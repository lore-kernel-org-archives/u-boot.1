Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE6AC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC1A806DC;
	Wed,  5 Feb 2025 14:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MaZt+S0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471B3806FE; Wed,  5 Feb 2025 14:04:41 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E7880562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 14:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38da713b9daso1813592f8f.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738760678; x=1739365478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=twc9pzaJKY/JZlA9Bdxrn0h5ljO6ZIhyZDnyc8wi4kU=;
 b=MaZt+S0N/pmIzmKDhvlvJNO1RmNsABgUDHB95LQeRdmhIfAWjajG/lSqFgQ3sEqwO1
 MtT3MkIV4ob2Fx/4Ey8Tjw0tpR0nSqSTwhPhy/2if8e7xjsOwCmawgueXOb30yxGFGzM
 aAViXd24SIOriWUPobynEThRgUcknqahyQ8RSY4wa4T5tKuWU8D28vW3h2brKOH07i+I
 nwPn7KiJeAwfYHcc6FvPbk7S/xrE9rCFoFnwHkeZsMg9eIo2HeXVxUIm6fOtZxspRiFf
 ONAxlQHex2DdVIUtAwA8TrfUsA4x0ZVi9wtmKkfQjkAuo2iyF83NmmVXgWhLqvvQDqMx
 jc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738760678; x=1739365478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twc9pzaJKY/JZlA9Bdxrn0h5ljO6ZIhyZDnyc8wi4kU=;
 b=SBk2LLIrA5uwb3PjBOelBaJRGcCwNkuFT4P5e27FlFFcph/D8JlX+FLCMbrbLpahZ6
 kyQGaVowcJ0LwLN2pzG9wqimxDkCP/4dWbYSI5f5MZmD+LGSQ9mgRAlf8PyP/eKfX9T5
 GoensEYa0Jl30EuDNxXaIcG6ShrbvE40ag/y0lrUeh4Pvcf/Sy/POLUChz+Zsa0HwsYv
 qp38FztszP/xb3Hf76SDSSVO4O7BS1A27q3KLducsIpDJBgsmW27/Xhw+BFeS9JIUY1R
 bk/CS0rFGYjfSA365kh79JCdK/C1PGHX9duHimSCn5I56uozG41Ai2Qd6NLWGu4ThnRV
 Ff2g==
X-Gm-Message-State: AOJu0YyrwpzBSun+oqYM3UPVbIpxsBCxPWVFDg80MmImRundONyszg7e
 Tdf4AoTuqFQ7N5vKjvRMuOJ6dgczWuROIj+OgrRUeHxwF7tqbXETI0ofuG5p5SoYmXvDvDGAuit
 U
X-Gm-Gg: ASbGnct4kTB1lE0kLTYACDrEvNOnSVMSVFG1zfPq7QqmUoT0jAPfc3xwvs0OM69HVRy
 5uPU7NzOM5RJuWON3k+dUrm/ml5uxUiehmE2CsHs6wchnjMpBGTV7nuSLRVqCVfBDDeZTNUIZja
 +y1deCM88G/Ar/9LR7f6bqTw1+QBYoRUXUOFPykydpsbM0tksr/ruaLrIA/eaNcLYAOglBr6pjn
 ks+plXt9gzs7peTLN++iuKiHseZ0D9MYPo9g733kCDgnHJOOj93KstbAuJlYLxqNGuYy88XVH/6
 VSFYLiJocJp4T1/S9F6SDO49DYk4zqs=
X-Google-Smtp-Source: AGHT+IF6QIq6HDrDTPaUhdCS/rWYuXnG8BbQJHvjYiVEq+PPUM3pbzlrlH2AErXFNhW8q86vf7bisg==
X-Received: by 2002:a5d:524f:0:b0:38b:ec2d:c0cf with SMTP id
 ffacd0b85a97d-38db491062cmr2329522f8f.44.1738760678309; 
 Wed, 05 Feb 2025 05:04:38 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:ee7:da01:45e:8dbf:25d9:d8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38db801bff0sm855664f8f.56.2025.02.05.05.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 05:04:37 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] test/py: usb: Fix format string for fstype command
Date: Wed,  5 Feb 2025 13:04:26 +0000
Message-Id: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

USB tests on ext partitions can fail with the following output

test/py/tests/test_usb.py:245: in test_usb_part
    'fstype usb %d:%d' % i, part_id
E   TypeError: not enough arguments for format string

So add brackets around the format string arguments to prevent the
error.

Fixes: a730947974e3 ("test/py: usb: Distinguish b/w ext2/ext4 partitions")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/py/tests/test_usb.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index e1f203b5cbc..566d73b7c64 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -242,7 +242,7 @@ def test_usb_part(u_boot_console):
                     elif part_type == '83':
                         print('ext(2/4) detected')
                         output = u_boot_console.run_command(
-                            'fstype usb %d:%d' % i, part_id
+                            'fstype usb %d:%d' % (i, part_id)
                         )
                         if 'ext2' in output:
                             part_ext2.append(part_id)
-- 
2.39.5

