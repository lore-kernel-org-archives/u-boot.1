Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D747CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9488486D42;
	Thu, 21 Sep 2023 03:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eQw+YliN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B2186ACF; Thu, 21 Sep 2023 03:58:27 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA1886D4B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4510182fe69so232693137.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261495; x=1695866295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeXHMpzReSeTWWjHrSSKjIvzdzY8nx8L3trIc6xmco4=;
 b=eQw+YliNAx1YlTRzjjOpj+t2vYS9PonEVhok8b5HHtPgFL8jxGRXyjZRiYxohHryNy
 6HUS1Tf7n9yn1mivNAo22RZkcJ3uz2Fa/7h6BuUYyCg18sFFjzdjeVBIZcHUdRqXOk41
 yJ3TELr6IdzfTn9QLLqIRfa8FZcUZs4sTbxqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261495; x=1695866295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeXHMpzReSeTWWjHrSSKjIvzdzY8nx8L3trIc6xmco4=;
 b=B7K22hN7VSyw64SFpnoE7XlVV0LE1V57eXRf8QThDiCjGrO78FYzxDbcXN+/MSOYW7
 vadG8OHayHNmsOfjVX+kQCsjmHoLpxkHRMOREEiI6cTLmaNfVvCkoqVEnaMI407VIZts
 vbI5ovj/7lUk7wzMvuum5a5jviTJbL2gsLI2a5qtWg/3wP5WaFrimo7xdkQcvNv+jKw0
 C6yMgrMQX27sfgkQ65t4ZtNARE093C6ZSOtwHwKKhEMCTM5p1xT/cufayPAnFePF1h40
 tLSHLXzvhhcxg++TeRJCaeyTUFbv6Pyg8uPNMvgNVFoJ4lE1/mXqFNsOLV5GO7VChmLt
 A7hw==
X-Gm-Message-State: AOJu0Ywx7rBLdkIP9Xc4i7/Sl7Fr66Vb1Cnsty6y+etbmRcLVGOvdVMY
 P62JnzJ8rLA6pFK1zjyihv8K4YcY5rukNaXLSWc=
X-Google-Smtp-Source: AGHT+IEjrgHtOmE0iR2t0u3P3P1WGwpMQ38qz3noU3c/Hc8KudIn9SuFvvBbM+YglCAskWePTOGM2w==
X-Received: by 2002:a67:f747:0:b0:44d:506c:b9c8 with SMTP id
 w7-20020a67f747000000b0044d506cb9c8mr4094799vso.26.1695261495399; 
 Wed, 20 Sep 2023 18:58:15 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Ovidiu Panait <ovpanait@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Shiji Yang <yangshiji66@outlook.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v2 29/32] bloblist: Support initing from multiple places
Date: Wed, 20 Sep 2023 19:57:18 -0600
Message-ID: <20230921015730.1511373-30-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Typically the bloblist is set up after the devicetree is present. This
makes sense because bloblist may use malloc() to allocate the space it
needs.

However sometimes the devicetree itself may be present in the bloblist.
In that case it is at a known location in memory so we can init the
bloblist very early, before devicetree.

Add a flag to indicate whether the bloblist has been inited. Add a
function to init it only if needed. Use that in the init sequence.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/bloblist.c                 | 13 ++++++++++++-
 common/board_f.c                  |  4 +---
 include/asm-generic/global_data.h |  4 ++++
 include/bloblist.h                | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2144b10e1d04..6f2a4577708d 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -476,6 +476,17 @@ int bloblist_init(void)
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
 	}
+	if (ret)
+		return log_msg_ret("ini", ret);
+	gd->flags |= GD_FLG_BLOBLIST_READY;
+
+	return 0;
+}
 
-	return ret;
+int bloblist_maybe_init(void)
+{
+	if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLOBLIST_READY))
+		return bloblist_init();
+
+	return 0;
 }
diff --git a/common/board_f.c b/common/board_f.c
index aef395b1354e..244b0c5685e7 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -841,9 +841,7 @@ static const init_fnc_t init_sequence_f[] = {
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
-#ifdef CONFIG_BLOBLIST
-	bloblist_init,
-#endif
+	bloblist_maybe_init,
 	setup_spl_handoff,
 #if defined(CONFIG_CONSOLE_RECORD_INIT_F)
 	console_record_init,
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index edf9ff6823f2..b0485f3dd2a3 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -674,6 +674,10 @@ enum gd_flags {
 	 * @GD_FLG_OF_TAG_MIGRATE: Device tree has old u-boot,dm- tags
 	 */
 	GD_FLG_OF_TAG_MIGRATE = 0x200000,
+	/**
+	 * @GD_FLG_BLOBLIST_READY: bloblist is ready for use
+	 */
+	GD_FLG_BLOBLIST_READY = 0x400000,
 };
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/bloblist.h b/include/bloblist.h
index 7ea72c6bd46d..080cc46a1266 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -413,8 +413,26 @@ void bloblist_reloc(void *to, uint to_size, void *from, uint from_size);
  * standard passage. The size is detected automatically so CONFIG_BLOBLIST_SIZE
  * can be 0.
  *
+ * Sets GD_FLG_BLOBLIST_READY in global_data flags on success
+ *
  * Return: 0 if OK, -ve on error
  */
 int bloblist_init(void);
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
+/**
+ * bloblist_maybe_init() - Init the bloblist system if not already done
+ *
+ * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not et
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int bloblist_maybe_init(void);
+#else
+static inline int bloblist_maybe_init(void)
+{
+	return 0;
+}
+#endif /* BLOBLIST */
+
 #endif /* __BLOBLIST_H */
-- 
2.42.0.515.g380fc7ccd1-goog

