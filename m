Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A4C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4C380FDA;
	Mon, 24 Feb 2025 06:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M85+arNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE2180F67; Mon, 24 Feb 2025 06:56:10 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1701480FBA
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22100006bc8so67374965ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376566; x=1740981366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLmtr5Cd9BiKtoFr0qW3BsLi7LQdCugSkDtTNMA/w7E=;
 b=M85+arNhgr/CQHsn6JpXeKQWFSnhI0GNNYYwh29PZGhRRpHr49cTVF2EqXBVANR5FY
 ANMcKhEfV8RSKp82tmMg2iPYbEtE7j/gAy+knQWLwgLSqG+z2pQP6K5wIvFUWd9NJ8z3
 T8gfobwd+TnC+NoaGvrcJ5IKS/UpPHb4eFF4QDFGvbOcUmCUUwTTgcA91rq8ifKt57tv
 fPt2g/eNEZm+U9Sul1v7tMYCp9Q8dMq42LE1sVa36bbK9kIpM6ZDVwesufL+YgVujEyL
 3j1jiH65Qlp4o14Mxyr/xTQrSzf6iB9LCACLMk5ffZ/W9TgcAjbk/0js9/FZ2L+WJhdK
 Stgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376566; x=1740981366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLmtr5Cd9BiKtoFr0qW3BsLi7LQdCugSkDtTNMA/w7E=;
 b=r4lftTM+OeKtvvKONIPcllGs07UJFMaIRVGYTCTBVJLbpUV7Ci56WDJdQ1b3VaNyIL
 3i1r76+WgZ2BZGKp/fcfDQ+dKiY5FgCnsBhyholdRVRVgKx57uABvMZ3/T8s1I1Mq09x
 FAuPGoa1BGMGGNm57yE2xS9E4MbvAJsAKP5tpNiInz6wHUqFte3LRMRUV/+UExeS0i5t
 qzoh8nR7Rb/X9XXB7tH3lR73CHD3Jml+8rwFMjvcPwMCFdFOgwyWI5k1t3g8eKsiKfpt
 qQwwPH7XSAVHHxpFaY4MvTzHJgUtHfHn2u9+ImVHnnDAU8by96gRMusG4w3nJN4wzHhd
 SNqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFJcQ3IHhkYEijScW2/aaRj/6M8lVmOXwMu6iJSpiVd+Uv+2xGZkqQsZPc7hwi+v8FKPxig1k=@lists.denx.de
X-Gm-Message-State: AOJu0YyK2Jv6378W0UO4oato6fZ5wKcU/saxNqYWWVNElfxZbeljfTT2
 n6nanUW4mFxfmyJSCkLt/DGVBPzDj4dh49ZMorfpDWnRdErcE9LB
X-Gm-Gg: ASbGncvzxRziGENe9W2PA5ZH6s8fl+9yURJOc0t7wjY5Q9/4Kym4HCuAEUjXba6A9PZ
 8tet4uMoWtpRjmZldy59MtGSPq+L+bHXBHDu0y0P+6S24wRsOilOOkNTN/ysEr/JX+LeLW6kKPQ
 9eTKHW44MN4NW4mKz3+QN2w1SHWM2VHgLa1OVJLZY/8Y0eldjEo5kwjbD0PVcwVkm6MUhTCbG5K
 bN/OL8n2ukZ6Mp0p/unWBx2/2eZJzrKK7Dcys0wukrFKmI39CFMEblnh698ZrafWQsnNOWXjNpW
 BYKHA6HaPZD9uTJgWZ+INZZAYQukMEdqVs2Y8Q==
X-Google-Smtp-Source: AGHT+IGrHy1kU05eBZGiMMkGo+Orul0eXT3kG9Bmda11Iprcn0K4NqkAL9gAsh/W6YPeO/m2dPikWA==
X-Received: by 2002:a05:6a00:22d6:b0:730:94e5:1ea2 with SMTP id
 d2e1a72fcca58-73426c8d91bmr18751829b3a.4.1740376566358; 
 Sun, 23 Feb 2025 21:56:06 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:05 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 07/17] arm: Replace 'adrl' in EFI crt0
Date: Sun, 23 Feb 2025 21:55:14 -0800
Message-ID: <20250224055524.1334929-8-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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
2.45.2

