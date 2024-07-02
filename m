Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC1C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671B6887A1;
	Tue,  2 Jul 2024 20:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H3v7lu2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61125887B2; Tue,  2 Jul 2024 20:29:04 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0976987D0A
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4468ac3c579so3295011cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944940; x=1720549740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w51ycu0Ck8ZvbQIoGfv2pnMBqCAtaWnBVBbUXVW8pXA=;
 b=H3v7lu2VymFnLS7Hb0F27EmXKGPrJvdVGg28QtUfUzeBlCdotKGF0WzlI9984Lau43
 2pQsD1RGE/pRD0zjA5x7JVfWrN9XODPUpImHMjA25PC4JVbof4Ng9aePs8QdqnoKAtmq
 erKdAEHMwGIFCk4/G090w94hGiIvRlrfbLSPwejqOUGU9NBUOdcjdX1kNwD1id+omJCk
 TF9+ODJysKCVazknjQWS2Fss9oQqjKMI2ytALiOrxPZHaIp7Xabjb/T5UheaRhDEs4h1
 fcs+Gm4sGhqSSrNZbyyKuDRRX4IJSwstqkS0C39cM4iYQjzM9aGxK3+adStmz2e4hqwr
 mBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944940; x=1720549740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w51ycu0Ck8ZvbQIoGfv2pnMBqCAtaWnBVBbUXVW8pXA=;
 b=EJNm9tzauv/cxpxN5ah1kQaG1wu38Uxlm6pl4jybps8gtY3QmCJiBrVbxqVqWdHMaE
 38OSw7rlvlmTjOHELz4BoFKuRZe4phNnJN+G948ft/J0rFXbreFrx9ohho/yDP+IrcNw
 W4vr3U6Djbf76QEMtd+gx19EIT3Ygdc1f891epJ6U2cNfzph99alWmQ9CdDdnpViCIyP
 A/YxlNkoyo1A0kSPcF7O4tTvrZDQWhVxh0zrzky0ptZbQCE82ZjH66nKW8kMpwu3g2ok
 U5l4Ijtu+q58+YHEdSD+MynAiOsT4N2LlpXJfqyiKB8Lb0fPAhdX30jzGkZMdX2NGCPe
 vzeQ==
X-Gm-Message-State: AOJu0YwKlLWkmquzkSJMIkdaxEkaA6ZnAFAeeF53f8Gq4PdokNiV/Yzp
 ElbY73OALhMbs+feeWEd07iVrMAaKPVXAoQTYxtjftme6/cfK7PEV9fhcAsTJK3gFaX/EbNyUT1
 r
X-Google-Smtp-Source: AGHT+IE4cbA7nqo6nR4pHcMndq9hBs0rQGEOlB0hFQpr7Ao5tQ5MYZfKFScwp68WAxq4FiLgkac0xg==
X-Received: by 2002:ac8:4551:0:b0:446:641d:d11e with SMTP id
 d75a77b69052e-446641de3bdmr84560081cf.61.1719944940491; 
 Tue, 02 Jul 2024 11:29:00 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:29:00 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 13/29] mbedtls/external: update MbedTLS PKCS7 test suites
Date: Tue,  2 Jul 2024 11:22:49 -0700
Message-Id: <20240702182325.2904421-14-raymond.mao@linaro.org>
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

Update the PKCS7 test suites for multiple certs.

The PR for this patch is at:
https://github.com/Mbed-TLS/mbedtls/pull/9001

For enabling EFI loader PKCS7 features with MbedTLS build,
we need this patch on top of MbedTLS v3.6.0 before it is merged into
the next MbedTLS LTS release.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- Update commit message.
Changes in v4
- None.

 .../external/mbedtls/tests/suites/test_suite_pkcs7.data       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
index d3b83cdf0aa..2dd1c56109f 100644
--- a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
+++ b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
@@ -14,9 +14,9 @@ PKCS7 Signed Data Parse with zero signers
 depends_on:MBEDTLS_MD_CAN_SHA256
 pkcs7_parse:"data_files/pkcs7_data_no_signers.der":MBEDTLS_PKCS7_SIGNED_DATA
 
-PKCS7 Signed Data Parse Fail with multiple certs #4
+PKCS7 Signed Data Parse Pass with multiple certs #4
 depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
-pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE
+pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_PKCS7_SIGNED_DATA
 
 PKCS7 Signed Data Parse Fail with corrupted cert #5.0
 depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
-- 
2.25.1

