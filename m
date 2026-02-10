Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F05CEA8128
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752FB83E3A;
	Tue, 10 Feb 2026 16:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EULN8Doj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8AB83E23; Tue, 10 Feb 2026 16:15:44 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FED83DCA
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8c69ffb226eso576702285a.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736541; x=1771341341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfdRtqEvFkIHCWNCX6N0ehrjloOW3r7N9dJjOBiZe9g=;
 b=EULN8DojOygmt/CYA9MTtBGfgf23gOUQvaa5wOd3EG45+ejzPjR+/Qsy7wznsFblFG
 +eIRMrgMOCP63H4l32ESV1OpkEdqPXaAA2BMnRlJForuRBnODo3kszNw63Y/Xf53mFld
 yORu/feZYQzskFsHx9lJoTVWHUESLaGv2jh64Sw1bBIqc3/trrsflVllAAJwmma1cIjo
 tk2PP2AbboKzMGSXR8nBS+wxSMIetDBmFcHBNp/5VW8BT+Xoe50rrjB1agMsTnFdYcG/
 q9TMgtpazzhgNzcVmfedrEJO7VcBdE7FBPO6vFIbIheHg+UWHi1UC38tXPDjm/uv56Gj
 BAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736541; x=1771341341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LfdRtqEvFkIHCWNCX6N0ehrjloOW3r7N9dJjOBiZe9g=;
 b=jrxcsED2Is3d/np/m7dE8ZIcEkCJ3JzQ8gTPCweIoxJP27Us8g5Bu8XoqsOQhaxW1K
 atCWoOB3EbGOJ0cV8b9RUe/BeJkitFooPfCh8dlL7u5llCXkJwXKpi/vElJ6M3EBjBGL
 gxJJhLRTIaVcfoljkbdk/vnnM/vpjmUGzy5yWURo5G6lEJRdXmREUUgga5a+MISRqq7w
 iKXP6XtR/NprcgXY5NF/ZSVjztN1h1f++2Q7UN3HMHgqKC+Hxsl/l5L0RHKSqe0mUuPH
 HagbBl9GdxrpKqF+WKe8AjlSag+cKY173E6LCWqiRHcRrGFAD+Uy1hxOFTBPJem+8QtC
 5mIA==
X-Gm-Message-State: AOJu0YxPLJHUs3CwOQm4xoG5wBjmbReBITqdLlDcYvzy2m0meHtlo+yH
 c3lVlt3xbT8dgVo4hyG1Zk/A6CI8AclgSKt8TK3B4VWA0JjioT5bQgJ1GLCBhw==
X-Gm-Gg: AZuq6aIoZfQyd5Hv4kH0wX0dpg18l0ON2eDKz/xokbBZLrevCsiPZ+By4ynsYIVlyn9
 GKguFDhdcZwpEu0G4jet2xu/+62Q4WrmKiI+9WIlhSAybDSROiB9MXs+ot5oEss+8CAUqR4Cevg
 ml8uiq3VQoEKaP6op4dnGDSKGjvjBKVj367Nh8C2ApgOWmCPwtsCiqIP37kp9/VltLaYMeS8ZyW
 c4OZBp/5JlQLLPPyalrHzUygKDhlzRAosueYTDXKy48/QcTl4Gp2gB8lAKVfvvSJDF1cwT3EwTj
 RegiM1m03d95Gxgtmeqvnj9tpVTgC7MuqxcqGa2RpGzXEzT5PbijGETHA2liz8ynTI5bEoUTyGq
 ER2pe7/9ZCQ8cu7ahHPL5b2xbYwFSta5pMOeYTZFDC1DYSnyjOHlhxz2nzjz5bUJUYv/S9dfsGk
 yKUS7M0tMfXRJM5NzJGm8wtapxbav5Dp2eHqWx+V1Sae+C7f/hs47Rd8Ion5NkonzKd+Nl1IqE1
 MPPV1Zc7IM=
X-Received: by 2002:a05:620a:468d:b0:8ca:105a:f5d1 with SMTP id
 af79cd13be357-8caef7e7740mr1930473985a.30.1770736538861; 
 Tue, 10 Feb 2026 07:15:38 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:38 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 10/16] configs: k1: add default option for clock driver in
 SPL
Date: Tue, 10 Feb 2026 10:14:53 -0500
Message-Id: <20260210151459.2348758-11-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add default option for enabling clock driver in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 configs/spacemit_k1_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 617fe9d2aae..e64687e95ce 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -44,3 +44,11 @@ CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 # CONFIG_DEBUG_SBI_CONSOLE is not set
 CONFIG_TIMER_EARLY=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_CLK=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_SPL_CLK=y
+CONFIG_SYS_MALLOC_F_LEN=0x5000
-- 
2.25.1

