Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDFCCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 08:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE90784868;
	Thu,  4 Jun 2026 10:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tqfSY/EM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3804D8486A; Thu,  4 Jun 2026 10:24:09 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F7D84715
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 10:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-460166910e6so226718f8f.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780561445; x=1781166245; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xp/gitadWb1HWf6ak8AbBdjFSPqTnPsS3XOTPt4FecQ=;
 b=tqfSY/EMA0DZ2abuDePxp9s2leDQQXZGFFO/TsXkiL0P/wHbs/4Susfh2dXnw8SaoF
 owI+J0QLGd7kC8a1CFTEqzzAkj6JBGthLhR+q/i3NUnGxw/F/b3NzLGTa2Fz4TffZzW9
 ucOceVvkdoiyjHMZdH7A+t3Sp4XsH0htRZJW6hClY+dVU1U2JSYhG+Y/9QqAHKy2OlB3
 ZSzHyEsIzmx2MxCsq0IFaq7Whso32xXjTFec+w2asHTXMTL4HrnVHCqo/gd4c8xzE1x6
 AZGyGXMIoitNpyfouBQgQJJiPWMEhiC5/pcOt94UkjFCyS20WQRvZUZ6Xg/eTKXvupaG
 yQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780561445; x=1781166245;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xp/gitadWb1HWf6ak8AbBdjFSPqTnPsS3XOTPt4FecQ=;
 b=jKLPLcJCaKdoznnnrGE1ZW8GLF8YpyCsNA6X3V2U9wdFfCTfbVL8XBNZ1NqkgYHTn+
 ds2YNPlu7jj5QD7lQ6Rcg/k2o/PCY5ou6hyS0EYVwqNbRLarlW58XRYzaY/REUCMlCBB
 7LAPVvHG1xnhG0BO7nEPE9aOZ8E5YkSQOp4CCD/IQz1Q89KeqboGK/GJg+Mb95c2qSLh
 oWDW1bd/1hDFFaPC157vUyStEV9ShOnBOlm9lpoXnSLzzq22a3IPFGWBtceXknxiWCva
 uBncsNmiWix7JBB15o120GKUqR/fHO/mFp755PLDNtwVdSoP90qjiuxTUjwIuM+FMm05
 wIfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TgXpVAhCT0WF2zgI5Drv1oSDVONn6LwttJL/sOiUY0vXEW4OF2E12auY7BjsVP1OBpRxm7vo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/D8jhB+kCb295YsoSCay4NqT5SyQxGjY8wCWS2n0s3/ixyHID
 h1qIBkHiK9zVzCa2pmbBNE1HpLYFvV1YazJq6ZERHYADGN1y++8gnx0QyDQ5APi9eC8=
X-Gm-Gg: Acq92OEogK7QBfmlBtfOkF+46SR6sjD/HsteudcUmI+xVmsE5+1QIjhCFZ+DH8oiknZ
 eVNoxlsB/Jz+L+AhLI1+jmfUlW2S82qXVMIDyf36G2I4kigxTA3PHdL3x6nltZ1M+LRNuE6/RUf
 pMvATFQkrarPV+wFebtelic93RIVr29tYCFS2Dty0wHaPzzoKPl7EeHun+/9iCCGLVgMjlV5XOI
 XhXJ+TjhtTxL8SrTs3Lc7xTY2wZzaV1VPnZHqkHyHoj8uJcEaRPV5x6jX3Fsr/2lNJTwDgrwrrF
 Jlg/vtgErjCd29Lm1aHVdyUJjKEEz3lgphVSKLXei0rjxi+zPvIyE4ay5ilp9Hkvz9fvjDC2nKf
 w5GKzxA0OzF6hPomyp/oN36j+FvMkkaLRc4WlJujsNvjzwlIDuBRaZldffdLr0sL5B8zLgGi0cm
 LllYHIJYDOtreoboKpm16tdQxkaMwqACW1UB0vGlQAlCMVgajCK+OGHmsXAXsiCYHn7vbBucQ1Y
 LDVb/Q7gtExafc8R0CjaOUjm2Ei20yVfOWcrus4al/jTP5a81hPCocexjYMtaVWHO7En+Os+DrY
 kGC4wLHcpwoc0yrjjMKVqZqQeYKfUBPJs6hecXN0pfs8xHcmx2KxJZw3iV+dbVR6CFj1WqBVD+f
 rYEH/ebHoN/6DyUtLrYF4qr7Fn9JhZkKE5lkLApMBmND4/AE0L84O26AvpCgaOL4T1W1UKMdnO0
 TgG8R4o+vZ60jjV/E2pO1YuMG9hosGPLyfWy0nQ3E+0OuNR0ThlNnvWlhu5DZmy7X3d3+x5aaxX
 QOioo+BPEtb0+zAwfjE5kFPNNckqrx78MquadFEN/s=
X-Received: by 2002:a5d:5a12:0:b0:460:edd:ca89 with SMTP id
 ffacd0b85a97d-4602184186dmr7222096f8f.26.1780561445143; 
 Thu, 04 Jun 2026 01:24:05 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3444fesm15960424f8f.20.2026.06.04.01.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 01:24:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 11:24:03 +0300
Message-Id: <DJ04CQW0NOFG.1904K2K2X7IOI@linaro.org>
Subject: Re: U-Boot Concept Tree Proposal
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Simon Glass" <sjg@chromium.org>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
In-Reply-To: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
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

On Wed Jun 3, 2026 at 8:06 AM EEST, Simon Glass wrote:
> Dear U-Boot Contributors,

Hi Simon

>
> I would like to introduce the U-Boot Concept tree along with a few though=
ts
> on its role in U-Boot.
>
> By way of background, I have been a contributor for about 15 years - arou=
nd
> 10k commits and countless reviews. I have introduced many innovations int=
o
> the project: e.g. sandbox, device tree, C test infrastructure, Binman,
> standard boot. Of course I could not have done any of this without the
> U-Boot community (nor would there be any point).
>
> As the U-Boot project has matured, the demands for mainline stability and
> rigorous review have created a natural friction for landing complex,
> large-scale feature and refactoring series at the necessary pace. This
> structural reality, which has slowed the adoption of ambitious efforts li=
ke
> bootstd, VBE, xPL [1], and CI-connected hardware labs, is what the Concep=
t
> tree is designed to alleviate.
>

Well the problem here -- at least from my side, is that a lot of these feat=
ures
are useful but feel half baked. E.g we found bugs in the bootstd uefi metho=
d and
those were not corner cases bugs. We couldn't even boot boards with it unti=
l [0].

I also think to an extent that's expected. Introducing big features will ca=
rry bugs
etc and that's fine. What's not fine is trying to merge all of them in a sh=
ort
period of time. We need to find a working model, where new features are tes=
ted,
at least on a number of boards and become the default. Those changes also n=
eed
to be sent incrementally and be reviewable. You can't send a 50 patch serie=
s and
expect them to get merged in a week. You need to find a way to send smaller=
 patches
that people can reliably review and accept.
FWIW there's similar code all over the place in the driver model.

The pattern here is that you add some code for an idea, but you spend littl=
e
effort plugging it in to the rest of the ecosystem and boards. You just mag=
ically
expect people to follow that and then you personally treat it as a U-Boot s=
tandard.

> I strongly believe that projects must evolve in order to stay relevant in
> the long term. This includes code-refactoring, new features and subsystem=
s,
> along with migration of old code to use them.  A look back at the U-Boot =
of
> 2010 shows how far the project has come. I don't think anyone would still
> be using U-Boot if it had not evolved.

Agree

>
> I have set up a 'Concept' tree, a possible future for U-Boot, as a way to
> regain the old pace of innovation. This environment is a proving ground f=
or
> new features where we maintain a lower bar for risk tolerance and
> completeness. We will accept partial and speculative features, provided t=
he
> underlying code remains robust and of high quality, with the shared
> understanding that features may be dropped if they do not prove beneficia=
l.
>
> Another difference is AI. I believe that AI is the next step on from
> compilers, which also took a long time to produce good code and find
> acceptance. The Concept tree welcomes (and encourages) high-quality AI
> contributions and reviews. It accepts PRs and allows reviews on PRs or th=
e
> mailing list.

Do you plan to merge patches that were written and reviewed only by AI agen=
ts?

> It relies 99% on automated tests (sandbox, QEMU and labs) so
> sets a high bar for testing. It uses a separate Gitlab instance for now a=
nd
> of course uses a separate mailing list and Patchwork project to avoid
> cluttering the main list. Concept runs an AI-powered cherry-picker so tha=
t
> it keeps up with mainline. In no sense is it operated as a fork.
>
> Once features are landed and functional in Concept I hope that many will
> find their way to mainline, although inevitably some rework will be neede=
d.
>
> I recognise that introducing a new 'Concept' tree might initially cause
> confusion or concern. This is an invitation to work together to define it=
s
> role. I welcome all feedback - positive or negative - here on the mailing
> list, privately, or on irc. Let=E2=80=99s discuss how this initiative can=
 help
> U-Boot remain the defining firmware for the 2030s.
>
> [1]
> https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3DieT2oaHfgL=
f3_nC+xXA9g@mail.gmail.com/
>

[0] commit 4b151562bb8e541 ("bootmeth: pass size to efi_binary_run()")

Thanks
/Ilias

> Concept tree:
>                        :
>                        ::
>                      ...:::.
>                  ::  :. -
>            .   ::::::-  - ::. ..
>           .:: .:      -=3D=3D  =3D.:.
>         ::.- ::::. ::. :=3D:. ::::
>   ::. ::   =3D..  :.-::: =3D:
>     .:-:-. -.::  ::=3D-:=3D:
>   ::::::=3D.  -.::   =3D=3D=3D:       ::.
>     ::.:::=3D::=3D:   -=3D=3D=3D:--=3D=3D-::--::
>       :.    :-=3D-.:=3D=3D:.   .:  ::
>                =3D=3D=3D:       ::  :
>                =3D=3D:
>                =3D=3D
>               :=3D=3D
>               -=3D=3D:
>               -+=3D:
>               =3D++=3D.
>              .-=3D=3D=3D:

