Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE93C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BF6580F88;
	Wed, 26 Feb 2025 14:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X0DIoKgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F563805C3; Wed, 26 Feb 2025 14:49:21 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11CA80F3F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so6200341f8f.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740577731; x=1741182531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrGNL2bXhySUpkHNyN6qc9KKJcx4wzkk974EFffw5HA=;
 b=X0DIoKgV1IVI9D55d/hiPRThhhAqgHftjC1AgUZd4ufvI2R/y7ohq5mYama4y5NB4r
 T12Wjl7Blwpvf+3yQJzJL0suMIuSOYA2buP2zo8tfsJBypmA2tDEejknJouBooapRH7f
 Zj+i/t7M80ChIYCSOCjt4797uLmBuzSTUyL7Hbi2eGz3pjli8FLc5IviAYTTyJlrEVEx
 6qgtD/9RJA+S7K1iTg+GzQHzs6okApH2cxVx2M4ZkqOEEjMoK7dAB5BVIQ2Imre9S3dR
 7lutV7lhn8QmfCEpnmk3vye6OUKtylB5FMctmXvw269CgfzF/01dmf2iNjT9RQVsdS17
 fQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740577731; x=1741182531;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrGNL2bXhySUpkHNyN6qc9KKJcx4wzkk974EFffw5HA=;
 b=ZOk4/8BbN3KkVBpttqIOeaRIWyQObpuSBYzLIkJf9paEGneU7/Dn1iL7U8sIRS3GaL
 eQ/dB18+1z1MxlY9ZT7pgrNKCMkB2XuKx/WuP0WYms8cAElbSHmMhUQ7xLVmIZoA29yp
 qNd7oUzgSszP0HJug2ZPxd05L4y6xdRUteBMm5gNxvl4Zda0XQ4b0Ry92DVMabyl2tHY
 8ceMo3JwJO2gYpSVLkV+GGIb3p9XCCwJTY77XTbBR4KzajcUe2L/EG50TpAz8dQMi7sF
 YtsCHF9BVevnNh5TQ/zkPIfVXgYpViaNOMO9m7+gfGUFLOZsNgpeF310LWu7/hIzvs3u
 nKPQ==
X-Gm-Message-State: AOJu0YxpLs2Nh6kFqu6//5SFiyXa6seeIgIBWNfsO0rcQJC3JlzqtH4l
 YVu3di45PdZI1AIuBsUQ+d5epKAxCuc4H1XNfOqa1uD/J/wSU8yfcTCTNv0bXoc=
X-Gm-Gg: ASbGncts8v6bfjQBpGiAMQpA5GeLhH8OW/xkO10fntpwdb+5m9H3okwcYvwNoqcpped
 yOSYECEcyCQjdCeV4ILevVLXNJWFNxDbqZ1+xPODhUWXN/j0+Mg/Ngy3Cnp2mkAYWQEYee7WkiJ
 Y3k+igIl/BZnAJur5NUZ3eDwvq73FbxMeunLzB4VI0T8miZ0zA6p/BR2lVyz91wTs5+JXMVP7FU
 qNjcnQbNsmINIFhGXZNJx4QXvVvZbtATyKCDyho7aiLs4XO41JFcIndD9+IJ3iASfg9vTxntSxe
 tQaL4ciLq7vrm6vm4K6w2WaTj04zf4pl+0VCEz2/taRxE6R47qfvgUTlYGw9ow==
X-Google-Smtp-Source: AGHT+IH0+NiKTlBw5hjg5AzX+tusLPfDtvVZae4bgXuCDKjwsqbOwsUZMN++iW93207T/n7p9+1adg==
X-Received: by 2002:a05:6000:1866:b0:38a:8ec6:f46f with SMTP id
 ffacd0b85a97d-390d4fa3de0mr2859462f8f.53.1740577730642; 
 Wed, 26 Feb 2025 05:48:50 -0800 (PST)
Received: from toyger.caleb.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba539450sm22106625e9.21.2025.02.26.05.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:48:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>
In-Reply-To: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
References: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
Subject: Re: [PATCH v4 0/3] clk: add a stub clock driver
Message-Id: <174057772939.26167.11292853145020770893.b4-ty@linaro.org>
Date: Wed, 26 Feb 2025 13:48:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Mon, 10 Feb 2025 16:27:24 +0000, Caleb Connolly wrote:
> As U-Boot works to align itself with upstream devicetrees, there are
> some common issues we start to run into, that of hardware blocks which
> might be important for an OS like Linux, but which aren't useful in
> U-Boot.
> 
> For example, the Resource Power Manager found on Qualcomm platforms
> includes clock controllers and power domains which are only useful for
> managing power consumption and enabling low power states.
> 
> [...]

Applied, thanks!

[1/3] clk: add stub clock driver
      commit: d31a3bd08ed46c51cdc5f5f126f2a721c5425bfb
[2/3] qcom_defconfig: enable stub clock
      commit: b72d6a9d619b000875699fde633b26c0ec1bca67
[3/3] clk: stub: add sm8150 compatible id
      commit: 506f6a384c335e86c4812c5e734dea4eabc21130

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

