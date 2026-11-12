Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0F606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OGypzS4H;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=MdhKussa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB6B6608C7;
	Thu, 12 Nov 2026 06:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ns7rlJ2i-anZ; Thu, 12 Nov 2026 06:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B19260897
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794464050;
	b=bS2VqT5DdF7cVIUiZUmBd7RV0tNVORbHQQmZerTgDlPDJNIlYvZK376u/DNVSkgK+Xsz
	 1O7vHXBTnb6KA7lDB/ELbhpjTbvH+KaXMFbrY3cfFh8kRIcWc953lM4/kLshpoXJpfSYO
	 WyBHMqkc/L1yklAAZk8CF26C0nCXn+4mRS9iMuNJrJ6YEjmS6hzgNSOEefcKnlZFIALr+
	 otQv4QdsW6XHa/6QgEKNYyLO3JrzPlR1/vaR4IZAYUZIMC0+0hJZsDR/M0p5Niacp90qq
	 HIUtDnEbTq0M70TL8ixLqrumI0ltmTxF7ZFVBS+Fgux7Q6UOCCdt8sleUCN1sGr+k+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794464050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/8O1urIEdkxlcHm59UuemSqdzzloBTqhprKIna68Hc4=;
	b=TQJilFDCugeVh6NwNxi9q3U4xdtHxT+qM2NaMbrhdABR3c4M9IIiBNe6wsWZqObQPYdV
	 tQnxsmbm1P5rpRQDRkUreACgNJiz1SyKX5KB961AtM1fpEfDxIh28qSz96sWJPgHhkPY8
	 nQkGDVv3ksSSb0XrNV6AXfhl2M0gPjz6B+svuROZfSd4Y12j0aPhJz9VBKxIUZKRb+GTA
	 0RGxPw2T4nrfWU+AznaS8wkVrffFbnMzeTqPmnNPeMHRBn9xNrb2pTLpg1AfTItuxobnk
	 gg2q2FRgVd2Rm+SQAcuG1RAlFsXMTL5EUoQlwrBy2HXFLvcu/vut7zTD9tXm27tyHPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=MdhKussa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794464050;
	bh=/8O1urIEdkxlcHm59UuemSqdzzloBTqhprKIna68Hc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OGypzS4HTMWHH0bd1Yi+osYFnj7B66FT5sFa+OuwdAqhFVELDjePiQ8LG52DwdFuS
	 15P3giAuMucckndHVqSIGe0vtAebX4s93CZkTZKbH7dcTCodGrcwH78m3i5eJ5b6ya
	 RCjWb79WMta9M8/Z4eHMAWDieDsPwYVcqn3iNnbj0Tf2jXNDFsRBvkZNiLOPXX9wB1
	 AjghX/+xE6a/p3HK+3BvAUJqYrI9HkEDX9A7rIVrfINpJRsh8m3bDEwZThHaSYxUR4
	 wVf7wetM9+UO/QwdjgWPqXWCknvN7ziKt9XF2LCl8fQ74hhfSt1KXhRkPJCx7k2MrF
	 jtnWpRY2hLagQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B19260897;
	Thu, 12 Nov 2026 06:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8978AD7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B23760897
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ohc7f6RfCaZp for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:14:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FBB060893
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=MdhKussa
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FBB060893
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:14:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AB5DE10E339; Thu, 12 Nov 2026 07:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794464041;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/8O1urIEdkxlcHm59UuemSqdzzloBTqhprKIna68Hc4=;
 b=MdhKussaoYndgZpDLDJ0PkFXRXiorFppOIao1BcjUZiQhcCkLSGCWpEA2C58YEOgPdUjeT
 IN0Co00jjqHIWLQ0/ZZICCPPH78LOeFvORn/QPiBQopx1hZDmoj1Z5IlutiFqFWymhCuAw
 pzETjv9PYhIJpKHx4YnTrFZJQxBySE6SQFk8I0lPygJFNEy1ltcpD8JRVD7P2B8RopFKOE
 5U5cg173A2fDtsUPBB2e84cN7qIBivCpwaBqgxnIYPAxxd5jHkg3NKI8Dr4EQAP98nO4JN
 E+nOgFurFjIWof17qdXYmtn4Zqs5ksXOfLAiSrHc9tG6PbEh43JTxM+CY71Olg==
Message-ID: <f4520acb-ad39-71d5-c3bc-c4d7e9ce96ee@nabladev.com>
Date: Thu, 12 Nov 2026 07:13:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: designware: pipeline multi-byte read commands
Content-Language: en-US
To: "Terry Zhou (Synaptics)" <terryzhou05@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michael Drobot <michael.drobot@garmin.com>
References: <CAMPWMbox-ZOjndykUunWoB48yPS8CGchCJGnFS2ZEQ218Ykq-w@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAMPWMbox-ZOjndykUunWoB48yPS8CGchCJGnFS2ZEQ218Ykq-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Terry,

On 04.11.26 05:33, Terry Zhou (Synaptics) wrote:
> Waiting for each byte before queuing the next read can split transfers
> on controllers that issue STOP when the TX FIFO runs empty. A TLA2024
> configuration read returns 0x8585 instead of 0x8583.
> 
> Pipeline read commands, reserve RX FIFO space for outstanding reads,
> and issue STOP only on the final command.
> 
> Based on the multi-byte read fix by Michael Drobot, with RX FIFO
> accounting following drivers/i2c/busses/i2c-designware-master.c in
> Linux v6.12.
> 
> Signed-off-by: Michael Drobot <michael.drobot@garmin.com>
> Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
> ---
> This issue affects DesignWare I2C configurations that issue STOP when
> the TX FIFO becomes empty.
> 
> Validated using downstream Synaptics SDK U-Boot with a TLA2024:
> - VS640, VS680 and DVF120: configuration reads returned 0x8585 before
>    this fix and 0x8583 after it.
> - SL2610: reads remained correct with this fix.
> 
>   drivers/i2c/designware_i2c.c | 31 +++++++++++++++++++------------
>   drivers/i2c/designware_i2c.h |  1 +
>   2 files changed, 20 insertions(+), 12 deletions(-)

Looks good to me, thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
