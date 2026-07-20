Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F01C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CFB838D7;
	Mon, 20 Jul 2026 15:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kQY+28PE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864BD846A4; Mon, 20 Jul 2026 15:10:19 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F8480517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso699307f8f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553016; x=1785157816; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Wtm5dzBS99EJQKTbjuSR7eeokTNr+u35q1yLYNC7CY=;
 b=kQY+28PE9ZXClnL+oqxu+S2sQ0dhI8qoVVAs808Lyp9hy8s1G1AIWdniohbM64LdAW
 xbG21oUJ39PTwNfpJG0MznUmVTsO3pOe9p3V/4WA63P63siz1wp6TvAoR4tdhoTm8ekA
 7OpRf6xssCAqNbzhSVl8bb/ouT3K34Q2jtX129qHbV+lPFqWgv3JBw7iQb7/zZjSuEIE
 ffb9zcLwKXW+Ccb+Uy5AXedMKsGdfytruc3bAWKbfImWf3vrgexrL+4U7lPhQMPcoJ1D
 BUuBL6EL+xW84mOvHGx8u+d4WYOK/nbHeOMEtlYNRHD0srdId16Vtc+Y+Vjte8tpb+WD
 grEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553016; x=1785157816;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Wtm5dzBS99EJQKTbjuSR7eeokTNr+u35q1yLYNC7CY=;
 b=ifvEEtxzpTBryytQEvDKqD9wZMVRGYcEH0jKjqkH053+R/DLUPdvcHN/BvCbNNuRPk
 zpe3n3z6l1l6eKJh+6Ia/m/GhDL9gVaAkZUK8Ori1UPoAKQ/aQLl5AZytIuPIAfuHZpJ
 +NpBgkKssbU6bP0L/NTmbcCnzBt/LGuH+7bGE8GQeav/8J3w0WF6fcNevCn9ImMwFYrH
 vvBw4NESATFv/j7tidD75KPX4SgRgK2scA/fZmk8s62x/ZgjMJCD+u1diZiCxq5Q7WOu
 hX4yxHaLY2CcDRzYqWltjwQRcUY/yLhb5XF9CeXahmaLq9pvcWWSwOwFy6oekcwG5+6d
 eOEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXzv7f5nJR0SIRnheBGfEN6k9/6RRg+/JP2hypw9q5sTNRfwqYIg45waL8tkRe10p07NCXzXg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt9pCNYXExNk25tSJTIeQzhNtasosrVx65orHEoW7o7jmAbcYH
 dy/zvYqgxl+BksO91+MvIDt0OTCe2HBt+Dv3wcij2UdfOrJLGHhNTvXc7ZsdEAPexSw=
X-Gm-Gg: AfdE7ckPEwtuZlJURhqYqZypMJ5l7MbZG5OwxOFBFM9XFDjDCfuyvKra/ClYR7BSEta
 SyG2tm0oMljjFnhJVuIAkicVKG2PhRrW7PYXndx+QN4loaCEaGcQeyoOkw8MUdpsmcpCvcHwlNB
 8/Uh1WxE4HY1KKr3vfvarKVEOc26UByDrz/8qTGHwTOCT4gOZ4YDFGw5YzT2Yk0QHLA2DYAB+UU
 yDB6Zp8jXK2MTfoRQCXgsnXGHDXKJF8k1FevLhWOHLSNKIiOOYNRKaAYt6w9gKwi0F7qwEo6uhT
 d64A76n2lzlUyP3x13jwzzHJ5EiFb4Qx+tRdfbsC8dIsVMfoel7lmr0RmBzOpjj2nGFZaPeH6ZU
 DUe+a+qLnCpjSyH1UpDNRs/T1UP8tX8dTi6E5nZAMTToVno/63UBLgVuLleKDSkyRUYk3cg/T5y
 l66nv8/7iaWvvkZ/e83ILGL3eMdWnVYeCywsv2OvRjSLSR
X-Received: by 2002:a05:600c:45d3:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-495503fd2a0mr104254675e9.9.1784553016473; 
 Mon, 20 Jul 2026 06:10:16 -0700 (PDT)
Received: from lion.localdomain (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955fc42db7sm61531435e9.3.2026.07.20.06.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:10:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: hs@nabladev.com, trini@konsulko.com, neil.armstrong@linaro.org, 
 u-boot@lists.denx.de, Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
References: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] i2c: geni: reset controller on NACK to recover from
 invalid bus state
Message-Id: <178455301529.1001378.9800568671464819973.b4-ty@b4>
Date: Mon, 20 Jul 2026 15:10:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Tue, 02 Jun 2026 12:13:22 +0530, Aswin Murugan wrote:
> During i2c probe, repeated accesses to non-existent slave addresses
> generate consecutive NACK responses. On GENI I2C controllers, these
> back-to-back error conditions leaves the controller in an invalid
> or busy state, especially at lower bus frequencies (100 kHz and
> 400 kHz). As a result, subsequent transfers fails and valid slave
> addresses are not detected.
> 
> [...]

Applied, thanks!

[1/1] i2c: geni: reset controller on NACK to recover from invalid bus state
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/97fe35f568e0

Best regards,
-- 
// Casey (she/they)


