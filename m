Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F90C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 07:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA048834B;
	Thu, 13 Jun 2024 09:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718264955;
	bh=98MN392AhcmuxzSemJPddLTSljNsVkVozioENg4LvX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3j6I4XVFp1jeOTT2FLy1pEgjxO+PHc3YKIAEh4eygdIWRtb4ASc9tYwFkKqbmCVV
	 89PiNWk/53otxDcGlxU0MzosT8UnXzSEiC7UAfBM0zBrkBeIZFsY5hnr0qxXP3GWB4
	 wL49hkiLhvSY1rQkhWLPBwLbauT2SSw7giPfP5dCdgLwx2zZMb5NE7a36QCf76+DrU
	 UIxMCChm7PlJ4/MMyqdAnYNaHSnHMcdY86+y4HoiEFEy686/CtV3IYm2QpyhqILwtk
	 g4L/hK3wPFTroiwiSkQt0FK8p7pxQpqB++BQSU1OUwF3MlCPIqH9H710kbMlDMc0ZH
	 QWzi3am+ACj7w==
Received: from [10.88.0.65] (dslb-002-207-026-217.002.207.pools.vodafone-ip.de
 [2.207.26.217])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3CCAC88315;
 Thu, 13 Jun 2024 09:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718264953;
 bh=98MN392AhcmuxzSemJPddLTSljNsVkVozioENg4LvX0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BpNCwlSMaHo/0CNUn4MH63ENIg3dk+ulsS6oD+6AaVNnIPA3yMjcdCF3xL+AgkFtn
 o2GaJ6iif98+2vxOhelgT9LRjXW6FIROsNx++9rSf2tQP9WLQyxDvvnALBieWYnvAh
 eY1UFQmJtI+qKnDnMCEuukKXOx3y3BGcQ1FFDeXoSrm46bGLCF95hrOLIXvBrJQ7cz
 +nGJ9qxouJOVK2MckaiK3+XFl6dvBms2dws3BX9OhV+xHhDs936/OhtXyD4dEmGAlJ
 OBswnbVtmp+j59cCDUj2ekZhtiwG4mM6fq86t/ou8+7t3MMM2rvfCetppyWigfMYQY
 bEZ30EU6M/iSg==
Message-ID: <814d2716-bc77-494a-871e-1bf3ee466d6b@denx.de>
Date: Thu, 13 Jun 2024 09:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
 <94d1e571-6051-4a1a-b15a-ab5147ada833@cherry.de>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <94d1e571-6051-4a1a-b15a-ab5147ada833@cherry.de>
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

Hi Quentin,

On 2024-06-12 12:37 pm, Quentin Schulz wrote:
> Hi Claudius,
> 
> On 6/12/24 12:20 PM, Claudius Heine wrote:
>> Hi everyone,
>>
>> in the past we used cgit, which provided cloning the u-boot repo via 
>> http, https, ssh and the git protocol.
>>
>> When we migrated to gitlab, which doesn't support the git protocol, we 
>> implemented some additional service files to continue to support it 
>> for some of our git repositories.
>>
>> We just noticed that cloning via the git protocol is currently broken, 
>> likely some changes in gitlab happened and we would need to recreate 
>> the symlinks on the server to point to the right repositories again.
>>
>> Since that is another thing to maintain and keep up, we would like to 
>> just shut the git protocol down. AFAIK most projects moved to use 
>> https for cloning anyway, since there were not many reports of broken 
>> cloning.
>>
>> What are your thoughts? Is it worth the effort to keep the git 
>> protocol up?
>>
> 
> On the side of OpenEmbedded-Core, HTTPS is being used since Langdale 
> (4.1) and the first dot release of Kirkstone (4.0.1) so only outdated 
> layers would be impacted (provided they aren't already, but since 
> there's a download cache system in Yocto, it's possible they're hitting 
> their own local cache instead of fetching it from your server(s)).
> 
> It's never nice to see things going/breaking compatibility because it 
> may break old builds which is always a nice trick up one's sleeve to 
> figure out when things started to go wrong in one's image.

Well, this happens all the time, but maintaining backwards compatibility 
here should be done in a best-effort way.

With old build, they likely need old compilers and systems, which will 
probably break anyway if they use https or ssh, because obsolete crypto. 
If people want to build old stuff, they probably have to fiddle around 
everywhere anyway, or have a download cache.

The internet, or any network, isn't nice to old systems...

> Also, while I 
> checked OE-Core, other third party/community maintained layer could be 
> impacted. I assume this is the case of meta-amarula-engicam[1] and 
> meta-allwinner-hx[2] for example.
> 
> I would suggest sending a mail to the different build systems mailing 
> lists, I assume https://lists.openembedded.org/g/openembedded-devel and 
> https://lists.yoctoproject.org/g/yocto for the OE-Core/YP side? Either 
> to ask for their opinion or notify them (and specifically third party 
> layers) it's going away or both.

Not sure if I want to go through them all. Looking into all these 3rd 
party, downstream repos and informing everyone seems to be even more 
effort than maintaining the git protocol.

And if someone uses their repo, they will notice it quickly and can 
easily fix it.

Anyway, I fixed it yesterday, and it doesn't make much sense to stop it 
now. So I will leave it in place until it breaks again, then I just 
remove it.

thanks everyone for their input,
Claudius

> 
> [1] 
> https://github.com/amarula/meta-amarula-engicam/blob/master/recipes-bsp/u-boot/u-boot-common_2018.05.inc
> [2] 
> https://gitlab.com/dimtass/meta-allwinner-hx/blob/master/recipes-bsp/u-boot/u-boot-common.inc
> 
> Cheers,
> Quentin

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
