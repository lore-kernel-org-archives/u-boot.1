Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D90C282D0
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 10:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC1C812D9;
	Fri,  7 Mar 2025 11:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X4CccYrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3FE3811C1; Fri,  7 Mar 2025 11:16:53 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3088122F
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-549901474c3so796813e87.2
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741342610; x=1741947410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xknTFCjCKVLA+sCWvnOOr5Yrp4PNq0msUNu6z+fXdAk=;
 b=X4CccYrEQrPniKda7mPAFuJzrryvGMOHzmfCr0UxsV7pDK7FwBZytfzP7ksGpbKm+o
 06/Bw6s3uAFqr2gm3IGuETHy+8deMH5i4QcIdZafImnW4vBJoIxRsQ87KuBCvG2LGHB2
 6Iwz/+EIIFwWTkf3zVHecQqLapLKxw4y1K5R2j08wnVCRWBfFmTcgEzLYeig3ob87UaE
 +o2fWcYOIM17Kos9ZK+zQ1gJ/5oWo8+YxHMRV2m0FEuVdEcF8oWDqJ0dz618rV+Ryd2d
 +5D1jWTujhniJxr1qesmPhfSY/a+jMO5fW3Yg3nj+ejdX6smtdk6UDlimBBuvufMkZyv
 PwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741342610; x=1741947410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xknTFCjCKVLA+sCWvnOOr5Yrp4PNq0msUNu6z+fXdAk=;
 b=d1Ayi4lPXTtpxZI6wnOiOw5slemWZuxAz5OTkzPR0Ztk9rSJKiRosbNIK/Ht9Oh+9b
 MaghiCD4nTr+u5ba6DY9pxmIzxIwVNdhKTQwOK75ENfk+L16asKgqq2bQ5tKO+SYNmAc
 oHYT18XkI1K5xhykZA/D1zoyf6Iu/hVmRFWkMJsi1a3QrOGoikHAEb2iWPaguy3jFAs9
 XURUmomBf9XjkH4CRQ3MQdTNSQJV0v1n7Fo65pdLp81SSLBYkS6BLzqTBRZEevmHEJfv
 H+8gwJMnYVpaJyZTtEkguNGOTDz/3yaoOwh2qy/u7Oe/c0bmmDXseyr3v3AUxzJkseRh
 C2Xg==
X-Gm-Message-State: AOJu0YyO8Ol4w6U0T/hlYUHENYK1rnt7uCcT40QAZ15xC+yCFdLPb11P
 h1CGjx6ih2qpxLHfCdZQv8qlh/Vz5ShsmT9l6sdvJrhREl9XMmHd
X-Gm-Gg: ASbGncvpvDpjgFxQQYIcHCvg30p8rBSXuReYUVShuCsPFbTkMVS8DsBPNnovj1oE1BP
 oODAJCgIJlNMApvFMypASEBUjoK+Oa3IcfxW3J0WFBCzMMR6Ob4CWZkmU5pw2AkMCgF9yOS6Sf2
 j5QUuW/SOX5c6Jaqy1QBvMArzww+bUTVpjE5f0QxSgIWlbk8Vhcrq6bcnIY+hAhOmMbqXBQu56j
 oZSQu39tP9kfxz9IL7bQW9N4WQzkcKyxkv6ZRWkBLg/StrptB6waCllWDR3n1guIWryONCQrkTe
 PNRlIxtaQNhlbOCxBjrwY8y3Ku+Ssgc6h5Yo
X-Google-Smtp-Source: AGHT+IFGgkw6Ie1RyRFstOXmbPFuv7TprJ8E3lULkLWaRgoHXsi5HQsQfM8cD0MI6Qy2+VD9+hJ9JA==
X-Received: by 2002:a05:6512:1255:b0:545:f0a:bf50 with SMTP id
 2adb3069b0e04-549910b5d89mr892298e87.35.1741342609454; 
 Fri, 07 Mar 2025 02:16:49 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498ae4610fsm438278e87.15.2025.03.07.02.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 02:16:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] sandbox: swap bloblist and fdt loading address sequence
Date: Fri,  7 Mar 2025 12:16:29 +0200
Message-ID: <20250307101629.51561-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307101629.51561-1-clamor95@gmail.com>
References: <20250307101629.51561-1-clamor95@gmail.com>
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

The existing memory layout places the bloblist at 0xb000 and the fdt at 0x100,
resulting in a 0xaf00 size constraint for the fdt. This constraint has been
reached. Lets modify the layout by moving the bloblist to 0x100. With a
bloblist size limit of 0x400, this allows the fdt to be positioned at 0x500,
thus expanding its permissible size.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/sandbox/Kconfig         | 2 +-
 common/Kconfig               | 2 +-
 doc/arch/sandbox/sandbox.rst | 4 ++--
 test/lib/kconfig.c           | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 4c169034d9a..da7a19264b9 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -77,7 +77,7 @@ config SANDBOX_BITS_PER_LONG
 
 config SYS_FDT_LOAD_ADDR
 	hex "Address at which to load devicetree"
-	default 0x100
+	default 0x500
 	help
 	  With sandbox the devicetree is loaded into the emulated RAM. This sets
 	  the address that is used. There must be enough space at this address
diff --git a/common/Kconfig b/common/Kconfig
index 7685914fa6f..cf4bee063ae 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1070,7 +1070,7 @@ endchoice
 
 config BLOBLIST_ADDR
 	hex "Address of bloblist"
-	default 0xb000 if SANDBOX
+	default 0x100 if SANDBOX
 	depends on BLOBLIST_FIXED
 	help
 	  Sets the address of the bloblist, set up by the first part of U-Boot
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a8b0d7f0395..99459815c25 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -658,8 +658,8 @@ that are mapped into that memory:
 ========   ========================   ===============================
 Addr       Config                     Usage
 ========   ========================   ===============================
-     100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
-    b000   CONFIG_BLOBLIST_ADDR       Blob list
+     100   CONFIG_BLOBLIST_ADDR       Blob list
+     500   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
    10000   CFG_MALLOC_F_ADDR          Early memory allocation
    f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
   100000   TCG Event log              TCG Event Log
diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
index a3645abf946..2f47af9acf1 100644
--- a/test/lib/kconfig.c
+++ b/test/lib/kconfig.c
@@ -22,10 +22,10 @@ static int lib_test_is_enabled(struct unit_test_state *uts)
 	ut_asserteq(0, CONFIG_IS_ENABLED(_UNDEFINED));
 
 	if (IS_ENABLED(CONFIG_BLOBLIST)) {
-		ut_asserteq(0xb000, IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-						   CONFIG_BLOBLIST_ADDR));
-		ut_asserteq(0xb000, CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED,
-							  BLOBLIST_ADDR));
+		ut_asserteq(0x100, IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+						  CONFIG_BLOBLIST_ADDR));
+		ut_asserteq(0x100, CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED,
+							 BLOBLIST_ADDR));
 	}
 
 	/*
-- 
2.43.0

