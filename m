Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F66C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE07C819D2;
	Thu,  6 Mar 2025 17:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hE4QBgrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE57819AA; Thu,  6 Mar 2025 17:05:33 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4713081B42
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d2b6ed8128so6772195ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277129; x=1741881929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0teTz8VB7qBHHw32SJpt8MR6+uPFQRq39wPMmlhV20=;
 b=hE4QBgrLXhFaUv3oSm0IDgMn/qxOhqNPDavVss3EkY1Pn+mxDUxUbJRqsAPQ9sB5Zp
 2NjsLb6gGJiO0Boe17b/yowa6U1UDyAXzV2b3pRukx9C1cFaD1L+H79vrltn1zHcVu79
 bIIpDoM4YgpA8QyIgvCptWllkkfSe6/AWVtqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277129; x=1741881929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0teTz8VB7qBHHw32SJpt8MR6+uPFQRq39wPMmlhV20=;
 b=i8zQlL6u5H17u6VmI6kGV3QHqkkqRf3AFq9vXJj4UXhQvX6gHCv9vT7yKS3UzBPQVN
 QCt4FFORtYYxk4lD673LlmuO51fpo4QnvRjMq0yuF6ceRZ7nC8q14bS0Sxv6I8LJcpI7
 gFSWoNmHJbfuKMwgHY+fo9xn7Ff0ykOCE/VWp4MOkORgBF1geS38LvdsxhiZEg2/fOma
 Hw1MxASav+/09XRxAAYyqBoV/yX6rb2pQRY6f5yocQOemYKYKGshLpCGD8pmcsBRHzI8
 GVG2aPqM62DqhsGejoQOKzwLLgYOZoE+oE4ihSrjNNYSjUiGCVe/J/QnIkTJ2BBXYsbe
 LgYw==
X-Gm-Message-State: AOJu0Yz0/LfgQTAoPYujy6PP+WNTD3tFLrfB1YF0BvaeqTtM3npbMvsi
 EC5DfJDVNSgSwpD1N/3nYY+9Zi71kfgOUcBA5zTyTrFP9oX9u5pknTBvAEcHiAPe54bcZmEBWZ8
 =
X-Gm-Gg: ASbGnctwLs4f3aolzlNwaUQernr22YGcyGPhsovpYRHAfqn9lo64qv8jFbMuhzu4i2u
 EUGg0LuhLo0p1mk9q8/gmQIC/dpF0QWoWe9SUXyAgpekguJDhPrrV/2pTZ1d6hr4ongfe69WETS
 wwRfmEWuydelQ9Hk+a9qLJIIw4JRvYK1dv610StOlsOMqDrWqj9QfaJFjckx5bUo2lUV5eNyzPs
 qsok3+kxXJXusHv9/sQdlOiraIyQUa50YxNWqHk8fyR+n5Sqm18jU1cW9rj0xt4U0iBkOcXPX4d
 hvZ9bIfCqsAVkHczhlKPpPw0sC/Kvf5MLRpFO26+EWJ1oFlHuHAfJjnp4jTOBZ+URt7bgXC7X+9
 q2BCwHw==
X-Google-Smtp-Source: AGHT+IFCKRG8hurvBw/z77226oxlElmblLuOWpPaYI4wsmmoSqvEx1OD2xrBqmZDlGkSFYbItwlJlQ==
X-Received: by 2002:a05:6e02:4602:b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d436aa13abmr45324265ab.3.1741277129186; 
 Thu, 06 Mar 2025 08:05:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 20/47] x86: Rename the _D dirty flag
Date: Thu,  6 Mar 2025 09:03:47 -0700
Message-ID: <20250306160428.3041057-21-sjg@chromium.org>
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

This value happens to be used by ctype.h so chose a different name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to rename the _D dirty flag

 arch/x86/cpu/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 845e00ca439..b108f724c51 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -596,7 +596,7 @@ int cpu_has_64bit(void)
 #define _RW   BIT(1)	/* write allowed */
 #define _US   BIT(2)	/* user-access allowed */
 #define _A    BIT(5)	/* has been accessed */
-#define _D    BIT(6)	/* has been written to */
+#define _DT   BIT(6)	/* has been written to */
 #define _PS   BIT(7)	/* indicates 2MB page size here */
 
 /**
@@ -620,7 +620,7 @@ static void build_pagetable(uint32_t *pgtable)
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _DT +
 					 (i << 21UL);
 }
 
-- 
2.43.0

