Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A72C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 19:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B4B8722B;
	Mon, 30 Oct 2023 20:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WW2b/6dk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E9386FB0; Mon, 30 Oct 2023 20:47:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4626C8722B
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 20:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7dd65052aso48913687b3.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698695231; x=1699300031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nYio7TTfgkkRK3hfj2MijHWHgu4fLI7UDIzCtBsZHyM=;
 b=WW2b/6dkowYXY6NJAaypIB2T7tu9AJ+cN4IeZ0qdz+yqoA8DjUG1sd7OKkSHrqDxra
 eYuTCtU4og5YS+PgoiX2uwn9sOoAdneqgoU7/mYT7/6mFdZQP5tHzqttBNqSJcf4kB64
 XMCq7TErYeQ5E1YxEjuEg2Qg4YZsVQR7MmOW98AppCfKIA6BBD6hEZQFyDnfSV3PEPfM
 yibdLKE0yAOK0ns/zUsZ5xs0l3lVr+yTy1x9m60OXqMpKpow5LqCF9GHqNB6wcqS8rIc
 F7GXL7/TQaghtzTy5MaLslTWfnj1Wgoh8e2M2cEPwrdzGFkZivbeF2h63V0e4bFD4J5+
 6YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698695231; x=1699300031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYio7TTfgkkRK3hfj2MijHWHgu4fLI7UDIzCtBsZHyM=;
 b=NRgESUaIIj1i/gE15RcNUMoyfhpOtbf0i1gtjbmeLgfjU7fw3d1FFZbxUrK3p7v2nD
 HArCR3Xtn7c+2PvmvXUxOrW7qHYoIQFrGKH/5aCWhoMfEbKt2yUbKv50YlrlGiRm0rjG
 YwEKFKeq6qYCitb8DlSxpS5F0n189bb9aNaJe6qVlVTIEqj/uuJiNH7K2ZOMsEYOvAdz
 5p8yKyPmHgWrzyojjUDGDPzCUAuzFbpDh9PnMTrHurbceUhzV+Zf+bqRr0MKADYN0hc2
 REXasJ57d723QcPXaPD84BZEfT0Q09F0dShV8NjtneTiGLw+G+k8KkanZNfP8ppExXs8
 Uutg==
X-Gm-Message-State: AOJu0Yy8Kgi7SARxAtq24N6zEmn0yrYWnanH2IYGSRKObqOWRnGE6Ar6
 LCcgX/oD6s3ijC+wt/uryTw=
X-Google-Smtp-Source: AGHT+IFpUpWb4w/FoN3qBBERJ6FyldwU/vwcckfS4e7a7rL4ThC8LTuh+ovFvQEf2MKY7lPF0p9ZBA==
X-Received: by 2002:a81:c64b:0:b0:578:5e60:dcc9 with SMTP id
 q11-20020a81c64b000000b005785e60dcc9mr9872811ywj.10.1698695230883; 
 Mon, 30 Oct 2023 12:47:10 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a81b40d000000b0058fc7604f45sm59189ywi.130.2023.10.30.12.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 12:47:09 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] bootstd: Skip over bad device during bootflows scanning
Date: Mon, 30 Oct 2023 12:46:49 -0700
Message-Id: <20231030194650.11594-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

During scanning for the next bootdev, if bootdev_next_prio() encounters
a device error (e.g. ENOSYS), let it continue scanning the next devices,
not stopping prematurely.

Background:

During scanning for bootflows, it's possible for bootstd to encounter a
faulty device controller. Also when the same u-boot is used for another
variant of the same board, some device controller such as SATA might
not exist.

I've found this issue while converting the Marvell Sheevaplug board to
use bootstd. This board has 2 variants, the original Sheevaplug has MMC and
USB only, but the later variant comes with USB, MMC, and eSATA ports. We
have been using the same u-boot (starting with CONFIG_IDE and later with DM
CONFIG_SATA) for both variants. This worked well with the old
envs-scripting booting scheme.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 boot/bootdev-uclass.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 44ae98a926..b1d48e5b69 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -677,8 +677,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 							BOOTFLOWIF_SHOW);
 				log_debug("- bootdev_hunt_prio() ret %d\n",
 					  ret);
-				if (ret)
-					return log_msg_ret("hun", ret);
 			}
 		} else {
 			ret = device_probe(dev);
-- 
2.39.2

