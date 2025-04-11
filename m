Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD665C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F97B83FD4;
	Fri, 11 Apr 2025 14:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wHAtDa1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8179A83FD6; Fri, 11 Apr 2025 14:43:16 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D4683F7B
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BCh9Yu2076647
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 07:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744375389;
 bh=SyMIf/y6Es6udpIXHlylvEJd5A+eUujQ1oy3QGlUZ2U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=wHAtDa1mtH1jnFNGIcSnb7E7/qFLP4ZWa3NSuYxJTLB2M9h8GeWQW3vq3iCepZOoa
 dZZ/81vU9e1j5Zsboo6gCtfrmBzIOYrSN0CJ7zEgZIwxVZyPLjh23XH9lz1hRkhU7d
 IIcS4iiEkXrpIdSMii5BweBfqmCB/VMrA6mUb9WI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BCh9qG043910
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 07:43:09 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 07:43:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 07:43:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BCh87V028629;
 Fri, 11 Apr 2025 07:43:08 -0500
Date: Fri, 11 Apr 2025 07:43:08 -0500
From: Nishanth Menon <nm@ti.com>
To: Michael Walle <mwalle@kernel.org>
CC: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <d-gole@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH] doc: board: ti: Add optee rng support
Message-ID: <20250411124308.ujiyfbtwyrlrx5hf@devalue>
References: <20250410132746.8168-1-u-kumar1@ti.com>
 <D93SWXVH3Q9B.32OUNLRBRTKQW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D93SWXVH3Q9B.32OUNLRBRTKQW@kernel.org>
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

On 14:17-20250411, Michael Walle wrote:
> Hi,
> 
> > J722S has hw rng, which can be used by OPTEE.
> > So remove option to use SW TRNG by OPTEE.
> >
> > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > ---
> > reference discussion 
> > https://lore.kernel.org/all/20250313144155.2382316-1-mwalle@kernel.org/
> >
> > Bootlogs with optee trng 
> > https://gist.github.com/uditkumarti/5f90210b23e67cd4eb6d06a024031ee8#file-gistfile1-txt-L1970
> 
> 
> I can confirm the TRNG will work on u-boot as well as linux.
> Thanks!

just curious: Did you have to change .configs for either?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
