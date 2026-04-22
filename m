Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE55F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A48840D8;
	Wed, 22 Apr 2026 03:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MSv/NV4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3B58412A; Wed, 22 Apr 2026 03:56:08 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F94983FE9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a415fd6bceso5419990e87.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776822966; cv=none;
 d=google.com; s=arc-20240605;
 b=F87Rh3ik2xW3H7N/syCOYc3TKlmmoCILb3elxNFQY1ij8cXO/zk13Z79RrMPz6Ilck
 JklVhg6Beb1n3ZkZGdTE34NFJ7FhxWHt9b3Hkq5jjV0piLiptVXX8FDAf2fwUIXjndXh
 8arFGH36PLoE4qgx6gZFvsOmD2RH8nLdb8KRcF2HPJ7aqzk13vd0PrfFmOxl98qmqWgc
 pfcL68DD5O4pZUzAD3p9kQ6IIRz/cRJSPvOm7+Jbz8Dwm3aSTM/dIMGYpcXgD0nNJy+5
 58SHI8nESjD0gE0Z03mkmyhbiemSrI67hzeYnyB0bV3J5WWdnK94jweRnhj3k2OgokIx
 a6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LNI0Tb01Ent5j6oSb4dSttbjld7q4GqQo9qPvdHMEb4=;
 fh=H1j7qQvZ7Hu3Sepwv46nn2/CxeKmUlT0dMO+1NCeC6I=;
 b=TGWEM5txYSGhpeqILHlagYppd5GSKdHjO/tVtoymmrYU+YDnSFdr1h6VJwD/D2qxl7
 eEOWDs5mCEnQRFQtxaNqHO6ONuWtSNb/IoBp9wL5QMHrWtUkma8yeCBuRAKPCcpG8vqW
 4hy2MMnvKF4D5Diq+AxfWw/21iuwFtPQoPwHfutKKgGm4C1x3t7t3QTnNbAwwObkGD5y
 uAxYJEOti/X/bF06Vl8DbIfVr+pzYpd+VhjAKWkYZbTa7qnmFhVl1uSUXM/XkT1CgnFQ
 e+Do30bnyt/LGj2+O7k3GRnDHopG3BgOAKIEBDUn5qajSiCzMf01Ra+jr5IYXvwIrYf2
 p8Gw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776822966; x=1777427766; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNI0Tb01Ent5j6oSb4dSttbjld7q4GqQo9qPvdHMEb4=;
 b=MSv/NV4I71/7JhdF7AgbttXQBwJWR2dRWnJtjw0zqRV8hzPytVSNTJ2tqXXpjYnzCR
 bn2QFX/CPuRhYHU9jAE92VB2SGtls/iXKvuPRJouCN9zXImWWSeQfn7xd9JVScmfDyhO
 /MG5oxbr5ny+g1X6ELwBtmRs1ERhiPmwEpaLpI3RW2Sk8MJXEHxsxtYfd6Um4bOUMc2o
 F3ei3dv5aa1oAIHmMBYVYLzp32aysDyloGwTXIpThwYEeVhHadUyPJbLHDvIQ6S/1zm4
 Kz89iXz3QumsD2EmFhb083eXaVUO56JpHSNoiAzMRjYoKKzzp3+URftOAKJFB/c0H1D/
 Ttrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776822966; x=1777427766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LNI0Tb01Ent5j6oSb4dSttbjld7q4GqQo9qPvdHMEb4=;
 b=SPxu9rVSVbQydFFF+HckSIxxUPpah3OZUpf3YjhBHsUOFJwzdMcDeDyN/uw4YUufL9
 bdq2klClhRlyh2q9hCCI3NrMU6XNp4Ma6626LEpZ6FyugG05L2XJhhZKnkZAYsl5DOS7
 MLELowZHtPhdNwDmJpY7keYiBloXKEvmCMDl/XxKHjfsg+u06vgcqmyFUExPAOlNiGcH
 NEjEqpLuu5WHVJAQxJ7eQrwhE6dKjp87QCWzYumPSDD4ePuWJAQyJtXdazuKbtYnDyyE
 8COWgO677tlfOTn3F0rSGjK3VqV9csuAiVLNaRkvbFpxeFgxqy8ddW/nicCklaEkNb0L
 iHOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VgxI8xrSOA6il8vYNRii8k8MuKGiN4dfJ1uxFeK8OP/mSThM4OjcnAvWrO3zDSU5vassEyx8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyk4H82ARRTd/4BkbruTI+I+a9TGZtE1u5xMv6+dYKVd+X1hEx2
 nxIb08gp/Cf6DyV6wRCrFstSJaKrNG6H5Nyjs3H18sEL795RsTKffR24H5lqPyx26WSTyKFc23o
 GGu++IaspJtMUYzd2VTIH+25CRdZWOFs=
X-Gm-Gg: AeBDiettgB863ouqmvXmtfmArCPTLZ/evhvnxuad1wN0xKpSQuz7+XO92Bw3tUNmsVu
 2NyzUUqoiRtbvuSKF7/r3h4e0w6K+Yw94ZQ61C4N3TOy2zwTjnU/jRunKa1cCfi5ccBGBqAgSnv
 e4Tyffmgen683pdpBZeffVzzz7M9RyuBOViNM3oyjFZUf7ynBKp3eQJ3TSVLwzwqrcwl/CQprXA
 pXU/K++35RsNLIdgYdu5rT4n3IaknU/WR2nue5bSwwPbJsADwJq2oa2YaZll7RNOAvl25ggX1jC
 DgFLtEHdaZNi6EV7YE8CF7WKCDIxI7ZKg1pBeMOUmVxFduUQZx0q7/6O/cBBO+RC3srUrOS2F3q
 cTAhQ1xc=
X-Received: by 2002:a05:6512:138c:b0:5a4:6f3:e0a with SMTP id
 2adb3069b0e04-5a417174ccamr6494920e87.8.1776822966173; Tue, 21 Apr 2026
 18:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260415101257.23154-1-cniedermaier@dh-electronics.com>
 <8d8a649a-4cc3-4d88-9028-a8c4976beb12@nabladev.com>
In-Reply-To: <8d8a649a-4cc3-4d88-9028-a8c4976beb12@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Apr 2026 22:55:54 -0300
X-Gm-Features: AQROBzC8Rgu1Rm6lf9etZgghMSPfsW9cYcd4JsSjRZAfdLj5CjtD8gCh5mA4GkI
Message-ID: <CAOMZO5A-xam0e-dmnn5nC-0wpixPr4=U9xje0XGE4xh2Zg5ceQ@mail.gmail.com>
Subject: Re: [PATCH V3] board: dhelectronics: imx: Use second Ethernet MAC
 also from fuse
To: Marek Vasut <marex@nabladev.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 21, 2026 at 4:39=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:

> "the function _to_ determine" ... can this be fixed when applying ?
>
> ... and uh, odd, why is Fabio not on CC ? I don't think this patch will
> be picked up with him not on Cc.

I have fixed the typo and applied it, thanks.
