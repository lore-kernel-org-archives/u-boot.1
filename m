Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CAECD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CB28341A;
	Wed, 13 May 2026 16:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="B/RO+FDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419018460E; Wed, 13 May 2026 16:09:40 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B66F80F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dca4debedaso6440227a34.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778681377; x=1779286177;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IVpmNSM4+h1MeuILJpxviPbdYg/WNN1cfCABGc910fY=;
 b=B/RO+FDCGyjaf8skTAqqXZP/vofvpXELMC+XK49lfsjxXZn7l6XFdVejZ3LhoDU+3V
 gHXXKl+wkosrL5T78yvqMO3bMzblsWgy4niB1ef9WRlrA2eqgPwYgUGL7NXK1mYf/QtZ
 OVLQr7zyhgKr52jElstUxKVyA0lsfJKbIfVVzsEblBVoseuc958B6pVmOpm5cEHc2Kht
 AS87zoqmGgTwBFiug9GwkhyR7qB4bJ0PDH7o+Dlr0zGDI4mN3VVTE/eDRvIQ37ghyl7g
 Bxxyj1a/epIdXhlhivTsOaJLkf3fr+Iri0L15kQpOXgmrfaGXKi99A1swSTugFly5njZ
 L/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778681377; x=1779286177;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVpmNSM4+h1MeuILJpxviPbdYg/WNN1cfCABGc910fY=;
 b=HAg+2q5l7BhuerukFDfMaYK/cVNAJawGwwt/ZuP1QNaw+6SeA5CAlo9dlWGC+FnyQ5
 ACBKreRoUrWZffwpzYsl+LSJgauQrNiGQQ3wxFdJYxlXajLqLpePdiuPSRqYIg7FHuBU
 Z2yJpZtDNzOQwKF/5JlHhza7NVnWYoTGhoCNGfEiAgfyBVVbQ6OuPKq0GFOQ+zXr9iLW
 eiec3KzdxdGIGInDAbctyHVCsAuzGRONxT9l/gbeICZoWDUeWX4kZENIjQDAz0aCl3RO
 HVWF0rHgxoJnkPB3GNBegmOF9BuQEznhLaX3KfH5mE+/CLllMrRb6QBGJpKWARf7qgkq
 +ZEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ83dahZSxFR4vF/bz818DWr11EHGwmtGrA9P7r+9z7Sk7Fnxk25W+VKHuPfT3oXhOjw62J85kk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6pZPhBtd8kfKkTX7P79TiJOB94y9GRQKYkTw5+llopIu990jF
 vMTn04jAfXyRDLvL+bey7xHyI9GGq/ozZ8XHad/RJl+GmdMbN6LsGMI2oumutZ1dcxo=
X-Gm-Gg: Acq92OFDPWI8PmL8eT3P4TfJ58EJNwnSxiqOw4C0xlkudA6Jzq0wSduPY5vG3puKB6k
 6G/QlTLT1hh91qQccepok2eAmNeRCfqd/7zXxIaGo2RP/GuCeEUkMgLpOLeFTXlKj1T2d9aCnjo
 H5L50oc5zbIu7uBF9Y59RDKuF6ax+pVI2Wzz1Gcd684c0e7zqPkwXJ/yOmIe63JqkD6itXaWoFF
 r6/7nxJ0d8jbs5hu8x7s7PPeL2GRlxhexLDfr3elKbZxmrvBfDaa7Yd+twwn2x2S1OzmGhvxgtH
 D64FteJWeiwTRRam01Ztd8XiUzKz2NZwOaDtzNRSk7GWdTqQe7RSBZwEMieVLzTkl2avHFj88k7
 LEOIAwAH0y+6h+CfkzyAhcxvTbQz20OQxQr4730p0ZqXIUiiELyUskpxr2vrApesGmdp4s0hlh1
 jMVrpYN62JUv/cKc+pYiEc3cyuhow6
X-Received: by 2002:a05:6830:349e:b0:7dd:e032:3cdb with SMTP id
 46e09a7af769-7e3da454179mr1966850a34.18.1778681376824; 
 Wed, 13 May 2026 07:09:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:597d:f2e2:6bf1:a5e9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8fd96sm11249134a34.19.2026.05.13.07.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:09:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 13 May 2026 09:09:23 -0500
Subject: [PATCH] ufs: Kconfig: use bool instead of tristate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQprZQryIuavKnjkIimVSE0
 rsb2+W3eG8lRRYoXZqVMj6ikmJFe2rIPaY4g8VXkzV2MH3b8RKUXy7FIDPHxCWLlqmAz37sMPg
 RprdU63dGkO9+vt4O63J/wpX/jrbtB8o2My97AAAA
X-Change-ID: 20260513-ufs-kconfig-no-tristate-4d93e6d9e052
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UzaiU7dR6hmRex5ek98CDzm+SeBPcgfNncRXEeDL8uM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqBIYZOEIJXCjleLu3Gkkrg0BLEyjJ4xLMeRmdf
 YNvnm+hTuCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagSGGRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApIAH/R1ycfVimJYwc7qA6m/3H2Ccsi1trWjpc2dIEbs
 PsQ5bKL6haWYUl14gg5Xe9ginqRf6/Xn9P+Zdlmm9+pvHYFUQAeobE1SSLYcdniRopisOKFIlj4
 fFmLwFNlhqHBLUQetUKQNZjuxySPT9TLmCFhfGWvCb3YpylJJMdzriaOGS4Iv7Rq7qoCyXyQtHq
 1WSISespcVvzU+8J8UOG/gEnOp8+eNhsEo4l9uA7JxRR9MHmyUTDc249VReGaISVgxM0lXiteGe
 0Qek/hwcImbay5dm04iPCo+3eGhOo4gSa40omlJMR1Vw7A7rN70E6ASMMcUbKP91GgQEkgxdFc/
 lSRw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change the lone use of tristate in the UFS Kconfig to bool. U-Boot does
not support modules, so tristate does not make sense here.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/ufs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..6ddf0820102 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -24,7 +24,7 @@ config UFS_CADENCE
 	  controller present on present TI's J721e devices.
 
 config UFS_MEDIATEK
-	tristate "MediaTek UFS Host Controller Driver"
+	bool "MediaTek UFS Host Controller Driver"
 	depends on UFS && ARCH_MEDIATEK
 	select PHY_MTK_UFS
 	help

---
base-commit: e3e651c480c46b332f16a7555b97c6c6fd640a40
change-id: 20260513-ufs-kconfig-no-tristate-4d93e6d9e052

Best regards,
--  
David Lechner <dlechner@baylibre.com>

