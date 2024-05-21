Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DD0C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 11:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86404880A1;
	Tue, 21 May 2024 13:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716292504;
	bh=BU3HEmWzng80hhgTqqC8PRA7Kne/OkzBOZDGB3PboEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n612Ig0ipscssE76nPoqybm+eLqVjT3KL1vi+vdNm4OhWdFdWr6e6fVCQ5eikUFq6
	 JViS6YvRLp3imQnjdYST2csxN+tquJRLjLSwyMhU8GmfFh7VUriVPh84D9okUosLq0
	 tXx9z64gX5r0WbmTmMSxNdjwFqHKaItbVA7q7Ass7ZIRW8ZRreODwWPvjpYZLj3/o5
	 16rOOHN+elc2NFyMWrEmaYtDV1AR19AEcvXOUDypP8sO2iuOzrXD1pcQb6Q1i3+9an
	 zU0Dc3fOb1qZ+90iJQsb2kW+YqQqeoMfQF+cLX1TKDeTmTNeDkOGNpkF2Yf84nue7r
	 qye8Whfdlrxqw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD63A8873A; Tue, 21 May 2024 13:55:03 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FDA88080
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 13:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VkCY105dHz9srS;
 Tue, 21 May 2024 13:55:01 +0200 (CEST)
Message-ID: <97ec64c3-7323-4886-9623-77b4bc28dfff@denx.de>
Date: Tue, 21 May 2024 13:54:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] cyclic/watchdog patches
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
 <ce12ad50-bd54-499e-965c-5693355a4e84@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <ce12ad50-bd54-499e-965c-5693355a4e84@prevas.dk>
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

On 5/21/24 11:47, Rasmus Villemoes wrote:
> On 21/05/2024 10.46, Rasmus Villemoes wrote:
>> A bit of a mixed bag. I've been wanting to submit something like 3/3
>> for a while. So when I stumbled on Marek's patch
>> https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
>> , I got reminded of that plan, and I think that patch could be more
>> readable if we adopt this model.
>>
>> While actually doing those mostly mechanical changes, I stumbled on
>> two separate issues that probably want fixing regardless of the fate
>> of 3/3.
>>
>> Mostly just compile-tested, and now also checked that at least the
>> sandbox test runs succesfully, and that it builds both with and
>> without CONFIG_CYCLIC.
> 
> So I managed to trigger an azure test by pushing to github and creating
> a dummy PR: https://github.com/u-boot/u-boot/pull/542
> 
> That fails, and while it involves the cyclic framework, I'm pretty sure
> these patches are not to blame, since the same error also exists in
> other pipelines. It's an "expect" failure, because some watchdog
> callback apparently sometimes takes more than 1ms, so the default 1000us
> threshold is exceeded, and that prints a warning which breaks the "expect".
> 
> An example is
> 
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8459&view=logs&j=a1270dec-081b-5c65-5cd5-5e915a842596&t=69f6cf72-86f3-551a-807d-f28f62a1426f&l=1055
> .
> 
> I don't know why it only/mostly seems to happen in clang builds, but I
> think the fact that these happen quite frequently warrants either
> bumping the threshold used in the CI builds quite a lot, or adding a
> config option to suppress that warning/limit altogether for CI builds.

I've also seen CI build issues from time to time and restarting the
build magically solved these issues. I'm all for making this CI
build more stable, perhaps Tom has some ideas?

Regarding this cyclic patch:

Still some problems, MIPS64 related at least, octeon_nic23 target:

https://dev.azure.com/sr0718/0cded7c3-6e6a-4b57-8d0f-65c99496c42f/_apis/build/builds/357/logs/415

Thanks,
Stefan
