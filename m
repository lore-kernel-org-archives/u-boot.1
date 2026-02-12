Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEABEB4907
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 11:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB5BE8367F;
	Thu, 12 Feb 2026 12:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67DF83A47; Thu, 12 Feb 2026 12:25:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D328680FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF676339;
 Thu, 12 Feb 2026 03:25:41 -0800 (PST)
Received: from localhost (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44FEB3F632;
 Thu, 12 Feb 2026 03:25:47 -0800 (PST)
Date: Thu, 12 Feb 2026 16:55:44 +0530
From: Sughosh Ganu <sughosh.ganu@arm.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Leonard Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH v2 0/6] Add support for fwumdata
Message-ID: <aY24uCQy_Pb7HGTD@a079122.arm.com>
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
 <20260114113115.01a0f1fd@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114113115.01a0f1fd@kmaincent-XPS-13-7390>
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

On Wed, Jan 14, 2026 at 11:31:15AM +0100, Kory Maincent wrote:
> On Fri, 12 Dec 2025 17:23:25 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
> 
> > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > (Firmware Update) metadata from Linux userspace. It provides functionality
> > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > metadata, change active/previous bank indices, modify bank states, and set
> > image acceptance flags. Configuration is done via fwumdata.config file.
> > 
> > Made a few change to mkfwumdata tool along the way.
> 
> Hello, any news on this patch series.
> 
> It would be nice if someone could take a look at this and help me get this
> merged.

Apologies for the late response. I recently moved to a different role,
and missed getting these patches. A couple of these patches no longer
apply, so it would be good to send a rebased series. Moreover, the
patchset makes changes which affect the current mkfwumdata tool. I
will test these changes on hardware early next week, and get back with
my feedback. Thanks.

-sughosh
