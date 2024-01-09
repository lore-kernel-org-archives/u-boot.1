Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D462CC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3356787729;
	Tue,  9 Jan 2024 15:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x18mDlce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09F586F1E; Tue,  9 Jan 2024 15:39:03 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EF686F1E
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409EcpZw109537;
 Tue, 9 Jan 2024 08:38:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704811131;
 bh=yy7RjZzUB15G7Byxa4oao4SjNRdpBM0at5tS1GwsdXM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=x18mDlcesj3TldZB7adIMqU/zsq9VEH5K0wmr7UVLl7eXu37359Goo7f5VFfSAsV4
 qMAPNIoSBhWnVUi0DIbUVekaNk83rtYy/wZBaidndd0FWNm/zLtTYeSdlsygVQqV7S
 xkSyjDu2DWmRN1/N976aq1ngCBOee1xk3kMyS7WA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409EcpUK009996
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 08:38:51 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 08:38:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 08:38:50 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409Eco1o104618;
 Tue, 9 Jan 2024 08:38:50 -0600
Date: Tue, 9 Jan 2024 08:38:50 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH 01/10] board: ti: common: Introduce a common fdt ops
 library
Message-ID: <20240109143850.pzbn6bcdeuw6cc67@molecule>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-2-nm@ti.com>
 <59043a79-8199-4319-a9c0-eb2bc8d55a77@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <59043a79-8199-4319-a9c0-eb2bc8d55a77@kernel.org>
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

On 15:08-20240109, Roger Quadros wrote:
[..]
> > +/**
> > + *  struct ti_fdt_map - mapping of device tree blob name to board name
> > + *  @name_fdt: board_name up to TI_NAME_FDT_MAX long
> > + *  @fdt_file_name: device tree blob name as described by kernel
> > + */
> > +struct ti_fdt_map {
> > +	const char *name_fdt;
> 
> Can we call this board_name? as name_fdt corresponds to device tree name.
> 

Done.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
