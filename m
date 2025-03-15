Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB48C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A358B810F5;
	Sat, 15 Mar 2025 15:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PlMpmJTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B627E8122F; Sat, 15 Mar 2025 15:27:29 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FFF8198A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso2542819f8f.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048844; x=1742653644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=PlMpmJTB9xxBFTTlT91xWczqPytahZU8F0V/g9heb7/pPFaoD+GTV2BBDniCxEFWkX
 369Z51jzKFPc4z6kojP+lfgKlCkrldxXZEdI5+x+aT7uHzDlj0OTSR1+1198ikvGOFj8
 gaL77E9yhiRX5gG5dl8UrRFtgYXYEK2GUYeu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048844; x=1742653644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=tmNantG5ixoBqIh8INXYOiojmY4+A5oP3YLHDSySdmcOSRYS1DCPfnLPc5xFYCgNz1
 V5QZZaiWln9pzKjbr4Hz9ewLge6GwFcoNMAkJapfxDKXHlJM9QlpLQysB1fn/kLr7x3e
 YTfBKW+FXfLB5aoV3VSn4wB26Co8eAy0nHaMynEb/QMSQi+aAFYCdqZD197AwHD2XypG
 LGSErc2l98lc9yn3AvwQz4fAE7vVz7zdgATNfWf4V/GVX8Cn4sH83Fe80Qkz+tXwn6wn
 mEh3Pg47AjiV4F6q8M+SI5h5ucniNSaFFF3jRrcS92TSUuknhhz9MB1j0a5HkxkSfO/p
 OePA==
X-Gm-Message-State: AOJu0YzVfZb0oARasPEWmhTnqs9Ow58ezeZxLqCctS5NntXmVYFI1kzt
 NDJ30CdyjeUD1iBwe20RMxP6E0HJz6izHY9/upnl1VhRrfz9c9lTWNwTiMERsetQl2zy8dP4DeX
 zbw==
X-Gm-Gg: ASbGncsAh4oa8jn3HbGi8KlznZu5oYyr6iNuXRScW2x8BISy5nn8po4egUT9I/XokB4
 aMXcRfqyQeMH26rFFmNCtKszJtZ94ZzVGYuewozedr3/EjH79c/XAM6M7YhoXBdlhDxNIa8Z7YF
 uUM//brT3xreb4Hi3RfZbxC9cnYfhFBk7hjfEpup6c7pL2Pn5og+QIQEQo99VbEZrUftpZUT2VG
 3Bxy8JeJwdPSj0cRyc257HznEMY3zxFy+ij5AcTc9hi49o4sOmhoS9QGKoig0IGKsHtE2g3ysrW
 GND3iyGctM3PSJCo7JBK/4zmeKQ9JG7IKgvH2TkjgzvFkHHxxNSR
X-Google-Smtp-Source: AGHT+IHZLwBn91H4bJ56qitoCNXq/pSZPVVGMDqsdvculW0iwlCk+/e1ptE5ViwkL2pjLFCZDR3+zA==
X-Received: by 2002:a5d:64a1:0:b0:390:e8e4:7e3e with SMTP id
 ffacd0b85a97d-3971cd573fbmr8384534f8f.6.1742048844637; 
 Sat, 15 Mar 2025 07:27:24 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 07/46] x86: Drop mpspec from the SPL build
Date: Sat, 15 Mar 2025 14:25:27 +0000
Message-ID: <20250315142643.2600605-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

This is not needed in SPL, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 43e6a1de77d..a908356e8a6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -26,7 +26,9 @@ obj-y	+= e820.o
 obj-y	+= init_helpers.o
 obj-y	+= interrupts.o
 obj-y	+= lpc-uclass.o
+ifndef CONFIG_XPL_BUILD
 obj-y	+= mpspec.o
+endif
 obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_nhlt.o
 obj-y	+= northbridge-uclass.o
 obj-$(CONFIG_I8259_PIC) += i8259.o
-- 
2.43.0

