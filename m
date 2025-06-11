Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6F2C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442AC82CA0;
	Wed, 11 Jun 2025 22:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lSoiuWzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D186882C8A; Wed, 11 Jun 2025 22:25:07 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D758982B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so1652245e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673505; x=1750278305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOkgineMJ551dyRHxEfGWTNhTaN6wvRV6+TDygMhfB4=;
 b=lSoiuWzWErdYOo6p3kFqyKch3s5uNnRz+LsRbcshiFwhBIEhP47VPGOT/kpYcAxJMI
 DW4WcELZC1Kse55sdQ2XoTSj0qwqWgB0QqBA8V0F5uIrZjH6qs1RrwBexQqjFeVHqin4
 682Go82iWwtkY6ck+StcurlPPqfBIz6WzFbS9D403rh1TyUyKZAPt7UJF7uMJ1B+iMZT
 WSDz9zS3xJUoxzTOiBNF+TlaHW1I4Y/RUIxkF28gGMzvVgu9yzcPtjkoodfrkb6w2b5g
 BphX5lxeM0q2c+J4bE2VDM0Q30T8cAc8TBUWDzvN7OSnT/PhvMI0diRQb0gQzqO7+VBd
 qjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673505; x=1750278305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pOkgineMJ551dyRHxEfGWTNhTaN6wvRV6+TDygMhfB4=;
 b=aQdA49z64Omjr2Se3i70Cr7r3byasncnpnv3vS7UZO1q2GLMCrVAByYnKujTO3ooDh
 VmylNN+M/hAzck4eKnmJ32vlVlU4oiW1zCJXLkcLpGuUuk2rmg1Gshxvb7ahuLwq+Zj0
 I3xT/CNVS6r69kyDZhXHvB5065FQ6vk3VZEW1aapbYBI3v2jnpXx2cMbStfoBooC3wT0
 iP4Xg/j7tsJKXsTsR+UYPPZbWC3cz4LvC3pbzn9tPCyfNrQH5HWCLUGBBZkZ6xc/bkPZ
 YF2apSbf3Ym6JmMLRJ0p7eagtbJew+EX/ILkJsAyZu6Q6YNpCtUWhBh+ceAXD9q5uOni
 siBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk6IyngZ7F80eMcWodnmA+wDuc0tHul4+7cO/Io1VyYj6A/g2yMJyYMilpkWhmYGlZvdbbxIc=@lists.denx.de
X-Gm-Message-State: AOJu0YyHitzkyPnzPfs4dR8DWnzA+Wtbjw8j6dwnxoN8msPsU3/iwXEp
 FFyfuZmYo3VjHDYn7+mFjA2gC/MvIMJzt8kWSwzRgYza6NoDgTJ6RGMQ0xK5RN/uu9Y=
X-Gm-Gg: ASbGnctx1VbwnODU8anqkkIAXIzO8ZuGUe9WfXV1EtmPz340a9oWtB5U8e/YF1I1jbk
 2hvh3b4jvCEzUJcjWJMPa2zyX2uLrWN75bYV0EBzX5bi4An1SI3XsNsl43H7d7YloXgcUVE2Uoc
 hxT85YCy06pMdVr4RybJ73L1cilcqyiUuezjdQAXOpXg+BHd4Xj7UN2QTWP85VDg+F2dGqbkeyd
 ut5gnEuDCmye5Xdcz9Mq3ogWCqkdCgFT7g/S58wS0jRAkNNu0cZrNIVuo8s0LwO+0v8SC4c/BT4
 5jHw1wRFSwdjzSqFIsHCEToHx/5JxUhTs9LwFeAdQmKhrCt4U0OyLbB8jpdqG30mUJxpdJGhbJU
 h0DQQa2A91dMkFZonZez9x5CWJJ7oHM2T0LHn7JH5
X-Google-Smtp-Source: AGHT+IFZyiorv8+9TTDdUBHo3gz36GOHkSevnvI1S3xAs7bObrwn/JUGHoKae/WIkXdtC47J/7eaVw==
X-Received: by 2002:a05:600c:3e84:b0:453:a95:f086 with SMTP id
 5b1f17b1804b1-4532b8c2bd7mr13169305e9.12.1749673505261; 
 Wed, 11 Jun 2025 13:25:05 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:04 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 05/13] kbuild: use -Werror=implicit-... instead of
 -Werror-implicit-...
Date: Wed, 11 Jun 2025 23:24:32 +0300
Message-ID: <20250611202449.2317279-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit b89f25ea7892 ("kbuild: use -Werror=implicit-... instead of -Werror-implicit-..."

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e648f4920cfb..00c0d76e1954 100644
--- a/Makefile
+++ b/Makefile
@@ -437,7 +437,7 @@ KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
 		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
 		   -fno-PIE \
-		   -Werror-implicit-function-declaration -Werror=implicit-int
+		   -Werror=implicit-function-declaration -Werror=implicit-int
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_LDFLAGS  :=
-- 
2.49.0

