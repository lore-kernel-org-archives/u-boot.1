Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6322C79F9F
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C226405B5;
	Sun,  6 Sep 2026 15:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5QCLDSJVs-R; Sun,  6 Sep 2026 15:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7C74A405B6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708629;
	b=DTkRZ2fmJP3sTCWLjBjHlnlzVp/61ctx1ge77gIGQk1ZutlUATyXRMcUHla7bIyEdhaA
	 Yxu9oRya5IFdJDrt+VggljCySHT5Z5NVZlKElkzlkaV03xV9fkCqOmP2VpH/qHtWZgPz0
	 z1eCRqTzIuXJVjm3Ymz6DQaou4eaLugBZ+NpvNu3BCKsP0NfV1oRf4ViFPK5eGgRnLCr6
	 n4optj5p9sx49yUT/5CcHXMbXGK3y1K+69/wA1GcpdC33IyiuqoUdLzM+bC7aEJoYMLYz
	 ++knPAkJRAAHOkTuhovIpEjcN8saFQjD5t5OWVGUSS045fWGWi/w9Hsaf9EC2gla+vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4uqRwtnyuYtpK2Q47yocok613K3NoCO/7rQdaFnH2Eo=;
	b=IIVMDmWpyS+7XkZ/46w9Or9nzuPq/3YFMYOGbIWPo4QWh9rq7vBehLhxbkjiT59rHlHn
	 vE0cTcP3k3/zWVnJhN5Bb8En9lMI8GKcZIzU6rafOyY1Llp/YogWdIiki83abqY/xCwLU
	 H/6/kFXBvADa5zAf72Sfy5jfc0sPh8tdyaUsq8Y1MxL16WJjp10BzbaCh8z/E1tO2iqr1
	 vvn/bzyE9dDYBB6TBQeG2DTQqks6gM28HlU5COhm/Mmn0zXdjAfnUiKOUlb3oKDDgkHqr
	 0PW7G3DrPRVeIeviJ0/SF5HoZ3V4nqfwgrgZSKcR72yE9KMe31MluOXU8R9rx/jKBzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708629;
	bh=4uqRwtnyuYtpK2Q47yocok613K3NoCO/7rQdaFnH2Eo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kXR5mYf2SxvaToR/9OjGhkZeFRByMIFVJIQ7wO5rOAzCeMu+GYP3tR89kKlQx6jG/
	 T0jsQ4M6qqRaJHktJ//NMPGNnUbIjf2TOGBZ7f0kHAkZCMSTLim3jor3vTf9I+73PP
	 OsAOjm4yBXBFL13yS2byRWgXnU7jd7rcWFKG4X8F722u279XQDhw0cRnVakL1TG4mm
	 kVwcPj2cKKBWzpkOJr17PjcdRsT76Tkkl6ksY4zugUMc5muNrVvlg3gwSJAUEYsCLr
	 8NY8auf4EH3D38vBXjFjYBUsvcNofy2mGXtSKzLvi1qcmVmynM8AlW0onYoZuJ3o3u
	 l3VZayuGwRv6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C74A405B6;
	Sun,  6 Sep 2026 15:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01AB6970
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC2DD60604
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCI0RguC1tiY for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E974605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708626;
 b=X4PfFogvOtjUK/G0VEik+6pcAKZA7oGxaPrS9KMarzsTLsZ9kgw9v1Ew7cjtI7SrIA7k
 wCAGlCIA4pqFcFl4fSCAFd8UcDnDOdpXJUmzsLmvbpGhCQac9aEo+UY4BVUnT4VH380eN
 /mjvF7OuCuI3a439nDpvw050SCj79QC//5QukMJxsNClgWG7sLF6HRQZhUIP8+D73nNLw
 qNVcbpnIXT0wccuZqjaxpDnne9IzCa50IbNJ3UQrDVn/pA0c+kTcwAHyy7GiIPEwk6fvi
 2UcTahwALhU4+nMB0q1dyLGuV++AIdaFHNUIGIpkNZkXeDT7X6p2qT6j15o705yWbQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708626;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=4uqRwtnyuYtpK2Q47yocok613K3NoCO/7rQdaFnH2Eo=;
 b=Kjvi1pIWmlzRA8ZJrmUlRH3RKuNc7yI3H4U2aNU579r5/RdsQ8ykt+spLJUb/jeQKrfQ
 i9aZJor/ie0678W70aiQaqT1iD/aybIqz/9lx5UBeyXCbtDqNPtTcUgfYA+rkDKswQ0KL
 cIUFHM1oi7p8p5UHSm0txnNbcZKr6+mqbz3Emz7co9oMV97hZaljXOaplobq6I4st3Byt
 QOFox3qLMuL657wiCpSwJaAIev93jHuYdX37NCCc373erKQL2QlVLFkahdIF1BTvCWydq
 zP91uhGPm545eGWiIPZye9rVnHRQfkTjLed8c8SN6Zk0h7EcMSuRDvwc08AyTh3jjMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="O9I/veUw"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=O9I/veUw
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E974605DF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:24 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so31230425e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708623; x=1789313423;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4uqRwtnyuYtpK2Q47yocok613K3NoCO/7rQdaFnH2Eo=;
 b=O9I/veUwZ/5hSMN9QGONCV9ZDM9ct8C8Xu5fG6UMH+nrmsgP8F6tOI/jhlk7r7g97a
 +hQ3pczfzZyXVk1NiS3zDu9K3F+Tgj3HokklUCOByD/hIfZdvR0R2GFvApnN7Qvbg8wp
 /D5d/GsB/RcjfJwkWxth1x3+riSScB6V54DlGtqMtitCfknMORXill6/e9BjthvhC0qu
 mOJmbVvadQbTMBtKX7dmi2gW5ZAvmHZj9KqGmtwIVbNDaLdBeRJ1xEbqeYv8QonuWK61
 UxKyglkYHwsVSZEWM73LNnB0T0kob6sKS/JUGFHDMGRf0gbFfX85IO1q+lDgWRhTXUFc
 8D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708623; x=1789313423;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4uqRwtnyuYtpK2Q47yocok613K3NoCO/7rQdaFnH2Eo=;
 b=YdIcb/2JtJZZEhBCPSbGgpZB6vpfi2BVIlHgryDMiY/IFf/xAaeu5vKAbD6wNU5t1z
 SS2IROgLOacUNuekxRGFRxgDGhbpAmHDVU8IbnaLKm9/zIAiZTvjK1OGepbOTqhlmrGR
 sAqZuFzcGLXeTZAqoPrVPT2i9NMG43VAHTCWzI8dZrvLB4uM1z4dPnpVTTApDM2RJIVC
 2CTcHsZlY74kUeVTFhDfRnm09tbtP9oUiYTyimwGZgyA44Uqga0m8IXpBJmxIqJhMOBd
 nc55W9hzBT96PqjPDv0WxDM3IBXksRXcFCT0BMCVYUdi6pzERvtqjpKGKT2Zcpvm8oLw
 YGlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwecvRb6J+UnLum9OjddTqIL00H33cVm8O88y/pOIe43dSw+8nqQ1IkTxUZW2st6aBRYnO1Kn4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mhD76EGXeIrdZHJHvGhujqhm4N6T4reA695ma7a+dKI+9nFhP9
 3FyGZGvl7L4T4xJPBimk5ESxV9K+73wb65qydYiyqBqsFHqOANhEntrbkLWfskgZ6ZQ=
X-Gm-Gg: AYBFou0hEpGUJ3Nao3LvL7cbGa0Lhra+Cyz9oARlw4Ed0RoaHtJHD4cgjeyWN2ybz6m
 GTi8eO2MyHBgNILXFZyJ4gafTgxpz26OaN7JOSjib4Zrd/tC62dk80lQOfmqTEVYDeFzC5rSPaH
 SA7GRQoWz5YaenoVEMjIqHgO9Qwu+wxRbBD0evHG80F4SZXU5o8uvtJdL6aqkZ6Exh6jQhQMcil
 5K+DAbYelMJiKCEYF/5HjAig4yBNOYGFznbI7ek9PJeQ/5oR+W47p8R5SxlZaTGE7QFmBYhhoB/
 gG44f6Zp8vSVsYbBaGWeTUZsn4ZfHkljLy7LnekzM8Xi3w7WRlBU3jL53rRYBpyR78XBsKtp04P
 z7M3IxnSZfxZSqItr/O1o/Nw6Ml+NDOBjm9ojON6JvG0lguN2KN1CLoZgdTgKwYt5Fk26Fk9+8V
 /IejYoPDpGQ8b0wuO//MrHl7H/bxjkb4rBCYXZDaCcWhmB4cRrr8tINjPh7lgkfF2nvk9vhS1bG
 6uMYVY8TC0B9kVGBMqQb9LDanVbJyUMi0GyIEJETn412zw/fgfw
X-Received: by 2002:a05:600d:650c:20b0:499:8ff5:8ecc with SMTP id
 5b1f17b1804b1-49cf828609dmr138543265e9.15.1788708622662; 
 Sun, 06 Sep 2026 08:30:22 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:22 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v6 0/6] Add Genio 510 and Genio 700 SPL boot support
Date: Sun, 06 Sep 2026 17:30:17 +0200
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33RTWrDMBAF4KsErasijSRL7qr3KF2M/hqVODaSY
 xKC7x45pdQU4+WDx/cG5k5KyCkU8na4kxymVFJ/rqF5ORB3xPNXoMnXTIBBwzTX1DmslUAvQxl
 zwI52oxEto2U4UR0b6ZCDj9aTKgw5xHR96h+fP7lc7Hdw40IujWMqY59vz/mJL73fJbO7NHHKK
 AfV2MZHjyK+W7ydks3h1fUdWcYmWHEA+xxUTiMypoRUmvMNTqw4wfY5UTkD0QrrEDTKDU7+cYb
 LfU5WLsrYQqsN6jZscGrFwf6XJrVcxz2TQaDVRv3j5nl+AEV/puMXAgAA
X-Change-ID: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
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

The Genio 510 and Genio 700 boot chains use a platform DDR loader built
separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
the shared SPL devicetree and configuration needed to initialize the debug
UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
bootloaders GPT partition.

Add an opt-in binman description that generates the images consumed by
the MediaTek flashing flow:

  mtk-boot.bin
    MediaTek BootROM wrapper containing the platform DDR loader and SPL

  mtk-boot-payload.bin
    Raw DDR-loader and SPL payload for external MediaTek signing tools

  bootloaders.img
    FIT containing BL31, OP-TEE, U-Boot proper, and its control DT

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v6:
- Bound BSS below the initial stack and use a measured normal-SPL heap.
- Generate the complete OP-TEE loadables list with binman.
- Explain image-layout choices, AArch64 entry and firmware prerequisites.
- Update SPDX identifiers and simplify the signed-build instructions.
- Link to v5: https://patch.msgid.link/20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com

Changes in v5:
- Explain the SPL BSS placement and guard area.
- Use the OP-TEE v1 header for its load and entry addresses.
- Use MTK_BROM_HEADER_INFO for the BootROM image properties.
- Rename the binman includes with the U-Boot devicetree suffix.
- Scope the SPL binman-symbol default to Genio image packaging.
- Link to v4: https://patch.msgid.link/20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com

Changes in v4:
- Express the DDR-loader/SPL handoff and firmware load addresses through a
  reusable Kconfig image contract.
- Split the binman layout into shared includes and rename the packaging option
  to CONFIG_MTK_GENIO_BOOT_IMAGES.
- Require bootloaders.img to be a directly parseable FIT.
- Link to v3: https://patch.msgid.link/20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com

Changes in v3:
- Add Genio 510 support using the shared MT8188-family SPL configuration,
  pre-RAM devicetree annotations and binman layout.
- Make complete image packaging opt-in through CONFIG_MTK_BOOT_IMAGES.
- Keep the binman image description in a separate optional include.
- Leave SPL binman symbols disabled by default on MT8188.
- Add optional RSA-3072 signing for the bootloader FIT.
- Emit the raw BootROM payload required by external MediaTek signing tools.
- Document component-only, unsigned, and signed build procedures.
- Link to v2: https://patch.msgid.link/20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com

Changes in v2:
- Clarify that the platform DDR loader is built separately from U-Boot.
- Fix the SPL copy-window wording in patch 2.
- Keep the SPL annotations board-scoped and drop the unused pericfg_ao tag.
- Normalize the firmware-stage names in the board documentation.
- Simplify the documented build commands.
- Remove the redundant MediaTek documentation maintainer pattern.
- Add links to Genio Tools and prebuilt images.
- Link to v1: https://patch.msgid.link/20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com

---
Carlo Caione (6):
      arm: dts: mediatek: prepare Genio 510 and 700 devices for SPL
      configs: mt8188: enable eMMC FIT boot from SPL
      arm: mediatek: build Genio 510 and 700 boot images with binman
      arm: dts: mediatek: support signed Genio 510 and 700 bootloader FIT
      arm: dts: mediatek: emit the Genio 510 and 700 BootROM payload
      doc: board: mediatek: document Genio 510 and 700 SPL boot

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  15 +-
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  15 +-
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi       |  96 ++++++++
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          |  12 +
 .../dts/mtk-genio-bootloaders-binman-u-boot.dtsi   | 109 ++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  33 +++
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi |  27 ++
 arch/arm/mach-mediatek/Kconfig                     |  41 ++-
 board/mediatek/MAINTAINERS                         |   4 +
 common/spl/Kconfig                                 |   1 +
 configs/mt8188.config                              |  33 +++
 doc/board/mediatek/index.rst                       |   1 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 274 +++++++++++++++++++++
 13 files changed, 654 insertions(+), 7 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

