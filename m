Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F24C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AC18779C;
	Mon, 27 Nov 2023 14:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TV9HQbvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81298779A; Mon, 27 Nov 2023 14:01:41 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC3A87788
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50baa3e5c00so2491190e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090099; x=1701694899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVrJEggGQiWyhUZmh9VQRgAWKIQ1N3fTnwGAXaYlDHE=;
 b=TV9HQbvwE7lP1zBgPO+fprA7TU1dRijv39erkrk1fMQeuSxRda3C5X6coWgnK3lSlI
 2+SboOvte4ZWiFOqxvxx/aLuodggcyR/nAbJYk0/TP/UymxkGYrE9AD2gzZUVGhJ5Raa
 HyY7xEPK1lmM5uIgS6jxRTET+/gX/KwNUJcQpnWZkH4M3uPBDEDyGakyaBW0xznX8eTh
 fUMyNn33XShjLNhxRL6zCaseTa/1bals1AsgiuYLlN6OVO6xweDUqV3z821uCuxv7zs0
 g5cTZQz2MMzX/HLqDYBtGg4tY5jVcfyoJ/vr5+h+6NvyWXc9yoPQYTGuviMOkIRkJavF
 qCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090099; x=1701694899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVrJEggGQiWyhUZmh9VQRgAWKIQ1N3fTnwGAXaYlDHE=;
 b=gdktEyCdVIzXdqP1h6/g5sqAWe1JcAZEbaGOD7ck93LXgGKWvHrlZu4Uqiw7f/zsAq
 r7ecv54Rf+ew7b4JLWCdCmGNRPJZrYLc/nfXXS57EZSAwya8rMMU5IRJw03rqdebv+Zk
 Z+8MulcQPJs//SB6BAjspwt6hw2MqCdK7Uj/6XCNUqdhPz/PEH6V5MWcdM+wr09AIFBG
 5YxHiY5USQJ+NrhuNspnEVAocd6XT/RSekq3sFIIqV+B7LvYJc7wB0Dux2ClWLRRe/tq
 fY3XBNPtZbWWV3eJPTxiye1HjzMMqzRpjfxO/wJI/ASkEtAoF+NPgrCogpvXmvQf3t71
 T9nQ==
X-Gm-Message-State: AOJu0YxxFYlVi9Lyvwz5zlUwK07vFxDljtJGX7zdV0q/JcxG0doXbTEP
 ebIggoz6m8nvKWfBzh+4e688NNSph1gHjl50WCyU6A==
X-Google-Smtp-Source: AGHT+IHVnM6molkynpWKh1sKPdlYFQcW7gvHq1/+Tc3zN/VA5RH6bLnFAESG7iIUM3rSQdx7dICP3g==
X-Received: by 2002:a05:6512:1105:b0:50b:a69d:b8bb with SMTP id
 l5-20020a056512110500b0050ba69db8bbmr5512988lfg.49.1701090099048; 
 Mon, 27 Nov 2023 05:01:39 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:38 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 39/43] Makefile: add dtbs to clean
Date: Mon, 27 Nov 2023 18:57:22 +0600
Message-Id: <20231127125726.3735-40-maxim.uvarov@linaro.org>
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

CI test checks that generated dtb has to be cleaned up.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 769111bf09..2fc04450c6 100644
--- a/Makefile
+++ b/Makefile
@@ -2172,7 +2172,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       net/lwip/apps/ping/ping.c
+	       net/lwip/apps/ping/ping.c \
+	       ./*/*.dtb *.dtb
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.30.2

