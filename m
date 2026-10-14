Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253ECC6B1C
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1DF6608DA;
	Thu, 15 Oct 2026 04:06:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAOmRL0t3nox; Thu, 15 Oct 2026 04:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DFE3608BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792037207;
	b=ftad/njD7CLnPYIOPmsXKNUPbKcfinz8RoCYtJ0KzW6wPEzi1TOHDvz0WDPphxBW+FYW
	 pJamtYF7l2YcMu+w1Jzdo3h2+vhi1X9ku76i6RXCjHSoOxsbJfNQFvUrEyX/jrMZhgxoO
	 T5vQGP/68joxEyoUgp+LHc5Z51red5P6FJseOWajcWPQSruh3Kyavd82bERhz72NUs1uA
	 uT4pUzcxyPZpRefNFcygOooqZdZOL2s6nyhGlx8XHoT+/9dAHfKWWdmAX2yhAmkMxosLx
	 yZd66djpgEpWDTMISDbpRouUHUAMqQmmg+yH5bwhuJrCSZ98cLYKKH0n8DQ+sJ+pzwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792037207;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2kB4ah0QTNJQXXc74cA0AYLOlmyXfqEcgUquopKY4sk=;
	b=U4LQSvAmsqreRbFibDDRaTnemmpm/LuoBNP88v0eKTEjNSaTQaFy5MpViuEGjWiqnaJP
	 19Ky8h7XLAj6sUOG6rREE563ARE4zRr/PfKZcKqsKAJzR9E+7Wo7PUToxQYy9Pv4fHLHi
	 GkP+sLwSAvuAdyeUE1ocPKcZkATbVFY0QuAreB4lepTaSNpvW1s5WuMuW2k1lGxJqgeDY
	 jmNyUU6agboSFZWgwAe4LM/LVf8nFjXVNHRCR8LyTn0abPgmgVL0e/MjAxaKTUhvBQuTX
	 dlKhNb1ljsNgKrk5lA5WCwXjJNM/wqWOPi5MRYnqbIwROkf4JxtLDkxBsT5d3Geh5SA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792037207;
	bh=2kB4ah0QTNJQXXc74cA0AYLOlmyXfqEcgUquopKY4sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nDwvz0fLneGKQNcNFKVx50W4PDkbmNZGn6Jvjg2LAOqXLj6FrrDkz8kfQu+GnGdAj
	 yxeSJpeOwQD9P8hydPXw/IO+Sq9SxLgA9YjSrf32o1upmkQPFVKhALa1plsBcC76R2
	 TojLjviV+cIm2TCU2JpBtXxhJpvgPNQgNhwt0mydUJtT/+mxyQJWc20g8OdJ19FOjT
	 VtZcjZuhOdOvtlZ7Y92B9kYyudhnhfBVsc23MNGF2nl+RDHqsgMYEU0KHlw2TLkvXJ
	 1mH61HWX2pX4LLktIbUfxpyw5VIVXGvdTPb7LVl3FrtIzpXBgn3BZx1L+Fde5ZZnwQ
	 15hqzmnlVwuDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DFE3608BA;
	Thu, 15 Oct 2026 04:06:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F462255
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9120780F84
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b0jHMprm9ShO for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 04:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CA2980F3F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792037204;
 b=gQAUP8L8wgwCiyaYq9X8ziCW3ejdyRB6xidvOGlSUzIDcle+FULWbxuuF5hrWb53X/mo
 iynjelsm02/Mwr4wODSbisa7MUjA9FeCvluPReloOrVo/SulWHtk97yf5TavXYhnD+ZgE
 DLpko3GIcHJjJQNbRie5SlxgqZZFUxh/QG4PAlmmzB5brujND8P7fg2r9A3iz4e7UfcGz
 Kz253io9QJjQD8K4hcBV2wTy+QZ4LMy5xDOUJPfncUANVb65fq/jrXWLGeNHIkTqVxmw6
 0nK/3N451DbNab6QfR1ABbo/JNEv0NO+tzt1wf14yV5ytuIbDO9zUxTlQRFrZ80AJtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792037204;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=2kB4ah0QTNJQXXc74cA0AYLOlmyXfqEcgUquopKY4sk=;
 b=MNwarzWcANgUP22rPI54XsP56khsd1QOPIQ3I2QaBv+V9YtFzTMrMRzH6/0KXHaWbUZ9
 S6GTiDkOQJVnT4s5mFdPQeWfiBZOj7OXFzQD+ppy14+FK1cGocsa16i+tpatSWBoVkfhS
 kBxnFpetfjEDHg3iwz65e3a/Tiz6jNFOqmwC+9S+VVrQ2+mkRJwHe1mTTDR96Gs02vb5o
 N8Y44Oll/4ZPdtsmFBBR8nYjnULXchrm1z2LTzRUcf+F6wbnACO9AtXO/XBjAO/PCpgvK
 o2nY2TCkjoMzadjSnJvFjms7NYEuC6xXJJjj7gF4LlPxSyrXK/2ZBO9wVWlIc3zAO0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nejRdCFQ; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nejRdCFQ
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CA2980F3F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:06:42 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j4vdq1HX5zMlQf;
 Thu, 15 Oct 2026 06:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792037199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kB4ah0QTNJQXXc74cA0AYLOlmyXfqEcgUquopKY4sk=;
 b=nejRdCFQSzwJNyODyIXLFOAJEdxbRdlwUeZkk/xxze5aAO0ttLI0jg7LwKSiVbAC42FDnZ
 atcBd9FKDxCefEOZwrO/lfz0xiV1bllAOReV/Gzz6urtyFHX6ckBZIuVUqGnB7fsdhiHSj
 617CSkbfRxUMT7g5q9THaqbCD+3ZkdP85/kSlHZbcaZXouDoC8RamZuFykZhnwI2LGCOTy
 ZT7tlvloAe1HEQBRhitO+JH9FDrYau5z99ReEq7hFXUFxp5UnUvEynzJ6Q5zgoDyBPb6jW
 CHTYtoLiqHUwiBAmz+OPuiqOazCffMea/HFlR9Xyb7m5uly6fNGtAfREjqHpvQ==
Message-ID: <401765e6-3eba-4795-b05f-80c8351f4e4e@mailbox.org>
Date: Wed, 14 Oct 2026 12:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
 <MFdJqIFZlw7IIf1Jj2LsvEA5c04izFohJgFJlOWk6AmReo362WRLQeEFh8KgY1DFFup2bV5iyOo06KmvI_2hEw==@protonmail.internalid>
 <179192278169.4115168.10731444024331979767.b4-ty@konsulko.com>
 <87pkxc1t94.fsf@rasmusvillemoes.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87pkxc1t94.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: w3xz6eiq47uxptedpye4rmmxfenfj3eu
X-MBO-RS-ID: b475838e1f104bfa2ba
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/14/26 12:17 PM, Rasmus Villemoes wrote:
> On Tue, Oct 13 2026, "Tom Rini" <trini@konsulko.com> wrote:
> 
>> On Tue, 29 Sep 2026 19:31:59 +0200, Marek Vasut wrote:
>>
>>> Add empty string Kconfig option, which depends on CMD_CONFIG and lets
>>> user embed a short piece of text into the U-Boot config, which is then
>>> printed by the "config" command as part of the embedded .config.
>>>
>>> This can be used for example to embed OE /etc/os-release into the U-Boot
>>> binary, which can then be used to identify the exact OE build from which
>>> the U-Boot build was built from:
>>>
>>> [...]
>>
>> Applied to u-boot/main, thanks!
>>
>> [1/1] cmd: config: Add additional embedded text option
>>        commit: 400e46a0df848db66ceaf3ece26786f689789163
> 
> Late to the party, but I don't really see how the existing
> CONFIG_LOCALVERSION doesn't satisfy the described use case.

LOCALVERSION is also attached at the end of U-Boot version string, that 
is NOT what I want.

> Is it because LOCALVERSION is for some inline string meant for inclusion
> in the U-Boot banner (i.e. inherently a single line), while this is
> meant for some multi-line additional info?
> 
> I think gating this on CONFIG_CMD_CONFIG and using the config command to
> print it, including the \n escapes, and then pasting that through echo
> -e to get those interpreted, is all somewhat roundabout. It seems that
> one can obtain the same effect by unconditionally having this config
> option, obviously defaulting to the empty string, and then extending
> cmd/version.c doing something like
> 
> diff --git a/cmd/version.c b/cmd/version.c
> index 62406608eb0..ef70087f3f6 100644
> --- a/cmd/version.c
> +++ b/cmd/version.c
> @@ -27,6 +27,10 @@ static int do_version(struct cmd_tbl *cmdtp, int flag, int argc,
>   #endif
>   #ifdef CONFIG_SYS_COREBOOT
>          printf("coreboot-%s (%s)\n", lib_sysinfo.version, lib_sysinfo.build);
> +#endif
> +#if defined(CONFIG_CMD_CONFIG_EXTRA_TEXT)
> +       if (CONFIG_CMD_CONFIG_EXTRA_TEXT[0])
> +               puts(CONFIG_CMD_CONFIG_EXTRA_TEXT);
>   #endif
>          return 0;
>   }
> 
> Then the extra version info is printed in human-readable form
> immediately, and there's no change in the binary size when the string is
> empty [*].
> 
> So I suggest renaming this option to something that doesn't tie it to
> CONFIG_CMD_CONFIG and doing the above - that also makes it usable by
> boards that for some reason cannot afford the ~10k increase by enabling
> CONFIG_CMD_CONFIG. If it is unconditionally defined, the #if defined
> guard above can be dropped. CONFIG_VERSION_EXTRA?
> CONFIG_VERSION_FREEFORM? Dunno.
> 
> [*] Unfortunately, we build with -fno-builtin, so the compiler
> doesn't even recognize strlen("some literal") > 0 as a compile-time
> constant.
It is deliberately tied to CMD_CONFIG exactly to avoid growing size of 
existing boards. We could do this in a separate command or subcommand 
which would be yet another variant of CMD_CONFIG, but I wanted to avoid 
that duplication.
