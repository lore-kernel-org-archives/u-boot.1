Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1FAE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D94896B1;
	Wed,  4 Dec 2024 00:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H1pBCr9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACDF688F55; Wed,  4 Dec 2024 00:47:43 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716BC896F5
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-841aa93433aso209928539f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269659; x=1733874459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MOGQ2zyftS1Xz2K5qYTDlxJ85b4+CYNa3WpB8IuHTM=;
 b=H1pBCr9rn1ozYrYeIUHy+A/B5M6gbfAoHkR/YHuJe6CuH7iEwdNuiWUb0u7xTZkP/h
 65JhKAZUFRwA78F+THKW5sYvBLS0NNY+Qq9AmFSveeE13mxWe7UtpwBUChLFWg4rRMKd
 i3Li0by5Hajd+G+uTaGTBpsXtG6kzF3XkYB30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269659; x=1733874459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MOGQ2zyftS1Xz2K5qYTDlxJ85b4+CYNa3WpB8IuHTM=;
 b=Bugu6Js4v8A2uJzcUeKSFRuDG5A9QCE/0l5AtV0EISMQyUgMpAmh9H33uVZsB1aYfY
 WBNUDKow60zr9xbXDGrw/a6TljbftQnxsN90N23TsEiMb/1PJPTpQ5HIpq2ACEUaDHZA
 tMpzswTP/N1rtl5je81YLW5HCXpr9RUhY/Kt+OkI+GjcreI+LY1FIDPi8pMsTaEOBJSd
 5wtNNPoMRx3i1G034IKqe6TqQkdEboMS2S76moBdvT2CBUUnHtic8i59hCh1nwmPuHlU
 rTyCKxDs7hon4iT0nWK1sl1/NGRS8WxaeW2vCK6MeLYrIk7Zg9D0lzF2RJtq38E6+Iho
 pJDw==
X-Gm-Message-State: AOJu0YzhhNeLYhzoGGYouB8PFibq9dF1aAfXz1D2FsIptCw4Nq2+W/RR
 xI63w7TuXASjWzph5/c47BiIb4dDjCLvXrVHxf3LQTzlNHDd/4jthY++F7ZEDM3k+YNfSSjKXzk
 =
X-Gm-Gg: ASbGncsoiRq4+0OrF9MjNqib+WOWFC6CZ4B5LkM2bgZgtqc9RKh/PM/tg3XjooQ9+SZ
 8Xz6hgGaVc8QjC8l0UesoMHQPA0Mq/gT6iAgpziaDa69DysM2pBJ/lVRgFn8F0UgKxtJReqAkfH
 WeKM9ikvGU64QXgEPsr3d8fJ5V/QkZG5WWhWCGJPpLtKaf2XN/Aa2Tv9C84z8gafugTCiiwzgAl
 THIAz+bdk1UZnaWcRlPsn281bPXmbzmAIzUTtSMbveWHQrrZERLebME8csk82bNcleykeZ5ljS+
 K78G3IkLq1k=
X-Google-Smtp-Source: AGHT+IGk7PTnt0bTVuonMzC6vnD+g0aLzEiAFu/15e8rFu3z8EqVzJEBO/Gc1bM5qjnYGUNCsBrWdg==
X-Received: by 2002:a05:6602:1505:b0:841:a678:de3f with SMTP id
 ca18e2360f4ac-8445b42e47dmr553486539f.0.1733269659450; 
 Tue, 03 Dec 2024 15:47:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 31/41] bootmeth_extlinux: Move extlinux_info into plat
Date: Tue,  3 Dec 2024 16:45:49 -0700
Message-Id: <20241203234559.2938192-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

This struct is missing a comment, so add one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 569f9d760bf..e2050af8203 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -22,8 +22,15 @@
 #include <mmc.h>
 #include <pxe_utils.h>
 
+/**
+ * struct extlinux_plat - locate state for this bootmeth
+ *
+ * @use_fallback: true to boot with the fallback option
+ * @info: Info passed to the extlinux_getfile() function
+ */
 struct extlinux_plat {
 	bool use_fallback;
+	struct extlinux_info info;
 };
 
 enum extlinux_option_type {
@@ -175,20 +182,18 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
 	struct pxe_context ctx;
-	struct extlinux_info info;
-	struct extlinux_plat *plat;
 	ulong addr;
 	int ret;
 
 	addr = map_to_sysmem(bflow->buf);
-	info.dev = dev;
-	info.bflow = bflow;
 
-	plat = dev_get_plat(dev);
+	plat->info.dev = dev;
+	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &info, true, bflow->fname,
-			    false, plat->use_fallback, bflow);
+	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &plat->info, true,
+			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
-- 
2.34.1

