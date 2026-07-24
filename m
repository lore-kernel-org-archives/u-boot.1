Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4326BC531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3DCF80D49;
	Fri, 24 Jul 2026 08:29:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOisKjlugKvc; Fri, 24 Jul 2026 08:29:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1511F80CEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784881785;
	bh=n/9yqlxbr7nmGJCGcOJ+lNkYkURPj1TrxUqw2zDYZEQ=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LWSU6d+I+rtAKZhR4hJaTYb/uj7sE0w6XJcPxynChnslxPQ7qXmAcfc6p+2xm7L7s
	 pvjsOwjLg8W+pmwKyBOp8gGZ0+O09hiEuVko+y/KrzWPJJH8mY33P03jJsqcv7LNsy
	 Ub/eHQWJ00WDGdyZH5E92RhDzetbKDEMt/4u3Bvqh1tBf5ZyhenBZaRVBAWFVmaRSr
	 LBzgT8aYds4Rzv1XZGCyfGvQWYK2SbUMsw4kRi1dgQdnxcuGTzotkSaKQb1sr7OtP7
	 yaFt44H73MgPhBDAhc1kzV/cgc+D4e3r6nO8V/datq0gailW7tL5O5nlD4Y1f2fzxu
	 Dmsl1f1j5lwTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1511F80CEA;
	Fri, 24 Jul 2026 08:29:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 705EB78A
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 557BD40A36
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:29:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPc-bvCplELR for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:29:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 74E0340A32
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74E0340A32
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74E0340A32
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:29:42 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso131367a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784881782; x=1785486582;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n/9yqlxbr7nmGJCGcOJ+lNkYkURPj1TrxUqw2zDYZEQ=;
 b=PVQ+/97c+kAZ6oVjWgF8TchKUuqiTi+iCWZNCOXQqCtwo11rkSrT1/XgzbfWruJwP3
 APMcIC9uE0a3uNRIo6d26sJJudw6kxxgQlmd+88mXg0Xge+ZhkunMFxteULD9oPIIhMP
 uyY8/bWE4VTaKvJjJaKkne5OZZPJVlOonm/TiPF7/QITvGHjnYDUFga5qEtK1EHPZHSe
 wMWCw1XBbxckXVvJhjuPoMWfG8stjlCXoyHhtp1kEOkxTNf+q79TXn23CKjuKey6S2fa
 LI0p5FV9CeiyGgv/394059QQ5YV+LkVPdOHK65j6DcM2awLG/lpKofGDU2rOhD/FqT0I
 SZfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMDk8ldFzFLKB630+dqx/rayg7+WiprfmMGsbzWYs3hWNc2NMFprcVZoTwvjj3o0wvfN2iL2w=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxwH+KL3RLPBzm/aMAupBz0Bkab+gkERssSZRDXcZuH8n115z9V
 lGp2fHAuH39d9nMaij44jtuUEf5YCf0Ol3GIWnD32OuyulN+tXaps2gJztHjOItNtYE=
X-Gm-Gg: AR+sD10bAVexViXLh7DFSKZntAnrPZiZGRuEvGazZK1SMoh9eOvRf5avYCfrPyU68lN
 13czo0i5iMXQRkVRu5mgnoESe/TXFBvNSm/Pbu5+w3J5HuXsocLwvFNDvEWLgTPhZA8ReXw3/oQ
 NfcdTOd/nkguwLW8JD9VA0b2Mc52UrwV/K54emBkWCcLD9rWKi91quauGGihoKVQNGE87Jz2Ioj
 147Zw8b3kqEnGhPoBB0SjTZejDw5HFLuF3jgxKNoi3y6yYUoG7sqwfUy3G6A2v5vUYsya+t+hft
 3A4Xflq59DO+ZKk4OWPwkpoG9SyPjhJ1zT9bFF+ubV6eZdH9KlqHiJu3etKVLE/jnDE5KzsEuYq
 CJm1+w+br19LoCEly+k3jlqI9qHJaGcv3ziAcFQMJZ3c1xI/SQcpJb8j9Q/+8cYftE2o1VtgVdy
 TjiU1kd1mdQzPECy8dhtI=
X-Received: by 2002:a17:90b:2881:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-38ec64bba97mr6820371a91.12.1784881781647; 
 Fri, 24 Jul 2026 01:29:41 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03b0eabesm1143088a91.6.2026.07.24.01.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:29:41 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:29:16 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] doc: sophgo: licheerv_nano: fix incorrect step numbering
Message-ID: <amMiXChGxboNXBM3@lliang-1876.localdomain>
References: <20260430191306.64628-1-hfranco@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430191306.64628-1-hfranco@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784881782; x=1785486582;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n/9yqlxbr7nmGJCGcOJ+lNkYkURPj1TrxUqw2zDYZEQ=;
 b=mxAzD37V/9X0TPlCXSVf7fu/VjgH0pg4J3ZU42UsoqjI5s7WfZuI6INRfQeeA2GbeV
 UqDz/Teb+noJH0Lyr569A8/5YtIHDtpbSPZnBPcvQLgABj9IBTjFmy8zex6JimFAMhKn
 gipkQgXbRx7bkzJXehRa0RT2CSYNmBLdi7Yz6lg6E4l0nJ0CUvHvrhzJDNjoxX/WURoM
 vNZD+Ezmd7Lw16mBwvTPwhx/ozLDoqWxZr8uFNpxTgjyhzm/XKxnqTpTN+yGTN9XtRwn
 xiGOmjcjDfoeZYXSeZ7HhUD8qNecSDpJ40MLEBENK/bhYJinp12euSaX+I27Prtr2wrO
 LZew==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=mxAzD37V
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Apr 30, 2026 at 04:13:06PM -0300, Hiago De Franco wrote:
> Steps 2 and 3 are incorrectly numbered. Fix them.
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  doc/board/sophgo/licheerv_nano.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-riscv/main, thanks.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
