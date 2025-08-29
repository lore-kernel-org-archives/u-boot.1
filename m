Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67115CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 23:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1A383824;
	Sat, 30 Aug 2025 01:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jkmD6fgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90078380F; Sat, 30 Aug 2025 01:40:00 +0200 (CEST)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CAD837E2
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 01:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-89434e44afcso1302140241.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756510797; x=1757115597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EafLMbEkLM/zahQku3M0Wk0FyM36qwWWXx5zP0f9ySM=;
 b=jkmD6fgVfdbhxgMctIsfFAkhDk4h93QcdKuUW9ip7xfcg8B79f3eqzDRRLVQMyfocR
 n7qd4+9EjDBP+qRPK1vVqZqCslfRZwXfGpm4s2y2xZ18jDkIBynvPvd7uXOJzAGzdiAK
 P2Iz1EQdXUFSbpfXUxvjs22+U1L0sceXpeGmXKi2yghCLHSuBKoUA0QNyZglY1T74gld
 AksoUuzAOhUig0/zuAf/p025z+aaRHyEl4Px827rxOGT9FYpHP8QW0EfPdDkz2MmD3ys
 OWVsVFRgXpV94nhRGFQ6ysHcfgO/aSOz+XrebowX9KomdFEy/Mvw4oSF1IS6KjYQIgnL
 olHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756510797; x=1757115597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EafLMbEkLM/zahQku3M0Wk0FyM36qwWWXx5zP0f9ySM=;
 b=DVQ90nxtHVqoqtUfmXB7pjvGHWLPENbvsp7OHVMA3ksJdugiOssIZKpXu7YN/tW5Pt
 4qhXlIdmUfnII5CkFahQ766sf6Cxssgn/E0Sid28LZtdeCReGDfkX1VH3Fl5mgPaD5eL
 TziM8n41jHOC+b5J9EW/Xz2/neKK8xHS4zg8nK4G8XqEn3tDcR8WUP+fCdwDMLuK7te1
 VY+rpGbiEGMLHxU2Mlk9VFuAAgDRPw6ji9CLsTLC1DyirYMrcjqkOucJn/K+U3km8Vx4
 QVHjbuSpXRGF4FY7fEtD3l7He4HQMFcCx3UisVZA0MziU36tP/IL/QyoEnjP4xOswOo1
 n3xA==
X-Gm-Message-State: AOJu0YwDJpN8EOqHdrWTUW+R30Gk2X1dWaMZDeIFV0IN8PAj8CH9hxMJ
 MGCOPSvd9ZovB2GImMT9O01G+RmFt6ssgDUtFNsdlonvrozJQP0Kx0bFiGNO6Qx1vBxmy4plrVf
 35wl5
X-Gm-Gg: ASbGncsG9uFJuhJNmhophVFKFzTRdHY6k7f05dBkCSq+tBz+KpN2BXMvx7zSWZSp5ud
 AvsD7pWeeV2B/d499yE6Y9IiGjq3G68eZjT8ST5pCTU1BfgoNa8hXSMyAANtmD7sxCPCcVuBsE8
 E59NdMVCWHti4cI3Ir1KIUP7IQ2FU+BnlpFUuVnP3Z0PMPkCXpX/OgDwK1gjw+2fkU/Exeu8odx
 WI+QtAEl14vdoHKRUCqRYB0JqFLX+vw10gD1J1xggFKmPhIlGQBa0GGs1xxDUUE1JGMmLeP99G/
 7MYclvlqhOKcQv3H2pbYK/xRQgUHU9CtKkoKNN6Jd06nqFNCXMdSvBcbInG01SOpiao0JnJjIW5
 C778wg7quV0JyNT2LKjMuqsaOcYElJuKMA8z5tSdDihFqEKBO4Cn1EQvb/mo=
X-Google-Smtp-Source: AGHT+IGOr32lGz12n1y9tRdglANUVRPGKa8WToEk2bZuiodRl0QbXwaWuozY/fzQVCV4xX8XgaLpSw==
X-Received: by 2002:a05:6102:370b:b0:523:e010:df0f with SMTP id
 ada2fe7eead31-52b166d7d27mr131969137.0.1756510797302; 
 Fri, 29 Aug 2025 16:39:57 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8943bb744fasm1360819241.15.2025.08.29.16.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 16:39:57 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/4] tools: zynqmp_psu_init_minimize.sh: Switch to
 clang-format
Date: Fri, 29 Aug 2025 17:39:49 -0600
Message-ID: <20250829233951.547352-5-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829233951.547352-1-javier.tia@linaro.org>
References: <20250829233951.547352-1-javier.tia@linaro.org>
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

Replace the use of scripts/Lindent with clang-format in
zynqmp_psu_init_minimize.sh. This change is made to align with the rest
of the codebase that uses clang-format for code formatting. This ensures
consistency across all scripts in terms of code style and formatting.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 tools/zynqmp_psu_init_minimize.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/zynqmp_psu_init_minimize.sh b/tools/zynqmp_psu_init_minimize.sh
index 5c8b73703bf..f8b729ebc97 100755
--- a/tools/zynqmp_psu_init_minimize.sh
+++ b/tools/zynqmp_psu_init_minimize.sh
@@ -82,7 +82,7 @@ for i in $FUNCS_TO_REMOVE; do
 sed -i "/$i/,/^}$/d" ${OUT}
 done
 
-scripts/Lindent ${OUT}
+clang-format -i -style=file ${OUT}
 
 # Prepend 'static' to internal functions
 sed -i 's/^.*data(void)$/static &/g' ${OUT}
-- 
2.51.0

