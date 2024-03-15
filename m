Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1492AC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 18:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F8687F65;
	Fri, 15 Mar 2024 19:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FmWlt0l+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7961B88018; Fri, 15 Mar 2024 19:07:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF690878E9
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 19:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4765=KW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710526017;
 bh=SUFKGCW6xstkhBj+tyB8CVJt194y+YwyH3TjFCqc1OM=;
 b=FmWlt0l+/VUjc5hGMTRK4azX7r0PYOESp2RrwBeYiB35ONJWuLhiNyWxUMRcLP5Vbhu4kRqi9
 FwwiAYvvcGfGG4UKHznLvcWANRjo/tprB2hPCNEr3W0DytHjWvKYyVqnZ8LHnzgUWOuvN8s4emy
 8tdYZ48z4JmMHkmEjSQegvftvGi+7A8kQC79yjFrtzhkMb69+UwkSMS45qU2TdBYMCrcVZYFiIJ
 FhO62gnDkgYGZQ2uJe0QtUKogmBYkC7p+esHGpNKS3I8xRmqkN3Tm1Hfr27/97ZawMnSS67VhwQ
 Lr9ebvZEfQYXMALd6kgA7pgHsnpJ6PoDifNqTD3r2Q2Q==
Message-ID: <59ba9347-ec51-4c81-b488-83c67035abd8@kwiboo.se>
Date: Fri, 15 Mar 2024 19:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Weizhao Ouyang <o451686892@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
References: <20240104114619.280513-1-o451686892@gmail.com>
Content-Language: en-US
Cc: Michal Simek <michal.simek@amd.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240104114619.280513-1-o451686892@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f48e416c5bf97101a6a54f
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

Hi,

On 2024-01-04 12:46, Weizhao Ouyang wrote:
> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> crashes.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

This fixes a null pointer dereference when running "sf probe" and there
are no spi devices enabled in the device tree for my boards, so:

Fixes: 3feea0ba196a ("spi: spi_flash_probe_bus_cs() rely on DT for spi speed and mode")

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  cmd/sf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/sf.c b/cmd/sf.c
> index 730996c02b..e3866899f6 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const argv[])
>  	}
>  	flash = NULL;
>  	if (use_dt) {
> -		spi_flash_probe_bus_cs(bus, cs, &new);
> -		flash = dev_get_uclass_priv(new);
> +		ret = spi_flash_probe_bus_cs(bus, cs, &new);
> +		if (!ret)
> +			flash = dev_get_uclass_priv(new);
>  	} else {
>  		flash = spi_flash_probe(bus, cs, speed, mode);
>  	}

