Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E98E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 09:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB89980283;
	Thu, 19 Dec 2024 10:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kV4Zon6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF5280295; Thu, 19 Dec 2024 10:42:18 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDD88021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5F6FFA41C8D;
 Thu, 19 Dec 2024 09:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE5C4CECE;
 Thu, 19 Dec 2024 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734601335;
 bh=zMDAk/ZKnPYIJmt0Qagingk94OS+qLxn7z7ea6gJ2hM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kV4Zon6+h5s0amgXrO+5Z5TA9/KPw5kii//2NjKyclVXGwvCzOiTKUydXpCF2zfLT
 OU/xVrB6j8DWUQ0fGsyKY6BqGQiXHpLZsq2bBJGrSxGU1nI1VjFdx7OwoXuTkYlH4l
 tzLAaYSw7yTh7Am5YJ7oNGlVf03OSXefTkk8PpucXoHHNav2OYCtUZiOywKbH8/a1B
 9hYIDSBxH5PAq0UFlG4YcooE2jDPX7xikQ18Cr4wzQh+N7D0DP+QXL0YR+LQLE6W63
 X7iEQx+aLE/1VNE0QaGBOhcldMD0F8yiDg1qUbjdEY9vVCAUfkIPNVJmjM0FFQhYsp
 gfkFj/KHZG3aQ==
Message-ID: <7bfc8dc4-770b-4e83-987e-2e016ffa0cf7@kernel.org>
Date: Thu, 19 Dec 2024 11:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: board: document support for USB DFU boot on
 AM62Px SoC
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, lukma@denx.de,
 n-francis@ti.com, mkorpershoek@baylibre.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-6-s-vadapalli@ti.com>
 <ebc7bc88-1545-4a53-8cd0-1c9812723025@kernel.org>
 <rxpqzluyl7cdpqpujehhej6xycqrcphnkmzppbfq6rmxikcgng@kamzjftilzsy>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <rxpqzluyl7cdpqpujehhej6xycqrcphnkmzppbfq6rmxikcgng@kamzjftilzsy>
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

On 19/12/2024 08:43, Siddharth Vadapalli wrote:
> On Wed, Dec 18, 2024 at 04:08:01PM +0200, Roger Quadros wrote:
> 
> Hello Roger,
> 
>>
>>
>> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> 
> [...]
> 
>>> +DFU based boot
>>> +--------------
>>> +
>>> +To boot the board over DFU, set the switches to DFU mode and connect to the
>>> +USB type C DRD port on the board. After power-on the build artifacts needs to be
>>> +uploaded one by one with a tool like dfu-util.
>>> +
>>> +The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
>>> +upload. The next stages as exposed by U-Boot have target alts matching the name
>>> +of the artifacts, for these a USB reset has to be done after each upload.
>>> +
>>> +When using dfu-util the following commands can be used to boot to a U-Boot shell:
>>> +
>>> +.. prompt:: bash $
>>> +
>>> +  dfu-util -a bootloader -D tiboot3.bin
>>> +  dfu-util -R -a tispl -D tispl.bin
>>> +  dfu-util -R -a u-boot.img -D u-boot.img
>>
>> Is there a known reason why -R was not used for the first command but required in last two?
>> What about if -R is not used for all 3 commands?
> 
> According to the "dfu-util" help menu, the "-R" option is defined as:
> "Issue USB Reset signalling once we're finished"
> 
> While the "-R" option is not required in the first stage / command, it
> is required in the next stages. Without "-R", the user would have to
> press "Ctrl+C" to proceed i.e. tispl.bin / u-boot.img are transferred
> / downloaded onto the device but not executed until user presses "Ctrl+C".
> 
> As to why "-R" is not required in the first stage, I suppose that ROM
> automatically executes tiboot3.bin after it has been transferred.
> 

Thanks Siddharth for the clarification.

-- 
cheers,
-roger

