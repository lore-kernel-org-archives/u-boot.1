Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E8C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 20:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6824587D50;
	Tue, 23 Jan 2024 21:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BP9b9JEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C1387BC3; Tue, 23 Jan 2024 21:47:22 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB79087B6C
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 21:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NKlBTw009933;
 Tue, 23 Jan 2024 14:47:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706042831;
 bh=UH1sKsnsBtAHMdeb6EP5fJA4pStRaV+nFoaffou48QE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BP9b9JEWTMWPshwElGZzsTwtCgGp6jNjSflfexMNi/SbSOS/DUCo5Vuj2NyjUQFCf
 CmqCmnEUUXqE0v7AdudfYtB9FyvtNbSahVMkegyfRpmK3Ix90Q+R7S4AF1EfdpZ1Hi
 ZDzWUOgYMCq3vDJrH1Qka86chZ71slmBmKlcA3Co=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NKlBkK108461
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 14:47:11 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 14:47:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 14:47:10 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NKlADb085857;
 Tue, 23 Jan 2024 14:47:10 -0600
Date: Tue, 23 Jan 2024 14:47:10 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v8 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Message-ID: <20240123204710.hlv4x4y3gst7utoe@squealing>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-3-a-nandan@ti.com>
 <20240119193403.kgzt2zcxa55wexr3@skedaddle>
 <c5fd33d8-a1be-41e0-974e-7b4c5f80b318@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c5fd33d8-a1be-41e0-974e-7b4c5f80b318@ti.com>
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

On 20:21-20240123, Apurva Nandan wrote:
[...]
> > > +void k3_mem_init(void)
> > > +{
> > > +	struct udevice *dev;
> > > +	int ret, ctr = 1;
> > > +
> > > +	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
> > > +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> > > +		if (ret)
> > > +			panic("DRAM 0 init failed: %d\n", ret);
> > > +
> > > +		while (dev) {
> > why loop on dev? is it possible to have ret != 0 and dev = 0?
> > 
> Some variable needs to be used for loop condition, do you want it to be ret?
> or maybe you can suggest your idea for this please.
> > > +			ret = uclass_next_device_err(&dev);
> > > +			if (ret) {
> > > +				printf("Initialized %d DRAM controllers\n", ctr);
> > > +				break;
> > > +			}
> > > +			ctr++;
> > What is the use of ctr++ ?? please do a limit check for instances.
> This is to keep the logic independent of board evm, so that no include of
> EVM config is needed.
> ctr is just used to notify user about how many DDR are up during boot, else
> it is not needed.
> 
> I can remove the ctr and printf, if you want.
> 
> For a limit check, how can we get number of DDR instances on the EVM, I
> don't know, can you please suggest some way?
> 
> There is no config that stores this info afaik.

Why? J784s4 has only specific number of controllerns, correct?

A variant of the below -> but still have a question:

while (ctrl < J784S4_MAX_CONTROLLERS) {
	ret = uclass_next_device_err(&ret);
	if (ret) /* Question: How do we differentiate between valid
		  * failure and next instance not being present? */
		break;
	ctrl++;
}

info("Initialized %d DRAM controllers\n", ctrl - 1);
> 
> > 
> > [...]
> > 
> > Next time, please respond to the review comment questions so that I
> > know that you have considered and decided something is not necessary
> > or something was missed in the new version - for example what happened
> > to mmc_stop/restart?
> mmc_stop/restart were removed (mentioned in series changelog)

Mentioning in diffstat of the patch helps give people the context of the
change w.r.t the path itself.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
