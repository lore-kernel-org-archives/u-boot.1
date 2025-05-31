Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D326EC5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E170982B72;
	Sat, 31 May 2025 10:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="buxq12LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D032C82AC4; Sat, 31 May 2025 10:44:57 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E759C8003E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a3673e12c4so1855740f8f.2
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681095; x=1749285895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIZF4li7UUm7WILdz9NUcRMMIrsxw1CsckkM2OcB1NY=;
 b=buxq12LULlfTFTg2hm91OQtA+iDIHg703PeKiTLbaxgo9CyBmgqzRUEXBhhb52WVNC
 i/UXPxfSqhzsp/mMQLAudUsgnqYhclTRiT9sXJEAcGHdCWoPZOlEsN6sooUXnL1UUNTB
 1bQ0d+XSlOHG+l4mCowyAf+D714CYPshk9WuNtHkKAdWFE26K1kRsKw3uMR7bBXQddBe
 sqJpzeQtVL066LBnvo491egwe6EsD3IRSj6p4R3Kqgu2TMp3LPd2HPpZIcFSmEQI9VVG
 BzWfmqi7JTCoJKPMlGA+1sb8wUvYulg92jdgzrmk2pG/ZGfrXCTHAZg9aqNmQyDyqPJM
 ehGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681095; x=1749285895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIZF4li7UUm7WILdz9NUcRMMIrsxw1CsckkM2OcB1NY=;
 b=MtMlz1qGNUkAl8k6/W3Q2kal816gyB8vjcFvASVj39PW6na4sExWq2M3BE+6O03Uoa
 euhSx+Flao3WjSlseI8mNXmx4hgWt5LcQlJdvxuuIRTn3mgHBpyZx4BJdt5QyEoKCf/o
 xjN9NVgqJE6FEIjC489zexGRkg1dOk4VQ0COrhPiuEGVs2N+x9xO6Ey7aUHslSL8Q1p9
 2JlNJK0rP5znAeBcW0QR4B/CkrxU8gp4dAEAT0KLa4LK6W3pmYK8Arun4MQt3i4gJDI0
 Z60H/2oCK0bYQJjGm0j/U6adnkXkKb8SCagCiLT4U2hv54wAxK9sKBTaMh2/TxDI0+fh
 8mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbIXpCwlMHJxHLn1/S5/9R4TV+By6OXB5VPWvhSOTGUQCsXDFlsMzjsv6DdjNU0hxjYbRokxo=@lists.denx.de
X-Gm-Message-State: AOJu0YyzoUOTunkaTWGZ3CmxqIe0QDOyR4J/7WN913SE0Pk4XdXmtHqc
 mxjR/OLb/cxLDHZT7oVOqXgug5QRTClRqq4OcAcFn8EQP9qmM9iHeofrX5yvcF3PVk0=
X-Gm-Gg: ASbGnct3H5zBArZ8C103CNbugxV4gZCQ9v0qxv1TndoMMMzrufepJWCywaGLKkdX3wa
 lGusuasKQ/+rr4CdP+w8K409CIFpETntLBlwA7+riSWAQnY48hGsUmkqUaulr5WSNv6GxThyIab
 ywNpJZDcb5NpnJFeaJwviUvorI3+wX63aG+cQs2pNupfloeER0fHAw0p5uDDs4lXE6C1TEBe+Wb
 TAtb+BslTQLMhFMgSW0BYPmEBqbUtgz6L3T7nIpCZ0fU0QZrt2Pc/necUsVMBDRWe4MpjvgRQLb
 baBRNH1X+5SlRQp+tnAk9yMstOx8xPc1lodOH2Cgi5LzexU8K45AMNXNYzqPI+s1pLBXeFaa7nO
 k4+Plf6Z1MPe65PNWPvAdyBraz+5ACg==
X-Google-Smtp-Source: AGHT+IGqmcEZEzPu9IGC2eYi+Ztbx12Zj/bRx2Niitko9m8jhPaNA/mvLhkGwJCjf2dePKjPUqhrGg==
X-Received: by 2002:a05:6000:3112:b0:3a4:bac3:2792 with SMTP id
 ffacd0b85a97d-3a4f7a3dc11mr4842179f8f.4.1748681095311; 
 Sat, 31 May 2025 01:44:55 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:44:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 02/13] kbuild: add -Werror=implicit-int flag unconditionally
Date: Sat, 31 May 2025 11:44:30 +0300
Message-ID: <20250531084449.4125187-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 61a0902a06d6a ("kbuild: add -Werror=implicit-int flag unconditionally")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6a1eb26c6e41..9098e732b4a8 100644
--- a/Makefile
+++ b/Makefile
@@ -436,7 +436,8 @@ KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
 KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
 		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
-		   -fno-PIE
+		   -fno-PIE \
+		   -Werror-implicit-function-declaration -Werror=implicit-int
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_LDFLAGS  :=
-- 
2.49.0

