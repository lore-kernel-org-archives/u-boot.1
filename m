Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1816FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D46CC88E5A;
	Sat, 14 Sep 2024 03:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kCB7B/ND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781A788706; Fri, 13 Sep 2024 18:15:29 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75822887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c351809a80so17120946d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244126; x=1726848926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsxNQwVIKqre0Dk0fy7j/CQPrmcf7JFu+880fhTDl4k=;
 b=kCB7B/ND33+wAjucGTFcsJxmm/cM4XKE3FqbFLzJKas7Ydo3bzsxszaXemkcMx4b5v
 fkiYB3GPiW5DZbqrzXXWOSKyZY2xLyciSKcVGwMsCEzEKwfScARezL0svLBSm+3Xx1n/
 wrINGKiPS7JveHZACiDfKhF2r0ibB+9hLnC5dscePY8iiHu0WYLgW8KSvXvP7ewV7Woq
 XIZpuKgnUwlv+MQGw2GeSgEKkwC1e0FElAwvVBVmG+oOaUXyYaFpD+nZC/q4TA9knKVQ
 LGup2zMH6AjTKrfWDQfuT26+TFGSAzW9yIRLWQQT32nF7vHelG/diDVtDeugZEJpQcho
 hv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244126; x=1726848926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsxNQwVIKqre0Dk0fy7j/CQPrmcf7JFu+880fhTDl4k=;
 b=ncozxDuLgkQjlhFZ9vguzFPT3ENuZTmQK15zK2LeYqzVO9fSl+MIP/NQDYVJBDomE2
 2qHIpdU6G7LmJ7BKOeTfipXRpbDQiPtM2HM75BIVfr4f+MDh5miMTYEyS/uxWbyPul2b
 rJbBMP1iYYTVycTlBzfSvTBrls4q3ZJwEvu+HbKNXeM8phgBahWypIsjWRvcx1K8J4sC
 W/Ue8wz3KEjFGmtcEekpq6dDQ7xeRkrMR1kLz/ndKvMsAa1miXZouQKTN9+elAdVbBif
 x2CffDQPB3YnCWf6qB8hNh/hRzzuGCzxU64cZt/Xz0gWqsRec+GB4qyGjhlywdQ2W3at
 w9+Q==
X-Gm-Message-State: AOJu0YwVFTHPSjeKMhMUXTwZ/+ZSvP5tTkw/i72svUcmLA92EjXTbIAw
 h0w/BGyqpM9ti0IlWnMKgJT8ZqG0wGImj7u0Hf7P3BVbffCrVk69hQn7Fq/zpHQsovyjd3jOiew
 g
X-Google-Smtp-Source: AGHT+IG6tXck1k1nWaPGHoJkE7Xtkzy5EoIDnftk6GYo57XfldZ2sNkQq+dbvT971Fy85KL5D7/z1g==
X-Received: by 2002:a05:6214:540f:b0:6c1:6a91:49b0 with SMTP id
 6a1803df08f44-6c5736ebd39mr101675276d6.51.1726244126192; 
 Fri, 13 Sep 2024 09:15:26 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:15:25 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 24/27] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Fri, 13 Sep 2024 09:03:41 -0700
Message-Id: <20240913160408.2199558-25-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

Previous patch has introduced MbedTLS porting layer for RSA helper,
here to adjust the makefile accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
Changes in v5
- None.
Changes in v6
- None.
Changes in v7
- None.

 lib/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 3caa45dc2a8..72b413d85a9 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
 #
 # RSA public key parser
 #
-obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += rsa_public_key.o
+obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_LEGACY) += rsa_public_key.o
 rsa_public_key-y := \
 	rsapubkey.asn1.o \
 	rsa_helper.o
-- 
2.25.1

