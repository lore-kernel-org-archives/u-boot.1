Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8B606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uDjbQiMo;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=evNliep5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D064077B;
	Mon, 16 Nov 2026 16:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QJgTddcv0O5; Mon, 16 Nov 2026 16:08:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52DED4078E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845322;
	b=Z8QN7CqWHSUEgt3uMpsO5xJqmON97rYWFTjh5VGgE3krHrhIhYwbk7ff8Q3hwe974pp1
	 8N+q9vT8KhgMfd9L0kACe1j6tobYw//0FiY8jWN/go03z4L+AplpdqqiqAJHAxtqxIbSB
	 kjgNNY+EygC2xZl5HS7B/77XVdhS/3/0zZOLVXnnfNAT4m2e/ZPrX8cdG+6/gGixlJlwq
	 8wlrLlh5OVxnxW+b8tFJEftGYyoNBygUNdop0BxmrQ/fDVf794W+NKdfSb4ZJNfeqT1aH
	 Wc+8815iWoeU91KpjZM1/SUh3ze4kxeWFQUfRI53wJrp0Nmx3y6Q9STX6AKUfmDQVVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RQ7+O5BbfAQ6gjtePTpcklmeGwlK5hahmPMu8+GnluI=;
	b=l4I1kmObbjkfzjsT19Cx2pbNnOhDxxwYNLQArd/SpKdqUoRNqOMx14tyN2y6JCVtbuFI
	 d1ZeMYxWmULMNTGp0B12bFHJYhrsr9qteFS8ALyjNn4NFsZLJcOER+2gT0ZSP77jxqwGK
	 yJhdqQDrsrMH/t6JOZVgbImHTcnPcEteNhO/vXkOfosFpor1y0ZrjT1bGtcbOH1S3wdcw
	 0YUzCieKbPBGvZTnmQjQ/8O8oBzZWIa1jXz5iUzPisqG08t2KyoYwvt5iUSKJ3/lPHI77
	 aF09v3cLXqyuO6F7D6rUoL82Bl2w2PiYEjS8gWl4QlVsuS33zQ3kfekY7qO+VP54Tug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845322;
	bh=RQ7+O5BbfAQ6gjtePTpcklmeGwlK5hahmPMu8+GnluI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDjbQiMoZ7pel7uuE9j2xqwpT8N2YcsGAYPWY0SUAXYg20ApuyBzt4Rpka5K10W6k
	 AUiGriViFXmZjKHgaPGS+kcjohIvVPsAu8Xhe3ZAiZ5Ny3maZZLQOt+sztV134PUYB
	 nesa/aPcErgZsTflpnsGf9eu4u4QOM4Ob3+x81fQN+BHI2ZxN1etD/vGVlXwk/VA/g
	 BbVfjatv0BsWQ12m9aFS8qDHiNml5rY40HAsHWzUF1W/ylocE6ZNWs0umaB21yMMrp
	 kN6vTIqO4/jKval74bLrWocQmJ6ZP6kBeSrEkkx8LQ58tSp42lOLV7gOsmKpY/gze7
	 xeyn39cM0jPXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52DED4078E;
	Mon, 16 Nov 2026 16:08:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B82A34DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E99580DA6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NuFGmPwP87A2 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:08:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D9A080D7D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.13;
 helo=smtp-bc0d.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=evNliep5
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D9A080D7D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:08:38 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSt841Mx7z2H92;
 Mon, 16 Nov 2026 17:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845316;
 bh=RQ7+O5BbfAQ6gjtePTpcklmeGwlK5hahmPMu8+GnluI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=evNliep5m+3OCI8g6I81q4Sxx94o4P5tlL7b1MWEw5bF61vCtM24Dpio4KSKzuH9K
 QbUWtcsoBnL9spTBa3MuCl+ZEBc59ZNQShbPLPMpWdBOKL+1GtfXFemXcyJ+dvFHGb
 g23pbh+EuQF/bJsWug7n06yY3LBZQo6VKEPvw2meU/8QC+MBjn3g06kEnBQ0CL2Cz1
 leZdGfGSPpUpPL3wdFKS/7dlkkiqAuy9/3KPiyO8DbjwVxLDTbVFuIuU+Ax1BxK43L
 8rbsp0yR5NcOKdHKO1IdFM+62CkYf+Arjp3LYkbCzhu6/SFaxIe3Z011UOo2z1gmx/
 iqTwD/IcVRoIQ==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jSt825jX4z9Y6; 
 Mon, 16 Nov 2026 17:08:34 +0100 (CET)
Message-ID: <a465933f-ff45-46f8-a9f5-92d7e7689794@0leil.net>
Date: Mon, 16 Nov 2026 17:08:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] doc: clean up README.rockchip
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Johan,

On 8/15/26 3:05 PM, Johan Jonker wrote:
> The removal of README.rockchip is long over due.
> Prepare and expand rockchip.rst with more info.
> Move the still relevant parts from README.rockchip elsewhere.
> 
> Johan Jonker (6):
>    rockchip: scripts: remove rkmux.py
>    rockchip: doc: add mask ROM mode text
>    rockchip: doc: remove TODO
>    rockchip: doc: remove README.rockchip
>    rockchip: doc: add back to ROM section
>    rockchip: doc: add notes section
> 

I've decided to exceptionally merge this for 2027.04 as I believe this 
is going the right direction and that we (I) should be more open to 
gradual improvement of documentation. I'll send a follow-up series to 
fix the issues reported in this and earlier versions.

Thanks again for looking at this and for your patience.
Quentin
