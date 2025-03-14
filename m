Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4A8C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 04:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24415810E8;
	Fri, 14 Mar 2025 05:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pAGexwsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38368168B; Fri, 14 Mar 2025 05:01:02 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2350D80F4C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E40vg61575252
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 23:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741924858;
 bh=H0RsdRbKu2G6D+SLS71xcaGq+4+KEiYiYv25tDjx6f0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=pAGexwszK/SW+YvjPTetDfK6CL2Ta882nlFEBUSF+aGrkDqVW2fC5jB+o0XqSB/NM
 J2MVHtTwDULaaZ8/1m7XbpWTLQCBEnqTOze6Kz6/C/sEs7E1Tz/EBHsD1XFQx8oC5+
 5jDBqQ9LbzqjzJnZ6XHsw/lxjbsQX/MAAZe/WjVQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E40vhi022189
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Mar 2025 23:00:57 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 23:00:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 23:00:57 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E40uFV103415;
 Thu, 13 Mar 2025 23:00:57 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Mar 2025 09:30:56 +0530
Message-ID: <D8FOTRTJIAZO.3HCU80EKTZGCO@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v4] spl: remove usage of CMD_BOOT[IZ] from image parsing
X-Mailer: aerc 0.17.0
References: <20250313032842.1189977-1-anshuld@ti.com>
 <20250313145152.GZ2640854@bill-the-cat>
In-Reply-To: <20250313145152.GZ2640854@bill-the-cat>
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

On Thu Mar 13, 2025 at 8:21 PM IST, Tom Rini wrote:
> On Thu, Mar 13, 2025 at 08:58:42AM +0530, Anshul Dalal wrote:
>
> > Using CMD_* configs from spl doesn't make logical sense. Therefore this
> > patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> > SPL_HAS_BOOT[IZ].
> >=20
> > An imply clause has been added for CMD_BOOTZ to avoid breaking configs
> > that rely on CMD_BOOTZ in falcon boot. There is no such need for
> > CMD_BOOTI since it's already enabled by default for the platforms that
> > support the image format.
> >=20
> > More info:
> > https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
> [snip]
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index a04fcaa0e08..9f2ba4d02f8 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -352,6 +352,7 @@ config BOOTM_ELF
> > =20
> >  config CMD_BOOTZ
> >  	bool "bootz"
> > +	imply SPL_HAS_BOOTZ
> >  	help
> >  	  Boot the Linux zImage
> > =20
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index 21a5cefee7a..49eb513f923 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1153,6 +1153,19 @@ config SPL_OS_BOOT
> >  	  Enable booting directly to an OS from SPL.
> >  	  for more info read doc/README.falcon
> > =20
> > +config SPL_HAS_BOOTZ
> > +	bool "Allow booting a zImage style Linux kernel from SPL"
> > +	depends on SPL_OS_BOOT
> > +	help
> > +	  Boot a linux zimage from memory in falcon boot.
>
> I was going to say this to v3 but you posted v4 already. The solution to
> existing platforms is "default y if ARM && !ARM64" here.

That makes sense, this keeps the defaults consistent between both
SPL_HAS_BOOTI and BOOTZ. I have addressed the changes in v5.

Thanks for the input :)

Anshul

