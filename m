Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53501C35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2155C80FF7;
	Sat, 15 Mar 2025 23:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1n1uR9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B333081100; Sat, 15 Mar 2025 23:18:29 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E548168B
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223959039f4so66751705ad.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077105; x=1742681905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5idqIpZMv/1NvxdmkDoua70IYimTcZ1gzRnKttSb7s=;
 b=P1n1uR9gZ4vkJErH+FAfTL+TnbCWRmtFz/LvLUOTjWiieaPEtfnDLkf7IBuvir69+V
 tAqCQ1WcX6FmOl12m138kwYSJq1bdOjcTcu6IeGD3jw8R1ku90Xirj4jsRrVQIAawW7T
 GRNzCofefZjYuo9qbxsCqGrNxxcbghEmnAxPkPqWAyU3xkUtWEKRaqT7tDVp7cDGL5ge
 8ToQsPI6xIj+QQzxugZvCoE2cawAiNvgZEaLNdOnHV/dCO/chAKX0UlrBCnWyKUC6Zd7
 A8gBfhroFAshFkcTzaUctDpQaiiTkBtHFTbVF4p1a6V7FoUnW/0lcvQIKClRmi7Xovgx
 /VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077105; x=1742681905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5idqIpZMv/1NvxdmkDoua70IYimTcZ1gzRnKttSb7s=;
 b=tHNXcK7SSl2yqViHIHIpNMHCc33h6yEAeD5rl4OSEogepeciDBjmHqX8brJQ1AszjS
 omSws+Ez7PwjSemHDbmc0iPhiAmHNh0UVf6M11FZSb4cN0EENth1YkfX08XPNBvpUe7T
 6x+lBXflr2t+JXD5PQJPCJk8ZXkJisi5Ii4OAGuELk0LJjiFwAK21Z+9C2WFDvSwx1NQ
 Av0/4Em2zCdE/VABbdgTiNLsNbu3poJJsCoW/p0oLGP3989B9fA2edgYk880R+oU38bE
 nFg+9thttm+oOAdBvqsAD3Aks/cYJJgWnJ2yjT0BAi90t1OtgpBhjw8raMjCSBcAkZP3
 /ZJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDg7H1FQd2/+gh2czWAOfo4MTnxEBkdK3dT/I4yLN6W0t2VPyR8DQ8UyEaMRStsGvasl8TVcg=@lists.denx.de
X-Gm-Message-State: AOJu0YweXOq4QEOdjA2dUO0gH+JHycF6iofkpMS9GWLen4pH2rdjQGIf
 hrr5pl1WrVtrbqp8Io9wx6o7SgmJ+K28DYk7vKFuCoo26Dvr47pW
X-Gm-Gg: ASbGnctf1hoQXWuweigZUvQk/4WyUu3CLkFUG0VsO85AyuRmErcNU4arHfkA/gEzES3
 6v5BJ8odik+bmSHIB1nAbsWLa6eTlDSbE5WP7Jhy9/rGjdDUrmRikTWv7qayMvpZwkp3sQ/PVEX
 hDl4TpQZcF6/A3OEqjassc5PROe4CUGLZ/AULF5jYDZjftHjeU5aN3TwSljNa38JQXqCShLoRbV
 9vI5Y6EO+9AxBTwD0wZOLi/j3A14aaIwo8zyH4Q4ahb/iwMpTHwR3ucn3AZSGu5hXuA+LmZ6H8L
 Ps0z1+hhZ6ZHqLIb87dfbg1KWjVXzdcgO4s39vcNR7NEbSOm3lJThC8=
X-Google-Smtp-Source: AGHT+IFZGbG2cEdLDy37QsrCd73YZPWafMIA9bVVo6vPM9xImOufdUTYnrNFx35ExWz9+6UWUUFQGg==
X-Received: by 2002:a05:6a00:92a3:b0:736:4abf:2961 with SMTP id
 d2e1a72fcca58-737223e8ef3mr7164333b3a.17.1742077105382; 
 Sat, 15 Mar 2025 15:18:25 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:24 -0700 (PDT)
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
Subject: [PATCH v2 06/15] arm: Replace 'adrl' in EFI crt0
Date: Sat, 15 Mar 2025 15:18:04 -0700
Message-ID: <20250315221813.1265193-7-CFSworks@gmail.com>
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

LLVM's IAS does not (and cannot easily) support the 'adrl'
pseudoinstruction, and ARM developers generally do not consider it
portable across assembler implementations either.

Instead, expand it into the two subtract instructions it would emit
anyway. An explanation of the math follows:

The .+8 and .+4 refer to the same memory location; this is because the
.+4 expression occurs in a subsequent instruction, 4 bytes after the
first. This memory location is the value of the PC register when it is
read by the first sub instruction. Thus, both inner parenthesized
expressions evaluate to the same result: PC's offset relative to
image_base. The subtract instructions then remove one byte each
(low, then high) of the total offset, thereby getting the absolute
address of image_base loaded in r0.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/lib/crt0_arm_efi.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index 91b0fe12c51..235b3a0c48f 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -149,7 +149,8 @@ _start:
 	adr		r1, .L_DYNAMIC
 	ldr		r0, [r1]
 	add		r1, r0, r1
-	adrl		r0, image_base
+	sub		r0, pc, #((.+8-image_base) & 0xff)
+	sub		r0, r0, #((.+4-image_base) & 0xff00)
 	bl		_relocate
 	teq		r0, #0
 	bne		0f
-- 
2.48.1

