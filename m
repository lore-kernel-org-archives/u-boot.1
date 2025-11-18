Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7402CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803D983F24;
	Tue, 18 Nov 2025 19:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JZeGbIPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C4D83EDF; Tue, 18 Nov 2025 19:04:06 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DFE83E92
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e80c483a13so3176571fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489043; x=1764093843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P7s44kHKmIlntivDxvhz7vcrlh0gPmnTA2/PydaDti4=;
 b=JZeGbIPbONEw+5RT2qaF8di3Qpr/lT2uO9rtrj4TeC9MyQ8DW4ZqoUEXOrzcpO/x+e
 bgDDehET+Hs/a5HOdA7JZRkvHFUX5tdYd8mINN4LhZbLi6d95ewgTmt/Db+WFp3/prKE
 7iz1kWSzVkK8UhJLmloYC9H7dNzsoEHgLRSfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489043; x=1764093843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7s44kHKmIlntivDxvhz7vcrlh0gPmnTA2/PydaDti4=;
 b=p/JMvHK+bUDcHzCSfix8ah7qwrIRLVGXyojH9O2U6WFa6f1SN9a7KmH/SPArCK/d4r
 En0PDGOsb4+7h1BzoIvm39x5xzqLaT1uWK6lT3Bnn+XuXS3ZmWMiXeIlO3/1jBUnCDyS
 zIA8BpQZ8inZ/liwxvIXrBF6MwqNgw2GIQ6KT3QO8X9xoCAc1DEFYoBg67hkz/thuFNA
 5GCKhJ1DF+Fxh0bEJ06mFWZGdwu7Nx+qmt5sq/zlKLk9Pfjo9EkDCNijW0RKbBXddKar
 YCeYSXeY07YZjoH7Khu6QXXmbk5a/DR6DPwlaWkPeH6BKPEuUuMkyexZntr2LIdvaY95
 k4TQ==
X-Gm-Message-State: AOJu0YzZ9UXSron4mr9oL19JXZlpRaTzDgNZMZbDxdipGw65ntMms3zb
 4GdbEylY20sW05a2y8YvbGiYANxMDafMcP/5fJi+mlu43XYKON+steZHI4FypJv7Sv1vJwYXwaL
 cs56uB6bS7A==
X-Gm-Gg: ASbGncvHqoXokgRT3ntaqGOsbKxCUiUvKEWOEWYumLDwQ0zE+IL9OwQ1ljvV26hOsq2
 +AgTnv07UmlUMoTfNYB4EvAHd9jsft687LDa52XfSS0Gt7I/eusNY5rnWeiLpTVnmtb9iu2+JTm
 uuVZ0jrCbgW37QlfF2OliBwcp1e1TeprU65JuD5uQPB581T36FF2zSrzbUjbwGTPVx2gfXBEIY/
 XXMPIqOQFfo2sQ/UjnFfpa8eA1J2w0uM2LPN18rlWShoqfrf9EUNzV/ISFq1L8FSA/qCspfReEp
 UvZF2XzDLEN0S1HxVvl+jH/b1nl9pj6o2YZAiPrzYk24awkzjKRfEYt9UyO5mvLWVwu0N6rCljm
 5saHgnlUitlEej3dOS0WVD9DAp8gOxZQchhX/MimyBKzwZeKfUZzl2YXh1PLYCiMdicKdS21jI5
 3BmBFoKtQPkwXaS/mHb9yrsz+X5APQqWHWBeDSM6vAhYRqCxyU9WxP
X-Google-Smtp-Source: AGHT+IFb6qbrJ0CSFer4meZfIWfe+IU8lFfwSq64H+kXqNBDLM9XCpKSBoncLvOIiqX2lhHe/63lsA==
X-Received: by 2002:a05:6871:e485:b0:3e8:9447:3000 with SMTP id
 586e51a60fabf-3e894473349mr4898188fac.52.1763489042543; 
 Tue, 18 Nov 2025 10:04:02 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a28428bsm6907573a34.1.2025.11.18.10.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH] kp_imx53: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:00 -0600
Message-ID: <20251118180400.591100-1-trini@konsulko.com>
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

Cc: Lukasz Majewski <lukma@nabladev.com>
---
 include/configs/kp_imx53.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/kp_imx53.h b/include/configs/kp_imx53.h
index 78c6c67ab99f..bb136b7e1290 100644
--- a/include/configs/kp_imx53.h
+++ b/include/configs/kp_imx53.h
@@ -18,7 +18,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc1,115200\0"	\
 	"fdt_addr=0x75000000\0"		\
-	"fdt_high=0xffffffff\0"		\
 	"scriptaddr=0x74000000\0"	\
 	"kernel_file=fitImage\0"\
 	"silent=1\0"\
-- 
2.43.0

