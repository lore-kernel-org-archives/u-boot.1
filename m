Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB7D3A667
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 08:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C38891E7;
	Wed, 30 Oct 2024 09:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="X8YQNGhz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRPJaDZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BD2891EB; Wed, 30 Oct 2024 09:55:02 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E82F891DD
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 09:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BC57025400C8;
 Wed, 30 Oct 2024 04:54:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1730278498; x=1730364898; bh=lYs7RaWAv6
 FqUIkmwxMo+URzvu0ctWvQzYMN3rv4uJM=; b=X8YQNGhzoTmuwGy23O3rG7x0i6
 dH7oHGloPXEcKmci20vDCTHEg/7LUhvPsBxu3+UHcDjfXQCdMkw2TS3LGKmlValH
 XcMTWvjeviIIL56oMXgfLlVSj+dJRP3ZzHnCK/0k2fvADZ4+pZO/I6hSTNbN5Wvb
 LKCtIOWa3aqsECNUm/6LQFh20weXNTLer1t/DDQa8Q3UCvMMWK3RTXKa0lzov/a5
 Zgz9rtLhvCbh55RiCAdvTjsEQpkKtTwY4GV5MLSVlsSCX78PJZ0iM3suSzAHz9AU
 5SFGvJ4LtyfwRDZWoUt3bNiH9ZqNMJK+gfbS09ObKHDMwoK/lEWA3TR27SFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730278498; x=1730364898; bh=lYs7RaWAv6FqUIkmwxMo+URzvu0ctWvQzYM
 N3rv4uJM=; b=LRPJaDZKUJzU4AVvXUxixx8IKzQOXjuiaLUcjKVUPgbhMJY9UV4
 35tvivpCYMnTBfuRrBAeiITMG98XLLzFGsuoOKPcONC0CAMej2lTOko6pTaVFePq
 zaGYbKV0E13Bpd7R0afcS2N/hgtWJB0DHrQMxbGJIE/1Sjeo9gf+RjxeuVJ3Qh00
 tROuJVqaw/rWbJ1FvOJ8Y04RN2W9hDMY54U2PhYAp9AIh1eVEK1tz+tczCxIKIJX
 1mGqXUy32JABnOmOAx0RzWfe7njdYVOYDyMYLoN0I7hYA/SOhAzFqhN6K09YcPEf
 ddxul1UMi55lcZdFBLhJ8CfFYRaezT/cT/A==
X-ME-Sender: <xms:YvQhZ-J4bdRvSLHRYRgsGX5144FZnK9wtqLT2y6ecCqq2o_Vs3AAtA>
 <xme:YvQhZ2KghYG05zfnUWMzoIdvLP4KfcuAM_K0EqdmjT-o9Wb-pebGnClfh5GjzC6bo
 MuMyK98EPtaOD9hj9A>
X-ME-Received: <xmr:YvQhZ-uttQFKgXl_fQsejmZrXpns4yAksDGqHHBc6d4H39R59bwKMk4zbK-pykeh8ob4RiMwyI_ozWUJnJD2Y3dwz7SaZLSZs-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddguddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
 tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehsuhhghhhoshhhrdhgrghnuheslhhinhgrrhhord
 horhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghp
 thhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtohepthhrih
 hniheskhhonhhsuhhlkhhordgtohhm
X-ME-Proxy: <xmx:YvQhZzabI1jUfaK_TKxRkADI0g8JSGgGgA8visG1FYJCd5hKfV6VaQ>
 <xmx:YvQhZ1Zep6pgg9hYM0o0Ek5IVIzRf3HNjaa3-yMJMdyOgpsp5-Aegw>
 <xmx:YvQhZ_AKMxTRJpD30f5jNwenS7QH7XER8COODijx2gUNuY3XYhbRVw>
 <xmx:YvQhZ7bZbB2uh-hRrCwMrV4PCmb1HrkxgwkLrwguOSsqiX4u0jrffQ>
 <xmx:YvQhZ0WpfzxnhWQvDqYzB8ukAVojYqji2t7b4idjT40sc5p0cMV5k7PG>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 04:54:57 -0400 (EDT)
Date: Wed, 30 Oct 2024 09:54:56 +0100
From: Janne Grunau <j@jannau.net>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH 2/2] apple: dart: use driver specific instance of LMB
Message-ID: <ZyH0YCUFWdcZV_Hd@robin>
References: <20241029071846.514559-1-sughosh.ganu@linaro.org>
 <20241029071846.514559-3-sughosh.ganu@linaro.org>
 <ZyCdj5x3RS_djKqk@robin>
 <CADg8p94Kc13KHdZxJ1-rhkSWzOY=QBDfPsSnQdQzmLpcfzy+VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADg8p94Kc13KHdZxJ1-rhkSWzOY=QBDfPsSnQdQzmLpcfzy+VA@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 02:22:53PM +0530, Sughosh Ganu wrote:
> On Tue, 29 Oct 2024 at 14:02, Janne Grunau <j@jannau.net> wrote:
> >
> > On Tue, Oct 29, 2024 at 12:48:46PM +0530, Sughosh Ganu wrote:
> > > The LMB module is typically used for managing the platform's RAM
> > > memory. RAM memory gets added to the module's memory map, and
> > > subsequently allocated through various LMB API's.
> > >
> > > The IOMMU driver for the apple platforms also uses the LMB API's for
> > > allocating device virtual addresses(VA). These addresses are different
> > > from the RAM addresses, and cannot be added to the RAM memory map. Add
> > > a separate instance of LMB memory map for the device VA's, which gets
> > > managed by the IOMMU driver. Use lmb_push() and lmb_pop() functions to
> > > set-up the relevant lmb instance.
> >
> > thanks, this fixes the initial brokenness when setting up dma mappings
> > but I still see SError due to translation fault. I don't have time right
> > now to look into it so it could be unrelated to the iommu.
> 
> Good to know. Thanks for testing the changes.

It's SError-ing on `dc zva` of an invalid address which somehow got into
the main lmb. I don't see how but it went away with my minimal io_lmb
implemenmtation exposing lmb_setup, lmb_add, lmb_alloc, lmb_free.

I'm not too happy about this approach since it's a little fragile with
respect to the global struct lmb. to be somewhat safe we would need to
reorder lmb.c to avoid `static struct lmb lmb;` is visible in "shared"
code to avoid using it by surprise in the middle of functions like in
_lmb_alloc_base().

I'll post patches later today.

Janne
