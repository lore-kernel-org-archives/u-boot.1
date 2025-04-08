Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E717CC36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 19:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E516782A76;
	Tue,  8 Apr 2025 21:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RHYtTkVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD4A82AA3; Tue,  8 Apr 2025 21:05:35 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD8C8213E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 21:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538J5Ud9613071
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 14:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744139130;
 bh=AJJDkuefn/wqJkUcERoVa0YF8bk2CdzXlBnAC/MWzmY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RHYtTkVkQT0jIGDvvyqmc5LKXKyhGmxbuDxlLdHTWeQ+RERS3UC5BA4B9rNKEx1kB
 QD0Pri5XimYxwI703WIrJgrx9N/seoQP05//x8AFP5DsNetzfKRz4n4b2rC353knnN
 wxA+uGX1Oko5rDLCBKaoQ0Rg7U1e2VSXtifbjqho=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538J5UPs063944
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 14:05:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 14:05:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 14:05:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538J5T0O103527;
 Tue, 8 Apr 2025 14:05:29 -0500
Date: Tue, 8 Apr 2025 14:05:29 -0500
From: Bryan Brattlof <bb@ti.com>
To: Thom Nichols <thom.nichols@voltserver.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: bootcount support for AM62 RTCSS
Message-ID: <20250408190529.qzi54waaxj3hzxr6@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <CY8PR11MB79456EA41EF6365020C89B98FDB52@CY8PR11MB7945.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB79456EA41EF6365020C89B98FDB52@CY8PR11MB7945.namprd11.prod.outlook.com>
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

Hi Thorm!

On April  8, 2025 thus sayeth Thom Nichols:
> I’d like to get bootcount support for the AM62 RTCSS.  The RTCSS on 
> the AM62 is very similar to the AM33.  In fact, I’m pretty sure the 
> bootcount_davinci driver would work for AM62, with just the register 
> address/ offset and KICK_WE constants redefined for the correct AM62 
> values.  A while back I tested the AM62 scratch register from 
> userspace [1] and confirmed it works the same as the AM33.
> 

Wonderful! It is a different IP from the AM335 but not completely 
different however I think your approach should work.

> I’ve never contributed to u-boot but I believe I could get a working 
> PR that modifies the davinci_bootcount driver, if this would be 
> acceptable.
> 

You should feel free to start if you want! U-Boot is very welcoming in 
this regard. The more devs we have in U-Boot the better :)

> Alternately I don’t know if there’s any near-term plan for any of the 
> AM62 maintainers to port the rtc driver so that bootcount/rtc could be 
> used.  I think doing this would be beyond my capabilities.
> 

So we do have some plans to improve RTC support in both in Linux and in 
U-Boot to extend some features needed for the latest Sitara class SoC 
but I'm unsure about timelines. I've added a ticket internally to track 
this if we get to it before you do though :)

~Bryan

> Thanks in advance.
> 
> Thom Nichols
> 
> 1. https://github.com/VoltServer/uboot-bootcount/pull/15/files

