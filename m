Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA16CF8869
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 01:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD84988CC1;
	Sat,  5 Oct 2024 03:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728091098;
	bh=Ajkquf/5mTQgR8BRFsT13apBU6vw8DRWZ9FQZwE0tqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z7RNdjkvWDGXXTztMWcYvc+x7xJHCgToaQp47KuPE887/q6miKBo4wa2q+054P9dr
	 XMSn9P9djWSi85jskW65AcD4Srrs9OP2dbixTG4bPQZRqjqxhKQyI1JW9/p6RK8qPP
	 gURJYj459DTzM1uPFqAN0t1x/+6bOv+1P+bORePXDn0CNLDhUipBsh5qqK+JImGBq0
	 yGuouqtyqNyBgtnJFkQX1z5azzf/dAzVU7EBPhPUVAk4OErr6Fdb5bcrSKKiErHMWR
	 /Nj0H/sknUX7QAsI22qVi6DXBhmPoWnm+2x6uxHyarTgGLbBnRXYCp5f/CrljjkRxW
	 rrhRU3kx+aEXQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D16D78888F;
 Sat,  5 Oct 2024 03:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728091097;
 bh=Ajkquf/5mTQgR8BRFsT13apBU6vw8DRWZ9FQZwE0tqI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YGhGZovbCbrCHMS5XtMJW1ORihtaEFfTYfgpm7LXGxuXhJiOYB7o0gamlvsrqzMtD
 uVttKjh7z+gO3wn4P4fqtKQ/oHwCpO9niMGdyCdWNutzIwU8Vj0noZfsc9gMPRdREv
 GHQIFYJKEXoYldrHmPr7fcujN1bpqYmP8UTPHbfAm8PM1+EWzWWEfC+dxosjCNgDv8
 TYK9TW8IlwMN8BnyhzXePI6upTusK/LyT/Accv4Nwl78L/oRbPZM/EiVksVt+b6xxV
 eBgnUQL2v3DSa9K3+r1a20UxBjh1g6dx076jAP0Qpn0NTE56xwWb8pJzbmzROBWzc4
 loRjGgPM2igkg==
Message-ID: <1fe6c47f-52db-4bb1-b234-db5f5ec9c460@denx.de>
Date: Sat, 5 Oct 2024 03:18:16 +0200
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
 <066867d2-6d16-4ebe-9a42-8ce58d3889ec@denx.de>
 <CAFA6WYNy+XzWvMcfJqmLRfinKUPnvx7Ha42xOxF4a=izPKMr4Q@mail.gmail.com>
 <609e203a-45cd-4155-8f0a-26f3f1e8c497@denx.de>
 <CAFA6WYOgEUXVPfkaja4ZXekyet5n7E5MUKyUQY-qXjPzFtxttA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYOgEUXVPfkaja4ZXekyet5n7E5MUKyUQY-qXjPzFtxttA@mail.gmail.com>
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

On 10/4/24 7:40 AM, Sumit Garg wrote:
> On Fri, 4 Oct 2024 at 07:15, Marek Vasut <marex@denx.de> wrote:
>>
>> On 10/3/24 9:58 AM, Sumit Garg wrote:
>>
>> [...]
>>
>>>>> IMHO, the OF_UPSTREAM migration can wait until all the required DT
>>>>> sources (.dts and .dtso) are present upstream. If we start to mix and
>>>>> match DT sources then it is going to turn into maintainers' hardship
>>>>> again. However, I am still open to further convincing arguments for
>>>>> this.
>>>> With some Linux kernel architectures, it takes months to get a singular
>>>> patch review out of the maintainers.
>>>
>>> Okay I see the pain but we already have that rule for .dts files for
>>> OF_UPSTREAM switch but having a different rule for .dtso files is
>>> going to make maintainability complex.
>>
>> What kind of rule is that ?
>>
>> If the rule for .dts files is either dts/upstream or arch/*/dts, then
>> the rule for .dtso is either dts/upstream+fallback to arch/*/dts or only
>> arch/*/dts .
> 
> Yeah that the rule difference we will have after this patch for .dtso
> but I can live with that given it being gated behind the Kconfig
> option below.
Should be fixed in V2.
