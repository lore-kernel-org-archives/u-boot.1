Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D265ECD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF0B845C8;
	Wed, 13 May 2026 02:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="J+qTRi5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4A984255; Wed, 13 May 2026 02:26:41 +0200 (CEST)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42842838BB
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso6648147eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631997; x=1779236797;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJmCPlhRE2NhpNjMwY/djE3EkZMg7gco0T46tt4IUqw=;
 b=J+qTRi5TQsxyZz6BQ7Vr4JcR8jNZ8dPs58X5CrcCVf4u4/Lb/LIlAqPo/lragZEcy9
 zd1usRjQzAWFcs14DWKhv+1me8oHglD/rfjNFyvmTkrNTdqtp/g8lwbI7PuwkFDLd7Bb
 YoRt1rM47vSHM/L5ZYwvna88nyVREIu/kL2Kd5fowg5JMc9julm2e+byeH9M3LYbCU3B
 dGXbxDi4dPoAC7J0Ep0CQUmWXoSEoVN3YGB28w1egNyhAkm9b5HQolSktd8wM0m5qLhr
 l6mBLF9C05xk97W5u1F5qFDEGOgXaIeSqWDTwSKJF80q0ARZpWCerQWVAYNnRhm2LoS4
 85sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631997; x=1779236797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oJmCPlhRE2NhpNjMwY/djE3EkZMg7gco0T46tt4IUqw=;
 b=k5qzS9jN70ClZ73O5KBHMyJeCGF9CpS645qIk1IVnKl6s+f2MbpXuLyYEKNFK7Smi2
 pnKAdplH+KSUa327pDP55rGl7c7OmLlY9YYbF4AP2HK2es096dTtMftraIKU/zvDquAH
 ouJ/z5+X4YBR/Qptc9nAh0xCvimDG9BpJJF+C5KCjQyLguZNm8LOPblKroo455/syIDv
 ttn6vTwBjAgOh8VCOYsTd1s/W9Gz71u6b6LWHNDADku0ssj0e/l8YQwwNTCJsp78yuCG
 occK8G2mXBRtQVafkIhqEdTl6r/e8Gjg15lYGUv71WDknJkPS0x9gGuKn7ezK79eTwGL
 2d/g==
X-Gm-Message-State: AOJu0YypnLLpi07AubyPqP3ZI3rRELAspCmQiX9ep3uazEL2YB6jk/RO
 JDDMEcpXcMZLmT3tzIuUu1C3RDxmc3YL5CaSU8/egG3YSXRKwWNOuFVOFtu7guqtJehaCfkRLzK
 ipw7ut+Y=
X-Gm-Gg: Acq92OHMaHm77vQnF3A49Nu/7zcX25ol91yOEiMd1kHZ7Q8AjaYdggUf6M9e1hFPQay
 jrGhfCv3eLB+6QbcTUKGQqv/261EPm6w6HR+PBfzNAdH9xnIffDcHvG1aAp2N/nIBe5xEhY8QbJ
 j0pcrxw4MxyD7WPE+PtwupGT4aHnpdM0jKXhmO278R8P3FIUzwVGwbYAd7CLf/6Azh4Nnt9qp1p
 7yt814pSQf7kDHbVFbo8CQFkZocuk6cbFUz3SdgiZAg9aHS5aQSwQ+DgmVihPvOb83O2hLDdfmB
 CByaAjrYSDpUkoERG2YgAr92ChNi//Stl5e51AIHbZZGNy4v/m3JwJYmTBrhTVQPiGVIYBU+3kK
 zGFyHeud6igMVo6WwlIn+s6q4Fs5/dz8ozRwNMTNvErXa9LP1RaUVht4n2NQzg93fr74BSnslFE
 RBWra+1inVHS+cDuVnCHAXX+F+A0hFlWNKwGhqQqgDYKPzy4XpQF5CIK+HqrtmyepLEYYz8goVj
 qQUql6KbJ+rki4WeE19nxu6ShwV3IxI
X-Received: by 2002:a05:7301:2b07:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-30153cd0d66mr237706eec.1.1778631997193; 
 Tue, 12 May 2026 17:26:37 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:36 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>
Subject: [PATCH v4 05/14] arm: dts: qemu-arm64: add TPM TIS MMIO node
Date: Tue, 12 May 2026 17:26:09 -0700
Message-ID: <20260513002625.76915-5-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:53 +0200
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

From: Aidan <aidan@wolfssl.com>

Add a TPM 2.0 TIS MMIO node at the address QEMU's virt machine
exposes when started with -device tpm-tis-device.  This lets the
in-tree QEMU+swtpm test path (used by the wolfTPM Python test
suite, and similarly usable by anyone bringing up the existing
TPM 2.0 stack against swtpm) work without having to inject a DT
overlay at runtime.

Address 0x0c000000 / size 0x5000 matches QEMU's virt machine TPM
TIS region.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 arch/arm/dts/qemu-arm64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..e74d036a532 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -12,4 +12,8 @@
 #endif
 
 / {
+	tpm@0c000000 {
+		compatible = "tcg,tpm-tis-mmio";
+		reg = <0x0 0x0c000000 0x0 0x5000>;
+	};
 };
-- 
2.49.0

