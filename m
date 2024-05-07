Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA3EC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB6BB887FD;
	Tue,  7 May 2024 20:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DjBvq+Xx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98AD887FE; Tue,  7 May 2024 20:03:02 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8C788025
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c969fa8fd2so1555371b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104979; x=1715709779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4S5cAXZElrohXQQTuVka3vOKlQzDno/gUUykT7US7NQ=;
 b=DjBvq+Xx9IcBxEyZSxNiPY/v32LYWjDmuT2XyV0q2WMt/Np0e2RuN/dfgQZd8iTJMZ
 17NTT6+wb1VhJ2e1u49X2PAd/iTRTrpU80vhd/AtidqD/NEFmUalt1NjQ8eub6wSSOgz
 v9AzOOAhOg7OEsvvX8Xex0nb/q2ko79hiQNoufaRH1K4nxtt4f23N5WAKlp0DfbRzbyd
 oYRhct9rQRLLXxZUfAdMhxwjoLykG9oU2gXJB4gJ4q8FepJ7uHAvUNMzUwuSXs3bvDoy
 9WtovxB/0YqehGccwb7uHpZQ+HaOrs8x8/JKXXCW4D43oSeuJfLvxSDagwXxc2rDPSS4
 Ez7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104979; x=1715709779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4S5cAXZElrohXQQTuVka3vOKlQzDno/gUUykT7US7NQ=;
 b=TdTg7k5eOO005RbJHSSbrzVBkz4k0JM1yAeCCrU3I4aoxtT/qPHQnDEKbkIe37Gdj8
 OrSQ7ePcUZssgOdwIKjLW+ItbfOB47fxYTlKi0Wph0Vau12T10bZvgYNeCB4YrCQtJJk
 lJ2y1iEYQtWRXCjSQQhzFMWyKI2MN+8XkZ7RhbDXv7S1EubfGrWKjISJOj+R4wEdB7PB
 78SsZOXlxW1jHzj9eSMtcXU6PNq9OMrkQeObpGYzLZIhvP2IIBRXLA35IZToEUZvB29v
 ADONrh/hoxDkRchPskz/ZgDTt7fN3n8JRstQegWZwYOhqdBEmAndoN3r9pREZ2XCF15+
 cJHw==
X-Gm-Message-State: AOJu0YwamE8Ho1zcMPm+FjEwteD5eh3xMyTWmLfzrZuXNeB2YfmMgJNv
 1feqtlEOTzQ12BSexc15Mxb1ZYK2oZdLBAnkM/+72FL5i3qfB/xEtjoBIf4Mi1Rn2y3AREN9aR7
 x
X-Google-Smtp-Source: AGHT+IHa7I1DeLx2wiMNa2R1ViIyIYL/l9nzNw1gy+P1dolRXTLDKKdILhbBHk4PDHgFLghucO+vXA==
X-Received: by 2002:a05:6808:d1:b0:3c9:68f2:6489 with SMTP id
 5614622812f47-3c9852cc0cdmr361374b6e.28.1715104979223; 
 Tue, 07 May 2024 11:02:59 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.11.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 11:02:58 -0700 (PDT)
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 26/28] asn1_decoder: remove ASN1 decoder when using MbedTLS
Date: Tue,  7 May 2024 10:51:08 -0700
Message-Id: <20240507175132.1456512-27-raymond.mao@linaro.org>
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

When building with MbedTLS, we are using MbedTLS to decode ASN1 data
for x509, pkcs7 and mscode. So we can remove asn1_decoder when
MBEDTLS_LIB_X509 is enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

 lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index 3534b3301ae..7e3dc1084fb 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,7 +82,9 @@ obj-$(CONFIG_$(SPL_)SHA512) += sha512.o
 endif
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
+endif
 
 obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
 obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
-- 
2.25.1

