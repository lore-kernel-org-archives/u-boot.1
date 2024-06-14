Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1395C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25544889F8;
	Fri, 14 Jun 2024 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718374441;
	bh=zJjVvK6HZZzKI+zmj6GEnN6EBDvcTJlmjA3tNzKNVrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZ9aI5KxcBFKZiWMrLEKh5AZ8+IS796Z2HIY7IxBGk3DqY5SqYUm8BIe3WBFaken/
	 FIe4i5cXv8uPq2J90cDCJXWWg2MvwpSdIq9DWJdNQ6JTTqz0jjnAO5v2i/HCGtmg9i
	 STkRxqYEJFJqMsc1GlsoSrQusAPOwpEXbo+q3widSwZMCOhpgznvNapn/rhQi668Uz
	 MgjkU4r852/6022owfCWnrNmXJoJMo5ButyOk+2tX6NG8jbMHwkwbx2XTHZPT4v7K8
	 PF1vEvktoi5f4pPq0D2QImz3KWDeemztx+ggip94t0V7s4gqTBQuJqP+bvh6dRoQyL
	 SeaOF35yWO7OQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A408889F7; Fri, 14 Jun 2024 16:14:00 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4008D889DC
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4W11VC3kDbz9sbx;
 Fri, 14 Jun 2024 16:13:55 +0200 (CEST)
Message-ID: <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
Date: Fri, 14 Jun 2024 16:13:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240612165048.GD68077@bill-the-cat>
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

On 6/12/24 18:50, Tom Rini wrote:
> On Wed, Jun 12, 2024 at 05:13:37PM +0100, Jiaxun Yang wrote:
>>
>>
>> 在2024年6月12日六月 下午5:00，Tom Rini写道：
>> [...]
>>>>   configs/octeon_nic23_defconfig | 1 -
>>>>   2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> This seems similar to:
>>> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-rasmus.villemoes@prevas.dk/
>>>
>>> at least for CI. And for outside CI, I'm OK with just having the value
>>> be changed in the defconfig as needed. We do support using config
>>> fragments, so keeping such changes locally isn't too hard.
>>
>> So the default value is a little bit too hard even for some of the actual
>> hardware.
> 
> Right, there's some platforms where it's too small and we should just
> bump it up. I think for now the default is what we want it to be for
> most platforms.

The current default value is definitely too small, especially when CI
is involved (I did not have this in mind when implementing), so:

Acked-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

