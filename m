Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A24C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CBC81DF6;
	Fri, 28 Mar 2025 16:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z4HN2zsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1531881FC8; Fri, 28 Mar 2025 16:36:27 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EDD809A5
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d450154245so18586785ab.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176180; x=1743780980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD28WeKVfM78jO9PF7WpE7MXq2c5jHpukpElrSf/MFw=;
 b=Z4HN2zsZ/+10pMlcCTXnChuVXSL6QQ6XcgRRLfKkz/P95Qk9nnen7mSujtxFAVTOTC
 GBsWbaU4xzKIZk0A74mCkggcesWosrNxDTkUDB8JfVE0ZIzMf28kRHw13kz4CS8BHnh0
 /KFVAnUH8aAIO9rRx5jPqMj+rlj1zHxIvyRwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176180; x=1743780980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD28WeKVfM78jO9PF7WpE7MXq2c5jHpukpElrSf/MFw=;
 b=L4mFstQxnVH2/w6b5EaoL9oU8IJ7N8Vi2Jda/pWJEQopRpb2ICyGE0pjfYwLSfq0VH
 8JlWKZtVswePuILxWjdWQPnzLSY3giIq2uMRgqqIfVdNbHtD2cOu99MzjUJrVYF3/tFa
 9AEfL6JIdPnJqTXDwunFJLA+4wuJZOB/GO3i1hMfu6ZlgSt5subIkYowZw8bfkyYF0ir
 wv9Qr9x5fSsbghKFw5xuEyDSNcGOsmXKNdzkNaR69YZvui98tWgAc/ghEtl8asmk4voO
 gjENe9Yt8hDTqTtzEuJYlGiKyV13nuIxzSFWL7PEuzs09hjtxo0ht8gqmYIW+zkQJiU7
 jOTg==
X-Gm-Message-State: AOJu0YzVyaP332ghf0Pb6y5ZDnOC2iR5TlgpG7OJL1O+sbbBsJ2b0lwM
 wvuiIRuh39AbqRUVpWThNsqCbAmHGi/5x1iWPyfJc3T7DXgbd6qJWN7Rf/H5CeXAsXP65XTcleA
 =
X-Gm-Gg: ASbGncunBeavzp/MkiBov5uNBj+ztPzvjgzfHIg7yXXhjgdrX5SObzYT4Q2GK1AM4A7
 Xhtl+aUuLdJSPQs5kdcC6MCPKeF5FEoA2lMEasGEQw3g4Ih+fjmwOip9rLNf4bnYiXxA1nrGYso
 TaVt1EirRv5xxDaAJ5kA2mSzaitUeCj+V/d7J6E0wocDv0D8Pf8y9nLIZx+ojisflc+h36ie06H
 +3lWRxQVoTdzt9sy6C/3sfX0/oSEfwEn2X+TMQ2MaewEkX9bxm1JgRM1ym0Mzhis/UQP6tAoFeC
 va58mJJqrGVg4K1OzqrL3T3OAWAsBftPIh0hCVsS+TGV4WZy60ZkWd39BMFjbQwh4L6z0DTP7ns
 BJQPJdA==
X-Google-Smtp-Source: AGHT+IHqTgfwKcUJaIVHM9KUg8bRr8eW7Xi87yFYGz/2lbD3FBqbG3Fa4uirJENpnwIVQ7atHGM57A==
X-Received: by 2002:a05:6e02:1948:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3d5ccdc6d9amr97783965ab.2.1743176180106; 
 Fri, 28 Mar 2025 08:36:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 20/31] rockchip: Add symbols for spl_reloc
Date: Fri, 28 Mar 2025 09:35:00 -0600
Message-ID: <20250328153522.3555472-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Add various symbols so that this feature works as intended. This allows
xPL to copy the relocating-jump code up to the top of memory, then use
it to decompress and start the next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 958a1b70aef..842bd4eb07f 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -25,10 +25,21 @@ SECTIONS
 	__image_copy_start = ADDR(.text);
 	.text : {
 		. = ALIGN(8);
+		__image_copy_start = .;
 		CPUDIR/start.o (.text*)
+
+		/* put relocation code all together */
+		//. = . + 0xc0;
+		_rcode_start = .;
+		*(.text.rcode)
+		*(.text.rdata)
+		_rcode_end = .;
+
 		*(.text*)
 	}
 
+	_rcode_size = _rcode_end - _rcode_start;
+
 	.rodata : {
 		. = ALIGN(8);
 		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
@@ -48,6 +59,7 @@ SECTIONS
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
+	__image_copy_end = .;
 
 	.bss ALIGN(8) : {
 		__bss_start = .;
@@ -55,6 +67,7 @@ SECTIONS
 		. = ALIGN(8);
 		__bss_end = .;
 	}
+	__bss_size = __bss_end - __bss_start;
 
 	/DISCARD/ : { *(.dynsym) }
 	/DISCARD/ : { *(.dynstr*) }
-- 
2.43.0

