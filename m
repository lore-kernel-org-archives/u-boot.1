Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A61C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 05:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26418060C;
	Wed, 15 Jan 2025 06:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O/7NExe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54BF80657; Wed, 15 Jan 2025 06:58:02 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391FB80214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 06:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50F5vwpV3699796
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 23:57:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736920678;
 bh=+mAotMdRibs4JVADzBXoBIW8V9Qaw81pebGSvDDzN54=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=O/7NExe2vhhFxLFuw+YX4eFbSqj37G/ulv/86rXZzs9kwan2xkYvwIyy6y6lJOG95
 cTJKcte9Yj6hPzQ9XWm9QZ+k/TumyBLEVHR4KbvPFeoGJcFO83AG3MnPKWZL5iLNv3
 KKIHL/mLH1slPDDWuosSmU4XFXZI328Z4VtY9TW0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50F5vvqS016690
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Jan 2025 23:57:57 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Jan 2025 23:57:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Jan 2025 23:57:57 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50F5vuSN087071;
 Tue, 14 Jan 2025 23:57:56 -0600
Message-ID: <05272e42-5c55-4285-9ad6-fd7c9e913054@ti.com>
Date: Wed, 15 Jan 2025 11:27:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN / RFC] Regular community calls?
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20250113183409.GY3476@bill-the-cat>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250113183409.GY3476@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom

On 14/01/25 00:04, Tom Rini wrote:
> Hey all,
> 
> It's been suggested again a few times recently that we should try and
> have some sort of regular open call / video chat as that might help
> clear up some issues. To that end, I'd like to propose we have the first
> one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
> after the v2025.04-rc1 release, and I'll include a link in the release
> email. If this works out well, we can make it a regular thing for the
> day after a release and also try rotating the time, or having a second
> meeting much later in my day that's at a better time for other parts of
> the world.
> 

Thanks for initiating this, I think it will be helpful for most of us. For folks 
in the IST region, this is a pretty okay time in the evening so sounds good at 
least for me.

-- 
Thanking You
Neha Malcom Francis
