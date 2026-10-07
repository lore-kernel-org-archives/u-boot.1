Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA256CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A299F60B04;
	Wed,  7 Oct 2026 22:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HuU_lclnE-1; Wed,  7 Oct 2026 22:16:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE6C860BA5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411408;
	b=jv9jBhkEWTI45b22nSPzSx4WHPjo9XvU2TW4BnRvVKFxp4nlvolUURUfSWgJKTorbbHS
	 4F0UbqF/GGM+wvCvWzsdGby4idpz9egrseKbqaU8gGZ6ow6h2z0SxSoc0c4R4I5VmRWmm
	 mSTA6cSzONqN4DjwNBGyl0B+tYwLkfG8ZGM85IGsNPRRH35KQhYBvwC01F0EpJrZClTWR
	 cTX163IvwhH2BocWk3padn1J8dHYO3+yPgFHszDqWgndGF/Rto63x2v3lG/LpNyd7bYku
	 4fqYKrn6zUcAaBfIR8k0ijlB4mOo/Qedc5vPQILl4wbr2KtUFok0CEkP2PgNEFfb1DQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GohvfJ70TP9AbAhxSueOezUpJAtuxducB/qfdjabIYo=;
	b=QT68bNDHsBDqHjsRRCS0EKe+aF49MuJNgY3SPkSD1W6Iv1CwRAOVrx3MgPWCf4VUClOg
	 zzY5HZV+i7U2570LRtuO3+Mvdm+JS2mnq/pZe7kWMf5hFeSGPrZrpzxyxc4FirZW7e7vy
	 3UXt3tk+Vrn+PNZVl6dRv+eQgBSmi2yuFwBIaC8E/VtyrcdsLYZ4AAIxTRTNK+3UOWql0
	 +JlqsOq2JXWPconQS0riSzX/JN41pPnqNW8WpwTShK7FeiGkySPvMy/4uozul1EEtjY3k
	 EKZvROzJ9EzND3fIUnIv3J39X6iBm2XQFwspsAtXCUCP5fYO34L6Tv8I636qSVtQYZg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411407;
	bh=GohvfJ70TP9AbAhxSueOezUpJAtuxducB/qfdjabIYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GuDYkbOTcLJZmRXxcT825et5mTUmUWqUqgpsHz+E6NXMRyPRdfbOhsJU2LC5cyqC0
	 A6SC65QgaPk/jyG+GuWCF6QxTGy6Pr1XoSr4EA/B2FQDB0UJ3vskNRhFHhrbF0RAAB
	 BsexP0IDGi5b30k5CyVjy3X5LKUP51Nbys4W/AWvLJIw7mgN8/naHByZRDfj4fUTL2
	 beNW7foSMPQfKLgUP9CuNHUl5683ODOu/VY9B7KSmCazXcvahwOOuK1zrT2Y0Ja4S2
	 HRgnZNASGQOJyZQ0c9qgWoXoJYuFYg5TinU/R/Pn0Nrua+X1EaTmIe1gvc6VfLNVdT
	 on1SVoFJuI+ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE6C860BA5;
	Wed,  7 Oct 2026 22:16:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0117775
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E736D4008C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:46:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlcitC2EgSUN for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 21:46:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2DB6440080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791409604;
 b=rSUxhzEy/Oe68JX0amt0OeI0IaMy1esFEDsMpDGKhZyIaS7pN9ATDwiPj79d91gLAUBm
 TEJU4twrJpPvMz0NERc1A5LNBha4pIBHkUdUhlvT+K93gPnF0JOPdRl0t2n9V0+hZzEne
 xX2qpnaw2qICQJQRnC1LCu3zDY2IaKwvnIZyajc+pVw1U456Q3AM9rKYoIqec5vmYXpNc
 ozA04NwNHYLaDiEroGM/PCHeQFMDcxyC5yC58AkAwnk86krBditQtLFjJf4C1lHWRsyAD
 MjrQUEyYiQgkNaKiLhC7f3W0/8YmkP4ulNUt3dMhat+CMfK5lIUNH7zkO9LY8df4+1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791409604;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=GohvfJ70TP9AbAhxSueOezUpJAtuxducB/qfdjabIYo=;
 b=rB3wgOWbBrQpFGpm01DX/NUEBcng7ba30Mv+tYkUbpHiJsbIEtfYdClREZgEClUOg5AJ
 NypJMqInXA2D7EAPvKuJOjv2EvtPXXrm0T9599oABkannMKrLdzL/sdBNs/Skm2oPqQDW
 i3swBPTLTf6oC5Ui3xlBd4eFcMXqLunxf6cBfS3ybGqLeEAMPT0TMD+mDJTuBjg5xQRxu
 aIqAczB8U45Jr10lyM5r5DR7GDU/A7gjX88XCV2DnGoOf1/gBXvZjHZ7fYAO0uIZRuPQm
 EtAB+mq9zRdtTynGiDF3KE8wdHeptB5GEvVEjOQbwYBzPbebf5z009aYwgc7Vq+8KEw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=A2ZkVYGJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=A2ZkVYGJ
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DB6440080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791409591; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K9SuGLiFmWS4O1Fdg/ODI/j7VVdFeUfdFC9dK7L9JvujKaNlMskDuwACruIbxG4+DE6/7qy/6M7PhvCA5N0Q/mgvTA1AH4LmpWG2/xt2nlI/Ma+D58osRQsPnF9N4n273lVBDDYxI2/QF8EmSab5MuSyAU1q9ZelaNQJMo+y7MY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791409591;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GohvfJ70TP9AbAhxSueOezUpJAtuxducB/qfdjabIYo=; 
 b=coXQHPJBfsehbcOVeiLCaDICQcGeiAj7+tjy1xOcTqHa7h4ZucmU9qZlTduCWrLJn26jdpnzVO1iqodVf56gQ9TkI4KVSDz9wo9csosGfM4gcMwID8HuruqJRC9vpd5Jyj/yij1sacHtgXLTb0h0RcRUqs1khAkNjhl5iYF9PBI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791409591; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=GohvfJ70TP9AbAhxSueOezUpJAtuxducB/qfdjabIYo=;
 b=A2ZkVYGJcs45ycRPT8mhDKdupP3XfudwKZnqKlzI6bSyCJyW9SPqOn4Q5wzryMl9
 stmg53XhuFxOXiflVmU/0j/a0sKkZzzIs1i10I5CyujK5AzGL1Oy9KFKwlFyit2C7qd
 VDQtKh9tkquCFGA8WhyG+X1YpHtUCVJRblXEGLpM=
Received: by smtp.zohomail.com with SMTPS id 179140959063122.478478107243518; 
 Wed, 7 Oct 2026 14:46:30 -0700 (PDT)
Date: Wed, 7 Oct 2026 21:46:25 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>,
 Leo Yu-Chi Liang <leo.liang@sifive.com>,
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH 2/2] riscv: cpu: cv1800b: keep U-Boot out of reserved
 memory
Message-ID: <asa9sZjT6Oo0Druq@pie>
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
 <20260930-256m-fixes-v1-2-69546876ff28@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-256m-fixes-v1-2-69546876ff28@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.389.60
X-ZohoMailClient: External
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

On Wed, Sep 30, 2026 at 09:17:50AM -0300, Hiago De Franco wrote:
> The upstream devicetrees reserve the end of DRAM for the coprocessor
> firmware, as a no-map region:
> 
>   cv1800b-milkv-duo:    region@83f40000, size 0xc0000
>   sg2002-milkv-duo256m: region@8fe00000, size 0x200000
> 
> ram_top is the end of DRAM, so U-Boot relocates into that region. On the
> Milk-V Duo, relocaddr is 0x83f76000, and LMB then fails to reserve the
> region:
> 
> ERROR: reserving fdt memory region failed (addr=83f40000 size=c0000
> flags=2): -17
> 
> Implement board_get_usable_ram_top() with get_mem_top(), which returns
> the highest free window below the devicetree reserved regions, as the
> Xilinx boards do.

You might already notice this series[1] removing co-processor-related
reserved regions from the upstream devicetree, which, in my opinion, is
the correct way to go (and actually suggested by myself), since the
code occupying a memory region should take the responsibility to reserve
it.

So issues being solved here might simply go away in the future, it might
be useful to add the context that this is a temporary workaround.

The other way to go is simply removing the reserved region from the
U-Boot devicetree. IIRC the vendor FSBL doesn't load any co-processor
firmware unless you package one into the fip.bin.

Regards,
Yao Zi
