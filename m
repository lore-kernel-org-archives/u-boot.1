Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E02C021A1
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 02:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB21880BAD;
	Wed, 12 Feb 2025 03:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739326437;
	bh=DfMCo2AG9FO8vc5a8S+Xi+LjgTV+VTgN+AyrFYy7nY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bD1FXmK3Rl40jbt0kEwVZsowukauR9NVfQJVGHYNuahIsNZzOl1bOwogistB4n82B
	 g+jzKMYcDaz14wtNue8e+j4S1QByNvyPPPqQxjk+osDWQiOHhyrmnUiN8Ai4EwE9Wl
	 INkk6GtWyk6ecxm8G6z+hXZw4VKjyibFmoJy4UXSPqK1btWAIwWX/YMKApGmqbEkNL
	 oJAAvI4miOPcKezpBQc6TNE/lkoCjGksIGYdF6wrahxHYLRCj/ZCLkkR2jP6jal1XW
	 uhRRu9bLa3zSNu9lQ7AEXUyCg49ZpQWamSTyjVCpRGek4JKYEYBjkcQ+YxN24lqMEf
	 yGjUeC9cJixGw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA12980AE5; Wed, 12 Feb 2025 03:13:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67EE6807C0;
 Wed, 12 Feb 2025 03:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WT4gYCaG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 25630103718CD; Wed, 12 Feb 2025 03:13:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739326432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DfMCo2AG9FO8vc5a8S+Xi+LjgTV+VTgN+AyrFYy7nY4=;
 b=WT4gYCaGYhDzPn9T/pSdJT/eXN+tPVG28/E0iVp0Nenwd6bmLTwTDuxBcwzEACfkoNclnd
 OJHiCrb2Xo1zRRAy3g+dprujad7gp6FUlzYmEBWLXLi9TTTq6KiHCksh9uZOkelgW0YgAO
 ZkddR7GMlKgEzythv6N3vH+H9JdFtstcX+QLVRExxfDLDmWOZ3HIpRGe003ot/qUlL/tof
 sARFhyAzCvA4fmPDjv8GefoL0mU82FDpN004U6MVKYlMlJYKkMDGAiEwFUNdGCAhfA7TFy
 oOQ6uYgalUYJZToFiI5T88NJM+lI7lloyDGTVfK/cvJwQv0Zcbak6EJVgJh06g==
Message-ID: <1190ecc2-14c7-4680-8302-b4902f487156@denx.de>
Date: Wed, 12 Feb 2025 02:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xPL Proposal
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/11/25 4:03 PM, Simon Glass wrote:
> Hi,

Hi,

> I just wanted to send a note to (re-)introduce my ideas[1] for the
> next iteration of xPL.
> 
> A recent series introduced 'xPL' as the name for the various
> pre-U-Boot phases

Can xPL build also U-Boot "side-stages" , like for example 
self-contained blob which contains all the __secure material currently 
placed in separate linker section of U-Boot? It could be used to produce 
e.g. self-standing PSCI provider built from U-Boot code base.

[...]
