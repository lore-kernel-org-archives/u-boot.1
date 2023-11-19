Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0395C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66866870E2;
	Sun, 19 Nov 2023 15:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vs+fDePZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8750187083; Sun, 19 Nov 2023 15:44:00 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F6B86F1A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a694a365d9so166214039f.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405029; x=1701009829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0VHBo+o2V1zIFkHt29Wrg6DAhNj8n9Tc0s+RkSsYOQ=;
 b=Vs+fDePZMUsbPtf289HoVkRUwV0dcJh6FiqqVB8t4MgByMrlNNE/EAL8ZtTPQ+TAYe
 zbH3YaeiD9vzfCuFD2N9bWqNbiU+Bka7l/pPCvIRHaiMyZE511ZELhdIl5jsV/X5HPLR
 BAz/cxbKYWQWYvJ5L32dO8cwuoHX+S2rEZIdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405029; x=1701009829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0VHBo+o2V1zIFkHt29Wrg6DAhNj8n9Tc0s+RkSsYOQ=;
 b=jzp3Irzd7zydlcxbMg9Mg3vV12CnMqDcfFFK0BNjJmB8R9mIJ4IlC5WhmX4j39JHg5
 kDcYryt5fO2CZoKU5uKi3u744eqLQFiicFaUftDJT6GsEM7OaLAytgmcO/Bf4hGc/UnV
 q0rjyF5OtU+Z7KDlj0WP1MymEdAx1OUs7/SI/ZI7Cw1rWFJECOIlKnsNkFsHAil4nV4+
 COloTJcWZAWjrgW+9X3YvADAEU4c/8/GNGtIFJJd36WmD1Mwhjz7lbDFNMoHTKp4Uh2Z
 59SYTx4Agg7LLzTlnjx4bOvaOnuPE8qxKH2GIb6P0SGx+pn9JU0XaQ/Xcju2Gx4fezmv
 37tQ==
X-Gm-Message-State: AOJu0YwrYN07mxDiaz8EiCxtFMMrjEJV6WwtpGCsrZmH+WCrGeR5AXBO
 CtOOg7BTZR8Ny0zzM6xP6ismUIch7OR5vNl+aI+hpg==
X-Google-Smtp-Source: AGHT+IG1ABlq7xDXCA1w2FDZFdqFLO1AJXltAy7nxViaiA3X39OKY2nNUvDc4uBFoGBTBzegtAOxxQ==
X-Received: by 2002:a92:d846:0:b0:35a:d052:da3c with SMTP id
 h6-20020a92d846000000b0035ad052da3cmr4678222ilq.18.1700405029023; 
 Sun, 19 Nov 2023 06:43:49 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a023505000000b00463f8b3e34asm1511196jaa.23.2023.11.19.06.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:43:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 1/4] image: Correct load_bug typo
Date: Sun, 19 Nov 2023 07:43:31 -0700
Message-ID: <20231119074333.v3.1.I33852d11a04a125d8a4fd7938a8eb989454e7fd3@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144338.630138-1-sjg@chromium.org>
References: <20231119144338.630138-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 include/image.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index b89912a50f98..bd2f6c6d9339 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1011,7 +1011,7 @@ int image_decomp_type(const unsigned char *buf, ulong len);
  * @load:	Destination load address in U-Boot memory
  * @image_start Image start address (where we are decompressing from)
  * @type:	OS type (IH_OS_...)
- * @load_bug:	Place to decompress to
+ * @load_buf:	Place to decompress to
  * @image_buf:	Address to decompress from
  * @image_len:	Number of bytes in @image_buf to decompress
  * @unc_len:	Available space for decompression
-- 
2.43.0.rc0.421.g78406f8d94-goog

