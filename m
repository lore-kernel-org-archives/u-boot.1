Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2068CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 19:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03610803C6;
	Thu, 30 Apr 2026 21:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="M3c4z7MW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ACAF80433; Thu, 30 Apr 2026 21:13:15 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B432980086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 21:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hfranco@baylibre.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-61399bdd395so450874137.2
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777576391; x=1778181191;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lzLMHj+3ZW1p7OV0Ew3fHb+iGR9/DgMb4/uacI89Skg=;
 b=M3c4z7MWGEbJxpKFC6p4XbCwtEtioHiP3hT90Vbj7bBngaeeCydkSqClXam50JzctW
 qP/BanEvDKtrM6YK5dbOv1JSBMO+zTvaP89kOdfJw5CLzE6xwdNnq5Cbx8t5AZG1C3g6
 TCUBjdvf5SCJtfeVsgGUj3pj9CZmcRJ6rBXwG5QwAur3HDzEEG9PP3JmNxFb2vA3ns0J
 Dpr9ct5Qzjvvtj0ghYlK6NfCimkniU8cs8Lsms2crcjnTpix1SFo6rAA1pkAlp0rcweX
 ofs4MuLdhiFuGWPhf2z91XlbQich9qwvZkxowEZ2CyqhtoLQV4zJjnTKPu5SRy69LmbI
 JCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777576391; x=1778181191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lzLMHj+3ZW1p7OV0Ew3fHb+iGR9/DgMb4/uacI89Skg=;
 b=mSYLuyG1iOCptlE4DOAxYBN2RWVcfYHOXZmd71ciG0zf+lGYk8owm0+rKNxaarf+gb
 YchlHAPvwzso2w6oc8Osxpf3wx95qldplFR93ls1bfuE4783Z1ZRSwWRzVmen7PY4gfk
 IQLM6QfHgsrHH4RUpKYWs9tfVQHRpxCAW9QSLqnsho2s6gi8SXXRRoiIu3TfWZWVSXb+
 hoIhbS3dUVk+I8GA7ds/CCeQMSFmYRuwDTo1vJhsVgjYkx8JcSqEtXA0l0q+tPnYScMo
 CFL25aOFyPDkgtfidlG3FQioUrAWd5mt8Xgiq0BbXws5dgeibVavGZaoZ87P1Jhm4tbq
 Frqw==
X-Gm-Message-State: AOJu0YxwI1RNmpOGRof4MulD2eGNbJCTuFaYsouIgroSQODerLJvY0XZ
 wYdv9uPy0SbrIwZMVea4ecslUjGywQmiBPiypPj71I8nYjF251IdydPTlUOZ7DxQHgLZzPlqm+K
 BR+VDYZA=
X-Gm-Gg: AeBDievSWypVDVL03TQPfEfa5HB7YHf0xspEhibDOVnIWI/l91tbBT1b6OjWEOICo8N
 /wMd7WcM97JvNEXajT5VTe91Ir6/JaEr8B9uUbBfE76WDspjv96WUV10JjOQuuKVcEbfs4G0cRp
 Grsg5A4+30q2mxymZmFq0mQ9qa/cRfnLvHEglQQeusLxP69GJBvlgrgYanwKXAqZpl/1oJcHTx6
 Ow6Lze2xHCFVkofJfjnaihXhU875HT2W2Gz2cuJP3YuID+ZHH+7SVtS9fk2OdFtBUsoZETDjiCQ
 HL9cMdSCnSFKzucDddUAYm8AxHELBYgg5XxA1mV9a5QCCxbb4NcUHF9swLwq+4qnp8k+rvwtL3H
 TZAWGKtv96PTg1J6lRng/d8uL5aSk3gLFYC0nQPdKsdRC3hkQzfyqNvh+ozGtzw5kEGdXheJ0JY
 YxTwxkBwuxFGdhqX3kFU/bqpBFbrjy6b7ucIobvouKfGryKVREp/O/DmF9R2ovf+p4EaYJo5IxM
 tXo1bWgoPMV0G0=
X-Received: by 2002:a05:6102:32ce:b0:602:7a74:fbbe with SMTP id
 ada2fe7eead31-62ada94f75amr2641008137.9.1777576391270; 
 Thu, 30 Apr 2026 12:13:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c5:9534::3545])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95ce0897ee7sm340213241.3.2026.04.30.12.13.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 12:13:10 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc: sophgo: licheerv_nano: fix incorrect step numbering
Date: Thu, 30 Apr 2026 16:13:06 -0300
Message-ID: <20260430191306.64628-1-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 21:54:39 +0200
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

Steps 2 and 3 are incorrectly numbered. Fix them.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 doc/board/sophgo/licheerv_nano.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/sophgo/licheerv_nano.rst b/doc/board/sophgo/licheerv_nano.rst
index a75c6a37dc5..a3b1171287d 100644
--- a/doc/board/sophgo/licheerv_nano.rst
+++ b/doc/board/sophgo/licheerv_nano.rst
@@ -43,9 +43,9 @@ To run u-boot.bin on top of FSBL, follow these steps:
    FSBL, OpenSBI, and U-Boot.
    Note that you will have to use the file cv181x.bin as the FSBL.
 
-2. Place the generated fip.bin file into the FAT partition of the SD card.
+4. Place the generated fip.bin file into the FAT partition of the SD card.
 
-3. Insert the SD card into the board and power it on.
+5. Insert the SD card into the board and power it on.
 
 The board will automatically execute the FSBL from the fip.bin file.
 Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
-- 
2.47.3

