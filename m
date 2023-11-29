Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17803C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F3887638;
	Wed, 29 Nov 2023 18:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C7187616; Wed, 29 Nov 2023 18:02:04 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0E78777F
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=fedoraproject.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dennis@gilmore.net.au
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-67a22fb8ee0so22462406d6.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277321; x=1701882121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwr8+3JcOCGDUdWbilkRxTtenBqsTPpGWl6b+qEjOkM=;
 b=epZErDEn8o/BwpiFiYaSuBz7WQFq4i4W0AQN0yHHxa1iXB7Cu/2t7ertSolc3iahe8
 wdaVkRfm9bGYURZg7DNbL867AgQpaA5gu2SMC/RDH0YFESN30t3xXBlGiurXSXnZj1J+
 zvlr0y7qCEjjPB+02JtT4mwTVCVz5g4EdyMwRbqDqM1Ksxsx1oNSziR3ZiywMOVeAWDa
 4oLTfD0X7XanyxwtPzqVzxSXTfytfhSByb+7XDN4G9p0azPUhef+J5L1xEfBq+NmXgFR
 /omLhRB4wbUi7GRQyugusc8ZBUzrqQ/xDZv9TsdV62LOdb2e1/qKxurivTBI42QDFAx/
 eh5w==
X-Gm-Message-State: AOJu0Yz5+CWlzRSgVQT5ZvCOKR2tfF2X9UH8De3ST39arlXjNqCdeO7a
 jaq6F0iGr56bO77HUwzX0/NVWxeqPodnV0dhZp/DWWIV
X-Google-Smtp-Source: AGHT+IGZ+lmxXja+GoAPxQwL4swrkay6ZFiMO9ILlsGYk9JzFpUDMDe194GI0keIbXvZxJ+fmaLndg==
X-Received: by 2002:ad4:4207:0:b0:67a:2940:6f45 with SMTP id
 k7-20020ad44207000000b0067a29406f45mr12353197qvp.21.1701277321078; 
 Wed, 29 Nov 2023 09:02:01 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com.
 [209.85.160.180]) by smtp.gmail.com with ESMTPSA id
 em15-20020ad44f8f000000b0067a543e6379sm2139136qvb.75.2023.11.29.09.02.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 09:02:00 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-423d8761eeeso12292181cf.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:02:00 -0800 (PST)
X-Received: by 2002:ac8:590d:0:b0:423:74a6:f83f with SMTP id
 13-20020ac8590d000000b0042374a6f83fmr18604602qty.10.1701277320152; Wed, 29
 Nov 2023 09:02:00 -0800 (PST)
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
In-Reply-To: <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
From: Dennis Gilmore <dgilmore@fedoraproject.org>
Date: Wed, 29 Nov 2023 11:01:47 -0600
X-Gmail-Original-Message-ID: <CAABkxwsMjTQt3uZhdui91RoswHxS=i49AuXP1Cmjb4nF7_oaOQ@mail.gmail.com>
Message-ID: <CAABkxwsMjTQt3uZhdui91RoswHxS=i49AuXP1Cmjb4nF7_oaOQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: neil.armstrong@linaro.org, Peter Robinson <pbrobinson@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
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

A big benefit of using the full dtb in u-boot means it can be used to
boot the system without the need to load a replacement file from disk
or elsewhere, which, AFAIK is required for the System Ready standards
and it definitely helps in cases like EFI booting.

Dennis

On Wed, Nov 29, 2023 at 10:37=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 29/11/2023 16:34, Caleb Connolly wrote:
> >
> >
> > On 23/11/2023 07:04, Sumit Garg wrote:
> >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.or=
g> wrote:
> >>>
> >>>
> >>>
> >>> On 22/11/2023 14:27, Tom Rini wrote:
> >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>
> >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> >>>>>>> Hi Caleb,
> >>>>>>>
> >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@lina=
ro.org> wrote:
> >>>>>> [snip]
> >>>>>>>> =3D=3D DT loading =3D=3D
> >>>>>>>>
> >>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
> >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a seco=
ndary
> >>>>>>>> bootloader, so we can instead rely on the first-stage bootloader=
 to
> >>>>>>>> populate some useful FDT properties for us (notably the /memory =
node and
> >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with th=
e memory
> >>>>>>>> map changes above, this let's us entirely avoid configuring the =
memory
> >>>>>>>> map explicitly.
> >>>>>>>
> >>>>>>> Since with this change, we don't need to embed FDT blob in the u-=
boot
> >>>>>>> binary, so I was thinking if we really need to import DTs from Li=
nux
> >>>>>>> for different platforms and then play a catchup game?
> >>>
> >>> For now, yes.
> >>
> >> But why? Is there any value added by larger u-boot specific DT (most
> >> of the nodes being unused by u-boot) than what currently u-boot
> >> supports? The more important part is to get alignment with Linux DT
> >> bindings. If you need to have memory/reserved-memory nodes in u-boot
> >> DT for generalization purposes then you should import those particular
> >> nodes only.
> >
> > I've been thinking about and hacking on this for the last week or so,
> > sorry for the delayed reply here.
> >
> > The value is in preventing any of the existing bindings from regressing=
,
> > and simplifying the bringup process for new platforms (just copy
> > SoC/PMIC DTSI and write a minimal board DTS to enable the needed hardwa=
re).
> >>
> >>> There are quite a few features which aren't handled by
> >>> U-Boot that it shouldn't need to handle (rpm/h resources for example)=
.
> >>> Also the fixed-regulator / regulator-gpio binding differences.
> >>
> >> IMO, we should fix them first and then use Linux DT as it is.
> >
> > The biggest blocker here is USB, on sdm845 and the 4 new platforms I
> > have working, I only support USB high speed, this requires removing the
> > superspeed phy and adding a DTS property.
> >
> > I tried using OF_BOARD_SETUP to make this changes during boot but this
> > approach really isn't scalable (and I couldn't find a way to make it
> > work anyway).
> >
> >>
> >>>
> >>> I would definitely like to move towards supporting Linux DT directly,
> >>> but this approach gives us a nice middleground of minimising the U-Bo=
ot
> >>> specific DT parts.
> >>
> >> I don't see any real benefits here apart from the maintenance burden.
> >> If it had been an actual Linux DT then that can be passed to Linux as
> >> it is. However, the current modified import you are trying to do
> >> doesn't solve that purpose as well.
> >
> > Ensuring that we don't introduce non-standard bindings (by using Linux
> > DTSI) is one benefit, simplifying new platform bringup is another.
> >
> > The amount of work required to switch to upstream DT is too much to
> > block this series on. We can work on improving the situation there once
> > we have these Qualcomm improvements upstream and new boards added. I do
> > admit that this is quite an awkward middle-ground, and I would not like
> > it to last for too long.
>
> I'm a real supporter of targeting support of unmodified (or very slighly)
> Linux DT, having a reduced version of the Linux DT will be a pain at each
> sync, and you'll need to do this manually.
>
> Simply having to copy the Linux DT without any changes will make sure you
> are in sync with Linux's bindings, and will help making sure you'll boot
> unchanged Linux DTBs you get from previous loaders.
>
> And in bonus, you'll be able to chain it to the next loader like EFI.
>
> So I don't see why any work toward this goal is useless, and if an
> intermediate step is needed, let's do it.
>
> Neil
>
> >
> >>
> >> -Sumit
> >>
> >>>>>>>
> >>>>>>> IMO, the build command would look like following if we import
> >>>>>>> pre-built FDT blob from Linux:
> >>>>>>>
> >>>>>>> - Build u-boot::
> >>>>>>>
> >>>>>>>          $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> >>>>>>>          $ make qcom_defconfig
> >>>>>>>          $ make
> >>>>>>>
> >>>>>>> - gzip u-boot::
> >>>>>>>
> >>>>>>>          gzip u-boot-nodtb.bin
> >>>>>>>
> >>>>>>> - Append dtb to gzipped u-boot::
> >>>>>>>
> >>>>>>>           cat u-boot-nodtb.bin.gz
> >>>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> >>>>>>> u-boot-nodtb.bin.gz-dtb
> >>>>>>>
> >>>>>>> This would avoid the maintenance burden to keep DT in sync with t=
hat
> >>>>>>> of Linux. And since DT bindings in Linux are backwards compatible=
, we
> >>>>>>> can say u-boot should work with DTB picked up from any Linux kern=
el
> >>>>>>> stable release.
> >>>>>>
> >>>>>> I guess one question I have is, are we being passed the device tre=
e
> >>>>>> (since we're acting like the Linux Kernel)
> >>>>>
> >>>>> Yeah that is the case here, see patch #1 in this series regarding h=
ow
> >>>>> FDT address is being retrieved from previous stage bootloader (ABL =
on
> >>>>> sdm845 and qcs404 SoCs).
> >>>>
> >>>> That's what I thought.
> >>>>
> >>>>>> or knowing that we have the
> >>>>>> dtb attached to the end of us and making use of the old kernel app=
ended
> >>>>>> dtb option? We're fine in for example the rpi_arm64 case of just b=
eing
> >>>>>> given a device tree from the previous stage and not needing one in=
-tree.
> >>>>>
> >>>>> That's good to know and we can replicate that for Qcom platforms wh=
ich
> >>>>> are chainloaded and don't need an embedded DT.
> >>>>
> >>>> So yes, moving these towards the direction of rpi_arm64 and specific=
ally
> >>>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force t=
hat
> >>>> the dtb must be provided to us) sounds like the right direction to t=
ake
> >>>> these platforms
> >>>>
> >>>
> >>> --
> >>> // Caleb (they/them)
> >
>
