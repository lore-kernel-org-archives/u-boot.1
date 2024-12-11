Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35377E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B5180235;
	Wed, 11 Dec 2024 13:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dec5MXwA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCBF8021C; Wed, 11 Dec 2024 13:20:49 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590C38020B
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so1068883166b.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733919647; x=1734524447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hToCuvqo/hPIlaZhTNZx2upP465fBwmDWzJPrxLXqGA=;
 b=dec5MXwA5I1v1J5+f9pPtf76BYX0pHv8DqEa33sTE6KHuS+CxAQFZg9A5cwEz/o/R/
 4VpQ0xmdKSozCExUklsiqVYG21zLvoZfQWD8ihRB0A6Qj0ANXfbqmykSW+/e9akVXwDn
 Sy3kApWDSP06suIf/tQDEAgDZQm8OWma13nfSYbp/e5MYVylbP74dij93MTXpoKkZm5c
 5roP4Oy1d66PYwMKLrzP15PX26PpwVl+x6lVtquvh4Jk0X3NtB31cuWU5C3Qm4H5Ky8m
 ihTatkaphwbkY/peDvAKuO3r3pFwYVN+kpjx6sOrmdWamR12TIHtHzvrZUbwO73+nABZ
 TSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733919647; x=1734524447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hToCuvqo/hPIlaZhTNZx2upP465fBwmDWzJPrxLXqGA=;
 b=RQg1H/G0D9QKsJTsGUFyssEszVbF/qDCtpRjVpIrv+hQBNlr+6+fHySLC2+I1/R5SM
 ou6/pOWs1+4CDwuuNyHemIORuNqXcxHdi4CD1SMABIr17v6/aFY2TMGkApflnnzHWr4y
 nTsXApEdtkFpkHswqVZy2X/1UzzHDl2v70GzBiHwnvUY0RhkThXB/WNzIj9uu3DiM2xI
 +JRJOmIHenFOUXy3MFi1572lQPL1jrWsElLfBaTvFATkoiq/1Dp3EjzNIeOOS1rA715u
 43u673WMDxaN+0Ch6TxAXofJlVtFXckZUqDEYGWpL0jgz6oPYdyJzVKfN6alT9HyngvY
 4uwQ==
X-Gm-Message-State: AOJu0YxSFjIU/u5L9r3yF9cCbSt2HuuZvLFCMw/2le4dMHb//tknIQlv
 aYCOewwZw0vrWx0t7AH9gN7U4bkkE2b/GoZRzXe1C9dVYUkUiEnL
X-Gm-Gg: ASbGncuvk3OoXXjo+cpRJMpN3oDyCntqjSo6tS6H82vcooA8rRiUNQtOc/I+GMssrLG
 It1ibUUWX4Z/y1/2UKUWsMhkq74Cf/cSfaHPED6DZ9aZ4f2NpRPwssfqzUeZ5NEYvWu0eD0w4xF
 n5nO8j0uhMwtCok79FYxfe+vLtNnpTPZGE8ir+H2vhHGTYD8YjM1fPY7nIPOUkB7BEgPuvoqe+u
 AIyzqRTCqVfXKtqgiE+r/T9eDwqOSbHIoiLLVPe4njp96CmwghxeyePvF8NuOoT98r7anjDYXk4
 BmUOF9Yode2JQui7pvkGfrA55NTM
X-Google-Smtp-Source: AGHT+IFg5C80L7emxFoM2hPvsE21XxHwlhlVlWQfcVYw1P5BKU+dmFQLkgQfHW6IILT7rIuB7Id63w==
X-Received: by 2002:a17:907:9508:b0:aa6:6e04:eef6 with SMTP id
 a640c23a62f3a-aa6b1517f0emr195581066b.61.1733919646568; 
 Wed, 11 Dec 2024 04:20:46 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6a23ad9c1sm256530266b.48.2024.12.11.04.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:20:46 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com,
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/5] toradex: tdx-cfg-block: set apalis imx8dxp to always
 disabled
Date: Wed, 11 Dec 2024 13:18:51 +0100
Message-ID: <20241211122036.103383-2-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
References: <20241211122036.103383-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Dec 2024 13:50:55 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Apalis iMX8DXP 1GB is currently set to enable when compiling for Apalis
iMX8. This is a mistake the Apalis iMX8DXP 1GB was never released and is
not compatible to the Apalis iMX8 series.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 0fb49fcdfbf..4ef71c721f1 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -122,7 +122,7 @@ const struct toradex_som toradex_modules[] = {
 	{ COLIBRI_IMX8DX_WIFI_BT,            "Colibri iMX8DX 1GB WB",                TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
 	{ COLIBRI_IMX8DX,                    "Colibri iMX8DX 1GB",                   TARGET_IS_ENABLED(COLIBRI_IMX8X)   },
 	{ APALIS_IMX8QXP,                    "Apalis iMX8QXP 2GB ECC IT",            0                                  },
-	{ APALIS_IMX8DXP,                    "Apalis iMX8DXP 1GB",                   TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ APALIS_IMX8DXP,                    "Apalis iMX8DXP 1GB",                   0                                  },
 	{ VERDIN_IMX8MMQ_WIFI_BT_IT,         "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	{ VERDIN_IMX8MNQ_WIFI_BT,            "Verdin iMX8M Nano Quad 1GB WB",        0                                  },
 	{ VERDIN_IMX8MMDL,                   "Verdin iMX8M Mini DualLite 1GB",       TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
-- 
2.45.2

