Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C838CE7B05
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2338B88D1F;
	Fri,  6 Sep 2024 14:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sjiK+G3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F8388A24; Fri,  6 Sep 2024 14:35:18 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7ACD88D10
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3780c8d689aso1150677f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626116; x=1726230916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OU2VUMRGCTc+MvFx1Y4JV6qJNct5kwe7bvtCsqQAkio=;
 b=sjiK+G3u4NokV/jxs58FBRDQe5I70tJdWgyG/6yaEwH5zStZ6WQ+W4Gfjet1FvWxYF
 lPS2TOS1Ao3E9pd70v5EwzJrHdoZ3nETTWN13OEv6efidfpbgtmnZksOLEhsm4oMrllB
 Q0XQo9YwTge7Zhy/4VFYC/KW3e2yNl+U9vxK0LPZvRdg8b3wXVCxItxvEy2XYfoC/gxm
 dk2lL6Bh4NjoC3ONNk1oC1ZoCx1VvvmTih7hfkASGsqvDJto3Bv4+i759GDAK/HROTqR
 9vKgngWTXV5HqiTB5s0AQJF0YBnV7Z6AxC0M84WUEtp8F+VJll74kagmSeB3bLqgVD1R
 xsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626116; x=1726230916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OU2VUMRGCTc+MvFx1Y4JV6qJNct5kwe7bvtCsqQAkio=;
 b=Jg3/A1kq/AeRvbJCVFCFfvPrYyC9/2GWgAZj0B5Sl5J1uD4fK8FLwgRfAlQif8BiIu
 3Rh7vBtAuymobQdLXbvtR3Ugutcg0xSuE83wmFBbP7nWPyO7A7fJPtcR7R1T+bS/N0mT
 eDIr1QbkwCHzriLEkzC8chqybO8rULef4GVrNRAK3atS9IZK5x03852GkiMkdAn1Pf+k
 1W22fUPov280PjHKR7GOr4VYwpxvHc1sQdN5nRJV9WD9nZamyc/ik4s5og2/YL0DCBZd
 89ET+ZnhBKVyCjb5FXTic/JB2rXV7PdshmuIqBOFdeh/lib17xuDFz7XlVlxR/VyYW4v
 1ujw==
X-Gm-Message-State: AOJu0Yx4FJe0YyBLXy9LN+3k5zT9dEMw6SxT6EL7LHkalU8oerI6450r
 n0Hs3WUJC/rDviUikJNrsjX7K16LZHqTbrb9vnS1vGgwnIaBX5ihNHPRwo41i04a1hCqPl3rQor
 G7Wb0BkdG
X-Google-Smtp-Source: AGHT+IFU2oUXwAYTaFiq0Es0mb5nAxNvZ529gu3x0CULnG8rs+BnLo2JgQC29aGvZ88d//5pOI+6QQ==
X-Received: by 2002:adf:f089:0:b0:374:be28:d808 with SMTP id
 ffacd0b85a97d-378895cafdamr1584996f8f.20.1725626116089; 
 Fri, 06 Sep 2024 05:35:16 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 14/25] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Fri,  6 Sep 2024 14:33:30 +0200
Message-Id: <bbbd941adfa6b4f24ef2d7a15a2556ea4bf868de.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

From: Jonathan Humphreys <j-humphreys@ti.com>

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/wget.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index e8768fc2acd..b495ebd1aa9 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -349,12 +349,6 @@ bool wget_validate_uri(char *uri)
 		ret = false;
 		goto out;
 	}
-	s = strchr(authority, ':');
-	if (s) {
-		log_err("user defined port is not supported\n");
-		ret = false;
-		goto out;
-	}
 
 out:
 	free(str_copy);
-- 
2.40.1

