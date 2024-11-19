Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B193D6C2B9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18B08960F;
	Wed, 20 Nov 2024 01:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eyS0yPho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3946B895D0; Tue, 19 Nov 2024 23:36:33 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4158888F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ee3901b08fso4975237b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732055790; x=1732660590; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1C/OSjF9xZaMhek90OnzDZKChjbOxNaLWIylKca6Rc=;
 b=eyS0yPhoNlK1Z2EgxE4EcA79W6D6ql2Pl+N0wKEXK+K8ML7Mya/5zgBUEo4PPL2o6l
 SheCBpdTM6X4xHUM/bUic9hsTrKw1dJTE8Dmfh6gyLmDdcZWrvwLzaZ62X6MIkwVH83b
 4jsc0Xam2G2seYJTysbcto20+Hup2PMhIpawXtVEYLmdXx6PbIVaERKmSIseLtV4dIUH
 gfhnRpDFWDEfF/pyXUiywbaQNLAaX/5ehQzbUvG6dHuiW2pgALovndgUzgSkdPQqOPzO
 mfmQur021IRsqEFiE1F1h1WMn896DZuLs8/PGnGIFnX8C0alabphXlujGjkEi1pPPsWu
 QqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732055790; x=1732660590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1C/OSjF9xZaMhek90OnzDZKChjbOxNaLWIylKca6Rc=;
 b=t8FssMOL04KVJC1YH8+vQXl/741FTwPzzT2Gp+d9HnAnmuUt71T6qs67Umy6VCIPd0
 QiDHthKGNvbVNqFm9tBJWLgOm2JXNmmeg16PxLhXJEvHKzI4f4AI5yU5GtRHTf6uDslh
 PukFhFGUWdbNCdP7Ko9jV4O957KcK/g702jHi0ZyDSBIbtISKrwQ04a9tZX4QcQMqCrm
 XfE8XFoq3I2vvoPtNCDAqmBVnt1xrnKb78YkhAKARWg5k+hT8skkvEkZY9t1RZPlKlfI
 LMDuWktyP0FCBt5LYum8+cMK+AqrldScsT8Yx1hMaVFC2zADNDf3xbGIYtPCsbdFCUzd
 PmjA==
X-Gm-Message-State: AOJu0YywUZVZUYlbJTfncKsNGkBoEGBze9Do6BMLQnDFD7nHfOCp13Ty
 M49ZFawbP4KzglGjXJAmrhng7zdSnlJST+E/G4Fbz/m7bj4EOZw26w6h92Sn67YtaqEwhycrMSC
 Wb4bHtvjrs/h9KcJySNsz6UF6/aI=
X-Gm-Gg: ASbGncvqnE3q/UU4zGixIXWdjQE6Za4Lbuo/AxMvs/vmGyC1o6rdBvbFYngwl7FNgwg
 zzMPT6bA54OIYwjeob8VTOSn28DN3D4o=
X-Google-Smtp-Source: AGHT+IH2CPdve6AWOkaVZ86szBA+9fuz987nm3rdwrRxksEaKhTfmG2QOnVP/hSml6P5HY4ZRFjpaXHd7vPfVmGEyJI=
X-Received: by 2002:a05:690c:891:b0:6e2:636:d9d1 with SMTP id
 00721157ae682-6eebcfbe7ebmr2706657b3.0.1732055789765; Tue, 19 Nov 2024
 14:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-3-l.rubusch@gmail.com>
 <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
 <CAFXKEHZLwbU=w4LH4iiZeo4ycwOKjgi5YZesHHgxzy6Ac+TOUA@mail.gmail.com>
 <5ba375a1-cf1d-463c-8590-3ddf46c47f3e@denx.de>
 <CAFXKEHZ4+zPw7LuNYK2QZYOQj4v=1UMuf29CSGAEibSOWU48SQ@mail.gmail.com>
 <8404049c-85df-4c72-bf3c-bf83d143b8b9@denx.de>
In-Reply-To: <8404049c-85df-4c72-bf3c-bf83d143b8b9@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 19 Nov 2024 23:35:53 +0100
Message-ID: <CAFXKEHas2E2KTCDsN5f5=ntkqqPZG2Ti2WjFoRkyZCGV8hw-OQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sumit.garg@linaro.org, sjg@chromium.org, 
 xypron.glpk@gmx.de, michal.simek@amd.com, jit.loon.lim@intel.com, 
 barnas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Hi, sorry also from my side for the delay.. I guess, bringing
Altera/Intel DTS to the kernel is getting a longer story. But I even
can see light now. I keep you guys up-to-date, if any news.

On Sun, Oct 27, 2024 at 5:09=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/23/24 10:10 PM, Lothar Rubusch wrote:
>
> Hi,
>
> sorry for the late reply.
>
> >>>> Can this be generated using binman instead ?
> >>>
> >>> This would a oportunity for me to learn the binman tool. Great idea! =
I
> >>> need to read a bit more on binman to get a better understanding. I'll
> >>> give it a try and let you know. Thank you.
> >>
> >> This commit might help:
> >>
> >> 5fccc2891e28 ("ARM: dts: stm32: Generate u-boot.itb using binman on DH
> >> STM32 DHSOM")
> >>
> >
> > I face a problem here. First, to apply binman stances in the .dtsi and
> > integrating it as -u-boot.dtsi is very interesting and I actually like
> > the solution to bind everything togerther in this way.
> >
> > But, I face the situation where the very design specific bitstream(s)
> > for the FPGA are actually not supposed to be upstreamed. Having u-boot
> > binaries and bitstream as .itb separate, allows to build the u-boot
> > part even w/o the bitstream, i.e. the u-boot setup can be quite
> > generic, can be tested and verified building. Is this still possible
> > if binman requires it as binary blob?
>
> I believe so, U-Boot CI does use binman to build e.g. imx8m targets
> which do require extra firmware, but during the CI build that extra
> firmware is replaced by blank empty files by binman. It does print some
> sort of warning that the files are missing ... try e.g. 'make
> imx8mp_dhcom_pdk3_defconfig ; make' and you should see the behavior
> locally too.
>

I totally got the u-boot log wrong. The build runs through with or
without blobs. So, there is no open issue from my side.
If I build w/o blobs, I see the warning in red - it's actually just a
warning and not an error as I initially thought. So, the current setup
as is, actually builds on binman. It is ready when you are.

I'm issuing a version 5 now, just for having the document/typo fixes
excluded, as Simon asked.
Best,
L
