Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40293C7115A
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 02:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BE982D60;
	Fri, 20 Jun 2025 04:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oHb8YVIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8925382D21; Fri, 20 Jun 2025 04:26:02 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30D8E82CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4067b7d7e52so308495b6e.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750386358; x=1750991158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KX3KNsOA7Vgjfo8WMcwne7lpUV+PppnohmdzBMzaJOY=;
 b=oHb8YVIpfuxG61Wpqx+1ek7xEGM8q/Mv8JXZMj4O29KSofv9amyUFxxUkVakjVjPtG
 GqO9Q3qckZhHB2pTTr50V4513JtKb4/UlLc7sAjZaikEnYygKjt0E6CY6ivp7CBu2prY
 L15J58bfKRllNAmO8c+bngJR5bhwx8x+ZvJVIUd85JUhZdDwWmEBzfHiI8BitV87jBg3
 uBCUt9rUPRnziM9jDqAlhNMg+gQysTVEvMQXWKLp/AvvKCVFWAdgFfGfkYtlSl50EzLV
 RnpHk2OHZQ4Fiwr8Wp5Y5lhmSeo4jJYHbiPSN4utRD/QeUV7GVrXtnSVeX11UNqghO0m
 +YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750386358; x=1750991158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KX3KNsOA7Vgjfo8WMcwne7lpUV+PppnohmdzBMzaJOY=;
 b=uE+U7ou9bnzLfQ0mhOSUBi8uIOyABrz7ncJH9DcgX1Fge0OW+OLnGI2SB89nmEtbSb
 ESduT0wrPOdwa+HXh0404duFZzvFnhM10YkRSDhoCy2Wl+9v23/qOjGjbGMagD21ioDF
 x7HGukTyfPKIK4P4+nezGYgXRj1yNVkjuYEED3QwssgTA7XlpaPf5e8GjRNggnpXpT1n
 kZL+0tEc4psO+rkFTIkXtrzMwkkrCInfTNZF6GVOEqiwIrfs90mkeSgR2/7WlZpnZoEQ
 m+OfByaZxyaZ7TZLFUXRw2oAI4Cyhzk2yzSLLGNIRp5zkjXT4+8/h+IBSdnZy22PJwXg
 M6oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUil/fdRifCmORUIWt2LXAlfrv4XInjLBTLN6+lch2LNvVuuwOg4o8Hk35QFRIx1r6JU93Vaoo=@lists.denx.de
X-Gm-Message-State: AOJu0YzYidZVWZ2RfX2bH/m3Th40DgrnZao8+thWkv9idsJkLlX9r9WN
 bcpYjPVXvJjYH+uQmTYUxBsXP6VohVtlOaqFcZzJK82bvnUwVMbf+4g0gZpGiVBz4v4=
X-Gm-Gg: ASbGncsjztfDF5DmbsUAx+OiQCU+GOaDopx6eMkwKUbxRU2Erv3yPxImSMT55ol9ijc
 ogi7MQCNFLkrsxZbkJKNVp9zMEPiajPtaPbOgjioJyQUnmmXxqKx7Mk7CoEaVgQ9KKwyBgdK+bE
 mgVIXWsUr8mjzhUFSymc+NyeI0ica1IGSTj0GO/oT+ujwJUZk1IIKmY3mWyB3N+ON4owJtUBQoi
 wpPp/SQM1v75yW5gnEqwP1AZR5UpdR/cAtrD4KA+d6yYPKDCcrf1vE9TLJBZWx9ZG/R6whRHXDT
 ZFhtDx5+TeG8J9ShOfckuZ4kj/Db7W7xy7dkGfGFcvKvs/HboqFvmL+FWQ9420IZFS2O08pRhmz
 3bK0/QTY=
X-Google-Smtp-Source: AGHT+IEdvwn8Asfkzr0yPYa11qomAqDs3vyT1MYCopJLmRghdT0gv77iyx8x8liZvv7k3RDoYElM8w==
X-Received: by 2002:a05:6808:1896:b0:401:16e:918e with SMTP id
 5614622812f47-40ac7036de9mr993551b6e.8.1750386357847; 
 Thu, 19 Jun 2025 19:25:57 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6ceff18sm133448b6e.26.2025.06.19.19.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 19:25:57 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 0/2] board: samsung: e850-96: Fix MMC devices in EFI
Date: Thu, 19 Jun 2025 21:25:54 -0500
Message-Id: <20250620022556.10363-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Avoid using MMC in board_init() to make sure disk objects are created in
EFI subsystem later.

If it's still possible, please take this series for 2025.07, as it makes
EFI functional on E850-96 board.

Sam Protsenko (2):
  configs: e850-96: Enable BOARD_LATE_INIT
  board: samsung: e850-96: Load LDFW in board_late_init()

 board/samsung/e850-96/e850-96.c | 9 +++++++++
 configs/e850-96_defconfig       | 1 +
 2 files changed, 10 insertions(+)

-- 
2.39.5

