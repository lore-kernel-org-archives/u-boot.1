Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EADC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F758805B;
	Tue,  5 Mar 2024 14:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="HLN8ul4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102E088062; Tue,  5 Mar 2024 14:39:31 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A20F88057
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709645968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MiyqJcsf3lMGkkocqqRzuqOuEj2tqT0IXvLXdYprrWE=;
 b=HLN8ul4wVMawq/J+mz97M+f9Pt8X5NQnigLyb0aMDKDhFC8gpsy5yeD4SpYqVAf+yBL3/C
 NHPC/+nJGEWXtDR4Q934JSOzwgrH1wEpsdkxSaOLM45NWfxdE7iSM2aCm5EfIssDC7Y0xR
 G/UPxJmxNc4meTun0AqR0gliLX5wY/MP3E0FDLpSEmg3JM9C4+zP6Yf+Nl+gge/jmw07CS
 5IxMuDPeBKzeR2hSQ7H+GpRQTksfq7Xe38/tyY/jnaktPA4wopCBN8x73fztQ16zKpVTND
 lnshmvuQjKk+4cMmvd8WvTi8CW1Aaz6txxDjwMRiINCmwQcdGXcQ+vkyrOHYcQ==
Date: Tue, 05 Mar 2024 14:39:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Trevor Woerner <twoerner@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>
Subject: Re: [PATCH] configs: rockchip: rock5b: enable environment
In-Reply-To: <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-4-twoerner@gmail.com>
 <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
 <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
Message-ID: <d8d1cf0d32ceedc82938638730f69fd2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello all,

On 2024-03-05 10:36, Christopher Obbard wrote:
> On Tue, 2024-03-05 at 10:31 +0100, Jonas Karlman wrote:
>> On 2024-03-05 03:10, Trevor Woerner wrote:
>> > Following the pattern of other Rockchip devices, enable the U-Boot
>> > environment to be stored in MMC. This patch specifically assumes the
>> > environment will be stored on the SDcard.
>> 
>> This board has SPI flash, so storing env in SPI flash is probably a
>> better default.
> 
> I agree with that.
> 
>> However, preferably the env should be stored/loaded from
>> the same device that TPL/SPL was loaded from.
> 
> Do you know if there is some mechanism in U-Boot to do this already ?
> 
> It could be useful to enable autodetection on many boards which can 
> boot U-
> Boot from either SPI flash / eMMC / SD card.

I agree that doing this on all Rockchip boards should be the way to go, 
or
perhaps to use the device that the U-Boot proper was loaded from.

Moreover, it would, for example, allow a microSD card to be used as a 
rescue
boot media for the users to recover from a borked environment.
