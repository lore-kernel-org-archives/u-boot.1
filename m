Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C20CC35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B66A810EB;
	Sat, 15 Mar 2025 23:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2HLY4iS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A19809A4; Sat, 15 Mar 2025 23:18:22 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9950809A4
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so943447a91.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077098; x=1742681898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qQuUJzPhcB3525WwsQuK/LkKz++dwAR1dMAUbWZF54=;
 b=d2HLY4iSMIAm+KrLtSC09SCsP6iXWUqNKnxhEyLadwcQ+rLIMWJweyxaslXhRNn7wD
 po84nhy8kkHCRJxd5cb2+j8PVQd/rXduAEIdWDkGr34amEC9Fwxs60OcrjrhPazwOFrA
 LBakqMXEupWTN4cChARjxvyVk/gT0diKJiv9wJaeCB9KbTMRMzYMkYAeBqqSLnN1+OBE
 xmQh2bZw6biyj+qXbFXUw7lcDE0QIfg6DUuRKZT71Fp4bXb+hF7EtsgWxCH9w63Yf2MR
 /wq6elEZeufUKQFth4b9npMP/lyK5FeAMtqY6tfGwoye3uiJcBq+vNRysk3T1JgaPZpq
 FPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077098; x=1742681898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qQuUJzPhcB3525WwsQuK/LkKz++dwAR1dMAUbWZF54=;
 b=VpZyCe+Q+dOdWUEx6FJrcsFHJ9WNs8sXWfacystg4mOxt3hQRfrfdRdaTO12lwTcUk
 EYgCiT7jVkMdBntKgYLi2BlZJyklplLIhiNGk4CX2WbEK5HiNGbcxNFJBL+heElsyxto
 yXWlV3sHcpRU6AzjgAyyLOOrO7Ajkq8U2uptyuhhASXp5ATDvazVR9zhoPGprXGLz5VE
 TgNN/t1/i1w3/6GLh+MT8wgtJOIwIhap0qSfTF6dwobeys/dbEeKSNHOjVEc2sfBiN+o
 e6mecNzf38BVQuLcybihBP5q9XMuMGsCvHjBH5Yjt9OfMF/QFtRE7RaAfJmmHeXIIpHY
 bHSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/yOP2eILPoa20KMez0yXJBdZWwuHi3hOKzJjogu+77FFhgC/RJv6PoJZgQjc76StWAsSS5/0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3drb7lJhgbI/iLxRDYEI2mfA5VFOtHzefJW59/epm/kDfc3Yl
 Epx5jHJajRw6vDR0m6OmWZKwffLMXAGQaq02hBxnqpqxtXYLH8Un
X-Gm-Gg: ASbGncuBUrDr3v55YWL1wFIOcbIW5UrbGQaqi/sM5AZlh2+NJFDV4tWugYFy6GYJocx
 QhSj0sdIEn2GqjrmWaXnYs4/IcSF4p/Hsd9Y2+oByUlISZHBB0ullDXJWkrOK0K5gSn9vad4MUv
 rpIm48U6JnBvF1BA62fNHCDJ2M7pVuhXFKy+MzTWTRefpM0qb2QeXZwRx+F0xh1hYbYaNMS9IkF
 xMIH5S9v0Q9TpcjYDUmDNBomtNu8AfUq7LNJxmquZVDXCOlzfuu/yZsRf3Evgj2/WJkE9RHxOPf
 Sza4nX6bInupnWqsyyGztBxUPwiwnEKQHYmDI0wS3yNkKX7M+8F9wOQ=
X-Google-Smtp-Source: AGHT+IFA/1nUB/Dkd6aa9tcaG904zzn4tokjsygmx/kcuW9bzy/eNqcDL4zHOg9n/7OZlbGna7xMDQ==
X-Received: by 2002:a05:6a21:1fc7:b0:1f5:7007:9eb1 with SMTP id
 adf61e73a8af0-1f5c12cd9bemr12224099637.34.1742077098402; 
 Sat, 15 Mar 2025 15:18:18 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:17 -0700 (PDT)
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
Subject: [PATCH v2 01/15] arm: Remove stray .mmutable reference in linker
 script
Date: Sat, 15 Mar 2025 15:17:59 -0700
Message-ID: <20250315221813.1265193-2-CFSworks@gmail.com>
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

The .mmutable section was deprecated in 2012 [1] and finally removed
entirely from U-Boot in 2022 [2], so this special handling is no longer
necessary. Remove it to tidy up the linker script.

[1]: dde3b70dcf3d ("arm: add a common .lds link script")
[2]: 3135ba642f9a ("arm: pxa: Remove CONFIG_CPU_PXA25X")

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/u-boot.lds | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 2f50087f57a..63e82a09fad 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -169,15 +169,6 @@ SECTIONS
 	_end = .;
 	_image_binary_end = .;
 
-	/*
-	 * Deprecated: this MMU section is used by pxa at present but
-	 * should not be used by new boards/CPUs.
-	 */
-	. = ALIGN(4096);
-	.mmutable : {
-		*(.mmutable)
-	}
-
 /*
  * These sections occupy the same memory, but their lifetimes do
  * not overlap: U-Boot initializes .bss only after applying dynamic
-- 
2.48.1

