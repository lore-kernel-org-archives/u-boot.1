Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B5DC3601E
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 12:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA318295C;
	Fri,  4 Apr 2025 14:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pRaSVBtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A68828D0; Fri,  4 Apr 2025 08:30:26 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB04D8283E
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 08:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB7D543349;
 Fri,  4 Apr 2025 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743748223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbPi+pT60GIxbM6LfO4mtFKLGdLmok0nJ+qEZYcsMB4=;
 b=pRaSVBtrg6nLFqm8IcqIOdrYaRsty5q2xAGHpcjn97D5CkZLaRGkLDYrHq9roJjWNXNFOr
 nnFgVdw3jzE50bncgLMYvmnXYktq64Ue8uBzdP2KordVlOT9pLWH3byBeQ8yFc2mZNhFSH
 3/xrqShl4UV0aIg4OKWwpBzuwz3IT91+lDZSmHNZwGnMzKCrGFNTwgRN9KjtKPNdaJp5mW
 cP0NYH5PMTCUK84kSEpIAFEXXSfGA/T9kUKeOx/FIZ9HM17dv9S9+z3wXhxXZb5RBDHD02
 0IPrC2MF8ZbmdPcv8UjGB2JkIZfNAPlVWth85TzDiZBJVKtI/VeRMEbCpWJX5g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Fabio
 Estevm <festevam@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Mario Six
 <mario.six@gdsys.cc>,  Svyatoslav Ryhel <clamor95@gmail.com>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v6 09/12] imx: power-domain: Add support for the
 MEDIAMIX control block
In-Reply-To: <CAHCN7xKD8AODyDNSz21aO5kDJD1FygKUcsfXsCXV+K59VdgWDw@mail.gmail.com>
 (Adam Ford's message of "Thu, 3 Apr 2025 07:57:53 -0500")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-9-478b5e3dd872@bootlin.com>
 <CAHCN7xKD8AODyDNSz21aO5kDJD1FygKUcsfXsCXV+K59VdgWDw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 04 Apr 2025 08:30:21 +0200
Message-ID: <87plhszbeq.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeeftdefledvieegvdejlefgleegjefhgfeuleevgfdtjeehudffhedvheegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeelvddrudekgedruddtkedrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrdegledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghfohhrugdujeefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheplhhukhhmrgesuggvnhigrdguvgdprhgtp
 hhtthhopehsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghguhhsthesuggvnhigrdguvgdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 04 Apr 2025 14:35:35 +0200
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

Hi Adam,

>> +       /* Enable upstream clocks */
>> +       ret =3D clk_enable(&priv->clk_apb);
>> +       if (ret)
>> +               goto dis_bus_pd;
>> +
>> +       ret =3D clk_enable(&priv->clk_axi);
>> +       if (ret)
>> +               goto dis_apb_clk;
>> +
>> +       /* Enable blk-ctrl clock to allow reset to propagate */
>> +       ret =3D clk_enable(clk);
>
> I am only offering a suggestion if you ever need to push another rev.
> It appears that all the clocks are either on or off and if any fail,
> you immediately turn off any clocks that were enabled.  There are some
> bulk clock options where you can basically tell the driver to turn
> them all on or all off.
>
> clk_get_bulk, clk_enable_bulk, clk_disable_bulk, and clk_release_all
> are the functions I am thinking of.  Your imx8mp_mediamix_priv
> structure could then replace all the individual clocks with struct
> clk_bulk.
>
> That might shrink the overall code and simplify the readability.

These bulk functions only work if you get all clocks from a list. We
currently do not want all the clocks (simply because some are useless in
this case and also because they have not yet been defined). The clks
property define all these:
"apb", "axi", "cam1", "cam2", "disp1", "disp2", "isp", "phy";

>> +       if (ret)
>> +               goto dis_axi_clk;
>> +       setbits_le32(priv->base + BLK_CLK_EN, reset);
>> +
>> +       /* Power up upstream GPC domain */
>> +       ret =3D power_domain_on(domain);
>> +       if (ret)
>> +               goto dis_lcdif_clk;
>> +
>> +       /* Wait for reset to propagate */
>> +       udelay(5);
>
> On Linux, the GPCv2 driver was updated to increase a delay from 5 to
> 10 uSeconds [1] .  I don't know if that's needed here, but it's
> something to consider.

Thanks a lot for the pointer, I will integrate this change, even if it
is experimental, let's spare ourselves a round of ghost bug hunting.

> adam
>
> [1] -
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/pmdomain/imx?h=3Dnext-20250403&id=3D2379fb937de5333991c567eef=
d7d11b98977d059

Thanks!
Miqu=C3=A8l
