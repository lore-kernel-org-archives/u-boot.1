Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1A2C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DB8806FE;
	Fri, 21 Feb 2025 14:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GCYGYuVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D048056B; Fri, 21 Feb 2025 08:12:11 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC79F8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51L7C6ol225110
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 01:12:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740121926;
 bh=pKcR+cTFzS+X6lvnkANoOjeWL2w02r6Zgw69kU5WdhU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GCYGYuVjWr1JVu/q21yvP+e/mEy/K0aKzCeRdKS19Dpd/DCz+VR4sVV26X/2OAc99
 F7P9ZqIzFJcL0dFE9iqAtHvouZutshS1AY/4CmREAKt8W6ftydHkaM1uZNxH6L6dUg
 W5TqRmg4uj7i7ygh0c6uYBwGcZLVrZjPkZJjSlzA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51L7C6t0094526
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Feb 2025 01:12:06 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Feb 2025 01:12:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Feb 2025 01:12:05 -0600
Received: from [172.24.227.4] (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51L7C2Cm108316;
 Fri, 21 Feb 2025 01:12:03 -0600
Message-ID: <788ab031-a1c7-41f9-b629-984082b8e4df@ti.com>
Date: Fri, 21 Feb 2025 12:42:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] configs: am65x_evm_r5_usbdfu_defconfig:
 Fix USB DFU boot
To: Tom Rini <trini@konsulko.com>
CC: <n-francis@ti.com>, <s-k6@ti.com>, <kamlesh@ti.com>, <a-shenai@ti.com>,
 <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <srk@ti.com>
References: <20250220100241.1170993-1-h-salunke@ti.com>
 <20250220143710.GX1233568@bill-the-cat>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20250220143710.GX1233568@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 21 Feb 2025 14:53:04 +0100
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



On 20/02/25 20:07, Tom Rini wrote:
> On Thu, Feb 20, 2025 at 03:32:41PM +0530, Hrushikesh Salunke wrote:
>> Increase the size of malloc region allocated before relocation, as
>> current size is insufficient for dfu boot causing it to overflow and
>> corrupt the stack.
>>
>> Enable the fixed regulator configs required by vtt_supply which is used
>> by "am654_ddrss" driver. Without it during DFU boot DDRSS initialization
>> is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
>> are missing from "am65x_evm_r5_usbdfu_defconfig".
> 
> Sounds like am65x_evm_r5_usbdfu_defconfig needs to be updated to use
> #include.
> 
Thanks for the feedback. Will post the V2 to update
am65x_evm_r5_usbdfu_defconfig to include am65x_evm_r5_defconfig.

Regards,
Hrushikesh.
