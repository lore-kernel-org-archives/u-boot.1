Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57644C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B0F88CF7;
	Wed, 25 Sep 2024 14:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UunQKA1f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6728488B63; Wed, 25 Sep 2024 14:58:02 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D27488BB6
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so1051475266b.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269072; x=1727873872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsahKmcxnqcrUkA7i6UUMWMT0zqXogCNkuUMjwhHNyA=;
 b=UunQKA1fBROYIAi9KBQJSBioVbKu5kUI5FtrUj0hqcj/uMUeCCzyPUcg+ZtbEOehWG
 HfiwTQWnGnRakFyxDE9wnJv6/U7jMiVDm/DdUnbrBLZ5N/pxvkEMHo6HYfbUPk3VXIG9
 HJH+gMyrcyQMj6sB4m7/g4thbKVKlBXr8vbJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269072; x=1727873872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsahKmcxnqcrUkA7i6UUMWMT0zqXogCNkuUMjwhHNyA=;
 b=PwFXicx4tlglEm51oCSsDTcfP+M/vcYx0lJr97K/YWFH6M1dlxKFvJxsIeAyophpLx
 UDXJAk0I1nXwj3LWVPeyG7u8ekn4/p7xOWXj/Ds2kdZ1MQusUybjX+Y7q0LYBVQ06Oc4
 C8iotMvrspB3OUt91XLFeT5NmdcI8RN0PnA0B+4H/BnLJyuIbgGc6l/TXm35mwuxD1jO
 C2QA/aFBD5EPHY/yGeizv9qelN7JYrK09Is77kuoX/lT+Dz5cxF5SnbwblrLPV69wsn+
 kO8vr61cW4ZHlaiXPhO+n6VIJhBcdFNo8g/DmqynPKt3u2W/TP78KXm/TVHaoKdIKk3/
 wScQ==
X-Gm-Message-State: AOJu0YxgZGkMA1j6iaOCc3jcRU+p3kOxWdg8t9xjDSWC4r3oF54k8d3P
 j7iUqLGwwCdP/nEiQUbVzloRSXoU75O3Wygz40D0/GANMbbrNLKxDOI7Dc++NXTJKoT84xTGiZw
 atA==
X-Google-Smtp-Source: AGHT+IEXcrboOjidNL6DLH2uzp9VsQTyrC8JOc44CsyJdgUVqJ9reAGD47BaA8D9KU1ri4KwxAS4Rg==
X-Received: by 2002:a17:907:f75a:b0:a8d:446a:ded8 with SMTP id
 a640c23a62f3a-a93a03603bfmr254860266b.22.1727269071579; 
 Wed, 25 Sep 2024 05:57:51 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 03/19] spl: Avoid including hash algorithms which are not
 wanted
Date: Wed, 25 Sep 2024 14:55:29 +0200
Message-ID: <20240925125622.197915-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Update the build rule so that hash algorithms are only included in an
SPL build if they are requested. This helps to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 9478257e634..c29d03d4c6e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -76,9 +76,9 @@ obj-$(CONFIG_ECDSA) += ecdsa/
 obj-$(CONFIG_$(SPL_)RSA) += rsa/
 obj-$(CONFIG_HASH) += hash-checksum.o
 obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
-obj-$(CONFIG_$(SPL_)SHA1) += sha1.o
-obj-$(CONFIG_$(SPL_)SHA256) += sha256.o
-obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
+obj-$(CONFIG_$(SPL_TPL_)SHA1) += sha1.o
+obj-$(CONFIG_$(SPL_TPL_)SHA256) += sha256.o
+obj-$(CONFIG_$(SPL_TPL_)SHA512) += sha512.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
 
-- 
2.43.0

