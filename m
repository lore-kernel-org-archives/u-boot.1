Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3925FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9389E88E67;
	Sat, 14 Sep 2024 03:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zvPKMUsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43EAE88706; Fri, 13 Sep 2024 18:16:23 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DAEA887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c35b545b41so30203316d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244180; x=1726848980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lObwZT1tjmo3smg5zhNisg4daC1xw1FNSj1rS5aLegE=;
 b=zvPKMUsO40TkPwD6OL/PbevzXhOcKGYaT66HPjdcEgPvPjGf3GMGP2Nx4Up7FGOXi0
 FCzprwbXWfvUL5pFQtcgJr9u7JPJUmnXxsa/0sgoyYA7axi1ZIAsRJmllPGPNJCiJWFd
 3E2RKhMJR7FnVKCreJFrkMeDHaWQps6YKn9Ng5ykunALxIzt45iA9dMBXyL3WGO1pCgm
 6J6kXmthtCFHlUAcguh+G2xHzUXuAPm1o3QK2m2HGXd6lK4wvSEGmVOLLctlG+TCSD5F
 UYQ4ogTnFVk4DYd4NTpPXmUoQJveWUfXe4DkgXHpb8/EdQX1MmuIz1NFfKyGb+l0nTLV
 HEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244180; x=1726848980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lObwZT1tjmo3smg5zhNisg4daC1xw1FNSj1rS5aLegE=;
 b=iulajMzfoNKJXsUZ9T/Ebm4XnINCswf4mNcJJ3TGXwm8isbdnY9tb8NhXQnvDk2Yom
 Pr1JQ9Rdi3islkewwJdHjwcT/9homWF0AtL7oYjvORxuYmlFJ2QcYVl0HOmLSxXzK0GU
 oh0YHdsvTUVqOg3ZYMr51zWLE7wYQg1ti288sIFDr5wiv18vGrJeA5qxPtV03tcvqDRs
 eo1irGIAk3+UjbJA6elKjUr1WvcA95rPtSl6SZUlktJFYcyZ9PVfchHvHdtX9ZWbz3Sj
 kFAsrlbqhQnV1UYOsgkraEg26kUnlj7nqBLiaDlVPp1Ki3JmHwaE+h8ojZVRtGtAY8v7
 xAKg==
X-Gm-Message-State: AOJu0YxvPgWt8rRNbF7hSEJTEGLtXkTK0M2P90YytZUo1rUPBE9FKVfn
 1wZosf3/r4aIQo/2sDOb5CjhyUoqUFukq9xcOervQ2xLxWTPH3LWyqX/MLW5hrQEMheBvFwUqCN
 V
X-Google-Smtp-Source: AGHT+IG7Kc52wvukLm7kbEVRqEi4AGsWH8lstTgpwMNiyYPT8QTLn8yhtW2QA+rkV1fD1hBd3g6YYw==
X-Received: by 2002:a05:6214:3383:b0:6c5:51fc:3459 with SMTP id
 6a1803df08f44-6c573aad1bemr110198506d6.4.1726244179843; 
 Fri, 13 Sep 2024 09:16:19 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:16:19 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 26/27] test: Remove ASN1 library test
Date: Fri, 13 Sep 2024 09:03:43 -0700
Message-Id: <20240913160408.2199558-27-raymond.mao@linaro.org>
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

With MBEDTLS_LIB_X509 enabled, we don't build the original ASN1 lib,
So remove it from test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- None.
Changes in v5
- None.
Changes in v6
- None.
Changes in v7
- None.

 test/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Kconfig b/test/Kconfig
index e2ec0994a2e..558a9cd49b4 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -32,7 +32,7 @@ if UT_LIB
 
 config UT_LIB_ASN1
 	bool "Unit test for asn1 compiler and decoder function"
-	depends on SANDBOX
+	depends on SANDBOX && !MBEDTLS_LIB_X509
 	default y
 	imply ASYMMETRIC_KEY_TYPE
 	imply ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-- 
2.25.1

