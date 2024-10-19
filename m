Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A66AD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84222892E8;
	Sat, 19 Oct 2024 17:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JiolOPdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FF9892A5; Sat, 19 Oct 2024 17:22:47 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC6188F92
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83abcfb9fd4so60331539f.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351364; x=1729956164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wm4E9xlZw9x6n5A9J58U+VgJ1bv+Wqol7oUbwpKYvJg=;
 b=JiolOPdphBsrX53qxCaEY/XZny6oUtyoWT1+OlUH86orTCZ6Z8wDAsx345ILENvdL2
 wiTjw4fp2FIXc4A956zHL74DMlVbsgKHLbyT+SzQU40Iblxle638LOQTK7TWm1XeilP7
 uXNM33MuZ8qRVa5PQqWaO0yykF+j5jnJW8I2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351364; x=1729956164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm4E9xlZw9x6n5A9J58U+VgJ1bv+Wqol7oUbwpKYvJg=;
 b=RSK/BQVfWA+u2ACV2eJiBhaffwYDXGDu2yG93HTyLHGAvjNTzmZjrqubrTTpOmlDql
 ENqRXTcTYfEcdjNMO1M5dxVE+f689ycoQ/4pU5PJV3G+uAUBRj4o7nfAAps8Sy098UDo
 6zwFEiAF2We6M17FBtRD7WuN7pPuPfErPuHW9grYPhFseOaFvcfuwCs8BPPCCq2Jf63u
 JEBMA+CpbKO39DEj09Uo5Djppoz54bc2l1iGDKAyiU/osqJAvZmFLneWXHeOrwbNVvfN
 ZyXEPKu8V4Ud0m+rUmMqtEXCiDbSHhSIMTQ8v1tOLD26k6KCeN6+nBrgcUe9bQ5MLZxz
 1h8A==
X-Gm-Message-State: AOJu0Yxm/A0L0sXqjnqm13cW24KVxbKvpMy+CUXi/ciPXWEz/9zuq0w5
 qbx4pjVvZs//dhYfwxZ21r/H1z8oowRByDXvUeSQ3ZP6fejyWxY7ehsdCQ4YQLSEv6LlPnNJ7J4
 =
X-Google-Smtp-Source: AGHT+IGSm/YYXMSsUrabauZ3h6JORoPlfMcXDsBA1qaqc9sS2bWuLgx7d1fD6nq3Rdi6dRCS8CIegw==
X-Received: by 2002:a05:6e02:12e7:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a3f405b8f0mr57020785ab.7.1729351363761; 
 Sat, 19 Oct 2024 08:22:43 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 13/31] bootstd: Add a function to get bootstd only if
 available
Date: Sat, 19 Oct 2024 09:21:53 -0600
Message-Id: <20241019152211.1014896-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

