Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEBFE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A858060C;
	Wed,  1 Jan 2025 23:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aYFuLA1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4336480433; Wed,  1 Jan 2025 23:13:04 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6C98039B
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so101198885ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769580; x=1736374380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBx4QDQztrewJuM//K62hFhsDlNZffv1gs+6ahd+tp0=;
 b=aYFuLA1++DWm+MSn4mpwiNoKxeo8DvqaF/ASx3LWeQqDZQK5AAO52P4g9AkDLqmshG
 Dajn40MU/CFlBGhMpQtBQdcxz3oRYmJEqcxqUdlEj70XHq7L1ZfXRuymkJtul9UPWU9x
 TdNmALwH42xNY6TmTeEP3vHjj6JkeusE5oZx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769580; x=1736374380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBx4QDQztrewJuM//K62hFhsDlNZffv1gs+6ahd+tp0=;
 b=iIGFaXwucEb9EwDqUJFKj4HeU3PbLlWtT1mw2brS19+ncycin+xhZQL21AR1vndaA9
 Mu0KsUXtUPYXlZA+ojRXUem14fWUjBcNZAqih7MIk5W1U8hp3Wp3jwlIRfM6EYVsFrSI
 9n1NrdMdpCs36LN565OQMf+4Ns7MKoU0Dle19NNjcI+tzZQH/etEpt1VRCvSu8fV01H+
 a2jfz0Us5DfXNAhMcGJcuMHhtflktpwzN/0xLD9jhYgnZfK8z+FyPMneVzaAdiVk/xn1
 U9gKHKPhp5neeaStLP6V1wlRM47JWYdVIcqa6Vf1McJGK2bYgwVQuYWS6gCocZHiGpgU
 QOqg==
X-Gm-Message-State: AOJu0YwagHztk9PEgidYR1mQ+G7ljW5JcLn07ktYb7qFDCj6y+a9gaTJ
 1BefPJqNWRn4ZvgA/l9UusikT+2Atgg6ojqhUj9M6G1hYSp0EjkM4Gi6e99tur8zxibBcNu89G0
 =
X-Gm-Gg: ASbGncvuI2LIk+96HNQHDTnCdvTt3tFxAdzxupXazZp6iHECiVtw8RcSocPViEUKi8F
 60uUxtCXrmNm2ImeXbU4E6D+BtJdx3PITebeFhmJWhBfcoVs7pEmWCD0suvsdOImUTt5pXa6FdJ
 +3tjbefmLI6MTjFbvIImSPngJ3giubscl9gKuerkJB3VPwgAAIdAb2NlrC3gxj5Kdgqmys6K0uZ
 olUgl3lqXW8zzefIQIA1f6HG22IamYOgA+M03lTMNmlSzxfAzmNU3Y=
X-Google-Smtp-Source: AGHT+IHLT6OCm5wU0dyeJDV4It8LVbZyUNsnOpkyZ+4v4jm2h3NFKdG5z11Z18p/OsiZEtqDhxusXQ==
X-Received: by 2002:a05:6a00:4098:b0:725:c8ea:b30a with SMTP id
 d2e1a72fcca58-72abde2ab0emr63645904b3a.14.1735769580023; 
 Wed, 01 Jan 2025 14:13:00 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/67] upl: Update add_upl_memmap() to use write_mem_node()
Date: Thu,  2 Jan 2025 11:09:09 +1300
Message-ID: <20250101221003.1944600-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Use this new helper function to simplify add_upl_memmap()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 6e9f67f686f..3f38d533c4a 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -382,31 +382,17 @@ static int add_upl_memmap(const struct upl *upl, ofnode root)
 	for (i = 0; i < upl->memmap.count; i++) {
 		const struct upl_memmap *memmap = alist_get(&upl->memmap, i,
 							struct upl_memmap);
-		char buf[memmap->region.count * sizeof(64) * 2];
-		const struct memregion *first;
-		char name[26];
-		int ret, len;
 		ofnode node;
 
-		if (!memmap->region.count) {
-			log_debug("Memory %d has no regions\n", i);
-			return log_msg_ret("reg", -EINVAL);
-		}
-		first = alist_get(&memmap->region, 0, struct memregion);
-		sprintf(name, "%s@0x%lx", memmap->name, first->base);
-		ret = ofnode_add_subnode(mem_node, name, &node);
+		ret = write_mem_node(upl, mem_node, &memmap->region,
+				     memmap->name, &node);
 		if (ret)
-			return log_msg_ret("memmap", ret);
-
-		len = buffer_addr_size(upl, buf, sizeof(buf),
-				       memmap->region.count, &memmap->region);
-		if (len < 0)
-			return log_msg_ret("buf", len);
-		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
-		if (!ret && memmap->usage)
+			return log_msg_ret("umm", ret);
+		if (memmap->usage) {
 			ret = ofnode_write_bitmask(node, UPLP_USAGE,
 						   usage_names,
 						   UPLUS_COUNT, memmap->usage);
+		}
 		if (ret)
 			return log_msg_ret("lst", ret);
 	}
-- 
2.43.0

