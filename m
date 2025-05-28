Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C54C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7956083AA4;
	Wed, 28 May 2025 14:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GcJXNeGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7712883AA6; Wed, 28 May 2025 14:33:45 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3652D83A7D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3da73df6b6bso12835815ab.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435621; x=1749040421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoYwqe3Ojud+jRx1+7hPf9ndoDSz0HM2eiBeFnlc1vE=;
 b=GcJXNeGu8TVSbBqWjmAMp0qhcZ6X2bNHphx3c3HW1InpTSLrtZAkPQYCzlObhGGfV0
 v5aaArL3FYQqzDxN+SXb9eayNDulhv2s/Aw8jVTdLo/WXhtLYfeJAl3hlxsl/Nr7hy1f
 48tVzboGfCmPJs/V1OVCpcDhN/1JI62n8kNDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435621; x=1749040421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoYwqe3Ojud+jRx1+7hPf9ndoDSz0HM2eiBeFnlc1vE=;
 b=JeyaFVkRwwkm01IewaEYhjLtIxKGel7ts48OYgMVIyw5jjEFj3NvE74zFaaDSNeBM1
 BuO7Fd2uxTTOtZFm8X9+9md37hn3sigfVxy64vnSpAQJUEBo+mHFVEYlS143v2jmpPYX
 kXZir1r0ke7AW8K+ySKtCNVnGG/Kxa5ERNv9rfsg5VzGYLm9qbysxQmmVeSXPLycIUKf
 3T1z8wqQsfOE8v5yIgBYvSwkDXmB1dHWiMWZDEtz6o3MRLR6+Itkv/nsXZ7EA54jPW86
 zU8VNiE3riHK5QHGxOsVqXsIdyyT43IvoW/AC1ter/Tv48+NfJP8UI+QcaSvPbT9qbFc
 XZcA==
X-Gm-Message-State: AOJu0Ywzm4CyYogK0k7Cj8KNdi1jHqycT5x/OeILjGi3Z4ODPYKzftqa
 SA3By6WDnVY7o6UPyfGTUfAl72LzlSJSB76L/V39y1WljX50FlZFqd0tuMFKcfJh+LU0yt66MKV
 wtOi47rrx
X-Gm-Gg: ASbGncu94sAWlTXqXkd/bdzETLZAlsVVeklIIa9gXPNYYe8xRqNd7eo3Yo6owvcNRtw
 pcyplqX3HARk0LYugGDLu9RZS9l5yqkQwGNyoLEsUlKPr9BEMi/54qpeV6sCYngD4i7YRGGREhJ
 3OaKwYSiWElMC8k1lPIA+KwQCu3EG7Bajs2Uj45kQVXtqrIjG6Dr6+CMobnsMQ4qVEFXvgzsNXf
 pxLQc11NEt/yQa0/Y9KNc3iaPQRvD8d6HV+hCjXzaWFCWPSYMrSXsDN8C9dInPhtVNoN2Gosj87
 75Vh5Xx40POuR1nu+9YPWzmHmlt9Q8JsS6BWTO9G0IYPcW9Rsf8ELwx0OwFKVi76xKrDJGSKhe1
 6NPsZiGFWItQy
X-Google-Smtp-Source: AGHT+IHXOli7fsC99e0aIN+CRNz5tA4PHuA6S6KCe354mltDY6FLC9q4WuZzGb6laISIJpr0BETyaw==
X-Received: by 2002:a05:6e02:2503:b0:3dc:7fa4:832 with SMTP id
 e9e14a558f8ab-3dc9b68826fmr132326895ab.9.1748435621124; 
 Wed, 28 May 2025 05:33:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 13/25] passage: spl: Support adding the dtb to the passage
 bloblist
Date: Wed, 28 May 2025 06:32:15 -0600
Message-ID: <20250528063224.v5.13.Id6acd05e6730b3301ddc62b415a155202ddba74b@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Add an option for SPL to add a devicetree to the passage bloblist, so
SPL can provide the devicetree to U-Boot.

Fix a few long lines while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rebase on -master
- Update the commit message to mention the long lines

 common/Kconfig   | 20 ++++++++++++++++++++
 common/spl/spl.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 include/spl.h    |  2 ++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 94046c9aa8c..fcd9d1620b5 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1250,6 +1250,26 @@ config SPL_PASSAGE_IN
 	  firmware phases to communicate state and settings to following
 	  phases.
 
+config SPL_PASSAGE_OUT
+	bool "Support the standard-passage protocol in SPL (out)"
+	depends on SPL_BLOBLIST
+	default y if PASSAGE_IN
+	help
+	  This enables a standard protocol for entering U-Boot, providing
+	  parameters in a bloblist and a devicetree. It allows the various
+	  firmware stages to communicate state and settings to following
+	  stages.
+
+config SPL_PASSAGE_ADD_DTB
+	bool "Add devicetree to the outgoing passage"
+	depends on SPL_PASSAGE_OUT
+	default y if SPL_PASSAGE_OUT && !SPL_PASSAGE_IN
+	help
+	  Add the devicetree into the bloblist in SPL (it is assumed to not
+	  already be there) so that the next phase (U-Boot) can find it.
+
+	  This option should be enabled in the phase that sets up the passage.
+
 source "common/spl/Kconfig"
 
 config IMAGE_SIGN_INFO
diff --git a/common/spl/spl.c b/common/spl/spl.c
index f14c68c46a5..6e38f118f48 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -66,6 +66,11 @@ binman_sym_declare(ulong, u_boot_vpl_any, size);
 
 #endif /* BINMAN_UBOOT_SYMBOLS */
 
+#if CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)
+binman_sym_declare(ulong, u_boot_dtb, image_pos);
+binman_sym_declare(ulong, u_boot_dtb, size);
+#endif
+
 /* Define board data structure */
 static struct bd_info bdata __attribute__ ((section(".data")));
 
@@ -412,7 +417,8 @@ static int setup_spl_handoff(void)
 {
 	struct spl_handoff *ho;
 
-	ho = bloblist_ensure(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(struct spl_handoff));
+	ho = bloblist_ensure(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+			     sizeof(struct spl_handoff));
 	if (!ho)
 		return -ENOENT;
 
@@ -429,7 +435,8 @@ static int write_spl_handoff(void)
 	struct spl_handoff *ho;
 	int ret;
 
-	ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(struct spl_handoff));
+	ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+			   sizeof(struct spl_handoff));
 	if (!ho)
 		return -ENOENT;
 	handoff_save_dram(ho);
@@ -446,6 +453,33 @@ static inline int write_spl_handoff(void) { return 0; }
 
 #endif /* HANDOFF */
 
+/**
+ * Write the devicetree for the next phase into the passage
+ *
+ * For now we assume the next phase is U-Boot proper
+ *
+ * @return 0 on success,  -ENOSPC if it is missing and could not be added due to
+ *	lack of space, or -ESPIPE it exists but has the wrong size
+ */
+static int passage_write_dtb(void)
+{
+	if (CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)) {
+		ulong start = binman_sym(ulong, u_boot_dtb, image_pos);
+		ulong size = binman_sym(ulong, u_boot_dtb, size);
+		void *dtb;
+		int ret;
+
+		log_debug("passage: Adding control dtb size %lx\n", size);
+		ret = bloblist_ensure_size(BLOBLISTT_CONTROL_FDT, size, 0,
+					   (void **)&dtb);
+		if (ret)
+			return ret;
+		memcpy(dtb, map_sysmem(start, size), size);
+	}
+
+	return 0;
+}
+
 /**
  * get_bootstage_id() - Get the bootstage ID to emit
  *
@@ -835,6 +869,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			hang();
 		}
 	}
+	if (CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)) {
+		ret = passage_write_dtb();
+		if (ret)
+			printf(PHASE_PROMPT "Write DTB failed (err=%d)\n", ret);
+	}
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_finish();
 		if (ret)
diff --git a/include/spl.h b/include/spl.h
index 7c10c7f792e..4fa97078a31 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -441,6 +441,8 @@ binman_sym_extern(ulong, u_boot_spl_any, image_pos);
 binman_sym_extern(ulong, u_boot_spl_any, size);
 binman_sym_extern(ulong, u_boot_vpl_any, image_pos);
 binman_sym_extern(ulong, u_boot_vpl_any, size);
+binman_sym_extern(ulong, u_boot_dtb, image_pos);
+binman_sym_extern(ulong, u_boot_dtb, size);
 
 /**
  * spl_get_image_pos() - get the image position of the next phase
-- 
2.43.0

