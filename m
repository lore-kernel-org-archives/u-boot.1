Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70827C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 12:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8D0870E1;
	Thu,  9 Nov 2023 13:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TuwX+Tnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6554B87108; Thu,  9 Nov 2023 13:23:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C004E870DF
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 13:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A9CN3j2015393;
 Thu, 9 Nov 2023 06:23:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699532583;
 bh=memOQK0dHfn9ZPeMAHfCy/lKB5uw1N8/vCmnUrZCdGs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TuwX+Tnqzl2u/BPObFwr8U+9/rhH2VYfzn2EH6MlatzAjI1FhyTJwow5Z6aODPcHi
 /DxhvLWQL9Zt+GtkRtDM7miakuKaxg6mT8HysYSEZ8fO24yWJ86eeHU2CIDG555kvX
 EjvnA+VMuYeIlJ3YiEEmAO7JENexrnfyNZmMR2Tk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A9CN3El013602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Nov 2023 06:23:03 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Nov 2023 06:23:03 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Nov 2023 06:23:03 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A9CN3mN104693;
 Thu, 9 Nov 2023 06:23:03 -0600
Date: Thu, 9 Nov 2023 06:23:03 -0600
From: Nishanth Menon <nm@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Maxime Ripard <mripard@redhat.com>, <u-boot@lists.denx.de>
Subject: Re: eMMC broken on SK-AM62
Message-ID: <20231109122303.fakyjjb7df7c7spk@handheld>
References: <hsk5wejuf5maoer3aodjyndmyft56gag4cepfjep7lfthmwrcy@r2yoebb7stk6>
 <871qcz9q4i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871qcz9q4i.fsf@baylibre.com>
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

On 11:29-20231109, Mattijs Korpershoek wrote:
> Hi Maxime, Nishanth,
> 
> On mer., nov. 08, 2023 at 16:05, Maxime Ripard <mripard@redhat.com> wrote:
> 
> > Hi Nishanth,
> >
> > I've been trying for the last few days to get an SK-AM62 to boot from
> > the eMMC user data area.
> >
> > I finally got the jumper configuration to make the CPU boot from there
> > thanks to Mattijs, but it looks like the 2024.01-rc2 release doesn't
> > support booting from there:
> >
> > U-Boot SPL 2024.01-rc2 (Nov 08 2023 - 14:11:12 +0100)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.5--v09.01.05 (Kool Koala)')
> > SPL initial stack usage: 13368 bytes
> > Trying to boot from MMC1
> > MMC Device 0 not found
> > spl: could not find mmc device 0. error: -19
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >
> > It looks like you tried to fix it with 0f1c1e8b368b ("arm: mach-k3:
> > am625: Add support for UDA FS"), but it looks like it's not enough.
> 
> I confirm I reproduce the issue on AM62x SK EVM.
> 
> Beagle play seems to boot fine:
> 
> U-Boot SPL 2024.01-rc2 (Nov 09 2023 - 11:24:04 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
> SPL initial stack usage: 13400 bytes
> Trying to boot from MMC1
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Starting ATF on ARM64 core...
> 
> NOTICE:  BL31: v2.8(release):08.06.00.007
> NOTICE:  BL31: Built : 11:17:33, Nov  9 2023
> 
> U-Boot SPL 2024.01-rc2 (Nov 09 2023 - 11:24:30 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
> SPL initial stack usage: 1888 bytes
> Trying to boot from MMC1
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> 
> 
> U-Boot 2024.01-rc2 (Nov 09 2023 - 11:24:30 +0100)
> 
> SoC:   AM62X SR1.0 GP
> Model: BeagleBoard.org BeaglePlay
> DRAM:  2 GiB
> Core:  98 devices, 27 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
> Loading Environment from nowhere... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Net:   No ethernet found.
> 
> Press SPACE to abort autoboot in 2 seconds
> =>
> 
> Note that Beagle Play does not boot tiboot3 from UDA (User Data Area)
> but from mmc0boot0 so the boot flow is not exactly the same.
> 
> >
> > Thanks!
> > Maxime

There is nothing complex here - sorry for the late response, Sync DT
with v6.7-rc1 should take care of this:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/ti?id=c412c2f26eed08b1836ccf79f5547b67c1b55d5d
Vs:
https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/k3-am625-sk-u-boot.dtsi#L93
(notice no sdhci0 with bootph properties)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
