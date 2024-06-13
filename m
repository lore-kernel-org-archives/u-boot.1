Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1460C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 13:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE9588906;
	Thu, 13 Jun 2024 15:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718286756;
	bh=VsmrZcrKDsvkJwpK//ylZ/9L14J607XISEaoZxWWbRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCzmhYL3c87ToiLI2fj0ExCt+6vtA5cHsNIKd304T0yku3gnp3CS0hx//eQFpHvUt
	 mi4pDfK+66HOLqbzSCr9PBy5zJA9KNTUzcKKoe+WwOBEfuOXrqctPZKr9IckkZk87p
	 lkTPjH1kkt9J8Xv3VzSry6SK53U03uYVFxWjrjBTNO/ZQMZKRwJPKjHg5v6ZY5Czv8
	 PMuxtt4Vj/y+zN+ZaH0nlTceoxTCBJ/xLj/P5ol+gdVek7RXTzmQGanDAN1pcpXTys
	 RCQMBrkrltZ8zxqP+ZrKaEzntzFQzf1QyVACpxUe40GKJoqx3FCtEbJ2YKwxxNTPHl
	 sYK936APHSxVA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9232D888FA;
 Thu, 13 Jun 2024 15:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718286755;
 bh=VsmrZcrKDsvkJwpK//ylZ/9L14J607XISEaoZxWWbRY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BCtgJksWDoOqT5gAz+Rj64/HC6YXw8Xa7CxRhq/B2QKBcpGCn2S/mnI1bMRYDWbpC
 8wat8Xnu/fQWgHwNu1XrdbjIHi92JDGaDuRaQzDjdSKIjVSESNoHCTcLMJpiqZbrZI
 8Rf39qIL8xl5/Cz6AXokUenqY9cdRvrFlGMjvZMXi5ClXxnM/rhfF0q8Nfyc4ncuIA
 rE1hSAy9Y6+O+pWaoOcXKOlZyBd/8boSdQB2uMT7cq7hPPZ+fhOObj4JrhpeWeVRiR
 IzAr511zgjyYBnV+dDb+ajH6GXcBhfqPwL51ikIXAQdCdoXbHGIW7NMJzsy4boNENl
 A+KthGjiLxC8w==
Message-ID: <ea1f5d07-aaba-42a6-96f7-e90b370ff4ae@denx.de>
Date: Thu, 13 Jun 2024 15:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Claudius Heine <ch@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
 <94d1e571-6051-4a1a-b15a-ab5147ada833@cherry.de>
 <814d2716-bc77-494a-871e-1bf3ee466d6b@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <814d2716-bc77-494a-871e-1bf3ee466d6b@denx.de>
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

On 6/13/24 9:49 AM, Claudius Heine wrote:

Hi,

[...]

>> Also, while I checked OE-Core, other third party/community maintained 
>> layer could be impacted. I assume this is the case of 
>> meta-amarula-engicam[1] and meta-allwinner-hx[2] for example.
>>
>> I would suggest sending a mail to the different build systems mailing 
>> lists, I assume https://lists.openembedded.org/g/openembedded-devel 
>> and https://lists.yoctoproject.org/g/yocto for the OE-Core/YP side? 
>> Either to ask for their opinion or notify them (and specifically third 
>> party layers) it's going away or both.
> 
> Not sure if I want to go through them all. Looking into all these 3rd 
> party, downstream repos and informing everyone seems to be even more 
> effort than maintaining the git protocol.
> 
> And if someone uses their repo, they will notice it quickly and can 
> easily fix it.

I very much agree, that ^ is probably the best way to go.

If some legacy repository breaks, fix the repository, hopefully there 
aren't too many of those to fix. Github deprecated git protocol a few 
years back and users managed too, except the fallout here is much 
smaller as it affects only one recipe (or a few).

I suspect the following patch to oe-core (or local.conf equivalent) 
might also entirely mitigate the issue by providing https fallback 
automatically, without the need to modify the legacy layer/recipe ?

If so, maybe this could be added to OE LTS releases at least ?

"
diff --git a/meta/classes-global/mirrors.bbclass 
b/meta/classes-global/mirrors.bbclass
index 862648eec5..50a14c5881 100644
--- a/meta/classes-global/mirrors.bbclass
+++ b/meta/classes-global/mirrors.bbclass
@@ -77,6 +77,7 @@ https?://downloads.yoctoproject.org/mirror/sources/ 
https://mirrors.kernel.org/y

  MIRRORS += "\
  git://salsa.debian.org/.*     git://salsa.debian.org/PATH;protocol=https \
+git://git.denx.de/.*          git://git.denx.de/PATH;protocol=https \
  git://git.gnome.org/.* 
git://gitlab.gnome.org/GNOME/PATH;protocol=https \
  git://git.infradead.org/.*    git://git.infraroot.at/PATH;protocol=https \
  git://.*/.*                   git://HOST/PATH;protocol=https \
"

> Anyway, I fixed it yesterday, and it doesn't make much sense to stop it 
> now. So I will leave it in place until it breaks again, then I just 
> remove it.

Do you know how long it was actually broken ? (i.e. how long nobody 
noticed and complained about it?)
