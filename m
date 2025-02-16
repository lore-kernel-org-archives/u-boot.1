Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E39EC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D967680FBD;
	Sun, 16 Feb 2025 21:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="btACX7Lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DD180F95; Sun, 16 Feb 2025 21:45:23 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC8980F98
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-855183fdcafso125620839f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738720; x=1740343520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=btACX7Lu4HP/HlehHXO2fTAE2H32Gu7jgtbrI3SPhmr05p27E7jLwOhHuq87SgTfQI
 6RHzBiQ3ULIlLrk7zFbKx74pgqP1NUQre/YuO4jzyz0zAsYASq1QBx2YanhnjzXRKlBp
 IwxHj5VPgdDwYZ9xTASmojIsUAv9/ru+VtnlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738720; x=1740343520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=a82tBbHwSLmB+ThCYg79r+yMCKiAt31GKHO5/YnZLtOeB+LZ9i0Vza/QsPdbc0rLar
 aX4vTToSRQa2nWqvzPtUaMRGZA8KiPGfs23UA6cmE4WttUdJImyLoAQv12JA/IPDbrph
 HWRAF/CD+DP9x1OqiVVQxa3W7T5hJFFVp07t6eSCMzSgxkIfV1VqQT317hlydYwHXBTS
 mgXZ5oC5R9nIxA1dpfT3/8Rhx8sGu3cDVbDjIpxOp1xxNwqrQ2VcVGByi0QKl+n3dcDt
 ZpLLa55JBwZ4h4rQgfmRuco9YE6IlZrS87XCHHkzQE97HEUDu3ue8notPTO3ryzcLgXG
 Cz1g==
X-Gm-Message-State: AOJu0YzG4McwIMdKByqP6SPERjpHsox1pZzEG33gNtxpf1XLRVJe/EFY
 re1wH0QYD8X6Fd9YFm6100FfV6Ag8PKW7UDAt3A4iXEQztLI7AGL768RqpEEApMg62S48Ur9ZYM
 =
X-Gm-Gg: ASbGncuXDXM273FgEQaBid0Vs3k5JN25IkrldmLdJ3bny6VdDav8i0FPeSgnKPNn2S2
 qrQY1xzpnOkma/KojDYi/ujJE2xwUWs1u43e1Vrvh18erAFQxSD/2UR++cO+Al/l8QIf31ee6Ns
 g+NCIw6wFvymCHTf17mK40at6SaFmS2X0JYWzlSX9k/scezvVq0WsvSgPjvTyL+uwD9PaMH1Rdz
 JIx8tYwkZ4tfeOmZYtY17xcBumkiJJ5eEYzTFioPZsjv7GfEsgdE0v4o5Xywy2U2ZGdgVV4rMbE
 XLzyP2p37PzZI1kAMtZ0sfNtFGQTfmbjD/Q5lRqk7IvNja4xhgyb
X-Google-Smtp-Source: AGHT+IFRXtAwqnlEi2M2w9MiIx1D+BooGkKTY4MjF+fWzvNNyczNi33m4iIjF+vn765ZJYe8Lntjpg==
X-Received: by 2002:a5e:9415:0:b0:835:39a8:e201 with SMTP id
 ca18e2360f4ac-8556508c8aamr1001229739f.0.1739738719983; 
 Sun, 16 Feb 2025 12:45:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/28] x86: Include stdbool.h in interrupt header
Date: Sun, 16 Feb 2025 13:43:58 -0700
Message-ID: <20250216204421.3560012-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

This makes use of a 'bool' type, so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/interrupt.h b/arch/x86/include/asm/interrupt.h
index e23fb2c8e72..c689fc23d08 100644
--- a/arch/x86/include/asm/interrupt.h
+++ b/arch/x86/include/asm/interrupt.h
@@ -10,6 +10,7 @@
 #ifndef __ASM_INTERRUPT_H_
 #define __ASM_INTERRUPT_H_ 1
 
+#include <stdbool.h>
 #include <asm/types.h>
 
 #define SYS_NUM_IRQS	16
-- 
2.43.0

