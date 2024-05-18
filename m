Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30AEC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE44E886AE;
	Sat, 18 May 2024 17:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="T+Rlm5Rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756D988670; Sat, 18 May 2024 14:03:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A33F8863A
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 14:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716033788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/MUCy1vxNuW8qUE165Ev9S9Mc0BuiVpY+x6SOrprwk=;
 b=T+Rlm5RlzJnCCm9zoa4pfTRvSIVCLdzSWCjoheP0YpD8uftMpW3KIxJdjf5pscVojUTTuu
 oGcAuX6s3T4ccmzY7CV5K8YJ21uvdA2pZqqzrwMBij3a0i8ZUKpJo9NXuW3O3xBl80WloF
 i5M8MxD5aM/mv3cUvlSbVMf36llVkxI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-hKAhnB9uOgiW2at7wuSelg-1; Sat, 18 May 2024 08:03:07 -0400
X-MC-Unique: hKAhnB9uOgiW2at7wuSelg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41fc73366c9so54415215e9.1
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716033786; x=1716638586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/MUCy1vxNuW8qUE165Ev9S9Mc0BuiVpY+x6SOrprwk=;
 b=sszqt08Dvjw6vMUNAc7ZMTYzlmlRqmeCOGjkOpy+BYo1wMj7PbGgbm0A32s45unkRw
 ZvJuQnHuczOfj+21RfXfs0UNZiGyN+A5qXCGvOlJZVE3ksFLoRXZyJliT+4YWJFVHnZJ
 1e/6cUvDGyPOdI9N2J5OGCIzUYARsKw03Cv8jHvekwLPCh5DcLA9ng/dk2kroVOVnzVC
 kTxF/epeDTTYQ6AYZQWtyAQUOqC7Ji/wCQXhIyM9Yy7XJi1XNFVXKY9vUHPd+KG/lqga
 vQShWmXW5ZZzd0d17UC4yiix+LOKQFuK0iCFU1UZNuxyphFC5Y7n6fo5LOpAVXZiWCes
 cWaQ==
X-Gm-Message-State: AOJu0YxD0nc1alslreQFwViVjErUNyQa1VSq042QFHXfX/Tr7+NW2gaB
 4OHLZpKXQARGRhmfcuzSvz28CqktRR9m3BU+GEWMe7Kf1hvjMhxkimhhliEMCwyGChOnA1U9PzM
 jE9jv/MbdB4UAzWeLJhnCcUp9gXV7STsxqajNXNZICZl6YM6AQ8jfSu1Rg0EfmTrf7APOCqj4B7
 hCgSEKnsbB1W2IMi8SXZ6sokDHcyZpR/Fg4A==
X-Received: by 2002:a05:600c:4ecf:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-41fead61f20mr202743375e9.37.1716033785655; 
 Sat, 18 May 2024 05:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq3UUYBLe/i27kur8UK4IglhWNTMRKvH9MAVswU85dcL0LY29LZYcUvt5L1dA+ww1d17ryMQ==
X-Received: by 2002:a05:600c:4ecf:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-41fead61f20mr202743085e9.37.1716033785110; 
 Sat, 18 May 2024 05:03:05 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8969fbsm23908455f8f.37.2024.05.18.05.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 05:03:04 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH 2/4] omap3: igep0x00: Drop unused SPI support
Date: Sat, 18 May 2024 14:02:30 +0200
Message-ID: <20240518120254.204138-3-javierm@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240518120254.204138-1-javierm@redhat.com>
References: <20240518120254.204138-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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

There are no SPI peripherals in neither the IGEPv2 board nor the IGEP COM
Module, so there's no reason to have this enabled in the boards defconfig.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 configs/igep00x0_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index e4d25556e3f3..6df6c33e25ab 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -82,7 +82,4 @@ CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_CONS_INDEX=3
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
 CONFIG_BCH=y
-- 
2.45.0

