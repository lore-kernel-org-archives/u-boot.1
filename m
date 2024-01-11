Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99F2C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 09:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063A987620;
	Thu, 11 Jan 2024 10:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wCD8eNGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B746B87725; Thu, 11 Jan 2024 10:36:44 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A058751F
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 10:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40B9aXJe117298;
 Thu, 11 Jan 2024 03:36:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704965793;
 bh=O002uGVUX1Hd3fQtaxSPcaGevmISEnOjZa+eGdiPLZo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wCD8eNGHxeqfGhVqFiShGV5hW8xAF/Wv73qvBEz7iBvLhiDhlEbBUGWkHsA0jh+NN
 5c4hujAajuX6kG20u6tasaZYvjfPmIhKHaJSokbPmV6ffPPG5BXshWmsgj9APfTV2Y
 7OtLZv9UYvCkReHjGIsuI6uV1wlPNQFIejVX8PEo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40B9aWjv028782
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Jan 2024 03:36:33 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 03:36:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 03:36:32 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40B9aVV4018138;
 Thu, 11 Jan 2024 03:36:31 -0600
Date: Thu, 11 Jan 2024 15:06:30 +0530
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
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 15/17] configs: Add am69_sk_* defconfig fragments
Message-ID: <20240111093630.izftqnkdbt36xrpe@uda0497581>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-16-a-nandan@ti.com>
 <20240103175927.khcwikvf5srkygn3@proton>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103175927.khcwikvf5srkygn3@proton>
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

On 11:59-20240103, Nishanth Menon wrote:
> On 00:45-20231220, Apurva Nandan wrote:
> > From: Dasnavis Sabiya <sabiya.d@ti.com>
> > 
> > Add config fragments for am69_sk A72 and R5 configuration.
> > 
> > This applies on to:
> > j784s4_evm_a72_defconfig -> am69_sk_a72.config
> > j784s4_evm_r5_defconfig -> am69_sk_r5.config
> > 
> > The usage model (with the fragment) would be:
> > make j784s4_evm_a72_defconfig am69_sk_a72.config
> > make
> > 
> > OR
> > 
> > make j784s4_evm_r5_defconfig am69_sk_r5.config
> > make
> > 
> > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >  configs/am69_sk_a72.config | 3 +++
> >  configs/am69_sk_r5.config  | 3 +++
> >  2 files changed, 6 insertions(+)
> >  create mode 100644 configs/am69_sk_a72.config
> >  create mode 100644 configs/am69_sk_r5.config
> > 
> > diff --git a/configs/am69_sk_a72.config b/configs/am69_sk_a72.config
> > new file mode 100644
> > index 0000000000..5668e23b37
> > --- /dev/null
> > +++ b/configs/am69_sk_a72.config
> > @@ -0,0 +1,3 @@
> > +# Defconfig fragment to apply on top of j784s4_evm_a72_defconfig
> > +
> > +CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
> > diff --git a/configs/am69_sk_r5.config b/configs/am69_sk_r5.config
> > new file mode 100644
> > index 0000000000..9194694393
> > --- /dev/null
> > +++ b/configs/am69_sk_r5.config
> > @@ -0,0 +1,3 @@
> > +# Defconfig fragment to apply on top of j784s4_evm_r5_defconfig
> > +
> > +CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
> 
> See my previous comment. OF_LIST should have been overriden here to just
> a single dtb.

Just to get an understanding with this change, so from what I see is
OF_LIST is used to package multiple DTBs in u-boot but they way binman
is made, we don't have dtb generator nodes that will pack them
automatically. Even if that is the case from what I understand is the
u-boot.dtb that gets generated is based on CONFIG_DEFAULT_DEVICE_TREE so
how would we know which one is the default? Or are we saying that we'll
override OF_LIST and always use only one DTB for packing in U-boot.

The reason am asking this is because with FIT Signature, we embed a
signature node as well in the u-boot.dtb and not knowing which one is
the default and having multiple DTBs packed in U-boot have always been
problematic with this flow. ( In the past based on
CONFIG_DEFAULT_DEVICE_TREE value we have ended up packing the same DTB
twice. ) 

We use u-boot.dtb as a base reference and after adding the signature
node to it we pack it back in u-boot with EXT_DTB flag in u-boot which
gets propagated to u-boot.dtb (essentially only one DTB we can pack in
this way which has the signed node), so essentially if we use OF_LIST
and end up packing multiple DTBs I don't want use to have a conflicting
dtb actually getting packed in some other DTBs place..

Regards,
Manorit

> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
