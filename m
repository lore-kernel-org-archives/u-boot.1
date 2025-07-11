Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D6C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657B682F6A;
	Fri, 11 Jul 2025 09:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QhPl0Cjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7676E8362C; Fri, 11 Jul 2025 07:43:23 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB1A83423
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B5hG2N1971000;
 Fri, 11 Jul 2025 00:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752212597;
 bh=daoBuyM8RxSYjMqrczbnF4S3AFaD5dQOBndgS2aa/lQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QhPl0CjxYMy3AEc/AT3MYyy59dWNhaws/OJhHlQsDfFqUda7N4NgyYEq4uT3jetB4
 FmqMMtfz87Vmr75T4C3S7SDE8dQMPzF1hnYosSU8B3qUH2U3/kir+XZC97xoZxU62n
 g7VGBHTTi80ZMB+5yV+gp1tELHmGAXHyRLCDM7IA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B5hG2u1975038
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 11 Jul 2025 00:43:16 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 00:43:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 00:43:16 -0500
Received: from [10.24.69.200]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B5hDcA2927678;
 Fri, 11 Jul 2025 00:43:13 -0500
Message-ID: <51e00bdb-374a-4e35-a230-58427aeaead7@ti.com>
Date: Fri, 11 Jul 2025 11:13:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: KASLR OPTEE RNG support for K3 devices
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <rayagonda.kokatanur@broadcom.com>,
 <casey.connolly@linaro.org>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <j-keerthy@ti.com>,
 Gokul Praveen <g-praveen@ti.com>
References: <20250710095922.144361-1-g-praveen@ti.com>
 <20250710141718.fx7cqeh2f2eibwkm@bryanbrattlof.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20250710141718.fx7cqeh2f2eibwkm@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 11 Jul 2025 09:26:27 +0200
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

Hi Bryan,

On 10/07/25 19:47, Bryan Brattlof wrote:
> On July 10, 2025 thus sayeth Gokul:
>> From: Gokul Praveen <g-praveen@ti.com>
>>
>> KASLR, or Kernel Address Space Layout Randomization, is a security
>> feature in the Linux kernel that randomizes the memory location
>> where the kernel is loaded during boot.
>>
>> OP-TEE RNG is a Random Number Generator (RNG) component within the
>> Open Portable Trusted Execution Environment (OP-TEE) which provides
>> a random number to U-BOOT and U-BOOT provides this random number
>> as seed value to the LINUX kernel for KASLR.
>>
>> Add KASLR OPTEE RNG support across K3 devices by enabling the required
>> configs.
>>
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> ---
>> v2<==> v1
>> ===========
>> * Added 'if' condition for configs to avoid enabling this feature
>>    in R5.
> 
> Works for me.
> 
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
>>
>> Boot logs Link :
>>
>> https://gist.github.com/GokulPraveen2001/44aa8c0962438c12ffc55e6ed67742e5
> 
> Just curious are you enabling the kaslrseed command for this build? It
> looks like you're using TI's evil vendor scripts but I assumed the
> kaslrseed command was disabled.

Can you elaborate more on this,Bryan?

Actually, we are not using the kaslrseed device tree property. Is that 
what you meant,Bryan?
> 
> ~Bryan

Regards Gokul.
