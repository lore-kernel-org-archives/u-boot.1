Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E4BC531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 17:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3CBC60AE2;
	Thu, 23 Jul 2026 17:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nVJn92xZ-Xko; Thu, 23 Jul 2026 17:37:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34F6660AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784828253;
	bh=mhLM+86B1uQraQiRi63VApf26GMXo45//W6NvM0PC0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0/uBkUclyD0ZY5RKOVbOKs0h4/SnrRcooUV8m++6fIt/9a45Ny+xt7cLGVEN607i
	 jEX7+B02+4Z53Oxu9kDZtRCssBerxmzxViVu3tuPFMmbge1UY79nBUhcQuZCd6BuLp
	 IlfL1/qoPnMb2MTY6uMmZNSN27BiszM8CA4Hkgu2kmNqUoY4ugL8uNvjr3ZcG0pafD
	 1XmpTqSS/z+dsdMvzOIMegof7QPBDGnh1p/0R4EG+mpfpm0mbbGJw92Td0SoM3RjHo
	 6QeV53evEnejyjYfGJ6rM9rgwpCygfOJ8lnDj9WqgEtYU7cnfsJZqLPmBdAR07Z2La
	 ZuaNlJri1i3wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34F6660AE3;
	Thu, 23 Jul 2026 17:37:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73370788
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D991760AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHds-4yYZyJE for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 17:37:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=andreas.zdziarstek@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A78C960AA4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A78C960AA4
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A78C960AA4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 17:37:20 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so6482485e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828237; x=1785433037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhLM+86B1uQraQiRi63VApf26GMXo45//W6NvM0PC0s=;
 b=aNvtcKGJ0I7+W6X1gFqo9dUM9rKK90de3lmBCA+bJY1ldCizcJUjNh83DnZIug+mB4
 6xAX9OyYEMYycCYJFMPtfvJSt78XWF5Df+BxUTwUCmsRo6Nt9HaDJcVl/d1OJcZP0IkV
 gqAv0QZdp+jqcHsJTgGaJGPkzPyf144mDDqU9TftHcCg+69HptofG8PZQCKDr9aZP8QG
 y48NGXkrFSXLedTBfHLQARJBH64DEUO+79/E4yowLoCIaNMsjYKqRU1Sh62kqi53H+0i
 aGJr7SUSXgrYtLAk+7aiXjzFsZhlgKmnE9sR6+Ixs6enM3BvnqUb5cqtVndlWe3XiQ3t
 j4RQ==
X-Gm-Message-State: AOJu0YwnZfO82/MHb1yjwDGhKZ1jeNazoC/+QlTNPi3hg/MDSiA68v/0
 3Sf76NleU3T0YKxmS5Xy5AC82dlQfA/eKhCp98hOBAR+BOWEKds6LNUERPZueQ3K
X-Gm-Gg: AR+sD111Sc+RIUPKW58P+MmjQjrsN+GO2uqnuzY/rkZLIpVLI5ABXogyGsd/oYBdoKZ
 +/5lw2j9UogwH/at2E1uxGrxy+qTV85Pl3LHMof/pMWfCr/iiOnp9hN4E0C/eO5HwE7HkilaekF
 8IcYuoisKvA5BcPKML0teSAMdC21RHLkYmV57lmxgqk9oxBLWkAfcIfCuxug3YVlnf/v6NrfEtu
 6DzAtHQNFTAyRfCs+WcmM8++C+TGS3zOED5ZZsJO7ica5D1UU8CgQs1XGwIo/SgCk6uFjpm22vv
 vvX+1N0Pb4d1A7tjEAH4rzY1QH8tHtxibw2X5ezngwBW82scktfuhOwuxpb53XAuqWgKpRjARfk
 KaW8xgs1PnV1HRiYBznR6xfa7iJ8a/sHKeL/QbLPQiX7Ev6B3GaTkD9+z6rz2Jvd8bBMWGzY3dL
 xhLwvdpuO1tSxkrQE5QJ+7IQLSIFZdS0MsmWRYUQ6smPlKcokeLOWK
X-Received: by 2002:a05:600c:c05a:b0:495:5eca:f9b3 with SMTP id
 5b1f17b1804b1-49573d0ccf7mr48871885e9.26.1784828237419; 
 Thu, 23 Jul 2026 10:37:17 -0700 (PDT)
Received: from turbine.fritz.box (p5787a491.dip0.t-ipconnect.de.
 [87.135.164.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af914a9sm8497645e9.15.2026.07.23.10.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:37:16 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v5 4/4] rockchip: odroid-m1/m1s: enable watchdog support
Date: Thu, 23 Jul 2026 19:36:44 +0200
Message-ID: <20260723173644.234688-5-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
References: <20260723173644.234688-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784828237; x=1785433037;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhLM+86B1uQraQiRi63VApf26GMXo45//W6NvM0PC0s=;
 b=rdv9lCskAa2LP8OdrZKoD3kaKjbzJvLCgSYXu2mOCNu9wjbd1ZMHh/Vc3s+5gKZCoQ
 kzWD8BpIwMJPIfTMB08+GHRbq8vxksbRZMbz6AYz0TnCDVYFeH477GtXlAkgTK0ZPebP
 hwW63H7tla06k7cIEUnvh+fXK9VtPIh44MhDwOaTsraF92DiC6b71GagY71rnEY3LRTM
 2l6+C8rs1+SUzr1jk0X21rTxen7PHkuzOIoj6dsinSIYrEBXdNqK7uvOIIvioVNlE/G/
 f8ZHtAjYF7gvGdBQ9qSUUJjxUUKaZpxn9raSf/O2jMekjEA80Mg5LUxKWdwsCo55dUZQ
 A/Rw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rdv9lCsk
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The rk3566 ODROID-M1S and rk3568 ODROID-M1 have a DesignWare watchdog.
Enable CONFIG_WDT and CONFIG_CMD_WDT so it can be driven via the wdt
command. The driver itself is pulled in by the SoC's imply
DESIGNWARE_WATCHDOG.

CONFIG_WATCHDOG and CONFIG_WATCHDOG_AUTOSTART are left explicitly unset
to not cause any breaking changes on existing systems.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 configs/odroid-m1-rk3568_defconfig  | 4 ++++
 configs/odroid-m1s-rk3566_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index b00985b0405..bcc0556de2e 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -37,6 +37,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_INI=y
 CONFIG_CMD_PMIC=y
@@ -92,5 +93,8 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index d59882a2a59..cda2f9fb539 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -30,6 +30,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_INI=y
 CONFIG_CMD_PMIC=y
@@ -87,5 +88,8 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ERRNO_STR=y
-- 
2.53.0

