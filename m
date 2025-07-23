Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A03C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 13:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C1A8350A;
	Wed, 23 Jul 2025 15:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huSsFt6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A8F8350A; Wed, 23 Jul 2025 15:46:14 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCBF82BA1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 15:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74924255af4so5793271b3a.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753278371; x=1753883171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsdYy4DWZ5E94wVXLyn9mUfwZTbquhchq0Doz0DzCvI=;
 b=huSsFt6cZhjb+XnawA0ZGdSHeX5gUG7bhIqroXqn7EJe6g4XNoOCSIOF6er3atkt8O
 9xcBVdalvwwspqQrraVN4TTKDzCNiVqkeZFvAMToRkmoKce+mHkWm5GWNreCHVE7+h64
 yPgiJw2Y3Z4ixSKSQ9dvzB5fHRZZbYTCvk6FNYLvkS3EndtRMqVvx+IPWCXEVEoof+IK
 AdAjRngqy6JvtWrc2UKszT4GuPARc/mG0lRQ91DbD2b/+kbsNhSwaYQjkI1ecEooBY1o
 LPdqSGgotd/6hOCBl2XuhYSpxTeCNW8DlXRnuYSsRNfd0ZoOU7NPqj52d+iV/dts3vMJ
 i3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278371; x=1753883171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsdYy4DWZ5E94wVXLyn9mUfwZTbquhchq0Doz0DzCvI=;
 b=Rm8Vd63AudmIw5F7DZpasdbKGcljGLhHnWAsGlNdiF4uV0/94UsNgmjLfryXQfiVLX
 7ESmmkGGwQKK4ftOJjqK00d6L6MJdOARih1AQeeojLJt6CPVt0/M/lFRuYSOIFgRr/QN
 HgKa9VdR9cKnfoLm6AKXpDP9NAQUhU7uNxex0nNOyjHDw4GcYoX9fb4gHloQI48zqNbB
 oiroerqW8IdH0/en74hjMCskKd5zXvfj5eBtzUsGX2CvxtCwDZ8wzGHf/36ly41S/2S/
 wIbzzkpfPHjWcusHZGT4zVJjBPkV/T1Z0zrizawSg8HmjVPCr/m+ejxpu5W7W0U1Advx
 Gg2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRHbPMjFRhCBIS9tm6JcJBfCqm0RZ7Zf7Alz6WBqiZ8fFEbtywKkjCl5DZWfXloJPs2+A3oOU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8wzfJSlYDJHSoY5LL9yhtS7CNLtBTR1qRARqN0/cdvr6s78GW
 4vCVRHiwbnK/RwFP45nNtcwGjQycVoZqTSz2SiV/Nle4/v+0Uj5PgVj1
X-Gm-Gg: ASbGncttHfGEr7rAcPElSOcAxsQDUr4zcRFzlg0Ke8ZCenwUw0DQI3+n0IS5jZODkx2
 DvB9BHH/1X5tM0IgnH4E9YvfY9c/JO21A+Y4wpzuvi7VbajeLxAqiLE9r8MlcShkSpTyk6mxI9e
 0OG3Xrd91Se+Ie4KSZd/IZsXLmgj8UNUViaet/T4f4wzaljaMoVNtrCfX9b40tmvWhL3QF9x74E
 QO3qiN4n399zSP17ZYF9Wt27oQNtVNn0N260dC4AvVOVkJ1bGyKdpvSc/XOontFAS03qBkyQOGO
 eLaDaSJKJdUDUih597H2Hh6rg7h189QxhTgHp6w3zoxqWqQ/pqbH+ml2vJXwYYrMpBsvdsoc8K2
 QKGTOG+jW9Qfj8nGoJD6DVRB1trL1jYu5QiYPS6jh/mUvJ6o=
X-Google-Smtp-Source: AGHT+IFvvyz7qwoMnuUQtVHCoTRz/zsPWxC31PYLNsHRfhijOll70Ua9vtw1GO0Eqvq7Y8RXA8spCg==
X-Received: by 2002:a05:6a20:9147:b0:220:1af3:d98f with SMTP id
 adf61e73a8af0-23d491221d4mr4735658637.26.1753278370637; 
 Wed, 23 Jul 2025 06:46:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:db41:d59a:1994:977c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f3c999588sm7154595a12.66.2025.07.23.06.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 06:46:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] imx93_evk: Remove unneeded header files
Date: Wed, 23 Jul 2025 10:45:56 -0300
Message-Id: <20250723134557.1972331-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723134557.1972331-1-festevam@gmail.com>
References: <20250723134557.1972331-1-festevam@gmail.com>
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

There is nothing in this file that makes use of the definitions from
sizes.h and stringify.h.

Remove them.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 include/configs/imx93_evk.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 94355cf61e49..e7db0161126e 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -6,8 +6,6 @@
 #ifndef __IMX93_EVK_H
 #define __IMX93_EVK_H
 
-#include <linux/sizes.h>
-#include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
 #define CFG_SYS_UBOOT_BASE	\
-- 
2.34.1

