Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B320AC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE5C878CD;
	Tue,  9 Jan 2024 15:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x7cftMNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81B4878FE; Tue,  9 Jan 2024 15:21:10 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7769D877D9
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409EKtBF104689;
 Tue, 9 Jan 2024 08:20:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704810055;
 bh=oI2hSAPagXBakMUP6HQtvBtarUude4E376/6nxryLPo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=x7cftMNBHeXeRFcpszm6zq6U1HVZxLMTDDGvqsJS/mG5+isuuLgauuEBOZG3o6HZ5
 rlgESuk67rZXuHdWlCfPDaZhdWFFvDpj+KGi3LdhWx+nHqCMhbn2XpdOMu6kH1KDva
 AKXQgvqsXuEGMrv8hLq4qchIl9Kg7WycgAfTCYpY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409EKsWi027850
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 08:20:54 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 08:20:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 08:20:54 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409EKsfp083894;
 Tue, 9 Jan 2024 08:20:54 -0600
Date: Tue, 9 Jan 2024 08:20:54 -0600
From: Nishanth Menon <nm@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon
 Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 08/10] board: beagle: beagleboneai64: Set fdtfile from C
 code instead of findfdt script
Message-ID: <20240109142054.rz52nktlawfohnhc@moonscape>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-9-nm@ti.com>
 <86o7dvdz1h.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86o7dvdz1h.fsf@udb0321960.dhcp.ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 20:24-20240108, Jon Humphreys wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Stop using the findfdt script and switch to setting the fdtfile from C
> > code.
> >
> > While at this, replace findfdt in environment with a warning as it is
> > no longer needed
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  board/beagle/beagleboneai64/beagleboneai64.c   | 14 ++++++++++++++
> >  board/beagle/beagleboneai64/beagleboneai64.env |  1 -
> >  configs/j721e_beagleboneai64_a72_defconfig     |  3 ++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
> > index c8c1c78ae5a2..1982f738b04e 100644
> > --- a/board/beagle/beagleboneai64/beagleboneai64.c
> > +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> > @@ -28,3 +28,17 @@ int dram_init_banksize(void)
> >  {
> >  	return fdtdec_setup_memory_banksize();
> >  }
> > +
> > +#ifdef CONFIG_BOARD_LATE_INIT
> > +int board_late_init(void)
> > +{
> > +	char fdtfile[50];
> > +
> > +	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
> > +		 CONFIG_TI_EVM_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
> 
> This would set the board to using the control DT, not boot DT.  Is that
> what you meant?

control DT file name. not the content.

> But anyway, why not just hard code the FDT path/name here since there is
> only one for this board?  I don't see the value in the extra logic of
> using the config values (or having a fdt_map).  (Same for beagleplay)

because there are potentially variants being privately discussed for both the
platforms - though the timelines are unknown at this point. This will
allow fragments to replace the DEFAULT_DEVICE_TREE to the variant and
rest of the logic will *just work*.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
