Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14A6C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7C080EEF;
	Fri, 14 Feb 2025 15:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bu7F8xSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685B080EB7; Fri, 14 Feb 2025 15:01:03 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E5180E88
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso1569903f8f.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541660; x=1740146460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNw2IjE2pzkh8kOG8gbCKeyHG7nPC9wPKaPR6juqTg0=;
 b=bu7F8xSbbNDDGK6VWfTM1D6wiLYHY2kpAoLtNuMz3KDY1reyx+BNDdnsa9DkEBmYYp
 ir+Pb4IovjWDzkZYqmzI4/a0mNYMs7Nb3swHaCQgnuofgTICSYfNJa5gjskVTLF67Fo9
 RnO71LPKmRWcLMj6YZUbuikRJ3GwQNC+sEhxLSPw2m98iJSWAhLLpd7C7/jxXpd/DAyb
 9gNtsor0Pvc8sMHgSWULgHOKcebHl486X5KSx1D0YksvpbP09MZL6N4drDwq/YDNk+t/
 rm2dOc2He9sCG0nkseHKVZfoH2NWFiZ+qBsI8/tkxps3RlH1c0EoedlhXq63Ot+Q1vPi
 1QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541660; x=1740146460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNw2IjE2pzkh8kOG8gbCKeyHG7nPC9wPKaPR6juqTg0=;
 b=anVZvjj0TkA3QgAAeKREHX8NUuFdRZUBW0QiBXNa6JlofnA6EWrjQLKkCEuCP4yE4G
 m4OwceqZaWS/3qGLZxk925dBwWKBinZzVA9BZNQ00vy3F4JTvjtQmsLvYAMFAagDwRo3
 pZJhu5PKcEb8/hhudt3c/WB6Gw3gG1YwGLL8bQnxi/XgCy9mt2kCLsPgigrpJNhng+kN
 QkksKaS/pwnHiV82mFSUgbXwHdPX+eQJDCSjhnb7es11USVkemd7n+ORGecs1GiaMN3f
 lyny0ZQU6F7L8fWvRKgPXItsLWs60Y3PsZfbdkUjbQepaRGmgAu1KeiKyUTsPVHiv9SC
 92yg==
X-Gm-Message-State: AOJu0YzsthoDPQv0JNrOP+0SsJmNzI3pMBN0bXCUSHbQBJYAO9/X6lSh
 876a0MqJOD1kNSzBmCD1fPCKx2+yHh57AIqATVmzIj/L882gxnZ+TFotCU0hDhhrLyKUFhsH9lF
 vo3S4Bg==
X-Gm-Gg: ASbGncsVCy4JvhXu0RAuWrjjvfpHGCrI4PQuCm62QBTGvMIAbPq+DnVxZ3yGDL136l5
 PMbKByuHuVWzcZKq0Fui94LfoNq/YIvdwPU2sgn2+/t4rszE25HkmE8QdBDkmVpfppxe9LC73gT
 51vqef6Kdd2BTu1PJ+vUA0K0oRwMplAr3Fm7ztn79V3CHXXhPk59GG7W/HXGIxhPqQk54bTjQPC
 /vlB/1mo1INhl9SKfLLO6SNZnd8leN2woPVq8z9SCUVvU0VRIOK12x2iea1++FiTTO7BLzLJd3c
 LoX3fQdyS/iBXo/z2XLf2nZx
X-Google-Smtp-Source: AGHT+IE2rMF/5JOH+CGi8z2F4wmbgFuMcuqRHf87ea6KY7I1u8haZBgtZgRZOWxio9hqstW9LePY6Q==
X-Received: by 2002:a05:6000:120f:b0:38f:220d:9d3a with SMTP id
 ffacd0b85a97d-38f244ec272mr8173808f8f.22.1739541659693; 
 Fri, 14 Feb 2025 06:00:59 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:00:59 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [RFC PATCH 03/10] riscv: add initjmp()
Date: Fri, 14 Feb 2025 15:00:18 +0100
Message-ID: <20250214140031.484344-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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
 arch/Kconfig                    |  1 +
 arch/riscv/include/asm/setjmp.h |  1 +
 arch/riscv/lib/setjmp.S         | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 57695fada8d..b745222bfbe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -152,6 +152,7 @@ config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select SUPPORT_ACPI
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
diff --git a/arch/riscv/include/asm/setjmp.h b/arch/riscv/include/asm/setjmp.h
index 72383d43303..98ea157eb3b 100644
--- a/arch/riscv/include/asm/setjmp.h
+++ b/arch/riscv/include/asm/setjmp.h
@@ -21,5 +21,6 @@ typedef struct jmp_buf_data jmp_buf[1];
 
 int setjmp(jmp_buf jmp);
 void longjmp(jmp_buf jmp, int ret);
+int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
 
 #endif /* _SETJMP_H_ */
diff --git a/arch/riscv/lib/setjmp.S b/arch/riscv/lib/setjmp.S
index 99d6195827e..6f952a16eee 100644
--- a/arch/riscv/lib/setjmp.S
+++ b/arch/riscv/lib/setjmp.S
@@ -59,3 +59,13 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* a1: entry point address, a2: stack top */
+	STORE_IDX(a1, 12)
+	STORE_IDX(a2, 13)
+	li  a0, 0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

