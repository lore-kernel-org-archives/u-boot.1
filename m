Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F26ACE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDAB86B9A;
	Sun, 24 Sep 2023 21:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hcFaAXmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1414186BE8; Sun, 24 Sep 2023 21:26:32 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C972786B0C
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fa4ff8220so121479839f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583579; x=1696188379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYooxzpY3pEz/TLNamvqAhzCCwwJpS1EqvyREh3xC8U=;
 b=hcFaAXmQmUbydsEBeM2M/bjO9w9j0RvR9cfoBunRWDmP5+Y2N5CLld8Vyg0b+3NRVb
 ArTn9D71+Ybt4GSDstQXplGOC6GPgjQ8D0xn5n7jFlSB6TWeu0CrlImnEoOXtpkiPW6Q
 QfhXX1wBUcCxehv6XW56BSqgZiUcBZJq1qoXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583579; x=1696188379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYooxzpY3pEz/TLNamvqAhzCCwwJpS1EqvyREh3xC8U=;
 b=Duif2eCmEHhBqxwbetLHBsaOxjo9rzqlJ8Z6g0OH1CKScBDSwLm4aG7FiqGQgtIGvW
 GA+U3L5iO9GgMZgBHG4v4cJ6bRnkYa5vop9cMhYug1K7O9TEFWujBrieiVcneX8CvIC+
 sGB2DGKsabPQntZmA0IvLW2PrO/QtCIH/RSHYruHurxNQUMvShtmuMM931TwtmNqVs0v
 3p7+HxnOFJJ0LbpiVbd7YoGLj2Z8+4dEyLoU0L4r3HngKu9H9Xp0aFcZEzsKX2C/WJjL
 zsa/on8oer5SgOcJqKC/6CnhVChSEtGz5fI8afAIjgeQEd/oBXxjOG4bAlFWEaaZAKqo
 8q5w==
X-Gm-Message-State: AOJu0YwEVSC42AQLRKnR4y/WD4cC58HJC2bRBB5J5v4pJNsYhYclEAVr
 Kag1yzO7HRN9k/HZ5EB0/840Swm1/BYqRqP7RDc=
X-Google-Smtp-Source: AGHT+IGS7q9B+mSuTEpqqv5Aq1WYulikSNIaTzPWcCmqTJszcDHJ2JYMAa1XOAmfEpOivmgfWvUVjg==
X-Received: by 2002:a5d:9ad0:0:b0:79f:9edb:6e2d with SMTP id
 x16-20020a5d9ad0000000b0079f9edb6e2dmr6874086ion.18.1695583579490; 
 Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Ovidiu Panait <ovpanait@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Shiji Yang <yangshiji66@outlook.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v3 35/38] bloblist: Support initing from multiple places
Date: Sun, 24 Sep 2023 13:25:20 -0600
Message-ID: <20230924192536.1812799-36-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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
index 99c2a43c1961..d4d7d01f8f6e 100644
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
index 937fb12516c1..e8c6412e3f8d 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -693,6 +693,10 @@ enum gd_flags {
 	 * the memory used to holds its tables has been mapped out.
 	 */
 	GD_FLG_DM_DEAD = 0x400000,
+	/**
+	 * @GD_FLG_BLOBLIST_READY: bloblist is ready for use
+	 */
+	GD_FLG_BLOBLIST_READY = 0x800000,
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

