Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE5E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72E880107;
	Wed,  1 Jan 2025 23:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ekrbv6cX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8472880107; Wed,  1 Jan 2025 23:11:08 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F17C804B6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21661be2c2dso133608725ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769461; x=1736374261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFaFwU6HL85zhoI2+Kgy0zYyT+EhQzEcwUgT2B3AfXQ=;
 b=ekrbv6cXd580pV3PXOtmpPCRNhUwyQDoLSF0GmaLjTpB8k1aCn3qqq8uksh0cYIm62
 MX7ISMOjWDREskR4mPhfgc99chnJzqqTTPoK8gRRAbD32BKovXqQXXIC6PsGnvg5NEzq
 NdGdgrJWOg59hBQqzQlQJ5RljkbRjnsiXANWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769461; x=1736374261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFaFwU6HL85zhoI2+Kgy0zYyT+EhQzEcwUgT2B3AfXQ=;
 b=kn5JoMBvdMLOmgy+WeTC/iv++iHV/MZXuPpYrJzvFlyd6oZVcmxsKnhejeduj2AcRv
 ueVKsSWjFicpEvFHAB+Y9RbWd3iu1oZOO5C68ytcM/pmJmKyEBnehcruECELuHdotTDI
 BtFCRYLfukByvxsolFqhxawmIn17FzML7mhszVQf8CAITQ3WPlBnNLNghhA2tDzQkXQt
 zGDmGLgyekIpu9Fh1BhkixGSx7mLN6Taz/F9Z9ZfnMTxA38ykoWt5ADRkOGElHQr7Rr2
 ZLe5SOaIUE4hDsan+ERGwnUTLINrE7iTJ7XLD1LrKxtsMv+W6ucdL+iqd+lymQO9si0y
 90uQ==
X-Gm-Message-State: AOJu0YyT+ZQ+570N+A9xeMWi/5+qasc25Kq6SJFGSNdg9pwNfK1g99f4
 REvoE2KdTc5N6uGmwWelgCFEkQzQ4VUbJJl3ThkrdaodcWzaCFWh4neOfqXDmV/Ha3Rs6BPDz4c
 =
X-Gm-Gg: ASbGncvDjm5VhU8twAAr6d3/F9URRkV+zvXHH5hedpjBZR/u/df7uUgcoZ4QN2yADrN
 4ot8R03bOlItcTNnGScwCVQ1Idc70QDYQm3heD0pKYrtdvFH37Y2QYvfQDPa/5Tqyg3B5N/ohfb
 K4g0GC+9yfgxVWpbvcWebHiM9mjYM6eg4kXHn6tv1Zrri+BCr/6uOwRp/eCCFJlEU46E2lZNzOZ
 U3NdFE/FqAkREk+kYC42pLVYyF7wyyEaStOreNK8Y1SoVX76IHfL0M=
X-Google-Smtp-Source: AGHT+IFGCazKzjomIxceLm/v8fdV43mlpms/UKGPnWin1NfHts/LD/3UBTzRUdU+yXFqfi+YLChVJw==
X-Received: by 2002:a05:6a21:1506:b0:1e4:745c:4967 with SMTP id
 adf61e73a8af0-1e5e0446783mr72383848637.3.1735769461443; 
 Wed, 01 Jan 2025 14:11:01 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/67] serial: Support info() method in ns16550 xPL with UPL
Date: Thu,  2 Jan 2025 11:08:52 +1300
Message-ID: <20250101221003.1944600-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

UPL needs to pass the serial details onto the next stage, so adjust the
condition to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/serial/ns16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 3f6860f3916..5126cf8bc1a 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -473,7 +473,7 @@ static int ns16550_serial_getinfo(struct udevice *dev,
 	struct ns16550_plat *plat = com_port->plat;
 
 	/* save code size */
-	if (!not_xpl())
+	if (!not_xpl() && !CONFIG_IS_ENABLED(UPL_OUT))
 		return -ENOSYS;
 
 	info->type = SERIAL_CHIP_16550_COMPATIBLE;
-- 
2.43.0

