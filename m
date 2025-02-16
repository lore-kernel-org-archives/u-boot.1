Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD38C021A0
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 02:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2016680F56;
	Sun, 16 Feb 2025 03:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mv1hf/LM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F0780F53; Sun, 16 Feb 2025 03:04:20 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807EA80F1C
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so10876175ab.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739671453; x=1740276253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCKUbnl0c1cNnnTAXFLwAdiiYpZN1+FbyX0KRq6NXok=;
 b=Mv1hf/LMrsfoO6EILWRPeIwrm/0mpZ31J6eskb5gEhgIRF6vpswXxS746iLK1oQEhz
 +VCiJmh3x2pv18AnsoRXWTkScl26CwL1su/rCdb3c3NGuir255GLuXF1OtvClCGixM2P
 hI4WO+h1SILb10W+fgMqDVLAtiX8QZCxDdRJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739671453; x=1740276253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCKUbnl0c1cNnnTAXFLwAdiiYpZN1+FbyX0KRq6NXok=;
 b=slHyn/kmjrYZE0zFYWUgggfQdje34vPbghNP2UtjEfmzVEfhcPnzt5XJVxqnYVrZqG
 jJ1A4PmAMbxhubpjMuwdkXR+d3Zk8cf/xl2/6xu0DEvtbxOibY7zpOw3AgQajOLjflKw
 BEHK9EBYp++BRLZQdRmPcC84O54BvVWwIQ5rvtdbZWWLQDB96lrk11S/u+msn3BMaFJe
 uNVCx3Jm1R7ygRLpYXLd7HZYpvhwDk9u9B6NgFLAqaht+FO2ApxWm/5OmIizgUiT6dDn
 kUFwhw+vtU90dWpYYQwQgwxplFgWzigk1q38mNDuhgoFNiSt5+3o08KPc4lex+4MEqTw
 /UFA==
X-Gm-Message-State: AOJu0Yx0+xreBok9N6f+1WY/0gJ/7NgBGxHHDBxmrq9YjVjY3oCyVqm+
 hkKNyHmbRHH21I+9hQQUcxfhsAMcqD5VTCWQl7OZuvJa26ZtjS00L6FxNwSQBrQTJzmuVjkJG3s
 =
X-Gm-Gg: ASbGncuHpcrWmqOmVgKKg0RaI6ffvk6yJm+VPnUqTV8TVqpryJvm/c/zAk8coapdZap
 L+K96ECwsAD2iDPaeFqhZkH1g6wHUeqxkcDcFwVeRbWZHcNwNmeW37bVcxvf6yC2et0BKex8Ybj
 copoB3hToZNq5bFoCufwKTWAJOwNKVvtob+KpqpY8nOXoSeKut7ub7WITeefZSdqV/XfXghdrSW
 knUlh6nhsnG/HoXjfZPzwwrIuj4YyLKYQx1pt3EQn/wLD5W4VQkH3R9HSs1b5iJuR4zqWd0l5sP
 Aa2DMYsqNm/YeBaTodMnQF2KtPfy1vcwv6aGJNYN8rrhyTExGTJ8
X-Google-Smtp-Source: AGHT+IH/DVXYjQ+cugiX6cjCmSimOYoWWTZ/zNHHNSOl3d73mXLhSJPC8u9jmelzbgsyyJD7mS0Hbg==
X-Received: by 2002:a05:6602:13d4:b0:855:5b5f:a681 with SMTP id
 ca18e2360f4ac-8557a0ed382mr399363739f.8.1739671452654; 
 Sat, 15 Feb 2025 18:04:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85566e63bb7sm133525339f.25.2025.02.15.18.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:04:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] binman: Read the skip-at-start value on startup
Date: Sat, 15 Feb 2025 19:02:36 -0700
Message-ID: <20250216020359.3878546-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216020359.3878546-1-sjg@chromium.org>
References: <20250216020359.3878546-1-sjg@chromium.org>
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

This value provides an offset for all image-pos values in the image.
Read it on startup so that we can take account of it when calculating
positions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/binman.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/binman.c b/lib/binman.c
index 9047f5275f3..a594fe4c2ca 100644
--- a/lib/binman.c
+++ b/lib/binman.c
@@ -16,12 +16,15 @@
  * struct binman_info - Information needed by the binman library
  *
  * @image: Node describing the image we are running from
+ * @skip_at_start: Number of bytes skipped at the start of the image. This is
+ *	the value of the skip-at-start property for the image
  * @rom_offset: Offset from an image_pos to the memory-mapped address, or
  *	ROM_OFFSET_NONE if the ROM is not memory-mapped. Can be positive or
  *	negative
  */
 struct binman_info {
 	ofnode image;
+	uint skip_at_start;
 	int rom_offset;
 };
 
@@ -80,7 +83,14 @@ static int binman_entry_find_internal(ofnode node, const char *name,
 
 int binman_entry_find(const char *name, struct binman_entry *entry)
 {
-	return binman_entry_find_internal(binman->image, name, entry);
+	int ret;
+
+	ret = binman_entry_find_internal(binman->image, name, entry);
+	if (ret)
+		return log_msg_ret("bef", ret);
+	entry->image_pos -= binman->skip_at_start;
+
+	return 0;
 }
 
 int binman_entry_map(ofnode parent, const char *name, void **bufp, int *sizep)
@@ -107,7 +117,7 @@ ofnode binman_section_find_node(const char *name)
 
 void binman_set_rom_offset(int rom_offset)
 {
-	binman->rom_offset = rom_offset;
+	binman->rom_offset = rom_offset - binman->skip_at_start;
 }
 
 int binman_get_rom_offset(void)
@@ -140,10 +150,12 @@ int binman_init(void)
 	binman = malloc(sizeof(struct binman_info));
 	if (!binman)
 		return log_msg_ret("space for binman", -ENOMEM);
+	memset(binman, '\0', sizeof(struct binman_info));
 	ret = find_image_node(&binman->image);
 	if (ret)
 		return log_msg_ret("node", -ENOENT);
 	binman_set_rom_offset(ROM_OFFSET_NONE);
+	ofnode_read_u32(binman->image, "skip-at-start", &binman->skip_at_start);
 	log_debug("binman: Selected image node '%s'\n",
 		  ofnode_get_name(binman->image));
 
-- 
2.43.0

