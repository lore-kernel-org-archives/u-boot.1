Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AF4D68BD7
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D74A88EF7;
	Fri, 15 Nov 2024 22:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nKeZy5aP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE25C88F12; Fri, 15 Nov 2024 22:09:40 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BA188E4B
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso1857409a91.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704977; x=1732309777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KsEgp3V0AEgbOorImIVy/9an4s7iMqBfynvk8y442ig=;
 b=nKeZy5aPB7+XElvZQmvd4EcxJZPD/l9UIOJTDO3GGB3RK1HEyH6rsU9+dfr5yxQEB0
 85S/KcI1rt7Qj2q94KiSbpbUULTMgDTM+ZW+pNopknaOhtJYfZ0A2JUzLmXfwBtYMAPH
 s0ehlbtM5TbnVoZhkzOlOcga+KKc40am+K8N47O8qHd3d2FaL0uPm7dUs90gf7sV2V7h
 Ljo8CbRcGBnzC8adYuMyTvz+sEprc9C4V3I+kSPSBMU/WlOLHG5EXDz4SOLuuuAB2G4X
 Dv/3sy4k0ddQ2wVZ6LzHQr7/5LBSJq3QJR2k8X2mpNmigSBEN4XGhxOobBB5x/3wJGom
 4RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704977; x=1732309777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KsEgp3V0AEgbOorImIVy/9an4s7iMqBfynvk8y442ig=;
 b=ODWr9CEtWKNhbutCUdYGhwBcRhCHwg19uKFGor0xPWoVyc2q8Cf189ZZXYczcjl/Gf
 vZMvw2p3NrI+fDsVnofmL5pbPLf2M/DQWYd+wwZJFt4QosrQ2G1d+EIMiTY5Tkm9O2aI
 Wg43LzthHKd2EESYS3h4Gt4327n2/AZnv/wQwZY52zgzxhH726wkh0UF79Onjp4sNeru
 zzs3u/Ga5a7k1kAyBfrGPBQ7VD0A8G+CUwSisSY2kbPRvOFtyLGms3Gz3SDXl7XHFlqt
 N/03WLsNMl5KPWGiMSRpFOin99Kz8GPFMr0l3zyOkqsBSHVGUAEwkApboNQUse1+hF+g
 iycQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOE47UhdIHausgj71yH8OQhogYJCMVAu46mpURZAwlUYCmNUlXxcvEeRohm/biCwfC3Arr6uc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywirzf5BMKyOM2Uv5dBRkWk7uWOVb3hZzm6DYyoqQKyboV4D4sw
 VwlOVJGuYpEiVllLB7v5venUo+hX8dLSceptQOSjNHkBA7uozRC7k7auN8svrC059UHuD5fTcO3
 FkkJ5hRzoTk0zfWnTxsKZ/JcEaI70FJxQWHlaNg==
X-Google-Smtp-Source: AGHT+IHJBxeakPnYZy7G1Ceda4KG62ZLhixj2EyPnnA8jYpkQ0Lp2aVXOicP771ooIpl/C5s4hoo9CJkUKklt+92Ijg=
X-Received: by 2002:a17:90b:4c03:b0:2e2:bb32:73e0 with SMTP id
 98e67ed59e1d1-2ea154f5f73mr5909697a91.12.1731704976721; Fri, 15 Nov 2024
 13:09:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
In-Reply-To: <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 15 Nov 2024 16:09:26 -0500
Message-ID: <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tony

On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com> wrote:

> Hi Tom,
>
> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> wr=
ote:
> >
> > Hi Tom,
> >
> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > > > Hi Tom,
> > > >
> > > > I am on 2025.01-rc2, and I am trying to commit some files. The erro=
r
> > > > seems to indicate this framework directory might need some
> > > > modification. Did I miss something?
> > > >
> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not have a
> commit
> > > > checked out
> > > > fatal: updating files failed
> > >
> > > That's odd. You didn't happen to try out some of the previous lwIP
> > > iterations on that tree did you?
> >
> > No, I did not. The tree is clean with "make mrproper" and on the
> > master branch. I just did a git pull and worked on it.
> >
> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
> > framework directory is pointing to a specific commit.
> > framework @ 3867faa
> >
> > I'll stash and repeat it on another clean tree.
>
> I have the same commit error on a brand new tree.
>
> I think you are talking about the test framework of MbedTLS's original
testsuite,
am I right?
MbedTLS was ported into U-Boot as a git subtree and that framework is a git
submodule of original MbedTLS repo which was not included in the porting
of U-Boot since U-Boot has its own testsuite.

Regards,
Raymond
