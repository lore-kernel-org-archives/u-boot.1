Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7931C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427DB8894F;
	Mon,  5 Aug 2024 15:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAVLz5gP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D37B888F0; Mon,  5 Aug 2024 14:43:35 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0F8888F6
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b796667348so47169096d6.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722861812; x=1723466612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Lgrn6w9bCGS6LwfaPngU0GvNuYQHDTjCv2vQ//sos8=;
 b=LAVLz5gPXkRXFqqOPX8i3SI6iXm+688k9TEnVeTdETSdpVpySIGAqoBlKjSupgn2nq
 JZEYQSPi/UTUuDQWnAELE8/Mz4wa+PtGL2gZES4jaJn/eNcFi3h2ifgxtnUC8+VHOV0C
 f6Kwo9rysFnfpJOJC8fIsBZCCfpOVEywBQsQbj9VLy53BbikEc8c1viT17TY8AFCnDf8
 O57FesIxdsM6ZD5FCZwl2x9CN4yxo4Idlud8UFuKuQFNdVbv19OJhox5cHyiGjPYhR4M
 uQxbiBPfYG/P8Py/SYTYar8zj8t3FsHk2jh8NDvebvTzw9aSmnBMvEBKkNcNdTpMifAa
 pTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861812; x=1723466612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Lgrn6w9bCGS6LwfaPngU0GvNuYQHDTjCv2vQ//sos8=;
 b=Um7j2YMmPy/zbgCxkXii/cWqxSiVGIZNsfvmQCbDKPu6/bGj+smlUAjRudola8THqT
 K623XGp7FAvzHrVtnTu37eaefi8C0GbZusTm869JpaX0VSywV1BXfO2U6FEP4bXICXnp
 7fqZUu9J1e39fe42HTh/oF5I3KoKE4DMZi0EQ6PxY51qlfszO+ic7fg3VVjS/QUDho/Z
 FfVYpDYsdJVjnRxhI0PhKwo6f59s5mqZa8Vu5B8+pIUH7fnx/jQ1N78rH/gSx7Vnry7Q
 51UPI/dTMd1GmOzL5uCOJPccZdAUH2s2zBKFk0gx8VdMMbRwfecq7rMp6Fg67riC474d
 O1Rg==
X-Gm-Message-State: AOJu0YyCupnvYBw8eurLXf9Ve+nz9VOM4r+qcH51iCNZZwXwqlpu4USY
 BCh/gtv9JkpJpEUFlMxvPHP0ErFThk3q2oap/qJlRQP3KhbvMeDry3cFjg==
X-Google-Smtp-Source: AGHT+IEnfHtD773I4MZ5ltGerpL/B7DwG2u3u4o3deV5OMCRkuwtLpBVskAjBuy8i0S5Ei85ZUawdg==
X-Received: by 2002:ad4:41cf:0:b0:6b0:8991:a2f7 with SMTP id
 6a1803df08f44-6bb91d83d3cmr256969936d6.12.1722861812244; 
 Mon, 05 Aug 2024 05:43:32 -0700 (PDT)
Received: from p1g2.lan (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c87bb90sm34984796d6.130.2024.08.05.05.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:43:31 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH 1/5] tools: imx8image: fix soc variable for ULP
Date: Mon,  5 Aug 2024 14:43:22 +0200
Message-ID: <20240805124326.544310-2-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805124326.544310-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:54:59 +0200
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

Fixes: 6ec65c8558f (tools: image: support i.MX93)

Currently the ULP token sets the soc as IMX9, making it impossible to
differentiate the two families of processors.
However, since the 8ULP requires specific binaries like upower which do
not exist in 93, they need to be separated.

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
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

