Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E536FC87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 14:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1E8832C8;
	Mon, 11 Aug 2025 16:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YO1jWjdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A30C8331B; Mon, 11 Aug 2025 16:25:12 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E07832BF
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 16:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c0xjw4LZnz9st5;
 Mon, 11 Aug 2025 16:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754922308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/4QF9k00NKBpQCRh2S3oDOnXxjwsvUzS3QQUp3x0Vs=;
 b=YO1jWjdDWipEQmbrRmtXgEyWrfiY4T6lcxlBypfp6yn/S+Du3KXXWYmlRJaAWLUxTbuFxl
 O2rz51DTxfZGnhtmBZDlHtxiBl6JlBZQtvtM/Q5gqpIRKsEGcsDKBf9+D9YXAcdefYEs45
 B7tnE3IVwvJHlxwL7xvMmMYT3uNE5UyLucxWmiG1EBDcPxwIdxR2NeGbXVj+ar+0rrAibp
 gv2l0BDQ2Yr2rSh+E9SnWZuCEltgtVzhM8nyhLW0bxGWrk429vICnpFD7pqJKvzP9AMUKt
 ip3HtTcSDnO9gMriD/z5/xHFJzUEUUOEb1nwiz8ORssmxVVrywiFUJ04uKzpkw==
Message-ID: <63434f64-3633-49a7-91cf-69f52b43c0e7@mailbox.org>
Date: Mon, 11 Aug 2025 16:25:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] Image size checks: Simplify help text
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-4-pro@denx.de>
 <1d3e5573-7e36-4050-88e8-90d31e5253a9@mailbox.org> <aJmwfBL48AzuFra8@antares>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aJmwfBL48AzuFra8@antares>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3rsx6pa8ksrxjp8b9zy7rzqedjx87pdc
X-MBO-RS-ID: d9ccfa6ca291c5f45b9
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

On 8/11/25 10:57 AM, Philip Oberfichtner wrote:
> On Thu, Aug 07, 2025 at 03:41:57PM +0200, Marek Vasut wrote:
>> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
>>> For coherency, use the same help text for all related size checks
>>> options. Furthermore, simplify the depends-on logic.
>>>
>>> Signed-off-by: Philip Oberfichtner <pro@denx.de>
>>> ---
>>>
>>> Notes:
>>>       Changes in v2: new
>>>
>>>    Kconfig | 8 +++-----
>>>    1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index ec20603883b..490a706101a 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -543,10 +543,8 @@ config BOARD_SIZE_LIMIT
>>>    	default 1048576 if RCAR_64
>>>    	default 0
>>>    	help
>>> -	  Maximum size of the U-Boot image. When defined, the build system
>>> -	  checks that the actual size does not exceed it.  This does not
>>> -	  include SPL nor TPL, on platforms that use that functionality, they
>>> -	  have separate options to restrict size.
>>> +	  Specifies the maximum length of the U-Boot image.
>>> +	  If this value is zero, it is ignored.
>>
>> This makes the description less accurate, sorry, NAK.
> 
> What about using just the first half:
> 
> 	Maximum size of the U-Boot image. When defined, the build system
> 	checks that the actual size does not exceed it.
> 	[plus/minus treatment of the value zero]
> 
> And dropping the remainder "This does not include ..."?
Why would removing the SPL/TPL clarification be any improvement ?
