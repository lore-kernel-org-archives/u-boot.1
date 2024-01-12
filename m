Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA7DC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 18:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372ED87751;
	Fri, 12 Jan 2024 19:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="BTfiswXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4789F8781C; Fri, 12 Jan 2024 19:53:03 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45219876C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 19:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 86239240027
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 19:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1705085580; bh=7uAx1X3if7Cf4wbBM/0WDFqGJeouchbd/5AZxagljPA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
 Content-Transfer-Encoding:From;
 b=BTfiswXiQQYXY3sifAfKDlD5IWjgMH1H2ue1TKC5FPvU4HUR3XY9F8FRnW/7oxBDc
 P+ESj4AovxT6LgaZ7Gk84HPn/mr2KcsHoMqzQ9FqA3ehHXycH5S4AeZbf9GHpQzFde
 ilnZgYoc7S80Q/amQWuboa2eVH13w+W3+l179+a05EWsp6INer9+WMqbC8ei6hjSwX
 YlmBrQ3qvSwmPkg5ZlN/iSbnWWBhHkyB4qIAkImpZyTDAmSWb7D8ZjTUHxMSIKFnE4
 9ncNdSvmOwwyq9XxYz4oLkicyFtDW1Bs5WxMlFwk0ZoDco8E5vfihalZI/lv7GOkub
 8Oi23R+lFWXRQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4TBVzH35SGz9rxB;
 Fri, 12 Jan 2024 19:52:59 +0100 (CET)
Message-ID: <32f3aca5-8d5b-2f63-d60e-f8f0451c380c@posteo.net>
Date: Fri, 12 Jan 2024 18:52:54 +0000
MIME-Version: 1.0
Subject: Re: Please pull u-boot-samsung master
To: Tom Rini <trini@konsulko.com>
References: <CGME20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b@epcas1p3.samsung.com>
 <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
 <20240109155909.GS1610741@bill-the-cat>
 <29757fea-207b-53c8-844f-e76829cf04b3@posteo.net>
 <20240111175723.GK1610741@bill-the-cat>
Content-Language: en-US, de-DE
Cc: mk7.kang@samsung.com, U-Boot <u-boot@lists.denx.de>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240111175723.GK1610741@bill-the-cat>
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

Hi Tom,

I have to apologize, unfortunately I haven't built it for microblaze. I 
will submit a new, fixed version of the patch-series, should I?

Regards
Stefan


On 11.01.24 18:57, Tom Rini wrote:
> On Thu, Jan 11, 2024 at 05:52:33PM +0000, Stefan Bosch wrote:
> 
>> Hi Tom,
>>
>> is there any action required by myself?
> 
> Yes, please rebase the patch and make sure that microblaze builds. Did
> it before with your patch?
> 
>>
>> Stefan
>>
>>
>> On 09.01.24 16:59, Tom Rini wrote:
>>> On Tue, Jan 09, 2024 at 10:55:16AM +0900, Minkyu Kang wrote:
>>>
>>>> Dear Tom,
>>>>
>>>> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:
>>>>
>>>>     Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>     git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>>>>
>>>> for you to fetch changes up to 5631d20e2ef1008d55569790f79672ea8cc6894b:
>>>>
>>>>     pinctrl: exynos: Convert to use livetree API for fdt access (2023-12-07
>>>> 18:58:48 +0900)
>>>>
>>>
>>> The change:
>>> commit 411094b8afd9553eb34efed258c64bc39b578149
>>> Author: Stefan Bosch <stefan_b@posteo.net>
>>> Date:   Mon Nov 27 18:26:08 2023 +0000
>>>
>>>       common: board_f: change calculation of gd->mon_len to fix s5p4418 reloc
>>>
>>> No longer builds for microblaze.
>>>
> 
