Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A01C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D0D81249;
	Thu,  6 Mar 2025 17:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMYFbhlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504C4817A5; Thu,  6 Mar 2025 17:05:05 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B63181545
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d2a8c2467eso2820175ab.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277101; x=1741881901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=BMYFbhlWWt2M9Fh/sFZNyjEMAtpUgCvx6ebaLdsmp6GWuMhkN2+ZuiXFBstMv8NrJc
 aEUwqrgzOOUXtjOROhGJE+HeEIhdE6eW9BGtTFZhpnFGAMTad2KG5ZB1aXZzGB6oYglZ
 NqSpaNis87CSANRmPbZbwELI/XKHSOzop7y0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277101; x=1741881901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=Gpxa5YXHkTsDkxVMNFG05GfXJRmNoewdCRYNuj+Xx3FtrBqPFFtcCgl0U6H5SDHEi8
 URwqjE+/Xlkzn5a7ZCin219JDJCBNGB6qJHj0rpJfM94SMW76HOdY4ppNKUoL0LJMScg
 OLgZl31lS0qMxoY2Rx/5FscsZx5FtEfeXUQI3N4rdHs0t5kDQsMmOBDRbBesPz1Nw63B
 8tgX8oesKx8YDzG8n2aIBdPRBeJlA9fMclVU+RSFmzZHAaZSOWQ44BUKS6ec8WN9jnzs
 vv48kyepar11vNl9DleMncRX1N8F/05gff6tqd3gTzCff4uoGNYZX/+e/7ikLdJdsyjP
 NMGw==
X-Gm-Message-State: AOJu0YxHDbmDjAlGu/Vd085sTEdLyuDCYdpMgT9xEihiuiciiAPjZi7Z
 vkh1S46b1OgQAt1CYRPB7pQHxHxDc6fxhYL3AXApgKUdl/ObVafdV64qxYnfK92v79ekr76Uzfc
 =
X-Gm-Gg: ASbGncu+P2v7ZZGpaec1Y5aB0/xkvSsipHszhFZ8bA7h+hQ0kkrKwfoB27hSjZgAhup
 K5M6mZJnIsP1lR1ej1VSuT+BtAzymkxTlXp65MGM/2+7yS0Ju7AX/AVP4vLzGlZkokWAppQRH2Y
 QwlS2CxyLB7z5LfPeuSXil9ohYiZ01uhnCdWOvKvbHhKMOJFf4ZJlcPo0pcQxZDHtLrXpokewct
 VCcYd2JxsLJRQRO4/5P0OhkLIQK4+tpbrFgBqmQ1yJnNv4Z8DYaX5wzw+hnciyNv/5GKJbQh4Wn
 LJ21lEqD7B2IZuvBGQfE3l4jWRTRNSXfKVoVYY3Stkj8xl6H7cNMS0VVbraPLy8HqfGmQ4oW1f1
 xcTzYnQ==
X-Google-Smtp-Source: AGHT+IHoZnnbU/dVoSbOMoA166RzQUAqc+z7IBjyXF2Vn9pWGEtty7jA7CQ1KKj5geEtukAU3sEYug==
X-Received: by 2002:a05:6e02:3a06:b0:3d4:3fbf:967d with SMTP id
 e9e14a558f8ab-3d441943975mr399525ab.7.1741277100644; 
 Thu, 06 Mar 2025 08:05:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 07/47] x86: Drop mpspec from the SPL build
Date: Thu,  6 Mar 2025 09:03:34 -0700
Message-ID: <20250306160428.3041057-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

