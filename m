Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25FAC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F35183043;
	Tue,  1 Jul 2025 15:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KTPKTInN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5CF82F83; Tue,  1 Jul 2025 15:45:46 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614AE82F8E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ae36e88a5daso651598066b.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751377541; x=1751982341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3aDj35BZf2tsDuHeAa/lT3mLUgMDOUdHFp+jaI/rKu4=;
 b=KTPKTInNGQceFv83us0WZkMMvExFpXEJ+RJZOKjVBZ065dMsNSA7j/Mu5xGfjUmcU6
 jefqeHcGCB7kCDfXeaWZOUykq19WMery573TZCZ7GsGLpLNE+MZnqDQ+zcxdTFOu/4iq
 GAPxiTQn3noMlyVAu6Emgi54YqjV7tfMQm9VN0OvXHRutG/t28KzuSV2NcYbRrWvu18E
 s+vmq+rM/dmtluD4q4dAmntiDRvo1LILao3RViDunnFurtcBJE2U+kwvE98r561vi11S
 r9LZcbpgjH5mLWP81QRLwuWJI4g4X3B0YGPpsDfsqa46XrNdzMfzKIyOt4LBOiPxffO9
 n/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377541; x=1751982341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3aDj35BZf2tsDuHeAa/lT3mLUgMDOUdHFp+jaI/rKu4=;
 b=u6Zpk7IM5e6WtedVm+wAokSPzYDO8bOCwUAQdEDiiBm8X6YMFIq6fOgyoFSE9O0e5V
 of8II5XRPHYsck3CBStdBzJzybi91o02A0TbF4p5b5hrvgtmIWSUqXFGpzYz4FVyynXi
 FYwIkwI0WsSr9iKFWVzPPeKm/EgJ3nVSULSKgKQk2oytUUCokVq9KONgeHrifTeQo6Mg
 kLnLoOjMo5nt5Uf6VfVfa2UjQ67+5GETC8SNVnRlkdOwx/fxg2wSw/wolDBnnJEg7QGL
 ihl+4BVzdJwFz4w2diPtH0n00J753mxoIJxlIbCloOR1EjNOpNmyn6eajK/Oof9nP14B
 45yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCMMdAymhHs6HSh3Ri4tHKCVdtY5rSp47FUYr/B1sw5qr7IWkoxkcupVQ0a4hAs1ygBBXDKTk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7dcRmJLeT1VxDx3AOtkmEvs4Kyth2seS8Sjj9BEY5FEqlsC1+
 SaQvZDLwF7z8/SS/Xa7OPr6R7AK2cZO7WzafyQevW5X+Odn2FMip1mQRN3zVoA==
X-Gm-Gg: ASbGncuh0rtDVfZ6pZr+mvyh66Tek61SvpU8MkJmjmFxJl+eFDMnnJszKswIgiC8FRK
 kE883oxhGaHB/iuSAcOJuuod17dv8m+OHSwavP50l4EH56NhlB9VjGIvuyBwAsSW8guxQVFk8Sn
 y1oGvkzdU4k42vL49jMWG/RunDc9WchPV64zDNfFcvsfRCo5KDeKg9PjRF+c5WsVpZDGGC0F9Vo
 f+dA10claMjnNctpeBjQw68HWRBt/y0JuDErXmfguaHZGkC22yAjbHzBvZyxEHkyUTvEIlbFisp
 zuVhsWkXm9k/a6hzC87cL655+5Im+0NIL80aG+orDqnLaikgdXVSviNTzzvupIs/BPxMyyI1d7F
 O+p4Y8QmFfhCTELw3
X-Google-Smtp-Source: AGHT+IE27HdSf7HYvfFXhtXQXR3PV6fwc1TTNby5+ofeMY9VLM/bzJ5xTnCFzhZQpK82qVV9sN07Kw==
X-Received: by 2002:a17:907:1c9c:b0:ae3:a799:8e81 with SMTP id
 a640c23a62f3a-ae3a79997ddmr413339966b.39.1751377540480; 
 Tue, 01 Jul 2025 06:45:40 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:6d3f:7f26:74f6:c076])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae39ec1146csm288232366b.185.2025.07.01.06.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:45:40 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 3/5] configs: toradex-smarc-imx8mp: enable RNG support for
 KASLR
Date: Tue,  1 Jul 2025 15:44:58 +0200
Message-ID: <20250701134504.1076115-4-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/toradex-smarc-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 3e7e4264b128..0489f4441152 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -154,6 +154,7 @@ CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_SPL_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
-- 
2.43.0

