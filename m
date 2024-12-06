Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B4EE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24868975F;
	Fri,  6 Dec 2024 03:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iiqj2lvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC5C8977D; Fri,  6 Dec 2024 03:38:11 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6A68918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a77bd62fdeso5475885ab.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452687; x=1734057487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FjgX98zQ9LiIHYFJUf6V1snK6MplD46fQlGJcvlOq8=;
 b=iiqj2lvcMKYsfquMvXPLCAmkknS3EZuRkQxtD3fv/db5PdWqv0nsTsiIue2pjL4sOf
 +ZT8sSLZB2P2CNvlXqHHDgWf6lJNoit2gAbSZb+Ze8iXfCFoQBCzNeiN7P1VdIpjTF6C
 kBZAqtP4F3ZVeM4FKXavf4fzMF0wsYknmsAfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452687; x=1734057487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FjgX98zQ9LiIHYFJUf6V1snK6MplD46fQlGJcvlOq8=;
 b=dzp46vobQSkHTCJhs+RVHEL7CoaVCPLku04JKiCZNJ2iEWsM5a9+/jGGupl6MD1HDv
 GZMxi/33zflDzve1OViXr81W84Vb53PE03/96ZVk0fGU7dTXl+bJjIBI3bFgD+qKKIPR
 3aXlYfGD8D/wwWCNQxtT/Lz/3XgF5zv8u7tnUnnZhQwMrQ/941QfoiSKL2X4PaJuN5ri
 okMrY5B4ARJzFraC8bUai6BdJfrBqjObPVhHrPEzZ6JaGNmz5hTu7rYBqbJpGQUSlpXh
 8NfBnCMHp+WPNSN8xkb9vm/TLKHK2BKbYd72GtW6jhzlLF+kgG8hytKtWfha/D8ZLs7J
 XGeg==
X-Gm-Message-State: AOJu0YysPbKpKgRu8xd+Pw+wRAnoog1ES3S4+B5SsVZbQZ0lUWqC4GwG
 Miu+qncfIRajO0mBWSuRTJsOZFujmyQPdNLXti6qGLTg3r+JYzzUXEmzTlKQcPaj5h1mZdoIzeY
 =
X-Gm-Gg: ASbGncvmPhsqOMXjSR0WFOe3qWBkt/xyPptrqBL9ydBEmwEj+aE2in2Gj/V4gNtkmA8
 JvW+peBBoTDX4Bxv0orZ4OfoUFgK6tXcJg+1FY8qUIZYclCahYFECIb6XbUq2zy+4ZWrw9u0adP
 3DRdtzY9+uGH/swK+Lkd6b6PuBG9ceMseJcr7ndYpZzU4qpEBS8iM2BujDiqo3Y0SPDHvUz6f9g
 PRschfeT1jqYBtgWUxomaSzfxQA95lwiHXpdF/nArd8N7no79Nd0c5F4qX0ZIDEDn0yIqMc42JP
 BifHeabdApQ=
X-Google-Smtp-Source: AGHT+IHT40k1wic3BcMI8txUfrBu23q0LJLmsP7JslpJVZH8Uv98+SEOuFPBNvsTThAkTeoTrLNOLg==
X-Received: by 2002:a05:6602:341a:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-8447e35343bmr167948439f.10.1733452687574; 
 Thu, 05 Dec 2024 18:38:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 36/46] bootmeth_extlinux: Move pxe_context into plat
Date: Thu,  5 Dec 2024 19:36:15 -0700
Message-Id: <20241206023626.2456858-37-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Move this struct into the plat data so that we can use it multiple times
during the boot process.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index e2050af8203..144f5a11425 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -27,9 +27,11 @@
  *
  * @use_fallback: true to boot with the fallback option
  * @info: Info passed to the extlinux_getfile() function
+ * @ctx: holds the PXE context, if it should be saved
  */
 struct extlinux_plat {
 	bool use_fallback;
+	struct pxe_context ctx;
 	struct extlinux_info info;
 };
 
@@ -183,7 +185,6 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context ctx;
 	ulong addr;
 	int ret;
 
@@ -192,12 +193,12 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	plat->info.dev = dev;
 	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &plat->info, true,
+	ret = pxe_setup_ctx(&plat->ctx, extlinux_getfile, &plat->info, true,
 			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
-	ret = pxe_process(&ctx, addr, false);
+	ret = pxe_process(&plat->ctx, addr, false);
 	if (ret)
 		return log_msg_ret("bread", -EINVAL);
 
-- 
2.34.1

