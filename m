Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36A0C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 14:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1B287A75;
	Mon,  8 Jan 2024 15:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uRgZxBpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754B487A77; Mon,  8 Jan 2024 15:05:09 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC5087A21
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 15:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408E53bB031154
 for <u-boot@lists.denx.de>; Mon, 8 Jan 2024 08:05:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704722703;
 bh=+cuFtLFPJ366gMjROmEezCJTtSL6olJQMqanUvU99Sc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uRgZxBpumxB8LfFH4EDCh1uYZUmkGvEMPpQuYA7OZcXuFH1tA24SySPqicgEg7U3g
 6CYAMhg9UCtQeALwCxfJEDRD644594xuo74IsnQ3FvBxDXzd8KDdwXGaCGNs5Shzd/
 n73ZXpOY2tIzwAwqCME3uYO0Gr5G+xPEJ0wwyATs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408E531X076812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Mon, 8 Jan 2024 08:05:03 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 08:05:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 08:05:02 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408E52vo067086;
 Mon, 8 Jan 2024 08:05:02 -0600
Date: Mon, 8 Jan 2024 08:05:02 -0600
From: Bryan Brattlof <bb@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <u-boot@lists.denx.de>, <jm@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>, 
 <n-francis@ti.com>
Subject: Re: [PATCH 0/2] arm: dts: Add Itap Delay Value For High Speed DDR
Message-ID: <20240108140502.euuxmgutu4gcd7pn@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240108051922.29044-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240108051922.29044-1-b-kapoor@ti.com>
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

Hi Bhavya!

On January  8, 2024 thus sayeth Bhavya Kapoor:
> This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
> J7200 SoC and for DDR50 speed mode for MMCSD in J721s2 SoC.
> 
> Bhavya Kapoor (2):
>   arm: dts: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
>   arm: dts: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode
> 
>  arch/arm/dts/k3-j7200-main.dtsi  | 1 +
>  arch/arm/dts/k3-j721s2-main.dtsi | 1 +

Because of the periodic syncs with the kernel, modifying these dt files 
in U-Boot will cause confusion. (Which node is correct why did we have 
to do this in U-Boot and not in the Kernel... bla bla bla) If they 
absolutely need to go in now please override these nodes in the 
*-u-boot.dtsi files with a comment so we can keep track of these changes 
during the next sync with Linux.

~Bryan
