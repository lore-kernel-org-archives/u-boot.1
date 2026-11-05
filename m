Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A8606A32C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nfJbi6NR;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=RNFS4kkQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D148C60778;
	Thu,  5 Nov 2026 15:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT3I3574qIvW; Thu,  5 Nov 2026 15:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 046B960721
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793893173;
	b=CUTm0h/WbsgwfBqBEsD3oHYI/zLmP0+j+sTOgArmP01NI5ZmdPjieETs9erVvfGBqe2J
	 qApjtaczSya6674AgSgkvwR68F6Dgo8AUOPxv7+cNZY4+PC44932cQM+STd1973ymeLUX
	 sTVpwnUdWkh0QG8QZW/T+eXWLiCnZ2LlJ9UznbQvYcB5yVlWOOM7NFAGLlgSWNHDyox2c
	 JKtAdoFsh+nf6SwM8fzjNYXz8pwvZH2pAtrvfWSZPLyC7u+ecLdIq3MfPkMdb0T2uX3Sx
	 kzUKlEJYFFXkxb1p1PctCMZzDdFjRTo669HuilQzvK94WbgLQz/FgwEWFzMPdU4t7nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793893173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ExV4rB9L32lDatv22Zqy52/z8+qlJaij7PVpV5j9zyM=;
	b=S+gEpNFr92L/+8f069Rv453LxO4WY/Xlc4zT+PPT/lzzrHkxQlyL+9iy+ovgjJVj/En4
	 QIX3zBGfR+ZKSNHzUKPQw2i6V6nlAg1Ovi9ihWbH+TVtHJGQc+rN5rJAMHBiNiimdfy7n
	 0az9gl4lEk67xRkyfoDvPyQpIY/tZUNNILL+Cose1AWCxA0Ptmg2cwnGMAVNmF5SjXscN
	 9XnrdlYHc7MQwpSlhyow2BmxZfAb2GjMZFPW4PSLooP3v8uX5lr1DdCLwLvChWxPFVJOl
	 sNOgsmqb37XuXH85usc+foqrBHwzpyKR6G1Irh6G5JvGn4EgMJRxQIU2Prp/QS5yilg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=RNFS4kkQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793893173;
	bh=ExV4rB9L32lDatv22Zqy52/z8+qlJaij7PVpV5j9zyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfJbi6NR/KPQYAuL0hmtNhZzCI2/j+Mwr6iXzKBEuYaJ9e8HDZffCL9KApPcL1d7K
	 3kCz71JGhbD1wX+fkMPunaQC9zSIwdjuRMoW4HcXf7txuQFxJi7y5Aw9qNxyXuu5nQ
	 GLAe0w+iNz0Y1canO9zyepNY/ztbVJutz5WF3Sk1QufHDuWYiPVvJMYfGhexwhDc4w
	 3eLR4eDwhO330oVQ5W716MlwdO+3MKy6xWvwtFxe1CRp1LxjlndZb1q6zy0kaU4f+S
	 fmqR3269las3iG5Hfamav246dmksSXgkzCz8LuBfL/OkRr632a99NaOOg1LteidqOh
	 jmvjs3zeTgd7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 046B960721;
	Thu,  5 Nov 2026 15:39:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B5D11B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B84960721
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWMmpI6WXpsk for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 15:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9987460697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=RNFS4kkQ
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9987460697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 15:39:30 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-675617e81f9so1763653d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 07:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793893169; x=1794497969;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExV4rB9L32lDatv22Zqy52/z8+qlJaij7PVpV5j9zyM=;
 b=RNFS4kkQW3ZZnP7BaHkP/AFBTS92pniWD4eR2sNhuSayQaoEP/ehdtfMkjXkdhEo0e
 2oxSYzSEY3SxLlPC8sUTdUUiXSuKow/dGc/gURLyw8/GHpi9h0YcryzhQCZGsEo2PlOb
 x+PajeqWCZfshCP0vavEDbBAg1U0wwFqQTTu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793893169; x=1794497969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ExV4rB9L32lDatv22Zqy52/z8+qlJaij7PVpV5j9zyM=;
 b=2NYWCmxPeNaVANDo8O3hd8k5Xr7DfGn+mqeFHMEl1usvW2tQvQFGsq25VWcBX4CP8c
 OxiwRDcPfKe46zlqlfaHmkrnteRN4MUL8SQqGE8AM8TaPQpV7UOqqvBeifbmaWUCeqiu
 vOut3Fc8taN8TqH3abhUpraBiTB6I1R0IHdIG5qzjr1tm6kFHfdwAnHA10+iMXGOg+bm
 PJpDBcBbHkZ/e223QEvvrsDDeaYASvdhvQMowkBbPrJ4BO74V6rBFRzIrymmuv2AqsUW
 ozHIUneaf1c8r+lUBZgEn7G4xsaYb4hUIL9/Pec99G7TdPEF66tbPXB6n/dvUTdAUxhA
 X5pA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4Gc9PLWUjQ5u7JIn4rvjndPYpG3gH4qzW/HEIKQrMJHAGgQUgTakEwT5SaB2JwPCEB3McbWc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+2vHR4H+UvRgU8kdbrDbzIPmiBWNI1jDqESDCbzvHTds53RhPV
 qRH51bBMqfr/BH8Z51sRU5/T6LXIRghXimPkImh+7Nj7j74BBlVzB2n1ujtBkolFdTB5Y+KaUOX
 nK6FiUoGUALEAwbs46n49+U6Rrq8RLvDz1EzprJgKWA==
X-Gm-Gg: AYBFou0NwweSfVGBpfcn00Sh6LujrAhChOog4sxP2S8h8BfXPQERRqut13vG93fpAxj
 jzVFZzUfpCP2pC8EKi2LwlCzGtSdM9Yl0vNekobzQlJS2fdhm+txAfg+7C7tjr3Xxrx/NudjDpo
 VLWfzQ0HpYdaBVdGhWh+Z/vlhncmOflKQt7YcMWQP2LRy0r2svLb4Ho325JVcXwoKyscwsl9N39
 kefI8BtNunvZrf5WBii6lwyHUrlYcmJ8r5+KGQXFOiKofSYKbsIP2Uy+weLoqFbpVu2Q8JSddBf
 F9Ytz40BgL/h2NS8b2MSXPPc2CcVZ9eFa2aI8Q3zyPUlOAIyBiotQg2m8ISf9TcEtcHYnCYqB3f
 J6p3yK15igruD5Q4VJELerga6T6Uwl/w/oq+r8bF52fQIywU8m+VkSWpizFVHJxZXmSVsF8CaOL
 r1udBCgThx6xk=
X-Received: by 2002:a05:690e:b86:b0:679:9fde:25db with SMTP id
 956f58d0204a3-67ba500cc09mr12521786d50.93.1793893168801; Thu, 05 Nov 2026
 07:39:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
 <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
 <20261105144835.GM1164024@bill-the-cat>
In-Reply-To: <20261105144835.GM1164024@bill-the-cat>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 5 Nov 2026 16:39:17 +0100
X-Gm-Features: AclHuK945_5pi7BCDCf_VUaFLVg4XFhHAMX6H80gZKDuOC-6odiTXw-U8FJjXJQ
Message-ID: <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
Subject: Re: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, 
 michael@amarulasolutions.com, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Thu, Nov 5, 2026 at 3:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 05, 2026 at 08:12:07AM +0100, Dario Binacchi wrote:
> > Hi Tom,
> >
> > On Wed, Nov 4, 2026 at 8:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
> > >
> > > > This series adds support for the Engicam MicroGEA-STM32MP257D-RMM
> > > > board, with its RGB and LVDS displays and the FWU A/B update.
> > > >
> > > > The first patches pick the board devicetrees, merged for Linux v7.4=
,
> > > > from devicetree-rebasing. They can be dropped if dts/upstream is sy=
nced
> > > > with v7.4-dts first. Then come the fixes, the refactors moving the
> > > > STM32MP2 environment and FWU support to the SoC code, and the board
> > > > support.
> > >
> > > What's the status on upstreaming all of the changes you're putting in
> > > the -u-boot.dtsi files? Thanks.
> >
> > The -u-boot.dtsi contains:
> >
> > - U-Boot specific nodes and properties: the environment partition, the
> >   FWU metadata and the bootph-all properties.
>
> bootph is to be upstreamed,  I don't recall where the FWU stuff ended
> up, and I'd need to double check the specific environment binding you're
> referring to.

I added the bootph-all properties to the -u-boot.dtsi because I saw
the same in the other STM32MP25 boards, e.g. the stm32mp257f-ev1. If
they should go to Linux instead, I will send them for this board.

The FWU metadata node and the environment partition use bindings which
are only in U-Boot: doc/device-tree-bindings/firmware/fwu-mdata-gpt.yaml
and u-boot,mmc-env-partition in doc/device-tree-bindings/config.txt.
They are not in dt-schema yet. Both are also used in the -u-boot.dtsi
of the other STM32MP boards.

>
> > - The RGB and LVDS panels, with the LTDC and LVDS endpoints. These are
> >   already upstream in Linux, but in two devicetree overlays, one per
> >   display. Since the display is selected by the "display" environment
> >   variable, which is stored in the eMMC/SD and is not available yet
> >   when the U-Boot control devicetree is set up, both displays are
> >   described here and the board code keeps only the selected one.
>
> You can't detect and apply the overlay instead?

No, the displays can't be detected. There is no EEPROM or other ID on
the board or on the displays indicating which one is connected. That is
why the selection is left to the user, by the "display" environment
variable. Since the environment is in the eMMC/SD, it is only loaded
after relocation, when the devices are already bound. Is there a way
to apply an overlay to the control devicetree at that point that I
missed?

Thanks and regards,
Dario

>
> > - The LTDC "lcd" clock for the RGB output. This is not upstream yet:
> >   I sent it in an RFC series [1], and Gabriel is reworking the STM32MP2=
5
> >   SYSCFG pixel clock support, which should cover it. I will drop it onc=
e
> >   it is merged in Linux.
>
> OK, thanks.
>
> --
> Tom



--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
