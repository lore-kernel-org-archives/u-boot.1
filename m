Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E72C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 07:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771108817B;
	Wed, 15 May 2024 09:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Wfrv37AN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683298817B; Wed, 15 May 2024 09:41:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1EBC8816D
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=71b8=MS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715758865;
 bh=Ke8bN6mBr7S6ZjOh+i98Iv2VmDXIyZYXAifS5PcZbzk=;
 b=Wfrv37ANRsW6JXo+Auma16NRZEcyiI5FZm54KxybSk+SN69+0COy79fuZcjtO+D7HLGNIfQc8
 EDgqpRW4/wBnN8hbJc9NUqY+V0W6iCjiq6dliowQuh3UqvAmOF8ckkcQSCdPQV20P8z6wAB6ACp
 1Y59FZ2ruuNiX5vYzYBNuTV6vqEmZjNmPrVTamH+Jq3EELf3AaW3/DC8Hzwz/O/3m7BMrgExSKc
 5MR3P+9jmogSJiAQIYAyDBk9P/Kh3sUBmGWDi0NUu9UoEfZ9ZC9MXsn+HGSz3aFHBAsKz2qh9kb
 ImjR0wqWFbAcL/N5T04C6JBSLiXjpBYrQsv7uHPBHpkQ==
Message-ID: <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
Date: Wed, 15 May 2024 09:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240514164236.516595-1-trini@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240514164236.516595-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6644646bed12a1b2c55e7d04
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

Hi Tom,

On 2024-05-14 18:42, Tom Rini wrote:> 
> git-subtree-dir: dts/upstream
> git-subtree-split: 7e08733c96c84eb323f47e9b248c924e2ac6272a
> ---
> This moves OF_UPSTREAM to be tracking the v6.9 release and is for the
> -next branch. To test these changes yourself locally, either use my
> "WIP/14May2024-next" branch or run:
> ./dts/update-dts-subtree.sh pull v6.9-dts
> yourself locally. I intend to wait a few days to apply this to -next, to
> give people time to test.
> 

There are currently more boards/SoCs that use OF_UPSTREAM in master
branch than in next branch, a few Rockchip SoCs and other boards/SoCs.
Next dts/upstream sync will probably be good to do together with a merge
of master into next :-)

Also what is the expected sync cadence of dts/upstream? Linux v6.10 will
probably be released shortly after U-Boot v2024.07. So will next sync be
to v6.10-dts if that happens in the U-Boot merge window or do we expect
2024.10 to use v6.9 DTs if the v6.10 release gets delayed and miss the
U-Boot merge window?

Linux kernel typically have all major DT changes in -rc1 and fixes in
later -rcX, so for next branch I would suggest an early sync to a
v6.10-rcX-dts tag, and then sync to the final v6.10-dts tag once v6.10
gets released. That should give more time for testing, migration and
cleanup using v6.10 DTs in time for a 2024.10 release.

Regards,
Jonas
