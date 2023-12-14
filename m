Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D123DC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 20:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8F587A85;
	Thu, 14 Dec 2023 21:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tBBeJhYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29DC87B22; Thu, 14 Dec 2023 21:10:39 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8967B87A75
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 21:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BEKAKUE111622;
 Thu, 14 Dec 2023 14:10:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702584620;
 bh=rhAH9QmcY/cHkf8DyPNB+DU4HasLgr6R79nMPiBJfIc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tBBeJhYzwFSC2+cJQh+7UihtTiQzWvNStmq7tNFaGQotkUE5AfPzFP5RVWWA8Kdk3
 rC8lfJVo7ioRZ3/qA5JqfWjmXWmFsuZAW7oxT+FerLTBSN1t8DpLtzGN/r3XiseuDe
 6EEbpjTC+2UX0+XeQNExgfTT6GIbRG9bLMlRfXi4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BEKAKpo058493
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Dec 2023 14:10:20 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 14:10:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 14:10:19 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BEKAJ62055744;
 Thu, 14 Dec 2023 14:10:19 -0600
Date: Thu, 14 Dec 2023 14:10:19 -0600
From: "bb@ti.com" <bb@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>, "nm@ti.com"
 <nm@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "lukma@denx.de" <lukma@denx.de>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "rogerq@kernel.org"
 <rogerq@kernel.org>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
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

On December 14, 2023 thus sayeth Marcel Ziswiler:
> Hi Apurva
> 
> Thanks!
> 
> On Wed, 2023-12-06 at 18:07 +0530, Apurva Nandan wrote:
> > Hello Everyone!
> > 
> > This series will introduce basic support (SD and UART) support for Texas
> > Instruments J784S4 EVM.
> 
> For the whole series:
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> However, one thing I noticed is that with upstream TF-A I do get the following errors:
> 
> NOTICE:  BL31: v2.10.0  (release):v2.10.0-76-g02091541d
> NOTICE:  BL31: Built : 18:13:08, Dec 14 2023
> ERROR:   Failed to get response (-19)
> ERROR:   Transfer send failed (-19)
> ERROR:   Unable to query firmware capabilities (-19)
> 
> While with latest TF-A from downstream TI BSP (both 9.0 and 9.1 use the same versin) I do not get any errors:
> 
> NOTICE:  BL31: v2.9(release):v2.9.0-614-gd7a7135d3
> NOTICE:  BL31: Built : 18:40:38, Dec 14 2023
> 

What version of TIFS are you running? Not getting a response usually 
means firmware is dead or we're not using the right thread to talk.

~Bryan
