Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF5CC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2302887FD;
	Tue,  2 Jul 2024 20:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yc5CRElY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2DA887EB; Tue,  2 Jul 2024 20:34:08 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F064F87D74
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4463682e944so28247101cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945244; x=1720550044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTzRGAJvdIxI+FMac7Nz5QcjSbOVqVOQLrl7Ib4m3j8=;
 b=yc5CRElYKOQH4r5HfRPI8RwwkkrVY8P9styXrJi94qe9QKh0bcfiMCrnGPr78YRn6O
 36J+NofXmSYuYUUI6H5WuZDYzvUd/rKXN3pusdDkWNmg/isah1aGwdpJVyDx6ap4htXe
 c3BcX7N5MzJAoMBdxheUL3Jl1Wc2RxMEGQFmqkjRuQlfoMm7iYfs+vItpaor14iAbce5
 ZFdktnt+x9yKjV11DjoQyf6jEPomhnV9aCyGwUqx4RRd+QSBCsMgtR/l8Mcf7nSPT1zv
 hoEnE0A44RDT/7cSN7UA2pCqXAIxe4dYBus57yoWqu61f626axJBtrZ+TBIjkkbc0YXs
 uQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945245; x=1720550045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTzRGAJvdIxI+FMac7Nz5QcjSbOVqVOQLrl7Ib4m3j8=;
 b=VCoaGKbjDLxUYt+09D1RBNTZajkUlD6x0VBL5+UzzJ6BTcebyjCwv9XJcKE8MHHz5v
 o1nNmy+KQu0fjrKMychLoMikNFetEGNCb0iFneB4Ti9Bi6V0al3pYMou16AehfCxPSc6
 aJkFNF4AF5EDHppdaJo9/ZtFx/O9L6qKDvCefHaKLSwFIWygERDiqqCoOdbDEbE7jc9K
 AUIKOL8uWy9snRfVO+ZdCTghT8yLak5rjFT6JR1CI8H5ZtacofPEeX3wtvDlLsextHPP
 C0x5ebWiemCr0YjOyrFX+hFGcBmqIGEUUBxc8SE5OIVXlx1QRSr6LipjOabF6DLWNAcm
 YzWQ==
X-Gm-Message-State: AOJu0YyLrkW6VLITwxX3hWIa/yQz3cTwOR+Lql41gqdv6HNy2yWiW/yU
 hQtwhdRyDgJiopWKT/ah128wla9MROJyliiN5mrLPAyioBO0eHge0fWekyUzrYEoRMGouoC/9Su
 8
X-Google-Smtp-Source: AGHT+IF8IC7cqmqO0nWZGXqDEIt/jG/SzB7ywc1nEJELT7kFy5+wrt0AlZtfz/Hf6jaD7QFpSMH2Aw==
X-Received: by 2002:a05:622a:1315:b0:446:5d60:5cff with SMTP id
 d75a77b69052e-44662dfd9a6mr125277241cf.10.1719945244705; 
 Tue, 02 Jul 2024 11:34:04 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:34:04 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 26/29] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Tue,  2 Jul 2024 11:23:02 -0700
Message-Id: <20240702182325.2904421-27-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for RSA helper,
here to adjust the makefile accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.

 lib/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 9bbd8b48d77..281e507743a 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY) += public_key.o
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

