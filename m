Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1A9CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC40740632;
	Mon, 19 Oct 2026 12:47:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A309Unndm3Kg; Mon, 19 Oct 2026 12:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 390AD4062E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792414034;
	b=WODwVkX1Gh6iQhEl7lnZRMBK1nTIIzexnEbDbpet+U9Lv3locFokjwT0qJ/jZju3wkKK
	 RuHMkXmPI8QSajCc9kL1du2BCp4dlBDexpC8KSRXpKvFSXVVvR1qxAGBTqau7OnnYdjlN
	 1QqxcPBQiaiD7Nqd+WSW+DbWHQnDGZcUkMdopAZLhLiOuPEtpnlNJKXnqPkGBZC+oXXCC
	 xK4jP6V1twRP0MXNXivh0/dhr5I6oz8pUPB0xpsZ//Hy8lP4wqqumJHQ5y11yEdTt1UVf
	 By9+FlAGl4GWLrv61s4Noa+Tph620UuEo47Lh3XdzeX+x4PpzV1u1yOjqAj4eFkv9yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792414034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mm6dLoS+BmtLnIgkwkt3C1WGyRSX788BBgujAk2FVwY=;
	b=k5RMhMIXVKtP6QSqioQUy50EUf5jrilvnTl1n0NSHD773P9daivM0s7S90XccXWVFlKC
	 mRSHrIGuaxsSmJ3C3nq6dTNLOciIa4C/mTm6Gs0yMMdJQ23VwVlQ7hSzLc09CEKIChCKx
	 xKXwMgQeEJCxkPfNVwgohk+C8ooipizSxMRzkjzuV477KHhBnkGpVTtZms6vVQOfrlBSP
	 xkV0BbUqRnbXv72YH1shCL6miu1H+dxOy//7pQYQ29b7Irnk/VoUPZqjg+f5h3TCcIDuX
	 egFICJu1oDAUIXumilp8uoUibtbX97ua0FR+UyPgMMnewMywtrX0r5b4b/HkwOKQpGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=R9fJP+9I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792414034;
	bh=Mm6dLoS+BmtLnIgkwkt3C1WGyRSX788BBgujAk2FVwY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SrcW/E/xI1PEHdHHOmagMx4gTxJIOD0fHi/FaAfMbBfaM4RmLdr3aw582vNGRoSN/
	 Bkppycg2qcW96PCPUsx8q7fqJQLkP1bz5C5yTPHj8Ht8f+bo3QMThIJMRd9/lYqAn7
	 PEsHI24TRJ4/J8X9bu7X+CNsjQX1O06qHFJqAcXE89KWI/Kyr9iPMKnRIgpYiEdlPE
	 DCjXjUoL6geHTulu8GHiRE8AtTxkSyiU9sKqsJNYDder2IOedNNy/OKfH7xYMGgM6+
	 PdS2ilkhUntDKswTl6i9g1hB9JDJhf6fw/QJlGLB3dS29ITE9GlP+8e5RWUQ2E+FMw
	 HMeJinbRllrug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 390AD4062E;
	Mon, 19 Oct 2026 12:47:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CCD701AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEB684062E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v33avGJO_gNM for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91BC84062C
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792414032;
 b=Abu+DPc14JfQlW0LueML26i4hfydFdGhQzsvv/azIn5iEciHUZsN3rgKbtCYQvklyXnf
 TqL45JNcjuLFvS/rc9/u+0jlyyoY0tLxwGCayn+WmEyScgRXGVcoNb5Mjwyo5/ZeMoyKy
 BzbPrmA0vZ0g7xJS2h8uj4UiTXS+gpFJLDvj1CENZ46L6JO+zJgHKO7Nv9N6kfaakzsl6
 /8cARrPVlPmfZ8kvZSWDAjPrhBO4OKgxGEw0RkyIN/f/4F/ZkFA1sogu1rhVqKyNHy+7l
 8KIv6U7MblwNBWFW9tA70xdpiLw8MuvoVuKKuA+gb/vFSsaNNjdUTHf54wZr3MlPQtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792414032;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Mm6dLoS+BmtLnIgkwkt3C1WGyRSX788BBgujAk2FVwY=;
 b=DQdYaQZXnbN9Nsvxi1VjiASJMfAS3STarAP7BPIkN2tMg+qmd6drhg83xUV/xXeUTotP
 kjLRRmBwZZRzhKFCqcLKXXdpV1AhrxKsDKY8TL8vDXXsqWziUkUILnLJ7z4NtuJ0MMQLH
 agmV8nU75P+gggth+flCqYaPtpunJnDVggmBvwmnYz/X5E/DL+9wnJNWg0zFPFB8QkGJb
 SGDKiQUl3WA1xTwS4K+e0rmoFJJoFwsJ8kp8F+RIyMZyPu3WVe5c14NLEnj27jtGSPgct
 d6TuLcJCXLtkLSI8r2EXXfVgZci34cwloaDBGnbDsAZqQaj0UyeOdSxO7G95Jkeg+6w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=R9fJP+9I; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=R9fJP+9I
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91BC84062C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:47:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D5D6710869C; Mon, 19 Oct 2026 14:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792414024;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Mm6dLoS+BmtLnIgkwkt3C1WGyRSX788BBgujAk2FVwY=;
 b=R9fJP+9IIjerKzO/YGxailxs1K8szL9A9yHN+teon072sG+8wVDgSCYoZUvF8+2iil+Z26
 vi+Jwovxd5KrOAcP2scuTTwY/FGKAbB/Mz+K2fD0PU146n6Ww/cH2XwWoLoyvGaIsk+Ayb
 8+1v9FLeE36+A0HBDTRsH0HugtzqoEN8QKAT/QpSfpK1UhJOs2Z6aLqgYMMqqChhyPHrT9
 pCY9erc8JNXK3m2XMgSQeELmRAjExSA0V1d60XfGEkPbk2CT9t/dB2Q6lhT8V/X7x7cyq/
 QMjyRf1w49hHg7j2lqLK0Ick3wGAmwvUTCC9syeiqI/VXrtIgjHxQnS80+z6Ag==
Message-ID: <542b5753-9c28-4565-b03f-f7b300351821@nabladev.com>
Date: Mon, 19 Oct 2026 14:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security: "Permit write access only to listed variables"
 restricts only environment loading
To: Fiona Klute <fiona.klute@gmx.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
References: <f23265e6-5dff-414e-94ec-ab7312a0e1dd@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <f23265e6-5dff-414e-94ec-ab7312a0e1dd@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/19/26 1:28 PM, Fiona Klute wrote:

Hello Fiona,

> The kconfig description of CONFIG_ENV_WRITEABLE_LIST says:
> 
>> If defined, only environment variables which explicitly set the 'w'
>> writeable flag can be written and modified at runtime. No variables
>> can be otherwise created, written or imported into the environment.
> 
> This does not match actual behavior, "env set" and "env import" can 
> modify variables as usual.

Right, and if the attacker has access to these commands, that means the 
attacker has shell access to U-Boot, at which point they can do pretty 
much anything with the system. If the attacker has shell access to 
U-Boot, it is game over. For CONFIG_ENV_WRITEABLE_LIST to be usable, the 
U-Boot shell access must be blocked (bootdelay set to -2).

> The only thing that is blocked is loading 
> variables without the "writable" flag from stored environment on boot 
> (and "env load" based on what I see in the code, but I didn't test it).
> 
> As far as I can see, the issue has existed since the option was added in 
> commit d045cbacf2529266bb312add023e12c0d400bf67 ("env: Add support for 
> explicit write access list"), where the commit message explicitly states
> "env import" and "env set" would be blocked.
> 
> I consider this a security issue because preventing modifications that 
> would circumvent security measures seems to be the whole point of 
> CONFIG_ENV_WRITEABLE_LIST, and it only does a small part of what it's 
> documented as doing. For my current setup restricting what can be 
> changed in stored environment is enough, so I don't have a strong 
> opinion on whether description or code need to be fixed.
Please see above, does the security concern persist if U-Boot shell 
access is not available ?
