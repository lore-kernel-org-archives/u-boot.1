Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC7E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 05:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B9686801;
	Mon,  9 Oct 2023 07:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wLoOfXaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E54C86801; Mon,  9 Oct 2023 07:09:02 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A8786801
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 07:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39958e5L057945;
 Mon, 9 Oct 2023 00:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696828120;
 bh=uwJ8bz6heO3bQwoq+7oHcPyY6dlSATqY0yCQowCOPy8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wLoOfXaWYUBTTyIZlxfaFW3zAhu2YcZJUpgeZcEhP3Xh7DorKpusTFprwce4Z+PyH
 AosQc9eAOaFbsRIC6FZH+7UEQ5HzQD3806Y5dsyIeWJbtJrLciK4dFKzvuRgNKHAW1
 3q6N63I7iRfMjFbARhRLIxcyoZcDGPQ8n9i7oRAI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39958eY2129315
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 9 Oct 2023 00:08:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 00:08:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 00:08:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39958c4Z056527;
 Mon, 9 Oct 2023 00:08:39 -0500
Date: Mon, 9 Oct 2023 10:38:38 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Message-ID: <20231009050838.eo5f62fo36kxsaer@ula0497581>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-3-a-nandan@ti.com>
 <20231002160156.pacy7j53bbtx766e@reboot>
 <20231004051327.jvatwiwpmdz4lykd@ula0497581>
 <20231004122425.3lvghvwufnx5simt@manhunt>
 <20231005045948.syyj3xvpokloudxd@ula0497581>
 <20231005112624.sair56f6kff4ixv2@countdown>
 <20231006041604.xs6kkbxi3lfz5vpt@ula0497581>
 <20231006111347.2o37pa4r22xc3z6v@jersey>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231006111347.2o37pa4r22xc3z6v@jersey>
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

Hi Nishanth,

On 06:13-20231006, Nishanth Menon wrote:
> On 09:46-20231006, Manorit Chawdhry wrote:
> > Hi Nishanth,
> > 
> > On 06:26-20231005, Nishanth Menon wrote:
> > > On 10:29-20231005, Manorit Chawdhry wrote:
> > > > Hi Nishanth,
> > > > 
> > > > On 07:24-20231004, Nishanth Menon wrote:
> > > > > On 10:43-20231004, Manorit Chawdhry wrote:
> > > > > 
> > > > > > These are required to remove the firewall configurations that are done
> > > > > > by ROM, those are not the ones that are being handled by OIDs. The
> > > > > 
> > > > > I am not sure I understand this clearly. OIDs are setup to open up
> > > > > firewalls or close firewalls as the system requires and since it
> > > > > is authenticated, not compromiseable.- U-boot by itself (even if
> > > > > authenticated), is not a secure entity for it to dictate the firewall
> > > > > configuration (u-boot must be assumed to be compromised after
> > > > > authentication is complete). So, doing firewall configuration via APIs
> > > > > after boot, to me looks broken approach.
> > > > > 
> > > > 
> > > > I know U-boot ain't that secure given the most trusted entity is always
> > > > gonna be the software that starts up the system, we can't expect those
> > > > to be doing all the work and based on that we have the secure boot
> > > > designed to configure firewalls (that are not owned by anymore) and
> > > > U-boot R5 being one of the early bootloaders do come as a part of it. 
> > > > 
> > > > Regarding the OIDs thing, I don't think the OID in question is looked by
> > > > ROM and ROM always configures some firewalls for it's usecase that are
> > > > present in those arrays. 
> > > > 
> > > > The OID that we are using in the series that you had shared is looked by
> > > > TIFS instead of ROM and TIFS is the entity that is authenticating the
> > > > binary along with setting up the firewalls.
> > > > 
> > > > > > current series that is being worked on is to add additional firewalling
> > > > > > support with OIDs that TIFS will be handling.
> > > > > > The above patch is
> > > > > > essentially added to have the same development experience on GP devices
> > > > > > similar to HS after the secure boot is done so that people don't end up
> > > > > 
> > > > > huh? the code seems to blindly call the remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
> > > > > where is the distinction of HS vs GP here? This implementation looks
> > > > > completely broken to me at least.. please correct what I missed here.
> > > > 
> > > > Since this call is used across all SoCs there wasn't any point to make
> > > > the differentiation between GP and HS here, remove_fwl_configs
> > > > internally handles looking at the firewalls and disabling them if they
> > > > are enabled ( Which would be only in the case of HS devices ), for GP it
> > > > would automatically by a noop.
> > > 
> > > Correct me if I understand the security chain here:
> > > 
> > > ROM sets up firewalls that are needed by itself
> > > TIFS (in multicertificate will setup it's own firewalls)
> > > R5 SPL comes along and opens up other firewalls
> > > Each stage beyond this: such as tispl.bin containing TFA/OPTEE uses OIDs to
> > > set up firewalls to protect themselves (enforced by TIFS)
> > > A53 SPL and U-boot itself startups but has no ability to change the
> > > protection firewalls enforced by x509 OIDs.
> > > 
> > > Further, firewalls have lockdown bit that enforces the setting (and
> > > cannot be over-ridden) till system restart is requested
> > > 
> > > Is this correct? If so, needs to be clearly documented.
> > 
> > Yes, this seems correct. Will be updating it in the upstream
> > documentation in another series.
> > 
> 
> Thanks. I suggest:
> a) Add documentation as part of firewall series[1] including information
> as to how to customize the flow as needed.
> b) once the firewall series is merged
> c) am69/j784s4 series and add reference in code to the section of
> documentation.

Sure, would do the following in firewalling series. Thanks!

Regards,
Manorit

> 
> [1] https://lore.kernel.org/all/20231004-binman-firewalling-v3-0-e4a102324e1f@ti.com/
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
