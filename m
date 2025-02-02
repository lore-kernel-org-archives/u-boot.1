Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE58FC0218F
	for <u-boot@archiver.kernel.org>; Sun,  2 Feb 2025 17:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48A480107;
	Sun,  2 Feb 2025 18:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VjmU5aI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D3C80077; Sun,  2 Feb 2025 18:10:46 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5288004F
 for <u-boot@lists.denx.de>; Sun,  2 Feb 2025 18:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5401bd6ccadso3732884e87.2
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 09:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738516243; x=1739121043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z0FxjTIrBHB2Rb0Q3gl2E0AVHgPzUpasoh43Q+/Ljbw=;
 b=VjmU5aI4yyN0xpM4YBJBp9s6PvQzWpjJfphNpgV8P012WDbjQyfrKRzZ/rvG7fgaJK
 IIRxWczUR4dD2oQCh0hNcXBkLkmlCLs/XcziBMSgTF6LSbLMy1ut6YSMryTPRpiNaIw9
 HevwGuAKW8Y0fCKuzmpLgYxWARaAscZfkFNZG3SE9tCrZd9MFuoS2qHR/mFpfJHDK2KW
 e2gdVj1c+QO4Nr/mJvadbO9bf01Du/6oqwCYrVl8ftHZOxzQGXdQ2cePlBCdlME+vwjz
 7YSxPvxlWZJh9n7JXN9x2Iz2W7zwOn2KTILUOfh9aWYZIqkHv2t2KIMqlBV2/JS4nbXL
 fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738516243; x=1739121043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0FxjTIrBHB2Rb0Q3gl2E0AVHgPzUpasoh43Q+/Ljbw=;
 b=hR6yIAVeuHlu86oUXfzJLaQ8w0o5mv7papUmMPrwis7BRojcphkR08FkQ+wZJUkVrp
 lXLIfgqDM0mMbipnS5R3ffYZjeRZrRoc4ahfZH3pNxSIbbo4T0GJkbHK45LX7sKom4Pu
 P84PsCmSbfr/VcHoY261F5NVbkpuZZzuG/+QoMwzQQewlTCXJYx+HvdvfaHLr8GTNgmn
 JCH34HkILFBHrwAafO21L79ek2l+Mse2mxNtBH6OslEpyfXSM99R7mMCVQyyXkNvkBQc
 L5A/Xw0gQviE4X75iMOSIcRRMsuPisErkQqlwaWB9+TB1y/OIvVRq6t078zAxRwxQHpD
 Ivtg==
X-Gm-Message-State: AOJu0YyJJdjnGD1y5/gf8xM/FotmLWjOhW3B7CYQDtcqxdffBrerWWs/
 AT18+X+bCnyWmieMA19XUhmjhsSxI1x6nRX+zhxbyOKX7OxcA4cw4D+CNA==
X-Gm-Gg: ASbGncut/6rETiTJLcDgMf6kjJQv/Ng5rWbdTaY73WhTu5IQR0+RbtiKZbSjU8peLZ6
 6ruWzxQ5na5PQAy6tqH1NkhEVJzIbonQzGjBgex2s0fcsEHupTNk/b9KJsyYYwCxMWX8c/LwND3
 mlUU8GQknCEhKHoyQX18I+TaVJj+1RsGrQTVL+CX4kn3T8rXJ+7QIrxTsPQFQPZHCA1gpbTGoxx
 tgah5Aq5EFFzsCgHHi5oBIjBGxjVyVN8OtbtmQzF5p8dBP54of915eQz0ZDyUpIvzeaM/t//iTc
 KnqtE/XBewF1nJQserArOfk=
X-Google-Smtp-Source: AGHT+IECAoDp9bIAdEpGa6I7bkIoXUL29/EE/lNUV+FBwFoQrGmmTWArnyekdfWEPaSYF3aO1kMSSA==
X-Received: by 2002:ac2:4318:0:b0:542:214c:533 with SMTP id
 2adb3069b0e04-543e4c03255mr5163986e87.30.1738516242749; 
 Sun, 02 Feb 2025 09:10:42 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-307a3427f0bsm12292301fa.95.2025.02.02.09.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 09:10:41 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: imx8mimage: Fix potential memory leak
Date: Sun,  2 Feb 2025 20:10:39 +0300
Message-Id: <20250202171039.2073407-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Feb 2025 18:16:01 +0100
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

Dynamic memory, referenced by 'line', is allocated at imx8mimage.c:187 
by calling function 'getline' and lost at imx8mimage.c:210.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/imx8mimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/imx8mimage.c b/tools/imx8mimage.c
index d60d293e64..0f24ba75c0 100644
--- a/tools/imx8mimage.c
+++ b/tools/imx8mimage.c
@@ -206,6 +206,7 @@ static uint32_t parse_cfg_file(char *name)
 		}
 	}
 
+	free(line);
 	fclose(fd);
 	return 0;
 }
-- 
2.34.1

