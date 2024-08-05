Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4766FC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 21:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE1C88901;
	Mon,  5 Aug 2024 23:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UtIp1pj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820C288747; Mon,  5 Aug 2024 23:25:22 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09EE8862E
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 23:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368440b073bso116998f8f.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722893120; x=1723497920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i65ruWJskLpdMsZG1FavZTKlP+nXnavrF52ov0mb0RM=;
 b=UtIp1pj8hWH8nQipZnyR67ds74M0owI/tScUYxk9F/F4vQKaj2Jm2P6zbZMWRHPgOJ
 r8YjnKgCfa+KHO31o1/LSBvcweKxSFgowAG2N9WTWru8m4y3Bs9gntbucsJ8XHX/c3nb
 t6zopnhBknzerF1wosr6EV9krWHYAwpbWx1V9q/I+VmMuVCDk5vM8VMC2g+WeMjn6Wkv
 LHuonQX6iyx1RtAWlyLU5PF61vJjXptuz+QzakOiIfBkPbCg53a+Zd0D4hMiRfbB9gd5
 JSVawLNBSjaHbdgEx09ltZItsiT0kfQ0jBZgEVVPFTK6aszSLC3qBoSn4ZfX1nKABg2I
 3s4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722893120; x=1723497920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i65ruWJskLpdMsZG1FavZTKlP+nXnavrF52ov0mb0RM=;
 b=hNYV5Iuv4rW8PndJnAzJjkrPSz9H52ufATzxiASJXXPfH2igHOaxbvAZ5EFfsqbHmv
 sb3AYyz+IiImjCGyvnapvLONfIb5ch76Lug5mzX4Ow44crnWhN/NG7r6SApQLqHQ0ZTS
 LENn6eU8SKKsKiqMt2Dugvo3T+nFoO0MQWSOywyYpNTbXwEg0m1j4sFXNh+T9gi/vzoL
 +d9bliLKqHiKckmLqKrRdto6cxsGhqhCnMzC/a5NXbfB7LhPTU5s/wJISRCN806zyjEb
 bmNpjNtsrJ/0Jsi+zYftkSI+dN1QAyAad57Q9dMhGCebcsMz3X3wPqt9A6N0PcniETFN
 ygyA==
X-Gm-Message-State: AOJu0YzAWND69IYhZIhmMEtwNAZue9lTqCYzmR7jWU+p9FTeJh3KSqTU
 CKWJAD8TZFZ9i9En9+wtFkXyGfMiqww+g3ia6upLfIkBmkgJDKV2ud5qNA==
X-Google-Smtp-Source: AGHT+IE4vC1TO/qCadnBxTK9n0G/HXfX1/fCRUnDwUiGFlTNoWdyRXBkSHoevKxa88TweQ1omaSoTw==
X-Received: by 2002:adf:e3c1:0:b0:367:89ae:c204 with SMTP id
 ffacd0b85a97d-36bb35aa98bmr10382659f8f.12.1722893119783; 
 Mon, 05 Aug 2024 14:25:19 -0700 (PDT)
Received: from p1g2.lan ([2001:861:3201:3d10:ab7b:e9dd:27f4:647d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c33bsm11018351f8f.22.2024.08.05.14.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 14:25:19 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH v2 1/5] tools: imx8image: fix soc variable for ULP
Date: Mon,  5 Aug 2024 23:25:07 +0200
Message-ID: <20240805212511.653667-2-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805212511.653667-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805212511.653667-1-bisson.gary@gmail.com>
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

Currently the ULP token sets the soc as IMX9, making it impossible to
differentiate the two families of processors.
However, since the 8ULP requires specific binaries like upower which do
not exist in 93, they need to be separated.

Fixes: 6ec65c8558f (tools: image: support i.MX93)

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 76d0cd62dcc..53ab16637ba 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -119,7 +119,7 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 		} else if (!strncmp(token, "IMX8QM", 6)) {
 			soc = QM;
 		} else if (!strncmp(token, "ULP", 3)) {
-			soc = IMX9;
+			soc = ULP;
 		} else if (!strncmp(token, "IMX9", 4)) {
 			soc = IMX9;
 		} else {
-- 
2.43.0

