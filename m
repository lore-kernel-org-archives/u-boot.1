Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35EEC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7431A8122F;
	Sat, 15 Mar 2025 23:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IQkZvFGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6192810F4; Sat, 15 Mar 2025 23:18:34 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88368817D8
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fd89d036so64423125ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077111; x=1742681911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMZlWb3jctzDMEE3EOU1HsoBaXRZ4TfFvMn/2pYkYe8=;
 b=IQkZvFGsCIQf2omn4oxqRTF9dhN0y9nMRRzPKk4w6xDhXq3A3RAcULArN3QrLbPwn1
 8rcFPtrxXHNnkUG97h+Os+xJ30nVF4sAxzKMiYbuGcqSak1sCRnMlGIlm1el9GqDYizy
 tl9mferojNHU3asmilqR1eoEJ8iNyxfSa8W467KU2JbSIafixg8JLDe65Om4Hi3pi+Xu
 yXX54WD+LvJs2qm2HpRF6Uqnb3Wz7cqtOzFghn0dLM1b0HccnWmSfnSPbFB93XB2x4Bc
 pA/NoKZ3FR7VG4l8J9LSKjF/TmRngm82COk9ekwCBo/kFNQ9mxQ+hezuwnyyPA7F4TFJ
 h2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077111; x=1742681911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMZlWb3jctzDMEE3EOU1HsoBaXRZ4TfFvMn/2pYkYe8=;
 b=TsJgb33+Q2bD9VbT383YPr9otJixy3GYzDoBJUWkgTtSkemGAZ4R7wRcc9kumi3y9e
 8q8B99qV5KEq+v0YgnPR3w/Lus8fdrLEEqK8Lb9X4T8KTZmFGe4/WHqZSRhIZhIMNXNa
 qCtkLkLpwI4cG39iDS3OhDoldFs619TtbeY7BEs1bZqb3gmYrb/vruBgBSxPWHy/EgG8
 bPz64gGwNZ+lCMaJwFclFp6hgcrNpTnQM7mfajqfhYLqTTfoQGSt5xc35Bc2Kv9jY9Jy
 D/Z1VuUaefPGhk9dk9islIfAfJkRFFed8+tpF7ivdiK9012o9/AGwDfoiLzwTVH/LLoK
 1Dcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyL3Q0GEkrvHLPRdsVKGia62AbnfN9dZ8ARxbNMcwMYFggiNmVNgt3S2iIzVliSY5cfns/vWQ=@lists.denx.de
X-Gm-Message-State: AOJu0YznOSzQfa7m2MKyTt2GjTNgnlYkuklPuVsAvfi3Ml4aRU3aJfOx
 DE0/YimMMZbOAiV25ylNciOf8sY+DqqnbLK59AUBQiM8QnxgR72Z
X-Gm-Gg: ASbGncvVdb4ay34e+oCTvh4OukydgZfQeiz7e934ITNuxGeLJTGMwfnjS7km6Fdjwum
 mqWw9gf1aeN2k+bf+Lss6xa8p3W27csYxa79uOvlj9TORwQgVKw5GkHnKAXOVQRYRx9bcAwjePv
 rfuPoNOa2+2m5np+P/nz1zS/t7QFY1cHzQ94xw+pqxNbCKVw/NJLg+SmeRcl/mtOV265TyX/q6h
 yLAuZqKSJM1n5W+9FgpnF0oy4S1RP72c/nEUJpRN4J5wEURO6Xy7Dp/h17CrMZrWoo2V2zP6/LX
 HeGjl2pcMcojAkbTtA4BXtvqCMQCj2rKzFHcA+L9FnSnLMLCII4F3DA=
X-Google-Smtp-Source: AGHT+IHQdlIo6iEcDbpPORIR9PmMa7GE2t0SAaRemC+Cx9l6PLbrJzIWbATojnnkpC4M53rV8fEa8A==
X-Received: by 2002:a05:6a00:3d52:b0:736:7a00:e522 with SMTP id
 d2e1a72fcca58-7372236e170mr6693723b3a.2.1742077111096; 
 Sat, 15 Mar 2025 15:18:31 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:30 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 10/15] makefile: Add READELF command variable
Date: Sat, 15 Mar 2025 15:18:08 -0700
Message-ID: <20250315221813.1265193-11-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

This allows setting READELF=llvm-readelf in order to use the LLVM
version of the readelf utility. It also aligns with the practice of not
using $(CROSS_COMPILE) in any build recipes directly, reducing the
number of places where $(CROSS_COMPILE) is used.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 05a93813afa..fb5cd67745f 100644
--- a/Makefile
+++ b/Makefile
@@ -406,6 +406,7 @@ LDR		= $(CROSS_COMPILE)ldr
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
+READELF		= $(CROSS_COMPILE)readelf
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -2177,7 +2178,7 @@ System.map:	u-boot
 # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
 # R_AARCH64_RELATIVE (64-bit).
 checkarmreloc: u-boot
-	@RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
+	@RELOC="`$(READELF) -r -W $< | cut -d ' ' -f 4 | \
 		grep R_A | sort -u`"; \
 	if test "$$RELOC" != "R_ARM_RELATIVE" -a \
 		 "$$RELOC" != "R_AARCH64_RELATIVE"; then \
-- 
2.48.1

