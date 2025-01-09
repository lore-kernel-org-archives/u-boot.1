Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F8CE7719A
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 23:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65CD800D0;
	Fri, 10 Jan 2025 00:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V9I9abNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C3480196; Fri, 10 Jan 2025 00:47:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D0D8001F
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 00:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 509Nkxw53032422
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 9 Jan 2025 17:46:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736466419;
 bh=yA3GP7K7HxL6iWlY1JqfcJWxcM+tShTrs7C+0D7Z9kQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=V9I9abNQuCCBep0ZzUutU+nPNevIttDMXeTqG0KkDDyY4VOXvCgXwevWn+vHNQ0og
 /499hysd5vlxddNXhzncI8COgamEwUOkeEFWsudI0+CuMbatcIAtlSM4vpWIIzFey7
 8KMfMLXUF19cbV7I537vUuiOdE5amKymRfJp5Xy8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 509Nkx9T094708;
 Thu, 9 Jan 2025 17:46:59 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Jan 2025 17:46:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Jan 2025 17:46:58 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 509Nkwgt019087;
 Thu, 9 Jan 2025 17:46:58 -0600
Date: Thu, 9 Jan 2025 17:46:58 -0600
From: Bryan Brattlof <bb@ti.com>
To: Aparna Patra <a-patra@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <d-gole@ti.com>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v2 0/4] Add fdt-fixups for AM62P variants
Message-ID: <20250109234658.e3axwtct5d7ds4yk@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250108044939.392785-1-a-patra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250108044939.392785-1-a-patra@ti.com>
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

On January  8, 2025 thus sayeth Aparna Patra:
> This series implements fdt fixups, by reading hardware
> information from registers and accordingly delete/modify
> the DT nodes, at run-time.
> 
> Logs for AM62P boot:
> https://gist.github.com/itsme-aparna/b889fe59882c1acf0ef25a644bd325c4
> 
> Changes from v1 to v2:
> - Add another patch to set A53 CPU freq before core boots, as 
>   mentioned by Bryan.
> 
> Aparna Patra (4):
>   arm: mach-k3: am62p: Fixup CPU core, CAN-FD and Video-codec nodes in
>     fdt
>   arm: mach-k3: am62p: Fixup thermal zone critical points
>   arm: mach-k3: am62p: Fixup a53 max cpu frequency by speed-grade
>   arm: mach-k3: am62p: Set a53 cpu freq based on speed-grade
> 
>  arch/arm/mach-k3/am62px/am62p5_fdt.c          | 83 +++++++++++++++++++
>  arch/arm/mach-k3/am62px/am62p5_init.c         | 62 ++++++++++++++
>  .../arm/mach-k3/include/mach/am62p_hardware.h | 65 +++++++++++++++
>  3 files changed, 210 insertions(+)
> 

Thanks Aparna!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
