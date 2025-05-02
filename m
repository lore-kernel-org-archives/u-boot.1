Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98044C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 10:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F694820E2;
	Fri,  2 May 2025 12:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GF50Kgh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF0D820E2; Fri,  2 May 2025 12:59:24 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821EB820F6
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 12:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-476b4c9faa2so30226291cf.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746183561; x=1746788361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uwxURKf7ARI46v+XsfpOEfgda6BbWRbD0631AL8cEs=;
 b=GF50Kgh1YayVNI07GgZWRWMgX0PCFVD7JH6Yh+4sG7OOn0mrhp2dwypZ6unohQiZ8H
 olCqNifJMsv4Y/CuTfRTzQTH0CD1tIwyDow1NltZjNQhQzWXlKgE07frg0x7i27WhuLa
 Lp6F/6q9EjA93Ofd/ZCU6+v02WKyEFnKTVH/caO7IZk5nj7YyIShZWWXG2BMP3SCKpo5
 Z+AAkzg7u57gXWQPHS55gkZ4mSI9yJNX8wG2NP5hlXDJKFCEnEbyVNs7V+sBRgSyZSTp
 Drj2RW2Csi5sEqreb9W2yRf223F8ekGrKKG337omi4YFIj3/1lLusfuzxT8qnfdFh26p
 axFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183561; x=1746788361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uwxURKf7ARI46v+XsfpOEfgda6BbWRbD0631AL8cEs=;
 b=afovjNLaYPPGYvQPdob6f/uwQ+QqblhrT3SdsfkyycVGNDeLKx9HuEWRLZBMXsLwzG
 ZgZ//oj3VDL6kpDDwTujcgOBWK21ItuGMdmzWFcXChs/G22lmvwXBZdaiZHaN+9eSdb/
 SLAf6o+OFZZZwknZrSvVEOG0pGFJrVCTGlZ67QA7xuQOjsKyGeOQ/TTOQ5ZqhmZC0FuL
 ERPY1gnNzYTG3GHuGFR/Ma0etcNThFEKVkgpRK6iShaSTlsr3re4jBqz6GxusLZk0AnK
 +CoSiGmFp66ivrD4ovZaqVOhhfO4wnbx6Rln0s8eZHe1q7hs3wiozI8EhIKho4Dkko5M
 Nl7w==
X-Gm-Message-State: AOJu0Yzl23A1XI8Wh0IVrWUTxwN7D2MTL+kQ9Uyp7IT+pjRBeiX0f3pP
 zIMMPQSJTnSotmMOr4GXw+RMiyvlnEJRTJeW/8X6HZgHjFYyKb53UZQuOg==
X-Gm-Gg: ASbGnct1Uw9vubUrp+zS+J30YL4mX/tT54d44lpWhrxpSmKc3n+LRjB5VsGvRdUmmxd
 bmbWZ7KbfvyoVKC5WZqXJ6yreDa+T57Q7N40MLfbeS71o9pW50+ZzAjaI7JpraRkr/eWwl6GSrs
 PpNVn+enCgfi61O1SWOxQ2C6wmvEP2uhQBTec6wECOdwFUrB51MCX5O/3EdgqIhTsehWIO2miD7
 VALRVb9c54Ehijlf9xtOa0VFbdr/FN8o/hL1t/mSjyp3whr34S1j1R5PrOumEoGGH1z/iDI8hbN
 yMxlHIChr65f0ltmSMRFhfZ0IbDums1e7tadynpsZqvgfXUesAu8PBfVAca3k9ANDX21hfOETRE
 39KCho950lRW/Kek=
X-Google-Smtp-Source: AGHT+IHSQytymjYGFp2XhF919OaVVJNAJctYgaLpYVYWsmeWqWfqGzF9ny+r7wMRrA65IpKmmsqE9Q==
X-Received: by 2002:a05:622a:5190:b0:476:afd2:5b5d with SMTP id
 d75a77b69052e-48c311621f3mr43717601cf.4.1746183560753; 
 Fri, 02 May 2025 03:59:20 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b966dc21asm16754901cf.32.2025.05.02.03.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:59:20 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: festevam@gmail.com, aford@beaconembedded.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 3/3] arm64: imx: imx8mp-beacon: Enable BOOTAUX
Date: Fri,  2 May 2025 05:58:48 -0500
Message-ID: <20250502105859.978427-3-aford173@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502105859.978427-1-aford173@gmail.com>
References: <20250502105859.978427-1-aford173@gmail.com>
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

In order to run binaries targeting the Cortex-M7, BOOTAUX is
required.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 288626c1511..9f6fabc894f 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -33,6 +33,7 @@ CONFIG_ARMV8_SET_SMPEN=y
 CONFIG_ARMV8_EA_EL3_FIRST=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_PCI=y
+CONFIG_IMX_BOOTAUX=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-- 
2.48.1

