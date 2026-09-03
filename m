Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01752C79F83
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D20F40AC2;
	Thu,  3 Sep 2026 13:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxyfdVBDdafF; Thu,  3 Sep 2026 13:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E89140AF9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788443059;
	b=rkLx5tSq9fgfUmNPLXYN+7boLrq54D2nOcXEAFa9eldfisOfkFXOR519/262jQDfqfTj
	 AuknlcjsBcFpOMmVUa5ind9qNEt9R8szleE3SqaJuGZwSo7U0/wnLHHA00ZlGhsnnEiow
	 NtKYI2tmzCRVMK0hpQAn36V7pP+frLXlfqzyZVeQgPVLFBrICOzu2fWhTRwPRWAB1b+mt
	 6ILJgyKloWqtv85u6DoEFYCV1iN9oHDO3MrqHBYva2j3LSZwfWDoESRVKBxa48bzXL/m5
	 n+ZKurne4LR+cXg2MuPup4RT6gioVr5TL5Y4EMxY9pSf0pVcKr4d6AUs/6lN8tWGAww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788443059;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qEbyEJaAP2H1uadXvYcMQib93nlY1pFYffBZ5KUYx08=;
	b=XBOBa1mA2zoL49bjPOrIoLFAxdggcHQrWnMY025XwHu2SDqyxLAtqWLn+D5Qlj1Zae0p
	 BX728/tybo6Oxm4Raobaw+7X3x0CwH6gcTuIUZtIXTFgMFvLVjvyQSQEVJVs5gGm+2y8i
	 OuyZUMBxrMD5GGq+9KZPk89sOElyIoIds811+9FsBNNBnPFyfX3wwWYSm7KXpKnvfTpya
	 v64/7OuD4JztCPCURmiVnsIf6XZWQUBuBh6KRn+lYAqMB3ejEw5KCBVMLnqgiYSiJTtRu
	 aj7hqhF/07UAccR1+5z0hBzTu7ZHACupSfAOAOI/GULeoYFxlP+/CzjP6wG2OugoSfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788443059;
	bh=qEbyEJaAP2H1uadXvYcMQib93nlY1pFYffBZ5KUYx08=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fN364WkaeAkNEuQjVVXrrnuKGTVR61FH44Ix2adRDCwnoLIYib3R+Uy+wajM01VCH
	 qTYPSQuZjc/zYBp3m8uIcv64nBJnWsQPKmeFKMTQI16bHqlkU2ILIgEBWj4FQ4jgJ/
	 iuXf21TAJ7WvpRiDy6y1dm7PpGqgDmKKXfSXKm3mvAMc7z1OyyIxfEQs53BzPLHpv6
	 ejWN4LPQAVUgDnKOTkfXaThPR3fyx6CgX/2hIUKwjzhWu5S15szSOi83moiYF2BGo5
	 0loFQiUF63nvigw4qUMco52EBbraNRjaO4OXtcsSzeWRBYczZHzPvr0VIcI6qQ4Iku
	 XbT32RIEHIbMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E89140AF9;
	Thu,  3 Sep 2026 13:44:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A4D3022F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 968D440469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQnQfWgOAsyM for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A374940462
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788443054;
 b=msT6qnicJavgAnb/wfQ1qCS8uyXwEiNnbe6oOoX5hncCrW49RImchPUKap2hvop6p9Xx
 hekoFijPA03V2tgBAIE6jDnK9RiQ6szXdojnmI/KVOiDXaegfrvl+KEKb2Rpm3QlIf/Ap
 kXCAnuiQ6vjoDsBBWbrfZNwFjUlPml7ljhjpznP5Dj6Z7S9UgZuyx+BwjXdAS7IJoe9br
 9qcmtlTgWPNLr+QUcWHRmc+usNJGFGxZVjQDNX5rgLkeO6GIVIlP3EHKVN6JnWIfuwsKe
 uLWLAXCoiUZOx0MJReqPs73m2nW34Wg2lRBDbnWYAF4cPmSUDHGfuQF9AFporXopclA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788443054;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=qEbyEJaAP2H1uadXvYcMQib93nlY1pFYffBZ5KUYx08=;
 b=Ot5CTpF/o9xQtuzRsRGShjKiA/GbN+5Fz1FiOci6V6Rrsz+nBCtuA2JLHQtStPd4kUKg
 1nlgLfXrUMXahP/MJ1izfxT1NdjcC31u5vpMnh69NkE0PxlrsqEVelEFbF3w5N+jAZq9X
 gLXFhv9IwpSRYKPRvMOgUiyQUaIpwrW+jZyv5KFUbW+dsNs9N8Clr7Gr1BasvWat/s0TN
 d/2O+Z+jQkaQs912ft76pqiPpLfX5JvAXyeB86uxQrmUa+Bx6hRp1t1bWPOzBYSzm7BVE
 JH5l9aBhwW9HIWKq63IAz7pIaMVBIbPoZ5SL+XFQxIeg1vCU0FvO/zt7l3YWp8dLTvw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZcDE2Drf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZcDE2Drf
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A374940462
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:12 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49cd9add88aso15349245e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443050; x=1789047850;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qEbyEJaAP2H1uadXvYcMQib93nlY1pFYffBZ5KUYx08=;
 b=ZcDE2Drf9AIfzYYt2zQ2K4AOWxR0fGaPiFh3/kRiQxp7OH13gnc2jK2IxrYv2zxe0d
 RJ429inuDyxGQ28ZjjmzYRkcxrufbZFd4zxIDyMqUct6yLTfRVxfdkOalHqHbKqcTvhp
 G2wtwJNmqThGROL8hQw4T/wApzHQRepYMv8dYWbHMKKyUTKwomRWwYQEqnSQpLGOTpwu
 CD3Y968lLcgPBW6FU5Y5X94TECWaswN7raaZvN42vyf1xpjhzExv1MG79rsbXQpcg33F
 tTZLIOROai+PY0S5XcTnBmJHyzoV3yqi59nvN3l3E0VqqfjqtexdQHNg6UF4S+AN9mAM
 mTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443050; x=1789047850;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qEbyEJaAP2H1uadXvYcMQib93nlY1pFYffBZ5KUYx08=;
 b=HfX4lnLOeJNoO+kp+CphD8x2sYdx0o3FJHlb38EQhmnpNkQoRwWSXfsF4w8BS3uyW0
 hcJyyZlfTaeq88BlUPwHZPp7AghYguDMF7+oi1Ff2XEC95n+8EgYrdAcXF8lK30e5d7V
 hjVrm0Ovqazq8f3Zm++NWSITKD8cPOEipZ/iZkjlH1jaW8B7dAfljpe92aztnfmComGd
 k1NaptnnU6yTVwVkQ0KKyaconojEu/P4yEuXb3TNz6FiRBOYNFnmW6NrWuCJt1Vpf4TW
 +WbyzJ2AP1tL/g2wnzi9YVpyhJxdaT7M3GH/tJ/zpZwkWCIPP9Yy+ddt/a+EPgBqxwRp
 K2Dg==
X-Gm-Message-State: AFuF++mqtA3DERch+3hrlEpL30pBlXeYyTCizG4trb/5BVQY91kow8Tj
 2IHsjYDwTa619kS9xyHsJvPr5rF2yqdXKYm3HdzbSBPBcsm9O/D2HRv47/4Gqfr9Zls=
X-Gm-Gg: AYBFou2aNsHMTEN/H23L7ViOIGmdvnYWd9DVWv8BBDMr1iCPetRfapXxmdNy75VrAQp
 pm0xvGaA5IguI6SBKiONRWiKLuOXnBDOMUg02QWxZN+NxjZsXGre0BvTL9ZM4KN6WHEsxd0Pll3
 n3cGORjpkCk2jRe8+AoEJ4DswAGfm2UgH3kfCfZiXWaToja2K7ZcLAiJMMgmAI8Alo6XrGy1psK
 pYcuxE5zldFLkLo5wf14UiB1yhOcINh1uuOQ9CG160gaIvgrz4ag0kMdzJqKumAQ3jqoU8GgOTo
 9uOB4bdVNjDeOWzM1mavZ2EpPvtSBOxyQ9Zlw9T6yi2Le+fqNDDmAlo6znA8DWdWLq4jJDR/Df2
 fR2PJ/HpIVJqxEtXuEnH+G0HnskK4NCPbqh0PaNF1V0vqatTb0Y4GGX/LNrgRiyRnIHT75Buq3g
 AWu9MoJ2Kev1uhUIBWR7RCluklJ1k/HpEOWFQrtwUNzGdnMrq60MClcSW6Rg==
X-Received: by 2002:a05:600c:c083:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-49cf5b5c039mr2538995e9.2.1788443049765; 
 Thu, 03 Sep 2026 06:44:09 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dec54sm86751155e9.12.2026.09.03.06.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:09 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH 0/4] arm: dts: am43xx: Switch to OF_UPSTREAM
Date: Thu, 03 Sep 2026 15:43:11 +0200
Message-Id: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG95mWoC/6WQQW7DIBBFr2Kx7ki2Azb2VaosYBhaWmNTwG6qK
 HcvbqK22yg7njR6/3/OLFF0lNhYnVmkzSW3zAWap4rhq5pfCJwpzNq67WrZ9rDtL2hqmOmUIS/
 BISjPBSx2DSlHUn7ngvDLvUbR6J6jQmLFHCJZd/pJfT5eOa36jTDvUbeLSB9rqZOvZ39txuquL
 ji9gyGr1ilDVMUGNC/pK0FzEIMhPRhZ63Fr2P/F92aE9AllEYQl5gQoUYq666zohgfN3iPg4oP
 KTk+lu+WtFloPygr7oDo5HyaC4EGvCTouuewHqYk/2jk7KP+L0Bsy1EqLqPqbUqtE+x7v8liZA
 0kx9MQ7zY6XyzfVH0kDiwIAAA==
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-7bc51b74cace
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4039; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+OyWx3EgiAMyu+MBOZYEKpsZL+Vr492PxM77hSbrbmY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyZlUW83ztPq00+ZLRXQvcN+63OZTnmwgocDYrlxitTb
 V5yX2vrKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIn8TGdkWDpp+5GEX6V8TLN3
 JdrtvFJbnP70+H2xGy84BI209EQ2XmFk2PPa6/HjBN1oFaPeWctmZr685/+p5aq85t+3Zacr94Q
 fYgQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

this series does the final changes to switch on OF_UPSTREAM on am43xx.
Mainly it adds some -u-boot.dtsi files to define tick-timer and other
necessary pieces. It changes the defconfigs and removes the old
devicetrees.

This series depends on these other series:

- clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates():
  https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com
- net: ti: cpsw: Skip disabled ports in switch binding:
  https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-v1-1-764e97251ef9@baylibre.com
- mmc: omap_hsmmc: Add "ti,am437-sdhci" compatible:
  https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-v1-1-24299cefb42a@baylibre.com
- simple-pm-bus: Fix clk -ENOSYS check:
  https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-v1-1-1b16c8f95051@baylibre.com
- bus: ti-sysc: Prepare for use with am43 and OF_UPSTREAM:
  https://patch.msgid.link/20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com

It was tested on am437x industrial EVM with mmc. Help testing is
appreciated.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI) (4):
      arm: dts: am43xx: Add missing board u-boot.dtsi files
      arm: dts: am4372-u-boot.dtsi: Add tick-timer
      configs: am43xx: Switch to upstream devicetree
      arm: dts: am43xx: Remove local devicetrees for migrated boards

 arch/arm/dts/Makefile                     |    5 -
 arch/arm/dts/am4372-generic.dts           |   23 -
 arch/arm/dts/am4372-u-boot.dtsi           |   36 +-
 arch/arm/dts/am4372.dtsi                  | 1006 -----------------------------
 arch/arm/dts/am437x-cm-t43-u-boot.dtsi    |   21 +
 arch/arm/dts/am437x-cm-t43.dts            |  420 ------------
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi    |    8 +-
 arch/arm/dts/am437x-gp-evm.dts            |  798 -----------------------
 arch/arm/dts/am437x-idk-evm.dts           |  420 ------------
 arch/arm/dts/am437x-sk-evm.dts            |  710 --------------------
 arch/arm/dts/am43x-epos-evm-u-boot.dtsi   |   21 +
 arch/arm/dts/am43x-epos-evm.dts           |  803 -----------------------
 arch/arm/dts/am43xx-clocks.dtsi           |  754 ---------------------
 configs/am43xx_evm_defconfig              |   22 +-
 configs/am43xx_evm_qspiboot_defconfig     |    8 +-
 configs/am43xx_evm_rtconly_defconfig      |   22 +-
 configs/am43xx_evm_usbhost_boot_defconfig |   22 +-
 configs/am43xx_hs_evm_defconfig           |   22 +-
 configs/am43xx_hs_evm_qspi_defconfig      |    8 +-
 configs/cm_t43_defconfig                  |   17 +-
 20 files changed, 173 insertions(+), 4973 deletions(-)
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-7bc51b74cace
prerequisite-change-id: 20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-1359deb9d80b:v1
prerequisite-patch-id: a50725fed0f48a3b9a5fb7a393849ef468064a1c
prerequisite-change-id: 20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-c8c85066f569:v1
prerequisite-patch-id: 6f2e5fbfe0a07dc47c4676915bdd782056927de6
prerequisite-change-id: 20260827-v2026-10-next-topic-am45-ofupstream-mmc-compatibles-f42b5bb9af5f:v1
prerequisite-patch-id: 7053ccee1ca3e18fd3a0cc3fd591df52fa4db1de
prerequisite-change-id: 20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-64848798be49:v1
prerequisite-patch-id: 4063f82addda24a2eb7616e50ebbe08c2f8b2f6d
prerequisite-change-id: 20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-7dede28fcca7:v1
prerequisite-patch-id: f58324411758f20bbb2f6d6f3066fcc9201faf3b
prerequisite-patch-id: 899231254292cb832e7c4c7eeb1c4c090d8d5311
prerequisite-patch-id: 7b69f6e00f87753125b4c0891a9180862fbaf19e

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

