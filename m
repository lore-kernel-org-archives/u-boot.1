Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C22FCA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A315783829;
	Thu,  4 Sep 2025 10:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QGFp7dcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68418382F; Thu,  4 Sep 2025 10:30:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D878383734
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756974610; x=1757579410; i=xypron.glpk@gmx.de;
 bh=BsNi2tuCY5g3GZ8BTRWGpmXZT6v9riyH141V9yjT/aE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QGFp7dcTrM7ZEVSxnEA+/ZXxQclSSqeCsB8qifXsJ9P5ISIFJg0O7oLAI1WspStg
 L66NOaEiRw4qs+ywHSDyVZcSQxg4NPciSffWZ+57QO4CHUMCxWNl3smx1DXrDiXUA
 o0RRfGidSuV+jFAJ4dgGj1l3tNxNqwWv4i/IkK0abMxWDFE21wT3rcnUih/STS+Jw
 +Gq0kH2fzs1iQSyml3xOmW+75dlGfJcUY1yS851FH8QG4PymjnZ25l12s6MoP0RG/
 ZTliPe79V8mfkeywUDaPNRAzKCT9Ot/Ff7wD340zis8RMzl4VYnNJixdJAnIbeJ1R
 AiDO/aRci6J1E9NNHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1uHBtg2afa-00f5gb; Thu, 04
 Sep 2025 10:30:10 +0200
Message-ID: <0bd7548e-0f7f-4a51-a218-47931303dd7a@gmx.de>
Date: Thu, 4 Sep 2025 10:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut@mailbox.org>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-6-pro@denx.de>
 <21adca4e-834f-479d-a944-e4369c1b8c5e@mailbox.org>
 <aLlMjQb0Qs-VkiaX@aristophanes>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <aLlMjQb0Qs-VkiaX@aristophanes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5To4yeKcUdP5SBi5SOiQzWwPzYjtQ/FmJ7TrdjtIgOXg63wJMDh
 SWhufJHYkVyh/YjqDjOTXcfTO52ngpkN4k1eJbw2XyfZhcJ5OArYHqGaPdYcrmSvPG17gHe
 poPm/8HyeY0xbIj89uJFAwGHM3/1SAHzwayeGRTUSX9mcQQpUpJfNynPud/2rXGkeSFIPkg
 tenipNyuR1kbq8Hn7uO8g==
UI-OutboundReport: notjunk:1;M01:P0:HmQ1OgOfF3s=;4KLwvoAQZFF/UJX4asGcMTRTReX
 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
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

On 9/4/25 10:23, Philip Oberfichtner wrote:
> On Wed, Sep 03, 2025 at 02:59:01PM +0200, Marek Vasut wrote:
>> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
>>> Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change=
.
>>>
>>> Signed-off-by: Philip Oberfichtner <pro@denx.de>
>>> ---
>>>    Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index aa00669ba20..343299eed50 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
>>>    config SPL_SIZE_LIMIT
>>>    	hex "Maximum size of SPL image in bytes"
>>>    	depends on HAS_SPL_SIZE_LIMIT
>>> -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>>>    	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>>> +	default 0x11000 if ARCH_MX6
>> This makes it less obvious what the other case (!256 kiB SRAM SoCs) cov=
ers,
>> why is that an improvement ?
>=20
> This was originally Heinrich's idea. I personally find it better this
> way, but I won't argue about it. Can you please find a consensus the two
> of you?

We can drop the patch.

Best regards

Heinrich
