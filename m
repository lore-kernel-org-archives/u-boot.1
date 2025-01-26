Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555C6C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D489780FED;
	Sun, 26 Jan 2025 19:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gV4dyb80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B5A480F96; Sun, 26 Jan 2025 19:44:10 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DF380FE2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3cf880d90bdso13686585ab.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917045; x=1738521845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3Olx3b/419yXnZuVpFTXwfbRbkp+VaxDQ3YKrLfGfI=;
 b=gV4dyb80XmNLhA4zQFBeSUKqP1l7Str6Uv4g4wyAhl1jcSjwnoiIB6+EaMU5EyKPYr
 VMmqGSouog01oM0HqjPo8jIxAmZF25srZTyRVyy304Nxce72cQTKfdR4e8eYgyE6xcB/
 734Bd72ZYLkCQq8X7krWcGQ5JMGW/AJmyK0n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917046; x=1738521846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3Olx3b/419yXnZuVpFTXwfbRbkp+VaxDQ3YKrLfGfI=;
 b=bkhMyMDe/CbaAEvD+J4690mJXXB1J9TEwSMa2smrNGKIZg09KlvWtvmHPPjYBvm7Wm
 LsbYnRWUTKCrymcxxM5NyLYNWRXw/ns8qEdA9GecEHRm1+idBhxFKrrYnKXrCJ+z+6oR
 cvo17PMD4ST+k7nVyUzAXMHKKn1MCshFSZzbZ1LCz8DTm20Qmt1IBxJEJwo9DcP3YMI2
 xOXPe72UCZ5pR8fuRQGHgityyJTEfOQxEg+HR9hGuDQOS2Z+AgHV114lVsi3RoFOztkf
 2YAP7B6xfVLQBNURFkZoHD660vb7tU6AJaVdP4soOwnA9Uu36pp1BL7h4foCJ9JsFxc6
 mRVQ==
X-Gm-Message-State: AOJu0YxF1d2P0lsqgF6Ljz7Vt4wJRyjo4KlEerdwWZwHMfm40XOB/T+6
 guY14ld6VJQGwfTrpTnwn1g11Wslj2cbXGjP1OK4fQVlEt798F+yE/X3OVrr3KZDEmRZdRAM3yM
 =
X-Gm-Gg: ASbGncvJSgFg2jDSKAtOARnVNxof2uuQPJLgcBT0dnqpUj8pfF+yQ0hSyoBuHwZhhC7
 BmteBzwTaGx72l67a92jA3xW+1fhqgJSBfqkV7tLN3aHQZ+ibSdo4Ln3l5nDAY7xahIvI4L/j72
 IJlij7SsXUAPkLUZpU9exqdwrf37c4+iqY65LlRJIK9KDcQ9K9R7+aDr3clFEoUvi3clzChhezs
 JT5GdEBeUY0FZUgNHUhI57Hr6Edj+qjuyKGamF5aiLUVJAxSladHrVBUrGnC05CjmpdZZ+kbH0T
 LNKbGmuDVDi0bVkLhGTX6TU0pt5sF1FgVF/G0M+b4Q==
X-Google-Smtp-Source: AGHT+IEX9k1UuzW9eLxD9GnlRRyqSowcP21/Zn0zQleTnZPA+tI7MdlEO3ycN3ZbFa5XMkkkDTbp+w==
X-Received: by 2002:a05:6e02:1a67:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3cf743ab4fcmr284323435ab.5.1737917045689; 
 Sun, 26 Jan 2025 10:44:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Daniel Palmer <daniel@0x0f.com>,
 Franco Venturi <fventuri@comcast.net>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/19] spl: Allow spl_load() to be controlled in any xPL phase
Date: Sun, 26 Jan 2025 11:43:19 -0700
Message-ID: <20250126184333.4058848-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Some phases may wish to use full FIT-loading and others not, so allow
this to be controlled.

Add some debugging while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/spl_load.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/spl_load.h b/include/spl_load.h
index 935f7d336f2..525e0c9e86c 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -20,13 +20,15 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	ulong base_offset, image_offset, overhead;
 	int read, ret;
 
+	log_debug("\nloading hdr from %lx to %p\n", (ulong)offset, header);
 	read = info->read(info, offset, ALIGN(sizeof(*header),
 					      spl_get_bl_len(info)), header);
 	if (read < (int)sizeof(*header))
 		return -EIO;
 
 	if (image_get_magic(header) == FDT_MAGIC) {
-		if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)) {
+		log_debug("Found FIT\n");
+		if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
 			void *buf;
 
 			/*
@@ -48,9 +50,12 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 			return spl_parse_image_header(spl_image, bootdev, buf);
 		}
 
-		if (IS_ENABLED(CONFIG_SPL_LOAD_FIT))
+		if (CONFIG_IS_ENABLED(LOAD_FIT)) {
+			log_debug("Simple loading\n");
 			return spl_load_simple_fit(spl_image, info, offset,
 						   header);
+		}
+		log_debug("No FIT support\n");
 	}
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
-- 
2.43.0

