Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93741C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1208D88C6B;
	Fri, 16 Aug 2024 23:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LQI0c86q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37EE788C6C; Fri, 16 Aug 2024 23:55:22 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE7888498
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bd777e6623so12860566d6.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845318; x=1724450118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0Pkb2MdzMRP+2UtdiHPy6Yav3jenajiOesKLTAVyL8=;
 b=LQI0c86qjABtr5G6cspj+gLybdlYv6OdBFpTOpgxlStgJerJ9wP59KCzKp1eyb9CCP
 8mR81KVg2ObRfyIdMGj5MktTGD0w+rIU145FwuaLqZ+UO+dHUwrm2TWOdpb7Xxz87MgG
 knoTOIwq13dUd/Mm+HukxnTzDRI3XUxjbfFnuhMNFvVFXmbafHFZ5jFgH2JndTpAzTX0
 LnhPLjc9VsFdfqTQWCYV6dyxxWYoHYMuvjqmkjaqGRGydbV3Yi+uBvUWBB0my5yjULBA
 cOuYcmk9fG0ykIZ2WtU7Ofrfeyaxx++bGshnw0a9G7DKHXf8xzkvTUW+hwMaTrwlP3OE
 0WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845318; x=1724450118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0Pkb2MdzMRP+2UtdiHPy6Yav3jenajiOesKLTAVyL8=;
 b=krN1aIMe8fp0dDqD+feWEqOYx7rze8Kk19Ruvh6gW+7+sikjT4kOph7eI0mn/cjESo
 mLbrECzUvcHMYESVj9l/dTTEPMxNW7uzl5k4C7BConZD+Krg+zgtJ8jQJZZQDO3LMfSu
 9znAliBs0Z6RXzaPZ5UwB5xgX1rg9dyaKbm4GUyVBez73GZsqpBht7dkTFwE1YcWIxRD
 QKp80ATX7RikyA0nxxTzyIQ6hOJteTDP/hajw5A3PVpq4yJ7Uxoj5EjiKZgP6yc/MEJc
 Ld7ZxXpFtHcE0ytyabvWnKucFdMyOgsCwgaXcAiMGqR2W4R7/NbTG7OrvrOZb3jy83zs
 7XXQ==
X-Gm-Message-State: AOJu0YyGIaOX3CcyKUOy5CIKz1+5sq1c3rUHJ4uCSCj1+Gnfz6b0pRhD
 j0RCaiH34425SbM08K1/5hpX/FkLTzUNxv9JM5D15PgrvuCmxeOvkDTQxEvPSOLJoOWmK8q/wMf
 Ng6c=
X-Google-Smtp-Source: AGHT+IFCm7NDH/F0P/rg5O0/7S4J1gPOVSxuBnNrP9IyMqShAceAjySZ3tAuxXei/IwuaUqYdCvKWQ==
X-Received: by 2002:a0c:f40d:0:b0:6bb:a318:26e0 with SMTP id
 6a1803df08f44-6bf7cef1e29mr34032156d6.45.1723845318160; 
 Fri, 16 Aug 2024 14:55:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:55:17 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 27/28] test: Remove ASN1 library test
Date: Fri, 16 Aug 2024 14:44:16 -0700
Message-Id: <20240816214436.1877263-28-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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
Changes in v6
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

