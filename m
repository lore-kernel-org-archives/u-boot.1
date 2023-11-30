Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82464C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 07:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCF8870AB;
	Thu, 30 Nov 2023 08:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="II+QUX8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74814870AB; Thu, 30 Nov 2023 08:41:02 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B53F86FB6
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 08:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4b28f8ca7b6so193349e0c.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 23:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701330058; x=1701934858; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6nC0Nu2BKzRK3W76nFDyud/BDhkw8+hF1sJrrJBjek=;
 b=II+QUX8u9CjcI9jvYFK7+oZDeVvT7CO4t0Ivx7Qrr1JFqGNKrafNEsF7P1Y3C+0nWQ
 H/7ThG/IT2HwzOoetcJWoMmO5EZxbVrqmth5pysDSTqt4fZTTPTAM6pw6RklmfwWJjsV
 gF+x7iEjQ1DG0ntFdNSB4avKP09lfpvAj4Qdoh5UQDTMNuQLpISO6o4exWuyzWf74vyb
 o1phNjpUnrWtaTrO568RRUtRdfd+LwWUJIO6HwpEAtzok8tHfHPpdkSyVBuHsswPmHVJ
 sgGPsOP+LDal8/taJwgMajb/t5RgvMUwrWjCSBk4AZbhQKrB2N5/XBrYFrNH4KrvvRbF
 s8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701330058; x=1701934858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6nC0Nu2BKzRK3W76nFDyud/BDhkw8+hF1sJrrJBjek=;
 b=TREHGVAw1qcaq07r5/WI2I0QDo29p9rdNOOFrT3SO3QcBz0oVyNGPRtJEeSqTv/nzu
 d35fHy8npdwhwFg7fUpMZLd9yFgtTh6MWvHd8upoytWyhsEbiNNFk+QO7jnzRRMPAgSL
 hGnMwn+BPSaR81Lh8o7vePlsVjw4snCHzxrrNXaNwNK6wohPfzMM0asAc1LbfOoXSUmA
 uvq15my6TuFBS0wtiK6920ptOIjdpjGDoj2oLvzdRiR2l6kfWkPVx3mXRtEsbHe9Bnsr
 krGvtb7WRaHumFX7GchM8Wmc40+lsW66XXAk2z5zUJwl/5U1O8/T41E73aHEsZ6pk0G1
 wttg==
X-Gm-Message-State: AOJu0YyW6yUQ7ISGo4fcBpa9Kq9J9kfVq0xnG+kvbKsi4xjmlbBJ+vbz
 ZmGwr38wcbeOxTiTeBdpmEdaRkANDIPBYbCMX/JWDw==
X-Google-Smtp-Source: AGHT+IFOsMnVY7NMAbSnQ6TKczaErODJ/1nA3o/6WEZ4Ve71GG3d4CV/f92NnCJDkq2Va5Olpg+1kwhse+z9JNCR1W8=
X-Received: by 2002:a1f:c743:0:b0:4ab:cf9d:b305 with SMTP id
 x64-20020a1fc743000000b004abcf9db305mr18114463vkf.0.1701330058067; Wed, 29
 Nov 2023 23:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAABkxwsMjTQt3uZhdui91RoswHxS=i49AuXP1Cmjb4nF7_oaOQ@mail.gmail.com>
In-Reply-To: <CAABkxwsMjTQt3uZhdui91RoswHxS=i49AuXP1Cmjb4nF7_oaOQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 30 Nov 2023 13:10:47 +0530
Message-ID: <CAFA6WYO7r1-X=66MDpMJooM8MrovVOeY8P=7LGcDPM+KdnwfAA@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Dennis Gilmore <dgilmore@fedoraproject.org>
Cc: neil.armstrong@linaro.org, Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi Dennis,

On Wed, 29 Nov 2023 at 22:32, Dennis Gilmore <dgilmore@fedoraproject.org> w=
rote:
>
> A big benefit of using the full dtb in u-boot means it can be used to
> boot the system without the need to load a replacement file from disk
> or elsewhere, which, AFAIK is required for the System Ready standards
> and it definitely helps in cases like EFI booting.

The discussion here is all focussed on how to reach a point where
u-boot uses unmodified DTB. This would allow the system to be
compliant with System Ready standards with DT being directly passed
from u-boot via EFI config table to Linux.

-Sumit

>
> Dennis
>
> On Wed, Nov 29, 2023 at 10:37=E2=80=AFAM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> >
> > On 29/11/2023 16:34, Caleb Connolly wrote:
> > >
> > >
> > > On 23/11/2023 07:04, Sumit Garg wrote:
> > >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.=
org> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 22/11/2023 14:27, Tom Rini wrote:
> > >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote=
:
> > >>>>>>
> > >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > >>>>>>> Hi Caleb,
> > >>>>>>>
> > >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@li=
naro.org> wrote:
> > >>>>>> [snip]
> > >>>>>>>> =3D=3D DT loading =3D=3D
> > >>>>>>>>
> > >>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
> > >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a se=
condary
> > >>>>>>>> bootloader, so we can instead rely on the first-stage bootload=
er to
> > >>>>>>>> populate some useful FDT properties for us (notably the /memor=
y node and
> > >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with =
the memory
> > >>>>>>>> map changes above, this let's us entirely avoid configuring th=
e memory
> > >>>>>>>> map explicitly.
> > >>>>>>>
> > >>>>>>> Since with this change, we don't need to embed FDT blob in the =
u-boot
> > >>>>>>> binary, so I was thinking if we really need to import DTs from =
Linux
> > >>>>>>> for different platforms and then play a catchup game?
> > >>>
> > >>> For now, yes.
> > >>
> > >> But why? Is there any value added by larger u-boot specific DT (most
> > >> of the nodes being unused by u-boot) than what currently u-boot
> > >> supports? The more important part is to get alignment with Linux DT
> > >> bindings. If you need to have memory/reserved-memory nodes in u-boot
> > >> DT for generalization purposes then you should import those particul=
ar
> > >> nodes only.
> > >
> > > I've been thinking about and hacking on this for the last week or so,
> > > sorry for the delayed reply here.
> > >
> > > The value is in preventing any of the existing bindings from regressi=
ng,
> > > and simplifying the bringup process for new platforms (just copy
> > > SoC/PMIC DTSI and write a minimal board DTS to enable the needed hard=
ware).
> > >>
> > >>> There are quite a few features which aren't handled by
> > >>> U-Boot that it shouldn't need to handle (rpm/h resources for exampl=
e).
> > >>> Also the fixed-regulator / regulator-gpio binding differences.
> > >>
> > >> IMO, we should fix them first and then use Linux DT as it is.
> > >
> > > The biggest blocker here is USB, on sdm845 and the 4 new platforms I
> > > have working, I only support USB high speed, this requires removing t=
he
> > > superspeed phy and adding a DTS property.
> > >
> > > I tried using OF_BOARD_SETUP to make this changes during boot but thi=
s
> > > approach really isn't scalable (and I couldn't find a way to make it
> > > work anyway).
> > >
> > >>
> > >>>
> > >>> I would definitely like to move towards supporting Linux DT directl=
y,
> > >>> but this approach gives us a nice middleground of minimising the U-=
Boot
> > >>> specific DT parts.
> > >>
> > >> I don't see any real benefits here apart from the maintenance burden=
.
> > >> If it had been an actual Linux DT then that can be passed to Linux a=
s
> > >> it is. However, the current modified import you are trying to do
> > >> doesn't solve that purpose as well.
> > >
> > > Ensuring that we don't introduce non-standard bindings (by using Linu=
x
> > > DTSI) is one benefit, simplifying new platform bringup is another.
> > >
> > > The amount of work required to switch to upstream DT is too much to
> > > block this series on. We can work on improving the situation there on=
ce
> > > we have these Qualcomm improvements upstream and new boards added. I =
do
> > > admit that this is quite an awkward middle-ground, and I would not li=
ke
> > > it to last for too long.
> >
> > I'm a real supporter of targeting support of unmodified (or very slighl=
y)
> > Linux DT, having a reduced version of the Linux DT will be a pain at ea=
ch
> > sync, and you'll need to do this manually.
> >
> > Simply having to copy the Linux DT without any changes will make sure y=
ou
> > are in sync with Linux's bindings, and will help making sure you'll boo=
t
> > unchanged Linux DTBs you get from previous loaders.
> >
> > And in bonus, you'll be able to chain it to the next loader like EFI.
> >
> > So I don't see why any work toward this goal is useless, and if an
> > intermediate step is needed, let's do it.
> >
> > Neil
> >
> > >
> > >>
> > >> -Sumit
> > >>
> > >>>>>>>
> > >>>>>>> IMO, the build command would look like following if we import
> > >>>>>>> pre-built FDT blob from Linux:
> > >>>>>>>
> > >>>>>>> - Build u-boot::
> > >>>>>>>
> > >>>>>>>          $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > >>>>>>>          $ make qcom_defconfig
> > >>>>>>>          $ make
> > >>>>>>>
> > >>>>>>> - gzip u-boot::
> > >>>>>>>
> > >>>>>>>          gzip u-boot-nodtb.bin
> > >>>>>>>
> > >>>>>>> - Append dtb to gzipped u-boot::
> > >>>>>>>
> > >>>>>>>           cat u-boot-nodtb.bin.gz
> > >>>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > >>>>>>> u-boot-nodtb.bin.gz-dtb
> > >>>>>>>
> > >>>>>>> This would avoid the maintenance burden to keep DT in sync with=
 that
> > >>>>>>> of Linux. And since DT bindings in Linux are backwards compatib=
le, we
> > >>>>>>> can say u-boot should work with DTB picked up from any Linux ke=
rnel
> > >>>>>>> stable release.
> > >>>>>>
> > >>>>>> I guess one question I have is, are we being passed the device t=
ree
> > >>>>>> (since we're acting like the Linux Kernel)
> > >>>>>
> > >>>>> Yeah that is the case here, see patch #1 in this series regarding=
 how
> > >>>>> FDT address is being retrieved from previous stage bootloader (AB=
L on
> > >>>>> sdm845 and qcs404 SoCs).
> > >>>>
> > >>>> That's what I thought.
> > >>>>
> > >>>>>> or knowing that we have the
> > >>>>>> dtb attached to the end of us and making use of the old kernel a=
ppended
> > >>>>>> dtb option? We're fine in for example the rpi_arm64 case of just=
 being
> > >>>>>> given a device tree from the previous stage and not needing one =
in-tree.
> > >>>>>
> > >>>>> That's good to know and we can replicate that for Qcom platforms =
which
> > >>>>> are chainloaded and don't need an embedded DT.
> > >>>>
> > >>>> So yes, moving these towards the direction of rpi_arm64 and specif=
ically
> > >>>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force=
 that
> > >>>> the dtb must be provided to us) sounds like the right direction to=
 take
> > >>>> these platforms
> > >>>>
> > >>>
> > >>> --
> > >>> // Caleb (they/them)
> > >
> >
