Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18ACC8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0038981E13;
	Mon, 30 Jun 2025 14:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E7E81FEE; Mon, 30 Jun 2025 14:02:57 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D415280B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 14:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 55UC2UPY060074
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 30 Jun 2025 20:02:30 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 20:02:30 +0800
Date: Mon, 30 Jun 2025 20:02:27 +0800
From: Leo Liang <ycliang@andestech.com>
To: <Eoin.Dickson@microchip.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <rick@andestech.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PULL] u-boot-riscv/next
Message-ID: <aGJ803txDE1mbYjj@swlinux02>
References: <aD6aAdsMpatCgcIn@swlinux02>
 <20250605200506.GF1382132@bill-the-cat> <aET27PdD0VwuzOAB@pie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aET27PdD0VwuzOAB@pie>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 55UC2UPY060074
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

On Sun, Jun 08, 2025 at 02:37:04AM +0000, Yao Zi wrote:
> [EXTERNAL MAIL]
> 
> On Thu, Jun 05, 2025 at 02:05:06PM -0600, Tom Rini wrote:
> > On Tue, Jun 03, 2025 at 02:45:21PM +0800, Leo Liang wrote:
> >
> > > Hi Tom,
> > >
> > > The following changes since commit d45b1d4ac94710f88902adc2173d7930700e2869:
> > >
> > >   Merge tag 'u-boot-dfu-next-20250602' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next (2025-06-02 08:43:10 -0600)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> > >
> > > for you to fetch changes up to b911af6d60d3be570469b92df751874dc376336b:
> > >
> > >   MAINTAINERS: riscv: cpu: th1520: Assign myself as maintainer (2025-06-03 14:17:46 +0800)
> > >
> > > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/26483
> > > ----------------------------------------------------------------
> > > - board: Convert Lichee Pi 4A to use S-Mode proper U-Boot
> > > - RISC-V: configs: Raise SPL_SYS_MALLOC_SIZE to 8 MiB
> > > - driver: Add SD card support to the Beagle-V-Fire
> > > - MAINTAINERS: Add Yao Zi as maintainer for th1520
> > > ----------------------------------------------------------------
> >
> > This introduces a failure to build on microchip_mpfs_icicle currently in
> > -next.
> 
> microchip_mpfs_icicle_defconfig fails to build in u-boot-riscv/next as
> well. Reverting b73971dea9fed ("spi: coreqspi: add xfer function for
> PolarFire SoC") fixes it.
> 
> Seems the patch doesn't adapt the multiple-cs-capable definition of
> dm_slave_plat, which was introduced in commit 34da258bb04 ("spi:
> spi-uclass: Read chipselect and restrict capabilities") in the last
> year. Thus I doubt whether the patch has been built and tested against a
> recent version of U-Boot.
> 

Hi Eoin,

Your patch ("spi: coreqspi: add xfer function for PolarFire SoC")[1] does not pass CI[2].

Could you fix this issue and resend a V3?

Best regards,
Leo

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250529102112.3544972-3-Eoin.Dickson@microchip.com/
[2] https://source.denx.de/u-boot/custodians/u-boot-riscv/-/jobs/1155749#L5205
> 
> > --
> > Tom
> 
> Regards,
> Yao Zi
