Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764CCF58C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2C184034;
	Wed, 19 Nov 2025 18:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ftlu6oqA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ErdyRxEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6773D8006D; Wed, 19 Nov 2025 18:35:05 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D0884033
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:35:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dBTBp0nDZz9thr;
 Wed, 19 Nov 2025 18:34:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763573698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7f+VP+KaguVKW4Eo+w7TPOmCSqE5qdPYUVC9bheVgY=;
 b=ftlu6oqA3eWl9sxIijsRoI9ZP/LWcrEDO/44TuL6T/kl509ARkT/ZOD6CFkPrFwAvHgeS2
 FitxIFvmHAM03TalB8f/1Tm4M8VyRKaTFG1XzoJDeu1aH4g0GJ2HBJSnEIYBNviOHtj9mT
 fdMM11sZxGLI4/NvujD3agpwUVNigLmEnB5cszrmtGzzktSNx9X2Kaisn/mvit7UN8HKAz
 GQJ3QzPPt+ObFXiTrsRsw4GX/ofBIYjzAaWN4j6H4OSvrPzSPkeBsgx3aSTomCFijygJez
 iv3Czcch9SDzyo75Spyx1PJpfIzCCE9zsoQjlR6RQuHcerVV6Cy12rIQT69gFA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ErdyRxEX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <41203080-e331-4203-bd52-02a02b72dc5f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763573696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7f+VP+KaguVKW4Eo+w7TPOmCSqE5qdPYUVC9bheVgY=;
 b=ErdyRxEXv4Sf/7NcHPgIU4JdgXm4VBNTRMMYd4is5xxqkL4sh6d6YQAUOzze/B5kY5LD/D
 +q4O+rW6T+Ho7LvFntYs+hM7Ec+L5Dp0wiG5ld+Bfr98x6o3swnbDSCmt1jdIVWC3TmrIQ
 PxVpnKE5hYRz7pqvV09RDCp0Va+GAWIcF8ss1OSpL6AdL2exRoU1N/ys3FAAX/S8O3+aGc
 diuaCnAkkJiTwyU1vvs2tUt41LV6MFXge5IC63Nz3h1pLupUaFEQfW04wST2Qx1+QRVxPm
 w5PTGapzahlfdbfwl+TCV0tctmGZkMblCDr00teav/w9my8eveX7Y/1aEyKAIQ==
Date: Wed, 19 Nov 2025 18:27:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] boot: Warn users about fdt_high=~0 usage
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
 <20251113154900.GJ6688@bill-the-cat>
 <07424e88-16f8-4332-b93c-f0baeed5758c@mailbox.org>
 <20251116140913.GB2125796@bill-the-cat>
 <e619b3ac-d99a-468c-8275-a8db5b406e62@mailbox.org>
 <20251117143245.GH2125796@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251117143245.GH2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0caa29cdc1d6aceea84
X-MBO-RS-META: xoahoj3ejdyt7em6k4ydwkq1wc1iho9e
X-Rspamd-Queue-Id: 4dBTBp0nDZz9thr
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

On 11/17/25 3:32 PM, Tom Rini wrote:

Hello Tom,

>>> Maybe? I was thinking it should be around this in boot/image-fdt.c:
>>>           /* If fdt_high is set use it to select the relocation address */
>>>           fdt_high = env_get("fdt_high");
>>>           if (fdt_high) {
>>>                   ulong high_addr = hextoul(fdt_high, NULL);
>>>
>>>                   if (high_addr == ~0UL) {
>>>                           /* All ones means use fdt in place */
>>
>> This is exactly the code that this patch modifies . Where in the above do
>> you think this change should be ?
> 
> You're right and I did post the last line of context that's the first
> line of your patch. I really meant that we shouldn't even be checking if
> the current location is misaligned. We should tell people to stop
> disabling relocation.

I see, and in that case, I don't particularly care either way, whether 
we warn always, or only in case of actual problem.

>>> I think really. I am loath to break ABI like this but I'm not entirely
>>> sure we have a choice.
>>
>> We do, we simply warn users and remove the usage and fdt_high=~0 assignments
>> from the tree. The functionality itself does not have to be removed.
> 
> The problem is the functionality has always been for a hack workaround
> and bootm_low/bootm_size/etc were the right answer.
> 
> But maybe step one is just remove the in-tree usage and a big loud
> warning when it's set telling people to not do that.

This is fine by me.

>>> Maybe we detect disabled relocation and
>>> misaligned device tree and fall back to prompt? Or if it's too late,
>>> panic with an explanation? Or maybe we just move it 4 bytes higher. The
>>> device is in a going to fail state anyhow, so trying to recover it might
>>> be OK, and since the device tree needs to be modified by us it has to be
>>> in writable memory.
>> Keep in mind, on arm32 it may not necessarily fail to boot with 4-byte
>> aligned DT.
> 
> I'm pretty sure it is. It's not a problem about doing misaligned reads
> it's that the data structure and it's accessors require 8 byte
> alignment.

I think my knowledge of this corner case was from around this time, so 
old kernel versions might work, new ones will likely break. That is fine 
too.
