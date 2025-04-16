Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7C1C369C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 16:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0F182BA2;
	Wed, 16 Apr 2025 18:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CKK/T4Ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D339582BA4; Wed, 16 Apr 2025 18:38:39 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF16807B1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 18:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GGcXvG2836818
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 11:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744821513;
 bh=E1INpXEiJFw5YLriwu62L7m8S0M55TuPlzqlsMwAwO8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CKK/T4OkSjezl7u7VXBEuP96OMMdeO0tVdIgoftvJbrgJu5ltUHN+tZ/PQi/vFcOg
 1Aax2V/LSgqNSFKoMK2sjCvRzsysinGlGKSVbYj41sgpY7yB54AMXv0TB72kAfN4xC
 WfRRJa9QCxPfK7/hCwhOU1ZXqt0TbAEiHCDMYnfk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GGcWdu101794
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 11:38:33 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 11:38:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 11:38:32 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GGcWCe083985;
 Wed, 16 Apr 2025 11:38:32 -0500
Message-ID: <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
Date: Wed, 16 Apr 2025 11:38:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
To: Nishanth Menon <nm@ti.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus> <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
 <20250416150506.ws22odswwkjn2wth@deflected>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250416150506.ws22odswwkjn2wth@deflected>
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

On 4/16/25 10:05 AM, Nishanth Menon wrote:
> On 19:18-20250416, Anshul Dalal wrote:
>> On Wed Apr 16, 2025 at 4:54 PM IST, Nishanth Menon wrote:
>>> On 13:00-20250416, Anshul Dalal wrote:
>>>> The change to ATF's PRELOADED_BL33_BASE[1] requires respective changes to
>>>> SPL_TEXT_BASE on u-boot side. This is necessary to allow the ATF to jump
>>>> directly to linux kernel (like in falcon mode) which requires a 2MiB aligned
>>>> load address[2]. The current address ATF jumps to is 0x80080000 which is not
>>>> 2MiB aligned.
>>>>
>>>> Therefore in parallel to the ATF change, this patch set makes the corresponding
>>>> changes to u-boot. To maintain backwards compatibility with older ATF builds
>>>> (that still use older address of 0x80080000), the patch set also adds a
>>>> jump-stub which modifies the execution as follows:
>>>>
>>>> Old ATF -> 0x80080000 -> 0x822000000 (Main domain SPL or kernel image)
>>>>             jump stub    SPL_TEXT_BASE
>>>>
>>>> With the following instructions loaded by the jump-stub:
>>>> ADDR       | Instruction
>>>> 0x80080000 |   mov x15, CONFIG_SPL_TEXT_BASE (0x822000000)
>>>> 0x80080004 |   br x15
>>>>
>>>> Depends on:
>>>>   * [PATCH v3] configs: set SPL_TEXT_BASE by default for k3 platforms
>>>>     https://lore.kernel.org/u-boot/20250415095028.446254-1-anshuld@ti.com/
>>>>
>>>> [1]:
>>>> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/37447
>>>> [2]:
>>>> "The Image must be placed text_offset bytes from a 2MB aligned base
>>>> address anywhere in usable system RAM and called there."
>>>> - Documentation/arch/arm64/booting.rst (linux kernel)
>>>>
>>>> Anshul Dalal (4):
>>>>    spl: Kconfig: k3: set SPL_TEXT_BASE to 0x82200000
>>>>    mach-k3: add a jump stub to support older ATF builds
>>>>    binman: k3: add jump-stub to tispl.bin
>>>>    binman: k3: add jump-stub as loadable
>>>
>>>
>>> 	How about u-boot documentation?
>>
>> I will update that in the next revision along with any feedback I
>> receive on this patch.
> 
> IMHO, This change is too intrusive and impacts downstream customers
> including inflight production devices.
> 

Could you elaborate a little?

They do not even need to update their TF-A version, if they want to
use their current version they simply recompile it with a single
extra build flag:

PRELOADED_BL33_BASE=0x822000000

They should have no reason not to be able to do this. But even *if*
they cannot do that, the whole point of the jump-stub here is to
save them even having to do a simple compile.

IMHO "downstream customers including inflight production devices"
should not be a reason to block good and useful changes here in
upstream. But again, this change doesn't break anything for them in
the first place, so why bring that up?

Andrew
