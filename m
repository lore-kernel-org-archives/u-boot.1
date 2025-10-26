Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16024CCD193
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 06:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D90983045;
	Sun, 26 Oct 2025 07:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P8cmLTYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE1F82C7F; Sun, 26 Oct 2025 07:06:07 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB2F836B2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso838495566b.2
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761458765; x=1762063565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjHxDnFq6hWj06vQPtexXZ2zxvyOAy7rfygMeOh2J9Y=;
 b=P8cmLTYlRl8HdlDdEJ8K40K9yY42OkkVYypNEz5LveH32Cngq09oDaeBF8Oy+H98CX
 Wf4E6d+HQHMGeReswjFGrbpPeWBXliKUIgLsAQNzGolQOU9FZ767aAMtoHx3UYs4LnOL
 K9sQfmtd5wH/MH4PXfFjkLCsViDIuWkYvvgnrDdw3CT+9RemlULurkBE+udiNK1wjGN2
 2HW12JU97keVhFsNIYFDkp9Wj4dRo4zVTBibaM2JBhUvyjWf/UqRZAKGVBJt1Yu7BS6p
 ixfEUvdPNGvpHI2kmbTV4Hy/bjkTfbMaD8PwSidlKhXZhXBT1JivKF+lqRSfU+8+bp8Y
 Z0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761458765; x=1762063565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EjHxDnFq6hWj06vQPtexXZ2zxvyOAy7rfygMeOh2J9Y=;
 b=MQ4GUz87u12s3ha7iUYJh2by1S3J8MxPJfsjZGlFW2Av2e1TulpCoCTHrmr1i9JgZt
 jxGSv/3ZidGvqMqtDUE9UrAkQdljle6HAD78oa6jA6/f70QyRxtCAari4ge/kxlRgqdc
 pwOAosolKVdhPXvPq5h/CPIcOXHedEGdvHgXSyzoxAfrKNGuMWIrENBAbfhzDLZgRrAc
 1GHmlj6X/BvX4ihmxCyz2MjrgHvaUy0FemsU/Q89pCsEhhXU+lKcweoBv0BUN51pPkIx
 rtBKF2tglNsVCja8yIcoEG+d4jU9/+StLqw92I0tKAnMVbobck8f50bxhsSGCyobg5Fq
 xK+w==
X-Gm-Message-State: AOJu0Yz7t+5orVaMUI3FArKuLTsatnqshvrRododDFcmiEfmMG9aoEm9
 QlAU5aRIuoOLL7u5R0/TN/wA1Ose6oTyqShuUs4zgjFrSuFNMgwaWohZlcBRCQ==
X-Gm-Gg: ASbGncunqeBmq3u6pzAb2+k5n99RSXfEQUhNDOfMLvTCKL4J6va8DqtUzqByHnQ2utn
 KyBYYsPrfz6UFFytrBEc7nKBW0rSxySIYhcnmoQc4p0iASLQ5Pg0rwNEOdmCvRyTgQyZiOUcLQt
 OENzBMYZ5aFeEGLa5OrbOmVuXF0yNGERmsEIWntmltOoVMY06BTi8sZyb5wii5N+FQvJ1U9rKnP
 2kRmMIvCWNRwZJgbr78/RFg+pflJAOz8Tv0BnDMQdGfqR1DKv6Rm/9DMObzzRYB0JO3KhSP4vYr
 8Pc/fSoUI8ffQDRbLyXfqAcyCct4EjK/QLSy0NDD6COOrxZDKk6bFOTHvvhcG54K2P/ZhvauRMA
 6DzY6VHJgKGfr5CV1A7Tb6GfdUlK3Z5BiZIgn3ZGH00vxCS+M5TK4XNctAcVC9ncdwtup9JTw5J
 +WZJjgtzBpDDoBrIo5/7tjFGymdjmjou/K
X-Google-Smtp-Source: AGHT+IEahd1gKXwaxuSI6Ez7+8D1h3ePdjJtLLs2kMEhingxxl9Gc2tP5pgtxBmeiAugD3qcnIjxgg==
X-Received: by 2002:a17:907:c11:b0:b32:8943:7884 with SMTP id
 a640c23a62f3a-b647500ee9amr3536092666b.45.1761458764756; 
 Sat, 25 Oct 2025 23:06:04 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef6c13fsm3233783a12.7.2025.10.25.23.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 23:06:04 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@kernel.org>
Subject: Re: [PATCH 2/4] sunxi: switch Allwinner A80 boards to OF_UPSTREAM
Date: Sun, 26 Oct 2025 07:06:03 +0100
Message-ID: <6203838.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20251026012357.16773-3-andre.przywara@arm.com>
References: <20251026012357.16773-1-andre.przywara@arm.com>
 <20251026012357.16773-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 26. oktober 2025 ob 02:23:54 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> In contrast to some other Allwinner SoCs, there is no difference between
> the DTs for the Allwinner A80 SoCs (sun9i) between the U-Boot and the
> Linux kernel repository.
>=20
> Remove the old copies of the A80 related .dts and .dtsi files, and switch
> most of sun9i boards over to use OF_UPSTREAM.
>=20
> There is the Sunchip CX-A99 (family of) board(s) for which we don't have
> a DT in the kernel tree. Keep the .dts file in the legacy U-Boot DT
> directory, and let the board's defconfig opt out of OF_UPSTREAM.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Same comment as previous patch.

I'm not sure keeping Sunchip CX-A99 makes much sense. This means that
there were never enough interest in it to at least upstream DT file to
Linux.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


