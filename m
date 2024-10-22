Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C85ED2CDFA
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF8B891FE;
	Tue, 22 Oct 2024 18:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZlhHWtRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4842891FE; Tue, 22 Oct 2024 18:31:25 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A86188FA5
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b15eadee87so273051085a.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729614682; x=1730219482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pj8+5LCZXNDfIgiy8H8lOaG8PjOwM0E3ZeWWpG9OvbI=;
 b=ZlhHWtRhVDts+5ET7N0eTDPUS34WX7fTnD3furLRDr5BfMrlpir/3NIzGxwqE5JCTJ
 FC2MmPdr+MU09YzyBWlKoutb3YmO0jrTimJ48mDkk0vdKnQqk0SdB+5QZ1lx6u4dRd3c
 Tq8KbvF6RhDbTUQd3EYIhe+RnwS9WwJ8QatMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729614682; x=1730219482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pj8+5LCZXNDfIgiy8H8lOaG8PjOwM0E3ZeWWpG9OvbI=;
 b=jVU8hQtH5PBlau7ZpsAE20OogktyxjOGTRURqw5fD0JDwN1mAar23xnAeQYNot24ws
 /8kbXgdIJoyB95gMxBdK5F9GnRkATfnxxQYxz0UlzGcJwOm/AL1rGsnmD5LuQ8vDFJMy
 WxHikgTA/PsBiQdnEyF0X/Q097EomNBgEj85w6vtZy02X2CNff131MRjkY95JfamTtIt
 Q81ywrFya+NDijJBpBEjHm92lfaqLxwP1D1RvCi7murPXVLI6ueBUa1HDK3RQ3vtMEHp
 9BcbN2MG0iNM52iuHKDQGRm8RiZwizV1UbT6UTdoNcHYR4IDoQAjxe1SQ9scrckGGcY+
 ugDg==
X-Gm-Message-State: AOJu0Yy2BGrgnL3CTnSCjl1Hzq91Gd2gf91trVsL5G7ptvL9Nx8IL3Ed
 3aQnxhGSwNKBDIG/nCZrbetv+Ga0d53fUUr4WLqVFXYZk9x5UJPJjyxf29n3yvPQucRvgUDfIu9
 uq83/Hw==
X-Google-Smtp-Source: AGHT+IFI/lx32zUyx4JCwgbooPL1miO0jfCer1C0we4TiTQPrHktKaeZTqPQoZBB6dE2w7Hx9DwaPA==
X-Received: by 2002:a05:620a:1996:b0:7b1:4fd4:e868 with SMTP id
 af79cd13be357-7b176888e68mr419715985a.51.1729614682361; 
 Tue, 22 Oct 2024 09:31:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a5c5efsm293404885a.98.2024.10.22.09.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:31:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCHv2 2/2] cpu_func.h: provide noncached_set_region prototype to
 fix build
Date: Tue, 22 Oct 2024 10:31:18 -0600
Message-ID: <20241022163118.3128014-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022163118.3128014-1-trini@konsulko.com>
References: <20241022163118.3128014-1-trini@konsulko.com>
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

From: Jonas Jelonek <jelonek.jonas@gmail.com>

Due to the removal of weak functions in 7d6cee2cd0 ("cmd: cache: Remove
weak function"), U-Boot fails to compile after updating to v2024.10 for
mediatek target in OpenWrt with GCC-14 with error:
cmd/cache.c: In function 'do_dcache':
cmd/cache.c:57:25: error: implicit declaration of function
	'noncached_set_region' [-Wimplicit-function-declaration]

Thus, provide a prototype in include/cpu_func.h to fix a build
error in cmd/cache.c, since related prototypes are also located there.

The issue occured after the update of uboot-mediatek in OpenWrt to
v2024.10, in combination with GCC-14 toolchain. It was reported and
discussed in https://github.com/openwrt/openwrt/issues/16697, and
temporarily fixed with
https://github.com/openwrt/openwrt/commit/92ca322dd1f48158b8829fec59319a12e4ae4295.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Link: https://github.com/openwrt/openwrt/issues/16697
Link: https://github.com/openwrt/openwrt/commit/92ca322dd1f48158b8829fec59319a12e4ae4295
Fixes: 7d6cee2cd0 ("cmd: cache: Remove weak function")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
Move to cpu_func.h instead of <asm/system.h>. We do this because not all
architectures which compile cmd/cache.c have <asm/system.h>.
---
 include/cpu_func.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cpu_func.h b/include/cpu_func.h
index dba7d102e897..7e81c4364a73 100644
--- a/include/cpu_func.h
+++ b/include/cpu_func.h
@@ -80,6 +80,7 @@ void invalidate_icache_all(void);
  * Return: 0 if OK
  */
 int noncached_init(void);
+void noncached_set_region(void);
 
 phys_addr_t noncached_alloc(size_t size, size_t align);
 
-- 
2.43.0

