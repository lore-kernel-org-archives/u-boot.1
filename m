Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7EDC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB72C800B6;
	Tue, 18 Mar 2025 11:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qZt/PKBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFDF80548; Tue, 18 Mar 2025 11:47:26 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A10A80F70
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso33199325e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294842; x=1742899642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91CQhKc+LooEbAiV6R/y6WtHZQNtg2VBXsL24g8RQuw=;
 b=qZt/PKBr1LodvLSd/OcBtYrNaX9nmnN7vbRBodCp3nSGXudeZHy1Naf45o781Rkiqd
 u8nmOtNLxgUkLnJ59n3ECxMQpgdl1c/KR4CcrSwcGTg8umPF6l82gzi8+TYxB1GbxQuK
 Xp1y/l4mYdUU0ICE3Z1E8fe4xxcYRsZyc+Y41Ozct3wHiAniV7j6DnRvA33I/aI3Jwei
 U9QzeQ4RF8GALU8pF5eCcn3AZdbQnp76ZasHlHl41INeK6x1XsTBt9BkMFmjJF9tTdwQ
 CdzzOdcGWV1u3gqdiJYr5WJHCziOu2fpdfz5RSxaZ9ro/x7ryJJA48BQ4TOqCHDkUCqq
 hgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294842; x=1742899642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91CQhKc+LooEbAiV6R/y6WtHZQNtg2VBXsL24g8RQuw=;
 b=GxWTn0V642GJNJ6K2jm3JqSLnb9AGu+P5UL+fflXDwvZdXl8xZTs3QkjEmzA07fDXG
 FrQ2Pfv3BgnqHrp9LCthdAymQIctrNKNKOwiVppaff3QNPkEx92D4upuF0IRJYvVr/kI
 0wAdtaIGCbN1CU4bZ/SjHwIVfYcCcCHl0RroZQ9T8GeL8ITxvRJaoeyPR0mA4tGjl1PT
 F4DCFKlkwl3aZ6PWIB1BCIVU351DdVmJGdMNbSGNn6YpPLDsUw0aERL1IuOl0yxoaFy0
 o0s5fxkQGw3mLg1c4PGH2/Y5L9pT1SRyHwURCMc3AaLXkxgkU8rC8rhmTcDV8uqAuYb1
 pDfw==
X-Gm-Message-State: AOJu0YzNeTNGsH1e/1hnJVUIZ+0TlNLM2nsNW8LKCu8FTe0XT3K620LI
 a9aCPL3Yv7Fp8TveQC3l4lz1LobPk6aUUeSAb1OVQQJFuDItyn8a2eV251IXq5G+xNqt/s0ts1I
 w3YU=
X-Gm-Gg: ASbGncsnqUJWxMdzpDnO61BuL92hrFfP1Py0UO/O0X8ZED70gcqruq6CswQwygENEL8
 Si/f2UcC5Esq2r+mz9F+m2HlIxL/d7dmfGawla4cAmPwNFyhMCW9UOQ71c2aqwNkPk5Zl7jwcMO
 k5vObkfyCsKgwiGbRnbf+FUksm+wHw7aBwn5TO3OLCfstOr/hFr5qS6uqb3uxVKA4p3EAxYKKQk
 Qk3oc3w4te9NY+U7E2fZa3mqVJt43AZJMbBIWC1EhPo2HRtgKwvQ5e/w+ktn+tRMFAvUfNF/0k8
 ibsTmUpM00Bumc+n9p7d2CMy+qcPrfrmUaB+K5GGmbFulTP5z1iWSg==
X-Google-Smtp-Source: AGHT+IEP3KFk39gztlNA0DPFYBAiyO6F1ywgZqLVYoM96zE5NWglNpiDKLi/pQAOZp5BjYsm6Z0VsQ==
X-Received: by 2002:a7b:c00f:0:b0:43c:fe85:e4ba with SMTP id
 5b1f17b1804b1-43d3c953a27mr14313365e9.15.1742294842416; 
 Tue, 18 Mar 2025 03:47:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:22 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v4 03/14] riscv: add initjmp()
Date: Tue, 18 Mar 2025 11:46:39 +0100
Message-ID: <20250318104659.1114340-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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

Implement initjmp() for RISC-V.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig            |  1 +
 arch/riscv/lib/setjmp.S | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7a3141e92b3..aa60c5ff03c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -153,6 +153,7 @@ config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select SUPPORT_ACPI
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
diff --git a/arch/riscv/lib/setjmp.S b/arch/riscv/lib/setjmp.S
index 99d6195827e..9e1f3d5749b 100644
--- a/arch/riscv/lib/setjmp.S
+++ b/arch/riscv/lib/setjmp.S
@@ -59,3 +59,14 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* a1: entry point address, a2: stack base, a3: stack size */
+	add a2, a2, a3
+	STORE_IDX(a1, 12)
+	STORE_IDX(a2, 13)
+	li  a0, 0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

