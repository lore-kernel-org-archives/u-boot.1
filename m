Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7191BCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A36C88213;
	Thu, 11 Apr 2024 06:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="TV6GS536";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E549388205; Thu, 11 Apr 2024 06:28:22 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 327C188208
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lR9pbVoAsxiiKijSXHGIAktKYyg316HJ+R0kotHJbI=;
 b=TV6GS536CpQ7xGBDPEQPlULRrNY5ZU/lsUnsVWyg6SIJapEDAzN9/b8aTJkccov09zvEqt
 I6rBh6NS/WROi48M8DafplQRImfZkXsE2+PRdSQVgG4/5w2nKh2C5wfmgv+N6ab7+RzykX
 95ByTbSIhOOM5PUk0sIUe+L8IS0RKcFzFyL7D+K9NRwRDICM9UylitQwx2vZVZ/q2XyKmx
 vSuT3K0mWs3q1QOG8UJXhQECxbSn5Op6ZdVt87fEViI5ehSHM8kn1DC7K9MFt34O5usje7
 HseVoVcY2V0NZwczkVU59Z02YCXPvrZ5hkukYr1kQNxgDGS0qORXbx1Zl+gOGw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:27 +1000
Subject: [PATCH RFC 10/15] spl: Add SPL_SPINAND configuration options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-10-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809574; l=1420;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=v3TLI0FGR3ybC+CFJhwtlipDsaQ/z6IqQ0q0Je4f7+E=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAl7lxkT67gz9VnULOHmqyDgD
 D/bNJSBGkm+IWCxpIanhZ2BYcj3ssDdwPPes2uC0Y7Xm7Zb+KC7N6CyOGDJ4lDgUAAOlU
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

Boards that support SPI NAND need to specify the page and eraseblock
size. Add those as Kconfig options.

Signed-off-by: John Watts <contact@jookia.org>
---
 common/spl/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc..51d1f9f59d 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -906,6 +906,27 @@ config SPL_MUSB_NEW
 	  the drivers in drivers/usb/musb-new as part of an SPL build. The
 	  old drivers are in drivers/usb/musb.
 
+config SPL_SPINAND_SUPPORT
+	bool "Support SPINAND flash"
+	help
+	  Enable support for SPINAND (Negative AND) flash in SPL. SPINAND flash
+	  can be used to allow SPL to load U-Boot from supported devices.
+
+config SPL_SPINAND_PAGE_SIZE
+        hex "SPINAND chip page size"
+        depends on SPL_SPINAND_SUPPORT
+        help
+          Number of data bytes in one page for the SPINAND chip on the
+          board, not including the OOB area.
+
+config SPL_SPINAND_BLOCK_SIZE
+        hex "SPINAND chip eraseblock size"
+        depends on SPL_SPINAND_SUPPORT
+        help
+          Number of data bytes in one eraseblock for the SPINAND chip on the
+          board. This is the multiple of SPINAND_PAGE_SIZE and the number of
+          pages.
+
 config SPL_NAND_SUPPORT
 	bool "Support NAND flash"
 	select SPL_LOAD_BLOCK

-- 
2.44.0

