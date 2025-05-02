Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436BBC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 10:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599B181FDE;
	Fri,  2 May 2025 12:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nktY4WeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACEB28209C; Fri,  2 May 2025 12:59:19 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955E380F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 12:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-476977848c4so26577451cf.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746183556; x=1746788356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mwkb1oB4Y/y+HTF8yhpRuoRB8UHT2i5gQzfC1JNVKB0=;
 b=nktY4WeDPuFJATRvtfBsSHv9o3aIZU4L5AprEYr++eEBa50slpgb4u8ToszSnFgur8
 5BOj/fELmWbyIpjaQkKUb1uPf+qFMsthWwXAEXE/F/KQJ0XtxmVE8ztC1gfAhm3qxX1C
 tBU5JOJ4Dwz1qK/hHEbqXyhD2+ajjTiy7LhB4Fp+EGY4a91IS5orqoGry9ifD3Q+slrG
 Bu9T+4pe1j8E05X/pECVNrzcOKJk8HeZG7zlkqpznShQzHAe0iGz9tVRfP2Pc2yUkKDC
 sny6Ek/KbQ/0wHBLVOTa1GArVtXveW+E7vOM4DqTcoi/8QkbOFtYzogACnEAhZYTaJUa
 LP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183556; x=1746788356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mwkb1oB4Y/y+HTF8yhpRuoRB8UHT2i5gQzfC1JNVKB0=;
 b=axCXvbGPKTtKTY41HbACBKkdcvnW9oKPvTay/OXutB062DPpbInIHLgZUr5X12+c+C
 qvYgUcEtWz90HbvHHcNyXMnES7GbuVBBAxm7eclClNDuviZsUVpo7MSoM0Q91dfutnMF
 gYU4VBp97plNGCCIEORYFne1XlDO3ULcEZ5NIduE7Ip9fgEB9NDddPht5NnHIDB9ND54
 hiWTTxcOTJ1NCui7HjyosW1SzkYJ0vblEhHTPDVvsZBgktfs8vfBVQqCpQlBlwmDwU8A
 FJmls+JJhKaom8Ep292zfcGMiHUYysEcKD4Fpx9qAtXM/Q7wyikHlT9pxUX45WhCpk9q
 akhw==
X-Gm-Message-State: AOJu0YwQjDGZjzuaLWBAhVmIHyD9r/3nAPvKpFpZO1f8QSpylXU+7EmV
 JkQO1T6W/CSR+i+HJj5deUC6E43Kv5ZYQed+JkzAEsGXVVADRZXA9YFnzw==
X-Gm-Gg: ASbGncvfszO5LrbkwP7RaPzVp1tPWdjJH+KC2C+gk9lxfTYSwyquM33oVPaajY4JO9h
 wF9vQaLeWpBzohopL7WEhY/MTWuu/aHrqkq3QnZLldk19RfJ+arXe+Z2EpT3I9KXQixFLQSI8va
 kGwfRjMaKfr0CEqQpxNIIfWeIOXrT+seZniHlIBqwuV2dz4tySIn2F5Pp3VshywZkSVYUpLUHny
 TXChTySbGwIn8Gc84ZuTZaF+XvItywvcTjBZly81FCoEN2+h/CXPWUXhloQDkXEgAR9jf8RgCXA
 xu0bKhKHgK41Kf1mdsaioIXJv0hENzr0kfAbwxLngvfCVjQY44/xPiZs4iAOl5mEVn2iOoozNQk
 LckwIIO89n+e0q98=
X-Google-Smtp-Source: AGHT+IFA90wDj8ZfPP/qHmJvpZyjXkWzhGHNJ1p0IU8cD4Mf5vIz9KpYjpl9qQK9v2Jw45NKV9kxtQ==
X-Received: by 2002:a05:622a:114b:b0:48a:f7d7:f9f8 with SMTP id
 d75a77b69052e-48c31353b69mr41916151cf.14.1746183556112; 
 Fri, 02 May 2025 03:59:16 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b966dc21asm16754901cf.32.2025.05.02.03.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:59:15 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: festevam@gmail.com, aford@beaconembedded.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] arm64: imx: imx8mn-beacon: Enable BOOTAUX
Date: Fri,  2 May 2025 05:58:47 -0500
Message-ID: <20250502105859.978427-2-aford173@gmail.com>
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

In order to run binaries targeting the Cortex-M7,
BOOTAUX is required.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index c605567d9a6..115288aa27f 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -29,6 +29,7 @@ CONFIG_SPL=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_MEMTEST_START=0x40000000
 CONFIG_SYS_MEMTEST_END=0x44000000
+CONFIG_IMX_BOOTAUX=y
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-- 
2.48.1

