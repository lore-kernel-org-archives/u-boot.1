Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C11DC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037BC86582;
	Wed, 30 Aug 2023 20:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DVWKQq2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA60586567; Wed, 30 Aug 2023 20:06:24 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A322186545
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7927f241772so2100139f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418763; x=1694023563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG7w/phqv71NR6IypRiY2OYYAf2MeThoFN5TMsorrQU=;
 b=DVWKQq2/LVf91liKh0lM67Tx9aLkzd+FOTdxOyuRlwcYYIx6YGLWOtGp6J7Zm4CWWX
 JkaUxkpRuEH5Q9/PXUQsGLfE1Cb9esXxBbfXa4b8e7+/oFIc4oFDnepHBFK0hqRlvtDD
 fhf4BFew5A49seOturgwKwh+sxrYMF3Dw48nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418763; x=1694023563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cG7w/phqv71NR6IypRiY2OYYAf2MeThoFN5TMsorrQU=;
 b=TuCK6Ap5vkMcakibjV1vygkINuQdtb9FgFuAjv2ErAD3rzZz7MM15AplPc3XhzssWD
 8WQ3XDYz7/J47rooY+FbA8xV51TGAwIT54CuuO2lodnm8PF44VJwwuwa9VN3obqUqg8T
 4OeahfVmzT/L2kRMvsOTKO1JNSZQ3crXAO3VfhUzDEfogF7PGUs+joarc0wHfrrFhHhX
 hjb0kA0ZuzuWtsZaTRb3jHbgwWIzd/uoNs90c4huZmIuklrD/jts5AWZxBGIEVWXnQeo
 clcPilshm7nLrl1Il54VNEW481gnbya814zxwoLCF/nmg23s44dXqyvey5lMJgTLyfqi
 cKkw==
X-Gm-Message-State: AOJu0YxF49/8qDOIFTc6GCY/pL+DMuXHtR3UWshPF/JhPcty+Yj8ByvH
 3B3t8IT/Csh/s3IcikIcuRJiOKu+Fp7hpFWUXXk=
X-Google-Smtp-Source: AGHT+IE1DvhGjxszIrDtoPIf5azugQsERSybq+oReNPE+aSu4zUlfoVEzCKxGtIHyHCbTPB3B/f3pg==
X-Received: by 2002:a6b:f213:0:b0:792:4994:d1bf with SMTP id
 q19-20020a6bf213000000b007924994d1bfmr3270501ioh.9.1693418763330; 
 Wed, 30 Aug 2023 11:06:03 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:06:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Ovidiu Panait <ovpanait@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Shiji Yang <yangshiji66@outlook.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 29/32] bloblist: Support initing from multiple places
Date: Wed, 30 Aug 2023 12:05:00 -0600
Message-ID: <20230830180524.315916-30-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 common/bloblist.c                 | 13 ++++++++++++-
 common/board_f.c                  |  4 +---
 include/asm-generic/global_data.h |  4 ++++
 include/bloblist.h                | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2144b10e1d0..6f2a4577708 100644
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
index 2f986d9b289..76ae415487d 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -853,9 +853,7 @@ static const init_fnc_t init_sequence_f[] = {
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
index edf9ff6823f..b0485f3dd2a 100644
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
index 7ea72c6bd46..080cc46a126 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

