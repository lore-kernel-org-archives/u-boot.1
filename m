Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DB9C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F9281269;
	Tue, 25 Feb 2025 00:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SUclK1Pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0D580FA6; Tue, 25 Feb 2025 00:08:18 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0E481417
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d19d214f0aso34214315ab.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438495; x=1741043295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmrbrPx8C8lTlfgMpHMgdYbLaYRv5aqM4vQGegO2/n0=;
 b=SUclK1PdwUsvLa0w8hAvDDEP45xp4rWSab3QKj+Y51Bohnqq34APlS2ZS8CNw1Kfqm
 P39+clU28dFPmdT0MKNPC4HNIssWyhZT1ffJglWapV9UE0xlEbpsv8nbI+zBe7Htqh1J
 GYtuyfgUMFM9Xiq/mtipHYg674GJSjd/ok5DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438495; x=1741043295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmrbrPx8C8lTlfgMpHMgdYbLaYRv5aqM4vQGegO2/n0=;
 b=NV5KTJD2AdznwMs/s6ZPicJ5lyScgLWejEKyLphjQlieST9njlaUe1Z7fyYVfX1SeL
 N7UILi467ii3Biy032dJKvZ0QxFXxPwjLUrIhPcBHsaExUI6PUybeJ415jc08brkwMvB
 W8kcFj+Yq5sfNzsbP8jvRyid7fbatqTJ4zethmHzFpV9oQET7zNtF+eFfnf6Jgqt4XgS
 YMhR8FsTqTGiqTklfmLgBKjnH9Cbj3pZZyItMde6oULt7/7IHA2AqxI0SDAGT3yetbxx
 1NZyYT+QBFGNxVW1TH61+pnr52uRb5KnaSuCh9SM0le+u4Gg8k2NAlWnnVK0V+wZPWF4
 sy6g==
X-Gm-Message-State: AOJu0Yw1ZHfZs3aLuc92CFc47ah80OiCntPv4j2EczOCALB40dj4uWpd
 yakMgKFkDkny7moP+xbppsDvXONs6K8tq8ZeW4GAP3yvfaOSyyM4/7xkUMQorZkK9hsQr2VgSK0
 =
X-Gm-Gg: ASbGncv43EYhAhGOBvP5KYYlMAvDsN9VCc9AGCj/dbsNmdNQ/NRfvFrA66EITQ941Rj
 YRsCqC0TJGC3Cmml7CuxhcDMS6O2q6AXEIEs9sZLqt5mr4ObcDYhB6+ZrQAx6iO2npiWpMo9DH9
 FOFIKA11EH0joc6geW18xSdKTSvHuP97R3FIlie1m0e9ySfvRM7EfKxYvh6QI66egNnMjKags58
 vujI7Mxe8g+DaKvpyj59cKUmlR7uwu48mfbo342iPx4LtDofIEhBi+w0SEkyXfzNOAldIcUGHau
 Pou+ZAX+LemNQsdKzOkkI/97OSM02HUr0dTfWGiXolibnLJ6a/nec9vK5JkzNkg=
X-Google-Smtp-Source: AGHT+IHACnDD+6h3jLSlNJK2KAY92T0djyiYESiDkjlBawzCtVl+MtZc76HF5kMMD/I0b5kBfNiO+g==
X-Received: by 2002:a05:6e02:12c6:b0:3d0:618c:1b22 with SMTP id
 e9e14a558f8ab-3d2cb492ea0mr142515175ab.11.1740438494913; 
 Mon, 24 Feb 2025 15:08:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 37/44] boot: Handle running out of labels
Date: Mon, 24 Feb 2025 16:06:26 -0700
Message-ID: <20250224230640.2665206-38-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

If only a single label is provided in the list, bootdev_next_label()
does not operate correctly and reads beyond the end of the pointer list.

Fix this by adding a new check. Also add a note to convert this array
to an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to handle running out of labels

 boot/bootdev-uclass.c | 3 +++
 include/bootstd.h     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 9e4c3db2dc1..3791ebfcb42 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -579,6 +579,9 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 	struct udevice *dev;
 
 	log_debug("next\n");
+	if (iter->cur_label >= 0 && !iter->labels[iter->cur_label])
+		return log_msg_ret("fil", -ENODEV);
+
 	for (dev = NULL; !dev && iter->labels[++iter->cur_label];) {
 		const char *label = iter->labels[iter->cur_label];
 		int ret;
diff --git a/include/bootstd.h b/include/bootstd.h
index c39058c0787..ac3c1922fcc 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -24,6 +24,9 @@ struct udevice;
  * This is attached to the (only) bootstd device, so there is only one instance
  * of this struct. It provides overall information about bootdevs and bootflows.
  *
+ * TODO(sjg@chromium.org): Convert prefixes, bootdev_order and env_order to use
+ *	alist
+ *
  * @prefixes: NULL-terminated list of prefixes to use for bootflow filenames,
  *	e.g. "/", "/boot/"; NULL if none
  * @bootdev_order: Order to use for bootdevs (or NULL if none), with each item
-- 
2.43.0

