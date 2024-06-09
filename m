Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE00C27C53
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 22:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2BD888189;
	Mon, 10 Jun 2024 00:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a9KXeqAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC7A883DE; Mon, 10 Jun 2024 00:48:13 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A8387CF1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 00:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dfa4876a5bbso3518679276.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717973290; x=1718578090; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+zt417gDLZt/yBInw29vAt8JvUqRy/+WomQMdzX5Ag=;
 b=a9KXeqAC/evZIoqZd1rJ3+PYsl0YEuou1fTL1BRzNCb/RSdWi8dl/iD/obA5dwrdEG
 1JU5aOvttpvsdaGudRGdjCSK7n4aSNJeyYcVI33wfkVEsd1BYGu3HmQnre9jqBfGbFKn
 s5AkiMJc2/pZFpChQNxcOicB6Ibf1OMyfmXSydVyXFtwb3j4IrPMFeXUqL119zMXEOHC
 ZuC2OLvFDzgd37dy3IEu1TvbnzF5v9mpO0wiWDeRR0nk8SXNs7a74V50ihKMnPxHI6Bo
 qox9axqXnWhyw2w7yd62yxk3e2EMHU8g1RX/26ADWLm1Ea/mykbg6xPFeG/GOL8kXG1w
 tUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717973290; x=1718578090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+zt417gDLZt/yBInw29vAt8JvUqRy/+WomQMdzX5Ag=;
 b=VubCFn/Bx6PovhCCahbGpRoLbSq0sBP+Evxzq5jDFt38dMMXbhI7bEX04fNBeAECSw
 LJGK+o2loukV/moIJuYBGNuWOzvc2iFrBy0Sq4h9W83EjYdRkoVm3ld+F9tTlT4/vVcq
 wknzlhrlbEcT4gXqekTflLIRAMhlnune9fYY7HfSUwKwA8GnbJzV6d2TsKudMzxhdg29
 WlkS9nFfxblnpS0wX8IC8h+F+Dh6EXybd5eBXhAT+ZI97L5Zr44FSFkxtya18xf9q6e0
 EwQZz5iqeuake5ZPKiUSLsGUpHMqncldfATzkoXBJQUOrSEUPebz8DqMfoBtZWAqqTtr
 yDbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVESZASBrLby2F2qY5V8As136H/LuCjcsrZphBsKS2Y9kIeDyN2Ia4fHV1nwVYshUM9nQAgBPI5X/ab/12DDiq/qlM1FQ==
X-Gm-Message-State: AOJu0YyXAFjxdblMetpcOVns0GHYDHXjLb8dcwvCC7W+Wbd9cHvHOWHJ
 3HrrGhVPjR1HoN+WuSKcD/GuC2nw9uBoOKm9i4HGKptUwsRCjHOUzQ9m/0iA4ww+BEkXqpEtUuY
 BZsSI5Pz8sYGa8+SlMpt0T6UXUwBwjUc6YiCFQQ==
X-Google-Smtp-Source: AGHT+IH1CjNeK63Nc19W6YzAxbtJuKCdBGAIkN2UIPZ1CP4tmiVXt4XHA3zfi1GRq0PF2ImZb21eF3DQpn/LL/YKMI0=
X-Received: by 2002:a25:6890:0:b0:dfb:538:df1d with SMTP id
 3f1490d57ef6-dfb0538e1a2mr5828460276.43.1717973290059; Sun, 09 Jun 2024
 15:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-7-semen.protsenko@linaro.org>
 <475aea46-a255-4a55-9e1f-29ee028996f5@cherry.de>
 <CAPLW+4kRnT0kHWtU+s9u2oUf6GYs+-BMyr8P3hGcqbPAst_=ww@mail.gmail.com>
 <7efa7845-62d7-4b23-8d04-1204fd9a8895@cherry.de>
In-Reply-To: <7efa7845-62d7-4b23-8d04-1204fd9a8895@cherry.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 9 Jun 2024 17:47:59 -0500
Message-ID: <CAPLW+4mV4cdTmzaBOrN-KLayusa0Oh85NKe=5F+E4krjMEwbUQ@mail.gmail.com>
Subject: Re: [PATCH 06/42] mmc: dw_mmc: Extract clock on/off code into a
 separate routine
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
 uboot-snps-arc@synopsys.com
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

On Mon, Jun 3, 2024 at 3:52=E2=80=AFAM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
>
> Hi Sam,
>
> On 5/30/24 2:06 AM, Sam Protsenko wrote:
> > On Thu, May 23, 2024 at 9:36=E2=80=AFAM Quentin Schulz <quentin.schulz@=
cherry.de> wrote:
> >>
> >> Hi Sam,
> >>
> >
> > Hi Quentin,
> >
> > Thanks for reviewing this series! My answers are below (inline).
> >
> >> On 5/23/24 1:30 AM, Sam Protsenko wrote:
> >>> Extract clock control code into a separate routine to avoid code
> >>> duplication in dwmci_setup_bus().
> >>>
> >>> No functional change.
> >>>
> >>
> >> There are some differences though.
> >>
> >
> > With everything discussed below, I guess it still can be argued that
> > this patch doesn't change the functionality of the driver? Depends on
> > definition though. Please let me know if you don't like this bit and
> > I'll remove it in v2.
> >
> > [snip]
> >
> >>> @@ -439,35 +461,19 @@ static int dwmci_setup_bus(struct dwmci_host *h=
ost, u32 freq)
> >>>        else
> >>>                div =3D DIV_ROUND_UP(sclk, 2 * freq);
> >>>
> >>> -     dwmci_writel(host, DWMCI_CLKENA, 0);
> >>> +     /* Disable clock */
> >>>        dwmci_writel(host, DWMCI_CLKSRC, 0);
> >>> +     ret =3D dwmci_control_clken(host, false);
> >>
> >> Here, CLKENA and CLKSRC are swapped. The kernel still calls CLKENA
> >> before CLKSRC, is this really safe? (I have no documentation so cannot
> >> tell). E.g., we could have CLKSRC register be a way to select the cloc=
k
> >> parent/source, 0 could be 24MHz crystal for example, so switching to
> >> this new parent before disabling the clock output would likely result =
in
> >> glitches?
> >>
> >
> > Yes, you are right. In fact, Exynos850 TRM specifically mentions this.
> > Here is how TRM describes the whole procedure for "CIU Update":
> >
> > 8<------------------------------------------------------------->8
> > To prevent a clock glitch, ensure that software stops the clock when
> > it updates the clock divider and clock source registers.
> >
> > Software uses the following sequence to update the clock divider settin=
gs:
> > 1. Disables the clock.
> > 2. Updates the clock divider and/or the clock source registers.
> > 3, Enables the clock.
> >
> > Code Sample to Update CIU:
> >
> > // Disable clock
> > while (rSTATUS & (1 << 9));
> > rCLKENA =3D 0x0;
> > rCMD =3D 0x80202000; // inform CIU
> > while (rCMD & 0x80000000);
> >
> > // Update divider and source
> > rCLKDIV =3D clock_divider;
> > rCLKSRC =3D clock_source;
> >
> > // Enable clock
> > while (rSTATUS & (1 << 9));
> > rCLKENA=3D 0x1;
> > rCMD =3D 0x80202000; // inform CIU
> > while (rCMD & 0x80000000);
> > 8<------------------------------------------------------------->8
> >
> > It's an overlook on my part. And although CLKSRC reset value is 0x0
> > and it's only being written with 0x0 in the driver, it still has to be
> > fixed. I'll move CLKSRC modification below CLKDIV to make it look like
> > TRM suggests.
> >
>
> Did you mean "move CLKENA before CLKSRC"? Because if the clock is
> disabled, I don't think the order in which the parent clock and its
> divider are set matters?
>

Yes, in v2 I'll just pull CLKSRC modification down, so it's executed
after disabling the clock, as recommended in TRM. Something like this:

8<------------------------------------------------------------->8
        /* Disable clock */
-       dwmci_writel(host, DWMCI_CLKSRC, 0);
        ret =3D dwmci_control_clken(host, false);
        if (ret)
                return ret;

        /* Set clock to desired speed */
        dwmci_writel(host, DWMCI_CLKDIV, div);
+       dwmci_writel(host, DWMCI_CLKSRC, 0);

        /* Enable clock */
        ret =3D dwmci_control_clken(host, true);
8<------------------------------------------------------------->8

> > Linux kernel implementation also doesn't follow the sequence
> > recommended in TRM as you can see, but it works fine because CLKSRC is
> > always written to 0 there (and it's also 0 at reset time).
> >
>
> OK, so wrong logic but it works because we essentially never change
> CLKSRC so it's virtually a no-op and thus there are no change to the
> parent clock when the clock is enabled, resulting in no glitch. Not sure
> we should ignore the improper logic though? What are you suggesting we
> do here?
>

Yes, exactly. As for the possible actions, I'd say it'd nice to fix it
in kernel too, though I kinda see it as a very minor issue right now.
Not sure if I can find the time to do that soon though.

On a philosophical note: I'm sure a lot of drivers don't follow the
sequences intended by the hardware exactly, but they still work
because IP core design is permissive enough. Over the years I found
peace with that somehow :)

> >>> +     if (ret)
> >>> +             return ret;
> >>>
> >>> +     /* Set clock to desired speed */
> >>>        dwmci_writel(host, DWMCI_CLKDIV, div);
> >>
> >> Same here, CLKDIV is set now after the CIU is informed, is this an
> >> issue? We may want to set the clock speed before we enable the clock
> >> again. Right now it's setting the desired speed while disabled, inform
> >> the CIU, enable the clock, inform the CIU. This now does, disable the
> >> clock, inform the CIU, set the desired speed, enable the clock, inform
> >> the CIU. We may need to wait for the clock to stabilize before enablin=
g
> >> it? Again, just making guesses, no documentation for me here :/
> >>
> >
> > In this case, my implementation is following TRM (as described above).
> > After CLKDIV modification my code informs CIU again, inside of the
> > dwmci_control_clken() call.
> >
> > Just to be thorough, here is what TRM says about DWMCI_CMD_UPD_CLK (bit=
 21):
> >
> > 8<------------------------------------------------------------->8
> > ...Following are the register values transferred into the card clock do=
main:
> > * CLKDIV
> > * CLKSRC
> > * CLKENA
> > 8<------------------------------------------------------------->8
> >
> > So you are right that each time this bit is set all 3 values are being
> > transferred to CIU. But because that bit is set two times (before and
> > after updating CLKDIV/CLKSRC) -- it's ok. And also this way is
> > recommended in TRM, as stated above.
> >
>
> Hopefully there aren't other implementations than Exynos 850's that need
> to do something else :)
>
> Aside from the improper logic, looks good to me, can you please add this
> information to the commit log so it's not lost in the mailing list :) ?
>

Yes, will do in v2 (going to submit it today). And will also add some
related comment in the code. If you don't mind, please add your
"Reviewed-by" tags where possible in v2, to keep the ball rolling :)

Thanks for reviewing!

> Thanks,
> Quentin
