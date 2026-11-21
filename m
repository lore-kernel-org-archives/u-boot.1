Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E6606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z0OIN34T;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=RutduDow
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FB5C60653;
	Sat, 21 Nov 2026 08:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1mOn_sxjgtiL; Sat, 21 Nov 2026 08:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC04E60604
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795248255;
	b=PZAFS7O97svj+z8XwaRz84JzamV0LmKoIAOeZTVP2A9Ezmwyxu5/nn79xFpx6MfzMo7E
	 PFSbO3aUlA+rgO213cs8UtCQeBb5geqfebPDhHQCd0xRevubGxY9JKJose6yjY8TODxIA
	 6GmxYuGCsTbx6gUXugVbkW7QEKGFrytgGMAXUEswGStz5VgOZXP3kRq55KMgN05s/lkrA
	 AnTmYCgH6Of5mt86RpsD3hp6nHofy1q8+7s1bGJD5Au2AVpVV/HD28/BJ19k0SQRtsXXz
	 txvhR4oVDKiOulRqNeoCgmdRqCACNbmkKiJSqj6d4Q7bAa7Q9NyJcGURQ7MwN5Mbxmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795248255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZNxcZ36P0SwOIfka/neoX3f6/X6SOJshhWzbF2DZuuo=;
	b=Y69e6Xu8seksKX1ixlA9KtDS4CV7IfXxMLpqCfdyKZULc7y9a9Dl/PyXnZrNo6308By0
	 30tu2IRTxL5uygO2tSrfcZ37WlVerMI7VETmqlCWpDQhwUqK/7Q8yV0fbwHFId7dbKKUB
	 Q7uvd7a2aIzM4H8LrB0cdFlGjFJezRATbaH6F4lRbo/IVdKvVRPhT+sT16xNP/f7QAsZe
	 FkuP2axMW61WC2JXRY0n1TCZ+2vAJrdoSz7RpOhKkxAUzOXPPupinJ9IVZeDLex0HhtqK
	 Fdf1dY6tu+V2CZxsHUdpSNb6RYsOBpjm4uLL7ofNTlDKSpCgycBQ7ZSFurOeFZr4H/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795248255;
	bh=ZNxcZ36P0SwOIfka/neoX3f6/X6SOJshhWzbF2DZuuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0OIN34TJUmyjrDlmnbsoIam9USwEisp04SVQaweun1sNqNJVHzL3K327sxUAzx0v
	 avlv+SJQ2hQ6dHJUh5atDcelBHbTZRAIanNAWj/eEp62jnlmfX92xdoouvntbSSKBS
	 EP9P2kk/hF6mAmuDrI9/wGw3/fjMzzfMArGsTfKVk4DmQQvGegoVFOP/l/WEUp4egZ
	 36lFQLAZSVPrXquCiQuT6qJV7T/wvkKWJWdGYPweRZy/LKczQ82MX3wxkyFonCfyqq
	 sKEv+fbgaGAwlvJOIhzT8/ufUFB3RzL3/q/XZ1YP1fu+OZE/RK0Ru7DlSdLlFNf3Ed
	 Bv/pNHpET29Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC04E60604;
	Sat, 21 Nov 2026 08:04:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 553D7465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 08:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 476B540098
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 08:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2qYLSWcm4p5 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 08:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 562BB4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=RutduDow
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 562BB4006F
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795248233;
 bh=ZNxcZ36P0SwOIfka/neoX3f6/X6SOJshhWzbF2DZuuo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RutduDowsOJGJOgypB5s15xppX9mUriAsu2YLwbIH9ihB/tDRBu1R5Sldw1m/lwqa
 ziReFtPpvKYpI/0awJ/XlzwOQyu14hNMUBGmrX38WXnt6TJEoG7+tS7bQSxYPlDbNe
 qHIItFievHsLBRTnUedCOH3QhLtyxwKyrKgfmimr7MaoS8YzFbcm79vtKidNDvBpjv
 zYd9klk4tkFH8XBh2jKdoRXKfedO2fRq5MLLqv6zidolI2EN7JyZJFHM2nWIB5/rK4
 9Gc8pB/VV3bb5vJ0EiLbVhhyAMFD8Ci2bLEHyHXhjO2AD+/kkTswERhA8mQi2gYgm8
 l3Z98uO5eG1CQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id BFC58B221A49;
 Sat, 21 Nov 2026 09:03:52 +0100 (CET)
Message-ID: <530bc058-178e-4181-920c-b5319e48ada2@freeshell.de>
Date: Sat, 21 Nov 2026 00:03:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: spacemit: k3: reduce clock tree for SPL build
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261103-01-k3-clock-spl-support-v2-1-09a0b28e902f@kernel.org>
 <20261121030534-GKB156439@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261121030534-GKB156439@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 19:05, Yixun Lan wrote:
> Hi All,
> 
> 
> On 11:07 Tue 03 Nov     , Yixun Lan wrote:
>> Due to SPL image running in a memory space constraint SRAM environment,
>> so reduce the whole clock tree a bit to make it fit for final runtime
>> requirement, only a subset clock tree is registered, which includes UART,
>> SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
>> full clock tree is retained in non-SPL build.
>>
> I'd like to drop or postpone this patch for now, the goal was trying
> to reduce the code size of clock driver especially for SPL phase which
> both target for persistent NOR flash storage and run-time memory consumption
>  space.. but tested on actual board found, there is enough space.. so
> leave it as is for now
> 

For persistent NOR flash storage support the FSL SPI driver needs
updated in u-boot from mainline Linux. There's some lesser improvements
to it in u-boot now that probably need discussed and sent to Linux as well.

> 
>> Where surviving SPL CCU definitions reference parent clocks outside
>> that subset tree, it will use "clock-dummy" as name of clock parent to
>> ensure the framework still successfully resolves the parent clock lookup.
>>
> For above using "clock-dummy" clock, will send a separate patch for it,
> so will fix the unresolved clock tree warning..
> 
>> Signed-off-by: Yixun Lan <dlan@kernel.org>
>> ---
>> Changes in v2:
>> - add gpio clock
>> - fix tswi8 clock
>> - enable sdh0 clock
>> - Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org
>> ---
>>  drivers/clk/spacemit/clk-k3.c | 209 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 190 insertions(+), 19 deletions(-)
>>
> 
> ...
> 

FYI not including clock tree reduction or parent dummy clock
substitution, for what I understand the "bsp-spi" reduced vendor SPL
build I document at:

https://lore.kernel.org/u-boot/20261029003327.1890979-1-e@freeshell.de/

...fails to detect SPI NOR flash when K3 SoC has ran in BootROM SPL
Loader "UART" mode;   It is successful when ran in BootROM SPL Loader
"USB" (fastboot compatible) mode. There is some peripheral setup done by
the BootROM code in one or the other that persists through and should be
considered when testing. I would guess that re-sync of the source code
in u-boot for FSL SPI driver from mainline Linux, and port of the
SpacemiT K1/K3 specific FSL SPI glue code, would be a next step to
getting working SPI flash from within u-boot main app u-boot.itb

What SPL build are you using for testing?

-E
