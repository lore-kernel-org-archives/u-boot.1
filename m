Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63089C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6718873A;
	Tue,  7 May 2024 19:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K1zU3JXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6872A887CB; Tue,  7 May 2024 19:58:22 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2273C883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6a073f10e25so20028976d6.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104699; x=1715709499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSo/6LYKhZLp1lxneyI0eEaAHiuCpGkRxy7EAnfPo+k=;
 b=K1zU3JXjaLg+weEx0+BQo+DfAZ85wlUCf8/IHUujqYpB3+2dGE9M1aS0lYzHlIx7Pr
 1KklHHOSDIuNiXm3suUUCEugVF8qBsgAT7XxREzhp2nbkp5eIp/YXSkWdlzYlB0pWiMQ
 DmRLCKV84qdYh4wV+UHpKK/EOXvlXUG8J4P2lUZQHzTl5Pz1+erj3TNcUjbuoD3n0Iul
 LSlDfwnFXKvbKFAbyKG/a30udsRr57HbK30P/2R6OMUmQ7GMxO7ea6n1Vjen4XvulHv0
 I8wVevEKKaJkw4/9X/gE/Rt9cbvlIe6BqJTfjzQKwa5b4oQjESAFmxsQHHULgUJtyZC/
 mvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104699; x=1715709499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSo/6LYKhZLp1lxneyI0eEaAHiuCpGkRxy7EAnfPo+k=;
 b=o5vDbx13THjM+LUGWhgZrrreheiRT3mdJI5Qmn3vtx2vSDzYvEvDrNwE/13GqOUqwt
 y2g4bv1IE7tYzAmoEgjiCMDjATuaDaImuk6nUcrwCWWKYMwNEr7Ft9V+ue7AK1zDPUMy
 RITUtxBQmrL0jELkiRRJ19XnoCknmHviFOS3rasNSL+YBkTKfaECluN8RMrjI7lwXLTu
 zeTj2p3MBI1Cn7JNHPv5dYMJHn9wOmgo1kZmKLtQbBH74ks21Bqd1LPnlGOKFiuW5/PZ
 JFZ8RhIob7KmqBXsygBZqh6GwuzpgPTk3WCekSuJA3FAiJriN0C6/H0Gc/4m0V8hmNkb
 kmIg==
X-Gm-Message-State: AOJu0YwtVSSC/NxWFEXJMdS94CPmb+dm2N8YcQab4Z1VVCBrattYBFFD
 VD4NWpf5tBajgMRMxIL8WVHvHO7gZRmg3ebAhDyBr9/PyzvGTChUnZbZoBhbS15xS4ZvlTq6rPt
 h
X-Google-Smtp-Source: AGHT+IEK89bc0bEdVDoxhfml9yviU8fqDTEZ//gweaxYCL3NLPXqcDqQ67kN4kxhlP2RfQWBGt1XtQ==
X-Received: by 2002:ad4:5be8:0:b0:69b:7f0e:bdc with SMTP id
 6a1803df08f44-6a1514eb028mr5982376d6.30.1715104698844; 
 Tue, 07 May 2024 10:58:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:58:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 15/28] mbedtls/external: update MbedTLS PKCS7 test suites
Date: Tue,  7 May 2024 10:50:57 -0700
Message-Id: <20240507175132.1456512-16-raymond.mao@linaro.org>
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

Update the PKCS7 test suites for multiple certs.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
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

