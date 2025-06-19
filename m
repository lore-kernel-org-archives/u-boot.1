Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73938C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 17:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA0A382CD5;
	Thu, 19 Jun 2025 19:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M03CKWVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B937382CDF; Thu, 19 Jun 2025 19:15:35 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0CE82CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55JHFUwA685750;
 Thu, 19 Jun 2025 12:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750353330;
 bh=IFRwUmAN6yBeqL4SxNkU5KEuPm0hZL0Uh62yvFftw6k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=M03CKWVsRM2uHv0kQMwpndx87d0zgbmQ40NRBXai5CVoeK2odUU0qxP5wG4fXHAno
 Y0f/sWVc1MrNAhBoMC4x+oQYOEsnYXUWdSqY2kldgR4HZz1iKQdtSaQBxAjSLW4GLs
 D8fS2GJ2SAUGOPyfr13UiYQ7RFCk3R+KA7VFWC5s=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55JHFUsu1502132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 19 Jun 2025 12:15:30 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 19
 Jun 2025 12:15:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 19 Jun 2025 12:15:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55JHFTDn1750267;
 Thu, 19 Jun 2025 12:15:29 -0500
Date: Thu, 19 Jun 2025 12:15:29 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH -next] test/py/test_mmc: wrap multi-argument printf-style
 strings
Message-ID: <20250619171529.y6eg57sezcglxhpg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
 <20250619141331.GL6521@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250619141331.GL6521@bill-the-cat>
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

On June 19, 2025 thus sayeth Tom Rini:
> On Thu, Jun 19, 2025 at 06:45:05AM -0500, Bryan Brattlof wrote:
> 
> > Newer versions of python will emit a TypeError about not enough
> > arguments for a format string:
> > 
> >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_dev - TypeError: not enough arguments for format string
> >     FAILED ub/test/py/tests/test_mmc.py::test_mmcinfo - TypeError: not enough arguments for format string
> >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_info - TypeError: not enough arguments for format string
> >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_rescan - TypeError: not enough arguments for format string
> >     FAILED ub/test/py/tests/test_mmc.py::test_mmc_part - TypeError: not enough arguments for format string
> > 
> > Add parentheses around all multi argument format strings so all
> > arguments will be passed to the format string
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> 
> Nice! Does this mean you're also running these on hardware somewhere?

Yep I've got the all of the AM62* variants currently working in labgrid. 
I'm still trying to flow flush the u-boot-test-hooks scripts in the 
larger farm TI uses as a more permanent solution. But things are getting 
closer to fully automated :)

~Bryan

> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> -- 
> Tom


