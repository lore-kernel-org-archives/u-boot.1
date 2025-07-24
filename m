Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255A8C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF91F8390D;
	Thu, 24 Jul 2025 23:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="itHFeuYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367E783914; Thu, 24 Jul 2025 23:18:36 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4D4835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55502821bd2so1658638e87.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391913; x=1753996713; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J53bXYV2iGn5ZEl5khX8M01QSd1ksfi3VaTTGmGtUWk=;
 b=itHFeuYycwzIebzfZieKAs7JrF7mS1iYOrcS98aOQqJc/gLJpGDiLTMnh1LL82yvMb
 dM/i9/E1ubQY6XvQtqFh8H/9xWAnash7JkpFq8C5fu8l0lH3ire4+87wZTkntOSUr4xp
 qd8uy/sX6njt/dYJwm7Zg3hNYQtBXV6okA9dkBVWmp2G/7W/U+lnzxpj/d3I1Ngysn+/
 biAC3c9FyJtX0YtoBbbCTXOmmgPa0wqHwD3/YeKyBYmnguHSvDVRB+tRnCDMsdMmh5uO
 9av65qMfHQHxVRJfrk4OGhoY3G5ZfbPV/CBswZhcYj8gP3ZXgpl6zHBzXqpELUju6DEI
 DfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391913; x=1753996713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J53bXYV2iGn5ZEl5khX8M01QSd1ksfi3VaTTGmGtUWk=;
 b=hR6fx96Hlnusu/vLod6JPFZhYmv3wysvozOAQRxQ8XD1xYhBEvk2piuql5tbL0pbaB
 lSokY7ZNNa9mVEzC87dEyUG7DGk5k2ZEbqwmtZqQjdFPlOyzsBHXXub/sekooi53GYoW
 hivLWzrYXoEqVMiB5ihPsaHdlG13h4WStw/J3bXtFyCb6KHp+QoHZ8aUQOFKUvSBbpkW
 FR6+fkkuyIgFZKbvHUOIiJmnl0PNtH/WJLiWvkCIwp13R4jzt722ze6m2lwh62/o0XdH
 gW5TfoHHGE56LUM3pRrYqB/y6NqfRNOgCUR2YFyogwEcoQdu7zVnLFBWqgk/cGsTXyPC
 wNww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtkTns7sONqJK3m8uQESovIx38ISGxJU9vBnIQnuFkHtjDV5usHOUz60KVarmoEg1WGCXA+b8=@lists.denx.de
X-Gm-Message-State: AOJu0YzL/Dci88jLpwC82VbdrbUjJCepCUiwwVbbbych6YTFDfhen1cL
 SGPCjRg3HbyEDyxPgvRpR4OfJQfyJg+Lf4YqyNfxHGNaDQq3zD2MmyOxkALk6mnOPiebblm6Bu1
 4ErC7iRRVNQOctBCtAz0X0Jzk3/q70UzDAQ==
X-Gm-Gg: ASbGncvcXmyU2wOKteDHLp/zXdlHHAessScUoQFlQMcWd/hO+k8+Atr8UXO+zOLYwXM
 ezPlrKtFrSzA0QW3c3w/jvt4Jr6pGvEebMz1ketGmcriCNZDdScULFoftzziKZEWz+3IdgsWKFA
 Ytl+DP6YikWFkv0bVjnIkWdf1LEDxNnAbUFyXyzk21KsBgZU2JDzcq8t4rb1qyeUu/oNX4E5IGy
 ColtuVdxjxs4G9rutLzbaLrE427APg7spY4+bNXej7ev/dstw==
X-Google-Smtp-Source: AGHT+IG/Gzw3ljayZeoCAuOZblnFxZuasdbJWJ3N2g2ogcJJSEw8yWmUfRr+mv+qXXOoSQaw+BZBMSdghsTbvsvyr60=
X-Received: by 2002:a05:6512:3d0b:b0:553:2dbd:6a61 with SMTP id
 2adb3069b0e04-55a51380dc9mr2988438e87.14.1753391913375; Thu, 24 Jul 2025
 14:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250723180016.2021172-1-festevam@gmail.com>
In-Reply-To: <20250723180016.2021172-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:18:21 -0300
X-Gm-Features: Ac12FXyAltioFNawhs1lbNFRb1jzc0AhCmDPNrl3icb6dcgHJsA5pSx2ZyHm2qs
Message-ID: <CAOMZO5B7sQBQbaae+S9TjP=Ms1aw5xig1Pkoyj6=rmCNCtQjvw@mail.gmail.com>
Subject: Re: [PATCH] spl: spl_imx_container: Delete uninitialized variable
To: uboot-imx@nxp.com
Cc: seanga2@gmail.com, andrew.goodbody@linaro.org, javier.viguera@digi.com, 
 trini@konsulko.com, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
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

On Wed, Jul 23, 2025 at 3:00=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> The 'overhead' variable is uninitialized and actually shall not be used.
> Delete it to fix coverity CID 37041718 - Uninitialized scalar variable.
>
> Fixes: 73c40fcb7367 ("spl: Refactor spl_load_info->read to use units of b=
ytes")
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
