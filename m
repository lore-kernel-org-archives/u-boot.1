Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA48F4613B
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466C184144;
	Mon, 23 Mar 2026 16:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="TnzbM3k1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9979F8408D; Mon, 23 Mar 2026 15:58:57 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EDF28406D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 115A6105FF7; Mon, 23 Mar 2026 15:58:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774277933;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2bpWZA7dZCn1Ctkapcd2Ux14ks5HJnloMTA22pqRQus=;
 b=TnzbM3k1bThh4GPeUWHrcbqBrrtUCfWYWveB+EfJ+g5jbJqLjziqPfFPGuUJWOkiOT39Od
 /a9JZBwFeNbXLYBQeUiVQJip3WCuwbcXbprEChKlETPalnH2fBFfQuHJzxMnNwPh8qr18I
 X4lUG+4rsdvNxqDWKSQWbkaMRUqetfm3Lei0sdQ/ObmciBG4ZBSuBiGE1GL378oj9A/UqJ
 KpndU8A1ol+bGHltB/+74jDwpGTrn1xF7oj/9fKVC0aeK4bAjJ+qP3aeHE6yZSV+5sIu1S
 LLU+FSGWFbbO0UWr+90Pb9J4WJbf9TQDY6Xts/kndG3e6SV1IA+AQ9jSaNwoSg==
Message-ID: <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
Date: Mon, 23 Mar 2026 15:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
 <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
 <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
 <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 23 Mar 2026 16:12:08 +0100
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

On 3/23/26 11:07 AM, Christoph Niedermaier wrote:

[...]

>> The priority is this:
>> - ENV -- because user can override the content, and user override is
>> highest prio
>> - Device not enabled in DT, do nothing
>> - Fuses, (newly first fuse block 1 , then) fuse block 0 -- because
>> in-SoC fuses always have to take precedence over the external EEPROM
>> - EEPROM, first block 1, then block 0 -- because this is what is usually
>> programmed out of factory, anything higher priority is up to the user
> 
> The SoM is delivered with both MAC addresses coming from DH electronics provided
> by EEPROMs. If a customer wants his own MAC, they can fuse the MAC address to
> override it permanently, but referring to your suggestion if the customer only
> fuse one MAC address the behavior depends on which MAC address is fused.
> 
> Fuse only the first MAC address:
> - 1. Ethernet: MAC is taken from FUSE 0
> - 2. Ethernet: MAC is taken from FUSE 0 + incremented by one
> 
> Fuse only the second MAC address:
> - 1. Ethernet: MAC is taken from EEPROM
> - 2. Ethernet: MAC is taken from FUSE 1
> 
> The problem is that we have a customer with SoMs where only the first MAC address
> was sequentially fused from a MAC address pool. That means the second MAC address
> of the SoM is the same MAC address as the MAC address from the next SoM's first
> MAC address. This patch prevents this by setting the MAC addresses independently
> of one another. Then for the second MAC address the DH electronics MAC from the
> EEPROM is used. In this patch the fallback where the first MAC address incremented
> by one is used should not occur on the customer side, as the SoMs are shipped with
> MAC addresses in the EEPROMs. If this does occur, however due to an EEPROM read
> error or whatever this patch could be improved by a warning message.
I don't understand this last sentence, can you please rephrase ? Keep in 
mind, not all MX8MP DHCOM were populated with both EEPROMs, the rev.100 
only had one EEPROM on them.

As for the rest, it really boils down to the ordering of fallbacks, it 
is either:

A)
fuse1
eeprom1
fuse0+1
eeprom0+1

or

B)
fuse1
fuse0+1
eeprom1
eeprom0+1

The following ordering, which is the ordering introduced by this patch, 
is confusing:

fuse1
eeprom1
eeprom0+1
fuse0+1

So please pick either A) or B) above. I do not see any particular 
advantage of either of the other, except maybe B) improves boot time in 
case both fuse blocks are blown, because it avoids the EEPROM I2C access.
