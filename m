Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F996C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938E2879BD;
	Mon, 22 Jan 2024 12:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705923949;
	bh=x7uQh8S30QYFBdsrMLCh6v9qOOrjbv/KoESkTnsmGig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sgBpZrBY3BFzpmkejjhs6WjDU105oa+uGfr9ZiqR15kA+E4IVxiC7DExE8XVjQcd8
	 a/pA77a++wmTyli6VcVhpBQfvnLuYV9VMnpUffg3HaVspjQPdSzJDsoWnYLz1NDDgZ
	 jItFaWqwm3d4RKXr+bjW47zp0XdfwNnGWyN0jzFQNsY5tLQE8GzdOrAgqofjtWQsKm
	 BrGNq/5MohVkKeZaUu5GMpDsYUQaR1iMgF3fQ3v+5WQ3rPiqODCNWYlAMSHlwQpl25
	 x6T8TLNEw52FGylJ8jAJX3uYgZ6CSLJlNt/qvBz0KiNgZzrqOnK2nthJolH6Zh+vt0
	 GgCc7Ev6ZUslQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBCD879BD; Mon, 22 Jan 2024 12:45:48 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0108878EC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TJT1g3bbXz9skF;
 Mon, 22 Jan 2024 12:45:43 +0100 (CET)
Message-ID: <792da0b2-39af-4ec4-87b7-54e339b31a36@denx.de>
Date: Mon, 22 Jan 2024 12:45:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Josua Mayer <josua@solid-run.com>
Cc: Dennis Gilmore <dgilmore@redhat.com>, u-boot@lists.denx.de
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
 <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
 <20240113172236.GI1610741@bill-the-cat>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240113172236.GI1610741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Josua,

On 1/13/24 18:22, Tom Rini wrote:
> On Sat, Jan 13, 2024 at 05:36:57PM +0100, Josua Mayer wrote:
> 
>> Add a new defconfig based on existing helios4_config file to support
>> booting from spi flash.
>>
>> Settings for environment location are based on vendor u-boot:
>> https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios4.h#L59
>>
>> A separate defconfig is required because the options are not
>> intuitive from menuconfig, numeric values in particular.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> ---
>>   configs/helios4_spi_defconfig | 81 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 81 insertions(+)
> 
> So, a super new thing that might be of interest, but please try this
> since I'd like to prove/disprove the use-case.  This could instead be:
> configs/helios4_spi_defconfig:
> #include "configs/helios4_defconfig"
> ... enable/disable options specific to the SPI boot use case ...
> 
> And so now both boards will otherwise be kept in-sync for general config
> changes.  It could further be done as:
> configs/helios4_spi_defconfig:
> #include "configs/helios4_defconfig"
> #include "board/kobol/helios4/spiboot.config"
> 
> And have board/kobol/helios4/spiboot.config contain the SPI-boot
> specific options.  This path would allow for:
> make helios4_defconfig spiboot.config
> to be a valid alternative way of configuring a build for spiboot.

That would be cool.

Still:
The current version leads to this compilation warning:

WARNING: no maintainers for 'helios4_spi'

Please fix in v2.

Thanks,
Stefan

BTW: Could you please also Cc me directly with such patches?
