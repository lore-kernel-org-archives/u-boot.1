Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B3AE8FDC3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 01:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC2B86E57;
	Wed,  4 Oct 2023 03:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F8/h+rHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F53E86E65; Wed,  4 Oct 2023 03:56:19 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6126E86E37
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 03:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5056ca2b6d1so515485e87.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 18:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696384576; x=1696989376; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouDyIvkAcP3FiFhXtRxEa5Y7u0S95UEGfvjfoSSqcrQ=;
 b=F8/h+rHzyenu67qk+tiwfuZW2YBGxbxbHpR6J8oc+fY2IA4AjIxZmh4DPF5ZuUOtjG
 LECZvNbpyfJuslHjNVVjcOsPFME5DE78iD1HOVbgp6FWE9BoWDMOR2sau2W10I1trfr7
 rdshGF1Llm5VVpJibQMMJn8p/kyiAtfbPFy7P8jKjnpe9dRUcNGMtaeTAqFy2kq7IJTZ
 s/ZE1eRlyNde3mzuefeH3SqtCYCiLCqka9MpeOqZrF5f+Q7G5hkVpaglYF004cVlE6we
 afYjIZ6AXsMNmsE/l3YpJUS13xXCoPubKEYZMQlfrSR2QIPsxJ+7FFSg/tSC1V2Vb7Fn
 Fkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696384576; x=1696989376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouDyIvkAcP3FiFhXtRxEa5Y7u0S95UEGfvjfoSSqcrQ=;
 b=JE6BdzkT7ndvieIp3Y12cv1UFhu6wiD50hhKZA1BhrvGeDU6Ercshw/e7pc90aL4OP
 YvyKQRWIEgbL5Ir7idA47xR76t4WQTcgEuyt36/OB5EqsPu6a46eMJIqp8azpJvKrWjR
 2DKaW9RcyPi8f6VWqSUz3jiEzx1XICTtXcfy0OteBVY5P4srahbhrnfyPoZp17HQyFGb
 PXcq5yzMBb1XMYVY1UUMlXhVaqOtYGIqMfyQEqtS49+xG6S8CaNWhtQYZ0JuGUIYalZM
 Dv6PxvhcnisB8BVbbL7hRkRpdN7hpQxePPvzeHQ0yonEkoN13Fbp7qi8hUM4Qi/cCk2p
 Lvbg==
X-Gm-Message-State: AOJu0Yw8SyH9m3nyMPUU1xtOCRvHdjzdiZjw1C1Qc+YmxhPAWvZaGVEa
 ykjv2UV5nM6WubK/CGoSFQToz7eTwlsqFqNeGoY=
X-Google-Smtp-Source: AGHT+IGoVoksBJbQKtEbRMuov8MmPeCDi+rbtanAUImZ6mtnp1w2TSMmfIiSIflxxhWNYpAIoPh43xnxfE0mOQd3gic=
X-Received: by 2002:a05:6512:3e2a:b0:503:18f3:7ce5 with SMTP id
 i42-20020a0565123e2a00b0050318f37ce5mr1398645lfv.10.1696384576209; Tue, 03
 Oct 2023 18:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
 <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
 <20230928122317.GD305624@bill-the-cat>
 <CAKUZ0+Fr+2mYYK8naK6gxLdzSDtQ=MW2Yp12ipXE5D3-pq-y1w@mail.gmail.com>
 <20230928161657.GE305624@bill-the-cat>
 <CAKUZ0+HnYEKxJUbXdrHPMUMVROcFSu7aA_mspd9OnaMCPozXTQ@mail.gmail.com>
 <20231002140449.GS305624@bill-the-cat>
In-Reply-To: <20231002140449.GS305624@bill-the-cat>
From: Jim Liu <jim.t90615@gmail.com>
Date: Tue, 3 Oct 2023 18:56:05 -0700
Message-ID: <CAKUZ0+Hxksjhyzb5EvqdkzNe4URQmvni1kH0PrNNAcEg39deBQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
To: Tom Rini <trini@konsulko.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
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

Hi Tom

Thanks for your reply.
I will create another thread for this topic.

Best regards,
Jim

On Mon, Oct 2, 2023 at 7:04=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 02, 2023 at 12:40:54AM -0700, Jim Liu wrote:
>
> > Hi Tom
> >
> > I followed your suggestion to modify the code.
> > but still have errors.
> > Should I use my workaround?
>
> No, please figure out the errors, or at least post what you've got,
> thanks.
>
> >
> > Best regards,
> > Jim
> >
> > On Thu, Sep 28, 2023 at 9:17=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Sep 28, 2023 at 10:32:51PM +0800, Jim Liu wrote:
> > > > Hi  Tom
> > > >
> > > > Thanks for your understanding.
> > > > but  this patch  is an incomplete patch.
> > > > After I applied this patch  I had another error.
> > > >
> > > > arch/arm/cpu/armv8/cache_v8.c:773:2: error: #error Please describe
> > > > your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
> > > >   773 | #error Please describe your MMU layout in CONFIG_SYS_MEM_MA=
P
> > > > and enable dcache.
> > > >
> > > > This error is the same as that link.
> > >
> > > Please use that patch as a starting point (and also possibly needing =
to
> > > grab
> > > https://patchwork.ozlabs.org/project/uboot/patch/20230822075112.71799=
2-2-bhupesh.sharma@linaro.org/
> > > as that's how I'd like to proceed with addressing this generic armv8
> > > issue, thanks!
> > >
> > > >
> > > > Best regards,
> > > > Jim
> > > >
> > > > On Thu, Sep 28, 2023 at 8:23=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Sep 28, 2023 at 08:49:23AM +0800, Jim Liu wrote:
> > > > > > Hi Tom
> > > > > >
> > > > > > Thanks for the quick review.
> > > > > >
> > > > > > if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error=
.
> > > > > > So we added a workaround for our bmc uboot.
> > > > > >
> > > > > > the error message as below:
> > > > > >
> > > > > > CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the followi=
ng
> > > > > > build error would happen.
> > > > > >
> > > > > > arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
> > > > > > arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_dis=
able'
> > > > > > arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_dis=
able'
> > > > > > arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate=
_dcache_all'
> > > > >
> > > > > OK, so you need
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20230811054228.3=
721455-1-bhupesh.sharma@linaro.org/
> > > > > to be applied, as-is, yes? Thanks!
> > > > >
> > > > > >
> > > > > > Best regards,
> > > > > > Jim
> > > > > >
> > > > > > On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
> > > > > > >
> > > > > > > > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=
=3Dy
> > > > > > > >
> > > > > > > > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > > > > > > > ---
> > > > > > > >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> > > > > > > >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> > > > > > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/=
mach-npcm/npcm8xx/Kconfig
> > > > > > > > index 5f4a0506dc..163e7e7d48 100644
> > > > > > > > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > > > > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > > > > @@ -6,6 +6,10 @@ config SYS_CPU
> > > > > > > >  config SYS_SOC
> > > > > > > >       default "npcm8xx"
> > > > > > > >
> > > > > > > > +config SYS_NPCM_DCACHE_OFF
> > > > > > > > +     bool "Do not enable dcache"
> > > > > > > > +     default n
> > > > > > > > +
> > > > > > > >  config TARGET_ARBEL_EVB
> > > > > > > >       bool "Arbel Evaluation Board"
> > > > > > > >       help
> > > > > > >
> > > > > > > Why do we need a new Kconfig option here on top of the existi=
ng generic
> > > > > > > ones to control cache?
> > > > > > >
> > > > > > > --
> > > > > > > Tom
> > > > >
> > > > > --
> > > > > Tom
> > >
> > > --
> > > Tom
>
> --
> Tom
