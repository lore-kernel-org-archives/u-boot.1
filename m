Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA8EC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 09:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD8E87D40;
	Mon,  3 Jun 2024 11:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b40ortUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202648813A; Mon,  3 Jun 2024 11:11:08 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A20878E2
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 11:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42120e3911eso36753315e9.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717405865; x=1718010665;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OsGP1lip1h770i3+rDZz96/9Q552dbOuttcPIxafzkA=;
 b=b40ortUv/SMV/SKwPkDQ4OAk7Xn4k8H28tFn8ORPRK4nSGF2y2uPZCyICgu0h+naJM
 Vp3rf7LMOoW6WDDQe3xcwiZNiXjILThs8tKSM8xfaRof7iU1SbMel+LM6YGXtqWn22QQ
 AHcIvy67v9A3mP5I4ua7qta5cwPqoPpavptYHM0GkZYh3kxzxaNn7wYupo/yRqq7vLl3
 syGOMtBOtHh8+ZbqQzaIF+NyXVMNAJduNe93Ay0FgBzXF5dj8u2eX6WcnqIKL/Tunw3I
 z1NJdNxwh/NkKEgoyqAfQ4Ishk8Rt1itraTNTH4JxDhc8wQ369xNnVPEmhvLTWRc3gG2
 HXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717405865; x=1718010665;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OsGP1lip1h770i3+rDZz96/9Q552dbOuttcPIxafzkA=;
 b=RsdsTa7sQY3zQdrULdhh66zbChKMBQB9uH3ytDCAN0gpN/yBNSKRaLd/npotuPbenI
 S2+B+nP2pxjXaq7PBBOpwcHHw5hOpnj7KiwdivtEcrCkgXKr4tBDTnPB4qcMGE48p1vc
 MPEinbbxwzFzB0bPpbSplWFLeapPabEQXTyAfJ/qygOxJStFYL3/HUANtT23ORXmP78e
 HtgTQSMIP11x/zvuAELTLQITnwvBKsibExy/coU+Djs4H2DRALR3XBPpP8MmcrB4Kpm0
 tHEDaauHHV3sD9JfIVvhFhqtFZzfQo5S71M8h5f5ELPPFAJnAiPTu7L+pBtH+OZiB0Bj
 BgUw==
X-Gm-Message-State: AOJu0Yy4Cy7uJD0VPZVC9ZNDJFDE/Wsgjuwclz9NaLuq1bVwkfpnvCby
 OpJK5h9ULu6P1lixJFxTT1AuED9b5VMPzO+62HP0nCo7eb8h2/uz2kX1RuXeCaJsUAAB75Maspi
 vktU=
X-Google-Smtp-Source: AGHT+IE5D/8jY+Xv8mbHxEbl8D+n+AnmUw/DXK4vMF9yeOHmd4Vm+vtJ+YCtpGlWRdKfACG2mvOnHw==
X-Received: by 2002:a05:600c:3c97:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-4212e0c3fd9mr66010955e9.37.1717405865331; 
 Mon, 03 Jun 2024 02:11:05 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b8b39aesm108702055e9.46.2024.06.03.02.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 02:11:04 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Mon, 03 Jun 2024 11:11:01 +0200
Subject: [PATCH] bootstd: Fix a handful of doc typos in bootmeth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-bootmeth-typos-v1-1-6edbdb469f7c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKSIXWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNj3aT8/JLc1JIM3ZLKgvxiXRPzZAsz01Rzg+TkNCWgpoKi1LTMCrC
 B0bG1tQC++TBfYAAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-bf739
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

Fix some trivial typos found by browsing the code.
Done with flyspell.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/bootmeth.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/bootmeth.h b/include/bootmeth.h
index 0fc36104ece0..529c4d813d82 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -40,7 +40,7 @@ struct bootmeth_ops {
 	/**
 	 * get_state_desc() - get detailed state information
 	 *
-	 * Prodecues a textual description of the state of the bootmeth. This
+	 * Produces a textual description of the state of the bootmeth. This
 	 * can include newline characters if it extends to multiple lines. It
 	 * must be a nul-terminated string.
 	 *
@@ -138,7 +138,7 @@ struct bootmeth_ops {
 	 * @dev:	Bootmethod device to boot
 	 * @bflow:	Bootflow to boot
 	 * Return: does not return on success, since it should boot the
-	 *	Operating Systemn. Returns -EFAULT if that fails, -ENOTSUPP if
+	 *	Operating System. Returns -EFAULT if that fails, -ENOTSUPP if
 	 *	trying method resulted in finding out that is not actually
 	 *	supported for this boot and should not be tried again unless
 	 *	something changes, other -ve on other error
@@ -151,7 +151,7 @@ struct bootmeth_ops {
 /**
  * bootmeth_get_state_desc() - get detailed state information
  *
- * Prodecues a textual description of the state of the bootmeth. This
+ * Produces a textual description of the state of the bootmeth. This
  * can include newline characters if it extends to multiple lines. It
  * must be a nul-terminated string.
  *
@@ -244,7 +244,7 @@ int bootmeth_read_file(struct udevice *dev, struct bootflow *bflow,
  * @dev:	Bootmethod device to use
  * @bflow:	Bootflow to read
  * Return: does not return on success, since it should boot the
- *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
+ *	Operating System. Returns -EFAULT if that fails, other -ve on
  *	other error
  */
 int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
@@ -255,7 +255,7 @@ int bootmeth_read_all(struct udevice *dev, struct bootflow *bflow);
  * @dev:	Bootmethod device to boot
  * @bflow:	Bootflow to boot
  * Return: does not return on success, since it should boot the
- *	Operating Systemn. Returns -EFAULT if that fails, other -ve on
+ *	Operating System. Returns -EFAULT if that fails, other -ve on
  *	other error
  */
 int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
@@ -264,7 +264,7 @@ int bootmeth_boot(struct udevice *dev, struct bootflow *bflow);
  * bootmeth_setup_iter_order() - Set up the ordering of bootmeths to scan
  *
  * This sets up the ordering information in @iter, based on the selected
- * ordering of the bootmethds in bootstd_priv->bootmeth_order. If there is no
+ * ordering of the bootmeths in bootstd_priv->bootmeth_order. If there is no
  * ordering there, then all bootmethods are added
  *
  * @iter: Iterator to update with the order

---
base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
change-id: 20240603-bootmeth-typos-47c865e70ccf

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

