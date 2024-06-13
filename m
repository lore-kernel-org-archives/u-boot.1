Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F62C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 14:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC19888FA;
	Thu, 13 Jun 2024 16:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718288035;
	bh=RF5DCU1b+sdoMol80sobuOT+JWbUqoG33w+J5FO66OQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BC+WRTfPbmllgiyEmT/aG0H2/qO+topkPui0nAwrTRWleJKcSe52xFaOzfNOVU+aq
	 kRj37B+lAitEn//J9/R6VZ86LjlScB2oZly1El3gZatwoAlkLBjJtTjsi+xSaDGCpH
	 kogD4IxNTUosG+2PN846SCMc7LJrJ3jGk0Fvyad+HAUE/G+klVb58DqbDBowE0dDQX
	 F0FMBTcZoSniQ0Ug0+apsfi78YVgmFHM4mpiZD9Tfoo5BWbUlmVOK669LgLTFJoLtY
	 Ns0myOOARu/BTN9vbc17l2saZqddtsujTOrxYDXwvk+Ov0U2Q96h2JYnmrMuEsND90
	 UNJPy30a1Tyiw==
Received: from [10.88.0.65] (dslb-002-207-026-217.002.207.pools.vodafone-ip.de
 [2.207.26.217])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 78A4A888F6;
 Thu, 13 Jun 2024 16:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718288033;
 bh=RF5DCU1b+sdoMol80sobuOT+JWbUqoG33w+J5FO66OQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kuA2Ssm4Q7sR0ULX/ut9PBBKNrdpSuoRzLG54ihtTlLVYu6a2GHfyXCM8Rv730bBP
 bi5q6WM5rBcvr7XoGPCECHS2SZ3qsJcGBQ0QaQZlipSVvj3SQUqW5ATPtpotzxPrzy
 7taci82UJ7xJTzThXFLA3hK/Gte9v+Ukp9n/zNEdw9ABZD9sZg5Pmn+XxfQQxxOgaC
 7mmjMoh5xsz5XqBBZR6cryWLabdPfT6vQSpvvYp0sIproTFuEsmG3kpZmesyhy/MMd
 OfBjIWmDEOYh+kiRsr76PTf4cGXlYeS7WT0hPnDFSdITAH4uq1OguiDfxC28zdATWX
 PJ33ypI9NT2Eg==
Message-ID: <da7fac68-6684-4932-89c1-594913832fb9@denx.de>
Date: Thu, 13 Jun 2024 16:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Marek Vasut <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
 <94d1e571-6051-4a1a-b15a-ab5147ada833@cherry.de>
 <814d2716-bc77-494a-871e-1bf3ee466d6b@denx.de>
 <ea1f5d07-aaba-42a6-96f7-e90b370ff4ae@denx.de>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <ea1f5d07-aaba-42a6-96f7-e90b370ff4ae@denx.de>
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

Hi Marek,

On 2024-06-13 3:12 pm, Marek Vasut wrote:
> On 6/13/24 9:49 AM, Claudius Heine wrote:
> 
> Hi,
> 
> [...]
> 
>>> Also, while I checked OE-Core, other third party/community maintained 
>>> layer could be impacted. I assume this is the case of 
>>> meta-amarula-engicam[1] and meta-allwinner-hx[2] for example.
>>>
>>> I would suggest sending a mail to the different build systems mailing 
>>> lists, I assume https://lists.openembedded.org/g/openembedded-devel 
>>> and https://lists.yoctoproject.org/g/yocto for the OE-Core/YP side? 
>>> Either to ask for their opinion or notify them (and specifically 
>>> third party layers) it's going away or both.
>>
>> Not sure if I want to go through them all. Looking into all these 3rd 
>> party, downstream repos and informing everyone seems to be even more 
>> effort than maintaining the git protocol.
>>
>> And if someone uses their repo, they will notice it quickly and can 
>> easily fix it.
> 
> I very much agree, that ^ is probably the best way to go.
> 
> If some legacy repository breaks, fix the repository, hopefully there 
> aren't too many of those to fix. Github deprecated git protocol a few 
> years back and users managed too, except the fallout here is much 
> smaller as it affects only one recipe (or a few).
> 
> I suspect the following patch to oe-core (or local.conf equivalent) 
> might also entirely mitigate the issue by providing https fallback 
> automatically, without the need to modify the legacy layer/recipe ?
> 
> If so, maybe this could be added to OE LTS releases at least ?
> 
> "
> diff --git a/meta/classes-global/mirrors.bbclass 
> b/meta/classes-global/mirrors.bbclass
> index 862648eec5..50a14c5881 100644
> --- a/meta/classes-global/mirrors.bbclass
> +++ b/meta/classes-global/mirrors.bbclass
> @@ -77,6 +77,7 @@ https?://downloads.yoctoproject.org/mirror/sources/ 
> https://mirrors.kernel.org/y
> 
>   MIRRORS += "\
>   git://salsa.debian.org/.*     
> git://salsa.debian.org/PATH;protocol=https \
> +git://git.denx.de/.*          git://git.denx.de/PATH;protocol=https \

Well the path will change a bit as well:

git://git.denx.de/u-boot.git -> https://source.denx.de/u-boot/u-boot.git
git://git.denx.de/u-boot-efi.git -> 
https://source.denx.de/u-boot/custodians/u-boot-efi.git
git://git.denx.de/xenomai.git -> https://source.denx.de/xenomai/xenomai.git
git://git.denx.de/mxssb.git -> https://source.denx.de/denx/mxssb.git

If we want to make it perfect, it will be more difficult than that.

>   git://git.gnome.org/.* git://gitlab.gnome.org/GNOME/PATH;protocol=https \
>   git://git.infradead.org/.*    
> git://git.infraroot.at/PATH;protocol=https \
>   git://.*/.*                   git://HOST/PATH;protocol=https \
> "
> 
>> Anyway, I fixed it yesterday, and it doesn't make much sense to stop 
>> it now. So I will leave it in place until it breaks again, then I just 
>> remove it.
> 
> Do you know how long it was actually broken ? (i.e. how long nobody 
> noticed and complained about it?)

So since 3rd of June, so about 5-8 days or so until someone noticed.

I mean I could make it fail 10% of the time, and issue a deprecation 
notice, and then raise that percentage each month a bit higher... Maybe 
some kind of scaling, the fewer people use it in a certain time, the 
oftener it fails... :D

regards,
Claudius

-- 
DENX Software Engineering GmbHt,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
