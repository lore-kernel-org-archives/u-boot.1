Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE86BE7719A
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 04:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2AC80613;
	Sat, 11 Jan 2025 05:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="MEDom4Je";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E378036B; Sat, 11 Jan 2025 02:56:01 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0000801B0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 02:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.lin@sifive.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216395e151bso32622325ad.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 17:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736560557; x=1737165357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJL/AuHiUbT6XmVyiPWoKCEnUnT+t0MIuF0vvdrCZyg=;
 b=MEDom4JebFKH8kMT479K6wR2X/OC1isrj8ZmzyS5atgrKyeOkaP4FTNNb8ab6i46uz
 rYI1v8JB/fy4ZSNfQVMdCYpi0y3BL87w7XHI2IjfzQFXsmiY/ocaF/HzRMkkQY83p5Td
 VUaJi0r15Sjl//+IcnzuoyEemyPMxrvBYtXn5eWGDkfStw3jNWti7IF8RmciSP4ZI3F/
 4GCEtH01lQTm/UWm5CXwaCTqCVFYbhFghtxSGbkC+f9I5XV9zGdmJaJ+5aIerLSG7t6C
 fRREQBE6ylot12mIKBfTGD9PxzC7BWDp/1FxpLCkyA+FXw6c09LUaS97fss4jD2GIDdm
 stcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736560557; x=1737165357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJL/AuHiUbT6XmVyiPWoKCEnUnT+t0MIuF0vvdrCZyg=;
 b=EcXjBg5Tfn7msomWDL3oh8LXTtuiqEngguXXec/5aES9RwlQjJQEEtkB6etpzMeFnW
 9tfeqvz7CHvXLt3CzQXP4Zfdz24X0WscXyjB/bYt2EFoxjiSUEhnBsCGSahqLzEMwvcT
 ZQvLi5i2ee6sJnM3Se2ckjkSkajUfCIQn0rByLhwEw9FI/4bGMniqEbphgjbOig0zW+F
 tKkJsnIFp3FCFPPu0ySxyDLeOK8JpdtCzrRHFNWpIg3IbWYH00868jXYnOloSmK8bZor
 IE8Y66zRWkjLh8ALig9z6H5TNkLQcPnhHybAyR5uujMnkmFx3nxsl+b1gRKLOfwewlxu
 kB+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjnQPDCjJsDWrstML6ZT831rHTYgIZfkCUgaE6l1T7nlk5lnJCanJ3YFqU6PvAmbtgy+zGV50=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/V2+tuHYTI1fL+FRsk4/XEb8noFdnk7nRrf92MqFKgh/4OIDQ
 d32bNFbzmMaKHQujsUnon9Cs4mQMD2zDXy0mH4p0CwnpEgpF7tMmYBnqH9+b3RA=
X-Gm-Gg: ASbGnctXDR9DSRGp96IJzyPbxPpynAdwlZR+Idzh5CLFqsKtAfWOBh9aGoWyEYy3l+a
 BXQcOm4vkm5kQMbfTEpsk70kKerwbtb43qvgLoohob9YUPw+e/tiiIrUND3h+8g5M7Pd8vo/fKA
 dZ86GGJWx6NDEGpB7BgdbQxF6oJzDKze22eeZQqP9hiZ5aEt9dUiUV6JdT4awDH/l1ENFCcwf3c
 NB6NRjr8WD7Wq3t/RQTzTGHCsj/RLLDy7EEXm0L0M48BmEjPaQr9ougs+MHFoB5tDpPgA7/bTMR
 grESU5XWdfJzRTnKTdZbbb2U4KcH7d4dCeJVPdX16kYTXx+sWIyY+jN+crQ8bS8=
X-Google-Smtp-Source: AGHT+IG5yDtpLdxDPaVz5qqybHrpSCYgNjwxoNgtQojrK9RTDaAEdZVKqDVE9qQviVh4IPIrPYxPMA==
X-Received: by 2002:a17:902:ecd0:b0:216:3f6e:fabd with SMTP id
 d9443c01a7336-21a8d647c0fmr131606165ad.7.1736560557336; 
 Fri, 10 Jan 2025 17:55:57 -0800 (PST)
Received: from peterlin-1873.internal.sifive.com
 (111-254-79-27.dynamic-ip.hinet.net. [111.254.79.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10e0c4sm18901555ad.24.2025.01.10.17.55.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 17:55:57 -0800 (PST)
From: Yu-Chien Peter Lin <peter.lin@sifive.com>
To: ycliang@andestech.com, trini@konsulko.com, xypron.glpk@gmx.de,
 seashell11234455@gmail.com, dan.carpenter@linaro.org,
 mchitale@ventanamicro.com, ben.dooks@codethink.co.uk, u-boot@lists.denx.de
Cc: Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [RFC PATCH 1/2] riscv: Add CONFIG_SPL_OPTEE_LOAD_ADDR
Date: Sat, 11 Jan 2025 09:55:26 +0800
Message-Id: <20250111015527.35528-2-peter.lin@sifive.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250111015527.35528-1-peter.lin@sifive.com>
References: <20250111015527.35528-1-peter.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Jan 2025 05:43:13 +0100
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

Allow specifying load address of OP-TEE binary. It is
recommended that the specified address aligns with the
base address of an PMP-protected NAPOT region and matches
the CFG_TDDRAM_START configuration in OP-TEE.

Signed-off-by: Yu-Chien Peter Lin <peter.lin@sifive.com>
---
 arch/riscv/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a160d24fb03..9a9458026d3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -582,4 +582,10 @@ config SPL_LOAD_FIT_OPENSBI_OS_BOOT
 	  This is a shortcut boot flow, from u-boot SPL -> OpenSBI -> u-boot proper
 	  -> linux to u-boot SPL -> OpenSBI -> linux.
 
+config SPL_OPTEE_LOAD_ADDR
+	hex "OP-TEE Trusted OS image load address"
+	depends on OPTEE
+	help
+	  Load address of the OP-TEE binary.
+
 endmenu
-- 
2.39.3

