Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F35EE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA4A86E5E;
	Tue, 26 Sep 2023 16:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q7mwTrhI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90E1486D90; Tue, 26 Sep 2023 16:16:11 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A5F86DA4
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3512b425662so19463265ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737760; x=1696342560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYooxzpY3pEz/TLNamvqAhzCCwwJpS1EqvyREh3xC8U=;
 b=Q7mwTrhIzbfSSkRTVmH+3m+csE7rgYcTUlAN0lCpDXIkjcthYBjA6TvshGy/tsXGgS
 JigSlsl5wDHTCZk79r3/2OavDjov/TYzanEbZ0TOntb+OxkP0FpHa1/htVNIX9thfNWQ
 KW5tm2JU3a3WxlN/VwOqva558bXjlkNEUx8x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737760; x=1696342560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYooxzpY3pEz/TLNamvqAhzCCwwJpS1EqvyREh3xC8U=;
 b=Pu8Ccq2TtSb1MDk2LjU5qQaTFbBjFOo/l92+RWR03Liz1Ku7e21RgbxyGNQsl8S0Sl
 KeDK4D1kf+Anpvb0a+C5yYFa65fQbH3kUA6p8zXPEXhms9+H3wD85TUyWiBO2I3ebwGQ
 mU5xcTTRFrqyOnwsdg/c5jYmo7a+GKImTuagQHp2pnsOZ8F5QtXk0HjGT3eDQK8VPxpx
 owzprsba2/iBqynogqH1oZ4Xcikh6R6NJ4WrkxgzdtmXSwisTtFUlQV/29I1JJQ3vJ6Q
 fz5Pom1DTT7ukC+q25NXNBnPqgtzynlHIrAUISbQ73XfZz3xCM04CNzNMiAMwTOinp0u
 GSkQ==
X-Gm-Message-State: AOJu0Yx1cWHQQAcqHeU4bn55Yuxexuq7Coef1aXSVtWyO/8ZmHEtGfiO
 2lLw5ClvRXZ/z9Pjfqrl4l6hnMWbPujEFg+GeM4=
X-Google-Smtp-Source: AGHT+IEGN5XelVZ4rRGMt2J4dkSmOWwE2WvaCgIBOKzIjlR17MnTi//x9ENIda5Bjg3yd3FQyuvkuQ==
X-Received: by 2002:a05:6e02:1d9b:b0:34b:ad80:61c1 with SMTP id
 h27-20020a056e021d9b00b0034bad8061c1mr14333777ila.26.1695737760579; 
 Tue, 26 Sep 2023 07:16:00 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 37/44] bloblist: Support initing from multiple places
Date: Tue, 26 Sep 2023 08:14:51 -0600
Message-ID: <20230926141514.2101787-38-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

