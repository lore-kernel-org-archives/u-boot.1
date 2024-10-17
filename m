Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C91FD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3686D8922F;
	Fri, 18 Oct 2024 01:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lXR94Z6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B73891E5; Fri, 18 Oct 2024 01:24:55 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604E9891C6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a3938e73d3so6213805ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207491; x=1729812291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzZ7U2LzSIvP0rPKfT2W1T4n/w09G7KqszgmIxXKUe8=;
 b=lXR94Z6OMk8eWgkWUQgCFpg/A8TMI2PamdUGXAUFJyRZFt6TLtXlnew11flSmT/UOv
 xZCQGL383NNK44Fwvby8YX9+FxkefAxb/kCuDKVXO5MUOKv/zrlea5GuwNjzgA9C39F1
 X9RX0dh2W9x1GkhF1SmzLuxdxIk/kYxD64unc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207491; x=1729812291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzZ7U2LzSIvP0rPKfT2W1T4n/w09G7KqszgmIxXKUe8=;
 b=nt6mlJT+EgXGzKfFOSCFQIt9q3aon3szFzPV8F8f06zJj9Rr5ZmByg0AhmpHyvZFqc
 nMnPZbwYe8WnBCpPGSVvdXy1PT3R7r5VS6ypaaP0zKuS0FXIOgFbXY77YJ5zpBC5rteh
 6d4zIW+D5AAipc1q0y3bXobaGLI2FF43caCRSg87qMohfX3iFt4faj53ImmsgF6pfq2W
 TVPPh1bIxwF5amuKv5b3x6uKvmvjIc2c3JhQirhnbF8x1pydDTN//IlDVd0R6qasxws5
 bVVAjJHqZLVwvxIJFgsYK7TLZFNrPlByy/EQFr09Ob1RU3iMMMbG3kL1GbfJ5wLX2G/3
 FioA==
X-Gm-Message-State: AOJu0Yycatd/JOhXTPZDEF7nC4sJg+16VgddEe8hV9upxuvk5YkVn/jH
 ciCw9qyl2NWBEsjnTXOcUHpsel14rAdkiypKVJRBN+uouRYGgOXEQ2doSXmsYfnm0SiOUdv9dfE
 =
X-Google-Smtp-Source: AGHT+IEB7mnSWzBP2NiC4vsdZgkuRQ03tzXYGI3/R1vhfqeoWD55M+0EWLw62MwfF8SgJJl5Q5iT+A==
X-Received: by 2002:a92:cda1:0:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a3f40ad81bmr3960125ab.21.1729207491002; 
 Thu, 17 Oct 2024 16:24:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 12/34] bootstd: Add a function to get bootstd only if available
Date: Thu, 17 Oct 2024 17:23:51 -0600
Message-Id: <20241017232413.724808-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Provide a function which is safe to call in the 'unbind' path, which
returns the bootstd priv data if available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootstd-uclass.c | 11 +++++++++++
 include/bootstd.h     | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 596d3e5e41d..b2f80808c85 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -140,6 +140,17 @@ const char *const *const bootstd_get_prefixes(struct udevice *dev)
 	return std->prefixes ? std->prefixes : default_prefixes;
 }
 
+struct bootstd_priv *bootstd_try_priv(void)
+{
+	struct udevice *dev;
+
+	dev = uclass_try_first_device(UCLASS_BOOTSTD);
+	if (!dev || !device_active(dev))
+		return NULL;
+
+	return dev_get_priv(dev);
+}
+
 int bootstd_get_priv(struct bootstd_priv **stdp)
 {
 	struct udevice *dev;
diff --git a/include/bootstd.h b/include/bootstd.h
index 4220ece785d..4535d91e2ad 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -89,6 +89,23 @@ const char *const *const bootstd_get_prefixes(struct udevice *dev);
  */
 int bootstd_get_priv(struct bootstd_priv **stdp);
 
+/**
+ * bootstd_try_priv() - Try to get the (single) state for the bootstd system
+ *
+ * The state holds a global list of all bootflows that have been found. This
+ * function returns the state if available, but takes care not to create the
+ * device (or uclass) if it doesn't exist.
+ *
+ * This function is safe to use in the 'unbind' path. It will always return NULL
+ * unless the bootstd device is probed and ready, e.g. bootstd_get_priv() has
+ * previously been called.
+ *
+ * TODO(sjg@chromium.org): Consider adding a bootstd pointer to global_data
+ *
+ * Return: pointer if the device exists, else NULL
+ */
+struct bootstd_priv *bootstd_try_priv(void);
+
 /**
  * bootstd_clear_glob() - Clear the global list of bootflows
  *
-- 
2.34.1

