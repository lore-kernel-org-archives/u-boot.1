Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843BBCD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 14:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC28D847B0;
	Tue,  9 Jun 2026 16:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FcfrWp+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFE68485F; Tue,  9 Jun 2026 16:23:45 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7068884704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 16:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chleroy@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4445D600AB;
 Tue,  9 Jun 2026 14:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E7F1F00893;
 Tue,  9 Jun 2026 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781015021;
 bh=VWR6BWk0P1Kj3yu7gLKUxOSRaRjhrEP5nzO15a/ODSE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FcfrWp+FoVZGdO2kDWYfUiHF+dj3UWA1OERFm+Iv4WA8+Y/g/HEwFqpuqb7pusnmo
 sbhVwA33gLBhhte4GF1we8z1+zXQnr7Pe+gg/c2tI1G8dpvoKyBR2OkZE3GPZ/+pGX
 fIvY1lfrMtQ8oIB+NlAelyc6XwVKT+jJh4I8aXeucFBaCGCaqcUkTEhPylMJ6MjLTW
 tLx2h6YZtSPWFPlEM4Cr9ohhUKgEjgpRKu0jodAIeK5f6Q8l4/w8u+6TrYoyMD+xyp
 r6Gt80iK8Ao8aQ55x1bk8HLTSkj6wZ0uB7+xFodFdoQFHWeP/lItLyV+VSSZ9iRqX6
 6dPdzbXsn4xLQ==
Message-ID: <465fc13b-28a8-4ac5-90c1-e10c0a342a7d@kernel.org>
Date: Tue, 9 Jun 2026 16:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
 <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
 <20260604230951.GX627328@bill-the-cat>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260604230951.GX627328@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 05/06/2026 à 01:09, Tom Rini a écrit :
> On Fri, Jun 05, 2026 at 12:31:10AM +0200, Marek Vasut wrote:
>> On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
>>> Currently, the bi_dram[] information is stored in the board info
>>> structure (bd). Because bd is only valid after reserve_board(),
>>> dram_init_banksize() must be called late in the initialization process.
>>> This limitation is problematic, as it forces us to rely on a variety of
>>> bespoke functions to determine board RAM, bank memory sizes, and other
>>> early setup requirements.
>>>
>>> By moving bi_dram[] into the global data (gd), we can run it earlier.
>>> This is particularly convenient since boards define their own
>>> dram_init_banksize() routines, which do not always rely on parsing
>>> Device Tree (DT) memory nodes.
>>>
>>> Additionally, U-Boot defaults to relocating to the top of the first memory
>>> bank. While boards currently use custom functions to override this
>>> behavior, having the DRAM bank information available earlier in gd makes
>>> relocating to a different bank trivial and standardizes the process.
>> Regarding the BD, this is likely really old, but it seems BD might be passed
>> from U-Boot to Linux somehow ? See [1] and U-Boot
>> include/asm-generic/u-boot.h :
>>
>>   8  * NOTE: This header file defines an interface to U-Boot. Including
>>   9  * this (unmodified) header file in another file is considered normal
>> 10  * use of U-Boot, and does *not* fall under the heading of "derived
>> 11  * work".
>>
>> Are we certain we are not breaking ABI here ?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/ppcboot.h
> 
> I've added in Christophe as the maintainer of one of the active and in
> some ways oldest (since MPC8xx is very old) PowerPC platforms we still
> actively support. A tested-by on this series that also includes
> verifying Linux still comes up would be much appreciated.

Traveling at the moment. I will try to give it a go in a couple weeks.

> 
> My suspicion is that anything DT-based shouldn't change here, and in
> turn if you're doing modern U-Boot you're probably doing
> not-extremely-ancient kernel and so DT based booting.
> 

Linux receives a pointer to the device tree from U-boot, nothing else as 
far as I know.

Christophe
