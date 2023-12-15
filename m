Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17446C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD1987C30;
	Fri, 15 Dec 2023 15:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X53/MbNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D15F87C22; Fri, 15 Dec 2023 15:23:50 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD7787C10
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BFEN8o0057100;
 Fri, 15 Dec 2023 08:23:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702650188;
 bh=Of2bBLkZgMMZoCVB7+Eov90RP0t5qQoeM53JgAzbOqM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=X53/MbNkqsnx42OoJWorr6r0+1rOnw8UpHK/Q01Z3p6DbX1WwJhJtr1amWLhVnEo1
 gXM6h+3Y3XoB+jXjP4sE2fMZo2JgVD85QqyvPCfUZHVE00SakeecnGszxHT/xJ+7wG
 TE4neKvjahGes8jb+OfQ+hHILKrsRjmhzdk8ubDc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BFEN8m3036855
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Dec 2023 08:23:08 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 08:23:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 08:23:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BFEN8kH043746;
 Fri, 15 Dec 2023 08:23:08 -0600
Date: Fri, 15 Dec 2023 08:23:08 -0600
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "bb@ti.com" <bb@ti.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "n-francis@ti.com"
 <n-francis@ti.com>, "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com"
 <afd@ti.com>, "a-nandan@ti.com" <a-nandan@ti.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "lukma@denx.de" <lukma@denx.de>, "j-choudhary@ti.com"
 <j-choudhary@ti.com>, "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "hnagalla@ti.com" <hnagalla@ti.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "u-kumar1@ti.com"
 <u-kumar1@ti.com>, "sabiya.d@ti.com" <sabiya.d@ti.com>, "rogerq@kernel.org"
 <rogerq@kernel.org>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20231215142308.2vbeicrlkbgr2pui@rebound>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
 <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
 <946574dc39d1cfb5bd08950a61eae06f3fbdc06c.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <946574dc39d1cfb5bd08950a61eae06f3fbdc06c.camel@toradex.com>
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

On 08:49-20231215, Marcel Ziswiler wrote:
> On Thu, 2023-12-14 at 14:10 -0600, bb@ti.com wrote:
> > On December 14, 2023 thus sayeth Marcel Ziswiler:
> > > Hi Apurva
> > > 
> > > Thanks!
> > > 
> > > On Wed, 2023-12-06 at 18:07 +0530, Apurva Nandan wrote:
> > > > Hello Everyone!
> > > > 
> > > > This series will introduce basic support (SD and UART) support for Texas
> > > > Instruments J784S4 EVM.
> > > 
> > > For the whole series:
> > > 
> > > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > However, one thing I noticed is that with upstream TF-A I do get the following errors:
> > > 
> > > NOTICE:  BL31: v2.10.0  (release):v2.10.0-76-g02091541d
> > > NOTICE:  BL31: Built : 18:13:08, Dec 14 2023
> > > ERROR:   Failed to get response (-19)
> > > ERROR:   Transfer send failed (-19)
> > > ERROR:   Unable to query firmware capabilities (-19)
> > > 
> > > While with latest TF-A from downstream TI BSP (both 9.0 and 9.1 use the same versin) I do not get any
> > > errors:
> > > 
> > > NOTICE:  BL31: v2.9(release):v2.9.0-614-gd7a7135d3
> > > NOTICE:  BL31: Built : 18:40:38, Dec 14 2023
> > > 
> > 
> > What version of TIFS are you running? Not getting a response usually 
> > means firmware is dead or we're not using the right thread to talk.
> 
> Yeah, sorry. I was always running the latest from the ti-linux-firmware branch:
> 
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.2--v09.01.02 (Kool Koala)')
> 
> So, it is really TF-A which seems to cause the issue.

Actually not TFA either (TFA complains correctly). we have an internal
ticket that is in the middle of getting fixed for TIFS and PDK to
enable this. a bit of history: A new api TISCI_MSG_QUERY_FW_CAPS[1]
was introduced to help determine which version of firmware combination
supports what features (such as Low power, etc). This allows for
consistent TFA/Kernel implementation that can dynamically detect
platforms (since LPM also involved a bit of firmware handshaking for
board specific details - PMIC control and the like). This API is as
fundamental as version message API that all firmware are supposed to
implement. unfortunately the defconfig option for that API wasn't
properly implemented for various firmware components correctly. -
impacted chips are: j721e, j7200, j721s2/am68, j784s4/am69. Other
K3 processor firmware have it implemented correctly. The latest
9.1.8--v09.01.08 has the bug as well - but hopefully should be fixed
and released soon-ish.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
