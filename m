Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089CDC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76DE983D4B;
	Thu, 10 Apr 2025 17:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DQzORs3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A510F83D46; Thu, 10 Apr 2025 17:26:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB48983D46
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AFQdD91319366
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 10:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744298799;
 bh=Il1kM+MEf4RRKPJY2Iqu503trRFRWdMhX1iBCsadfw0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=DQzORs3qPbyTR+mqx/B7tLrMTEIcslGN39kzTf++ZMQdMxPRL3tJMY7zzSMb0WxGA
 3FkBimNi/5gKdeIjLwynkVHshe4n2sPUCGEBFc3bWat6sNurQkXiyFB3L6NgwUQ92u
 /pLnC0nqTGaHXtAdBLNvTkfuJ120yIf2AnghoLfc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AFQdOQ111018
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Apr 2025 10:26:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 10:26:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 10:26:39 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AFQcqT106264;
 Thu, 10 Apr 2025 10:26:38 -0500
Date: Thu, 10 Apr 2025 20:56:37 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andrew Davis <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH V2] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
Message-ID: <20250410152637.aionie55wphegsei@lcpd911>
References: <20250407121554.1010490-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407121554.1010490-1-nm@ti.com>
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

Hi,

On Apr 07, 2025 at 07:15:54 -0500, Nishanth Menon wrote:
> When FIT image with multiple dtbs are involved for R5 boot process,
> R5 SPL starts off with the first instance of dtb to probe the
> eeprom, then once we have identified the type of board, invocation
> of setup_multi_dtb_fit will replace the gd->fdt_blob with the proper
> board dtb match. However, when we do this, two things happen:
> 
> a) Prior to the invocation of setup_multi_dtb_fit, as part of the eeprom
>    discovery process, i2c controller device is already probed and marked
>    as exclusive with the match of the very first tisci match (from the
>    original boot dtb). This list is stored in the info->dev_list of the
>    first probe.
> b) When the second dtb is loaded, tisci is probed again (since this is a
>    new node) and the new info->dev_list is empty.
> 
> At this stage, the exclusive devices such as i2c instances used to
> probe the board information is left in the old info->dev_list that is
> no longer used actively by the system using the replaced dtb.
> 
> As a result of this, the cleanup we intend to do with
> ti_sci_cmd_release_exclusive_devices is no longer complete and
> leaves the instances such as i2c for eeprom marked used as we scan just
> the new info->dev_list.
> 
> This creates a problem when Device Manager(DM) firmware starts up later
> on in the boot process and identifies that this instance of i2c is
> already marked active, so it assumes this can no longer be controlled
> by software and is marked internally as reserved and HLOS can no
> longer control these instances. This defeated the purpose of
> ti_sci_cmd_release_exclusive_devices.
> 
> NOTE: This scheme works just fine if the FIT has just a single dtb as
> the info->dev_list is upto date.
> 
> To fix this, let us make ti_sci_cmd_release_exclusive_devices scan the
> all registrations of tisci instances and cleanup all exclusive devices
> that have ever been registered.
> 
> As part of this, change the prototype of release_exclusive_devices to
> drop the handle since that has no further meaning now.
> 
> Though this issue was identified on AM64-sk, this can be present in
> other builds which use multi-fit-dtb for R5 SPL startup.
> 
> Fixes: 9566b777ae0a ("firmware: ti_sci: Add a command for releasing all exclusive devices")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> * commit message: s/intent/intend (review comment)
> * Added comment to indicate am64x-sk
> * No functional changes.


Thanks for addressing concerns from previous series and
also discussing about alternate approaches.
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
