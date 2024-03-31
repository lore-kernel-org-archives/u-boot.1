Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642D2CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035728825C;
	Sun, 31 Mar 2024 23:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/vsk1kE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC66887E50; Sun, 31 Mar 2024 22:03:44 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0FB87F74
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-515d515e28dso1110583e87.0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915422; x=1712520222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SN9H1KWdNsEF/z0kmR2dcyCmCCNFhLM7FXzlMpjzoA=;
 b=j/vsk1kEYAqW2xqzNGhWPoL1Vu1lgQNTxaiYqrxmtyEgRSYx0xlFfZv7nkDvWlBFwX
 smNo6k79teDvB/9lC7poJPXUrxnGBMA8HYSZozjsbmXghCCtm0U4S7ArOSkklbF8xPxx
 csaYA4Jv5GDxIDb8MOGj//mHfSQKvSjvHRAbFmFMU2LFUuNguzEwUYrPDHIiuF1aWkxB
 uJgzU2wxaVp4JGaN4WcEzIakm4C2N1uDQjdsS8rtbnARROtv6V3xv5FTf9e6Hc9X/u37
 WrB1bAp5SuQFHX22hwpFz2bx0Ls+2DBCmUDAqh7+EMioc6FmBuP6Zou0HFAlw0102RlM
 X1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915422; x=1712520222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SN9H1KWdNsEF/z0kmR2dcyCmCCNFhLM7FXzlMpjzoA=;
 b=vHj2tewAgEsj6kAWIY74pWdLEqPQhMBbytcv0nX48QPD9NYb+yH5rNbb/L1yLUSfio
 aw/xp6uoi/PBJUMkAbcR9EB+y9fwgFtHlsrrhhjVMFWnof+m0uv2MNnftKrkAOjfIW1L
 omLRBucb4Kg0m50SD3ZAjmXJruTCjfd5op8W7lkZAO7FqtDkg4wFAIk+TFUJWHHOQMnv
 zycSndWtxqfLj72VvX0EaCOKujug+vzT2pXvXEd+ZQWxf/x2o6wjU3WpBjka7IvH5KLI
 NQMAqyh1rThI4sMsfqtOPzeGxNePoEzE7Shdd9AH2B5uW6AUCkNIK1ih0+08RrmLJeEs
 gmzw==
X-Gm-Message-State: AOJu0YwGGQWGWyQTkARmZ/xmnBUwLYJebAW20SJ355PHBWh1woqbRH9p
 XBxTkC3xMn4PKEJXF9A1VDvINepLvWuBnNIOGgmddnPsY0g37iWr/96HukAC
X-Google-Smtp-Source: AGHT+IHoTxLTErqZFsUAv/+VfqZ4+llAQGLAhuICVCqD7H+7aizDMuhncBXvkmYgklWd83cVZIxP8g==
X-Received: by 2002:a05:6512:48c6:b0:515:cedb:a518 with SMTP id
 er6-20020a05651248c600b00515cedba518mr4517112lfb.16.1711915422161; 
 Sun, 31 Mar 2024 13:03:42 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:41 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 9/9] mcheck: let mcheck_abortfunc_t print the pointer
Date: Sun, 31 Mar 2024 23:03:27 +0300
Message-Id: <20240331200327.29141-10-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>

---

 common/mcheck_core.inc.h | 16 ++++++++--------
 include/mcheck.h         |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/common/mcheck_core.inc.h b/common/mcheck_core.inc.h
index 2f11ac567f..6902140992 100644
--- a/common/mcheck_core.inc.h
+++ b/common/mcheck_core.inc.h
@@ -90,7 +90,7 @@ struct mcheck_hdr {
 	mcheck_canary canary; /* Magic number to check header integrity.  */
 };
 
-static void mcheck_default_abort(enum mcheck_status status)
+static void mcheck_default_abort(enum mcheck_status status, const void *p)
 {
 	const char *msg;
 
@@ -111,7 +111,7 @@ static void mcheck_default_abort(enum mcheck_status status)
 		msg = "bogus mcheck_status, library is buggy\n";
 		break;
 	}
-	printf("\n\nmcheck: %s!!! [%zu]\n\n", msg, mcheck_chunk_count_max);
+	printf("\n\nmcheck: %p:%s!!! [%zu]\n\n", p, msg, mcheck_chunk_count_max);
 }
 
 static mcheck_abortfunc_t mcheck_abortfunc = &mcheck_default_abort;
@@ -124,9 +124,9 @@ static inline size_t allign_size_up(size_t sz, size_t grain)
 #define mcheck_allign_customer_size(SZ) allign_size_up(SZ, sizeof(mcheck_elem))
 #define mcheck_evaluate_memalign_prefix_size(ALIGN) allign_size_up(sizeof(struct mcheck_hdr), ALIGN)
 
-static enum mcheck_status mcheck_OnNok(enum mcheck_status status)
+static enum mcheck_status mcheck_OnNok(enum mcheck_status status, const void *p)
 {
-	(*mcheck_abortfunc)(status);
+	(*mcheck_abortfunc)(status, p);
 	return status;
 }
 
@@ -136,11 +136,11 @@ static enum mcheck_status mcheck_checkhdr(const struct mcheck_hdr *hdr)
 
 	for (i = 0; i < CANARY_DEPTH; ++i)
 		if (hdr->canary.elems[i] == MAGICFREE)
-			return mcheck_OnNok(MCHECK_FREE);
+			return mcheck_OnNok(MCHECK_FREE, hdr + 1);
 
 	for (i = 0; i < CANARY_DEPTH; ++i)
 		if (hdr->canary.elems[i] != MAGICWORD)
-			return mcheck_OnNok(MCHECK_HEAD);
+			return mcheck_OnNok(MCHECK_HEAD, hdr + 1);
 
 	const size_t payload_size = hdr->size;
 	const size_t payload_size_aligned = mcheck_allign_customer_size(payload_size);
@@ -150,13 +150,13 @@ static enum mcheck_status mcheck_checkhdr(const struct mcheck_hdr *hdr)
 
 	for (i = 0; i < padd_size; ++i)
 		if (payload[payload_size + i] != PADDINGFLOOD)
-			return mcheck_OnNok(MCHECK_TAIL);
+			return mcheck_OnNok(MCHECK_TAIL, hdr + 1);
 
 	const mcheck_canary *tail = (const mcheck_canary *)&payload[payload_size_aligned];
 
 	for (i = 0; i < CANARY_DEPTH; ++i)
 		if (tail->elems[i] != MAGICTAIL)
-			return mcheck_OnNok(MCHECK_TAIL);
+			return mcheck_OnNok(MCHECK_TAIL, hdr + 1);
 	return MCHECK_OK;
 }
 
diff --git a/include/mcheck.h b/include/mcheck.h
index f4c9b7e61c..bd506ae629 100644
--- a/include/mcheck.h
+++ b/include/mcheck.h
@@ -29,7 +29,7 @@ enum mcheck_status {
 	MCHECK_TAIL                   /* Memory after the block was clobbered.  */
 };
 
-typedef void (*mcheck_abortfunc_t)(enum mcheck_status);
+typedef void (*mcheck_abortfunc_t)(enum mcheck_status, const void *p);
 
 int mcheck(mcheck_abortfunc_t func);
 
-- 
2.25.1

