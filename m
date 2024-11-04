Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B117D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65BC288ED9;
	Mon,  4 Nov 2024 18:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nWQdPEwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03CD088D7E; Mon,  4 Nov 2024 18:51:25 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D565788DFA
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83ab5b4b048so212339739f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742681; x=1731347481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wm4E9xlZw9x6n5A9J58U+VgJ1bv+Wqol7oUbwpKYvJg=;
 b=nWQdPEwadrPigzM4rmlELABqbXbTk5p//5195MnRx0r56J/dSSNKDaMN4RqxAX8aP3
 iWxguaFXe9EPvJiBYOKNs4CFhZ/uhOOXGjCCbb3yN+1xI/4wamJ2rQmhiAcU4XxsYVwU
 BlyBWnGB5SNoLGYeDmr5JNQ+6XiUa2sJmH67c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742681; x=1731347481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm4E9xlZw9x6n5A9J58U+VgJ1bv+Wqol7oUbwpKYvJg=;
 b=AnUD0CQS+fGOBIf9RDFw4C1DGGHvUAezsfTfn97NViHm3s1JhnMh0LSIZbSrELhYA/
 WvCxRVofDC9Ak+IwF3OgmPbzqXxlaREnsKet7uH2QdE9o8xcsm05zXOACjEjZzEsC+ZS
 afH/BXq8t8RZNI+/RQOg0udaAYGLcb3wLN1WSwCVaQQGyyHjnRJPObesVXnnqGHDbQlI
 wavpWSToGtjIQY3zvpMGpKnkZfbI5UsB3gdNdC2hFTXJoUBS92nMtdS6Yuim7h1WmVQf
 SOP8Htm66MAaWp5pw3Pgp8yIBVxlIi2bR5kY477viR20o1+CB4+LmXlzTEuoULXovVVN
 jLNQ==
X-Gm-Message-State: AOJu0YyiFQ+1y9coxgEvdnFwH40ADyPadRgAIrATAkHiZNj32q8Y1o5m
 vpDKJqbGQqmmHUok4dku/c/Xw6v6l4ltFfGCUDAdRP1AiicKdlaJ9AL8sm7V8GF3ca67jHjUIN8
 =
X-Google-Smtp-Source: AGHT+IGUkdL1xDPoUl341/Fbb7EWT1vyGF0R4jYE3lwJBYn+dOTaOhUSWM4ezXuw7/nIbTaeZHwUbw==
X-Received: by 2002:a05:6e02:12e1:b0:3a6:ac17:13e4 with SMTP id
 e9e14a558f8ab-3a6ac1717a2mr146600335ab.18.1730742681096; 
 Mon, 04 Nov 2024 09:51:21 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 03/19] bootstd: Add a function to get bootstd only if
 available
Date: Mon,  4 Nov 2024 10:50:54 -0700
Message-Id: <20241104175110.1048449-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

(no changes since v1)

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

