Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE38CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDFA56061D;
	Sat, 10 Oct 2026 19:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pimSQw_oxMh; Sat, 10 Oct 2026 19:10:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17054606AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659410;
	b=o/njEOVe4R9oIwQWHHVko3cHf20ZdGnVtAUGbRNkWce5i8WJGJOR7bOYxEqmTj38TPgu
	 AOXt7BuGPf3KLOczi0pNHui9PZsawMAU0/RMHrjuDUjuGCXynonRYwN1ICcVIFDyEwbAx
	 orjgXG9Hb71fi4+tVpOrrXcwu0IHg1nViZkCoP7aUb4NTdnZmuR7Mk0SVgkrxnICglh3R
	 kcRFRrBSnjX9Q5wQym+OTe8SG8ML/sgay8d+IiY21uh1wG5h5cyMSo132S5BvZUc5xHhK
	 OHCapSmmpGupSDAOZVXqCL2kxpDD4+8XCuNdJW2XEq2siW6DwayBMKlEjXGKkfNox+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=asahtIKCZ2A5uzV6zinqC8Uo/bJvj2RF/iD4evG15+g=;
	b=hIlFmzBAfPNx+iIcZL29a038Rnbnjb2kcavZca8OTaTKl7d9Fj12vsIIG5TrHCMTw7t+
	 7uz26yU74D22rvlk0yxWOqTUOLWIzHuTiYflgosLWCt/frX1VDAQ08A+zxR95wVSTNVZE
	 QWBrGjmU0fk2NRNKva5FX8f0J1KLORraFPaNfWPtyR4RUo+0wWxh1yqkGf/ZTkHB5iKJY
	 tTwvQpEjn5nnwugyy1koPy5c8Bb7CAX25p+fZoMTtgb3FCwl69PDwYnK/OnPLKtT1GX1W
	 tkUcxqvOIa3th3hRqWvrf/ierM3cTdSq+N+EVcZPPcuyKYp0Fv6sYVmyXGRKuZ1S76Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659410;
	bh=asahtIKCZ2A5uzV6zinqC8Uo/bJvj2RF/iD4evG15+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7rZWc1FzZgNaGaK+iznhFg31LPJBNd8hL/0F0tg9pdGO2TOWDOqpwRdMjvb/YyBU
	 AbcgLAbJPWSpNyyWXYCZBP2dpbUBO38tJNuByHGF6q1FahmmxPdki8NcGqJJG1yJ0M
	 WUhNnwEI0N3FXKZXRz+3TQyJ8EN1wysDKpTzIUSQb1l4cEf9kGRrWj2cRByBfdpNPK
	 8cPznvGNEppI50C5hwTRgV+tdNY1qdqq77zN1rTPaXR2ZHe3BwqQLZiaKYveKcEhZO
	 UIN5o6k0f9G4VJx5Bb6cynZLfzIsoOH4kNwSq6bDISdR3/eFsSaZlmtf/B4Dmqn3Ah
	 p4W1rwKMdWWpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17054606AA;
	Sat, 10 Oct 2026 19:10:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B37356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 15:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 851554076E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 15:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZcbsY7CDUyve for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 15:39:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7427C40767
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791646769;
 b=PR70eF9xJrjZnJ58mh8peHBhvqsevRVIPq+ETjSTZ2rfsnftrdUZ1+KDfaR726cM9TnZ
 Xvdim4Z/oBApz34FEeP5BZ+VbDWh4wsQmAtpNyDShvPOxnx1WQow3NlpX02unafiKVRGZ
 9UzNcGo2WacWUHDCqGhT608lhetbSRRw1X5uYPqRMAjtoLM23F9FN3mdVgh0ZMyRWvrDh
 MhhUxU9LRwD1Yn+WWsePEbzJ5I7a+wGxby1lJUevy9Fm1DYWpHvOVrcnzLYuEZqbfE7fK
 pLnA4711TnJCR6gBfk2sdUvKAq+0SJZHkGkQdCqbMyDttAurc9KAK8cekFLdGngT4UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791646769;
 h=X-Greylist:Received-SPF:Message-ID:DKIM-Signature:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=asahtIKCZ2A5uzV6zinqC8Uo/bJvj2RF/iD4evG15+g=;
 b=rHn1imXxpQRfoz+/mQ+O2iO2XZrN+w2j1qCSPySu6+L+jwVQ9dFYuNRHsM7Wv7T+N7tt
 nJC2DJHrhdQ/F+PU4bsqEHjPuG5VLcdEY332UGA+9qRKPNO0iZCQJ/IEgX+BQ70XFZj6z
 kuzVnmhkmVdmBUBF8gumoNWvirlkbQXXgR9GXKaagFod3pBT6rwHTmOK0oucopDxb07Wi
 npqJkRPK8zZvgJC4g8C+6CiT/ad0my1rokNcug6q1d9nSDO0Q4vZQrmU8BBaOWNehYqjF
 oWAq37TBJJR3uJxIMLxrlzxUXswSGXjWBWItgUEvBdS5RcI6u95VLbNABfD+XamgoAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=cyberchaos.dev;
 dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256
 header.s=mail header.b=IfUyWZ1Q; 
 arc=none smtp.remote-ip=195.39.247.168
X-Greylist: delayed 393 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 10 Oct 2026 15:39:29 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=cyberchaos.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev
 header.a=rsa-sha256 header.s=mail header.b=IfUyWZ1Q
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.39.247.168;
 helo=mail.cyberchaos.dev; envelope-from=yureka@cyberchaos.dev;
 receiver=<UNKNOWN> 
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7427C40767
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 15:39:29 +0000 (UTC)
Message-ID: <d20b21b9-52d6-4eaf-99a2-ce140deeb9b4@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
 s=mail; t=1791646371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asahtIKCZ2A5uzV6zinqC8Uo/bJvj2RF/iD4evG15+g=;
 b=IfUyWZ1QCLDuQwPd/yOWQQtO/I1WU50GMXDYBUD/y2JGmUJDUTlN+oBI4pad53qJc7ngMF
 43tmcWMxHKAV8rz5j3HAD7VPkVj/JCaFTBnRyNRSbETGjM7YS73zaGSss/PSDgZgjGHbCv
 +BVoNnjnrOyNybVJCz+AY3YKDWKcH/U=
Date: Sat, 10 Oct 2026 17:32:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] doc: apple: Add Apple M3 as supported SoC
To: Janne Grunau <j@jannau.net>, u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev,
 Anshul Dalal <anshuld@ti.com>
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
 <20261010-apple-t603x-support-v1-1-ca529f301a62@jannau.net>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20261010-apple-t603x-support-v1-1-ca529f301a62@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:10:03 +0000
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

On 10/10/26 14:13, Janne Grunau wrote:
> Adding M3 (t8122) to the documentation was missed in commit a1a47eee6763
> ("arm: apple: Add Apple M3 (t8122) support").
> Since Apple silicon SoCs have switched to upstream DTS stop listing SoCs
> with device trees. The expectation is that u-boot support is added
> together with Linux support. So the device trees might lag a little
> behind. Since u-boot's dtbs are usually not used on Apple SoCs this is
> not an issue.
>
> Fixes: a1a47eee6763 ("arm: apple: Add Apple M3 (t8122) support")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   doc/board/apple/m1.rst | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 900c5e6d91ea..4ed275f7ea8c 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -9,6 +9,7 @@ the following SoCs work:
>   
>    - Apple M1 SoC (t8103)
>    - Apple M2 SoC (t8112)
> + - Apple M3 SoC (t8112)
Typo? This should be t8122.
>    - Apple M1 Pro SoC (t6000)
>    - Apple M1 Max SoC (t6001)
>    - Apple M1 Ultra SoC (t6002)
> @@ -24,8 +25,8 @@ On these SoCs the following hardware is supported:
>    - NVMe storage
>    - USB 3.1 Type-C ports
>   
> -Device trees are provided in dts/upstream/src/arm64/apple/ and available
> -for all M1 and M2 (t8103, t8112, t600x and t602x) devices.
> +Device trees are provided in dts/upstream/src/arm64/apple/ and available once
> +they are merged in the Linux kernel tree.
>   
>   Building U-Boot
>   ---------------
> @@ -82,5 +83,7 @@ supported SoCs.
>        - Base Address
>      * - M1 (t8103) and M2 (t8112)
>        - 0x235200000
> +   * - M3 (t8122)
> +     - 0x2a1200000
>      * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
>        - 0x39b200000
