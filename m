Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C690EC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FFD86242;
	Tue, 21 May 2024 10:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716280954;
	bh=snUoNDpafK/rELOLwqiJi5C8mh9CnLdBP/LZTefePQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HHNpKhg2aitQ3MZ5DWNOGgjDY0yVJ6e4Fhpn0jgAKXPLnvHGR3wS9D1CnRnua0M4L
	 Eaxgg2rhZGMMmvuLmfczLj9HV5S5AaeNxP+kqy7B+mifBfd+vqLAbUSzWb+p/atIIk
	 Jv0WW9OeHiRDibLTtMfXmE0JKBNZNTPmkokFC+mOQiqmRYIRBd6WFMyRSs+IpmJhj9
	 iZKTyhmrHG0Pz4pbO8xgm5AxD3i9FWvhFWmbrfnmEWhLuJIJ9JYLP+wjo1MmtHMH+P
	 hgyxUwsClHD6nJynUOrbu5COPRPUaVqf+9VlmyMSrWEV6FP2vfbZ0/O0TVQ9qVqbYH
	 eI9sS3CEn9GeA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6205187FD7; Tue, 21 May 2024 10:42:33 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD412841BC
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Vk7Gt3W70z9snZ;
 Tue, 21 May 2024 10:42:30 +0200 (CEST)
Message-ID: <785b0ed7-980d-4ad2-8b68-88923fa5ee21@denx.de>
Date: Tue, 21 May 2024 10:42:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
 <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
 <7f45eeed-4bcd-4a3a-9663-133a20c182f7@denx.de>
 <948d94a1-e97b-460d-8c83-4133eaebd2ff@prevas.dk>
 <4cb6b424-e61e-419a-ba42-53296de13277@denx.de>
 <b4dd54e5-9653-44eb-a505-1862da7fbee1@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <b4dd54e5-9653-44eb-a505-1862da7fbee1@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/21/24 10:38, Rasmus Villemoes wrote:
> On 21/05/2024 08.57, Stefan Roese wrote:
>> On 5/19/24 21:44, Rasmus Villemoes wrote:
>>> On 18/05/2024 09.34, Stefan Roese wrote:
>>>
>>>> This introduces some problems when compiling e.g. sandbox:
>>>>
>>>> In file included from test/common/cyclic.c:10:
>>>> test/common/cyclic.c: In function ‘dm_test_cyclic_running’:
>>>> test/common/cyclic.c:25:42: warning: passing argument 1 of
>>>> ‘cyclic_register’ from incompatible pointer type
>>>> [-Wincompatible-pointer-types]
>>>>      25 |         ut_assertnonnull(cyclic_register(cyclic_test, 10 *
>>>> 1000,
>>>> "cyclic_demo",
>>>>         |                                          ^~~~~~~~~~~
>>>>         |                                          |
>>>>         |                                          void (*)(void *)
>>>> include/test/ut.h:298:29: note: in definition of macro
>>>> ‘ut_assertnonnull’
>>> [...]
>>>>
>>>> Could you please also change the test file accordingly? I'll then
>>>> try to get this upstream shortly.
>>>
>>> Whoops, I don't know how I managed to miss that when grepping for users.
>>> Sorry about that. Updated version coming shortly.
>>
>> Thanks. Still the new version also fails in the CI build. I'm using
>> MS Azure for this, here the link to the failing build:
>>
>> https://dev.azure.com/sr0718/u-boot/_build/results?buildId=355&view=results
> 
> Apparently I'm blind, the full definition of 'struct cyclic_info' was
> not guarded by CONFIG_CYCLIC.

Yes, I already "played" a bit here but still got other problems.

>> Could you please make sure that CI fully builds?
> 
> Is there a way I can trigger that from my side without sending patches?

You need to have an azure account and push a branch with your patches
into your u-boot repo to trigger the CI build. Gitlab also is possible
AFAIK.

>> BTW: Not sure if I still can pull this (updated version) in, since I'm
>> leaving for a 2 week vacation tomorrow morning.
> 
> NP, I should have been more careful. I'll send an updated version in a
> moment anyway.

Thanks,
Stefan
