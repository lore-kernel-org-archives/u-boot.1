Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4699EC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F22B82E52;
	Mon, 14 Jul 2025 15:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bViwxy6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F10283010; Mon, 14 Jul 2025 07:46:22 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBD582B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56E5kCZ52538632;
 Mon, 14 Jul 2025 00:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752471972;
 bh=n9xUcMcilr6cV6FTbYv2V7rJqoQ+WPc0P7ni0AI5TjQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bViwxy6VMOPV23X81f9EbW1aMjbzxmkczx4b+SANVU+dnvpLjciiIWKddPHFpR8jo
 hZyzSeal7+R9AsHJQvjODgP3B3wZjPTAIBEVTYbGpEfH/CSJ9S2+Vgt2NrjqhGDz4b
 GxhWSWWStod8vlny4GRo853UiBQ5booEhB+zy0HQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56E5kCuM006263
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 14 Jul 2025 00:46:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 00:46:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 00:46:12 -0500
Received: from [10.24.69.200]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56E5k9bj4109268;
 Mon, 14 Jul 2025 00:46:10 -0500
Message-ID: <4c9c8325-7f81-47b2-8a9e-756645bd42e7@ti.com>
Date: Mon, 14 Jul 2025 11:16:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: KASLR OPTEE RNG support for K3 devices
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <rayagonda.kokatanur@broadcom.com>,
 <casey.connolly@linaro.org>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <j-keerthy@ti.com>
References: <20250710095922.144361-1-g-praveen@ti.com>
 <20250710141718.fx7cqeh2f2eibwkm@bryanbrattlof.com>
 <51e00bdb-374a-4e35-a230-58427aeaead7@ti.com>
 <20250711121741.jyo6gonfhoswbxvb@bryanbrattlof.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20250711121741.jyo6gonfhoswbxvb@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 14 Jul 2025 15:04:16 +0200
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

HI Bryan,


On 11/07/25 17:47, Bryan Brattlof wrote:
> On July 11, 2025 thus sayeth Gokul Praveen:
>> Hi Bryan,
>>
>> On 10/07/25 19:47, Bryan Brattlof wrote:
>>> On July 10, 2025 thus sayeth Gokul:
>>>> From: Gokul Praveen <g-praveen@ti.com>
>>>>
>>>> KASLR, or Kernel Address Space Layout Randomization, is a security
>>>> feature in the Linux kernel that randomizes the memory location
>>>> where the kernel is loaded during boot.
>>>>
>>>> OP-TEE RNG is a Random Number Generator (RNG) component within the
>>>> Open Portable Trusted Execution Environment (OP-TEE) which provides
>>>> a random number to U-BOOT and U-BOOT provides this random number
>>>> as seed value to the LINUX kernel for KASLR.
>>>>
>>>> Add KASLR OPTEE RNG support across K3 devices by enabling the required
>>>> configs.
>>>>
>>>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>>>> ---
>>>> v2<==> v1
>>>> ===========
>>>> * Added 'if' condition for configs to avoid enabling this feature
>>>>     in R5.
>>>
>>> Works for me.
>>>
>>> Reviewed-by: Bryan Brattlof <bb@ti.com>
>>>
>>>>
>>>> Boot logs Link :
>>>>
>>>> https://gist.github.com/GokulPraveen2001/44aa8c0962438c12ffc55e6ed67742e5
>>>
>>> Just curious are you enabling the kaslrseed command for this build? It
>>> looks like you're using TI's evil vendor scripts but I assumed the
>>> kaslrseed command was disabled.
>>
>> Can you elaborate more on this,Bryan?
>>
>> Actually, we are not using the kaslrseed device tree property. Is that what
>> you meant,Bryan?
> 
> Everything in this boot log is tagged as dirty. So I'm just trying to
> ensure I've got everything setup correctly.
> 
> I was curious what you are doing to generate the line:
> 
>     KASLR SEED OPTEE SET SUCCESSFULLY
>
> before we jump to the kernel.

Oh,got it Bryan. Those were just small debug prints I added in the 
"kaslr.c" file during the testing phase to check the offsets at which it 
was loading.So,the boot logs in the link are the ones I got during the 
testing phase,which I have not included in the patch provided as it is 
not needed.

Regards
Gokul


