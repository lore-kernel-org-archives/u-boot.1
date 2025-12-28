Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06426E8FDBE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 13:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39FA0839D5;
	Sun, 28 Dec 2025 14:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="EUTGDEPy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0f94ovL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FCF839DF; Sun, 28 Dec 2025 09:12:32 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C558392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 09:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=niklas.soderlund+renesas@ragnatech.se
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BFD027A00F5;
 Sun, 28 Dec 2025 03:12:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 28 Dec 2025 03:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766909547;
 x=1766995947; bh=687ue5WUDoCbb5BuxfrTjpPSlkvYMKzyKEWIAkJdKvY=; b=
 EUTGDEPysz3JrHvK4CaQ5y/XThwXv6UA4fgftvqyerQD3wAcvSfZQVgPnKQiJMdg
 CxWTxvFEpyVvlq/N7y/NT72oiFD25PZOEUfy83OpkzwGfThPnll++g53qnDHOhqi
 ywwvbIgaP26URi7nsAlgcPm96fYMgTNTJ6hRNcOu/GlCjmxgT/0mgGRjc6BsDgTd
 d8HY4M7EUkF5inSw371GEsEk+GHq2lr36HHQekM4MBS/Tckmu57jBOqEHLGqrDz/
 QzS4AevPtjkQFbPaZE1sUB7fB72d5lCh6+xu/xiBUtMA27pgcbtzboWCB3Bn0V1B
 8Sv7G0X70VGFt3nEc5RpFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1766909547; x=
 1766995947; bh=687ue5WUDoCbb5BuxfrTjpPSlkvYMKzyKEWIAkJdKvY=; b=b
 0f94ovLCFrpHxm0C7GWXgfZSP1UXNQ5N70dSSGCICXDBq8x4CDdCxL8QNYnTqbXM
 JvfE+QousUwf8sGx1/+TjCKt/Rf5CuSyoegg0XEFDhEyRE5eE9235km0MryfTqJ9
 gp1KNpUmaUqbfbmL4Sb7UYP9qqvemSFH3VbaOFhngCPPr9gYGaFxYKiE+agw3+qD
 2T6+JbTZTazFP6ZVla9agGlcOtZA8A54LEAjX2GNrUQNCNkvdwotoRgW4yoi9mTs
 tsgTVO/ZT9FPNyuiQrrcDM99A0f2A6gT0gvIAemqlQ/BbC/HLVjye4p5nSLCqyBa
 P0ThFS6phVR4y4U4aJ3mA==
X-ME-Sender: <xms:a-ZQaUDDlCpJhG8h1gXWcKTm-rq4ihcqmXWbOhIPsxcYL1fcuBHzUg>
 <xme:a-ZQadaI72I-3OrZqFOYuu_vp8VuHR7ER369FHR1tJu13xvABFLGc19pnpYFfreTP
 iu9z9uuZFulAfkuLF1f01t6-PGosREkymwTAnpifzMehAhmrRzDjw>
X-ME-Received: <xmr:a-ZQaf4ZSLFuxY2fxzHXMU-KF9mmlkuhYHccOV88o5JvzDvgH3stVeqgtJoIwHMw3gHytTXjWPukRrSr9nSyG-EYToHZbDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejfeejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
 ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrg
 hssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepfefhleelhfffjefg
 fedugfegjeelhfevheeikefhueelgfdtfeeuhefftddvleeinecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhu
 nhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohephe
 dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthesmhgr
 ihhlsghogidrohhrghdprhgtphhtthhopehifigrmhgrthhsuhesnhhighgruhhrihdroh
 hrghdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepthhrihhn
 iheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrd
 guvghngidruggv
X-ME-Proxy: <xmx:a-ZQaWZv1gJ87griLJWqa3SqS13izqyAxWxBPrLpRci9VFJItNaGLw>
 <xmx:a-ZQaWjPgDhK1wb_ySK1PR2fnNCOTK_WPRYlUj6mlnUniMGrj2QJkQ>
 <xmx:a-ZQaf8YDDEBuaoLgL8BmDKKjtcC6e9t0_mJcX7fUsl8u4JvV-sdcg>
 <xmx:a-ZQaZoG6UN8GhvxRsniB1AK0AG6QlRqZ7StY4l0lSM5W9K9n5azqQ>
 <xmx:a-ZQad8pj1x0Hhk4iil-uuvSmSx4z0_ZQOGNIoRg26ijSfAjsfQOUfBx>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 03:12:26 -0500 (EST)
Date: Sun, 28 Dec 2025 09:12:24 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] clk: renesas: Do not enable MSTP4 modules on
 R8A77995 D3
Message-ID: <20251228081224.GB1315338@ragnatech.se>
References: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228010327.2836161-2-niklas.soderlund+renesas@ragnatech.se>
 <49554065-2782-43f8-b298-ef575d6355ae@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49554065-2782-43f8-b298-ef575d6355ae@mailbox.org>
X-Mailman-Approved-At: Sun, 28 Dec 2025 14:43:53 +0100
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

On 2025-12-28 03:03:31 +0100, Marek Vasut wrote:
> On 12/28/25 2:03 AM, Niklas Söderlund wrote:
> > Since commit a2bd99549c61 ("clk: renesas: Tear clock controller down
> > last before booting OS") enabling the module gated by bit 8 in MSTP4
> > prevents Linux from booting. Furthermore bits 8 and 7 of MSTP4 where
> > only documented in early versions of the datasheet and have since been
> > removed, do the same in the driver to allow Linux to boot.
> > 
> > Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >   drivers/clk/renesas/r8a77995-cpg-mssr.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> > index f49faa47cb37..0a59a19cb227 100644
> > --- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
> > +++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> > @@ -220,7 +220,7 @@ static const struct mstp_stop_table r8a77995_mstp_table[] = {
> >   	{ 0x03e01000, 0x0, 0x03e01000, 0 },
> >   	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
> >   	{ 0xc00014df, 0x400, 0xc00014df, 0 },
> > -	{ 0x80000004, 0x180, 0x80000004, 0 },
> > +	{ 0x80000004, 0x0, 0x80000004, 0 },
> Should we disable both BIT(8) and BIT(7), or only the BIT(8) that hangs the
> system ?

I think we shall remove both as the datasheet removes both, no?

-- 
Kind Regards,
Niklas Söderlund
