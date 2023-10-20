Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2262C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 16:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A9C86C33;
	Fri, 20 Oct 2023 18:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697820304;
	bh=8NrCtTZQXjyWfgSSQ+LEvfYafaFJo/+RcDE3K/gaLug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EAjb9wPBFnmjkoHXkDLtplm+Y7JSXFCRH3IDb92LcH5kNRhbeheszmdDa1fYl7Cq6
	 KwVHA4sXnhPjD8JpxlkECx488YbLYKSVXQ0uezNwDhUL31FXEzdTcrmiEmHaNW8eU3
	 rPiv6VSm8AL2FDF1ftKEr3LnYU96UTqn4nqKyU3kMmdSzqn0oPDlKalG+AdkL0GQc/
	 k0M776QzOQBadRnxB/OChMXtgMJ20DapGfqZF44diqkujQIhI27L9x4zhjvyUg5/h2
	 xxqCp/sS6xsjXNVM+Jw5yo17V8UegeP1+BqgilmTbulm+E+igv7IkNfu85o/h1gQ07
	 2x+MwiZ9wcnWA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F81C86CEC; Fri, 20 Oct 2023 18:45:04 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E0B86801
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 18:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SBr6M6Ybpz9t27;
 Fri, 20 Oct 2023 18:44:59 +0200 (CEST)
Message-ID: <1571d7c5-30f4-4ec1-9ad9-f1312ea965d4@denx.de>
Date: Fri, 20 Oct 2023 18:44:58 +0200
MIME-Version: 1.0
Subject: Re: Please pull u-boot-marvell/master
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Chris Packham <judge.packham@gmail.com>, Marc Zyngier <maz@kernel.org>
References: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
 <20231020144545.GJ3119521@bill-the-cat>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231020144545.GJ3119521@bill-the-cat>
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

Hi Tom,

On 10/20/23 16:45, Tom Rini wrote:
> On Fri, Oct 20, 2023 at 02:51:08PM +0200, Stefan Roese wrote:
> 
>> Hi Tom,
>>
>> please pull this next small batch of Marvell related patches:
>>
>> ----------------------------------------------------------------
>> - kirkwood: Pogo v4: Enable LTO (Tony)
>> - mvebu: AC5/AC5X: use fixed page table size (Chris)
>> ----------------------------------------------------------------
> 
> Given Marc's request, can you please either respin this with a revert of
> 6cdf6b7a340d or I'll do that later, and drop the AC5 commit from here
> instead.  Thanks.

I'm just now leaving for a longer weekend trip and will be back mid
of next week. Then I can take care of this, sure.

Thanks,
Stefan
