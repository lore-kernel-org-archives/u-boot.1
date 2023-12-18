Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31579C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968AD87DE1;
	Mon, 18 Dec 2023 08:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T3ydjKXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA05087DE8; Mon, 18 Dec 2023 08:25:29 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A0087DE7
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28b406a0fbfso2032344a91.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884320; x=1703489120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KX0oMS9fKHDG92d984I+WGMrCqo5x7crkUbdPUftnA=;
 b=T3ydjKXlqbqWJvpjI8SPsvjZ/AxANWuHtSZIxpqrCaaDrouvfpOA0rezEUsSzKmYR7
 iuoVX3+sNR/O8ZEbZJwL7V90pZdtvGu1rHNXGIAsHRfrHi3is4KfjIWe97jHcyLu1R8Q
 7iLDAAhxPYuG3dPOu4Zi92ehwoKV9FwUBQ5p4e0+EnDEN7vtx+k9lFHpv0eyiurDmVDr
 OZAZIecyU7UWN8y6T/oCpWsiP9gLsrpOgrfz5ALabRZnbX8qeO+d1wudZXnXjRfqs3Vo
 MsT1Uih0WOH4We2W8p6ST3aK6dd9qBon164BJ8yzBVxM6JfD5nhXuvsz/n3wQ1oWPWu6
 LffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884320; x=1703489120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KX0oMS9fKHDG92d984I+WGMrCqo5x7crkUbdPUftnA=;
 b=kzi0AI64ngmp+CpmjtEFen8loxwHgZm4v/BtCntlpXQczIqRfybyLi7nw9Yjb+tZPg
 2T5M6q5OHD8rUIq/5NJAn3D54jf74FbPDscb9qwarKLdqC3LX/vaJ9USEhXlsgqFv+vx
 FEWibE05D6A6OSiJjqEEx04CY17JhtPwToDuL6dwiGmOoODvXepmwF0iN2q2B4P5jB42
 /RdknxwJ4+TuJUgFLu/tqTg6vQH6Z43SIr4i42Z8I6au07c0U72YKTW8Gu1FSogUJkUy
 njP/wc4DciFODDchtuK5FXE7OInAwbJSP8lJ2Vi/tmLiLpcedqrZSPVS1GyI3brkjV4h
 IAGA==
X-Gm-Message-State: AOJu0YxNc/vLTHzp8gxrurSrG/SkAqQObwGaOFI9FGYn2HfM4e3fMZQD
 mFVkf+YMSuksdFWbfGS19DxdCCgPSsudiqPHZamGeQ==
X-Google-Smtp-Source: AGHT+IGZZiD6abVezN/J/gEmGZDKn5WyPD83J/+38XaAsVbT+htw3npY84WpyQpyURxFkIo+sub0/A==
X-Received: by 2002:a17:90b:1bd0:b0:28b:52f3:3dc1 with SMTP id
 oa16-20020a17090b1bd000b0028b52f33dc1mr908864pjb.50.1702884320572; 
 Sun, 17 Dec 2023 23:25:20 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:25:20 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 7/7] hmibsc: Enable LAN75XX USB ethernet driver
Date: Mon, 18 Dec 2023 12:54:28 +0530
Message-Id: <20231218072428.1802969-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

HMIBSC board has hardwired support for 2 USB host LAN75XX ethernet
adaptors. So enable corresponding driver in u-boot.

Steps to test networking:

hmibsc => setenv bootfile fitImage
hmibsc => setenv serverip 192.168.1.24
hmibsc => usb start
starting USB...
Bus ehci@78d9000: USB EHCI 1.00
scanning bus ehci@78d9000 for devices... 5 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
hmibsc => dhcp
lan75xx_eth Waiting for PHY auto negotiation to complete......... TIMEOUT !
phy_startup failed
lan75xx_eth Waiting for PHY auto negotiation to complete....... done
BOOTP broadcast 1
BOOTP broadcast 2
*** Unhandled DHCP Option in OFFER/ACK: 125
*** Unhandled DHCP Option in OFFER/ACK: 125
DHCP client bound to address 192.168.1.22 (6220 ms)
Using lan75xx_eth device
TFTP from server 192.168.1.24; our IP address is 192.168.1.22
Filename 'fitImage'.
Load address: 0x90000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ################################
         5.2 MiB/s
done
Bytes transferred = 30992680 (1d8e928 hex)

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/hmibsc_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 656c9c6d0d6..dd3d18a5953 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -71,6 +71,8 @@ CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_PHYLIB=y
+CONFIG_USB_ETHER_LAN75XX=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
-- 
2.34.1

