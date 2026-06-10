Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CA0CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE8E849D2;
	Wed, 10 Jun 2026 16:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIB2Xv3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CCA8848A1; Wed, 10 Jun 2026 16:41:39 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B78E849DA
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68b5bae70easo999816a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102495; x=1781707295; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GF8WuFKWJST1PgdxbA0uoeyPt8My6fqf2JPt1sx3pCI=;
 b=SIB2Xv3JWYPTSEkLCdkGFp7eWqH6smHRquGafCbwXnffxoUuk0ZuIWwYiCbtGt6F/r
 ifHO/qqeTGPZobIGeFcf7vJj09LoOwnrZeJJQs5YC6RCxpnu9mMNzNSNehHzo/6MDD8K
 TjwLleZxkjX1QwNPCyi3z9pvRfs2LNX8M6q9PCjkAb2egv6KPmfCiKvFqkMqKVz6b8K/
 spie4cYUgfK0yzp9OrQXqnYcx5hiLArBhXBFTHmJ6jaUC/5XuvR3bppsx6DWT9S1DgU/
 hoOPinm0vN+YSxza87dZN3DHNHP++vAQZlJL4R5SEWPFZMqxlq5+VYxMhMDlUHZi9trT
 JKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102495; x=1781707295;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GF8WuFKWJST1PgdxbA0uoeyPt8My6fqf2JPt1sx3pCI=;
 b=YPc8qAoL+P58/kS+x5Aucq2f6RgqIiWYeeDhpycA6RYR3Ou4r1aNBV66e8J0EE6aH4
 ajy53TlvOOb6t9TinWj6Olojzycy1BGKuCF5S6NSuD/i4zyFQIWQGQGfdclKva9TQJ3s
 UvZJL1dqfgF7PgndH7QpT7gkqISwzmS7vOLHBh6m2RtXgh7L8SeI7eOB71tPDf8z831v
 6VZ2Yd7b9bcuKsg4IDjBjHaOME5iB05jtNv0Nj7Bcx21Ie06L6/5nDhbybe8P1f9xt7e
 Eucxux2U2KGTzeWSDaMGfnaFgKy0M+igWFyAs4lxiW+no/SLy5DW2ZuOXXZC3663Uz5U
 HqVw==
X-Gm-Message-State: AOJu0YzoZStZeYhWel3UsMzL6qB0waEPz7kRqiW6KmcMCmUBIBCLZsBv
 IXCJW6JUkIDcti6C9UloyL8wjNHcdiUNSx5n9gUdvYNGeJTF9U96xUqP9qf4xA==
X-Gm-Gg: Acq92OEUnk+tgHPnQBn8eNRdhWFf1io2HP8Hy/437s7WywLpaP6KgfGyh0oG1s+a5s2
 1/sziTZA7uVvCWq8YZwO9olslanvVP2ngzWqlsnfvggiZLmT6ARsX4yzfmu5gv3buKROD7PlU0k
 BXUPe36WZpgBToxPHPFKOd5QPpBxssks2HwfNEPY9JE95NhEIZinwF4+YsKajzZT2qrWgV46ziW
 h4xUhB0OCl2IamqoVtQTKyenXkPgyD29FoYhhYInto2v79JECth+H2rlbi4ECHCCdxC1nSef9RV
 JDu5puzsnkzHQW2mwQUVN+Ha/ISHPRVPyJyE1Nv5G/S0ErREnDbn6k6U5bX2Ng2s4vcJBDSQaq5
 SIg2fn/tchjmEWUORbIghAdT654BopV1lP/1qmkUmpPaW+4gHfc6EVgkAar6ifjSpA/WIWbuNN4
 tVwvkIemACqYcKqiaEdrf22Q6B7iKldWy/IS6HgugOBAkm3lEq8Xkl5G6/lZ8V3bAT3t6R3Z0b
X-Received: by 2002:a05:6402:5194:b0:66e:a6a2:5e0 with SMTP id
 4fb4d7f45d1cf-68fa5047f22mr6172286a12.6.1781102495382; 
 Wed, 10 Jun 2026 07:41:35 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e6585154dsm10012715a12.15.2026.06.10.07.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:41:34 -0700 (PDT)
Message-ID: <bef53c21-05be-45a9-88df-ef2f05007791@gmail.com>
Date: Wed, 10 Jun 2026 16:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 18/18] Kconfig: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle Kconfig:
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Kconfig b/Kconfig
index 8428d039a1c0..890f89de1214 100644
--- a/Kconfig
+++ b/Kconfig
@@ -193,7 +193,7 @@ config FUZZ
 	select ASAN
 	help
 	  Enables the fuzzing infrastructure to generate fuzzing data and run
-          fuzz tests.
+	  fuzz tests.

 config CC_HAS_ASM_INLINE
 	def_bool $(success,echo 'void foo(void) { asm inline (""); }' | $(CC) -x c - -c -o /dev/null)
@@ -308,11 +308,11 @@ config SYS_MALLOC_F_LEN
 	default 0x10000 if ARCH_IMX8 || ARCH_IMX8M
 	default 0x2000
 	help
-		Size of the malloc() pool for use before relocation. If
-		this is defined, then a very simple malloc() implementation
-		will become available before relocation. The address is just
-		below the global data, and the stack is moved down to make
-		space.
+	  Size of the malloc() pool for use before relocation. If
+	  this is defined, then a very simple malloc() implementation
+	  will become available before relocation. The address is just
+	  below the global data, and the stack is moved down to make
+	  space.

 		This feature allocates regions with increasing addresses
 		within the region. calloc() is supported, but realloc()
@@ -420,7 +420,7 @@ menuconfig EXPERT
 	  Use this only if you really know what you are doing.

 if EXPERT
-	config SYS_MALLOC_CLEAR_ON_INIT
+config SYS_MALLOC_CLEAR_ON_INIT
 	bool "Init with zeros the memory reserved for malloc (slow)"
 	default y
 	help
--
2.39.5

