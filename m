Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BBEE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E7A806D3;
	Mon, 23 Dec 2024 08:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cn9AHPb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF6D806D4; Mon, 23 Dec 2024 08:28:50 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288988056A
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN7SeKO819791
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 23 Dec 2024 01:28:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734938920;
 bh=hz0ns4v52agX67YXcbU5ochHYBesZTcV0OTNFUWT9Zk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cn9AHPb5Too8gldGQP+DUgtZ53ovVE7Musnn/O9YUjuyuVhV8VXp//v1dfDrwFgtn
 Hfp45545sSzY9djzKoyZxByzfpbvEzc5gNAtqoCn8ki4GUSJ0Kro67iQQPFtIKvb0S
 F/GpL2sQ1gkqwxv7PP9DxPH6soOU7Mh/JpmIP5XY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN7SeYE074367;
 Mon, 23 Dec 2024 01:28:40 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 01:28:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 01:28:40 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN7SdN1007558;
 Mon, 23 Dec 2024 01:28:39 -0600
Date: Mon, 23 Dec 2024 12:58:39 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>
Subject: Re: [PATCH RFC 4/8] soc: Add information to identify the J742S2 SoC
 family
Message-ID: <20241223072839.avi4ujcjm5b2x3mc@uda0497581>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-4-13a6a127b344@ti.com>
 <46b59d32-7016-4341-b0fd-a9a04add4b08@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <46b59d32-7016-4341-b0fd-a9a04add4b08@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Udit,

On 19:37-20241222, Kumar, Udit wrote:
> 
> On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
> > J742S2 has the same part number as J784S4 but JTAG_DEVICE_ID has a
> > PKG bit that tells about J742S2.
> > 
> > Add support for reading JTAG_DEVICE_ID and set family as J742S2 based
> > on that.
> > 
> > Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
[..]
> > diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> > index a3acca4d394273aad53efd3eee200ecdda50c31b..f8e64395ae3f18513837a88cf91d340fc11bb346 100644
> > --- a/drivers/soc/soc_ti_k3.c
> > +++ b/drivers/soc/soc_ti_k3.c
> > @@ -18,9 +18,14 @@ struct soc_ti_k3_plat {
> >   static const char *get_family_string(u32 idreg)
> >   {
> >   	const char *family;
> > +	u32 jtag_dev_id;
> > +	u32 pkg;
> >   	u32 soc;
> > +	jtag_dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
> 
> Please check, if this register is available for all k3 devices.
> 
> if not then please move this logic under J784S4 SOC.
> 
> Second compilation will fail for few k3 devices , which does not define
> CTRLMMR_WKUP_JTAG_DEVICE_ID

Ah yeah, thanks for catching it!

Will fix it in the next revision.

Regards,
Manorit
