Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E0F4612A
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC00F8408D;
	Mon, 23 Mar 2026 15:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eAW3pJzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C7984180; Mon, 23 Mar 2026 15:32:58 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FAF683DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-467fd082ffeso1560389b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774276375; x=1774881175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xD1XrXBI7ee+ZneLiE5cjRHVE6lmS6s1T1nfjo1rJlc=;
 b=eAW3pJzFpCg2QgEHgRJSwwUC3BSahly9j6Gu1sDm/qXTA9UGpXrUN/gu8x5UblTCd7
 VwzUa7vHdkTn9XuiDEWtMeo7uj1nuboIH7wVO3cGGMQP7OAp5GluoHISo5vuenc4BB11
 Hls85Om23qXxW5quMpVarNsGilYCDYER5iDe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774276375; x=1774881175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xD1XrXBI7ee+ZneLiE5cjRHVE6lmS6s1T1nfjo1rJlc=;
 b=CBfMkQMPGVxN6Ail/t2hEXpkerBIQeb0GP+reYKCEg0/NC+pK6Xd4VX9EKB0nsksb/
 OsXzUViML2afLrfx15wwsuUjgpe91cMNgY9gbh2qb5VXIxihTLsb83EsD4uC1tybkRpO
 1+ogHn1qX4ywpNUSWCTP4F6r+rPdYQvNb3feuN8GDV9UpGq2Hv1MjPJO3RgMMi4+37A+
 VPlBoeWcAtUpWTXTM8Gzwu18Mnw1D4v0I9kl/ZpE3twr5AlSVZj+iKF1BFw3KJAJZI2d
 v0cpr5H3S0M2JuVs2Wq4jeUbjiIjAb7DJsUTusswEZUh7knPzv3lfMTtqorJ1wuy4Ubf
 cFCw==
X-Gm-Message-State: AOJu0Yz3Fiyq/2C8T/MDJc7z6Jsu47K0Z+MLPIpvIlmqaRoooLB3AwZ1
 Z4toEWsFGB5ytz/yJCRnLuOFnyOpJKdI0cHnIY1wXpVpp7tC7Vey4K0iGq3z7BJKXglAtzbs+cp
 quiJy+2E=
X-Gm-Gg: ATEYQzwmuGmYYII5TZQItmnjWP54CjXXSvKbyoOUpbgB38AVKL1AWf6kqEsvz9O/GdO
 /EJdIBJV5elGWT68JcLY8ydJJaXblyiI8LOcxZ2/BFslocldmtAxG10kcoMgxKxN0lw+fqDjPbW
 bmZ+UnIQ1j0i8bKF/OIen9edCKgu24fyYcYAW1DP51wDIV32qmFgi/Y4BWNASqdDRpYeF3x0sT+
 poZdeM7MGloVbQSV2l5zAH1etaQmS3M8pIBt09fjOFCHVDF8ffgJcrY3MzXVVjywBo5536eglpJ
 SIrZpQd/HJRhP53B7rHeRkZhxLEeldvoPyt0NK8Cl3OEbM+BMYXbXTI+dVCNu63ipWvWQVGX63c
 CiL9VK/dk4FpqgdvyNmomVEa8jiIm39zL0kxHSyDJbCWQ9vxHyAVH7mh6aRfnbmgZN8xIUzzbug
 9RBbx2xqPzYAAOChXPrf3gU3+IqG55tFKdSksohGorsjA24uua3OsOwrvKaSPZQOybUpD/a3J/q
 oyEM8dDopRp0+UETlu8NtDO8JWkesi+dzDUqNOxZoQcchKVx7M=
X-Received: by 2002:a05:6808:524a:b0:467:53b0:b43f with SMTP id
 5614622812f47-467e5fe304emr7370179b6e.56.1774276375027; 
 Mon, 23 Mar 2026 07:32:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7ecb194sm6950491b6e.12.2026.03.23.07.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 07:32:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: [PATCH v2] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly more
 visible
Date: Mon, 23 Mar 2026 08:32:53 -0600
Message-ID: <20260323143253.2272167-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317012433.4162524-1-trini@konsulko.com>
References: <20260317012433.4162524-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue around
USB_GADGET_DUALSPEED. It is possible to select this symbol (via
SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency due to
how this symbol is placed today. Move this to it's own section of the
file guarded by USB_GADGET || SPL_USB_GADGET.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Implement this move as suggested by Marek instead

Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index baa2eb61ea33..2f79840df18c 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -179,10 +179,6 @@ config SDP_LOADADDR
 	hex "Default load address at SDP_WRITE and SDP_JUMP"
 	default 0x0
 
-# Selected by UDC drivers that support high-speed operation.
-config USB_GADGET_DUALSPEED
-	bool
-
 config USB_GADGET_DOWNLOAD
 	bool "Enable USB download gadget"
 	help
@@ -372,3 +368,11 @@ config SPL_SDP_USB_DEV
 	  so it can be used in compiled environment.
 
 endif # SPL_USB_GADGET
+
+if USB_GADGET || SPL_USB_GADGET
+
+# Selected by UDC drivers that support high-speed operation.
+config USB_GADGET_DUALSPEED
+	bool
+
+endif
-- 
2.43.0

