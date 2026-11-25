Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0426606A688
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vPZw4Qgt;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=KJvua3Sv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46CA180AE6;
	Wed, 25 Nov 2026 08:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDhApPhI7CvB; Wed, 25 Nov 2026 08:53:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8059880AC6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795596802;
	b=Zogtgr6mff8kEF1vshPWl5A4HXj9ISDU8/ye55eSm+wcnqsnwuYglCXBMnF3LVmB6DT1
	 WQju/1zosfUFBJE1DWin7gj/sUS+o0lsX9TzBAZm5z8KyOQmIGi+v5Xvb4D7EW8JmIbjU
	 Et5xzFkMWusBBAtUrxzsiGOOWDlzvpzLG9szeV6HP+PYD1IT644FbPKvIWJVa8EubwAAN
	 zBWhX+wkfFcUR1DnlavoxUELV6ezWZzrAxZSbmJGAEHyfGy+UbGA9nPdPEVarOo+63zHV
	 KCf9loQPogmdBqcq2E12b7UznfBZnJnuXz7p/9V0IjcY5io4E3WqRxss3/0sqmtrOUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795596802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XJ0HzaFmRyELTpJGgAG3x06aGsEPDOsaN/mKeUwnRPM=;
	b=JAsytPQJliyahnrplKh9gvxHK6o3mlQjsZmAV+0/14b/ao2L2hDXh3fpgyHPYKPd24xO
	 slbf+zyEu6DDkU3yzdWBNeEPPafYmfkuI5z2ypIoXGUpalgnBdFUcD7WbD0o15Mw8xmm3
	 liykevLf1XdpVcy4l7foYlgr2bGoc95OLiXLz3RKmbb9BpCIkDDsys6RxSsqgKqQtXWA5
	 WOMnR2WcSv4XB/LgcH94vk6VWMp0OqHuTff4WjxRZFSfg6G9sieOFSqgOZNnuXUJmN3v8
	 onu16pkaAFh2hvDabEtWuuUbWng2iXELfHRvsbf5JURytylEZQyRYIlJSB6wGgDczcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795596802;
	bh=XJ0HzaFmRyELTpJGgAG3x06aGsEPDOsaN/mKeUwnRPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vPZw4Qgt+hJcerhPtuYzJ4ZaCUc5weCOughYLfLKrSEjgsKaYNz4acn5+s/WdMZLt
	 nJ/7RqkTiC3W+EMiV62Nk9NvwsdXBDq5L7ySlnOEqYQox2NQKfyAaRVjeaNDfinED8
	 zKCCJPsCDsehE3MTO6234DRbHMtKjjldHd2wYPjvIojkCd0kDjytR8Q5ITyfK863b3
	 Vk5MSyLcyoeT9Izu6Vtaf1/IwHzH+Pm29mwahxOnjvPtov7eEs0v+3/C3QRaRg+gI3
	 rPKNhfj6r+bj4w9Q1xT/NdHWwGMvWez6iVm3KWVCCVtxiYh2VZscw5URaNUEyT7AE9
	 F9bwLUBMLxkTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8059880AC6;
	Wed, 25 Nov 2026 08:53:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A3E02F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8051340643
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46b14eetuRxG for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 08:53:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 58AD7405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=KJvua3Sv
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58AD7405CF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:53:19 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b4f4095a7aso47254967b3.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795596798; x=1796201598;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XJ0HzaFmRyELTpJGgAG3x06aGsEPDOsaN/mKeUwnRPM=;
 b=KJvua3SvfIBHGAdjCa9zetbJmRtvN5tM+R+o3LoGM85GASzlkk+APOUrGOp/SlbSFJ
 erKI3l63wSwa3R5ZY9p/ui8amwCa14wayLfbrV7jsX92CZrnXhM+sGEphw+ZJQKiVeLY
 ZR4cFVgb//VYdsHvf8o6w32acAWKxLqbRfKSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596798; x=1796201598;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XJ0HzaFmRyELTpJGgAG3x06aGsEPDOsaN/mKeUwnRPM=;
 b=hfRboOooqWnd3fFcyl4ANgNmy/kxxala8iUQotckB70E1QcKSYT6VPiC66oE3+gNzs
 xyLb/FXDWm6tuhhuOveGMY/mD1y1JzuxICvFMmiGZ864CHJIPMKBroSVkVe9th7rExAn
 T+jlWXr9ylSudNUMR02YrKiASD0mXw/vnydhL1fklLUmG/yEDHozz3a+otVgVf4f3roK
 CFERAo2140Th7th8NkYIwYcYF62dJRZkxzlyVjAA6B19/09HlqBeEUYMXH1dOpbRPVfu
 0n7w6i8/llGU3U7fkY6g9hjslbwrC7tdrWHEC+kO/ztG8E8TS1XRlBv/Trk5lL04kM97
 Lgdw==
X-Gm-Message-State: APuU4Z+c9J2IPmp9zb4EHfTCfEcoqnn2fHE+XPXY3YY+Q0AWfV6l90uN
 EYK71+/zWffTp/FbYG8aMcz390+ThZ7GKkc/FDzMMLamYxb0HhEg57S454AVmokdTiIk3t7mSpE
 EWbpkRyUP4WKj5yhiMhvtXSp1quotyq1+yfDpuiAcqw==
X-Gm-Gg: AZFdTZcUX3/WcRNajv4JUy869Npz+y4HIRDEIrtJwaH6JAzUIjitcU4CXUZ4aiC1xM1
 bOC7n5wp9wyV/tdvaqa/80p71j4UPgGB9GsRr01m4i492zEBgMJAoEagHjgrbuxjs49qanPQVkN
 Yuii8yLuPa8jK+IIsA3/R6Wi0bnBSLjgh27JlR0kiHgKjPTGTnqg1C5K4R1/7E2wM2qxSiZwJ3m
 mumIJHLGbu0U+SQ0DenP40WO4KljyLzgmvYF3p+sFzWJiyVM1lDFXqt1+L24KMjfO+ZC36kdOcq
 Sgjn77TigOfnWuVordnrYAPiS7yDbOPWX5sKfw9yZ2GoZOZGSAk6NXmRnAbyl8haCcG+5bAU+UJ
 WKVBeH3vW+sGNgp0u7WhjFJY/r3SWLg+i6/6T5Hg3enDCf51Csv+LkC7kWK20gWMWDQ==
X-Received: by 2002:a05:690c:2a90:b0:8b4:cc58:78d6 with SMTP id
 00721157ae682-8b52046e501mr74541477b3.19.1795596797950; Wed, 25 Nov 2026
 00:53:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121123451.2471185-3-dario.binacchi@amarulasolutions.com>
 <20261125003129.18729-1-peng.fan@oss.nxp.com>
In-Reply-To: <20261125003129.18729-1-peng.fan@oss.nxp.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 25 Nov 2026 09:53:06 +0100
X-Gm-Features: Aa3M54p1b8GYRxVvUlJKOEBK6J_mV9eGnTHIBJqEtSFHXRA3wLfpbim3h54l5n0
Message-ID: <CABGWkvqiZcO0u736+_UR0VG939m68-hoe8MUpy496_cC5npNpQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/25] clk: imx8mn: register the main_axi, noc and gic
 clocks as critical
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peng,

On Wed, Nov 25, 2026 at 1:34=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> On Sat, 21 Nov 2026 13:33:52 +0100 Dario Binacchi <dario.binacchi@amarula=
solutions.com> wrote:
>
> > From: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > The main_axi, noc and gic clocks feed the system interconnect and the
> > interrupt controller, and must never be gated. Register them as
> > critical, as Linux does, so that their parent PLLs are kept running.
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > Changes in v2:
> > - Reword subject and commit message to describe the change
> > - Fix the coding style of the new clocks
> >
> >  drivers/clk/imx/clk-imx8mn.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.=
c
> > index 2dfa860bf375..56d44192e35e 100644
> > --- a/drivers/clk/imx/clk-imx8mn.c
> > +++ b/drivers/clk/imx/clk-imx8mn.c
> > @@ -29,10 +29,19 @@ static const char * const imx8mn_a53_sels[] =3D {"o=
sc_24m", "arm_pll_out", "sys_pl
> >                                              "sys_pll2_1000m", "sys_pll=
1_800m", "sys_pll1_400m",
> >                                              "audio_pll1_out", "sys_pll=
3_out", };
> >
> > +static const char * const imx8mn_noc_sels[] =3D {"osc_24m", "sys_pll1_=
800m", "sys_pll3_out",
> > +                                            "sys_pll2_1000m", "sys_pll=
2_500m", "audio_pll1_out",
> > +                                            "video_pll_out", "audio_pl=
l2_out", };
> > +
>
> sys_pll1/2 are fixed clock. I not see the point of switching mux for noc/=
gic/axi to other parents.

The patch doesn't switch their parents, they stay as the SPL left them.
The parent names are only what the composite clock needs to be
registered, the same as in Linux.

The point is the enable count. The rate of sys_pll1/2 is fixed, but
they are gated by clk_disable() like any other clock. On this board
main_axi and gic run from sys_pll2 and noc from sys_pll3, but since
they are not registered nothing accounts for them. When the display
clocks are reparented to video_pll, the last registered user of
sys_pll2 goes away, the PLL is turned off and the system hangs.
Registering the three clocks as critical, together with patch 01,
keeps their PLLs enabled, as in Linux.

Thanks and regards,
Dario

>
> Regards
> Peng




--
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
