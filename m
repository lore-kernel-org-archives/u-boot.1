Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEE8C5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9402C80F9C;
	Tue,  3 Jun 2025 00:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cg5/9o2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC22F8144A; Mon,  2 Jun 2025 20:57:33 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39588070C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 20:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=behradelmi1@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-32a806ef504so43077521fa.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748890651; x=1749495451; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O6y7swCNA6ODNLbvdPI8+xngRE6DNsKyCd0xpyTFpqQ=;
 b=Cg5/9o2pGFun/4+mAAOUiIU9uAkgDs74ukNKT3lUf9p15KYpH7aBFRvYVI7dtNJTBk
 +p65sXUbRKol/0yJLDOQt+mFmnGm8+4JLp8/+w+R+npmeo2bPvoSV82Mr0t8h+L0yTl3
 zDQiu9TZHooG4b0tvF7dHxSoUtq7hlfuc73XxgSTZpa1IppADLqpD7Po56hmcSr50365
 +EkEw7E7EgTDqHSm9P07K58kEa8fb1LKQ2bdqq/JDdbejoBLa9HKrsCqDiDmZJSU9Wcr
 CWykZ/+4jRu0X7Xh5JF4WHsYRs4iI5Cv6SSVvnehGT7F5RAbeoV6LNcBuQIrH6eNm7pL
 KUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748890651; x=1749495451;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6y7swCNA6ODNLbvdPI8+xngRE6DNsKyCd0xpyTFpqQ=;
 b=AFRpFQxeMsM1hrcc8qROe9RAjfSZkHnz6khE7kxTnHxkaLVfmrcwFDESQjXbhKG52x
 6bZEPWID1l6tLPv2YDGpfADJ956U6fQIcBcPrl+HGNEs2UQwyKyq8NisnPwOydtcxeqR
 bL7E9UUeuRtuUfc+YnfzkbSRHG0OnA5URtNIweBPqjQgyW05iSnTXZbBJ+/c1a5CZlgg
 HRWPFdnPhEd3PdjFWORfSwdsmz5/CpHiNi38adX9pgs00fW+AOhegKoSBqqpikjWqoau
 GGerb4l3wYNb5FebRSe+aKm9fAStsyKPFHa4FNd7c6V1wIwrmncnkKE9EtbRxW6vek3J
 TEWg==
X-Gm-Message-State: AOJu0YwoVmZh4Adg/NjtfOTG02xPwJipg61SRCDj02L1DVf65HX1ABPv
 j1NpOZo2EbddmOgP7p9YcNZwiKoMAya4U4uZzMdBwOMyRvmlzQgxawDwz3Wx1pU94bbhmw7swP3
 UaiV4kvzTaRgUJ9pty6r/8woBVpa3fP9ABxQJH0OnuqmF
X-Gm-Gg: ASbGncutV2bfLlDXsCdOJ6OvvPFtbQrK2XLPVUBUczjNC3VXOepkQS7VG9Ekx6+lE+I
 xICdxCCrF+B66QDvfBrrFtcFfMWgLr1hMIxj8c9uwRqXnDw4tb25sFpe8ZIV9aqRorQVHSxUwmm
 TtJWz+S9wBhymAPUi52eBnVbZ1pJNA5H7VbQ+A4g2Set0O
X-Google-Smtp-Source: AGHT+IHm/GByPbMwKbb/tx/cY+U7yWW7l3o6rMZOJz9FiPm86FeZE+2eO4UxPZ5EkQLMkxFd7ISkvrcmMBiPBvtYUSI=
X-Received: by 2002:a2e:b887:0:b0:329:1916:7a88 with SMTP id
 38308e7fff4ca-32a9e9b2df7mr23473181fa.6.1748890650553; Mon, 02 Jun 2025
 11:57:30 -0700 (PDT)
MIME-Version: 1.0
From: Behrad Elmi <behradelmi1@gmail.com>
Date: Mon, 2 Jun 2025 22:27:17 +0330
X-Gm-Features: AX0GCFsUD55Fn5iICZewFystM8_HLYKI3xoCx_cXZglKgrcQkW-8e4RbdRQRCNw
Message-ID: <CAFUnUVBZG5eV5f4sypeBrUhgJQGeYiHNKqx18p4N9o2c2_mL8w@mail.gmail.com>
Subject: [PATCH] doc: build: fix typo in gcc.rst
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 03 Jun 2025 00:22:06 +0200
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

From babe445ec1e08a9bd6d313980371c4b64494ac89 Mon Sep 17 00:00:00 2001
From: BehradElmi <behradelmi1@gmail.com>
Date: Mon, 2 Jun 2025 20:54:16 +0330
Subject: [PATCH] doc: build: fix typo in gcc.rst

Fix a typo error in gcc.rst, changing "out-out-tree" to
"out-of-tree" in the Out-of-tree section.

Signed-off-by: BehradElmi <behradelmi1@gmail.com>
---
 doc/build/gcc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index c76a7fbd732..1fef718ceec 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -122,7 +122,7 @@ Out-of-tree building
 ~~~~~~~~~~~~~~~~~~~~

 By default building is performed locally and the objects are saved in
the source
-directory. To build out-out-tree use one of the two methods below:
+directory. To build out-of-tree use one of the two methods below:

 Add O= parameter to the make command line:

-- 
2.46.2.windows.1
