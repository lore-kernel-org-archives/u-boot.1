Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6B8FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 16:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0F4848C1;
	Wed, 29 Apr 2026 18:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ogI+tG3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9061A848C3; Wed, 29 Apr 2026 18:20:59 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFFA848B0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 18:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so652f8f.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777479657; x=1778084457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vImslMwyXcASfDEei180MXXimfMtSB52kRlkM75F8jo=;
 b=ogI+tG3/v7s9DZRwSqadCyN3TYa76rFPGOJeK8G/8gfU1EXIEppL3PbMB3LOqUkvhT
 GUIYH8BDgntOSIIHPvBsE1NlxwmAz53jIlTUpyO7+VztyHHrYXI5251LYWTIbPo0L/Z0
 7zTm4H4lEoyJYE3mv6d9ETERoEWnMtE3veOjOw6mQflnwtb02D8Qq1aTApdlCaupzFGW
 nbxO0ZwMijVrPDxqp3x91K5eNqoF0BLLR4CuGFRSlB41UZTgkwkKU4m0ASsyQ9ilMnpQ
 KuE/Q+VZS4wnf59zeMk7YflYLqmrAutnQ2GEyofft+QKB/NftIk7Ql/4Jy0/T1T0sKjT
 jtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777479657; x=1778084457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vImslMwyXcASfDEei180MXXimfMtSB52kRlkM75F8jo=;
 b=HwSwrzTIh4BDmlicQyS/9Yzi/yJr46di1l5+jWemPq8hWHkWNMpF7MLVWuR16MGJv8
 TVQqcxT6UW0Bnie6Lc/miwNxxvrpL4gUecDYxmKAFe1a2Zn1+z3DKQxNoU5f00/0OHGN
 EztRP5vbCLkeZvgbv74/eUD4/RBcNhxDjGzYy4MNC4dHc38SbywUuxDcWQPaucQuLiHy
 SChwdRFxV33cd96WZQ65MFi7GJsToww+8BxApuJKg0ooTbE2dpEBfADDvhLtfirCrbWz
 m+N0TY5XLTAcW+IYbnXwmfZNDEG3BrN7AaU2CmfQyh8i3JQbHS+oWk1P6ePeBCKfpUJt
 1/1Q==
X-Gm-Message-State: AOJu0Ywfb6i/ZzagC9kp+3NIezH7t0Q4ExcW5nxvftmrTMovZH8eM5s6
 AREenHLJgexlWWcF15Zxw3Uj/7Aw4q3kZKM9h+x13fCNPpgobOfjBNZuzCqmzJRh
X-Gm-Gg: AeBDieuCxVc7y0huduiwp1KKJ4eH9N4m/kFC+mKz/J5QPloJjRjC0H/W7f+g++4sx+M
 2owQXEWA1dZwkI6lbRIGaXhWQiLILksVTE+1NQdc2n0zBHmtr+1bY9ixxO25Ed10sfBb2UmUWQz
 aUy4oTyc6r9hWe4bLleK7BX4G0U57KFtKr0SdAJJdEf4IR3ZV9moJ4x8TVYqwB0EPNlw1Y/zjY+
 YKLG+aJrcChk5ncxujPNbgYXm9+9+nnDRvxpdrik3+qEXVPiK8JJ3/zIIPaYxSR/rlEAV78SBic
 +k/XCYJ88SAtRuIhVQDp1NpHuI30RVz+7LIPXXzH4HyRe0yg1Zgop278bnkc8a19VdRiAYxVxf7
 d+KULA2UFnhY1mFfB3+PFslSJxLJHj7nrSAbMNobB9W3oQvipxDZlRUEAzsJyvDxWQ7TM7gPsa8
 huT7b6/3QLbT1IbxaZqlYFhD+PNEeASWxg34tUteWAGAbgv2X/to2lVZ0vv1Tpv29lbw==
X-Received: by 2002:a05:6000:178b:b0:43d:1bf6:30f2 with SMTP id
 ffacd0b85a97d-4479009bb44mr8106156f8f.20.1777479656792; 
 Wed, 29 Apr 2026 09:20:56 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217c56sm6742489f8f.20.2026.04.29.09.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 09:20:56 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Yixun Lan <dlan@gentoo.org>
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH] spi: sunxi: wait for TX/RX fifo reset done
Date: Wed, 29 Apr 2026 18:20:54 +0200
Message-ID: <aWjBFp42SZOUo6dm7CAJWA@gmail.com>
In-Reply-To: <20260421-02-spi-fifo-reset-v1-1-e2cdd4bd474d@gentoo.org>
References: <20260421-02-spi-fifo-reset-v1-1-e2cdd4bd474d@gentoo.org>
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

Dne torek, 21. april 2026 ob 06:47:50 Srednjeevropski poletni =C4=8Das je Y=
ixun Lan napisal(a):
> Once reset SPI TX or RX fifo, the underlying hardware need to take
> some time to actually settle down, the two bits will automatically
> clear to 0, so use a poll mechanism to check status bits to make sure
> it's done correctly.
>=20
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> On Cubie A7A board which using A733 SoC, we encoutered a SPI nor flash
> timeout issue, it turns out that the SPI fifo reset take a few time to
> settle down, Add a loop to poll the status.
>=20
> This was the error message shows on A7A board once this issue happened.
>=20
> =3D> sf probe
> ERROR: sun4i_spi: Timeout transferring data
> Failed to initialize SPI flash at 0:0 (error -2)

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


