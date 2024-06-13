Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EB2C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 07:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E1F87FA7;
	Thu, 13 Jun 2024 09:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718263927;
	bh=IP5j6GjeKagwXcmUsy6lINx6BN17VXVBeSf7Fc/o2O0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oEP96AJ3FSvBg/G4lMaVyBeIANQAnQNw2j+Kuk0qP8CzkW+if+bW8gx6V16x5YBwB
	 10l8Kg/hg3g8eprgDGnFsYLfD2m/8USmQXRRAWw4oJ/o9/pzmbG90ZftvlICt+sB+g
	 VbOfsQYrxe4w4bfmYnUgix0pMh1tclNPSCLzoGkQhUNky/SznXIrScakwFv7e8r2qn
	 y2qW9/KGKzNfctn/MpUnESjcRBE6jNnYWZ9628b7B2PjHKPmC6KzLxPtrDZka0jcwt
	 2SaiAMk0cNBhZ4Xqj61EffJVn4pmtx4upN1Lg8AGcKSnWsQ9UVrMc0WSOEiiX6mRNj
	 L4wtoCm6ZUpIA==
Received: from [10.88.0.65] (dslb-002-207-026-217.002.207.pools.vodafone-ip.de
 [2.207.26.217])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8013A87E2E;
 Thu, 13 Jun 2024 09:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718263926;
 bh=IP5j6GjeKagwXcmUsy6lINx6BN17VXVBeSf7Fc/o2O0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e4g4IoAZqDZfTNUKynJ4eFoAkrAK4MJJHH/BZHhTPLqb7tn8nI1pwjAVh7lUZnKI8
 mM7HyeH/+Ot+wVljXs3hqOmdTLTioxb8YVLhLTIkblG5ZsvNBBSqpNneNdyaMeMumd
 htSlBGUFkyqfqdinmOJFwnFwIRTvtuuEMOCzRpqARXbbjgkVpfWD22E5Mg+IEt4fQO
 Bmk87SnGZYb3Nsd2JWi63kD+yIJ8I8W9xG2wdd1xd4mrXL2PjIBoLZjTVU0Fvi3IrP
 wjej2jlQXcj7w9GCM/brShgFN6qLIOTYw1riwaP/qxG4i9IvORbAedTUfsQtAPcSTs
 u9s0fhy0Wzc6g==
Message-ID: <fff4530f-1730-4a54-a934-c1998425eca8@denx.de>
Date: Thu, 13 Jun 2024 09:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
 <738ebfbc-aefd-478a-a49a-5763e2e24e71@prevas.dk>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <738ebfbc-aefd-478a-a49a-5763e2e24e71@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Rasmus,

On 2024-06-12 1:18 pm, Rasmus Villemoes wrote:
> On 12/06/2024 12.20, Claudius Heine wrote:
>> Hi everyone,
>>
>> in the past we used cgit, which provided cloning the u-boot repo via
>> http, https, ssh and the git protocol.
>>
>> When we migrated to gitlab, which doesn't support the git protocol, we
>> implemented some additional service files to continue to support it for
>> some of our git repositories.
>>
>> We just noticed that cloning via the git protocol is currently broken,
>> likely some changes in gitlab happened and we would need to recreate the
>> symlinks on the server to point to the right repositories again.
>>
>> Since that is another thing to maintain and keep up, we would like to
>> just shut the git protocol down. AFAIK most projects moved to use https
>> for cloning anyway, since there were not many reports of broken cloning.
>>
>> What are your thoughts? Is it worth the effort to keep the git protocol up?
> 
> So I don't think you should necessarily keep the git:// working if it
> means extra maintenance. I just checked a couple of my local copies of
> u-boot.git (don't ask, it's many different customer projects) and it
> seems to be more or less random if I added upstream with git:// or
> https:// . I can certainly change those, and thanks for the heads up.
> 
> I'm just wondering if it's possible to have the server send some message
> to the client when the git protocol is used, for some deprecation period
> (6 months?), so a developer doing "git remote update" will get notified.
> He would then also have a chance to propagate that to whatever local CI
> he's responsible for, instead of only noticing when things do start
> breaking.

We are using `git-daemon` and there is a `--accept-hook` which can print 
a single line to the requestor, but only if the request is denied.
So there doesn't seem to be a way to implement a deprecation period.

regards,
Claudius

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
