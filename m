Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B902ECCFA1A
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 19:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381F683F26;
	Sun,  9 Nov 2025 20:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jbsoQzHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D05683F26; Sun,  9 Nov 2025 20:01:38 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DAC83F24
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 20:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d4MbL54Fwz9t46;
 Sun,  9 Nov 2025 20:01:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762714894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtjC9oQEsQ9ZkbSw2nd6A3c5wmQHAJD8Wd9efyddKJ4=;
 b=jbsoQzHDmxTFpjks6WrFRZ64pdOd2tJ/KwKXgC9M9e/rOx0IbHaOEK3jah6GtXkayk/x14
 8oOgBWIIrc9m778IpSVJQtOgg+Tp0lESEaaqPlvCE1KlUIAZ796ZxKYpDovdSEpymcEdC0
 M/C1C6+QdXMX478fD/wsdPYrRPOa2fcvvgGk3XcHsozbpZVqISdBGgSz9pOXtDCSn7zT37
 BNLUk0DHIf2RP52TIv8YH2AR7PafYU+nZ4JRXWLXRU+7msXk0vhSD+4fl3+t+cPXEhbnZY
 qtYPl6+RGi+S+qP+y3XH14opXQI8yGIUa8deq//GEoH+qQhwjNJTDXvsi7Jkog==
Message-ID: <4cd587dc-da4d-4645-9a6a-fd14dcf15de8@mailbox.org>
Date: Sun, 9 Nov 2025 20:01:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] spi-nor: add support for XM25QH01D
To: Ssunk <ssunkkan@gmail.com>
Cc: Takahiro.Kuwano@infineon.com, jagan@amarulasolutions.com,
 pratyush@kernel.org, trini@konsulko.com, tudor.ambarus@linaro.org,
 u-boot@lists.denx.de, vigneshr@ti.com
References: <fda19051-7b72-4f11-aa8e-b8eb70ff04b7@mailbox.org>
 <20251104110307.3993-1-ssunkkan@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251104110307.3993-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1aae8d4cff0917dd7c9
X-MBO-RS-META: 7ybgo7harpr3ags8zkany7c1ez6ioj35
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

On 11/4/25 12:03 PM, Ssunk wrote:
> Hello Marek,

Hi,

>> I'm sorry, my original suggestion was unclear.
>>
>> If you want to sort the whole XMC part list, then please do 2-patch
>> series, sort the list in patch 1/2 and then add the chip in 2/2 .
> 
> Thanks for the clarification!
> 
> Actually, I don’t intend to sort the whole XMC flash list — I only want to
> add the new XM25QH01D entry. Would it be acceptable if I just place it in the
> appropriate position without reordering the rest of the list?
Sure, this is fine by me. But please also try to get input from the 
subsystem maintainers.
