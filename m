Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3399BC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 21:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D5987A8C;
	Mon,  8 Jan 2024 22:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gh92+mPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094CE87A8C; Mon,  8 Jan 2024 22:11:51 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DD2877AF
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9ab48faeaso419823b3a.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 13:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704748307; x=1705353107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DHqcUbjxrVoW86bDiTanSkA0v4N2pRH32cvAl1clU5w=;
 b=Gh92+mPKmaCvCIEeJFR2WCnrkn4F2tyIsvwbPaW61eA0jAb9WLGNbFiknkFRBTFBnJ
 zgES1J4PJUmvHALTEnvQXovRtJ5L3I9v2R9m6VhI2aKdSnW4FruYTjji+DT9T0JOys51
 TQlYlGz4JIGv7jTECbGpPd9a18XKpKWAFSsueg5/lNB5gDLJpp87/2WZaRTJFoo0JhPE
 XqgZUIuBTwmPC5sfFN0UWMaqAjjBAfvUnK9+ajoBxqy7HQxyvQRTspltwUcsY1+oMWZf
 EXXHnAPmy6C4BMwZMCOXfjasovnzL7h8fOTAYbdZKW5QMlyX80Ol4sJwig7rfynBNaWr
 ZJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748307; x=1705353107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHqcUbjxrVoW86bDiTanSkA0v4N2pRH32cvAl1clU5w=;
 b=ws0K7rHXLuXy26c9n8Y2e8EgVof+eUYFPq0aZUhIvFBXUUjQGveWtl0KoSxrOGBz4f
 F69aRXORyyJmo1gBvS/vuWX4o4Cqc1Nt7zbr4tHRMkq9+z4epF9pesJ0eaznvAD4s2M8
 /Kv1hvhxKbUJ/F3ff6FIkmKwo7A5aJxt6ntIPCmBdYvmLVR3rqII5uF80bml18ZkmMYu
 UAaMoOXRt452NSO1ixoPWmyK2zsm3gl3NgxCNdr8r6xzgL00olg8RC4sovnfMHT7qUR6
 HYFfyqIezhaVwSCRnruiIRJUACZRHQPX2yDfzNON2BCSWgPsGlx4jH8tE69uU0a8U18T
 KQow==
X-Gm-Message-State: AOJu0YxjHp50wehgYGD/cB5aDdCrbfCWtvy4FVhiZwoIvLWkcsNNzgIG
 3WMyqKfxiOX8cpQX31jqlvQ=
X-Google-Smtp-Source: AGHT+IGOrdh8w+KClb7P2OtwEbsJaQ3+/DJH92e/jv2dNF2uRNew74JLvyCbvIZEEN55P1eePOoBqQ==
X-Received: by 2002:a05:6a00:2447:b0:6cd:dfff:19b6 with SMTP id
 d7-20020a056a00244700b006cddfff19b6mr9142114pfj.2.1704748307052; 
 Mon, 08 Jan 2024 13:11:47 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:63f2:cfe7:4b90:23c])
 by smtp.gmail.com with ESMTPSA id
 r11-20020aa7988b000000b006d9aa6592d0sm304581pfl.82.2024.01.08.13.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 13:11:46 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: m.othacehe@gmail.com, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] doc: imx93_var_som: Adjust the underline length
Date: Mon,  8 Jan 2024 18:11:38 -0300
Message-Id: <20240108211140.3270595-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Adjust the underline length so that it matches the title length.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 doc/board/variscite/imx93_var_som.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/variscite/imx93_var_som.rst b/doc/board/variscite/imx93_var_som.rst
index 2225a772e375..4951afd2dad6 100644
--- a/doc/board/variscite/imx93_var_som.rst
+++ b/doc/board/variscite/imx93_var_som.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
 imx93_var_som
-=======================
+=============
 
 U-Boot for the Variscite VAR-SOM-MX93 Symphony evaluation board
 
@@ -38,7 +38,7 @@ Get the DDR firmware
    $ cp firmware-imx-8.21/firmware/ddr/synopsys/lpddr4*.bin $(srctree)
 
 Get ahab-container.img
----------------------------------------
+----------------------
 
 .. code-block:: bash
 
-- 
2.34.1

