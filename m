Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B4CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C566B83FCD;
	Tue, 18 Nov 2025 19:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JCrmM2LZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6F5842EB; Tue, 18 Nov 2025 19:04:41 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F8E841C9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso1642155fac.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489078; x=1764093878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M86s6SasYYXCJcFEi5Hpl6oTV9xdOBke5x0F5AMpsy0=;
 b=JCrmM2LZEl5bgfTkMgevRM7Y6sYK4qt5eI3avG5GHEQiP/2QCJluu5v+KcTttm2N/A
 /WnLBU6HGsRhnEe03Dlp0kyUJOWl5F+BkEXdhoqcc9wYHV7Ayf7PY3CzynQe1LQCop84
 j8e84UlkZg1iJ8oqw4kewWPKzKs3+bV/O2FiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489078; x=1764093878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M86s6SasYYXCJcFEi5Hpl6oTV9xdOBke5x0F5AMpsy0=;
 b=fTZm6ci5TAKei4gPZ+8PdkG7jZO62f7Zxw+ViIAgU1cxsaJHx5tL03Ie5BBWIYT0Wj
 yEWJLlAHErGmxPwfFhuITzmxnkV0OlpITkII26udRTbVG494zOqvEqG6TOX70IFuO6aU
 5WMJrHFtBMOrbYMwMdw2A+FDFcgEpfNFAQp+wUmxd3afcE6oDKoGzxLFOloD54SQAYWh
 qSAGBUqou6kaFVaKixwmii/PaMrJjVjWTIDLbbiZ2JomSmdX6obXxxLIb4OyYg1orQVB
 0epJBinwgI+L2U1K/1Oj7+KrgYbhBc7AGBzY8yaWrqRW+ZgBB8izUdZWEmb2VkyMLZ74
 p41Q==
X-Gm-Message-State: AOJu0YzitIFazyPK4O8U9+ob3H8RzSehB3PI8DzSMBOYH8vAmK6MZ4Ya
 V169NO5KqnAqtJf2hKuda5Pmqoxk5JK7pLN4QgR7vmGiQ0F9heps/AMcmyR/OO5dRsqUGWTgTds
 +/rm8KZQpYA==
X-Gm-Gg: ASbGnctzBPEoftSJVMFt6l1sTb0BVbJwFBn5aRG4KZJw0IV/fqLlN6R768/RJYLeDZi
 XRroMB61dvamVH8oiwnfZRwzi3zlKb7IwTd0FvUOsDZim3UIz0TZM0INq48rPvGvKeI5f3qyudk
 UVg64TaUhm5569Ay4NjLQ+vrITugWCXBfM3Mih+rPEphaPhQF3eUMxVp3Pso2T0y+heoiK+5UdK
 C4W00kzdfyuz4dYLQy7kUvjYPnqp/wqsmGdn/jQXq62Fn1ST7ms4Viao7zusF1FvQwyG+k7JwS0
 PzT9k/ZUpG1o/C0NR2gAZAVGo41liB9oQsn5Mol69s/kFfJ2FFjIRs+mCOi8JP7xPTLMK/0BgOH
 KIXXckMpCiE6E+NGob3CH1XDuiIEvmzvRPK75sPvDaoBLRr2YVMd37y8MDc4RnmYM6Wfr2O6cAD
 yPwi9u7siCDetrfWPl+ydRQG0QhdogKszsJDOVCw65hh1HKUkyFP7o
X-Google-Smtp-Source: AGHT+IEGctZGi4f8GXEvEi/WoZDmBewbX8Up8UneCqM/nVJgDNcIAbvstFa03v0wbkr2Ck0WKK/4rQ==
X-Received: by 2002:a05:6871:28d:b0:3c9:7b0c:8b60 with SMTP id
 586e51a60fabf-3e868efed0fmr9112766fac.2.1763489078211; 
 Tue, 18 Nov 2025 10:04:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522ae6e2sm7117353fac.16.2025.11.18.10.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Breno Lima <breno.lima@nxp.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>
Subject: [PATCH] udoo_neo: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:36 -0600
Message-ID: <20251118180436.591518-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Breno Lima <breno.lima@nxp.com>
Cc: Francesco Montefoschi <francesco.montefoschi@udoo.org>
---
 include/configs/udoo_neo.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/udoo_neo.h b/include/configs/udoo_neo.h
index 4ecd71f96537..8e784e9f0cdd 100644
--- a/include/configs/udoo_neo.h
+++ b/include/configs/udoo_neo.h
@@ -21,7 +21,6 @@
 /* Linux only */
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdtfile=undefined\0" \
 	"fdt_addr=0x83000000\0" \
-- 
2.43.0

