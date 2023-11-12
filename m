Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4856CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BD586FD0;
	Sun, 12 Nov 2023 04:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NFpxONxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC3A87036; Sun, 12 Nov 2023 04:50:42 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E1B86FD0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a6889f33b9so122643039f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699761017; x=1700365817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysjorctiarNq4DRZGkkRDIYELDp3D4i4OTNDl6MR+dc=;
 b=NFpxONxiIWEqsZU5Qob4lwScfdcfmQ6ga62v015ry7t1nTtWIfeAVlTslsBNDiqS3s
 jZf4Lx+Io0LlDQG6I8lo3tw4UOZmmdpnErYCncKLInw/jYjZNuTx5C+7M06IoN4LzGCB
 J256l8ZsyHlTKn1XX2FTgWbkfiumojZ3LByyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699761017; x=1700365817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysjorctiarNq4DRZGkkRDIYELDp3D4i4OTNDl6MR+dc=;
 b=jaZv02srl/rBDZAoP2KkAP5awkM/EeYHh9BONL8yj9lH1Vp0xcsaMVqpjvPr1sh6sP
 4NJ1QmUAbqFG2l1bGqCqxA2ty0a7Kc/6cZ3WKdkweokhPDcA6adwuCgNrqDPKgY5QuA/
 u2FSbef+wYRLR039uhbLW9+V3FsQiuSUxlrwhb+zMZ7XiPzNFNxWbW37kk4ssb959+9s
 owiDxYku/gfO9H4Wso3O7/ZIBij9Te4sqe6VJHF5e/UorB3va+3nKOUXAb9W/JHS4c/F
 /3k7D6kFWwKY0eDrKjmO5advUaoF/WIMFW6mO1mogfBOkQrhAmNAyndAvHISjMfeU+Zv
 wNFA==
X-Gm-Message-State: AOJu0Yyn+K0Wbw9LpqfdQXfJbzOyb7huVwxjnvlUpPAsLkLAswA0+hyx
 TcuIEJ1/EX3wFDL/aKzuBB2I0c6NW1rbF6iJe5Jehw==
X-Google-Smtp-Source: AGHT+IFBA9Bi97VYdxF8KHIrMcaM+fhep683H3zyO673314bE4yPt5n5GEArWOXTC4eXsU8g7L5RYg==
X-Received: by 2002:a05:6602:2a49:b0:7a9:8dfb:3ed0 with SMTP id
 k9-20020a0566022a4900b007a98dfb3ed0mr5090238iov.14.1699761017315; 
 Sat, 11 Nov 2023 19:50:17 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056602305000b007791e286fdbsm817864ioy.21.2023.11.11.19.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 19:50:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 1/5] image: Correct load_bug typo
Date: Sat, 11 Nov 2023 20:49:53 -0700
Message-ID: <20231111204954.v2.1.I33852d11a04a125d8a4fd7938a8eb989454e7fd3@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112035001.103897-1-sjg@chromium.org>
References: <20231112035001.103897-1-sjg@chromium.org>
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

Correct a typo in the function comment for image_decomp().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/image.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index 2e3cf839ee36..0fe67852c563 100644
--- a/include/image.h
+++ b/include/image.h
@@ -936,7 +936,7 @@ int image_decomp_type(const unsigned char *buf, ulong len);
  * @load:	Destination load address in U-Boot memory
  * @image_start Image start address (where we are decompressing from)
  * @type:	OS type (IH_OS_...)
- * @load_bug:	Place to decompress to
+ * @load_buf:	Place to decompress to
  * @image_buf:	Address to decompress from
  * @image_len:	Number of bytes in @image_buf to decompress
  * @unc_len:	Available space for decompression
-- 
2.42.0.869.gea05f2083d-goog

