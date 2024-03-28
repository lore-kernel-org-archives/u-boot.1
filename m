Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351A3C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C0487EE6;
	Thu, 28 Mar 2024 10:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711618675;
	bh=Ep656/4o8zc5K4vwXt49p2YC6+PrT+NG1VumITpRRfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CtWJSlZXm3bjq7p7ph9NsiL/3xXThppMaqdWWk+8asHlGZqalxsSYWlNzDtMmHsS
	 yzHs2lUyfTk5auZYKTjkMU+PjnVyugJoOY7aYFFz779O7y+37xpWyzyZGq/y/kM9ka
	 fG49CUC/HipEQF9g33wy7c0qHWC/v3tZh/pino1TXZGK0vLRQOHkCG6DQyIXYhIaBs
	 sdx5IU6NGXPiIZB2rTsO6+JVCAskXGKp5EP2lQGmXo1slzlOUEUwMaN05Z8ksFRzZF
	 fIRy2zkCZ+KVq4OZgPtBtZuDlG2FhsfrePSpCmogds50T+WoFEnMmb0MldpVx6MyNb
	 aIR9wfj1+INpA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B6287FAC; Thu, 28 Mar 2024 10:37:54 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F15F87E9B
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4z3f0TcTz9ssM;
 Thu, 28 Mar 2024 10:37:50 +0100 (CET)
Message-ID: <55229181-3aff-4bff-afb5-df778f5f1849@denx.de>
Date: Thu, 28 Mar 2024 10:37:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm: dts: kirkwood: Enable upstream DT on Kirkwood
 boards
To: Michael Walle <michael@walle.cc>, Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Dave Purdy <david.c.purdy@gmail.com>, Evgeni Dobrev
 <evgeni@studio-punkt.com>, Luka Perkov <luka@openwrt.org>,
 Siddarth Gore <gores@marvell.com>, Simon Guinot <simon.guinot@sequanux.org>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Walter Schweizer <swwa@users.sourceforge.net>
References: <20240328021825.17935-1-mibodhi@gmail.com>
 <D057P1KGDU7W.1IWOBHLNV5GX@walle.cc>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <D057P1KGDU7W.1IWOBHLNV5GX@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4V4z3f0TcTz9ssM
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

Hi Tony,

On 3/28/24 08:41, Michael Walle wrote:
> Hi,
> 
> On Thu Mar 28, 2024 at 3:18 AM CET, Tony Dinh wrote:
>> Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
>> DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
>> DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
>> files from arch/arm/dts/ directory.
>>
>> Background:
>>
>> Hi Stefan,
>> Hi Michael,
>>
>> I did a survey and we currently have 28 Kirkwood boards. Using some
>> commands and filters, here are the finding.
>>
>> git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"' -f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm/marvell/$1.dts' sh | grep differ
>>
>> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such file or directory
>> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No such file or directory
> 
> ...
> 
> Are you sure you want to have all this text in the commit log?

This is also my concern. Even though I love descriptive commit messages,
this seems to be a bit too much IMHO. Not sure if and how to get these
findings of yours archived otherwise.

> You seem to have forgotten my tag:
> Tested-by: Michael Walle <michael@walle.cc> # on lschv2

Tony, many thanks to work on this consolidation. Very impressive
results. I can't test anything of this though, but my plan would be
to pull this in the upcoming merge window, if nobody complains.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
