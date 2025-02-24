Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E82C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9DF80F9E;
	Mon, 24 Feb 2025 06:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BX9YQf3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4653F80F9E; Mon, 24 Feb 2025 06:56:05 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484EA80F0E
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220c8eb195aso86583455ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376558; x=1740981358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4U5Vl/4jnMM50eIfLiFMwl0GO9zMnH8asrTN6DK0oI=;
 b=BX9YQf3a8AzBAAvkGddMa9275KKIRzowqvEGOgKO11ATR0ZaNHD/9wf2OK6+1j23WO
 zGY2TXh7ZU9KnCCYzWYmqAaYuFYLcywc1s9dSmaSDxFZjuagDjlmUeKiTWHiQ09QsKD9
 Juh/vhGt6aUL8UO9/sfjhS4bVwaBFQnzuthGPz5JYIQX+iLln0Bs5oeQl0PaRKKoli3p
 ndDV2tX0CoEv7vrDf7vuhVqbx209IgRgTD2RaVjdTOCur6fDOCrTZJRpyB3LnXbNGMWc
 BlE0dXr9drORT/waQJMh8OI++wGGerjbiLcODaJqGrsArb6msz29cKPrq7TnGatRD0/G
 bV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376558; x=1740981358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4U5Vl/4jnMM50eIfLiFMwl0GO9zMnH8asrTN6DK0oI=;
 b=Qu40vYhfm4PNaNLTnPc43cBFWNe1eqSr1yf2pFGvxZXzr2bXv6u7yCH8xQihYdLOAl
 MzPgS6Jerm0h/lDv9Nadu9Q1ZyRcXeoCm+D/r2lfBDoXHe/B5G+UBjsOqAj5lAh09Q9D
 aSL0h/tJzzBkJARt2LYPY4vG4NGxSDTQfyyuf4CzMtGuDNyT65sjfsVeZ7SW7VyNrkBc
 Yl5eG/ib3fwkwb18ti36ak5aotL4Ng7tKg8c/p+OXOJtkZHRGKvlE2TiqICd1h7SW8zY
 0gWMJHSr099Mg69eRVbk3OQqghLI/V2PxtPPt8S5FDo3b5JtS/KbNUtbqM4fk/s+jjls
 qxVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ/ZOVP4OHQDZokcFpCqLHhxI65qD6niC1TY84LL4LKAHgjYMcM/qBWH9Iji6o7B/d5qJo6Iw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvy+OIKvoEAmtgfcB887IzhpW9Ys50M+t5+GRFZ0V4UK24FI9W
 gBu18bAfmfOKtM7TA+HcyDVwB3buLdyhJAdrE0+WNy5YyY+WeknI2JlEbop2CUc=
X-Gm-Gg: ASbGncvNVCEVl0H3Beat33Ss0UhIvlPy1dM5YVjtAs8mAx2rJLOhfN6v9I7ZDMBSsB+
 mUsR2vfgicGEuHjJDHADp3ClRBFaJUuWg10y8XLNkuBIui1KOkgL7U/9+NjI+p9TP0uwUsHYs40
 vPcfrwV45EgYtM6f6QGR85BpMqQFcAd99gcWUl/pRx3iIg/S43m5Pqdvn/29J00op/67TVeyS6Z
 kde1LegeMImnvAKx5bl7zMvfJXY/QNV0LIhuMtMB//xEEFhS31167zmYYMjwin/mYPhwqGHm7gP
 QBahXg2/rg2v+Xu00EEc+Uce5NKEet4M95rIjQ==
X-Google-Smtp-Source: AGHT+IFuxxvKh0lzURYplCtBUKV8e1IKP/MaB2I6NQZHv/RMdpyVL1IX/SSrtxPJxIEBRtc+oT2bbg==
X-Received: by 2002:a05:6a21:4f85:b0:1f0:e803:52db with SMTP id
 adf61e73a8af0-1f0e803534dmr3494800637.18.1740376557732; 
 Sun, 23 Feb 2025 21:55:57 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:55:57 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 02/17] arm: Exclude eabi_compat from LTO
Date: Sun, 23 Feb 2025 21:55:09 -0800
Message-ID: <20250224055524.1334929-3-CFSworks@gmail.com>
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

These symbols need to survive the IR-level dead function elimination pass,
since nothing at the IR level is referencing them (calls to these are inserted
later, at codegen time).

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 1c95dd6fed2..74cd5051552 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
 extra-y	+= eabi_compat.o
+CFLAGS_REMOVE_eabi_compat.o := $(LTO_CFLAGS)
 endif
 
 # some files can only build in ARM or THUMB2, not THUMB1
-- 
2.45.2

