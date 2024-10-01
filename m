Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B6CEACDD
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 004398921E;
	Tue,  1 Oct 2024 17:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727796435;
	bh=yl+4EvhvGIL/Jr+OSOXACYxASNXIaMTH0jWu2kF5VPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DmSZ/esWHuAUKoi7EYx+ZcMpyhXE0WTlSEFGMX1xM4BBGCQrCQBkCn+9mIfql5kh1
	 xn3BWjs4B/yQk2JItGYbM3RtBjKlaKG0yh2324qQzacNMa7J2aJ3yBdkekJEkIDkKQ
	 ScIoNx8uPX5gIemEwpCiQqxXjHUn/osn1dWVxRs/s+ZevM4WoSsvqYM3JXJ+AplkbX
	 08qVZejaXwE6b8xbm3z6mwt8aPYAMrtiLluK5FBffTpyjCH4cQ7Wv+w4IiPL0ocyfr
	 nlSzbBwTvtNrgD222GKTOIvT408rDH2xP70kBZe3ZhpFAuBpPDBUj6owZ1clcVXu4C
	 AUoVyvbtjew3g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E824E87E30;
 Tue,  1 Oct 2024 17:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727796434;
 bh=yl+4EvhvGIL/Jr+OSOXACYxASNXIaMTH0jWu2kF5VPc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M9q1KLVowbnSx8BiGzsimzuPFk5juKhk9EicFL5TcE4qxPUMe1+at+J/MyzQN4Q3m
 9VdLD32weQqSz7BlFtE40hWXYE38oj4SXMMClMgz3atbvOAZhoaTUYhbul3UMEsA8a
 l7o6nQuXIfxsP+0eyOV8ElPyb399eRaxxR5jn46OXbkXjC4SNDEOkr0xlNF5EkqwXO
 P+GHna+zxQac2QEgY5QZ6/tTVdQKWvlhA/cd4821/zWb3Q2K7kNRUi0sTMB461Qke8
 eKbjQXkqJbVQ2LoRxu5DQhGAl6vMpQmY4qZ/sosa9to13xzgCASiftNwuDaD0LIDpR
 8lSIZJnroueug==
Message-ID: <066867d2-6d16-4ebe-9a42-8ce58d3889ec@denx.de>
Date: Tue, 1 Oct 2024 16:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
 <75eb6eb6-dd55-4509-a041-a5941286493f@denx.de>
 <CAFA6WYM8KJQkTQ6YtMC7ByKU-h1Yss9K50veWmsnni3gYsgj_w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYM8KJQkTQ6YtMC7ByKU-h1Yss9K50veWmsnni3gYsgj_w@mail.gmail.com>
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

On 10/1/24 3:35 PM, Sumit Garg wrote:

Hi,

>>> On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Currently the enablement of OF_UPSTREAM results on the build system
>>>> searching for DTs only in dts/upstream/ . There are platforms which
>>>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
>>>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>>>
>>> I would like to understand the need to maintain DTBOs separately from
>>> DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
>>> DTBs?
>>
>> This is a stopgap measure, I would like to start reducing the amount of
>> U-Boot DTs for iMX platforms, but the DTBOs are still in U-Boot only, so
>> I would like to have some middle-of-the-road solution until the DTOs get
>> upstreamed to Linux too.
>>
>>> Jan recently pushed those so-called U-Boot specific DTBOs for a
>>> TI platform which were accepted in the Linux kernel upstream. This
>>> patch will just deny the ability to build those DTBOs from dts
>>> upstream tree. IMHO, this takes a step backwards on the whole notion
>>> of OF_UPSTREAM.
>>
>> I don't think this will deny building those DTOs which are already
>> upstream. With OF_UPSTREAM enabled, this will build:
>> - Upstream DTBs
>> - Upstream DTBOs
>> - U-Boot local DTBOs (and NOT U-Boot local DTBs)
>> The DTs that are bundled into u-boot.itb are searched exactly in that
>> order too, upstream ones first, upstream DTBOs second and finally the
>> U-Boot local DTBOs. The upstream content should always get higher
>> priority if there are any leftover DTBOs in U-Boot which are also upstream.
>>
>>> If we really want a middle ground solution to allow migration to
>>> OF_UPSTREAM easier then we need to find a way to build DTBOs from both
>>> directories (local and upstream dts). I would imagine that will likely
>>> complicate building and packaging DTBOs.
>>
>> I believe this is exactly what this commit does ?
> 
> Okay I see, probably the commit subject was too confusing for me:
> 
> "dts: Add ability to build DTOs only from arch/$(ARCH)/dts"
> 
> I can see the benefit that it provides to people migrating to
> OF_UPSTREAM. The negative part can be people just not pushing the
> DTBOs upstream which should rather be easier as we have seen Jan
> pushing DTBOs upstream.

That (push your stuff upstream, reduce the duplication in U-Boot) is up 
to maintainers to request.

Strictly enforcing either/or means setting the entry bar to OF_UPSTREAM 
higher than the entry bar to Linux kernel, which is not gonna work.

Giving contributors some middle-of-the-road solution might in fact 
expedite the switch to OF_UPSTREAM, even if it may not happen all at once.

> There is also magic added by this patch
> regarding which DTBO is actually being used (local or upstream one),
> the packaging ordering can be magic to someone debugging a boot issue
> on a particular platform.

See discussion above, the ordering is well defined.

> IMHO, the OF_UPSTREAM migration can wait until all the required DT
> sources (.dts and .dtso) are present upstream. If we start to mix and
> match DT sources then it is going to turn into maintainers' hardship
> again. However, I am still open to further convincing arguments for
> this.
With some Linux kernel architectures, it takes months to get a singular 
patch review out of the maintainers. For systems which already have DTs 
upstream and only have DTOs left, the OF_UPSTREAM conversion and DTO 
upstreaming can be done in parallel, hence expedite the process.
