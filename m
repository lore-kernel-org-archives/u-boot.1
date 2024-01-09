Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2682C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 16:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E89EA8785D;
	Tue,  9 Jan 2024 17:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xkJEQktl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13618785D; Tue,  9 Jan 2024 17:16:26 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1D786E82
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 17:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409GGJ5e101984;
 Tue, 9 Jan 2024 10:16:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704816979;
 bh=zUiur+mfI6ypmuJNKAze1he1MBRl6+Gg237AjpgQs+M=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xkJEQktlfsU1UoiJHN+HyMp6D0tK6H/tTrVvJmr4LU8oUpnTeSY+31t20CCOFU9k1
 tQZDRZ3sE+pOm+wdl7wbnAkBXl4W4aHIbkWomhbrZjTICeRZ56111XSAQ1XQmNr7ia
 h3GhbkWjizH6T7gDnZgniexgM67uqF07BWj4CriU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409GGJJw032044
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 10:16:19 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 10:16:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 10:16:19 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409GGJDL011416;
 Tue, 9 Jan 2024 10:16:19 -0600
Date: Tue, 9 Jan 2024 10:16:19 -0600
From: Nishanth Menon <nm@ti.com>
To: Thomas Richard <thomas.richard@bootlin.com>
CC: <u-boot@lists.denx.de>, <thomas.petazzoni@bootlin.com>, <u-kumar1@ti.com>, 
 <gregory.clement@bootlin.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Gowtham Tammana <g-tammana@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/8] Suspend to RAM support for K3 J7200
Message-ID: <20240109161619.3hb35z334s4zxb4g@glimmer>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108165628.3935756-1-thomas.richard@bootlin.com>
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

On 17:56-20240108, Thomas Richard wrote:
> This series is the U-Boot part of the work to add the suspend to RAM
> support for the K3 J7200 EVM board.
> 
> During the boot R5 SPL makes a copy of DM-Firmware and TF-A in memory.
> Resume detection is done by reading a magic value in a pmic register
> (set by DM-Firmware).
> 
> If a resume is detected, R5 SPL run the exit retention sequence of the
> DDR. Then it load TF-A and DM-Firmware using the copies done during the boot
> (fit image processing is skipped).
> Before to start TF-A, R5 SPL writes a magic value in scratchpad ram. This
> will be used by TF-A to detect that the board is resuming.
> 
> The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
> reserved memory region (for the kernel point of view) to avoid any
> memory corruption.
> 
> This version is mostly to test the firewall protection with the suspend
> to ram.
> Some comments (for the v2) were not fixed in this version.
> This series has been tested with the series [1] to enable the firewall.
> At the end of the resume sequence, TF-A is well protected by the
> firewall, but OP-TEE remains unprotected.
> 
> [1] https://lore.kernel.org/all/20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com/
> 
> 

And as usual, as I have already responded on https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/25120

My objection to this series mirrors what I have mentioned previously for
TFA as well - I am looking for some common sequence to be defined
between am62x and J7200 family rather than each go completely
tangentially, until that happens, please consider my standing NAK.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
