Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17D1C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32418882D4;
	Tue, 18 Jun 2024 16:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718719271;
	bh=JoAVe/zpuPdkcxSLZOfOe+FQBQ0pLDPFyS4OiNyMrEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=caXm2RjnjEOfpYubi3a92hZiytpLArtEp+zuJ9ksCBzrSkzj8XUAHBbP595DXHYcf
	 /Mi5GrUGzUulzvoncltTmmBDrimiZwBIOpZFlzgDXtgjqBjyRXGlifIAWXv+R7asA5
	 2z/iw6uXv65+3BrPsRSdE6CaRAbLcZKOMnmIu3Ua1YBECcCrg8E8+bezDr9eRv08vN
	 2PCLlxi+Nn2ZDHmktcb89jv13Y+DysFqG0vJBWhB7kMqR8xUoY5j3rlLrgVPRbWPPE
	 l2Tg8ysqXzyWTqLDmZ4ZzePBhhFXVDKa12aYrtOya8JiuedHtSdZH+BmgTkGcWDnn5
	 gSc7VyPK50GbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27137882EF; Tue, 18 Jun 2024 16:01:10 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF18688137
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4W3T1X552Fz9sSF;
 Tue, 18 Jun 2024 16:01:04 +0200 (CEST)
Message-ID: <1b6c57bf-265d-441a-9e63-8182a7929ad1@denx.de>
Date: Tue, 18 Jun 2024 16:01:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
To: Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240617232904.GL68077@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W3T1X552Fz9sSF
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

On 6/18/24 01:29, Tom Rini wrote:
> On Fri, Jun 14, 2024 at 04:13:54PM +0200, Stefan Roese wrote:
>> On 6/12/24 18:50, Tom Rini wrote:
>>> On Wed, Jun 12, 2024 at 05:13:37PM +0100, Jiaxun Yang wrote:
>>>>
>>>>
>>>> 在2024年6月12日六月 下午5:00，Tom Rini写道：
>>>> [...]
>>>>>>    configs/octeon_nic23_defconfig | 1 -
>>>>>>    2 files changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> This seems similar to:
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-rasmus.villemoes@prevas.dk/
>>>>>
>>>>> at least for CI. And for outside CI, I'm OK with just having the value
>>>>> be changed in the defconfig as needed. We do support using config
>>>>> fragments, so keeping such changes locally isn't too hard.
>>>>
>>>> So the default value is a little bit too hard even for some of the actual
>>>> hardware.
>>>
>>> Right, there's some platforms where it's too small and we should just
>>> bump it up. I think for now the default is what we want it to be for
>>> most platforms.
>>
>> The current default value is definitely too small, especially when CI
>> is involved (I did not have this in mind when implementing), so:
>>
>> Acked-by: Stefan Roese <sr@denx.de>
> 
> Can we please get either this, or
> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-rasmus.villemoes@prevas.dk/
> merged for master? The number of false negatives in CI due to this is
> big issue for getting more contributors to use CI. Thanks.

Yes.

Applied to u-boot-watchdog/master

Thanks,
Stefan
