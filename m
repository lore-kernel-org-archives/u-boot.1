Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075D4C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 19:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D86780E94;
	Wed,  5 Mar 2025 20:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tTu191+8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ri8e+lnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0CF80ECC; Wed,  5 Mar 2025 20:50:58 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28539808A2
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 20:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z7NTC6NCjz9t1x;
 Wed,  5 Mar 2025 20:50:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8ahUvM4AhUDrDuWbKtSRADFb4G5ZNjyivRWHStdpIo=;
 b=tTu191+8S8QrYoseAx7ZZ6LZ2Fl9OskS8/OWt8HZiH0JQoZyaMrEHsqPJy2WjtTQrpek+Y
 9X1aIOSeN17XdNYRHzA5Pm/oLU74OANz9Qa84Q6CEtazMYws09cc6tzmJc8oGCf7O05mjW
 44BLRaU0h1x/mK9hW4cqMpWETCuyJ3D3egw/+BT86DXgkHxAghjUcdwOxkoCICnRFFK7Me
 FkpHCRY9bhJWf+autYG/J6jqaKF7ouls3lHqy1wNHNlloak7UjAjSjCF4UbX+2/C7lvbFv
 4ZzbmCZR2WZHA8UWBqSdL3702DH8gCvkFGboT1usZqCWUekF0ENzyS73aST9HQ==
Message-ID: <debb5963-ca43-40b5-ac32-1c7e5caa6a62@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8ahUvM4AhUDrDuWbKtSRADFb4G5ZNjyivRWHStdpIo=;
 b=ri8e+lnUXmTKxQh8WKMf6k9SB/6Y2sNn51nWLc652EbWTYN2AHx0R9HPdQwf3ma1JznmYo
 xSIHod15ImrA+VGvcCUtx/wTpExk4SFyikgzHy0ihGQ2pXTlAwD5jIzu7Ctj2UXbIETutk
 nH8U1iLikMj/KDDSbhvfJloeIULztBBtPbBV7RgEuleDzTQ2pQ4z9OTsQbS0cT3C/+eXVD
 ajoRdrRv+MS2mDeZyGvBUHtjA/SWBhjXceffsFmX52Q1mcMcWUmx5cwLzhN+ctjAOulOfk
 +DoiLMTHVtXWA8w0fSHlBLhX5kbBdCPIcYay6/RFAUfk+oArip2jiv8wP0JsPQ==
Date: Wed, 5 Mar 2025 20:50:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] arm64: renesas: Add TFA BL31 handoff support on
 Renesas R-Car Gen4
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250302210000.777581-1-marek.vasut+renesas@mailbox.org>
 <d5e121b9-02b4-4548-9aa7-47dbd2e7098d@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <d5e121b9-02b4-4548-9aa7-47dbd2e7098d@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fe3215c63f30c36314b
X-MBO-RS-META: 9x3k99eiujkp868srysybso3dm631ep5
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

On 3/3/25 10:44 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

[...]

>>   board/renesas/common/gen4-common.c | 126 +++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>
>> diff --git a/board/renesas/common/gen4-common.c b/board/renesas/ 
>> common/gen4-common.c
>> index 52a0639073b..f7d129be4c8 100644
>> --- a/board/renesas/common/gen4-common.c
>> +++ b/board/renesas/common/gen4-common.c
> 
> I'm wondering if it really makes sense to have this in board/? If I 
> understood correctly, this is all SoC-specific? So shouldn't that rather 
> be in arch/arm/mach-renesas maybe? So that boards based on an R-Car gen4 
> SoC don't have to set SYS_VENDOR to renesas or copy the code in their 
> own board/<vendor>/common directory?
> 
> What do you think?

Once it gets thoroughly tested on the other SoCs, then it can be moved 
into more generic location, sure.

-- 
Best regards,
Marek Vasut
