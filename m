Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AF0C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366E288116;
	Tue,  7 May 2024 20:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S66tpyg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B3288805; Tue,  7 May 2024 20:03:28 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E02688025
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b730fc89bso10130566d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715105005; x=1715709805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzwGWDYWNay6lHvRuc5Q3+s0NOEt2ovfeiC49sOwtHE=;
 b=S66tpyg69ol3JWijGOXUMKF3ps0E9DGy7Zqd238+r7QEZtcWJP7wlV+o8b/k7siNJq
 O3n+rliZdzbZzc1narFGQCTdvskjD88a9qvs0OFEZewwsvkO1F3VCKjvLWrhdWnpZG6j
 DTOIQ4mcRgojeLWhtrX/XB6qm5bXXEB59iwW7R+8lrgSei3QWW7zXgf1syulC0BVbNe9
 CVQC5RNgtK5wMDlMo86ShohLd7My1jvldNmYF9Q9hW+y3NQOpfqS1R9oCt31U27RRAmG
 4Nl4nn6oj2cReoqkiwFn1SUinkpq4Nghsc0RKJRQEu+/HMTJ6+HRuNK62kATDRDMVRYI
 4z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715105005; x=1715709805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzwGWDYWNay6lHvRuc5Q3+s0NOEt2ovfeiC49sOwtHE=;
 b=m6wj+zS9yMdGlum3CcZrAtFZOaHJHPn+ntF2IoIHnZjayAA07BXlPwGigBc4j8Pdyb
 JJpLFpjmAJ28chYkxBoYxbU1qL1jkAexEOpU/qfQGAO7KqXOMqN/e7ZyrcnJeWqkLg/9
 /OqzS3JhhmHQBKB5pDtpA42en+e9qP3NkChH4QlY/VlS0sv4Hq3iTkYQ0rrOu6sW6VQN
 KSDkzD4ko9W/JLNYwOsccFxKy9xRjKUOmfpXTnr8t6nmJrwNoOxQGLpDg4qF4AYsX6uG
 GLlPE/UYvunEdH4zKsbZNQKshaILnhYj+spj6sytcetnhZYmVdl6uwbdO+SHgDtZEdT9
 S57Q==
X-Gm-Message-State: AOJu0YyIzOEPkH1GgR408ZLMl0MAsBrXXSATtpSsWCpN5tKv6m8EJwf+
 6+P71U8BRzqm+vf99WgDQp8oa5MSObwALD3wdeVsY9lHeOucspifsTa+rP/Q2gWt9TZo4+wtaX5
 J
X-Google-Smtp-Source: AGHT+IECjVQAO0RMXPNyUt1l4TVh+ExLxQ/QlpFg4yJkpcX3r1QCxMa3dhXInHHTQU2cXjycFqUMaQ==
X-Received: by 2002:a05:6214:2b06:b0:69b:205e:fb0e with SMTP id
 6a1803df08f44-6a1515b9220mr5582416d6.59.1715105004841; 
 Tue, 07 May 2024 11:03:24 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.11.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 11:03:24 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 27/28] test: Remove ASN1 library test
Date: Tue,  7 May 2024 10:51:09 -0700
Message-Id: <20240507175132.1456512-28-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

With MBEDTLS_LIB_X509 enabled, we don't build the original ASN1 lib,
So remove it from test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

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

