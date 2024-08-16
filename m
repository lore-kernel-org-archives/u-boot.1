Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D60C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4095388CB9;
	Sat, 17 Aug 2024 00:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gp5wmFoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B0F88C50; Fri, 16 Aug 2024 23:54:36 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4062288498
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-49299323d71so911868137.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845272; x=1724450072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7rI1bMdhA051gt7vG9rHzgFfFcI8mItr9FazgjR15A=;
 b=gp5wmFoLAcMYfNQ+GZI4IXW/3pL0ROibjnJiMlup0p3yZYWTrLLChpJ6JPrzVfASHd
 tjUvFWsBfcfSi1Dp4vJwra2LFEHbdfLjVZ/e9Qs/Vm//tQRZm4CBZgPqrDsBWxas/3+X
 Tjgbb6p3pk/OHrxaaZK9XPGZ/XX0LbYhXYS+khMhYa/ymekTo3ft1nR0YRQpa9aWR5F+
 IieaQjNzZagXCipx/XwAmi6BtxXzTV9X69QC4Rgq+LKCPFBp4l4VnuV8SnUF0vdxEdt5
 uay3SRaWMFi0G8VhBrRlE9tzNSHqL3DMjV1Ah4xY2T42c4XwjdBL32yoH4YkQbctwUYu
 QnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845272; x=1724450072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7rI1bMdhA051gt7vG9rHzgFfFcI8mItr9FazgjR15A=;
 b=fAp5dC2QL1u27/GCof0ubml7Mjb+oCYt9J3G3zAo/j5nrRVxCAj6R+Ah3RZ1H9d/dD
 5IBHkuXdGgyqZ2iUOKtRhSiUBk83iGiyP3y+3Y4QriQpZ/ffm4El0SVoZd7/AuZHhmwO
 cAFmzlAMxiIPB5wzT5xZI1hhJ9MazDUSWakDfUB1Mbl7F47EDrboTfPSxAFRpW/Qjikd
 TkgVvaYKkS5P68tVQk1gZ5IoU4AxAWduN1BrxCXb5e82p+J36K04zVQIjeQ4zaAY14N3
 nD2Vi57FwKXDDPJLZdx9idawa8pBd0Tw5LAgDcujoGyKo9aqLyRPNKGGMaMrCZt3IIUi
 DX7A==
X-Gm-Message-State: AOJu0YxKazceRmFzCk8Bd10aax4EISOXe1H0gueor/h/E3MYnyYy06R3
 /CLspeph9Mvs3aRGkh5thYOo+aqPgjE9I/MdCx5tegWja4Uk99DYtXvEuHlGcn4nk/YpXfYy9Oi
 VTL4=
X-Google-Smtp-Source: AGHT+IFMhB9eNm5cgmtbj+3V01PKxjhZgsX/+lBePUECXSxLDPmK2ldf20tgS84AqRM9JuMcf3AFeQ==
X-Received: by 2002:a05:6102:3a13:b0:493:b3d8:bd8d with SMTP id
 ada2fe7eead31-497799e4d1emr5088662137.26.1723845271957; 
 Fri, 16 Aug 2024 14:54:31 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:54:31 -0700 (PDT)
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 25/28] lib/rypto: Adapt rsa_helper to MbedTLS
Date: Fri, 16 Aug 2024 14:44:14 -0700
Message-Id: <20240816214436.1877263-26-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
Changes in v5
- None.
Changes in v6
- None.

 lib/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 3caa45dc2a8..72b413d85a9 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
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

