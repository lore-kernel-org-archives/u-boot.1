Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D19C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 15:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01B682DB7;
	Thu, 17 Apr 2025 17:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JS33SRMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6E982D21; Thu, 17 Apr 2025 16:54:12 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04BA82CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 16:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20DA743A37;
 Thu, 17 Apr 2025 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744901649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40vIGiNyH1XQiRP8m//B+x50dB7xhh5d09ejxnsBGhs=;
 b=JS33SRMSOiZy9VmgqBEFWjZC7RGMnaXOhrGWGZd+7zNZ41NFzZG5nJa/pexW+oKxyfGacz
 kHb4lxoOlWSZ5wPCqPcsA8h4akQLNODZteJfAj187aFW98JYb+Xs21K5VUUb7Fsj4Pm00K
 2xBayYegRc7peZ1vNrcjG2X5F+OLbXy4Iu1DmwbO74VlgmjUz8DJM85KDtx5qPIiFE6CfN
 Zv4Pg1/hOI7JKGjINyGGPnlX9z0nXTDDdQ3ExT4CWYoumYmJVfvA5SQzycclRaIls/Zb/y
 8ADBfzW4+hawphEdcMJAOVuNRSGB1J+LsFQFAPXQNtJFxbmAzlReCg89rVvmrg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Heiko Schocher <hs@denx.de>
Cc: Fabio Estevam <festevam@denx.de>,  "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: imx8mp: pci enumeration fails with current HEAD
In-Reply-To: <c533393a-ca65-49a4-55a5-77bcb3cf589d@denx.de> (Heiko Schocher's
 message of "Thu, 17 Apr 2025 16:37:39 +0200")
References: <c533393a-ca65-49a4-55a5-77bcb3cf589d@denx.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 17 Apr 2025 16:54:08 +0200
Message-ID: <87fri6q1nz.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeeftdefledvieegvdejlefgleegjefhgfeuleevgfdtjeehudffhedvheegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehhshesuggvnhigrdguvgdprhgtphhtthhopehfvghsthgvvhgrmhesuggvnhigrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvg
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 17 Apr 2025 17:35:41 +0200
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

Hello Heiko,

On 17/04/2025 at 16:37:39 +02, Heiko Schocher <hs@denx.de> wrote:

> Hi Miquel,
>
> I have here an imx8mp based board for which I just prepare mainlining.
>
> pci enumeration works fine with U-Boot 2025.04
>
> u-boot=3D> pci enum
> PCIE-0: Link up (Gen1-x1, Bus0)
> u-boot=3D>
>
> and tftp through the ethernet interface works fine.
>
> Using current HEAD
>
> * 5b4ae0f3f04 - (origin/master, origin/HEAD) mailmap: update my name and
>   email (vor 2 Tagen) <Casey Connolly>
>
> It breaks with:
>
> u-boot=3D> pci enum
> nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on pcie-phy@32f=
00000: -110.
> pcie_dw_imx pcie@33800000: failed to power on PHY
> u-boot=3D>
>
> git bisect dropped your patch:
>
> 197376fbf300e92afa0a1583815d9c9eb52d613a is the first bad commit
> commit 197376fbf300e92afa0a1583815d9c9eb52d613a
> Author: Miquel Raynal <miquel.raynal@bootlin.com>
> Date:   Thu Apr 3 09:39:05 2025 +0200
>
>     power-domain: Add refcounting
>
>     It is very surprising that such an uclass, specifically designed to
>     handle resources that may be shared by different devices, is not keep=
ing
>     the count of the number of times a power domain has been
>     enabled/disabled to avoid shutting it down unexpectedly or disabling =
it
>     several times.
>
>     Doing this causes troubles on eg. i.MX8MP because disabling power
>     domains can be done in recursive loops were the same power domain
>     disabled up to 4 times in a row. PGCs seem to have tight FSM internal
>     timings to respect and it is easy to produce a race condition that pu=
ts
>     the power domains in an unstable state, leading to ADB400 errors and
>     later crashes in Linux.
>
>     CI tests using power domains are slightly updated to make sure the co=
unt
>     of on/off calls is even and the results match what we *now* expect.
>
>     As we do not want to break existing users while stile getting
>     interesting error codes, the implementation is split between:
>     - a low-level helper reporting error codes if the requested transition
>       could not be operated,
>     - a higher-level helper ignoring the "non error" codes, like EALREADY=
 and
>       EBUSY.
>
>     Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
>
> reverting this patch, and it works again fine for me!

That's right, this patch made assumptions that are wrong, I am very
sorry about that. In my understanding there was a power_domain structure
per ID, but in practice there is only one per node, so when two consumer
devices point to the same node that has #power-domain-cells =3D <1> it
fails to power up the second power domain. I tested this patch using the
imx8mp video pipeline (which works fine), and I wasn't using PCI on it.

It's been reported:
https://lore.kernel.org/u-boot/20250403-ge-mainline-display-support-v6-0-47=
8b5e3dd872@bootlin.com/T/#m68e9d16204a61450084324b99fd571d95932ece0
https://lore.kernel.org/u-boot/20250403-ge-mainline-display-support-v6-0-47=
8b5e3dd872@bootlin.com/T/#me570681ae3cf6c42cd45912de15cb968af55be28
And the patch is being reverted:
https://lore.kernel.org/u-boot/20250417115311.1905411-1-w.egorov@phytec.de/=
T/#u

> Do you have a imx8mp based hardware with pci?

I do not have PCI on the board I am using for testing, but now that my
attention has been focused on the power domain counting issue I managed
to observe the problem by alternately enabling lcdif1 and lcdif2 which
share the same power domain node.

> Can you (or anyone else with an imx8mp based hardware with pci) approve
> this on a similiar HW?
>
> I try to dig into it, but may you have a fast idea!
>
> Okay, thought about it ... it tries to power on "blk-ctrl@32f10000"
> driver:/drivers/power/domain/imx8mp-hsiomix.c
>
> imx8mp.dtsi:
>                         hsio_blk_ctrl: blk-ctrl@32f10000 {
>                                 compatible =3D "fsl,imx8mp-hsio-blk-ctrl"=
, "syscon";
>
> which has several different power domains ... and your patch prevents to
> enable more than one of them ... adding some debugs shows:
>
> u-boot=3D> pci enum
> [...]
> power_domain_on_lowlevel(power_domain=3D00000000fe5942f8) blk-ctrl@32f100=
00 priv->on_count: 0
> power_domain_on_lowlevel(power_domain=3D00000000fe5942f8) blk-ctrl@32f100=
00 power_domain->id: 4
>
> Here pwoer domain id
>
> #define IMX8MP_HSIOBLK_PD_PCIE_PHY                      4
>
> gets enabled and on_count increases...
>
> imx8mp_hsiomix_set: ------------ power_domain->id: 4 IMX8MP_HSIOBLK_PD_PC=
IE: 3 4
> power_domain_on_lowlevel(power_domain=3D00000000fe5d2408) power-domain@17=
 priv->on_count: 0
> power_domain_on_lowlevel(power_domain=3D00000000fe5d2408) power-domain@17=
 power_domain->id: 0
> power_domain_on_lowlevel: ret: 0
> power_domain_on_lowlevel(power_domain=3D00000000fe5d2480) power-domain@1 =
priv->on_count: 0
> power_domain_on_lowlevel(power_domain=3D00000000fe5d2480) power-domain@1 =
power_domain->id: 0
> power_domain_on_lowlevel: ret: 0
> imx8mp_hsiomix_set: ------------ power_domain->id: 4 IMX8MP_HSIOBLK_PD_PC=
IE: 3 4 END OKAY
> power_domain_on_lowlevel: ret: 0
> power_domain_get_by_index(dev=3D00000000fe5b2410, power_domain=3D00000000=
fe594458)
> power_domain_on_lowlevel(power_domain=3D00000000fe594458) blk-ctrl@32f100=
00 priv->on_count: 1
> power_domain_on_lowlevel(power_domain=3D00000000fe594458) blk-ctrl@32f100=
00 power_domain->id: 3
>
> Now power domain
>
> #define IMX8MP_HSIOBLK_PD_PCIE                          3
>
> should be enabled, but since your patch this gets prevented as "priv->on_=
count: 1"
>
> imx8_pcie_phy_power_on: ------------ pad_mode: 1
> imx8_pcie_phy_power_on: ------------ pad_mode: 1 ret: -110
> nxp_imx8_pcie_phy pcie-phy@32f00000: PHY: Failed to power on pcie-phy@32f=
00000: -110.
> pcie_dw_imx pcie@33800000: failed to power on PHY
> u-boot=3D>
>
> I have not a fast solution, may you have an idea? I try to look
> after the easter holidays into it. May we need for each power_domain-> id=
 such
> an on counter...

I fully agree with your observations and conclusion, I was hoping for an
easy fix but the fact that the power domain uclass would not retain any
useful data nor know how many sub-domains there are is a bit difficult
to workaround.

This needs to be thought deeper, I will report whenever I have an idea
how to do it, for now you can revert the patch locally (or wait for the
upstream proposal to get in), and do not hesitate to share your findings
if you have an idea on how to handle that properly.

Sorry for the breakage,
Miqu=C3=A8l
