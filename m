Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68C4D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35F2839E8;
	Thu, 15 Jan 2026 23:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k4SU3/Ik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5A183942; Thu, 15 Jan 2026 23:28:46 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05ACF80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cfd0f2ef93so643453a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516123; x=1769120923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNPa6mtjj/Dc2OxCt6x1x9ZeRVltib0RcZtDs4GRveQ=;
 b=k4SU3/Ikb2rvvguYQO88Tr25sQPiuJd5Bf/E8M6H2OuMsaB7MsLs5ZCwJQJM8nwWbV
 LzWnoSxbw9iLc07yRjZvKJ8ni4i6yso7V9j0t74DRcpgHgJ5CBFby88c0hYIvgkXt7Rb
 sNJWk58VJt6805PXvFqjBe7u1vsrBt89Zy5jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516123; x=1769120923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fNPa6mtjj/Dc2OxCt6x1x9ZeRVltib0RcZtDs4GRveQ=;
 b=Ba+9WmqPLT41tcS7cy1sBhy3oCRyKouKgUrwaeJjCZvzVA01GebnpKsEo04jRT7hQz
 9vdIYAVbr3IYyWAmGj2LmFyaar1gDfaZUekninJmsP2uH+mfnbbE/mWnFm3+2fPANu/d
 LDRMCwjE2EgJ+fVew+tTDP3g/287C9fsmrP/bHqDjLLgAoiugo5zGvWi6eQR9mlV7dcs
 ChLQ3aCeAvf56Hu6mSjEgYtTQtQYevd+7+sEdJobhi/r+GZdBvrZiR9vkXX1PshNxDO0
 LWl8jte2I0MKZoVsbNat4XWyNu8YJ2VjJJtRz9x5Cgp5wsmnhnlc/9ahKkPxvq4NORbM
 F1aw==
X-Gm-Message-State: AOJu0YxGq/cargtByuETV1gBa3B1k6ayrcpdDHmDg1+sEWYHYTOIqJnB
 bIEATkXMqFmHxOp2Pjq2icp25UXrh3qtoFcc+P6W2IGwCToH9gueliiEO20a9A7H8nRziLl9U+g
 fTgZ1uKM=
X-Gm-Gg: AY/fxX7Noz9IRduhVco7gl5UMxSq1HqvxQVrBdFczgWhHB61r6xxOrA/j0j5XdBdQQx
 fiMkWKMeuW+JWDrKsGbcOB7v0JFYD/qTaSJQTOsm2uX/zTyD08nqFzLOYW68/024e+xOFF6jeiE
 8WzyFkRcUJofEHmJ3+5GdZEh7oAcpsppZs4KcwlPdxHQJUfZs4/RDAyql63uPIuYeB/+dGOsz/7
 IUgmFQIrkyTP+AoNJqDS4j11pM9pGKL7Y9SEWWqrzNsgzbu9zFc4cKtpMUjgDfUMwp0LUr1TQUB
 XtWK81QphEGfLByD2d00yWDMwLDYIB59QvMBdNHoJhxz1Kmben7NhxRtc3+lRKMFQTyUmDsblVE
 3q0QAs+ingzyeQbWdQTqfYnyrlN5KYwWNbj4l6AWjkM8vwDFNREalgUF6q5lRCdzzudzVx1w6j0
 DswQQbvOwkEN4S+AddzSGFohG16UIU0YcAj96/FUWpGC+CcGgGAsbJNNUkSeDp4672PvcfM6xMU
 0FQMTo3OAz2vpGIOP4ndhJFad6AFolNFXgngSQvrQ==
X-Received: by 2002:a05:6830:82ba:b0:7cf:da36:4cbb with SMTP id
 46e09a7af769-7cfded3d3bcmr616124a34.2.1768516122785; 
 Thu, 15 Jan 2026 14:28:42 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>
Subject: [PATCH 08/10] riscv: Update linker scripts to ensure appended device
 tree is aligned
Date: Thu, 15 Jan 2026 16:19:38 -0600
Message-ID: <20260115222828.3931345-9-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Aligns the final section before _end (for U-Boot) or _image_binary_end
  (for xPL phases) by 8-bytes by adding '. = ALIGN(8);' to the final
  section before the symbol.
- Remove a now-spurious  '. = ALIGN(x);' statement that was intended to
  provide the above alignments.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Rick Chen <rick@andestech.com>
---
 arch/riscv/cpu/u-boot-spl.lds | 4 ++++
 arch/riscv/cpu/u-boot.lds     | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
index 0717833df556..35de28db8f3a 100644
--- a/arch/riscv/cpu/u-boot-spl.lds
+++ b/arch/riscv/cpu/u-boot-spl.lds
@@ -43,6 +43,7 @@ SECTIONS
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
+		. = ALIGN(8);
 	} > .spl_mem
 
 	_end = .;
@@ -56,3 +57,6 @@ SECTIONS
 		__bss_end = .;
 	} > .bss_mem
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
index b11ea8b56d25..c299c00fa298 100644
--- a/arch/riscv/cpu/u-boot.lds
+++ b/arch/riscv/cpu/u-boot.lds
@@ -73,10 +73,9 @@ SECTIONS
 		__dyn_sym_start = .;
 		*(.dynsym)
 		__dyn_sym_end = .;
+		. = ALIGN(8);
 	}
 
-	. = ALIGN(8);
-
 	_end = .;
 
 	.bss : {
@@ -86,3 +85,5 @@ SECTIONS
 		__bss_end = .;
 	}
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

