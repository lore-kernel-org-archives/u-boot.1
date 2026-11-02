Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F05606A59B
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DdMW8nAX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cwVgl66F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CEF840715;
	Mon,  2 Nov 2026 14:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4EM4gmPb2xi; Mon,  2 Nov 2026 14:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42D7C406A5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793631445;
	b=b92yMf+yCJ8RczH71zw3RlLyn/Wi1mfCW/JPHyeQwWbq67r5IbKcDg3CZ9Lfdmgy676u
	 hUmkAel1TWaCcdX5Fr2dx6avvrLkPMcVUHcivylXWrYAYkddw8PvtcDnAbdqDrWjKtdm1
	 TOw+YYfM4bJfZ2Tggs0fziiekljJZ9PXTD7JIX9aEW2YjEZStjnDT2Wr7A5IEV7mm1Odw
	 4Mucfp6zIJoGJQgx9FUcvyeJtrB4f69knUH0tM4YKCgrL8frG/HaOKiakFhkFGv5dvcwx
	 icrDZPJbXaueDwpmb7OYbowA9GQskhxC7BpKT75TJQ6csrH7Sy4qDoq4alKV82FDZ9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793631445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B2beon+Pup25sDG+SjYjRtoecAPqMns8MF1LmxMk16g=;
	b=IHSHToBoWt+AdpMVs3bbms2+aQn0OrrSoYKg+kHYoOry7cexDEkqtQ1uNOob0AIV5oQF
	 MOMxEZPusHIyNwBqGvAl1K/L4ndus5L9ih5RogQwehrKXXl/BvF5cMaaay2q1f77Ck7Uq
	 yiMSCA+XMEDnMJiEWx9uF4Ibyw9vODWyGEijz9oOc8XX2ZjjuXWLTTz2zc1aAV5Cl6Otc
	 7TcUiqzXaJk4+kBZ5zsGdxwvUoa9cyoEJzHswg+65mfpPbX1+y+lbwrurhcZ6Q9P6P+mS
	 Kjgu/qirvtdj1ga5075jK/NrrodjXMPfI+0Jf2blQW0eSdGF4xeam0kcobjLE57mbzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793631445;
	bh=B2beon+Pup25sDG+SjYjRtoecAPqMns8MF1LmxMk16g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DdMW8nAXZIKswXm7FX+6m06Uq/wRNNmy8BqExMCWcmq/ERBUKAr9L/0CKNLgF1/AW
	 c5UX2awgTLEAfkBgU2onko3hhUJQanLtNBVqHPu1HjQwWlbnDvdgChGhOZE1eDFNpI
	 0qwzMj0bmN0qvK3hg4Lnc6Cc0Y4w1x3IRZJ4Rj4THEWa6fl5LGxW5BnCjfmnDn9OV/
	 HVAw/s7pME7lGwAtd8UBOmHvSd1kGa291O/8P9nu7JaVAFWkBCJak571lWNQtfjGMX
	 6vOo8uwcT1sCFhfuxuXqBHi4f80q3r5M7YVFySwarG9Vnz8x4XhC00ZuQxmGEIDqEV
	 rgeIdJz50bNLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42D7C406A5;
	Mon,  2 Nov 2026 14:57:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EDFB7D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFA7D4018C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQa-kTRYFvQm for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8395E401B9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793631442;
 b=BXbxONVUETO8JtAAvbhFosD3aGgda8e1J1yib5MqLPaqHFrSd/wBaDHZdjXYGgrg78EG
 /MXp0vUlFjsgtkZaXNmFkSmjHnnmWptt18jEKcD6adsuAgWKqbWtB+8/2QJ0jdzJ/tuv8
 631XNpF+eDDwMVEPr5qhpC5oVsZ/IIRePD+fLdQBa+5vduzCiQ5VuDpHL9yh4ksXSAuuH
 Ozg6ABHIwTB4TKJRdFHCQ/qJGWuNaZgwRgCFOPrBBwf6ioCYmhcI+APVCwdrMh99zLBPl
 c/UXGsb8uVurFozDVWeGeGCawXJp44N1V6VYyS7noiTXvQJAdqmcnUJXEjeqQC8KVAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793631442;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=B2beon+Pup25sDG+SjYjRtoecAPqMns8MF1LmxMk16g=;
 b=Ar6IYfQVl0JCsDy0R9Rrlnya3kg+Vi0SVnZ7LbvDxDEVG0rZjX4jYX+kqexb8V6lUHnr
 ilVFVlewxYnwVX5pD7sexWChx5Nc+KwkeDON+N4OPhKmiytBk4kG3wrysv6yfzPAQWie5
 hN4bqU61Gp+M+VzXWKH4Jb/Prjx70Bcw8FVLKWvdd+m+eUCWP7OTazEXUsuNHRArIX5Rl
 6m0Kk/qhD5KIKd6IIaygXl62N5Fiixv6DUeLKnfJGZY5JbFDyo+3QuouKzWMmXB2vpVmw
 QR1TivlQdbakZO+HeBbXGGWRovZz4BQ0Gak1KcPC2TYQIpZI5INtDkGicNdwvcc90og==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=cwVgl66F; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=cwVgl66F
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8395E401B9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:57:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB201576;
 Mon,  2 Nov 2026 06:57:17 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 9EF573F59E; Mon,  2 Nov 2026 06:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793631440; bh=+Tn4OtGI6YEQPxYG9LL7ufXWOG9wN6boPLoR0yBa418=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cwVgl66FHJKC3Ob8jeGYH6z2EHwGzxztri7DEPi+M2YzZuSE0m0Dkplk+PUapcCQf
 yHyP5llqGD2X+buTWBx+GX7YGeEVHxXMbVoL3Hwj0/Za8trXe7zVUm/xnl+nXPuEJc
 gapgynBSWPZHKPnkq4pBr06R65OSUCdrI1Cq4D0M=
Message-ID: <d220155f-78cc-4c23-a801-8b1fb0962a3a@arm.com>
Date: Mon, 2 Nov 2026 15:57:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: u-boot-sunxi/master for 2027.01
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
References: <20261102114733.3468703-1-andre.przywara@arm.com>
 <20261102144240.GS3309461@bill-the-cat>
 <a4934306-eb4d-4a0b-b693-82b8f8d831b8@cherry.de>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <a4934306-eb4d-4a0b-b693-82b8f8d831b8@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom, Quentin,

On 11/2/26 15:53, Quentin Schulz wrote:
> Hi Andre,
> 
> On 11/2/26 3:42 PM, Tom Rini wrote:
>> On Mon, Nov 02, 2026 at 12:47:33PM +0100, Andre Przywara wrote:
>>
>>> Hi Tom,
>>>
>>> please pull these sunxi changes into main. Please note that's the master
>>> branch on the remote side, the main branch is immutable, so I couldn't
>>> push a fix there again.
>>
>> Ah. On that note, I think the answer is you should start using a branch
>> name (for-tom, whatever) or tag, rather than just pushing to "main" or
>> "next".

That makes sense, I was already wondering what's the best practice here, 
so thanks for that!

> Maybe check in https://git.u-boot-project.org/u-boot/custodians/u-boot- 
> sunxi/-/settings/repository#js-protected-branches-settings if main is 
> protected, then you can unprotect if you really want to (or adapt it to 
> match what you want). Just telling you how to make it modifiable again, 
> but maybe Tom would really prefer a different branch name as requested 
> in his previous mail.

Yes, I guess I do it at least once, to get it unstuck, and allow it to 
follow the "main main" again.

Thanks for the heads up!

Cheers,
Andre

>>> Not much to report here, some cleanup for some older V3 SoCs, also a 
>>> PMIC
>>> fix for some Olimex A20 board.
>>> H6 boards with 3GB of DRAM now work again, and the A133 build process 
>>> gets
>>> adjusted to the now mainlined TF-A support.
>>>
>>> There are bigger changes lined up, but they depend on DT bindings which
>>> have not been merged to the kernel repo yet.
>>>
>>> Gitlab CI timed out, but worked fine until then.
>>
>> Ah, I thought I had adjusted everyones projects to have 2h be the
>> timeout, but I see I missed at least u-boot-sunxi, I've fixed that now.
>>
> 
> FYI, I had to bump mine to 3h a few months back, but maybe the infra is 
> more stable/faster than it used to and we don't need that anymore?

