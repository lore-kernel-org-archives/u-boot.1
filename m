Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF720D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 05:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F908901F;
	Mon, 28 Oct 2024 06:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730092560;
	bh=6xAeu5ROFjpgifnBEkuQlJQqDHkAJ2QKrpTuVdhbyoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=m0pNZB7wLpKGLx3xspQDBNBtEtZ86JjL6tBX8GuC5zE4RMsKwElIcSJWhO6Mui55U
	 5OPAvOHOfiEaSUP6HHaJa4D2N0WlOmjxMmmcBbBPiiBvoHC2zNPLJIdkCFM0ogKgOi
	 MMlwF5JT18SMo/+/FLy7G3jSqp+igxEkKrUyxAoto7QCQWdHbOlZxsPNhpkW6Xr32/
	 8End6EhpGcvJ9KDQfv/j3bnmnlueDF4NyLNnA8LT6Ud/EiOzcfdiZ2qS59it1LdoHb
	 5IMuVF0mz6pnMfmVI7m0ztOM+mwsdTFGQq44NDjAZ4GteSz9KpN5artkWwaIE7vTaS
	 R89M1DFaOmboA==
Received: from [192.168.1.107] (89-186-114-4.pool.digikabel.hu [89.186.114.4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D8DB688FA8;
 Mon, 28 Oct 2024 06:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730092558;
 bh=6xAeu5ROFjpgifnBEkuQlJQqDHkAJ2QKrpTuVdhbyoI=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=feub4Qk30JDKZc+OJwCuqA1EtfVEbbnpdJLK51lRkr8tClF1imhebJacJlB+Jo4Fs
 L3NJVFFDyly39xvVdf5X+Sc+e2ZBHAypcuHIlUVwFX1Z1/9g9+ANvAMwk9cL1/aEPX
 dMWp9Bv6S6+gOd+inoTmhr9zWlS6o7cyIj8EFuzDSzIN9c4qpz+jUVkMc7Jd0c6alX
 Pw60rHGBer5PGCAsRyvlK3MSg+90Mxb6nPTCuYSa+8RigeLHPuOrH7ATH5laogIwVt
 h2XZjUs+tNAPPrZbmAEHQQACo9n8bzekJd88UOQE96R/qUQLu346R5EfD7KlOUQFsK
 gRqs9QuI5C52g==
Message-ID: <c4a248da-6e16-708f-abf4-b89422076466@denx.de>
Date: Mon, 28 Oct 2024 06:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
 <CAOMZO5Aae_0cDXX-E9syhVPwMF7_NVu2__40m6Tmi7daePyVbg@mail.gmail.com>
 <CAOMZO5DNQ6cKyNqsQaU8CE-FwoOQdgaf99S8dQ4_FE9XZDvmCw@mail.gmail.com>
 <16b090de-2fbb-4905-909d-0da92cb1946c@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <16b090de-2fbb-4905-909d-0da92cb1946c@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Marek,

On 27.10.24 22:01, Marek Vasut wrote:
> On 10/25/24 5:09 PM, Fabio Estevam wrote:
>> On Fri, Oct 25, 2024 at 11:51 AM Fabio Estevam <festevam@gmail.com> wrote:
>>
>>>>> Heiko, can you check if this works for you?
>>>>
>>>> Works fine for me, thanks!
>>>
>>> Applied, thanks.
>>
>> Sorry, applied it too soon. I see there is an ongoing discussion.
>>
>> I will wait for more time.
> 
> Go ahead, nothing to add from my side, but it would be good to get a TB from Heiko maybe ?

I tested it already, ah, and forgot the TB, so

Tested-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
