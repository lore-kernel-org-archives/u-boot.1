Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DAFCAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 21:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87168808AF;
	Tue, 23 Sep 2025 23:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4861833ED; Tue, 23 Sep 2025 23:23:48 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A02E80107
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 23:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.228])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 59651B220170;
 Tue, 23 Sep 2025 23:23:44 +0200 (CEST)
Message-ID: <acc7b448-f459-437d-a231-8bbf689f2195@freeshell.de>
Date: Tue, 23 Sep 2025 14:23:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] env: spi: Fix gd->env_valid for the first write
To: Marek Vasut <marek.vasut@mailbox.org>, Michal Simek
 <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
 <e05c9282-1736-4056-97b7-939b913dbfd4@mailbox.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <e05c9282-1736-4056-97b7-939b913dbfd4@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 9/22/25 11:47, Marek Vasut wrote:
> On 9/22/25 6:03 PM, Michal Simek wrote:
>> When both SPI environment locations are invalid (gd->env_valid ==
>> ENV_INVALID), the first call to saveenv writes to the primary location
>> and
>> sets the active flag. However, the logic for updating gd->env_valid
>> incorrectly sets it to ENV_REDUND, which does not match the actual
>> location
>> written. This causes the first two writes to target the same location,
>> and
>> alternation only begins after the second write.
>>
>> Update the logic to alternate gd->env_valid based on whether the last
>> write
>> was to the primary or redundant location, ensuring the first write sets
>> ENV_VALID and subsequent writes alternate as expected. This aligns
>> env_valid with the actual storage location and fixes the alternation
>> sequence from the first write.
>>
>> With this change, the "Valid environment" printout correctly reflects the
>> active location after each save, and the alternation between primary and
>> redundant locations works as intended from the start.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Comments from
https://lore.kernel.org/u-boot/e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de/T/#m114473aa0a28a08b150aef2dbed028200472fdf2
linked here.  Nits about the grammar overloading of "alternation" which
could be improved.

Best regards,

-E
