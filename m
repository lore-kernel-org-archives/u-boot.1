Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C932F436B1
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 05:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01B083BC8;
	Sat, 18 Apr 2026 07:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=elder-tomes.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=elder-tomes-com.20251104.gappssmtp.com header.i=@elder-tomes-com.20251104.gappssmtp.com header.b="U/BbYlqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F79484214; Sat, 18 Apr 2026 00:45:15 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898C38405A
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 00:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=elder-tomes.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=levi.shafter@elder-tomes.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so490819eaf.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elder-tomes-com.20251104.gappssmtp.com; s=20251104; t=1776465911;
 x=1777070711; darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNOGT0mFemBN8Gg+35AJuygJtLtf2CfupDW7HlONzjw=;
 b=U/BbYlqq7qv3mtHW3hrix4d5aKfxayXY8rOpWxHo8MHFBdZ/7zc9yJR1Y2B9R2fkU8
 DOx0mVPgIW7Bxg2mVSlqZgLVt+/wA+hnQ5mSYxjHj3Ux5UjTRyVTBdjhTKx1GcIImAa8
 s8mux9/b0D5IDwnC7/4ihJGRWxibu9y4cK+FPd32ERAcmedyZ4Iy2A+Q35lDUcw5b03E
 h51+oTzieOKa+x3fg4V1FrhmOiRyXoaX2NIYewYkgtAoueAAsFwOGHAIrK+ZKcZvGpis
 1MxRxdq9A1cIn30B0jugQx18LnfWy9mD8pV0ErfhIGZfiySEqeXoS6AmYBhCPihw4G40
 ntwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776465911; x=1777070711;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MNOGT0mFemBN8Gg+35AJuygJtLtf2CfupDW7HlONzjw=;
 b=nG/wrJ61ArYnPOIRohjVSDOvlBHpAME2BmAKaHB7jZcIBcHG0wLEdWWn9xgJG7Lb7n
 g9RnXjdXOBiwArICiC/C6Ki6dI55plTHDLy38pGzHTNjo53UGQvdL5NTDXPur+/bgNsZ
 mAuAwI+PI3/ERcooQGjCRvg1jUmSN8TWNtPTHiTPAJCCz9wiFtcgpGY0OTjrOuxcTcM0
 /0VOsQGljhQJ2o3G4WHwtWzH4Q5wgmbgs9K46RcKiV/fKpO12McwqQyM9Mm9fek0+07y
 foAt4yEgJ8h+joeHHv7f3xhgAURpjVx0x61jCsDfOufpHoI5cEZWWYGyvexf/Idfkmub
 jfPQ==
X-Gm-Message-State: AOJu0YzjPQAyk70rZB5A/hJsatQh9VkxmMrp/x7H/5IdVtX+N7/P0qCf
 aZclfRyvRAheeQA/vEtmo78kco2HZGTGPZm1IYY3Hfl1avlMSfExakNwchR33iCUX2sD0ihos50
 Fco4v
X-Gm-Gg: AeBDiev2FXtQ2FOpt2uBd2iEXmaQtAaR6CEmGy3/ZaR4eJ3XYuKdWH2LlQVAJtev0Zj
 AhKhqczdYpBL6qFKNPdks7SYG6xQqrMXkjedxyQ1bpfr+UBb6x1UdaB9/qGi+jFqrOXPtTrM135
 jyD6ZGu/glv+wZbc80Q3hejTDn4euGI7kTNoYTd8eG9jAtuCs/HdlGeSjpxvmOGmtNMe6RDFcDS
 vrShE02/jZf1fu8EsEpQA/n3IiPNcQXLKyo4CnClo157rq68+7tK/QwFwSNWpOKHoKtCyNC/1ba
 xadh4DAFZpZ5iHbMwUDJx0qqGexSiNnxyp4FpfavAIYo+S/TsMugXJpwiw/3K88ndBKO+UIYWCq
 HVugCxx4xDMP6jC9X7nG9lri8HBKnJ5PJDCocFX6iaHoLpO9AFneZSWz532OqHRYtb4LXleuYtP
 2Jk42KQ1pxk4Y4RcQ1T4X+VUh339s7fOCbFCCUidUbkRiYJAMSQiIpzvCm38v0B1sM5Xbds/jQv
 TVXcoPa2Dk=
X-Received: by 2002:a05:6820:178a:b0:68b:f68f:86d6 with SMTP id
 006d021491bc7-69462e7f140mr2650224eaf.26.1776465910637; 
 Fri, 17 Apr 2026 15:45:10 -0700 (PDT)
Received: from [192.168.1.9] (c-73-169-9-114.hsd1.co.comcast.net.
 [73.169.9.114]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69464e5e752sm1764931eaf.2.2026.04.17.15.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 15:45:10 -0700 (PDT)
Message-ID: <732a4d19-0e19-47ed-9f8e-0f28b8c50f73@elder-tomes.com>
Date: Fri, 17 Apr 2026 16:45:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: heinrich.schuchardt@canonical.com, sjg@chromium.org
From: Levi Shafter <levi.shafter@elder-tomes.com>
Subject: [PATCH] Makefile: fix host CPP pollution in cmd_gen_envp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 Apr 2026 07:55:55 +0200
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

Commit 2956a84 ("Makefile: don't use CFLAGS for environment text file")
switched cmd_gen_envp to use $(cpp_flags) so that KCPPFLAGS would be
honored when preprocessing the environment text file. However,
cpp_flags also includes $(PLATFORM_CPPFLAGS), which carries
architecture-specific flags such as -march=armv8-a+crc set by
arch/arm/Makefile for CONFIG_ARM64_CRC32=y targets. These flags are
appropriate for cross-compiled object files but cause the host CPP
invocation to fail on x86 build machines:

  cc1: error: bad value ('armv8-a+crc') for '-march=' switch

KBUILD_CPPFLAGS already accumulates the user-supplied KCPPFLAGS via
"KBUILD_CPPFLAGS += $(KCPPFLAGS)", providing the behaviour 2956a84
intended without pulling in target architecture flags. Use it directly.

Fixes: 2956a84 ("Makefile: don't use CFLAGS for environment text file")
Reported-by: Levi Shafter <levi.shafter@elder-tomes.com>
Signed-off-by: Levi Shafter <levi.shafter@elder-tomes.com>
---
Sponsor: 21SoftWare LLC

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dfc95d314dd..e2b8e6a1915 100644
--- a/Makefile
+++ b/Makefile
@@ -2147,7 +2147,8 @@ ENV_FILE := $(if
$(ENV_SOURCE_FILE),$(ENV_FILE_CFG),$(wildcard $(ENV_FILE_BOARD)
 quiet_cmd_gen_envp = ENVP    $@
       cmd_gen_envp = \
 	if [ -s "$(ENV_FILE)" ]; then \
-		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
+		$(CPP) -P $(KBUILD_CPPFLAGS) $(UBOOTINCLUDE) \
+			-x assembler-with-cpp -undef \
 			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
 			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
