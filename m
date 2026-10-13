Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645B0CA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 00:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C25AA80BE5;
	Tue, 13 Oct 2026 00:09:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hTkfpFfxyCVY; Tue, 13 Oct 2026 00:09:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BB5D80AC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791850197;
	b=S86j2krFJIPdsKQs2HyB/bEMI9EeoGE/ncA9PvMWAA/vNnrNPlM5vvb1Se6wRb8cYrik
	 KYuxyPgLejQqPz2JU6G3ovtQB6KJ59uUvAcIqTJPyD8aA4QMd3SHflqhh2Z9fx3JghCq3
	 HDuSocOG+Q0MrsChPVK+0xXOaTqBLkWFNrNJkJcG6I3iGSURYTQX3yTmZJb3iOYybCp9e
	 hCVzcNncuzzfRk4UKeWWbIYCJF+5b9tfeoZhrQfRvbubKb9OL+zhtp7QJACAU9MmL7X6x
	 SXkaCgsIMVCOXSCzJUKBEU7L4FW8mOEUBMBKBXssTWphtGflx80j4Q5rclCgJTbdLRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791850197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WH+csX4is2iBs4ZaWvVJuxFUxswn9vLUhHugXVijNuw=;
	b=aBK0NWv/V0M31KwtVj11al93oxiEoMUO0PmvU8Z/OiUxvr9BCfBbdZ14/0p1+QxfvrII
	 MPbPNR4hmD5rd5BgKmqE1cPfAbi6x/D1o95e6pXade/8dnomhdkhW3Qv5eHm+MYH13RaC
	 FRNfDV+z+gAI5U9KNjklEkTL1slRHE/gMTayG2xWiOnictbob7nRE87EFo3hosXxvEoj7
	 KC2c/13Wu4PdbmrJYcIOWclRAqNqAJOhHi1VcFWi5zQ7JbEzqktgYWF8oGNTHhiX62xXo
	 f8GnGnS4JWqaPN35POTYqvWUmu9HxTIZvwdVjk749En5iATlgytlfT2Fsp2kKxO2p5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=eGRQdySw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791850197;
	bh=WH+csX4is2iBs4ZaWvVJuxFUxswn9vLUhHugXVijNuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=alYlqOEZiKPPYQoMUehbACOUpE0Sju2T2bbjgevVrHQw60/Mx2h6aClhoDKvJrTHF
	 pceDE3A3ocY0DfHFZjwGr0njeBVs4HQSbc+1fC9XjkzlHAo2+AVljmfg/mT4Q+rix4
	 VjSb1yFvBPobJ1Irl96wT6kTdROheUgJA5nUe+p//rQC9jtrugZEC2lMIM8sMULMGv
	 0d1bV/vFDIcV05NOUvjbJok45ajzlrWhnsXCA7J5rkgFHsqB7OEUqqM8JwVv1INzbK
	 UVIywDwxllCOnSwXMEJc3FAYuZDtl6+lQH+TYC3IYSHihYVtoce6iof2t4XEskaRJn
	 5erKfVPpEeqPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BB5D80AC4;
	Tue, 13 Oct 2026 00:09:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B76DA788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8A1E80BCD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rgNkPVEwhR0X for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 00:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6ACFE80AC4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791850195;
 b=r5YAbcCfHZvtj1IJejnWfvMB8qzc42lF6+mEtQsPxxqQOLd4/fZYfCs4mitwoqQynXuX
 UkbxZO+TQYjU5GGRhEXidYHHvn2eHj+/YP07XbI3DVMIPQNw5MSv6tsAClIVulvzQSSx3
 kUwYscNG8fT5YvliRjVRaTObUwbfZtwmz2fv5uQcUFULnnEdPtpDg83XnTszUQMv38Mzl
 89MVqvuxE+esKwaVhqj5rtrEgAWfhXWm8pNvtCD97a4luu2iqJ2KNZzzBArQFQ2UXAHxj
 rPEv4aHUGBtk3DKRRl4c3GEuvQqFZ8wWEyR7r0Gu8vB/8nNJfgVKO/w0KzAj2+yWFRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791850195;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=WH+csX4is2iBs4ZaWvVJuxFUxswn9vLUhHugXVijNuw=;
 b=Tv7A1lzcPe4lOXQZ+X5XrASetwgd5hhr4wuPrJQnKS0oRyMHJDE1hg9CxJP/Z5ckS3RF
 e3XNUXRO5syasUdeAFubcpO72z+vu4bPkKXoC8Vhk8FWWmk6x/jjmRL/NTYuzJb3tLt3E
 0cz5RFuUMsmL3VXfd2F5ZVn1u3DchpvwwX6FwQkSPkOJCuTmNi7QiqmLdt1HG2bf0W0FQ
 hm3ege7tNrZNGSmj/QQMJeWdFhEHuwgTYmRIZFDJF4EleNkZ/VEeiQzHE/pBOBvnwtlH3
 3/rENQ9/5n2CxCqjdFWvrw+bTb3NF1FuOjHfNpO9QTs5i1d0Lrw0pQAX4pb9U/dR1jQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=eGRQdySw; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=eGRQdySw
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6ACFE80AC4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:09:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E8C691082D4; Tue, 13 Oct 2026 02:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791850187;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WH+csX4is2iBs4ZaWvVJuxFUxswn9vLUhHugXVijNuw=;
 b=eGRQdySw5Bg7/9i6psW8dJ/YeW0nBOvSMso93dybPAYdRv55AGqI1NFOGS1ktaaKLASv7+
 K2OiNecIIyKJHlwIJ2DUGK1acTUPHiIRUt0wT+nrOEh7YxgoVlwAA2d1CTmW0tuh4x5jfG
 2QN0q6N1ZbBbvLhkOVoRzTuR/DH8PHiiWBfM315m3mts414xnelH6AjxqhNv5ppSsUqRYF
 O0OGLaFRTIgHGHhyVkd8MzDMg82Iuy4SjcOxXksm50aff8d8AnJRAP1jGkGM0oJqDPV8gE
 NIqaKMERYq/SYRTJMu+ju0V0/qICMPSoFXW8sacJZVQpKJ6ks9uKI2DK/+/BqA==
Message-ID: <8d8690ca-2f50-1d76-6a36-c66a60b5aa5d@nabladev.com>
Date: Tue, 13 Oct 2026 02:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] spi_flash: honor MTD_NO_ERASE flag
Content-Language: en-US
To: Yasir Kilic <kilicyasirahmet@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Ssunk <ssunkkan@gmail.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 David Lechner <dlechner@baylibre.com>
References: <20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com>
 <20261008-everspin_mr24h40_mram_support-v1-1-d8f14da1a997@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261008-everspin_mr24h40_mram_support-v1-1-d8f14da1a997@gmail.com>
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

Hello Yasir,

On 08.10.26 10:29, Yasir Kilic wrote:
> There is a MTD_NO_ERASE flag for supporting spi flash devices with no
> erase command but this isn't checked.
> 
> spi_flash_erase now returns 0 if this flag is set.
> 
> Signed-off-by: Yasir Kilic <kilicyasirahmet@gmail.com>
> ---
>   include/spi_flash.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
