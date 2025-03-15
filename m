Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA60FC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385F681DB4;
	Sat, 15 Mar 2025 15:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bOeIkiE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E0981D6C; Sat, 15 Mar 2025 15:28:01 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA0881D6A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso2971595e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048877; x=1742653677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwCi5fFcCIl+1HqI/RJOgU0oPJvgxI88vMsJeVwX3JQ=;
 b=bOeIkiE+J1gR6wnUuoMgTs9E+RBtE2rWA89DE/jRpH7xToICM5LADXqDOVqMtGGSQy
 OfPliIIBRN4KSjt5M1XPNe4A6wrR8fAOzLLF5ZuKuaHWvFN3a47rFIeXAq5H/HwfWPT/
 k2l1Q0BYW3JZ5MqqbUI3RRZJhi1P9Z1u7Re7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048877; x=1742653677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwCi5fFcCIl+1HqI/RJOgU0oPJvgxI88vMsJeVwX3JQ=;
 b=TA/f1W9seeLK4Cy425CfBTK1dIDJdac0M7byqVfc8Hs4zdOlDjjl/2K3gd1502x6o5
 gOyZbk1qKGizrYiAV+CNPUv4lPXQPps9TY7nJjkD0lWp3kWG0Qhe2+1SWgGXX2TyI4bB
 uSSKmaCDLHFyYacOmUPdw19mZrG8tTf453DGUvs4Lb51getLGrgwEQOdh0FUIGycKjuQ
 lImGlSgO6O8SfvCYioavjVjstoI28OwgHzwpTwGcb/PENfVpVxCMGUGUjc1r4/g8FVDW
 VI08JMeOQ/jcpEBhzitpHB+bLHj55M4T+i6xQEXFfCEj3KzcDbVVdOVSNBWKgsisc0tz
 exgw==
X-Gm-Message-State: AOJu0YxLnRmmCnsdahlN7atWd1ljONX+hXIR4xHIRmOBt24N82jNJMMe
 GS/IUa2wO0fjpWOil5RRhDEKWCJsvEp6oDUKfuckROufknJ0tf5TFEXSTeHdJhnJnHHXhbgnj51
 aUw==
X-Gm-Gg: ASbGnctJUiBvRjH1p7Pua+XNxufUs3k4gULmEoJE6/M4928x9P7skmgn0hJT/Dl+131
 xjkeDH2GLT2zSWEc8wuRZ0leS64YielMIkfd/P+hTnSJq3+yEcDU+i/zBGyQihwNZmn9osToI0T
 zu0ueqwbS1+vrkFYTo0S/UQAltoERDmOTsyekn/hmkDqryKK9hEXBlTowVtoeQJQXiJIO+jSsoL
 wC/lVaxpfgumTMM6RvbyEeqCZp5pMgw4HrigArOengKnMnQn3QT17pWxOkU0fBhQpe5irsL9lWB
 1Zp0fQdDYAtIeyYbrCFDFj7M6fWkJJQTsz4HfKgt1Q==
X-Google-Smtp-Source: AGHT+IGK7tYRVrDJiIq4ta5OweFzwMM5KDoeDd8D8rO06vSmtXnPE2mjmNvjpRc+n/GuIGvVrLR8ig==
X-Received: by 2002:a05:600c:4f95:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43d1ec004d4mr85316655e9.0.1742048877444; 
 Sat, 15 Mar 2025 07:27:57 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 23/46] x86: Update mtrr command to support 64-bit values
Date: Sat, 15 Mar 2025 14:25:43 +0000
Message-ID: <20250315142643.2600605-24-sjg@chromium.org>
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

The MTRR registers have 64-bit values. Update the command to use 64-bit
values so that memory larger than 4GB can be handled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to update mtrr command to support 64-bit values

 cmd/x86/mtrr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index 93be84f74b8..289865515ef 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -13,7 +13,7 @@
 static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 {
 	const char *typename = argv[0];
-	uint32_t start, size;
+	u64 start, size;
 	u64 base, mask;
 	int type = -1;
 	bool valid;
@@ -26,8 +26,8 @@ static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 		printf("Invalid type name %s\n", typename);
 		return CMD_RET_USAGE;
 	}
-	start = hextoul(argv[1], NULL);
-	size = hextoul(argv[2], NULL);
+	start = hextoull(argv[1], NULL);
+	size = hextoull(argv[2], NULL);
 
 	base = start | type;
 	valid = native_read_msr(MTRR_PHYS_MASK_MSR(reg)) & MTRR_PHYS_MASK_VALID;
-- 
2.43.0

