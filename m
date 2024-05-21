Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D065C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 06:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A638E8803E;
	Tue, 21 May 2024 08:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716274651;
	bh=/Ci1BGYUcjRCj4BdJa7KbM0X12EobYZ/SDt8HFugCjE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6lHDaXWzl9Wx1VEm1NqbNwYg01LViZY+EBeaCfffz+hDpjigH9N0SsacPSrl5n4z
	 Qgb3rYIOHtVFTjJhbq+TqCpXN+ZBCnvT+ggwBpfW7rMU8Cx1mlm0tDBRlwFI0KWkmh
	 E5rH5/uXTQImR0080NpwPlj3tWpzByQBJKmtH0SzTLbOF3pkkAtW5A13KT+pxr4HAU
	 o6uIFBMPG97mBEd7+rItJywxx358FKL3uAKRtZtW6F2dmQLze3QglVu8wpQHvHubzP
	 4g+0s/bVmwPZpCXlFMWAGRnXT3EZ1x4FhLIZ7vlOAYyGKiP8sYLlnSsZwxEfQr6K3v
	 AGoiMhnMdklQQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AF588323; Tue, 21 May 2024 08:57:30 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AD187E1D
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 08:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Vk4xg65gYz9t4p;
 Tue, 21 May 2024 08:57:27 +0200 (CEST)
Message-ID: <4cb6b424-e61e-419a-ba42-53296de13277@denx.de>
Date: Tue, 21 May 2024 08:57:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
 <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
 <7f45eeed-4bcd-4a3a-9663-133a20c182f7@denx.de>
 <948d94a1-e97b-460d-8c83-4133eaebd2ff@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <948d94a1-e97b-460d-8c83-4133eaebd2ff@prevas.dk>
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

On 5/19/24 21:44, Rasmus Villemoes wrote:
> On 18/05/2024 09.34, Stefan Roese wrote:
> 
>> This introduces some problems when compiling e.g. sandbox:
>>
>> In file included from test/common/cyclic.c:10:
>> test/common/cyclic.c: In function ‘dm_test_cyclic_running’:
>> test/common/cyclic.c:25:42: warning: passing argument 1 of
>> ‘cyclic_register’ from incompatible pointer type
>> [-Wincompatible-pointer-types]
>>     25 |         ut_assertnonnull(cyclic_register(cyclic_test, 10 * 1000,
>> "cyclic_demo",
>>        |                                          ^~~~~~~~~~~
>>        |                                          |
>>        |                                          void (*)(void *)
>> include/test/ut.h:298:29: note: in definition of macro ‘ut_assertnonnull’
> [...]
>>
>> Could you please also change the test file accordingly? I'll then
>> try to get this upstream shortly.
> 
> Whoops, I don't know how I managed to miss that when grepping for users.
> Sorry about that. Updated version coming shortly.

Thanks. Still the new version also fails in the CI build. I'm using
MS Azure for this, here the link to the failing build:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=355&view=results

Could you please make sure that CI fully builds?

BTW: Not sure if I still can pull this (updated version) in, since I'm
leaving for a 2 week vacation tomorrow morning.

Thanks,
Stefan
