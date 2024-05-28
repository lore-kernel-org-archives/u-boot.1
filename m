Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31919C27C44
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3818852C;
	Tue, 28 May 2024 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gza7ZDcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E731088580; Tue, 28 May 2024 16:18:55 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB136884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-794b10641b9so54303785a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905932; x=1717510732; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSn/3mO8oK41mJeTa9XfbQ0t4yqAsY7f1rFtRVFbZ1M=;
 b=gza7ZDcS6eFmLpCxzH739rYZUszpZ8Hkubj3kuFIIUuqLPuHW5Qae+FyKKcdnpQkdu
 jy5THvBq4y9ilJwpygaCNywlnPF3IxNJyKXvTPRf4pt8Zqk8IAqTTTDy9TkK5puuNhcm
 TiQivpCnoYF6irZswiJ/GTBnf+KzdDzP7w5/14H3ub4434Lmn8d8MrNbswTlZHTeyGjk
 ZtDe9ltwbSs4IcfKD3LsJq4Lnm7dO9PA7NcKHG33hflA/RKgQ6rqP4yjBm9r9ZoxBcVm
 cDT1ceENd4UpPmplovuUAdZ3zUPycc+pFYqQFw36HGF1IUw3NEBpUC6pycSEKOVKhoiB
 kWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905932; x=1717510732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSn/3mO8oK41mJeTa9XfbQ0t4yqAsY7f1rFtRVFbZ1M=;
 b=Wzp/5c+Y9B+yvYts9ck1e3Snp7oZjyenvHGcb16kTtJpzUF6196ykAtf8TvFEtUDU2
 4d5RLBDk7+vuDPJn1/knKR5Jm16YfgPfYSm4dEw51q1vI6iKUOjFjwA3GAJSud6Tl2cX
 Fp2WGjlOuGvCAJ2VAH/0CjEFMty1/CgTt86ccz2mVeXHOaVk5T3hfgvnTE77YCicmTT4
 XBeg7Pw2aeGTbrtPecEClfsluapzuK0YSq0w6sSIiaeSODqwnQ30+PQUVhdoPsMwnQbd
 5GTxRPBbcMWyt/aWwYrrqgP8j/mMREzTeK5tNLdkHBb3V8bPme0IuFCi+AHTUiKX8dHU
 pbnA==
X-Gm-Message-State: AOJu0Yxl+HeSoHuX2+ZLDgyxbhriGCmLJVEDB/OImy6SgKVAncLB5p0U
 /rSiFYx/0BV56HRpNtPYf9yNDKpyWRBVzqq3RD2c++5kRV+98iO4lH6KomuuY4CwkaU6WARC7lT
 XvAE=
X-Google-Smtp-Source: AGHT+IF1pac9mF3STjU1WknxP85T+lyvoocRgOHRCirAYJF1zhU9Vop1XYl4NiC0spjKPFKvsyjlOg==
X-Received: by 2002:ae9:e609:0:b0:792:e8c4:414 with SMTP id
 af79cd13be357-794ab0a322cmr1346660885a.26.1716905932490; 
 Tue, 28 May 2024 07:18:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:18:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 24/25] test: Remove ASN1 library test
Date: Tue, 28 May 2024 07:09:35 -0700
Message-Id: <20240528140955.1960172-25-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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
Changes in v3
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

