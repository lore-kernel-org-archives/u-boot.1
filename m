Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AF9CD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F4E836AC;
	Tue, 12 May 2026 19:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTD+k5ox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F9883C2B; Tue, 12 May 2026 19:39:52 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844EF8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso4645710f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778607590; x=1779212390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP1uEntjC9OU9hYPAs+i036qumK/QyRHgs5/9FYhZwI=;
 b=BTD+k5oxv5ss03nrenP5o3p8+J6cXvHgbFokA3FzX5IO2lNRKx8gdUEEn/W0QMpogG
 HYbT685fHD8kLXlwEWBHFBcLzWMfOYiGuxOMDzSm6oajbI3kCRdQBeNb8bfvAy4cPjGS
 eYyyN8WrNBJrD67EArDQaHqtXOBk/+eIu4bYSHg+wcCWxvwInSUPNpVW40L9P/R8LOtr
 3SnNH63vXGO7NNghadfnW3BwTx6TzhHhA9orz3v6uPksD+g/H2tpRaN+nsWgZg0WiTS6
 hylbxxD5+y6RbPxuYMNInpIPcJ9P4lolgmDPjvu6YdMnpooSv0m/YWN5EbD53JWC7RMp
 LEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607590; x=1779212390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sP1uEntjC9OU9hYPAs+i036qumK/QyRHgs5/9FYhZwI=;
 b=TVvMq28iX4W072ZTrf52JZRFug8tsdARHMoiUejQOjTDODyA4Ep5FzPviSkxRWxtYn
 ui/5ZwmKmD87U88gfo5gCwA+bQMUYdU1tIPB+Q2xgB54GaX3L9dGa5HH7ZGZt0ziheGg
 qXw9G37WM76+06tipebI+FJr8lqWUO7IMEFwKlwz7fn/L6c8ZWakBo5bEspnrQ9KXMK6
 bE9Nr1i6s8+P1T9oSSQVH/zGawFJBqlt+Nl5/xKwycDzjIONw39Osyce9IudVL92FFfV
 gHqEpEc1Ih+XkQgCqSgnhzzloV0g3r4cAhEBv7AG3r/x8OIiF0NTCnN/ahEF2kG0Xd2q
 oVdQ==
X-Gm-Message-State: AOJu0Yw2Y04c6TpGYz+d67wx055GfvrkZOCWabYSbsu/y/vUpnTcFtcn
 76draS/n62t7qTQ4ee4KGnjxoKKuL1mBG4Rq/gjDd9QtvndJcAsyMCxTgMsaIQ==
X-Gm-Gg: Acq92OFVIF6idm14p0jHN9ySB8pyImc1GSUCgWeEMlIQYKPPHheb0QzD0nmuyr030bh
 TpscseXJoX5JhgM7hdFDV4zNID4gIpz03lYtyFaFhCT+z/B1hYAGme1D6v55nO4mKn/in2zGW7Z
 ssPvJkkMtez2s9bUrGup22Gu7p+0wHZ3y+y5rbKPEQ9eOaezG7c5UIOlPxS4w5+An+ycOHJRk6N
 ZgKA52MHk+pCMe2CJMGYPI0ycCYZRCnZRTUqLXukCJlv2huqmKJKrF4bJWmPszQI6f4G5RJTOTK
 X3MAcGIN6tjJin7EL1flThCHBYNjP2Sk596HlOBQ6/H3k/CfwlzQF90IQ52+aykl+tnHUy6mWry
 wHypCvaGArrvkUDHQp+oLnABVBf9GZfW0e8lvLmCR78YvMQBN1il+z/5/3dcFBGdfpkdEYcemiO
 uqY4yE0i1sVYVY60SpkKQmKwJp/RpAZ9lJhid1k61moI+92foASbjO2d8kk1Wv8H1JAN4VrO6x2
 emRkVRp
X-Received: by 2002:a05:6000:1865:b0:44f:da26:cbb4 with SMTP id
 ffacd0b85a97d-45b1379118emr6402018f8f.21.1778607589127; 
 Tue, 12 May 2026 10:39:49 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454922715b9sm36274813f8f.36.2026.05.12.10.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:39:48 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@kernel.org>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/5] sunxi: spl: spi: Add support for Allwinner A523
Date: Tue, 12 May 2026 19:39:47 +0200
Message-ID: <wMZoJNOrSM6zy-28htTEcQ@gmail.com>
In-Reply-To: <20260511213713.15943-4-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
 <20260511213713.15943-4-andre.przywara@arm.com>
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

Dne ponedeljek, 11. maj 2026 ob 23:37:11 Srednjeevropski poletni =C4=8Das j=
e Andre Przywara napisal(a):
> The SPI IP in the Allwinner A523 is mostly compatible to the later
> generation used in other Allwinner SoCs, at least as far as the SPL
> driver is concerned.
>=20
> Just add the pinmux configuration for SPI0 on PortC, as used by the
> BROM. This enables SPI (NOR) boot on A523/A527/T527 boards.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


