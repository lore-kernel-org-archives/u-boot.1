Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356DFE9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 10:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B70383AA9;
	Wed, 18 Feb 2026 11:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9440483B99; Wed, 18 Feb 2026 11:45:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 959F080050
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F871477;
 Wed, 18 Feb 2026 02:45:11 -0800 (PST)
Received: from localhost (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013243F62B;
 Wed, 18 Feb 2026 02:45:17 -0800 (PST)
Date: Wed, 18 Feb 2026 16:15:14 +0530
From: Sughosh Ganu <sughosh.ganu@arm.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, jose.marinho@arm.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leonard Anderweit <l.anderweit@phytec.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 5/6] tools: Add support for fwumdata tool
Message-ID: <aZWYOv6nAASD_dQk@a079122.arm.com>
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
 <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
 <aZWKyl6r8BphaePp@a079122.arm.com>
 <aZWM0_v4eUgKLTSz@a079122.arm.com>
 <20260218113116.3c447668@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218113116.3c447668@kmaincent-XPS-13-7390>
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

On Wed, Feb 18, 2026 at 11:31:16AM +0100, Kory Maincent wrote:
> Hello Sughosh,
> 
> On Wed, 18 Feb 2026 15:26:35 +0530
> Sughosh Ganu <sughosh.ganu@arm.com> wrote:
> 
> > On Wed, Feb 18, 2026 at 03:17:58PM +0530, Sughosh Ganu wrote:
> > > On Mon, Feb 16, 2026 at 02:35:35PM +0100, Kory Maincent wrote:  
> > > > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > > > (Firmware Update) metadata from Linux userspace. It provides functionality
> > > > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > > > metadata, change active/previous bank indices, modify bank states, and set
> > > > image acceptance flags. Configuration is done via fwumdata.config file.
> > > > 
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > ---  
> > > 
> > > I am not sure if this has been discussed with Ilias earlier, and
> > > apologies if it has been, but I do think that this patch is not
> > > adhering to the DEN0118 specification, specifically the part mentioned
> > > in section A3.2.1, which says that the metadata is to be maintained by
> > > the Update Agent. I would like to hear from Jose Marinho, who is the
> > > author of the spec, on what he thinks about this approach.
> > > 
> > > I do think that the other patches in series look fine, and can be
> > > applied. There is just an issue of inclusion of the tool for
> > > building. I will comment on that patch separately.  
> > 
> > 
> > Adding Jose to the discussion.
> 
> We indeed already had some discussion about it with Ilias. 
> https://lists.denx.de/pipermail/u-boot/2025-December/605924.html
> 
> It seems ST deviate from the original idea behind the standard. It does not use
> EFI neither update capsule.
> TF-A is managing the selection of the boot partition (FIP image: OPTEE +
> bootloader) according to the FWU metadata content and is dealingwith the
> rollback mechanism. Linux through this tools is the update agent to select the
> boot image.

Okay. I guess that is fine then -- with the Update Agent residing in
Linux, this is not an issue. My next question then would be, why are
you adding this to U-Boot then :). Can this not be bundled with a
related package of RAUC maybe(if one such exists)?

-sughosh

> The final goal is to have RAUC updating the boot A/B partition and switching to
> it calling this new tool.
> 
> Regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

-sughosh
