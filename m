Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7B8C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 10:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FD680540;
	Sat, 22 Feb 2025 11:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TJf7RLP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E723806FE; Sat, 22 Feb 2025 11:36:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 718BD801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 11:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51MAZv4H534168
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 22 Feb 2025 04:35:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740220557;
 bh=tWJwiI3gyLgKcHdPjuxd4uCyWePVs3KxG2ayyOAg4Xo=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=TJf7RLP3Buv4j4QJVa3lAXuhMwmF9ncIjQU+8Nmzxp4zBXrS44NUZRbSG9KSo+EVV
 rrdJ0u0iwRHDGlFGJ07HmwRTnqUMZpDuTW/QsK0batZ1bsqGjdqrw1ISh+2YCzTb86
 2k6Uo7G4BFnOF4JF7UBSGFOKwCDs9O4i79EsJEE4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51MAZv8i114294
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 22 Feb 2025 04:35:57 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Feb 2025 04:35:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Feb 2025 04:35:56 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51MAZu01089423;
 Sat, 22 Feb 2025 04:35:56 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 22 Feb 2025 16:05:55 +0530
Message-ID: <D7YWPASRXTZ4.2VMSJ4O8HUQFF@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <seanga2@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] spl: return kernel image header size in
 os boot
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.17.0
References: <20250221151752.2618666-1-anshuld@ti.com>
 <20250221200401.GQ1233568@bill-the-cat>
In-Reply-To: <20250221200401.GQ1233568@bill-the-cat>
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

On Sat Feb 22, 2025 at 1:34 AM IST, Tom Rini wrote:
> On Fri, Feb 21, 2025 at 08:47:51PM +0530, Anshul Dalal wrote:
>
> > During kernel build process the header size is computed including the
> > BSS whereas it's removed when creating the uncompressed image. Therefor=
e
> > the size of the uncompressed image on filesystem will be smaller than
> > the size specifiedin the header.
> >=20
> > Therefore it makes sense to return the header size back instead of the
> > file size in falcon boot.
> >=20
> > More info:
> > https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/
> >=20
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> >  common/spl/spl_ext.c | 4 ++++
> >  common/spl/spl_fat.c | 3 +++
> >  2 files changed, 7 insertions(+)
> >=20
> > diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> > index c5478820a9b..6d8d6544092 100644
> > --- a/common/spl/spl_ext.c
> > +++ b/common/spl/spl_ext.c
> > @@ -17,6 +17,10 @@ static ulong spl_fit_read(struct spl_load_info *load=
, ulong file_offset,
> >  	ret =3D ext4fs_read(buf, file_offset, size, &actlen);
> >  	if (ret)
> >  		return ret;
> > +
> > +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> > +		return size;
> > +
> >  	return actlen;
> >  }
> > =20
> > diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> > index fce451b7664..ddf85e2cece 100644
> > --- a/common/spl/spl_fat.c
> > +++ b/common/spl/spl_fat.c
> > @@ -55,6 +55,9 @@ static ulong spl_fit_read(struct spl_load_info *load,=
 ulong file_offset,
> >  	if (ret)
> >  		return ret;
> > =20
> > +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> > +		return size;
> > +
> >  	return actread;
> >  }
>
> Some image formats include information about the BSS as well, and others
> do not. But this is just having some parts of SPL return the filesize
> and not doing some deeper probing. Given that usually problems like this
> arise from loading contents in to memory too close together and then
> getting wiped out by the kernel BSS, what's the problem situation you've
> run in to, where, and with what loaded where in memory?

The problem is not about the allocation of BSS section but when loading
an uncompressed kernel image with the check in _spl_load at
`include/spl_load.h:95` which fails to -EIO even when the image is loaded
properly because it compares the size form the header to the size of the
file read from the FS:

	return read < spl_image->size ? -EIO : 0;

This doesn't work for uncompressed kernel image because the size from
the header (the parameter ulong size for spl_fit_read) includes BSS
which is not part of the final image file. And there is no way of
knowing the file size based on the header. Hence why we check for
CONFIG_CMD_BOOTI for returning the header size directly.

Although it might be better to have a different function altogether for
reading uncompressed image that can be passed to spl_load_init so we are
not using spl_**fit**_read to read non fit images.

You can find the bug report here:
https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/

- Anshul
