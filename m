Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC95CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 125A0605EA;
	Mon, 19 Oct 2026 10:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7g8HFdOE3Ly; Mon, 19 Oct 2026 10:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 58D0F605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792404968;
	b=W3GoAsqXYeKlJQj/APFbZFQydhNj8WpIG3iWpDVBAisyW5mexdySin8lQXyKSPxhIcL4
	 /Cq0a9eNkQWbjspBIZVZClOFGZLZI63ZyJBLK+19nW8GrLXW2jxQlCJUZOxFx5ApVfmwJ
	 JloyT3F7NSQoK8Df/RYNBqnzvgr2sFkJ1VdoYqHKz1TqRIlEQ9yt2x7jdtiJlQ4D3CQhJ
	 P3n5gi4Mc3TfvFZ70U6t7lVmUYHnJ8MX6rHC9LrbezYxxlwqSIakyqRhakkpJNHUGQJkd
	 bddNWJK5SEi7lt39VJVgP2KIlLs3AYA/mPbB5n7T3Oln194FaSuU+r2uhwsS0psj+zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792404968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8M/9VOV4M58wdb34Ao6d8bMluDly1tjynfPCwZqYCII=;
	b=FkJATr1AFXgTvvUoBuT73oUbpEbbmHb+JrfeGfeRix1P9GPytgjROHaDIjZBz/7cDXOF
	 nGVj2eucyfGEw8X485hm3d9Ov8DNh07iH9XZD/V+bszea3n8W/4Iq6tnEFf5jWuviEprl
	 613WGFUfAK6gATd8Jth4wnDNY/NqN3i5xwynKBygEA9LLFS4TdQmEoF6juVoUV6/BJY18
	 7zUZg4WFiSukCuf+yK1RVtUj7MOmL3lEcKiRCSaP6P0yn877KE8E1/RiTErwdQIR+LN1H
	 J35skMjL53iS7E8s+sc9ch4tHJsQ053ID21KzXGaTgVuAjPgOHMHuzpEvSwCqD4zHFw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792404968;
	bh=8M/9VOV4M58wdb34Ao6d8bMluDly1tjynfPCwZqYCII=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZPdkBZ1Cd5Q6WfGuucOMuS7eKhL3jQ/yDZ2EhsR70pvdXsZrXMGfx5NaouEp/SM9v
	 PFxqLqQBBqTWzPGfuQzliFx1DFwCqxcSOZVhFdIMzoRUHXSd4gED7Wp8bqgE6BcABF
	 JRW3IM1AYbuVcX1t8Dmm4PWpn3/VtRdGpPIQtgEtZAIRLiGWgrdSMuCEkiCNuITCWb
	 JCDEJ+ZZQ2bpRCeifNYHWSsKpBQuX+mgW3VStpHpF6injhZFHiOQ+Vunq5J3pxHmjw
	 lwsoNLsFqqIdYu9zVatqhdTXexynVDVWQa+jgrFtLGmPmWsjakZFWM5cjEHlVxMSDF
	 +bY/IQBU8xe6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58D0F605FC;
	Mon, 19 Oct 2026 10:16:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DE721E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F60480F36
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id in69xc7liIbJ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5710580F37
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792404965;
 b=CcLphSWovCIjkz5o+id62nvmh+KDOPt4P4A8HKSOl/CbIavszyRJb2+G6mEF6J47wRVM
 DvvSFJWdHSK4ZondhP8n8t2eFWBNCFBhLFFhZujwSCHHs3Saaru5+ACpQgzayFUY7LC03
 vqNSUHB4sq09zrijJ9SWT57lZDCa7QH9p2DzGkDxGI119/5zjdTsUsOQc82BdLeDa4Qw0
 fxn4LqRiHpjFerz+SmNW9+uB2aoEbqDOVKmiMkKo2mhyjMOEZEJH5wOd3cW0U8YyPFB+s
 CcjDARK9eIG5OEMI79ujVTegkBRvG2njUYBkBpntMY9uYH3yFucIGKWJaNie15i9FuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792404965;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=8M/9VOV4M58wdb34Ao6d8bMluDly1tjynfPCwZqYCII=;
 b=QD0yBPwl+4xFCnB5oJrtMLSCRtF79rDLSbYyNjlcYJBHBF2x4lV4GzZk4RjNqZ/pQjIj
 iJqJv4f0xv9c4V539u3d5XKsDdJGLTY6+vlO7idtqUTE6kwkp1oN79uSXLTltQz14+XE/
 n7UzqL3BFcpIZ4TEqKJ216dqTuvZ9oKTflzne2GH0c2i9IZB5zgCUT7pRXUf2zdhycdMv
 3ADHnctC2yRhIaujllCnhKvPI1KoxaAWr9pAjJcQQsLI6J+ofqsDR2TRyHnPL2WbEJQXa
 tke8xEcwJ0fWd6ap8i0jT6dth4WTBg2pRuIVrEzFi5o1ByS4AunQkMhUpWNNKz5Th7Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=xs4all.nl;
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=QvK9Yq7E; 
 arc=none smtp.remote-ip=195.121.94.167
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.167;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=QvK9Yq7E
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5710580F37
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:16:03 +0000 (UTC)
X-KPN-MessageId: 140775cf-cba6-11f1-b2ab-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 140775cf-cba6-11f1-b2ab-005056abbe64;
 Mon, 19 Oct 2026 12:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=8M/9VOV4M58wdb34Ao6d8bMluDly1tjynfPCwZqYCII=;
 b=QvK9Yq7Er/I0bms3nCOVMQzoiviD8DGXH3aoX+oopVO0X7Znxkhd2EQVymW6ugCKPXiRlOsd1IKJ4
 ypu4B5AOV6+uVKOkrAb0ikYI35N2UmQEWKMWg8LK3cvQ59zw+ZvgbZr0mpHe9459GrHJs2Fwoyb8SL
 sWmmTQ7bQgAYHLTtea9AXWgxuhPCw3UozClQ9ZoxvaHjltmV+wKpsCJm1mjzCRRVYpKJRfXnV5VVjc
 7wQN7SpqQd7A45fzxmA0LVbK1lUqEGLfih/GgyVkodcn3/xRyoT6HtICOpDXqph2wfarJO66qCd68Q
 wczQw93glSBkvEMnfKuy9WDneEN9g0g==
X-KPN-MID: 33|FdOQJQjz63tiboHACDrCStziBLNpp7Li3tUAOP3elpwoQK93HUcF0q9ge3WQxQt
 nkQaQX++VQNOTTeCBwLWhw8P+NlIqsK+ksQgTH4XNemU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XNp40WKAGiYwcAK6un/VSX/pxGBIxxnZ5Id2swDdu6nz/uwsP6zqhcpd6AGMlOV
 LoRMMoeu+6bNp9bTpIfC5yg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 13915d12-cba6-11f1-92b4-005056ab1411;
 Mon, 19 Oct 2026 12:15:58 +0200 (CEST)
Date: Mon, 19 Oct 2026 12:15:57 +0200
Message-Id: <878q3uyp0i.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, kettenis@openbsd.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, asahi@lists.linux.dev, anshuld@ti.com, j@jannau.net
In-Reply-To: <20261010-apple-t603x-support-v1-1-ca529f301a62@jannau.net>
 (message from Janne Grunau on Sat, 10 Oct 2026 14:13:57 +0200)
Subject: Re: [PATCH 1/3] doc: apple: Add Apple M3 as supported SoC
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
 <20261010-apple-t603x-support-v1-1-ca529f301a62@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Sat, 10 Oct 2026 14:13:57 +0200
> 
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
>  doc/board/apple/m1.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 900c5e6d91ea..4ed275f7ea8c 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -9,6 +9,7 @@ the following SoCs work:
>  
>   - Apple M1 SoC (t8103)
>   - Apple M2 SoC (t8112)
> + - Apple M3 SoC (t8112)

That should be t8122!

>   - Apple M1 Pro SoC (t6000)
>   - Apple M1 Max SoC (t6001)
>   - Apple M1 Ultra SoC (t6002)
> @@ -24,8 +25,8 @@ On these SoCs the following hardware is supported:
>   - NVMe storage
>   - USB 3.1 Type-C ports
>  
> -Device trees are provided in dts/upstream/src/arm64/apple/ and available
> -for all M1 and M2 (t8103, t8112, t600x and t602x) devices.
> +Device trees are provided in dts/upstream/src/arm64/apple/ and available once
> +they are merged in the Linux kernel tree.
>  
>  Building U-Boot
>  ---------------
> @@ -82,5 +83,7 @@ supported SoCs.
>       - Base Address
>     * - M1 (t8103) and M2 (t8112)
>       - 0x235200000
> +   * - M3 (t8122)
> +     - 0x2a1200000
>     * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
>       - 0x39b200000
> 
> -- 
> 2.55.0
> 
> 
