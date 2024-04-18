Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9FAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9839A8869E;
	Thu, 18 Apr 2024 20:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713465763;
	bh=4ArcbfeMlXEVJZdCrUX4oDHaBuMuvnsYdim2t18uZ20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z4hGqgw9MoqYTJbLTCs0exy2GwhkXYKKuzhVORQdORAXmhtRsJkIIP6sOEHpnsPcW
	 nluZYiEYO269u6l66RG643+tuFUAhQYHLwDvgaCZ93gukJuprQ6LrsRY4p6+kP1gnz
	 xlbTw7pQBUGR7cguVqUAfjhjoSuco24mcHN0A+QmNwfg5k2Pjggbp0UDbd2wtl+gw5
	 mqFhb8J8kZVmKhyhWJqKhaNAC9s2wsYeXomxeHAVaLeeigeXQpG2A15mx0oOnsrcMN
	 UL18pFAqnbV2jXnj0jMAlZqj8U4uhQbAu22SX/mJYwhz1r4GvvMMSplU6d3VWvhFgE
	 w6LVAruEaKF6Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A6FEF885CD;
 Thu, 18 Apr 2024 20:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713465762;
 bh=4ArcbfeMlXEVJZdCrUX4oDHaBuMuvnsYdim2t18uZ20=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z6ue+jF4WP83XI32WeKAMVv4lCeLG3ozNVHsRX+EkynQsgUXq8acuXssyLY4Me1Q9
 pC3tFrYY5GVFb2OuxvijJNu06X082duVa3Lr86ZGTIqLI3H2Ev1IW9sRhobaHpcqnf
 /C9bnwIG4dZqJ8jLfh++qIGqIj6N8JPmkR2pitQokPGRgbMVBT4csr6pCazAI0i+h5
 bN+crQnvn5NkN2iwu0+O3QjuiSWN6qAzIGTnk8Gw2Kmzeq43yFqSbh4YJ8VZTwrpVl
 j39WcMcIML/VQqIDCUzFRqdhc06eS31jWMTMV/3oU2jicyyQCa01VizL8qyL6dl51j
 s5BTpXcfepGWg==
Message-ID: <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
Date: Thu, 18 Apr 2024 20:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@denx.de>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
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

On 4/18/24 8:02 PM, Fabio Estevam wrote:
> Hi Tim,
> 
> On Thu, Apr 18, 2024 at 2:54 PM Tim Harvey <tharvey@gateworks.com> wrote:
> 
>> Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get the
>> following in the SPL?
>> Couldn't bind rng driver (-96)
>> SEC0:  RNG instantiated
>>
>> sec_init failed!
> 
> Yes, if I add CONFIG_DM_RNG=y to imx8mm_evk_defconfig I get:
> 
> U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 14:58:57 -0300)
> No pmic
> Couldn't bind rng driver (-96)
> SEC0:  RNG instantiated
> 
> sec_init failed!

Interesting. Which TFA blob version do you use ? I used the mainline 
2.10 for my tests.

btw. 'no pmic' ? Is that expected ?
