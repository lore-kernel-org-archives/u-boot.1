Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F28C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C0282FC5;
	Mon,  7 Apr 2025 19:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OLWqv48k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E81682F85; Mon,  7 Apr 2025 19:00:02 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D84D82F14
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac41514a734so801138166b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045200; x=1744650000; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AANO055lAmYadSL3sDMpYJqr2iGp/bkvmdCGZpwDbvc=;
 b=OLWqv48kyhgu1QZWCbWaEgeYJflqPU3GxezmaihSkZYcLZ9InlFtSfuhVV11dsdhZj
 4IkYb9yuqbW8JH1/+vksbOupC2Mw43mlGHvdAes8uKJ9MnBNcRge+EmbU2i5wi63m+8s
 tUyPcg1rN1WSteomE1uh4V/5Is2EsHUpY/BRyXLMU5TIzmvUGzZtY+s6mJjktHNjR56U
 Y+PYcwOrBYOM5xrfi8VV0AddTBX8PU7XQqjKNgzEDSsbwdKAOtF10hX8nxcji7NgAVRY
 DNTy1H5MbeXZrh/8c7WYUsgNltwNmEsQ7AhmFrACS2LYMRq+bFMdjwoP9dD4is5hYfMS
 D6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045200; x=1744650000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AANO055lAmYadSL3sDMpYJqr2iGp/bkvmdCGZpwDbvc=;
 b=L+5UAlqy1Gm0IdiYHyubBDtBpCh6QP7V2bz0m7QtkBSco/Vll1adKxD+YG3MxzsS1A
 pUlL3bEQOj3sf8aE+P87y9ZNKr60/UilE9B7P8eE8NpSwE/6SLdWtpjgfbU5kWG+1G3p
 iP7IoRO1363ey8m1VENwmV1FtgJFBm6fWkea7WjmVHr9qZ7uZyLZq7J5IA3ZKAklEGsN
 2JfLJXVJSb/LakmZip/uYZ3bqEDKdV85PddcuNnrkaUWI2m3BYXKbYTjQnf28ck2Wanf
 GNGxeQ/y8sxB1dwqJrmQgWanzjU4HmAnAt44rYDH3wKrjL7sqSd7ePAvMGxuZhxVwGJc
 yXqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUxmGDnBGVye9X9LrbcckYIVDGQrR/CwynuP1sWLGzXKb6g/YqcFVXaq+xpTWrcQppuiS4Wy0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxd+N3ae4IMA8AP/4zDKjWyuLsmL2oqISY8p4LjhLBqDMTQIEqE
 RK2cma3dH6D0iud/PY8N/jEbY1UVX/dOvO6ze7PntfJHULB6iwjMiX1GCg7nTBU=
X-Gm-Gg: ASbGncsEfMnssY3cpI3dprikum+vfuPy3KJ/I0294a8e54OhiXrYM5pQe3GQ8FN881m
 ZDCwAieI0ctBDia9MNGLFZaDpcDGQX343wlnuLyMplwBQzv6S3mJWNg0Go6PFBxJO1fEgqwFw8X
 vJQ/u5A8DlbBqSNNTQfTT3rDMZDJHAfvyZgBBMnXS2pLCbWdXk7EViFSVSyeC9fnfgWB6SbUmew
 qpkGHPba9iGSycoxVyim+aVL02q/s/NfRPmkAp3s9oXkW7YjNSvvcgJh9/2oSY+OvJyhX0K7utu
 IMBkgYu6SXpegzUbXqhnfELbKBpD5TJQ2uLnC0OSigbJRmde6IZJDV7/9g==
X-Google-Smtp-Source: AGHT+IHxA7TTl01AB8dG9FFRrFNgJeJg5ZZ1Ir+KqZmukeJOPnonsqtDMSt8tdU7kSoKmSRFmLe5Rw==
X-Received: by 2002:a17:907:7e9d:b0:ac7:cdaa:8946 with SMTP id
 a640c23a62f3a-ac7e7170365mr776129266b.11.1744045199915; 
 Mon, 07 Apr 2025 09:59:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.09.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 09:59:59 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:26 +0200
Subject: [PATCH 05/13] board: dragonboard410c: Drop reflash functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-5-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

This is broken ever since we switched to using U-Boot as first stage
bootloader. Since no one seems to test this actively, let's just drop this
entirely. There are other tools available for re-flashing the DB410c.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.env | 26 ----------------------
 1 file changed, 26 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
index 9d9a575a0c3f7a4739e4fb77a980d742e10510f5..57a30031f743f43d4a6389286b426b404d2f371b 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.env
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
@@ -1,30 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-
-/* Does what recovery does */
-#define REFLASH(file, partnum) \
-part start mmc 0 partnum start && \
-part size mmc 0 partnum size && \
-tftp $loadaddr file &&  \
-mmc write $loadaddr $start $size &&
-
-reflash=
-mmc dev 0 &&
-usb start &&
-dhcp &&
-tftp $loadaddr dragonboard/rescue/gpt_both0.bin &&
-mmc write $loadaddr 0 43 &&
-mmc rescan &&
-REFLASH(dragonboard/rescue/NON-HLOS.bin, 1)
-REFLASH(dragonboard/rescue/sbl1.mbn, 2)
-REFLASH(dragonboard/rescue/rpm.mbn, 3)
-REFLASH(dragonboard/rescue/tz.mbn, 4)
-REFLASH(dragonboard/rescue/hyp.mbn, 5)
-REFLASH(dragonboard/rescue/sec.dat, 6)
-REFLASH(dragonboard/rescue/emmc_appsboot.mbn, 7)
-REFLASH(dragonboard/u-boot.img, 8)
-usb stop &&
-echo Reflash completed
-
 loadaddr=0x81000000
 initrd_high=0xffffffffffffffff
 linux_image=Image

-- 
2.47.2

