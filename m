Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F6C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0456D80F92;
	Mon, 24 Feb 2025 06:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ii6uK4+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DF680FB1; Mon, 24 Feb 2025 06:56:14 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BCA80F0E
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso114506975ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376571; x=1740981371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EU8psrfLbzt2dQl5HuBeoc1PutDlMP8adIsza6G97gY=;
 b=ii6uK4+HvUxz7gHWALUs6pSzLXDIclVHDjUduo2HVKjLEedPjiEQn6u2P3rPV9sE+e
 VUtHGnekN5suTmAcCjdO16VzxdiRBeYnFMGWh4nQ+q5A4ATVtFfwUQnjbu2NWvAoSJb0
 6mKWtHdjGhiwRXrQc0uYfg9JPtm0LvPo00PnAX4AcfzmCHlkC3At6PPkmWjkOXASOwBI
 vo/dfx/cC/9hUw2rvKh/18mIBFF4BAcItQfDQqZ6YFnnFZKQH/+p2UcM8KAH28ES8aBl
 Y18ye4LT4mENAOOIHK6+DeJTjO5eakEaA5LGIT2aWPo1Dc91b6bLIFyGw/MQGh4NgUvc
 wIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376571; x=1740981371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EU8psrfLbzt2dQl5HuBeoc1PutDlMP8adIsza6G97gY=;
 b=cayZ+rAb6zFDT89QRlpQBG8fy4o1QjYrhPQZm6t56mommj3nDTt/p1rD5puIgNd5xU
 FUWYiIqFaCfJPk2EVjtR77j7luOCymiSPlFdP5VZbnCVHd+PCBkytHEtAWtFoMVy0Mxa
 ZxEmL8XXJDO85psffwPNSIudyglHF8jzRoxnKQZHH3KZw6zP8YOgHR1ZX/zPf0C4ovHz
 JPb0j+iUj1zpHWbltPXAGNjmmcBx7iGrFWGfEeNRTXTUZ43QqyMIM49XCZMI73Ht3kY8
 msK+f6+Gr71La4c72fV/HpKKau26/cD/FIU3B/HmOBvyVWLt1+hb6Jv8XMUaU8sIXkd8
 99nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6x6Xw//ag5zmPCDMXaBbBmMSFHNAW9+Z6w54dYFjjs8BmjvNPc66j69wp4cE/HtHYcyZfMNQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxtUf414zKU3c+O/T3+fUiT4tzzwJWhkktFdeV3CykYdRnXyLNx
 RKh/ZIbRSSvt+RSmRpP4VTXapzhG+7g2AiiCnLtGB73RcnwzSIk1
X-Gm-Gg: ASbGncvmANVz4wMdQzWnfy2MHcums9HM8CAoO2GDCEuDFVXFOn6D42grEr/m3sLSiAj
 enCd9vLeEGWgUzZ0Dazl7eLhOcuGJXu06TWHkHvNSQkBLLXwaltJlXnjmZPEJGfYkrSs5TR4i73
 5ODBu2zLqXb1eX9sJWIvCZCHUxRkEnRkEGubdqC4IRp1i2nPOFj0Thkb/e1JQPd34Z9A0jXJSk0
 COLCSA2E1yiF4nTSKtB++nqy85Zv4ZPxCCNBXjvlR8by9zjOsUKTZRQotHI08TiHTRRAPqSBf00
 pTqh8PDZcOEzn1OoqzYQn4tzNzoWX/6/G9DgEQ==
X-Google-Smtp-Source: AGHT+IHAbojEuikt9toCCAMKpqn8hGSOAANrfsWddVq3PQ8D3CK8YBMszcTwd/WIdzDIic4npGuQXg==
X-Received: by 2002:a05:6a00:464e:b0:725:cfd0:dffa with SMTP id
 d2e1a72fcca58-73426c84362mr16145840b3a.5.1740376571010; 
 Sun, 23 Feb 2025 21:56:11 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:10 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 10/17] spl: Align FDT load address
Date: Sun, 23 Feb 2025 21:55:17 -0800
Message-ID: <20250224055524.1334929-11-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

While the image size is generally a multiple of 8 bytes, this is not
actually guaranteed; some linkers (like LLD) may shave a few bytes off
of the end of output sections if there are no content bytes there. Since
libfdt imposes a hard rule of 8-byte alignment, make the SPL also be
explicit about the alignment when loading the FDT.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 49b4df60560..86506d6905c 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	 * Use the address following the image as target address for the
 	 * device tree.
 	 */
-	image_info.load_addr = spl_image->load_addr + spl_image->size;
+	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
 
 	/* Figure out which device tree the board wants to use */
 	node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);
-- 
2.45.2

