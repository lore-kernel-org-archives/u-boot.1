Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FF5C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9A188AC9;
	Wed, 31 Jul 2024 19:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fc20SdSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB3488ACC; Wed, 31 Jul 2024 19:36:20 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A7C88910
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4928d2f45e2so1559824137.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447377; x=1723052177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQ/sou7R72dI0nMuKysuv/d20FbUygoq23oScFDWvog=;
 b=fc20SdSwgrFeq2ChFNloQJwEBvzlbJ4WzPaeAdrRa19bhobCmx1RRchNiy9C0igILF
 nGkJ8iIozGxnO8t0142DzjGkAwzi/t7HrWOa+hif+cwp936FRd7foqOk4U4javGd3OY2
 d2hUAmJCtyCcs01P2Jnyhsnj/gpUft96v0L8zIToQE+GUipkb+0IPJXzqZ6yguz7yFcX
 rnYtZxQu1K13hCyxSppOhvBrx3cz8s44CzfcMTKM6NUQLRI8u0gMM1ZkUk2g8OCuymQQ
 9bSgQm+bKGhLWJIO72zby60tclBB/dJNaaRee6ZK+I02lZv6XcpUiZ77bBR8s+8plJMm
 C9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447377; x=1723052177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQ/sou7R72dI0nMuKysuv/d20FbUygoq23oScFDWvog=;
 b=mr7wNs7YkOaTbhYsu6mSxU5JydTEMtY7w4TjLk2bmGkzfTuEC6ewXSqmUbjN5ugc+k
 uJVuoJCsUHU95zT6I35X7Jqky1u2JLMg4wwPLYZICpR7l611X9XNfUcxcCm5kLoL0dPX
 4fJ9guyz1ONTpSQ13WFMxxFr3Zr7ITO7Q4FUK8HxAUo16Gqc4oxIHY8ETnUOc9QGh8+3
 +ejEWuu8BPX7O7aRAfmgJcEwN75evjkJbPm+82R/Jpk5i5VotnbhR1bU7wS7cWdOWDcp
 fODx71u2Y5+zf9qvTbgL24NhCzwm1vZzXK89cPujheHAYHIm1Mt03kHuuf0GcCH0DYtW
 uoqA==
X-Gm-Message-State: AOJu0Yz7f6WXr6YgGQWJQGTxm1Ia/6e8OeHE+jq9EYJRDLVg+N0YGWv+
 IYKo7KQwLs0tMJDF5mmMT9RKJUt5xXfRwruR8v76yreXJYksBfS1GOKo4jBTY0pLm1itF7Otgv6
 eV1g=
X-Google-Smtp-Source: AGHT+IGag+yxfi4Qrrwwx4pOdffCwSxQEwlLWHtEx9snnpDwl7jKNX9NUz+APpP1Jyuitmp/2lkQ5w==
X-Received: by 2002:a05:6102:1611:b0:494:2c0:cd18 with SMTP id
 ada2fe7eead31-494509a9c23mr29365137.22.1722447376984; 
 Wed, 31 Jul 2024 10:36:16 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:36:16 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v5 26/27] test: Remove ASN1 library test
Date: Wed, 31 Jul 2024 10:25:36 -0700
Message-Id: <20240731172556.1348487-27-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

