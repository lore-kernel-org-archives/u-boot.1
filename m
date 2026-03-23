Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE72D58CBF
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A1A8405B;
	Mon, 23 Mar 2026 23:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="W2TVAywj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6DC84207; Mon, 23 Mar 2026 18:27:15 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ABF483BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 18:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F410010C6E0; Mon, 23 Mar 2026 18:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774286830;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NRV5sBhIOvYp8U/ee+OWpi2WpSKa19C4gfBOFVsKBBE=;
 b=W2TVAywjk5dfsScpqv76rTW0WsHNDlWGU4lF8adCJfAaU030EbBFa8Y/t+YAhplM5GcMoT
 GtrXg+jMz/B6SSVRLVHhn2Ssba0uSJO7Sf47MW7wTgaXQKNHhAoLv0JDSx18zpCERG279y
 k31o4U/fVBi08yyB/obREIEn4yQbJ8r3ni+aCJA8a0642yUIk2bEElc9PzzT8ovI6zRCru
 UcLp3AuGKakCnuytBSAKsZ5ArkcbN9p2+TXk5eQWfEPbfBaL9uJdOPr7k5ncANZ86y7+Rf
 9CrVtn6g4NBmUjE3NZCjwF1wu1Xwp7t+vCzk6PLAgFX4cMEETXqKMucqV411cQ==
Message-ID: <2dca42bf-a247-4190-9439-14e14f65aec3@nabladev.com>
Date: Mon, 23 Mar 2026 18:20:39 +0100
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
 <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
 <a7ebfe912f084176b79c54a2e9e3d8e3@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <a7ebfe912f084176b79c54a2e9e3d8e3@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 23 Mar 2026 23:56:20 +0100
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

On 3/23/26 5:49 PM, Christoph Niedermaier wrote:

[...]

>> As for the rest, it really boils down to the ordering of fallbacks, it
>> is either:
>>
>> A)
>> fuse1
>> eeprom1
>> fuse0+1
>> eeprom0+1
>>
>> or
>>
>> B)
>> fuse1
>> fuse0+1
>> eeprom1
>> eeprom0+1
>>
>> The following ordering, which is the ordering introduced by this patch,
>> is confusing:
>>
>> fuse1
>> eeprom1
>> eeprom0+1
>> fuse0+1
>>
>> So please pick either A) or B) above. I do not see any particular
>> advantage of either of the other, except maybe B) improves boot time in
>> case both fuse blocks are blown, because it avoids the EEPROM I2C access.
> 
> The prevention of I2C access is only a one time effect, because then the
> MAC addresses will provided by the environment.

Which increases the system boot time, which is undesired.

> If I remove the eeprom0+1, because it was for prototype configurations,
> my preferred order would be:
> 
> fuse1
> eeprom1
> fuse0+1
eeprom0 can not be removed, that breaks backward compatibility. And the 
ordering of fuse-eeprom-fuse is confusing and has the boot time increase 
downside of A).

I would say B) is the way to go, it should also cover your requirements, 
keeps the boot time low if both fuse banks are fused (which can be fixed 
even on existing hardware, simply read out eeprom content and fuse it 
into fuse bank 1), and it retains the priority ordering (env, fuse, 
eeprom) without mixing it up.
