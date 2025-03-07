Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322A9C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 16:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978A880F4C;
	Fri,  7 Mar 2025 17:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ceu15/iT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9FA8122F; Fri,  7 Mar 2025 17:17:51 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5225B80540
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 17:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527GHldS4118222
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Mar 2025 10:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741364267;
 bh=ZAJdbT4n77BCvUelkdGRz1cNQIixosku5ZFF3G8Egv0=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=Ceu15/iTvhXoPLQyn+3Cu7k6zQM17PJbkMvFtF7rv1hJn2mVrl137Nr0E31LWCRxS
 yXvqlfzkfe4IoF78XcgQ7svRUD3P/0VSQRp2Xor8I2DsPbdVRSj5PmxZFO6YDif4oV
 l/bI4WrJgwBbZ073v+tu7FG0Rw9nSYUIuVPKph3s=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527GHlGE103484;
 Fri, 7 Mar 2025 10:17:47 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 10:17:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 10:17:47 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527GHkMd006180;
 Fri, 7 Mar 2025 10:17:46 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 7 Mar 2025 21:47:46 +0530
Message-ID: <D8A6443OGU14.1UVU8U0DN0NBS@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH 08/10] configs: ti_armv7_common: add cfgs
 for SPI falcon boot
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.17.0
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-9-anshuld@ti.com>
 <20250307155739.GQ2640854@bill-the-cat>
In-Reply-To: <20250307155739.GQ2640854@bill-the-cat>
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

On Fri Mar 7, 2025 at 9:27 PM IST, Tom Rini wrote:
> On Fri, Mar 07, 2025 at 01:25:36PM +0530, Anshul Dalal wrote:
>
> > When booting from SPI, only the tispl.bin and tiboot3.bin is loaded fro=
m
> > the SPI. tiboot3.bin is located by the ROM and tispl.bin's offset is
> > specified by CONFIG_SYS_SPI_U_BOOT_OFFS.
> >=20
> > The kernel and args however are loaded from the eMMC or SD and not SPI,
> > therefore we don't actually make use of these config values at runtime,
> > they are added to avoid compile time 'undefined identifier' errors when
> > building with SPL_OS_BOOT enabled.
> >=20
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> >  include/configs/ti_armv7_common.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_arm=
v7_common.h
> > index 3def7b1027e..f101d10992a 100644
> > --- a/include/configs/ti_armv7_common.h
> > +++ b/include/configs/ti_armv7_common.h
> > @@ -119,6 +119,12 @@
> >  /* FAT */
> > =20
> >  /* RAW SD card / eMMC */
> > +
> > +/* SPI */
> > +#define CFG_SYS_SPI_KERNEL_OFFS	0
> > +#define CFG_SYS_SPI_ARGS_OFFS	0
> > +#define CFG_SYS_SPI_ARGS_SIZE	0
> > +
> >  #endif
>
> We need to refactor the code and migrate these to Kconfig as well.

Yeah, we're already using Kconfig for raw eMMC as well doing the same
for SPI make sense.

Anshul

