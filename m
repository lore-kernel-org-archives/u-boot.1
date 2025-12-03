Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18117D116F3
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 06:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779C483F4D;
	Wed,  3 Dec 2025 07:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PewzO/97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D13683F4E; Wed,  3 Dec 2025 07:54:24 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8243683F2D
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 07:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6d13986f8so549672a34.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 22:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764744860; x=1765349660; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zirXjXYWBpFfo6mL2PVMvuz3OHjQPcaaB31yVfuSwY8=;
 b=PewzO/97F+MABc0BbedSQt6Yn1wIL2EAZkDsqFlncny+rkxWvF648SqEbQDcdrT/PH
 1AkcBoWr369tkZ5SO/xy5LbVjCUjdoPSUAkoade5zNBrUXBLytLqCtQvdIZA/P6AKOD0
 bt5b2RuBvWj+wAz0j8AQmEGN3uc+o1iOCWsUXKAMV24q1ZyZm3kojrJD5nAEXkQgaHrJ
 IjDCvvVyD+z2IhNogIJkwCP8PiJJkjqDbjg1bV2wp6qM991bGK754bmFAjJojrYKViJ0
 CXKj7/QpT0l+uUXVivbMgfAU+uUhGcgkdhF0eeaY5r7IvptpS+7IkAKbCGSJC2t5gUOY
 mung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764744860; x=1765349660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zirXjXYWBpFfo6mL2PVMvuz3OHjQPcaaB31yVfuSwY8=;
 b=NrUwdcY16fJAlqmytL5igg15ey3j/GxcjPdbIEQoMLEZsJVakL+xOlc3Ieat1F0z/w
 BDT5EBRb/F9sZoQLZOAAyBe9CwRG4lHAyct+OIyc8Dz0HJWve8mIFok38Q0ECWdknrLp
 0dQzsha2L1wWMaFfsu1sZF3O5AggKNl/K7kAmNpqyZKdZJ+X5XjOslNdcDZSZ3Fyoq+9
 OWbgvQ5oSt+6qPV9uW27dSLNaWyxo3Pss6+qJ7g7IdbvtvoN6O8XYuy9UB/hNX+je5pZ
 hr9xvq+LfE/qyZQ24l6JlN+wSNFSbXamoJdqKeplMg2RQ1pKU20OOc0vwz+huvnmNjlp
 BSTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5vOSP+VjDnR5RRX5iDmoMA9ezSSPlzQQv8ihF2+GHR/dGJhcViAdI1+a9gUQB2dtJBx5uT8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YylKQ03XgRa2XTuqdlCG/aC7vn/2ZTcyywq6qUkNrK4z/KjTKCU
 Zdn+enIisCoScdJqM7VxEIDpIKQbsH/HySTXjVFa3lR7PHFDQBsDVi2Jp1DRy+FX9d6z3sRh/C9
 JiY27JGgnEsQAB6rHSThX+yEGKS1UggE=
X-Gm-Gg: ASbGnctdN7S7jK+25BGdj0smw/Mxfy8VuktS/SXLzVRs1uDETHTMVSJfgjmuZ5XWUU6
 V1T9tuss/vYQxwIAxRU0Koye5osJr31wVdApzC7mP7j0DEOqT9diolzB0cw+gKO8ire+CjRatkf
 8Hu42f2MOqztIxGuNIOHW0S6Qsdjnv3JQG4vnoHi8YE+soj3nqMf6oMCDTrsfqKsi9lFERsYzI/
 wkdFrm0IDr/8oBJyXvbuVytBCp//UBsbscbucOnpgTCKWtX3yvzH9laf7lI2Pn3j2x4HFM=
X-Google-Smtp-Source: AGHT+IGJ/Xn9wiVc26qnpqWmxJCg4D/XBznYmmoK0Wpr7gxY0PriVbdFD5UD2z9ycL6ayTSveJ2a0c29O5mHphChPf8=
X-Received: by 2002:a05:6830:674f:b0:7c7:7f85:d19 with SMTP id
 46e09a7af769-7c94db6adbcmr679189a34.8.1764744860213; Tue, 02 Dec 2025
 22:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
 <CAN7C2SAEZgm8KshbGU3d48U3w01vtG5zvbzZRbA_3tE5S0E+Lw@mail.gmail.com>
 <CAC_iWj+Jo1fP2ucXPY+q6+rFhHsT3PKz7H2J4dH-3cyAk01HEg@mail.gmail.com>
 <CAN7C2SDDAtxfDiHUac9q-WfB8jr_eRPDKcbfrtbcyXDbdV7_nw@mail.gmail.com>
 <d481c4c4-76e2-4b6c-9bef-19c2d616fe23@altera.com>
In-Reply-To: <d481c4c4-76e2-4b6c-9bef-19c2d616fe23@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 3 Dec 2025 14:54:09 +0800
X-Gm-Features: AWmQ_bm21tyeNJ-oJEvJr6FfGKJjPfJogRNncMjC5ih7706h0NIa5a_K4UtDLoA
Message-ID: <CAN7C2SC+Bm2nQR2CHpFLkE_dRtY0FjXJ6vR2LQRyXy+rtpOEmA@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>
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

Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com> =E6=96=BC 2025=E5=
=B9=B412=E6=9C=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:46=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 2/12/2025 4:59 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Ilias Apalodimas <ilias.apalodimas@linaro.org> =E6=96=BC 2025=E5=B9=B41=
2=E6=9C=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:53=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >>
> >> [...]
> >>
> >>>>
> >>>> Ok, let me go through my irc logs in case I find it.
> >>>> Reading the email thread we should compile with anything > 8.1 right=
?
> >>>>
> >>>> Cheers
> >>>> /Ilias
> >>>>>
> >>>>> --
> >>>>> Tom
> >>>
> >>> Hi llias and Tom,
> >>>
> >>> I have a question might be wrong or not even exist.
> >>> Tom mentioned GCC 8.1 kbuild but u-boot is considered as
> >>> kernel build or it does not always be that case?
> >>
> >> We use the same Kbuild system as the kernel. I updated that a few
> >> months ago since we where stuck on a really old version.
> >>
> >>>
> >>> At least so fat there are nothing can build properly below 10.0.1
> >>> Using ARM official cross compile binaries.
> >>
> >> I think I tested with gcc11, but I I don't remember testing with 8.x.
> >> I probably missed something on the backporting. I'll try having a look
> >>
> >> Cheers
> >> /Ilias
> >>>
> >>> Thanks,
> >>> Brian
> >
> > Thank you IIias I don't really know all the u-boot things.
> > I had provided the first draft for fixing GCC check.
> > https://patchwork.ozlabs.org/project/uboot/patch/20251202041029.186-1-b=
riansune@gmail.com/
> > Now it is on 10.0.1 if 8.1 is the case will update after your confirmat=
ion.
> >
> > Thanks,
> > Brian
>
> I am able to build CycloneV with the later GCC 10.3 version on my side
> without this patch included in the patch series.
>
> Thank you all for your valuable inputs.
>
> Alif

Hi Alif

It is possible to align both sides with ARM official binary release?
The ARM have compressed cross-compiled binary.
10.0.1 should be the minimum it can runs.

[1] https://developer.arm.com/downloads/-/gnu-a

Thanks,
Brian
