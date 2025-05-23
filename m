Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6BDC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 06:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684EB8310F;
	Fri, 23 May 2025 08:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fWG7fAFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCCA383164; Fri, 23 May 2025 08:30:13 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FDA83108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 08:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54N6U85t842796;
 Fri, 23 May 2025 01:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747981808;
 bh=Dx2CFmQJHOev2egYm6nle0Y+ckJVTdz7NmaPqgVYoIw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fWG7fAFMvTpT2k2qX0VQ9I4Cv645LXd0dlIWkdnESYMwT6sCJ3DV/maFtbD41Idhb
 KB16f/f+NiDWUrtEJpm9l7HvYEMIM6RGu1g90eN6MM/szluGqSmzbR1k4i77Srovn7
 Fe2GmYQEfHHLMs5JOtd5vLDUusOdawGFFdHQSF/M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54N6U8OZ4063733
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 23 May 2025 01:30:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 May 2025 01:30:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 May 2025 01:30:08 -0500
Received: from [172.24.21.52] (ltpw0bk3z4.dhcp.ti.com [172.24.21.52])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54N6U5xi001537;
 Fri, 23 May 2025 01:30:05 -0500
Message-ID: <7c5e9e1b-247e-4791-9a3a-9983dede1453@ti.com>
Date: Fri, 23 May 2025 12:00:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable split
 mode for MCU R5
To: Tom Rini <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>, <u-boot@lists.denx.de>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-7-b-padhi@ti.com>
 <20250522144505.GK100073@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250522144505.GK100073@bill-the-cat>
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

Hi Tom,

On 5/22/2025 8:15 PM, Tom Rini wrote:
> On Thu, May 22, 2025 at 12:48:28PM +0530, Beleswar Padhi wrote:
>
>> Previously, MCU R5F runs in lockstep mode. Enable split-mode on MCU R5F
>> as the support to shut down core1 and use it for loading other firmware,
>> while DM runs on core0, has been added.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi              | 2 +-
>>   dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi              | 2 +-
>>   dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi             | 2 +-
>>   .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi        | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
> Please don't post DONOTMERGE patches.


Noted. Will keep in mind from next time!

> If the series can be applied
> without this patch, because the functionality is backwards compatible
> put these changes in the cover letter or link to a gist or similar to
> show how to test the changes locally. If the series can't be merged
> until the DTS changes are ready too, please mark the whole thing as RFC.
> For clarity, what is the case with this series?


This series is independent of this patch and can be applied directly to 
U-Boot.
The DT patch is only needed to boot the cluster in split mode and test 
the functionality added here in this series.

Thanks,
Beleswar

