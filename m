Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C41606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iP9ZRLu3;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=lWM/ZDKn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C80DF81468;
	Sat,  7 Nov 2026 14:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DzLKC0w8DvM5; Sat,  7 Nov 2026 14:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B70A681421
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061755;
	b=M6fUD3tEk7s+6ud0Uf/tJb5F1zgfCDG5QuA7cvK9Li7zhmRnaSJq1mPiq4ApkhzJkK3Y
	 uRZNbPmdtSKoNLVo440gEYnRsAMpvd5dNenQtBCUz/2UBpRLSarB1GFC/1ufI5/CsbEpe
	 d74vHCZ6807Vdo7ncDUzn/Rft9ChIAOnJfljzKqVCzBQZ/n9RZhq0JaUAb+ZJz18j8QDg
	 0ndPUFJley+Z/T7sms3wZrxg/ee5YAapUYsuzwQPZPIaMontqvuriQKeXe7d5Y5ZtAVUi
	 fpqxMJj51MRlFFRgTiSIkeTXE89T/33OX4bxsqYp+HnrdUsn1khQtuv+6AS6rMWo0OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hQsMun9o7H3Bf/y+O2hCOBvYN2RA/SjNNgsBWQvTRVM=;
	b=GrX0qGLEJYPc0+3T5CUm4JGWkJ/8JZMhFaqFQfcgMavTf8g3ybvEuxv5c6BnsZYRPFJu
	 xeMZc76lJvauCPcgCL4jjYwDA2hKrE28E4t1V0PQbufYMEFjYIPNyKH0PcaHESA5Sopdk
	 4xKWWAWubtB9cM2raqRuxdq4SZwzSvuJy5N6KXj2OoUN3gFpeJfQwqhg9OsnmavcNtE1G
	 3MdK6NrjtP7iM4O9hLhysTxaU2P0QodwpawRJcIOzXr+cXnXeklxDgb+p3NydtESTkTrf
	 lmzJBXavfhn33JzmQI8sflLH0Xble/0t4hPQ1Zt1USzS1d4FRnVJ9YeoVBZpogNEPEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="lWM/ZDKn";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061755;
	bh=hQsMun9o7H3Bf/y+O2hCOBvYN2RA/SjNNgsBWQvTRVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iP9ZRLu3FXo9SCje+DvW6lMjKtP8XMMVubytX9d7JeJFQ2QahI4+r6rao2xUBB5EG
	 Ns5Djq4zihd4ugvr71NjoYX8uMUBN1gCY/mbc1dsN0EzJzRIpwWBbeWWA9lFyd+M2D
	 oMmFF4Cv40JN+yPkbXWrHoGVzvQcn0OY/InqzeJfb1g+JSNuki3/yn5sVgmr5Ozo4+
	 ElmrJtP6pGFlU0068PIDyBABzFocLIsAKA06YRlPX3eku04byFWsuMMO2uVwdidrsA
	 9aHhYMNwIEf/i8K+UDBL7/nLPF37GYSj3zXM6t4Wn1PXb1WdsJ2SMjEsAe2X3A1L2x
	 TnHvSYDvQqBqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B70A681421;
	Sat,  7 Nov 2026 14:29:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AFC137D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 508C681414
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7QBF4MZaHNSn for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D2B181360
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=lWM/ZDKn
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D2B181360
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:29:12 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6798af41644so1268301d50.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061751; x=1794666551;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hQsMun9o7H3Bf/y+O2hCOBvYN2RA/SjNNgsBWQvTRVM=;
 b=lWM/ZDKnEzGhcIeTF81juGyBkVRJeFCg9ROpBY9ASXqBUhq5m8/aKF65s2+UiUl2FT
 ZPl4cfpddBBYEETgQqHC0DmUZHUMtem62A67IQVMfpZw0dliMOj5OhzXqXtwwqgfb60Z
 uf+bCQCa8Nb5KdxBPtE9zXBPhdkSGmdyjzOvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061751; x=1794666551;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hQsMun9o7H3Bf/y+O2hCOBvYN2RA/SjNNgsBWQvTRVM=;
 b=0J/m9ht2ybV/wsvYliyqyKyGjd0/Jh+PtkwVK1Sxk+CByVtqA32w7D9EwyknLuXmb5
 xdXWDJUhh5YuX3md6zJpYRiEjy0ET0bgacLu/F0alOSrRSiQ7o5O9SMONngYm0WWvcHB
 /g5DFL9rWRYMr76L10auy99GoznF3coD4iWi8/VWk/43SWHKhi2uQWGZXkllbhpvWYCP
 oNcdkrdkb3QkEALBYiwEBgO9anS+WqFRasOELCqhTrdIWGWPmd3WzlTRCUukWaesMDEK
 SJ36bMgrn6PB8xbDYZcz5hyhnEtNHLVLDat1Gi64xF2+l9MAPyPZfmHdQyO7XJVzj4w8
 260w==
X-Forwarded-Encrypted: i=1;
 AL+hErHozTumVKv9aJifuLWxAvmKXvbBWeASEdvNVDyHrmFTZWoLZ/HgsiFtzL0KSxRkXnfrHwt646o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8GOwOab6ER9U0Qqf/Zc7YSzh5QAdWFTSEJc3liqGNwp/z0Qo09
 bNqBRVgIuDMPRaIBNcR9TT/u4+UwxsSfpVosMpKwaTVm/jSZasIJzqPAqjIbPGTCXGRKuNm71gr
 mbqpk74rGd/hEodpkz/SFMQ+bX1tk8XYbHLkh9DSsew==
X-Gm-Gg: AYBFou0Pr4yrOf/qUajYsX7HBtwxvEpvrKme/nOmHIDHB7ylDcRwgI3T1qXHnOVF7ls
 7Iz5hp58Lnvh23/7yw2UyKMaC4E6BQtqpEkNPlcXs4eeSrM5vtus649kB0VYRiL7+yq6x/ynjQ6
 lPyRCCRHw18nBw7Xrj52F9yw9hmhFeULfKwi513IVIN2qrBGIAF8JN7vQeItKzoyZ1r4UYJ2/rk
 gJxsek9+TNq2yfGitNAzmM2Bfi+fjFjXcwGG8B1heCfO2ajdR7OXcziSJC+rat8HDVTNCowISM7
 rXKj83q72sW6jVPSCSxwI5KOzELGThuxnbha0zWNrEiKxs2ccj3Tw3uaGaHje0KgjQNtWXbYFMY
 FJ8r6FD7CyCCXI2NE8/CaZ+zTH4liBO6yN/YYwzxN51rgaz1KPM3wvm61JSskgpWdor2N/ALV1m
 aYCFY84BnQ7jE=
X-Received: by 2002:a05:690e:4091:b0:679:ab13:552d with SMTP id
 956f58d0204a3-67c1441af4dmr3198725d50.48.1794061748568; Sat, 07 Nov 2026
 06:29:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
 <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
 <20261105144835.GM1164024@bill-the-cat>
 <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
 <20261105172616.GN1164024@bill-the-cat>
In-Reply-To: <20261105172616.GN1164024@bill-the-cat>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 7 Nov 2026 15:28:57 +0100
X-Gm-Features: AclHuK8vWe-UzdilgKMyldFIvYIaDvSa5Z_4nW76VPtn93_ZL0FBOR0_4iUo-Bg
Message-ID: <CABGWkvpbBG2zrPDz7Fx766TdE07YHae1KnJ-+ReqGF2CRzyydA@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 6:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 05, 2026 at 04:39:17PM +0100, Dario Binacchi wrote:
> > Hi Tom,
> >
> > On Thu, Nov 5, 2026 at 3:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Thu, Nov 05, 2026 at 08:12:07AM +0100, Dario Binacchi wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, Nov 4, 2026 at 8:21=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > > >
> > > > > On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
> > > > >
> > > > > > This series adds support for the Engicam MicroGEA-STM32MP257D-R=
MM
> > > > > > board, with its RGB and LVDS displays and the FWU A/B update.
> > > > > >
> > > > > > The first patches pick the board devicetrees, merged for Linux =
v7.4,
> > > > > > from devicetree-rebasing. They can be dropped if dts/upstream i=
s synced
> > > > > > with v7.4-dts first. Then come the fixes, the refactors moving =
the
> > > > > > STM32MP2 environment and FWU support to the SoC code, and the b=
oard
> > > > > > support.
> > > > >
> > > > > What's the status on upstreaming all of the changes you're puttin=
g in
> > > > > the -u-boot.dtsi files? Thanks.
> > > >
> > > > The -u-boot.dtsi contains:
> > > >
> > > > - U-Boot specific nodes and properties: the environment partition, =
the
> > > >   FWU metadata and the bootph-all properties.
> > >
> > > bootph is to be upstreamed,  I don't recall where the FWU stuff ended
> > > up, and I'd need to double check the specific environment binding you=
're
> > > referring to.
> >
> > I added the bootph-all properties to the -u-boot.dtsi because I saw
> > the same in the other STM32MP25 boards, e.g. the stm32mp257f-ev1. If
> > they should go to Linux instead, I will send them for this board.
>
> Yes, there's many examples of needing to upstream this still.
>
> > The FWU metadata node and the environment partition use bindings which
> > are only in U-Boot: doc/device-tree-bindings/firmware/fwu-mdata-gpt.yam=
l
> > and u-boot,mmc-env-partition in doc/device-tree-bindings/config.txt.
> > They are not in dt-schema yet. Both are also used in the -u-boot.dtsi
> > of the other STM32MP boards.
>
> OK, thanks.
>
> > > > - The RGB and LVDS panels, with the LTDC and LVDS endpoints. These =
are
> > > >   already upstream in Linux, but in two devicetree overlays, one pe=
r
> > > >   display. Since the display is selected by the "display" environme=
nt
> > > >   variable, which is stored in the eMMC/SD and is not available yet
> > > >   when the U-Boot control devicetree is set up, both displays are
> > > >   described here and the board code keeps only the selected one.
> > >
> > > You can't detect and apply the overlay instead?
> >
> > No, the displays can't be detected. There is no EEPROM or other ID on
> > the board or on the displays indicating which one is connected. That is
> > why the selection is left to the user, by the "display" environment
> > variable. Since the environment is in the eMMC/SD, it is only loaded
> > after relocation, when the devices are already bound. Is there a way
> > to apply an overlay to the control devicetree at that point that I
> > missed?
>
> Maybe? How far down the path did you try going for using overlays here?
> And then also, since both of the overlays are upstream, is there a real
> penalty in applying both and then doing the fixup you do to remove the
> unused one?

In v2, which I am about to send, a new option,
CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS,
applies the upstream overlays for both displays to the U-Boot
devicetree at build time, and the board
code keeps only the one selected by the "display" environment variable.
The panels are no longer described in the -u-boot.dtsi.

As for the bootph-all properties, I sent them to Linux [1].

So the -u-boot.dtsi now contains only:
- the environment partition and the FWU metadata, which use U-Boot
specific bindings
- the bootph-all properties, until [1] is merged
- the LTDC "lcd" clock, until the pixel clock support [2] is merged

[1] https://lore.kernel.org/all/20261107141353.2228391-1-dario.binacchi@ama=
rulasolutions.com/
[2] https://lore.kernel.org/all/20261028135915.2665857-2-dario.binacchi@ama=
rulasolutions.com/

Thanks and regards,
Dario
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
