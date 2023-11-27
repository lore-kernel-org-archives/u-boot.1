Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E154C07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF1B8773F;
	Mon, 27 Nov 2023 14:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EzSZHQEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD018773F; Mon, 27 Nov 2023 14:01:13 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226248773F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507a98517f3so5641444e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090069; x=1701694869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp1Xhgf4y5DBBqJwAXIj4y1MPHFGwEfkxd7bvz64qkI=;
 b=EzSZHQEuOqxg5vZUKTYmKUnXBRkJZbbMeBsPYFOUITTTJQF6obmkNi1UcmO+nuSHGF
 Pu5vdAxBxop/8xGYdbGLcoz0JraQl3rk+KHmsSxHgf8ooF8vQ7wuKc+0ZXm9WPvSSjfM
 0Im9UFbgYvBfm34MY+zyH51l8irm7fGIiMz1lk0PuiL+7lq/aqEPyrLnqfo4TxBPduJd
 esa2CUYmBomhlA0XAzx16WhM9xYDNIkOkM2AsLDZHAbsCsKUzwLaKFwIPjYbi5YU10MJ
 V/LcAZoQPzHxUOnTlS5aUxHTs7N+OgekOvRJElqMIyHTR667+wVgJtVasRpe20y6TJS3
 EUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090069; x=1701694869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zp1Xhgf4y5DBBqJwAXIj4y1MPHFGwEfkxd7bvz64qkI=;
 b=fVFhjOWFj7uxQGS5wGgxlG6trCKj5q3JyAkAXNnNLeAQFPpKH1e+awKjt17G7qIZu+
 7KLUNZqhVy40zghY/fZm6VqMkFGhViQtfzzvVzXsrz38gSDtKa93F3WDzWbFvrhxMjl7
 FDTvWMCtywkcodBb4xy1mHCANIY27eW65kc3PR/3VNC+FBYrLD2WjrRdrhAHchqVRshU
 VJ+r8BlW56YAydG1nvo3AEocF+xwiFSKUX69Sio3vpWCWQ3TTvqjtgq+Ze7PlPOOK9Z1
 QiLaK2wremndwpxVhELwhvnKaqgHSEMejlsMj0aDzseHWTf7JstnvSdNIH5Sjs4W78ym
 QDpg==
X-Gm-Message-State: AOJu0Yy7wdFYRQCdtEnqL+bQKQpoD/53aC5P53yCYvGx5MTPM4XI3GlB
 cdE//Lbzxglr/Ul4ZajzPNr33YMgcw3CKMRvfOHFnw==
X-Google-Smtp-Source: AGHT+IFNJd3Rn9h3bF5fliHfb4jJxdNfNgT64t++ntXminYyI7dGuxlanoylP4I9wJJXFZhhLE92OQ==
X-Received: by 2002:a05:6512:ac2:b0:50b:a720:8ae4 with SMTP id
 n2-20020a0565120ac200b0050ba7208ae4mr6772337lfu.36.1701090069390; 
 Mon, 27 Nov 2023 05:01:09 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:09 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
Date: Mon, 27 Nov 2023 18:57:09 +0600
Message-Id: <20231127125726.3735-27-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/tbs2910_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index 8fbe84f1d2..ce40efa9ab 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=0x10000000
 CONFIG_SYS_MEMTEST_END=0x2f400000
 CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=392192
+CONFIG_BOARD_SIZE_LIMIT=417792
 # CONFIG_BOOTSTD is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
-- 
2.30.2

