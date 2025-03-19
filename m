Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8A8C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FFC820AA;
	Wed, 19 Mar 2025 15:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="amNrSYiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395ED82107; Wed, 19 Mar 2025 15:56:19 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F180820AA
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso34801595e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396176; x=1743000976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yq461gPGdoajYxxdeP0VizcrPrsdkkbAcWgw8wq42K8=;
 b=amNrSYiZePrcaMHCQkm8yuhp+93Hz4lvYVQbpSYqpsrpuT7PODke9HdaCrkERN2Dni
 kfaqSzeCXE54Run+5Qp7BPJ/5ioW8jRIBFJrugQROB/KDnC4HEQ421COAhUuHmfRMvW3
 OEglJ6Fdvq3+KLzMyTMMnkbEU8MNGlZAu8VwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396176; x=1743000976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yq461gPGdoajYxxdeP0VizcrPrsdkkbAcWgw8wq42K8=;
 b=RMxJCt/jYKE3UpckBIbfNM3TMQiSoJ1L5Tzz5cj4GxR6MOXqWG9NwiQDhQwQ/gyd5+
 UyyQHTVRa0mTffiZM38muMpkNQheyyrQ/4u6smIdKS1pab4UkOW5Y81dcpEqGchYMQhk
 bqFRACZ6oj9tq64ltR2D0cny2BPW54ulSxCFBdTuBdCiKocRFy8t0Mw/j5rtdlCSXPAo
 AxGNZjDHono9ggL7Q4fjq/NoS9WzP+Q+Ka9SdJ1r1fmUE8OXHpCIexZxHAHk3hjMb/nW
 XRODi0cGE7qI7BJYERhyng4b2srFUHWqZDBn+BBm0Wd+amUUKNhgmFa6irHttD0rGs8T
 ydfg==
X-Gm-Message-State: AOJu0Yyw6s5IGcdDRus2h0suQzzOgqkpPtB9DqDwQmJSm6IlXbYBp95e
 /tr9EI/AiAOcMTSWCnjdV2PVgAodGslArhQbFT+NFNc07NGjLHnkiu8eUyhcDgm84u5THIaFElQ
 =
X-Gm-Gg: ASbGncsuJoRfTip9/tvHKB07PwDO/v5im/D8xjcUoJZi+w6vJtt+2/sOwkGf5aNC93n
 Y4YR/O6L7Ogb5jnFu0PbPxOzuG+t3qpffwg0+Hi/BmqFExaPJwrAIZfi7l74yTSUMhfRzeDpB+R
 xkA2pbKkTD/cySlK1gzNFbhtq6Ld+7ivOBrXkJGG5akP4xy5WCBupDqDQdj9diFdlVc8pvZbfJK
 i/7tSuCYMzyifLCQVyknDCC3Y8WGIetDgDWKlvBR6hvcYn8XBhtS8iz/O9XR9rnUIh9RdigM2zD
 jaWsLW1M3/eNZ5OAYMJOHAQYExmCsGEMsu9TnJgHyg==
X-Google-Smtp-Source: AGHT+IFxMTXunI55QKhjylJJTDfm3dsfsJyqcZ5UGopRD/FAoqUAo0FdkB4KsPE66rorBV5DQJQb0g==
X-Received: by 2002:a5d:6d8a:0:b0:391:4674:b136 with SMTP id
 ffacd0b85a97d-39973b01f1fmr2329567f8f.29.1742396176118; 
 Wed, 19 Mar 2025 07:56:16 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/52] expo: Use an abuf to hold strings
Date: Wed, 19 Mar 2025 15:54:31 +0100
Message-ID: <20250319145512.2391122-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

It is more convenient to put strings in an abuf so they can easily be
resized. Adjust the struct accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c    | 4 ++--
 include/expo.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index ba052df932c..ee635116abc 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -86,7 +86,7 @@ int expo_str(struct expo *exp, const char *name, uint id, const char *str)
 		return log_msg_ret("obj", -ENOMEM);
 
 	estr->id = resolve_id(exp, id);
-	estr->str = str;
+	abuf_init_const(&estr->buf, str, strlen(str) + 1);
 	list_add_tail(&estr->sibling, &exp->str_head);
 
 	return estr->id;
@@ -98,7 +98,7 @@ const char *expo_get_str(struct expo *exp, uint id)
 
 	list_for_each_entry(estr, &exp->str_head, sibling) {
 		if (estr->id == id)
-			return estr->str;
+			return estr->buf.data;
 	}
 
 	return NULL;
diff --git a/include/expo.h b/include/expo.h
index 84dc77f771e..b6de0310071 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -134,12 +134,12 @@ struct expo {
  * struct expo_string - a string that can be used in an expo
  *
  * @id: ID number of the string
- * @str: String
+ * @buf: String (contains nul terminator)
  * @sibling: Node to link this object to its siblings
  */
 struct expo_string {
 	uint id;
-	const char *str;
+	struct abuf buf;
 	struct list_head sibling;
 };
 
-- 
2.43.0

