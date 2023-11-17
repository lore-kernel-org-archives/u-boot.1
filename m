Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3459C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 12:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3A886E64;
	Fri, 17 Nov 2023 13:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VYX9nZke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E008586E42; Fri, 17 Nov 2023 13:50:21 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1E98701C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHCnuTL108823;
 Fri, 17 Nov 2023 06:49:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700225396;
 bh=WT/CUSASpJlL0hPQBdFxqY6ib0FZe6b1SQAX0bKrBPc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=VYX9nZkeb1Moq/lwXen9oOj/T3PZP+ooyEoSlGGBWyeWABLk58d4/pIwscvooE5GF
 Pm/5x2a+muOU0AujPonlALFMA96uKxPlX5+HoJ2JQbqfKvQj0I1xZ0aXo9at7bhYhM
 OJa6BFAZv1SKQSjEsZGZbzcFBJJKcV3n8Yug/zbo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHCnubk020528
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Nov 2023 06:49:56 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 06:49:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 06:49:56 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHCntm5067870;
 Fri, 17 Nov 2023 06:49:55 -0600
Date: Fri, 17 Nov 2023 06:49:55 -0600
From: Bryan Brattlof <bb@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Enric Balletbo i Serra <eballetb@redhat.com>, Maxime Ripard
 <mripard@redhat.com>, Apurva Nandan <a-nandan@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha Malcom
 Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>
Subject: Re: [PATCH v4 00/16] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20231117124955.4u3v4p57zl2rclab@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231001165545.494212-1-a-nandan@ti.com>
 <lusvfc2to2akeccammsslooai53i4tflvcv4k2iofz3yqco3u6@uvn5flsjhxv3>
 <CALE0LRsTUFdSKYEoWDhPZRQEZbwv3-CMV5931KRbPvWmvWTSQA@mail.gmail.com>
 <719afeb3-7106-43e8-926f-4aa54d373055@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719afeb3-7106-43e8-926f-4aa54d373055@ti.com>
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

On November 17, 2023 thus sayeth Kumar, Udit:
> > On Wed, Nov 15, 2023 at 2:54 PM Maxime Ripard <mripard@redhat.com> 
> > wrote:
> > > On Sun, Oct 01, 2023 at 10:25:29PM +0530, Apurva Nandan wrote:
> > >

...

> > > 
> > > SoC:   J784S4 SR1.0 HS-FS
> > > Model: Texas Instruments J784S4 EVM
> > Maybe something changed but I'm surprised about it reporting an EVM
> > board. I was expecting something like
> > 
> > Model: Texas Instruments AM69 SK
> > Board: AM69-SK rev E2
> > 
> > Did you use the am69_sk_a72/r5  defconfigs?
> 
> Please apply AM69 config fragment
> 
> https://lore.kernel.org/all/20231001165545.494212-16-a-nandan@ti.com/
> 
> make ARCH=arm j784s4_evm_a72_defconfig am69_sk_a72.config
> make ARCH=arm
> 
> OR
> 
> make ARCH=arm j784s4_evm_r5_defconfig am69_sk_r5.config
> make ARCH=arm
       ^^^^^^^^ 

Just a heads up, adding the ARCH variable isn't really needed and I've 
heard of this causing problems for others :)

~Bryan
