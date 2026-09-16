Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D5C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 14:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57F92607F8;
	Wed, 16 Sep 2026 14:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GpEGovbHhSZL; Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 72EE3606A3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789570637;
	b=crYmCRdZ/BsVzcOetsPghChVXAxgSVrROT3kdBROCXq1SdugEyb+nMK9/K+p+jybUXAH
	 uzupELBXhjy4omWxjGhBvS+2IItFzCLV9v2TeLaY8qO1wjehrQpjCsQ1RSnPbj5RzeLsW
	 JsLKg2d/A1SqzodKiI6uovqtKwweLKJEi5W5UjJY0fMhbC9sTu/RUcqwHBttzig58CYI0
	 xLgC+mKmdpXTdcMZ/squOd/PXb0Q1LUC4ttAO8amWaucSXgzot6NePjvYYeqZJrON6QNs
	 rMucwOoM4LzH5QBnAmMkecHNxaz59Y08beHnUxcuhHI+hOxCJ5BIIan3Nzl1Wyg1NdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789570637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TzkLDXkn/wZcPYzqfg1KSwGo0Hzqf53dt1wyTP7cmOE=;
	b=bCB5U6/RLql1oYxzBr7byR/KkNJORej49G1dts2LnR6b+/RgD32w2RR8LkEgxn28dxWs
	 bpbXzbFKI/4JA7ndD8VWzxyCdreTmiPSkhphrddSc/K9ZHfH140UepYm1VmzivYzwgO07
	 EPEuAQ4ZRnwqAMdiTmq5ywo8PNtI/59COoejBZgU5xo/LLYlchkhBu1M0Ee2LsTuuzEjA
	 Dk3iic66N5Pg3usB4XD8JKll6UR2niceBwwIfILO7aXWiFT0po4rtnZOqOo9age905/CO
	 hQRHXo42CHVco2ENZm50IGxE3bhMatkpkFt/4zv76gRq4LLrtajJYznveryGAbPZlGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789570637;
	bh=TzkLDXkn/wZcPYzqfg1KSwGo0Hzqf53dt1wyTP7cmOE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z4c0GbK6fz58BVnRS9Uq1rlJPNLRXlHfuz6+0ReIe5CLM/Z+s9e+de93+6zklMNfN
	 2SXpXL7n5qZ7m71bwNTPeyQ7ral0CMJ6pPhxPfZf5MEyHZZsnU/K35EtqU42nn8APc
	 NZvVrKtaKKYoNVbPnNKz75J0uO9TjE2ZrWeBSiZXegIhpB06F3Qxtl6YEZQuW+k8nA
	 WvB9wnUw3Ncxxd/WAgQ49rz1FaMWRotV7xT7lY0yyGHXrvO9kXQeZaRqv3osFSDmXx
	 lmag137i4/QTmr/5bvkrzygb9XuqUPMHBS7C1zowGDOBIaPHo6tU3tUZBmstcYKyvq
	 0DarQHffU5GUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72EE3606A3;
	Wed, 16 Sep 2026 14:57:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDA122E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0C514030F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6W3STemqNKfY for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 14:57:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 040D14030C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789570635;
 b=FHn+AsRKgpOnOF9HccyzUlDjsGsQ7LS68e4IG05f9aaXOdiqAvC+gTPkvEEzP4kTiUHE
 HetOafxr5qRH+B2ss2yakV4tL3E7M7YoXXaaIQuM2jMCttay2GVJlKEeNaNp2yb/f4yVL
 ef+z9Zjq1WyXv1D8UPxdlZeHgZIAIo/3wNBII8cG2Fyxp8VzbYXTWu+Pxy4xQT9rsE9Qt
 fysQZ3ZRDypBNeWKrsDb/yNOm4ksqayNaZJJI747vE9s7h/nkXqRKwTzXYDlixkVhkEm1
 wo/oa1fU8OtMaNdPzXZcUamKteaLYYUeY04HC74KXcJv4PFLE23BKd9wYoeuav6XH3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789570635;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=TzkLDXkn/wZcPYzqfg1KSwGo0Hzqf53dt1wyTP7cmOE=;
 b=NkDX7ZEuMiutBZRT+00WfaQdUsQ81C1aHIxzVhT2rJfUEhdnGNCLWJcaCQ2imFHAZa4M
 +WkWoTPilj4TQacbREyCxyr/nqTv62vX0ayByR2Do7cfWDJ2MImm7IvlMtyH3+D4Zogqb
 kvIi5YfwsOjURXxGl8h88BRk7E5QWGNjnaPUlS6WyKyn7NdAVGLo1Fe8tEHLv1FG4TwSn
 8WW6Hn4Lud2w4b4csZlJzwCTkIQbGGvuAemSuJp2TiHYWMyrLD5FrjuzQE6gAjLvKCpF1
 2aFtyrQ2QJIUGqDydp20NNR1BPaFyIlkFqvVIky507yXQb1OPs0sJStzs41VYgIPmOw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cFswugcw; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cFswugcw
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 040D14030C
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:57:11 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so5107465e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789570630; x=1790175430;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TzkLDXkn/wZcPYzqfg1KSwGo0Hzqf53dt1wyTP7cmOE=;
 b=cFswugcwwkkLwZ+cewbXWdmQv4iJZa9Iez8SkqxuGrrTdfSymtWyaHrTXMmno1udbA
 ONCapI+qDkAS7YMxY4q4auowbDNP0KLaCJYUFVjdAp0G4WMH1h//rbmG4NNrAdOiKXjP
 KUPl6En9ppd85RDO3psICg29HXytjzjmrv+HCSMz0zIWss4vinM3i6Vdt67/13hHox7X
 mPgd0Btw50GhWYvGwfhDV7ihzpEgvLBF7ZYUI3ezExY12oei1Mih2iBk79X45TO8YjMN
 9qmIloiWL2ESI5xmdW6fFBDmfZcNA10cXWeP/WQAAwh+QkvezTnH6onFWckh+S1fHi+m
 PLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789570630; x=1790175430;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TzkLDXkn/wZcPYzqfg1KSwGo0Hzqf53dt1wyTP7cmOE=;
 b=iHac3D4AooNAI4GvZ+f5j5TGpMQzLa2aJE9rRDkUfi5Ujp6yYCLzgay0XGupYZzs83
 hmz6iyuND+5NJjKL8kP7/eJLvQYX5S2NvXmZDmH4xyAlfMPv6AghbAPreXeJrZFPtMEX
 UbJCnuyFpDc+kgw58bXdlNiSflEHjKZQ+sKQ7g3vmU0N38ye0adBIvxtmsyjwO9tyFc9
 iPf6e+rKbfd/gxzwi10mmDSM9na3Wy/M9kvr7SrPTJS274lapoMKnPfmwA2aMQPycGTA
 cvHJaidi68rFQ9U5gGpxSzUT7FFbjaNydhfufWj1okYqqMtAyfu6aIDY2rgJ6VmtTv5z
 z/8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfEcCjhCCQFe5sIKxzBS9bL7g+y9ayYrSsA2XdMT6KC6smRpa3RakjNMXeRRXSlX0V/pnheZk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nzyvF4lBgn47AR6TSMThuyyxB7cmE57aY7iVAEluL3mX/lhq52
 MZ8dUGVEX45ahaht+b1NSzw5mnoPzKlI22uK0nov2CqMyEI2ySAIAJGorslJ5BfT3x4=
X-Gm-Gg: AYBFou3kTlMT05zvUrDjq6a6OJ7z56MFclV4P2WGAkDhpF+AmVaV2uaGGOo3U0kHO2Y
 qcCE0jwRS1uHw7Ms32QJkL1RcSMTVjBBzlmsghPguTgSE1R75sZGSdSWqYvf9PJ4+2YfbHMOrEQ
 arZR418qnGOUMUF+nVeSKCiLYRde4RRSrfo82MfuPU4Jvgq9RVl2erRwpvIMa9wzbc4w340g7eF
 J/WD6ob10tm63bmhovJXHS5AlAGeYmrLNhSQaFvnad+hz6EeiszeUvqlXtqwfqjPDxZMDFUGDb6
 gvzApiZDTz/FU7sjrsVRM9ylESwUZrVv3QfTlwPxK+Ma+XcCYn6heRg99dyCDBQECp8Hzc7n1ik
 TBB2DP7s0Xf5s/TkHta7AazfE/oU7XWctotSjDRNsMpuBGi4AOEpKmUi0Eiamab0X27z4HCt3bW
 +STXM9zbpZRHEzWNgv+e5mBVtt/p2vJHrzmAd8pex/opQz0+eaIDt7iOFEjDOWAIPr5kZFqKWM1
 K97RlBYxOhJkhsPEuuFzUWixHLuM5PgRqcYLDDqT1B9Jk9a23TZVs2fpjff6ciEdMCPVfWW87lB
 J/c6/cc/VyEJohs3iq2LapQvcYy7r5HcGUEAwu3pt4r9sb5XpYjU/vw=
X-Received: by 2002:a05:600c:1da8:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49ec0549868mr68519435e9.16.1789570629855; 
 Wed, 16 Sep 2026 07:57:09 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd0a4e68sm122355e9.2.2026.09.16.07.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:57:09 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] Add MediaTek MT8365 power domain support
Date: Wed, 16 Sep 2026 16:58:07 +0200
Message-Id: <20260916-mt8365-add-power-domain-v1-0-b768d71b895c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOzW7DIBCEX8Xi3K0WjA34lPeoclhg3dIWOwUnb
 RXl3Ut+Lj2ONPPNdxaVS+Iqpu4sCp9STevSgnzqRHij5ZUhxZaFQjWiQwV5s/04AMUIh/WbC8Q
 1U1ogkHS6VRxZI9r6UHhOPzfyy/6e69G/c9iuuEej8NexXW73mvBUGcKac9qmjp2M6Iee1WgsI
 4+6d71Bpuj8rIKRGrU3criiMtdKN9epe5jqZvrxX7GpS+vgJAGBvIs2RJxR0s7T72fyhZ/bt9h
 fLn+yKsj3FgEAAA==
X-Change-ID: 20260902-mt8365-add-power-domain-ca1946099a87
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds the power domain (scpsys) driver for the MediaTek
MT8365 SoC.

The scpsys core so far only drove bus protection through the infracfg
register block. MT8365 also gates some domains through the SMI common
space and acknowledges its way-enable protections via the read-only
infracfg "nao" mirror, so the first patch extends the core to select a
per-step register block before the MT8365 driver is added on top.

The domain tables and bus protection sequences mirror the Linux
mt8365-pm-domains.h data.

This series depends on [1] for various kconfig cleanup

[1]: https://lore.kernel.org/all/20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com/#r

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (3):
      power: domain: mediatek: support SMI and infra-nao bus protection
      power: domain: mtk: add MT8365 power domain
      configs: mt8365: enable the power domain driver

 configs/mt8365_evk_defconfig               |   1 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8188-power-domain.c | 164 ++++++++++----------
 drivers/power/domain/mt8189-power-domain.c |  74 ++++-----
 drivers/power/domain/mt8365-power-domain.c | 233 +++++++++++++++++++++++++++++
 drivers/power/domain/mt8366-power-domain.c |  40 ++---
 drivers/power/domain/mtk-power-domain.c    | 116 ++++++++++----
 drivers/power/domain/mtk-power-domain.h    |  62 ++++++--
 8 files changed, 510 insertions(+), 181 deletions(-)
---
base-commit: e91d0b53e2678e0e6439370ead9bf2c71404b715
change-id: 20260902-mt8365-add-power-domain-ca1946099a87
prerequisite-message-id: 20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com
prerequisite-patch-id: 349b47fdcaa519c4bb9430a7d0a9cf34db04b64f
prerequisite-patch-id: 82685c1627b230ebcd75603c5b199ca61b53e53d
prerequisite-patch-id: 102fc1198a2b104b6fe2052d7258a97ab1f6033c
prerequisite-patch-id: 410192d9062fd4a4fe9152a0656cd00fa960d377
prerequisite-patch-id: 65651c5a260e0b28b3561d504b494f6625932a2f
prerequisite-patch-id: f710336972a49695622783e0724531fb2a2eb07f

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

