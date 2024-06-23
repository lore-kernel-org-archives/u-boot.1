Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF927C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A6488535;
	Sun, 23 Jun 2024 19:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EW0fbqL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0183A883B1; Sun, 23 Jun 2024 19:53:28 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C2288327
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7ec00e71a57so138786439f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165203; x=1719770003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Dt1YQ8kz+5dtP6ojgtt4IA7BEq51QeUBf6Sy4i/gbA=;
 b=EW0fbqL006aZ8YRBuECa7PHqhA5549KrsNPsPThU2l3PtoNPthj4xGqV+rNKlJXBj5
 sRj8++87wb/wIFZiQBLU69YwVVCs3p9jLL5fV5YAZuqbybj0Rv+EOFIg0tSmTArCL/cK
 I8cJL3yZbqRtMHNayJpgswsJxiQKFDRhJdDrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165203; x=1719770003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Dt1YQ8kz+5dtP6ojgtt4IA7BEq51QeUBf6Sy4i/gbA=;
 b=ANOAheUR/KTJuoLipFNfnB629jNdRM0tr80tTE80D8ApnzJxv2QbzocgAQ6IDKSpxk
 542iCUGuwTbN725BJ2ShWYkMh4r7C9z3HT/+BQv3pG6beK+T4/Zm4WAARZrSiGlyCBXS
 Xc99u1i7PoCvH39M51vzjfonXEcNDLBclKH3EGIuhOqcbmPd0B5oj8XNFRdavPYYW05I
 gRRQQ20qmeZt8Kyc8Cel2I+tI45MOWEx9vMtdAYfNHVhQI0CY6bN7pf4Ha6WBM58IZcs
 XLmiiP5HyUgGMGUZPPPR04C2tKWnpZHp7D1+d0ppBChvRo2zXHgRbQFUos/wiwrXfCMG
 bwwA==
X-Gm-Message-State: AOJu0YwaAtgdxxV4TnC+H8DCks/c1wz5nfmgov1lZBqb6aOkZujnB1DW
 XDEzVN28NxgHSAw1xgbPHjMnG/J94kCcxGopkP6tS1lvncNmaJhLN/1stovS0slaSd3SDKiH70i
 Vqg==
X-Google-Smtp-Source: AGHT+IHeHaEDJ69ryc8VFxyPCAPZuHq2Bjm1sKb09VG/DIi4wbelAJJYWZifqHM2TQwLaCRixlm1VA==
X-Received: by 2002:a05:6602:14d1:b0:7eb:bef7:c17b with SMTP id
 ca18e2360f4ac-7f3a7810ee8mr422050339f.18.1719165203195; 
 Sun, 23 Jun 2024 10:53:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v4 05/16] binman: Keep the efi_capsule input file
Date: Sun, 23 Jun 2024 11:52:51 -0600
Message-Id: <20240623175302.1463973-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

There is no need to remove input files. It makes it harder to diagnose
failures. Keep the payload file.

There is no test for this condition, but one could be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes in v4:
- Drop Fixes tag

 tools/binman/etype/efi_capsule.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 47da5da324b..03e55cbc4d9 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
                                                  self.fw_version,
                                                  self.oem_flags)
         if ret is not None:
-            os.remove(payload)
             return tools.read_file(capsule_fname)
         else:
             # Bintool is missing; just use the input data as the output
-- 
2.34.1

