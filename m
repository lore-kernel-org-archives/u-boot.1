Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189DFCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 19:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A00F086F05;
	Wed, 18 Oct 2023 21:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvSgfuXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9721A86D62; Wed, 18 Oct 2023 21:18:00 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EAF86EDE
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 21:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1156615a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697656674; x=1698261474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0HuyceIsI3OHRTlbOTjsKNGgKdGRiZhdzJM+8hxc3Y=;
 b=gvSgfuXuHPTaGIhbrYrOlaeSdNW6aycSjKeG9lddnFsEUB8z5OQMgL31F48qXktXGm
 tttpEqjNfIHeiUyc4s+EswqP8B8Ftc+5vR8meYdS10++n6Mj4GtbYJLmtuY8lQgmv/lq
 P1WQGD2ot2jjO8GWQgNcGXu5KYxVQDzuV6kdeWX+zdTDWY4EfQhGjH3NxIhBACH+8juF
 4aD2CYtoAj/unsfsMzm97hZ4F23eLA4YgDtsQqdOouvnQv4BVknwXLzE1RkEZuEEO4N8
 MByo9+OIjV2gpTnfxdu+f6X5YIzdegxYK2QtMCkGE87ekOXN4uTnXnAPCFdDAa4vlJdY
 Tm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697656674; x=1698261474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0HuyceIsI3OHRTlbOTjsKNGgKdGRiZhdzJM+8hxc3Y=;
 b=qGs4JCAfa+LY0xubc6JXPe4kkIRRZOj2YLBMuWNhM/cAv20P6XfbRBC/pUgFHtSPxe
 Db26lWSLPD4epgHhuYgGQO0mJ7sUXoXrwK+Hp6eygE4gWBiP0sRgiS6NO7jI0hCQpPcM
 VceWpDUSPLrcZLt0W1n5fGP67Jab/yj0trwhXh6FgzhdCa/XSDWQwXRdS55nzmfExLpm
 nbcipftr934r7YOzaCx1uyt3OYsWBlNzgVxgK0rY1cPFPFyfm4nKiXn457g5doYYv1pn
 AMe8j5v8k+ZXb8c3AKEgHl8o7bmJShjnRucNLS4gXagc5cxAgRp5kzVjWE/D5SyEfZHs
 vQrg==
X-Gm-Message-State: AOJu0Yy8PW6LkPBI3qmODmRhYth3+h8O91CFP//9g0mX8Cvb7QSFdJCr
 tvwWouPQi90VrKEC5SKpKO3FyISDC9I=
X-Google-Smtp-Source: AGHT+IHwGQHbv2QRnnIbh5yLLjC6w13drLWBML44MeHvwoy6CnPS3c+MSX6T3HKCO5FPThjEUxMdMA==
X-Received: by 2002:a05:6a21:8cc5:b0:15c:b7ba:e9ba with SMTP id
 ta5-20020a056a218cc500b0015cb7bae9bamr129174pzb.0.1697656674693; 
 Wed, 18 Oct 2023 12:17:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:f7a7:7252:9ef9:ef88])
 by smtp.gmail.com with ESMTPSA id
 ix7-20020a170902f80700b001c73eace0fesm277737plb.157.2023.10.18.12.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 12:17:54 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] imx8mp_evk: Add myself to MAINTAINERS
Date: Wed, 18 Oct 2023 16:17:42 -0300
Message-Id: <20231018191742.1303779-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018191742.1303779-1-festevam@gmail.com>
References: <20231018191742.1303779-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

I would like to help maintaining the imx8mp_evk board.

Add myself to MAINTAINERS.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/freescale/imx8mp_evk/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/imx8mp_evk/MAINTAINERS b/board/freescale/imx8mp_evk/MAINTAINERS
index 2759652cc425..c2c7c830b5d2 100644
--- a/board/freescale/imx8mp_evk/MAINTAINERS
+++ b/board/freescale/imx8mp_evk/MAINTAINERS
@@ -1,4 +1,5 @@
 i.MX8MP EVK BOARD
+M:	Fabio Estevm <festevam@gmail.com>
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 F:	board/freescale/imx8mp_evk/
-- 
2.34.1

