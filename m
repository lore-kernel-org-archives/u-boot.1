Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46A1C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 15:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D094D884B8;
	Tue,  4 Jun 2024 17:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wQ7M6UcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B107788418; Tue,  4 Jun 2024 17:15:35 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FAC884A6
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 17:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dc984b3d2so4136283f8f.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717514133; x=1718118933;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=isn1j/FeA/LxuzJvdkP15dTMCEGCgKXUf46NKunEXzk=;
 b=wQ7M6UcILcteX2cNPYa6zI8bfFQWzsl505o9tyPhoEhurU82JsCSYYGRSmgFth2uTX
 p43p/2gmKd0MpGNM7zisz18txnGR4gDXxfdO5LvrtfUBd5Kdz5o79aC0RfgG4OthSUz+
 gr9gMxds13vrQ//C7ITsJrFlJvWc00J04MO9/Ncb4u7rczxpcUGqB36LRJW2MYEykJWz
 KCzjdWJBWQTpN06/3GRvZ/u83APRf0ZCOWvPP5tVoKM5PwyOI/6zlxvG+z9AUktw9t+/
 MeNl0BAAIATX2Lcx0sTVu6p32bXcTMR08mh06nl8zUGljEWN+ZbW4m8Ctkbrmxh3GUCh
 eJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514133; x=1718118933;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isn1j/FeA/LxuzJvdkP15dTMCEGCgKXUf46NKunEXzk=;
 b=GqHMiR+RcStFfHkCWTPlYFRxpW+uhOimTe2M6aiXaDOwyQXO0fVUPZbR6lB/uqGPMw
 hpqHeFCsEwIXBDmfM7V0NyVIBd9YVwJqudTKfEievLgjxacli4f4qULx9YXzXdidwQpu
 A763ErMkeLf6bw7TfUqYvkqUmdDL5x/kxAfVm3BC+msW6IDVytxE6e9JOLb/ZCSOn0ZA
 e4QxBv5xdtMv7FaszQoPXlhXm3wYJyKKerP8k2Tm4sZfw/4nGLOiJ7iATMCwzBK5BJap
 2tu9Xdrc7974fK0Moi4c0WO6yP5LXaKNsY2ayFcXmI8jBpJa3C+1j8t0li7ok6YkqlxX
 18xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDT3PPauR3EiY9VbAGV9bANKw874aI7TCoxBguDxpNJq5+KwISk1yNMVEjrJQ7dJNSoXsNTggprFQorbNU8WtQoe6E8w==
X-Gm-Message-State: AOJu0YyiYLWZc40y4o9QGT8wXiRraeLT1TDbkUJtwcWtt5ZDcAo5Roog
 MP6lDoUNmDPvUqActEySwCjpmMI3lxLrjvf/sQLtBdkp3mDn/aceltzoX112/Is=
X-Google-Smtp-Source: AGHT+IHv6tc2FvGVTS3LEwELwYdUyPrr5fK7F9xy+Kpp2JDm4wAYlwin1q2nENGqoN3fVesW0utDTg==
X-Received: by 2002:a5d:5612:0:b0:354:fc89:5432 with SMTP id
 ffacd0b85a97d-35e0f259a0amr9266373f8f.5.1717514133086; 
 Tue, 04 Jun 2024 08:15:33 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0e84sm11891775f8f.13.2024.06.04.08.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 08:15:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Tue, 04 Jun 2024 17:15:21 +0200
Subject: [PATCH v2 1/2] bootstd: Fix a handful of doc typos in bootmeth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-bootmeth-typos-v2-1-821683a95aaf@baylibre.com>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
In-Reply-To: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev-d4707
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
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

-- 
2.45.0

