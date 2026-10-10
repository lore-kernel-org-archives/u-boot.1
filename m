Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9383CA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F3C260662;
	Sat, 10 Oct 2026 22:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nY-myBRdeqAD; Sat, 10 Oct 2026 22:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17B9A6062D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791673098;
	b=p/VVPtbDV9cbcW7JsisJ6RdkRve1wNSBM37MrpIU/s0E3rVhIRCD4rYvBVrcs3spIVrD
	 yKCIL4uYf+RIV8lfWBZLR2aBOF/EiQibEqhI+pxwwfjxJkPb5Z7wa28fAELt5X2eL3KLA
	 g7bcnkf1iD8mNPZzY6g0yBzoqq1eBPfhNLbr3FUswh7qwp36iAOLjkEzvZOhpsTRpPdWh
	 BAMIwZf6Zc/WwUjm1jlIwwNoD3oAOpY36dOFQCHNK8ZSnsI1bzYz6xhbrPr+MUXftnJk9
	 FuwDCCFys1T3l77rcsG4SqRwCjZc4RxhWTMN+FuJuvjA2R4pl0hZjxZG2gEhLdm7+2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791673098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8epDInGxS/eevNJoieBXzVOlRkP/jbW89M8jEwSXJyQ=;
	b=peyLtK+4bmnxQiVbTw2Jn1yHCHTEtU1hdIdIpdJD0dionp1CpVGV4KB/lOK+Yjn31IaA
	 TLxgznrvl9NRozpg4tGChRso4y6Ijzifp1d1TLSAMbRg4q+n6UNuD/gDkn07guiWA3KsI
	 CKVUpM68cGDpr6YfLS+sXH5djVEjntJnQ0CFJhWwibuQ/u7U5YuM2ya1wJNCJMfyrGKLw
	 BJ4mHN4Uzjg3zJ9MZKq6tHkWAvhgFWWJoZwZXlFUme2LtbgJVHpn8ZxlgRICWkgagM/2P
	 Z+amaSIe3eC3XGfMG65QhW9h2M9hUU4Atkp05b5DIlcnJivL26btME0uwigrJ0xzZ+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791673098;
	bh=8epDInGxS/eevNJoieBXzVOlRkP/jbW89M8jEwSXJyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGN7taYohkCDaCur83/xM59LykKGLiyKO3N+73I/5jCY+TcjhyOxCbObqlEVXvLew
	 SO1awYjPD+wMZfU5UsV9g2kVzxhk/YETr4AIc5hf4vj2XgjAaKGBsJpKXsddvGmWFU
	 7flGt00wT9oWEIKEsrL02iaEtZdgTnGPTWzb+Ugdr03UrXgG8vs4qMlb2UVf+fdSvg
	 cO6TiZbh2wM0mXKQKfagE4MzR19bjsShGYaplMiDxn4L3FQv8IqLqeYg/uCWTYmHu1
	 XL/bAg54Jhc2fhKxwd9APz24CHiEA7okAQJbPOOHVNNqAMP0oia+m/2jnRQdE7Bm9k
	 yZeczpVoDrDyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17B9A6062D;
	Sat, 10 Oct 2026 22:58:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2AEB22B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4A3A407D8
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xce1pmFqWlg2 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 22:58:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8ED1F406AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791673095;
 b=HWL/8C8oDg0Yap3d29rcrD7O8J/8s5iavMBHLG9oTkZRCHO0YFe71PJkzHzqD5S7e9mF
 ZwJdOcYy2rcgi+nyqCiegbhOCnBAbPX3QYQliSe9N8GmyIJx8byRR0ZtB7obXFL69zZiO
 tDECSaO0yHELoYdMvK2bSANEOEMRFBbvgt8XT6RJ77hyhRECWEg+Lr0iOdbwb44Rd97yh
 NcfLiwlTEgfMdYS+JVkhdD4Ne8lfYMzLtW1y3prqIFpshBVJQXYY/C6yDOv2RQLfj1LGY
 5YgVHNxgK/RhOEct1xlAMFPka3Mu44pu7ZNDgaOnm56mw/1fI6XnkqkTh9FfXohUhNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791673095;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=8epDInGxS/eevNJoieBXzVOlRkP/jbW89M8jEwSXJyQ=;
 b=TVaF1AyxfGu+K884MXIS8GpoDX/tC5FVVohIySH5N8c4PXYn/HQFycen6ELP9NULRd8y
 9MSqCGTlPgN65BF99ktISZz7TJu9dqEJhXngXTC9UFVUpz2Mqu4YFTcqknl3qIPdMu6rB
 7v26qRT2GZRVqTukMjCGHm2wxAUpXOU7Vg35bHUyuK68MrpdUzVCLtPpheXUXIArs5LuE
 dDh0/YqEWPv+PBMvQf6Tr/vejR24/HazRpApwrea7WNTCmUEKMismEMOX2+aO7bMvcK96
 F+QgktrdvXPtFI0lQRTf8ICfFwC6nN3SSfXhsV4kZJcEA7gIQ3mjqdgHuW3M318MvSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="OlpNq/CH"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=OlpNq/CH
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8ED1F406AF
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791673083;
 bh=8epDInGxS/eevNJoieBXzVOlRkP/jbW89M8jEwSXJyQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OlpNq/CHDuJGBV/qx4B28YKPU3NfVgdzMxksZLMxHhrKnmau3fruEPtsm+N8lMrjK
 36j9hq4XGNLwfxbA9yjlw92mrUS9PRT4Gg7JLutzEyHVLjhkK90JPo9bPYesV5+20F
 3VhgHFczHD8cMvB+iVYF4x0SzbK3IE9XslajW/MTAQcl3iIVzQRAczh9+oRCqon1oz
 tnzfoXAG3lsqu1aYAK62K6zlNS1grK36Wkl13W8LbI9vyV0y3IwXzAZCdE98l6gjnO
 0zVghh9r5N1tTl5GQMwPwsy66PubC7sMLS5hdF+qhHbUNUvX9cQXlJcP+s7OqypHER
 eLgtBi6ZGZRmA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3E291B2200FC;
 Sun, 11 Oct 2026 00:58:02 +0200 (CEST)
Message-ID: <62a524d6-4693-413a-a704-da8e83a98ed9@freeshell.de>
Date: Sat, 10 Oct 2026 15:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull U-Boot spacemit-main-20261010
To: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org
References: <20261010043056-GKA26088@kernel.org>
 <179166878504.3219985.15506887187282237548.b4-ty@konsulko.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <179166878504.3219985.15506887187282237548.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/10/26 14:46, Tom Rini wrote:
> On Sat, 10 Oct 2026 04:30:56 +0000, Yixun Lan wrote:
> 
>> Please pull from u-boot-spacemit into main, thanks.
>>
>> CI for this pull request is available here:
>>   https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1535
>>
>>
>> The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:
>>
>> [...]
> 
> Merged into u-boot/main, thanks!
> 

FYI to any future versions of ourselves wondering why non-existent
symbol CONFIG_DWC_ETH_QOS_SPACEMIT is enabled in this PR, this was
applied out-of-sequence due to a delay with the networking custodian
tree PR for the merge window [1].

1: https://lore.kernel.org/u-boot/20261009172150.GD769217@bill-the-cat/

-E
