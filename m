Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3B2C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC42388116;
	Tue,  7 May 2024 20:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I7kczFvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4BE887FA; Tue,  7 May 2024 20:02:37 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EE08839D
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b47833dc5so9929616d6.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104953; x=1715709753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llzUsP8DolurjOu/ALuDJKTWxEsLfLtMurzEiQlt680=;
 b=I7kczFvVcxnrBrAtTSbL9du63qH2A6u/nCxizhAXAPSjgoca/teHMe3QL37iYnnZer
 3obwTu6j/uzyULDltyEBQGgw0A5taVtE1qaFJnCuGLVrrAJ9Eji57Ebq3b0GsoQryVPp
 0xzOitOJMnWYOHaYVlw3MY8LTtxYW4xD329Lttw9yRh5QyQbVzUoLxHZRKkIMFp4oT/d
 a761JPDjVLn0ob4u0rozgkLEDHV3ZgJ6Kbo388B4qqa/iL8uS/KuzFHbjhd8tkzcCenM
 9LGS09Gu0VEHUx40KWG5SGwrpnan6reHGMyfPooiq0F+LTFbsF5QIyzeHm2M/hEwEb73
 lSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104953; x=1715709753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llzUsP8DolurjOu/ALuDJKTWxEsLfLtMurzEiQlt680=;
 b=g8TH0pPSBkTraKwvS8/1cvxFoly2aJZX+vnbh7T2GLLJw1VjF9yHWLUBgGbZuMUsad
 DhsuzCF0KttkGPKoJ05T1RDrY9pDAcNzdHkX5naVg13I4439awGnH3BWCC7lxuijdM5c
 OWWAJaQM2OSO23pjOlVwSESZvb1pTSKLALiraDzXTRQvSUR0j7Y/1AheXbsCN1FDtWTI
 GMiZerCkiVephvivaYTPEBCZRTLySQPh2wk/4sQxcG4AeCObgGIXOcLxEsZOCSrx2Kim
 ueGyvkRNhXH4Y7AALNAxB9lD//9YGQtn9C9bDU9LkJLXUl2dPWMP7zt8qpBdBI8RPbJV
 mNew==
X-Gm-Message-State: AOJu0YyJGzKHph3kjdWF0BAipHgv7Eum8yKwf2b7m0vhBR68wLTedTAH
 7VYp5rBWYbUki/5zJN2P2JyasAio48KMscM/bFVV7PBzCB++bFRXuyU7PwnlSx/JAIcxKvlSm95
 7
X-Google-Smtp-Source: AGHT+IG1HZHhBjbAyhR+5cn0WQBuXy9TtwQGmmrNE/GMuJqHDT/yF6Yu0QGQJym7M4j+21TgWVnwow==
X-Received: by 2002:a05:6214:c45:b0:6a0:8225:d89e with SMTP id
 6a1803df08f44-6a15145bf41mr7799666d6.25.1715104953704; 
 Tue, 07 May 2024 11:02:33 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.11.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 11:02:33 -0700 (PDT)
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 25/28] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Tue,  7 May 2024 10:51:07 -0700
Message-Id: <20240507175132.1456512-26-raymond.mao@linaro.org>
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

Adapt rsa_helper to build with MbedTLS

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

 lib/crypto/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index e3232019df2..866a9a3f059 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -11,6 +11,7 @@ ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
 endif
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
 # RSA public key parser
 #
@@ -28,6 +29,7 @@ $(obj)/rsa_helper.o: $(obj)/rsapubkey.asn1.h
 ifdef CONFIG_SPL_BUILD
 CFLAGS_rsa_helper.o += -I$(obj)
 endif
+endif
 
 ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
-- 
2.25.1

