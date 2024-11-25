Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388CCD58D76
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30518906C;
	Mon, 25 Nov 2024 18:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F+82ia6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B61893E7; Mon, 25 Nov 2024 18:59:06 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C158906C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71d40003870so429357a34.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732557542; x=1733162342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xioWqpO9xXmVVeBEkHKP5SvISe49PxuiOa+L2b2GhNs=;
 b=F+82ia6R7cpk6ubQw0+qWUnZR+hes4JWGugjy4yeT3LLBP1DvDNSh5b0hRCb2z5cfN
 NSwjl8uWvb1eT2p3g/iC/5NuIDTVtCweW05AQvm4YgaVU+Bit4eJXOVM+9kgmpE5tMPy
 UynmFYoA+uvoadEF+wJk7xfhOJfUulRSaaApoZ7u0QbfmqpWK/F5kmLE+cmARGNF6V9W
 CoDIt6OB9ezIFBhGoInDONeg+uny3kHfw5WEGrnXi7Hitir4crE9ziShJzhp/ESzARQA
 bC6MghdAyGyl/7JyFUlJ/Y96DTtNWIzO60WGEoAkZ116ONxHVpVpbzdhrkq2r8Yv/NFd
 qR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732557542; x=1733162342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xioWqpO9xXmVVeBEkHKP5SvISe49PxuiOa+L2b2GhNs=;
 b=rSaJg/LGRJwLpSAFdnKxMefB9IE2oo/2/RW0gIVNN8DaCpUEx3IoPyItfrXfMUkHv3
 nXeY9CaznnCtGx1aXzcgNZjiyhpEsOEBTu6wOCqZqA82W7QKuEaD+hzfR2uYBj+18FnJ
 uNSI4PcQ8e1yEFgRaWz0H9ZL9/EDcx0097472ZtoxpU2K4eY0tE+yW2Cs+aDkTeXn8+w
 Biboj4cDEkJaWbKT9uGcLqFeprSXInqxTtG9kASngNkC/GSIAgsQoj7+XAm6FqIzShqu
 MtOtgFeZCsj8k/o8Bqc1VY4f6CVce2RX1V3A02njNhnefnK5mskbVYL3DZLQvHnYnDCb
 aKYw==
X-Gm-Message-State: AOJu0Yzk07G9a1f6SdQfPLdPNXSpic06vyB42FZUms8wOtjRA5HhD1HO
 ZHJb5oYBH/u/p1CFqLcJ84+dmRl6ETK4F3rmTtcZstxNt22Cp/7DVfI68eVFG1s=
X-Gm-Gg: ASbGncvRjAT12tVULQdTeenKQOl7+O4C6ku7FPhwaKL9UzF2b9oT2MNQHX7EhvfLQaX
 rGyBF/+MZZkIBoUuSsgNdlYXp1mA3Y3oMOm/iJTQF7fxca5VeqG/OWcV6nJ/dDNUsqrznV5t8ld
 okD6cpCNE8lk6IcwSpy5kGdtqHW/xKs2LNcBLt74rDAOFxUowRLShm4nC0tzcJo1xWrT4EdXFpK
 oYerxXl28COg0fZQl/wt9aBG+kmHFNG9AB/M1eYsenB
X-Google-Smtp-Source: AGHT+IERQh5GDitzIBwAQNLxTT9X7iP4sK3O4GrOrDWwxwZ9qGHw+Tj8owbkA+x99OD7DIfelcY7kg==
X-Received: by 2002:a05:6830:390a:b0:718:19a9:434d with SMTP id
 46e09a7af769-71c04b733e4mr12336920a34.1.1732557542474; 
 Mon, 25 Nov 2024 09:59:02 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc3f450esm6939664a12.69.2024.11.25.09.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:59:02 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] net-lwip: zero terminate string with headers in
 wget_lwip_fill_info()
Date: Mon, 25 Nov 2024 14:58:49 -0300
Message-ID: <20241125175849.316876-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

    This patch comes as a companion to the same patch but for the legacy
    net stack. Commit 1327c2a8d6 ("net/lwip: wget: integrate struct wget_info
    into wget code") introduced function wget_fill_info() which retrieves
    the headers from the HTTP server response. As we want to parse the
    string in later patches we need to ensure that it is NUL terminated.

    We must further check that wget_info->headers in not NULL.
    Otherwise a crash occurs.

Fixes: 1327c2a8d6 ("net/lwip: wget: integrate struct wget_info into wget code")
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/lwip/wget.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 53c3b169e0..15cf4e25bd 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -36,8 +36,13 @@ struct wget_ctx {
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
 {
-	if (wget_info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
-		pbuf_copy_partial(hdr, (void *)wget_info->headers, hdr_len, 0);
+	if (wget_info->headers) {
+		if (wget_info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
+			pbuf_copy_partial(hdr, (void *)wget_info->headers, hdr_len, 0);
+		else
+			hdr_len = 0;
+		wget_info->headers[hdr_len] = 0;
+	}
 	wget_info->hdr_cont_len = (u32)hdr_cont_len;
 }
 
-- 
2.43.0

