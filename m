Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6CE9A03E
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 09:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6BBA83AC5;
	Wed, 18 Feb 2026 10:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F7F83CF2; Wed, 18 Feb 2026 10:53:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 827ED83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 10:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69AE814BF;
 Wed, 18 Feb 2026 01:53:05 -0800 (PST)
Received: from localhost (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0EF13F7F5;
 Wed, 18 Feb 2026 01:53:10 -0800 (PST)
Date: Wed, 18 Feb 2026 15:23:07 +0530
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
Message-ID: <aZWMA6Oh0dPtQmUP@a079122.arm.com>
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
 <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
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

On Mon, Feb 16, 2026 at 02:35:35PM +0100, Kory Maincent wrote:
> Add a new fwumdata tool to allows users to read, display, and modify FWU
> (Firmware Update) metadata from Linux userspace. It provides functionality
> similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> metadata, change active/previous bank indices, modify bank states, and set
> image acceptance flags. Configuration is done via fwumdata.config file.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  MAINTAINERS                        |   4 +
>  doc/develop/uefi/fwu_updates.rst   |   4 +-
>  doc/fwumdata.1                     | 222 ++++++++++
>  tools/.gitignore                   |   1 +
>  tools/fwumdata_src/Kconfig         |  11 +
>  tools/fwumdata_src/fwumdata.c      | 854 +++++++++++++++++++++++++++++++++++++
>  tools/fwumdata_src/fwumdata.config |  33 ++
>  tools/fwumdata_src/fwumdata.h      | 138 ++++++
>  tools/fwumdata_src/fwumdata.mk     |   5 +-
>  9 files changed, 1270 insertions(+), 2 deletions(-)
> 

<snip>

> diff --git a/tools/fwumdata_src/fwumdata.mk b/tools/fwumdata_src/fwumdata.mk
> index 00f4ae50dbb..2199e43b372 100644
> --- a/tools/fwumdata_src/fwumdata.mk
> +++ b/tools/fwumdata_src/fwumdata.mk
> @@ -4,4 +4,7 @@
>  
>  mkfwumdata-objs := fwumdata_src/mkfwumdata.o generated/lib/crc32.o
>  HOSTLDLIBS_mkfwumdata += -luuid
> -hostprogs-always-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
> +hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata

This is correct the first way around.

> +
> +fwumdata-objs := fwumdata_src/fwumdata.o generated/lib/crc32.o
> +hostprogs-$(CONFIG_TOOLS_FWUMDATA) += fwumdata

This needs to be hostprogs-always-$(...)

-sughosh
