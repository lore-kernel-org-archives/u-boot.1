Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7EBC98324
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5BB68108A;
	Sun, 27 Sep 2026 09:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrsVcslCjlY7; Sun, 27 Sep 2026 09:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C823C80E23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790499674;
	b=FwTJ9vAzkHlHgeY5f1rJpQ6MI1sD0a7iaZ8nNiloS2Szuz30JNNfny5nZJk0Pk+hdJod
	 nZdR0QhNVjKNgZpo87sk6PXH8Z3U6EGkAHhVhe18HO8OW9NAYinFg6WWvmEuB8R88jyyr
	 ifU7CHmm830MRqx03x8KvSJAf2D2mFmJ41zBkj9sa2UhaLQmUzbLDp272vEzNfjSUHyci
	 2cOURS0qpgN+oQV1YblyplgXM+Nw7Yg0IjV2tgYffYB7ecI5ApKHnDCq1kh7yGj2kI0hu
	 9XNwaCl8BA6t+gFa7LlbLiBn8R7C3FIYIHCwZh+/t1Vtkvm9On1dgclI0xWgaQ8UT1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790499674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f2qmffMZv2IspunVJWSv89EpY1RCf+8Og5xKaXXEcrc=;
	b=VI4RTjRYpDgsyjCJuY0AQ57jxj+2b8bUmw05KlV1ca6OkG1XzSlwwV8YfusJwoChgLOV
	 4neF+S+zCVCAe5cnARMKTrOnOAQ3katOJQn5nIx+u+/ZFpMVu15cL5lNdFGNKlYeJAt0x
	 gL9PDXL06+1yXMCgR5a4v5XA8Dny4xjT2K8KrAqlF2OjK8fRqZve8yCFS3KU8LdC5T8wa
	 Q1U5yJ9PrqCcRUr1hQTsUI5AiLJeKX3GMLkzermI+QnvYKp5uQKOZz5bRn2rGAAVj9hH8
	 9Wzboh/5Prj2xZLmi/s/flZkuc9CDB28w1jv8KGuSUvHSbVvOhvqIIg6Sl1Z+N08l8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790499673;
	bh=f2qmffMZv2IspunVJWSv89EpY1RCf+8Og5xKaXXEcrc=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DemKXw4oU/VXITUWxKDWC10sEYMkjCfe0ZahlMQAA+ccmUVlooXejKYqok0vI3Mqu
	 l07LKWNIc+X+pQPVQ7EHY1g80iq8wEFDreuv7EX4hXoarwe7qHG61wFQkRh+i50o4c
	 OIr0TgQyLyHlBvUfsZzIz0ktTzIjVWok4UeW8IVSnbY/6ko5pQUtNsbWXLsuaJwsgO
	 zvv7lNFYiSlSi6CZBD6FcapD/1LppQAeStGZf+Zy9ve2Dg7JExFlEl9NXi1q+uYmbd
	 p9vBjIjCGJztqtBsNo80B7FKCzspY9jfgCzMcgPjrdIhCZo4Z9xC0MGqnocsFrR0DM
	 4CrJfMaQHdFaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C823C80E23;
	Sun, 27 Sep 2026 09:01:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C52824E
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DFD14005C
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWdAQ1St97jz for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 09:01:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C1B7440059
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790499671;
 b=c45B4SkB9gk68nQb3pV4b7OroVFE9E4Ru9BYuQZ7xAbYnViOWy7tmAPYbteM7pKBKl6z
 uxUmJihbX8S8OTpyDXAw8EKZypb7CUgNvIj+pHLyLN6sRnqUYzdN93QOXqVxdLxQxtRmO
 Ehn86XqRzN4LVPbRBciIdk0D/dJmtR5JrbZPJOF/Vqk6lFajGnPArNYJICu6agZKDDzWl
 PLo8mCqB9ot8oYvwYED2jBbGH/m3LvrLzEtbOHtDIfCO16yxZkzWnM7zAj8ORV0hATyfh
 ksn8Aq9GliDuXjk2V1CaAPGCkoULQ8JsCiMhURM40Rxb1TNETJ85+JALE890/8VWtpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790499671;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=f2qmffMZv2IspunVJWSv89EpY1RCf+8Og5xKaXXEcrc=;
 b=okdT3pGfQPeFFkcNDd5sDvhgFNLE2lgvoifDPBWDz1b2laHUkzD9C9aUBcnL/54g6AJm
 2Kj0I4UJzdDj6noM00tV7R+SvOJglDSeF9GL+/AP3QgW7wKJVooyf1ur8R/+MEOVZlGB5
 v2M3swLY7UwaGZWzBHwwxe4jCNo/BAYKiT0TxTpmMkYi4z49hK4jNeVQx+11FOPIVfZbq
 l4Xleaaep0hCVxH7fYKJgO6eBtzim0GwROHL57Fmo6HyrbFq49NGw00kHgD0bogQOtceX
 MTDYqU+NZsw1yM5ShpKR7B3hrcuXksU7U8Fe6/hjiriu68Yysp/0etB4SaYpf01Lpjg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=aM7B5Eq1; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=aM7B5Eq1
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1B7440059
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:01:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DAC371061E5; Sun, 27 Sep 2026 11:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790499662;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=f2qmffMZv2IspunVJWSv89EpY1RCf+8Og5xKaXXEcrc=;
 b=aM7B5Eq11DOSHElFyM2IHZ3G88/zO6cVDhwGx6eWVa9jM3f7Pgyhcfn9lBenq16OSiy2ss
 ZZBmXPYlRMMCVWUM6eUiF9jPHXatQtnOCpA5Gu8As4CMClEq3RnI8Wpv87LWjuquXN9Qzn
 hXSKxDAE2Evqz6iQj6R47d9kHIXEljY7+L0ZFdQVuYJ7s7Mn8p0VQvzEGMKvApjDF9mqUU
 6TuRjyoFJSBRVa0b8vg71Z2MpuGIsuy6G1W5rHk69/DUeg+kCUWB7s3Rby/TZCYCN41nmg
 pYxW61YpADhPv4pVhZ2ScPYqxx62cTaitbk01sV/3r+FNFgnM5yCJEs4CHH8ZQ==
Message-ID: <3286955f-614f-5238-b1c3-1c5807dc21e5@nabladev.com>
Date: Sun, 27 Sep 2026 11:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Peng Fan <peng.fan@nxp.com>, Stefan Bigler <stefan.bigler@securiton.ch>,
 Tom Rini <trini@konsulko.com>, Utkarsh Gupta <utkarsh.gupta@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simone CIANNI <simone.cianni@bticino.it>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>
References: <20260922052700.528451-1-hs@nabladev.com>
 <CAOMZO5A25F+JPPPYgCSUOV27=auCbrsdHqCJ+6PVvzV9SPx-pw@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v1 0/2] imx: deal with the RNG self test of the i.MX6 boot
 ROM
In-Reply-To: <CAOMZO5A25F+JPPPYgCSUOV27=auCbrsdHqCJ+6PVvzV9SPx-pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Fabio,

On 26.09.26 22:11, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Tue, Sep 22, 2026 at 2:27 AM Heiko Schocher <hs@nabladev.com> wrote:
>>
>> The boot ROM of a few i.MX6 revisions runs its RNG self test
>> incorrectly, which leaves a HAB warning behind on every boot and says
>> nothing about the state of the RNG.
>>
>> The first patch runs the test correctly, before anything else uses the
>> RNG. The second one makes hab_status name the leftover event, so that
>> the warning stops sending people looking for a fault in their own
>> image.
>>
>> Azure build:
>> https://dev.azure.com/hs0298/hs/_build/results?buildId=214&view=results
>> is fine.
> 
> Not really; Azure reports an error:
> 
> + tools/buildman/buildman -o /tmp -seP mx6 -x engicam,phytec,toradex
> Summary of current source for 86 boards (2 threads, 1 job per thread)
>         arm:  w+   tbs2910 +   imx6dl_mamoj
> +spl/u-boot-spl.bin exceeds file size limit:
> +  limit:  0xefa0 bytes
> +  actual: 0xf091 bytes
> +  excess: 0xf1 bytes
> +make[1]: *** [Makefile:2453: spl/u-boot-spl.bin] Error 1
> +make[1]: *** Deleting file 'spl/u-boot-spl.bin'
> +make: *** [Makefile:189: __sub-make] Error 2
> 
> https://dev.azure.com/hs0298/hs/_build/results?buildId=214&view=logs&j=3024cb51-9d6b-5eff-1dde-683017b794fa&t=58ec3b56-872b-5fc2-ee03-8e48280ded87
> 
> I got the same error in GitLab CI.
> 
> Please fix and resend.

Ouch, I missed the gitlab Email... sorry!

Okay, SPL gets to big for board imx6dl_mamoj

What can we do? Simply disable the new Kconfig option for this board?

I added the board Maintainers to cc, may they can help us?

bye,
Heiko
> 
> Thanks
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
