Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07527CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9A4560821;
	Tue,  6 Oct 2026 15:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBuQR9LVVbTq; Tue,  6 Oct 2026 15:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E511B6080B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299502;
	b=d89XiS/y52Ut9LnS12nsX/P3cVXHymJ3E8IzCU1ZKcbEWhIFLOlKivjIW5/C9cWmvFaj
	 +dt8WbnoSmgNPTGYgahjCNoZU5kBi6tmgcXtaHluFkm8iO9N0eZW1AlKYD6x/sixJ0Ol5
	 fWAZVgulNcVL0851lgDFh+cHIwgLses0CUA1LjGwMPt8O+maOq2RgxKzOZdpoT+dkv26M
	 L5GsS8AoQy9UWiTbWq3AghPnXVkoc9A56D2OqCv9XgWh6LIKwSwcYvEI32gok+dES9jV8
	 wIZdpGpXPzR8S+LYOIfqgtvY2ypH2yhmA16V4Z7OnuImRzj2GwBKZ3v67ePp3igz+mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CzuDQ4IeuPGhgCqNsbJnTtrRNyDqC/65TPjgM3aVZR0=;
	b=QF2O1P924NtkiHiJtc63BQZ9k+rv1Kgip6ewopuqdG8+4oTHHyi6K5qRqsXMWSv6dWOO
	 5xEcOr1NWM3TaEUviQHRMHwY/qHCfx+5ebTzpZJ7RDNkIdnmaPbP3yOTv9a4p+RBZe/pj
	 +Mfpb2IEZT2xqdREMlh5hj7Lh07bOLtbUq0Zxi46FI+cr6kWxmn5yzHyT9T2GKFwkj4r3
	 edVnrIgE4hph0TsIT4lmZyIdSOWmqBuiX8iiMVlXYjsUcARcHNcRCPvgupS6ANXaOvc/8
	 c/33NGguygYiOBvYAnlqno3rv3bSvi1zD1rMCY2hUOyxgNbtprTo8p6iLu3BWsFC74g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299502;
	bh=CzuDQ4IeuPGhgCqNsbJnTtrRNyDqC/65TPjgM3aVZR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lh3wpNzDjB4zeJ9ZYo4wbhOsy9kNYhoa+gfOciwTEIdrRm62YzUdhWiBhc1BWqpby
	 wq9Pli8k+VDWFBbJTbAr65i7aoafYqWHGll+TltLddDn0m4X4a8uirbbQGS33blwFJ
	 xFOnhuHC498D6jjDiULwBtwrGXi6pmNV1lG1qBYRZnN8r83Hnt978wwgZ6ya7H7GyH
	 0znHvZiUfHdImi9qF2LLxoRb36nL/F2ttfzRsM1+2fJZEmHyL39c16/4J7Nvy5DJ0u
	 N1h1iEBN18W//fAIkMycHa7ucHP+y8W1iuZt3WFMUiHOo/8q34qbspMtpPYojXLOJf
	 TwR4afDPFRg7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E511B6080B;
	Tue,  6 Oct 2026 15:11:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1440317
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2A6C40602
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MSC2_bs5G6wY for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 623A3405AB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298921;
 b=khXpUpASVYR1wW7SoaPd17YGNCz1L7W1Y58/ldY0yR6WawGVA3HosR7c8owV+pR2ot9E
 MmzZJDdnq70NeUytPFqNuSXZI3KhKdTVUjBT+DL8aUObOGEnnDKIWd+ydb5ATV03fUu7I
 AVNandntBp49/eenQgeEcIXB0t57ftT0FdCl/KOlmYiB8EMER36LMloBfppt7H4CsGMPF
 aJfDjWr9j/WdGfYL1VzXHC5udL+Jh/S+IeYyg8SabolKFEUmqrxEjMyWPCoXGEVXAOK4U
 AMY23ouRY4e62SRmndaz2+wbaPRINu1bJkZOtUYgAO/pqmlfsI8OLQaxUwJ7aTjsJvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298921;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=CzuDQ4IeuPGhgCqNsbJnTtrRNyDqC/65TPjgM3aVZR0=;
 b=hY+6FGcrxMnliiIBxvpuNUZq7fYtFSCR0wobsjrn7egDdrtRcFjgHOl+btULoixnsVGT
 TMPtX+Vx2fxWYtEdARZLcL44VQPxZ34/sEMzT6EpOKhMCg5XcZTd/Rs6pM0TkOt6HIUVC
 7nENBtQseol9/V26H5wCsmy4V1xCnxUnNLeuKY9WvoQehj9tbAZb+3ArvYHCaFf38979s
 vZj+7Xo3irg46DmAzLb6sm47W0KuksBAk2042qXPoaUk3/4Vgw9HrfGk5m1dr5KdheKXU
 /VJySKaISr3JAIkdqqcaCtsg7ux5B1zF6lMJGs2uJFuKorabxSy8hoyqFq6tIcTffrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mXQMz7mP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mXQMz7mP
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 623A3405AB
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:01 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so8010665e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791298919; x=1791903719;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CzuDQ4IeuPGhgCqNsbJnTtrRNyDqC/65TPjgM3aVZR0=;
 b=mXQMz7mPCEpB+5NnoxJkEjLboDndfcsKxR8joloyLAkVxvESHP2DZWm1JwiOogdsn6
 5yqm5K1KAUubkxOZ0wImG9vcE3i5OQa7FxKhqAHdFq32dSgQJuYUCqlPYyR+hyhMBBFa
 1xsdtAQ/i5JvEpK7Gi6s9SwNzeV4qfxC6sdWa24PwvfcUBaprGzGAE1WSGwN8WyqdFx8
 UEmXXxcQmIc+CoE17DstPsUBwXT/irTpgh3el6lwNykEoF1fAboaQVYcEEwHmiyVc5Y0
 3EUTP+CKVuvSTCXf1cNRLhu7SJyMfqDY64BowZgQJn4xNltfHTHcVpA1KZmSy7HD9TDP
 758w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298919; x=1791903719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CzuDQ4IeuPGhgCqNsbJnTtrRNyDqC/65TPjgM3aVZR0=;
 b=HdNe7XyVwNMP7gDTbBPti9jZcBiG3c3idA7Btb2H3KzGFVVOSgn8qk2FuIANIEUGrV
 W+DkpWU10sijaiuv+jus2OoYI/lNhRS5FqAfZ24rlzPCMUU3cTEOJUY9XdbOHA3oZMgr
 iEDn/lR8LMmc4SMQj6UbVoFkRSp0GEyxh8GNszc3WZCQ1RG+sgwzFeTKfppVVfIAMWGm
 6YlEx5uOgJdlbBbJRiYytAxYC7f3K32cV154lTf1t2P5iUYFvNuT8W4PrHSQ6q+ZqUAo
 F1irk6kud9mLEfd2b5ovKk9Da62A8EUnDnrwHAhaqiIyKY4MDmhmxrH5FQy9u0nkagzI
 K4lQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUbQ0/u9zHwce9O82W9GAJaSZObMbIbiR0WZjxSB/3AjSH1xQuxHyqsZWvviDTvfQ5kSz4tUQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lt98dg3tf+PEnYQ3Rh681hyA3Awb+KjShI1J9FZ5ZM8fDnjEIs
 YXtVTatMSyQIK2/LUsXzDX7XgUZ61s6BwNLjlPiYpKgdOYmOdN7isuWMFWjp/G2IxsU=
X-Gm-Gg: AYBFou3pf91myrXBpfiJ+T82vOsPdeS09t+GLieD4hkzdD9/GWYDw2/w3jg+M/6jX5y
 1X8njNhvP64JiRf7bxdfzraAjRMs88+vAU9rPGdwUSkslO2yvK+zO2q9KBeOVBdh8PRm6lR3PgD
 Sh6+GUxOOrq1nL+oerNjvlIHDJ7ZXjDVEb2YhLCQL2ljC40hmVM2Rk+q130O9I58IIvUXv9YyFk
 uRUUYxcVJtjHDj7S6xT4MWTTSXI+iZesi6dvnEI+v2uP3feWcUKLv3yx4BqRbVPGpnZOh6wi3yl
 OulZQ6iaeP+euF1htXSD2dh/Y3LHmd456HGKfhUrmqiCl0PDyKF5SLDqKdt/CP9T4ic2NgbqMoO
 lZeiVaDDG4tT5qvfn0XpfKmFCudXY/JJxNlhmKGz5xu/hHJYdn84v5F/8mbzbM6IqZuR302q95i
 WCqWyKpR7QowOJ2zD3NcqLUw315V3r7amMp1GN+YYfJRf95UNHRgnOx8yUpQXCFD/qi1FidH+zg
 qbnkoA5S6+TDx2w+H0dZZRK5TEEabeDu87fmDgQYeksHa3Az7VWaCaYspWoRE8rvJQsYhyPB8zr
 WXAwc9ncTZJZ
X-Received: by 2002:a05:600c:a00d:b0:49e:6249:268b with SMTP id
 5b1f17b1804b1-4a17b5599ddmr28888495e9.32.1791298919114; 
 Tue, 06 Oct 2026 08:01:59 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm357622075e9.4.2026.10.06.08.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:01:58 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 06 Oct 2026 17:01:47 +0200
Subject: [PATCH v4 3/5] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ccaione-upstream-mt8390-da-v4-3-63d7d124780f@baylibre.com>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
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

Prefer fastboot in U-Boot proper when the complete download agent fits
the BootROM SRAM limit. Its shell and boot commands support provisioning
and recovery beyond the SPL agent's flashing operations, without relying
on the installed firmware.

This variant requires BL31 and an external DDR loader.

Use the same eMMC boot preparation as the SPL agent so provisioning a
blank device does not depend on the chosen agent. Keep 16 MiB of heap for
sparse writes; the download buffer is reserved separately in DRAM.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi         |  3 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi    |  2 +
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi | 62 ++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                   | 31 ++++++++++++
 arch/arm/mach-mediatek/Makefile                  |  4 +-
 arch/arm/mach-mediatek/download_agent.c          | 15 ++++++
 arch/arm/mach-mediatek/spl.c                     |  3 ++
 configs/mt8370-genio-da-uboot-fastboot.config    | 29 +++++++++++
 configs/mt8370_genio_510_evk_da_uboot_defconfig  |  2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig  |  2 +
 11 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 2ee7fb1f40c..f81ae1c82e2 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -16,5 +16,7 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 510 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 510 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index f37ec34b0f0..249441fdf0e 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -12,6 +12,9 @@
 
 #include "mtk-genio-binman-u-boot.dtsi"
 #include "mtk-genio-da-binman-u-boot.dtsi"
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+#include "mtk-genio-da-fit-binman-u-boot.dtsi"
+#endif
 
 &ssusb0 {
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 4fedbda9b3f..395241173a0 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -16,5 +16,7 @@
 #endif
 
 #ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#define MTK_DA_DESCRIPTION "MediaTek Genio 700 download agent"
+#define MTK_DA_FIT_DESCRIPTION "MediaTek Genio 700 DA bootloaders"
 #include "mt8370-genio-da-u-boot.dtsi"
 #endif
diff --git a/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
new file mode 100644
index 00000000000..a605ad2504a
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&da {
+	fit {
+		description = MTK_DA_FIT_DESCRIPTION;
+		offset = <CONFIG_MTK_GENIO_DA_FIT_OFFSET>;
+		size = <CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE>;
+		#address-cells = <1>;
+
+		images {
+			uboot {
+				description = "U-Boot fastboot download agent";
+				type = "firmware";
+				os = "u-boot";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_TEXT_BASE>;
+				entry = <CONFIG_TEXT_BASE>;
+
+				u-boot {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+
+			atf {
+				description = "ARM Trusted Firmware BL31";
+				type = "firmware";
+				os = "arm-trusted-firmware";
+				arch = "arm64";
+				compression = "gzip";
+				compress = "gzip";
+				load = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+				entry = <CONFIG_MTK_GENIO_BL31_LOAD_ADDR>;
+
+				atf-bl31 {
+				};
+
+				hash {
+					algo = "sha256";
+				};
+			};
+		};
+
+		configurations {
+			default = "conf";
+
+			conf {
+				description = MTK_DA_DESCRIPTION;
+				firmware = "atf";
+				loadables = "uboot";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 8b2534a19fc..4b2417801fd 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -275,8 +275,39 @@ config SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
 	  downloads it into RAM. The download agent also configures the eMMC
 	  boot partition so that a newly flashed board can boot normally.
 
+config MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+	bool "Run download-agent fastboot from U-Boot"
+	depends on SPL_RAM_DEVICE
+	depends on USB_FUNCTION_FASTBOOT
+	depends on FASTBOOT_FLASH_MMC
+	select BOARD_LATE_INIT
+	select MTK_BROM_DOWNLOAD_AGENT
+	help
+	  Build a small SPL which loads BL31 and U-Boot from a FIT already
+	  copied to DRAM by the external DDR loader. U-Boot proper then
+	  prepares the eMMC boot settings and provides USB fastboot.
+
 endchoice
 
+if MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+
+config MTK_GENIO_DA_FIT_OFFSET
+	hex "Download-agent FIT offset"
+	default 0x70000 if TARGET_MT8188
+	help
+	  Offset of the directly parseable FIT in the BootROM-loaded download
+	  agent. This must match the external loader's DA_FIT_OFFSET value.
+
+config MTK_GENIO_DA_FIT_MAX_SIZE
+	hex "Maximum download-agent FIT size"
+	default 0x8f000 if TARGET_MT8188
+	help
+	  Fixed region reserved for the download-agent FIT and the maximum FIT
+	  size accepted by this image layout. This must match the external
+	  loader's DA_FIT_SIZE value while the loader copies the complete region.
+
+endif
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index e052fbda73e..4139e9cf11f 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,9 +4,7 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
-ifdef CONFIG_XPL_BUILD
-obj-$(CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT)	+= download_agent.o
-endif
+obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
index da17fb4b309..193817cce98 100644
--- a/arch/arm/mach-mediatek/download_agent.c
+++ b/arch/arm/mach-mediatek/download_agent.c
@@ -6,6 +6,7 @@
 
 #include <dm/uclass.h>
 #include <fastboot.h>
+#include <init.h>
 #include <mmc.h>
 #include <spl.h>
 #include <stdio.h>
@@ -55,6 +56,7 @@ static int mtk_mmc_boot_prepare(void)
 	return 0;
 }
 
+#ifdef CONFIG_XPL_BUILD
 void spl_board_init(void)
 {
 	int ret;
@@ -68,3 +70,16 @@ void spl_board_init(void)
 	if (ret)
 		printf("Fastboot failed: %d\n", ret);
 }
+#else
+int board_late_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	/* Keep fastboot available even if storage preparation failed. */
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 125ebcd784f..95e2157b507 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -33,6 +33,9 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
+	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT))
+		return BOOT_DEVICE_RAM;
+
 	if (CONFIG_IS_ENABLED(SPI))
 		return BOOT_DEVICE_SPI;
 	if (CONFIG_IS_ENABLED(MMC))
diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
new file mode 100644
index 00000000000..d5766c34e25
--- /dev/null
+++ b/configs/mt8370-genio-da-uboot-fastboot.config
@@ -0,0 +1,29 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_CMD_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_GZIP=y
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+CONFIG_BOOTDELAY=0
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_ENV_IS_NOWHERE=y
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_BOOTSTD_FULL is not set
+# CONFIG_CMD_BOOTFLOW is not set
+# CONFIG_EFI_LOADER is not set
diff --git a/configs/mt8370_genio_510_evk_da_uboot_defconfig b/configs/mt8370_genio_510_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..c696e89c892
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_uboot_defconfig b/configs/mt8390_genio_700_evk_da_uboot_defconfig
new file mode 100644
index 00000000000..102f61a3afc
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_uboot_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-uboot-fastboot.config>

-- 
2.56.0

