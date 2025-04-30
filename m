Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02BEC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC0D82BB4;
	Wed, 30 Apr 2025 18:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y3ySXsCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB90782BD9; Wed, 30 Apr 2025 18:29:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9020A8215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UGT4W03414314
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 11:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746030544;
 bh=8eSrE5Nh/ryJEYimFmqZwkiiXTz7jZGMaW34UaaZP00=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Y3ySXsCBiaLLRQAkWpf9mgEEudV+W9wMOlHPGrDB0naxr/c1/iEmGWsxVG4qRZX7I
 2kbgfcfIm1vWqYLSerrorYx9g+PlCK46lQDJpW2XPsY8QKh3X/bCQohaHT82Y8nJ7t
 5ZZKFiq/IAtuj8JrKq2yF7/dbc3TG6Th9PsJCt9w=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UGT4AL003964
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 11:29:04 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 11:29:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 11:29:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UGT4ZN058698;
 Wed, 30 Apr 2025 11:29:04 -0500
Date: Wed, 30 Apr 2025 11:29:04 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250430135751.2626849-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250430135751.2626849-1-anshuld@ti.com>
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

On April 30, 2025 thus sayeth Anshul Dalal:
> As discussed here[1], the go command causes undefined behavior when used
> for running custom OSes since the icache might hold outdated data. OSes
> usually also expect the MMU to be disabled upon execution.
> 
> Therefore this patch adds a call to cleanup_before_linux before we jump
> to the loaded program/os which disables both the caches and the MMU.
> This makes the go command's behavior consistent with riscv platforms.
> 

I know quite a few other OSes are beginning to use U-Boot (QNX, 
GreenHills or all the other RTOSes) each with their own requirements 
from the bootloader. I'm curious if we should make boot* a little more 
generic rather than abuse the 'go' command.

~Bryan
