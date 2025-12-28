Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C5ED3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 13:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7995B83A41;
	Sun, 28 Dec 2025 14:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="hNHEzFfN";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxidtQOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E77839DF; Sun, 28 Dec 2025 09:13:12 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE6E8392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 09:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=niklas.soderlund+renesas@ragnatech.se
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BFEC57A0113;
 Sun, 28 Dec 2025 03:13:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 28 Dec 2025 03:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766909589;
 x=1766995989; bh=pCoJls5bidibTMlc9oNrjkkFdEV2CM3UxYDbQ/rGaFg=; b=
 hNHEzFfNnOPXdyGHG5XV+DfqYB67ddNvepEPBgrLz4v00CECLV5NMaRnBtNpKkiu
 KIqwWEEmFtrkBaPywoDAPvYECYwRoHKoTfA6lzsnupMuqKEEGeSUluCkE/aKPkQD
 TD7m7XIkb+H/MOODgaq2F78xBh+lyM/zQNZpidwGTxGoubRv73uX04Ikzo4cCIw0
 PhDw/wev+k5T+I10XzoqDIG3aCxgQdzTxZe5QpAVHlXBEDGEJ0AkMqYShv+fNphx
 QxgUE9nw6rfJr4OqNq0TKFJbwrH7wasWlBW6VBfrrIIyb4hyg6gqAxYZrM8WTuaj
 fXEy6QyzbHfEYF0H+8TlnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1766909589; x=
 1766995989; bh=pCoJls5bidibTMlc9oNrjkkFdEV2CM3UxYDbQ/rGaFg=; b=v
 xidtQOHCtGKQETES8vmpgA+thsZ1HDOciMxRzd+yNCImk3rz1s87GpnGpZy2hGGI
 Hz0AU44J7soAEoy80U0gaCJmBJ/ZFMA0ycFE7Ke4ncCx/HWz6Yj5NoUPGRu0jfDr
 g4mUaLQmOIZwQx/UgiF2GlO74uDM4VYfxplfFlX04rFx1hpV+e7mP0A8pVTK7d+y
 +xlVZ0Ky4vB5vKoUcvQorFwaRDEjBro3KSZrW7l1LjyEv+EWj65DHi+Hnya04yHH
 QNVYU5FGL761Cz9TKbyKxbmGMkINqYY0uejE3FLrh0f1EfdZdhj1Y23IYSD5QlZh
 PBnhWWh0zSzCWl152yfaA==
X-ME-Sender: <xms:leZQabioNerp4klD1IAJV-yXaM5jND09Hk71krrd64DQNic3jbrChQ>
 <xme:leZQae4MOyORv3lvb1boR5wSkanYrlMCglyvs1TUywC-TXJuLs-hmH-JxMkCMWNz3
 dRyTNvGW4hGesvvB7cKo3CS1-XPRJ34V905Yyx6IYaZPtSu3y9XQw>
X-ME-Received: <xmr:leZQaTboPAAmePDkha64U-z15gf5ab2EyJUV4bwi5_1jeGp8DNjS5Om5JlkDV721_3UFEZI7l_aMJ4_pkOvwJ_e5KkswSsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejfeejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
 ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrg
 hssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepfefhleelhfffjefg
 fedugfegjeelhfevheeikefhueelgfdtfeeuhefftddvleeinecuvehluhhsthgvrhfuih
 iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhu
 nhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohephe
 dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthesmhgr
 ihhlsghogidrohhrghdprhgtphhtthhopehifigrmhgrthhsuhesnhhighgruhhrihdroh
 hrghdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepthhrihhn
 iheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrd
 guvghngidruggv
X-ME-Proxy: <xmx:leZQaT6N-D1UTiZFTbvpZUbID7mnHnYkmhBoWfK5PRb7dbZWyzP_2Q>
 <xmx:leZQaWCU99-5AmSWh9UwS6yG3vYHR1xzqVCZbM7_AJ1JiHCjH06MNg>
 <xmx:leZQaZfGNNi08nwlgEh2XnHSBj8J1bXDMuWaj8pCuFfZRzVTCtQvKg>
 <xmx:leZQaVKAUdRBrbFqkJEi5JS_yS4LSsbhpypcX7AzbNreq-VckNmTdQ>
 <xmx:leZQafdx8Mv-TWX7j9atS6GftZQV_Upj-u1K7OG-pnHwuq7BQtWxmgDo>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 03:13:09 -0500 (EST)
Date: Sun, 28 Dec 2025 09:13:08 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] clk: renesas: Do not disable realtime modules on
 R8A77995 D3
Message-ID: <20251228081308.GC1315338@ragnatech.se>
References: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228010327.2836161-3-niklas.soderlund+renesas@ragnatech.se>
 <a0c985d7-9a8e-4820-89d1-5f491247869e@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0c985d7-9a8e-4820-89d1-5f491247869e@mailbox.org>
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

On 2025-12-28 03:04:35 +0100, Marek Vasut wrote:
> On 12/28/25 2:03 AM, Niklas Söderlund wrote:
> > Later versions of the datasheet makes it clear D3 do not have any
> > realtime module stop control registers (RMSTPCRx). Remove the
> > manipulation of them from the module clock table to match this.
> > 
> > Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > ---
> >   drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
> >   1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> > index 0a59a19cb227..736812e04d0b 100644
> > --- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
> > +++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> > @@ -216,18 +216,18 @@ static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
> >   };
> >   static const struct mstp_stop_table r8a77995_mstp_table[] = {
> > -	{ 0x00210000, 0x0, 0x00210000, 0 },
> > -	{ 0x03e01000, 0x0, 0x03e01000, 0 },
> > -	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
> > -	{ 0xc00014df, 0x400, 0xc00014df, 0 },
> > -	{ 0x80000004, 0x0, 0x80000004, 0 },
> > -	{ 0x40d20004, 0x0, 0x40d20004, 0 },
> > -	{ 0x08c0008c, 0x0, 0x08c0008c, 0 },
> > -	{ 0x09941c18, 0x0, 0x09941c18, 0 },
> > -	{ 0x00801087, 0x0, 0x00801087, 0 },
> > -	{ 0xf143dfc0, 0x0, 0xf143dfc0, 0 },
> > -	{ 0x063e1820, 0x0, 0x063e1820, 0 },
> > -	{ 0x00000000, 0x0, 0x00000000, 0 },
> > +	{ 0x00210000, 0x0, 0, 0 },
> > +	{ 0x03e01000, 0x0, 0, 0 },
> > +	{ 0x000e2fdc, 0x2000, 0, 0 },
> > +	{ 0xc00014df, 0x400, 0, 0 },
> > +	{ 0x80000004, 0x0, 0, 0 },
> > +	{ 0x40d20004, 0x0, 0, 0 },
> > +	{ 0x08c0008c, 0x0, 0, 0 },
> > +	{ 0x09941c18, 0x0, 0, 0 },
> > +	{ 0x00801087, 0x0, 0, 0 },
> > +	{ 0xf143dfc0, 0x0, 0, 0 },
> > +	{ 0x063e1820, 0x0, 0, 0 },
> > +	{ 0x00000000, 0x0, 0, 0 },
> >   };
> >   static const void *r8a77995_get_pll_config(const u32 cpg_mode)
> 
> You likely also need this part to avoid any RMSTPCR access:

Indeed, thanks! I will respin when we agree about the bits in 1/2.

> 
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c
> b/drivers/clk/renesas/renesas-cpg-mssr.c
> index 39ff4541c1e..4b07dbb3277 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -127,7 +127,8 @@ int renesas_clk_remove(void __iomem *base, struct
> cpg_mssr_info *info)
>                                 info->mstp_table[i].sdis,
>                                 info->mstp_table[i].sen);
> 
> -               if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4)
> +               if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4 ||
> +                   renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77995)
>                         continue;
> 
>                 clrsetbits_le32(base + RMSTPCR(i),

-- 
Kind Regards,
Niklas Söderlund
