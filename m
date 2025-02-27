Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEAC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 18:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D5F81433;
	Thu, 27 Feb 2025 19:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LfHiKyzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A2381433; Thu, 27 Feb 2025 19:38:44 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3082D81253
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 19:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d3db3b68a7so10832805ab.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740681519; x=1741286319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4512rpHqCMuwXl9he6QO8q7BOH+pCe+0TYcakCZVH8=;
 b=LfHiKyzcowmkLHSC9ErFcypgE3R+7FnvXMJLcnK2vMQC8y+cUV0ySAIqI6vPbhH6hA
 D2/7qEeNdSNnm0dDVwfOkIn/ntinVmiAgi8qE7mY3ajGIGlpU/+ZuLsigS3T2DbmjWwe
 FE7fKTog9/pKFkhK9NKsFdBLhaFe/395vSdpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740681519; x=1741286319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4512rpHqCMuwXl9he6QO8q7BOH+pCe+0TYcakCZVH8=;
 b=ccZX80gH6vnbWw6SI8iEWimxxvqRybtoUFv2PukhcbuOc7Jx6XYedfgn00gU09gLqB
 iZjvu2Z+8XywVRV6baUHCSL/bxrXgoaVoxTxHS1gQz1YuuDWJQ4JDE79hDj5+L0BsSc1
 qwZB9BVhTjfwituwVKO/rCMIrgaK4+6DBthgqRVwJ/LntzRsuNeEcp5CCz7i8E6VGrZQ
 KImwGaIleEf2jnmJ5rJzp2586a4ya8MBpr4OqVDsyIeVTpwmDDNLUAJkQDqdyv1kVSMA
 kgD4ZcKCMpGaWV1QLS29/HOpJ+UgfdaMp/EcgATsQOAI0v7rEHIZzb7FQVApDUhwHuVa
 ROgA==
X-Gm-Message-State: AOJu0YybQZtvQUXS0zpiunbG6KKGJfYJaTCWdj07ZG0HDPAl1GNZf4H1
 ZxskX3eI60hPFAKbPyBSBBiv+0xXl2fWD2gk4Jxa26ZULWVJrNWiIX3p5S4vuDOKz30aZDoBUg8
 =
X-Gm-Gg: ASbGncsuBBfYOyNwLG8Z0lBBklbWHrgLc0JEqjTGgSEOHHs/r3rNHe5YwCOR5M67V19
 0eaFDj4EOJ/loPJLuSHmr03FwTST6Onp+lGAr+5oigUZhA3vRMrfBeTicOA0QcEZiqRAA4x1W2Q
 TNjvNrZiqE7n0pjjRT7VM4Won8MiNwab3lmuc644sCL4WMFG55aSpyji6v9CMQzoDehkDtPqRHa
 x/gMqtcfldPvJ2eGhU5NzGejAosuYkL4z3sUR3jY8/x7Fj+nTK1WAN88P6OYLEK9LbqF2m6sk5B
 TTOLlkvb+AbtSbA/c4AQY3JAH/QUuh5LfFrOzU2iJjOf2SfxR6XkG4kJnlVmAuk=
X-Google-Smtp-Source: AGHT+IH21OwHKjzT9ctyN+cDbSgF2dXPHtu8z5J0wn9DeTnT/t9X9bt816yHdphxKkVnpym8ipuq2Q==
X-Received: by 2002:a05:6e02:2411:b0:3d3:ce83:527c with SMTP id
 e9e14a558f8ab-3d3e6e63990mr5087505ab.1.1740681519006; 
 Thu, 27 Feb 2025 10:38:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061f797bbsm473947173.123.2025.02.27.10.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 10:38:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] arm: Support a separate stack for VPL
Date: Thu, 27 Feb 2025 11:37:57 -0700
Message-ID: <20250227183807.372875-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227183807.372875-1-sjg@chromium.org>
References: <20250227183807.372875-1-sjg@chromium.org>
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

VPL has the same needs as TPL in situations where the stack is at the
top of SRAM. Add an option for this and implement it for arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use 'phase' instead of 'stage' in VPL_STACK
- Split off into its own 'vbh' series

Changes in v2:
- Reply on existing CONFIG_VAL() to select the VPL stack
- Correct reference to TPL when VPL was intended

 common/spl/Kconfig.vpl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index cf6b36c8e38..434562443ac 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -266,6 +266,20 @@ config VPL_MAX_SIZE
 	  The maximum size (in bytes) of the TPL stage. This size is determined
 	  by the amount of internal SRAM memory.
 
+config VPL_HAVE_INIT_STACK
+	bool "VPL requires a initial, fixed, stack-pointer location"
+	help
+	  Enable if the VPL phase should not use inherit its initial
+	  stack-pointer from the settings for U-Boot proper, but should set
+	  its own value.
+
+config VPL_STACK
+	hex "Address of the initial stack-pointer for the VPL phase"
+	depends on VPL_HAVE_INIT_STACK
+	help
+	  The address of the initial stack-pointer for the VPL phase
+	  Usually this will be the (aligned) top-of-stack.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.43.0

