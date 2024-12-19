Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38756E7718B
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 09:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4FD8021D;
	Thu, 19 Dec 2024 10:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pKcUEnjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F378022B; Thu, 19 Dec 2024 10:38:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7E58021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6E2615C67D7;
 Thu, 19 Dec 2024 09:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA4EC4CECE;
 Thu, 19 Dec 2024 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734601110;
 bh=p1U5Y72CaZCn9tQQixo18wkmsaDG1MFKLuDsNnWHdhk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pKcUEnjm2Rkn3uHDcBFuOR+Y/8hzGlqJmQwDLScfS30eqXMxFzDamy0pmbp9Cws/g
 lOQ2PhNzgSeMRL6x/fyIOakHODyEEG7LxPhFUTD1+Uvimv646Vinsb5EvNe0LnAjgo
 qmzvl0AOZU9GxZPqwEXGhJpp6GfaIz0jzzQisxwHPhO44J6KJuRF6CoQOUIeJa0uKt
 Mul3SceK7htwz63y/qQzJexxMP4e+cQYFQI+HFKkT/ufDN+pc6E2bmprxSYh8fdblN
 c+RiTYxjCTNPMvOzWameCGzwXN4XA4nzbHdax+wBFwiiaHwSv+SiYVSw1Tk0rLyMVA
 SKRgLUp6fuFOg==
Message-ID: <8d3bc864-3181-424c-9941-cf44ec0ec475@kernel.org>
Date: Thu, 19 Dec 2024 11:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] configs: am62px_evm_a53_defconfig: enable USB DFU
 support
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, lukma@denx.de,
 n-francis@ti.com, mkorpershoek@baylibre.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-4-s-vadapalli@ti.com>
 <7ac41391-b295-4601-94e5-5c18090d65cd@kernel.org>
 <ymjr6iwzuo3dbh7iyhb42u7p3gwbpu2of47eunkax5zbjtarku@dfzyblcdhnp7>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ymjr6iwzuo3dbh7iyhb42u7p3gwbpu2of47eunkax5zbjtarku@dfzyblcdhnp7>
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

Hi Siddharth,

On 19/12/2024 07:43, Siddharth Vadapalli wrote:
> On Wed, Dec 18, 2024 at 03:47:20PM +0200, Roger Quadros wrote:
> 
> Hello Roger,
> 
>> Hi Siddharth,
>>
>> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
>>> The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
>>> for AM62x SoC is applicable to the AM62Px SoC as well. Hence, include it
>>
>> Apparently "am62x_a53_usbdfu.config" adds USB Host and Gadget and DFU support.
> 
> Do you propose that the Host configs should be moved into the respective
> defconfigs of SoCs which include am62x_a53_usbdfu.config, while dropping
> them from am62x_a53_usbdfu.config? Please let me know. This can be
> implemented by a separate series if that is what you are suggesting.

No. The commit that introduced am62x_a53_usbdfu.config mentions that it is
for USB Host and Gadget and DFU.

Your commit message seems to indicate that it is for DFU.
I leave it to you if you want to update the commit message or not.

> 
> Regards,
> Siddharth.

-- 
cheers,
-roger

