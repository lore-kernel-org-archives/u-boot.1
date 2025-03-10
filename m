Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF0C2BA1B
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 05:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E0D8043C;
	Mon, 10 Mar 2025 06:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QXyDGfLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387D18070C; Mon, 10 Mar 2025 06:18:54 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4638D80107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52A5In0P891097
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 00:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741583929;
 bh=VfFvU7RpcUuGuuWHihPeVr/F805J8ZQjvSvoFYc3e+A=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=QXyDGfLngXzjUfHb5DVNts2iTuGdWJf6eZ52C7a7+zKk6c3FqwIw1aI8uBYIGYRd2
 UStVDczce7jd0oBgE5RxUemEvTooIcGmKQ4wMFAOOYqFxvIVLKjIaLUPAmaRstmacQ
 W7cyztrqOEmhYYpu/rBjKMBVujDDXwZ7R3j4Xz34=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52A5InHk117284
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 00:18:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 00:18:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 00:18:48 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52A5IlqV085905;
 Mon, 10 Mar 2025 00:18:48 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Mar 2025 10:48:47 +0530
Message-ID: <D8CBZ74BIHYX.1BJH0J37N5VZY@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: Re: [PATCH 02/10] cmd: Kconfig: enable CMD_BOOTI for ARCH_K3
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.17.0
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-3-anshuld@ti.com>
 <20250307155055.GP2640854@bill-the-cat> <D8A60PFV4FQL.5AHV0A4WLX0T@ti.com>
 <20250307162042.GS2640854@bill-the-cat>
In-Reply-To: <20250307162042.GS2640854@bill-the-cat>
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

On Fri Mar 7, 2025 at 9:50 PM IST, Tom Rini wrote:
> On Fri, Mar 07, 2025 at 09:43:19PM +0530, Anshul Dalal wrote:
> > On Fri Mar 7, 2025 at 9:20 PM IST, Tom Rini wrote:
> > > On Fri, Mar 07, 2025 at 01:25:30PM +0530, Anshul Dalal wrote:
> > >
> > > > This allows us to load the kernel image to memory on 32-bit R5 SPL.
> > > >=20
> > > > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > > > ---
> > > >  cmd/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index a04fcaa0e08..66145a001b8 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -357,7 +357,7 @@ config CMD_BOOTZ
> > > > =20
> > > >  config CMD_BOOTI
> > > >  	bool "booti"
> > > > -	depends on ARM64 || RISCV || SANDBOX
> > > > +	depends on ARM64 || RISCV || SANDBOX || ARCH_K3
> > >
> > > How are you using "booti" on the R5 part of K3? This shouldn't be
> > > useful...
> >=20
> > This is necessary to allow us to call booti_setup [the code path
> > responsible for parsing uncompressed kernel image] from
> > spl_parse_image_header at common/spl/spl.c:338 when loading the Image.
>
> OK, so please update arch/arm/lib/Makefile with something like:
> ifdef CONFIG_ARCH_K3
> obj-$(CONFIG_SPL_OS_BOOT) +=3D booti.o
> endif

We would still have to have CMD_BOOTI enabled even with this change
because of the check at common/spl/spl.c:338. I suggest we proceed with
my original set of changes instead.

Anshul
