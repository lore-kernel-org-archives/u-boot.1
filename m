Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEF606A68C
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A3h0vnRe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=E7akBXGI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=tZgg9qBY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E327C808A2;
	Sun, 22 Nov 2026 16:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9MJ0ISFK_3-2; Sun, 22 Nov 2026 16:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E505880874
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795366101;
	b=OvgswUoLhj8hwQAOgH2/KHbK3IVHRme4yAyOFg94jsouaf978pUO8t3awNouR/l//+Tv
	 1K4IEKi23edOjftZJykQMZLJQGpvCWCy1vtaZevNjBS/cNQHrnSKn6t4Hz5//AYt+qEOs
	 SftoPuhFBoxEfkOeuw2ZrSciJ71+D7b25l77OdVJPqNdUCUeWkTqSBoj3afMALpMklyXa
	 19hAjRKJ1ydu6eXbRNhFjtCXX33+6kCHtDHNOeOUgaT3UujLJhzM/D/PcI/U+4i/nK91G
	 hUza74N+evPzjzk/vwz6QfBb4HlzxuarlOPu5TAFJIux2Yfw+Yqvk50YvUH7VUCBx1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795366101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ubRQ5ThQI9AqLcht1bDr27Rwvh04OPp1TnnabeZOklc=;
	b=X/zLighwBkhYSrZgXtD61kztzPS8U84TwEMcpnNRHQSZOyUbroFADTDTWbGcKS3dsflG
	 6k48YIwni9KwPtoZs182sFMpxfGbQVb4MClayYT5DWI9ifYa8qfZXzCtLMb+sm1h3Wd2l
	 /xyEK2Y7lHY8fC/R3VuLqiL2gdeGeJZB66G7SZ3ilLJmBNiUyGH8O5Lh2jqe8QT51CtZp
	 ye9Ez1bSFc9100Opi/AnG/c1GtizwJEm/OZXddg48WNDEKgZQs+9dZaYgkL8oOVKzoC50
	 Qe5J+JruEqqng3qwmrUnwDB+KVYIiPyoPrm7UUh9maqJgYLXhHbn/Is4WDaFSEAlC6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=E7akBXGI;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=tZgg9qBY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795366101;
	bh=ubRQ5ThQI9AqLcht1bDr27Rwvh04OPp1TnnabeZOklc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A3h0vnReP2zZXRiOSjmv1rPZXDg7jvdqypiiAxlUy+599oKJS/CzRzC8qDeAcza3+
	 GjJeHHcxtrMwnGWEJztm7Jv3eYwD9knmdvG0GLKH3XPL06/U4sAbCz1JFywiFlla1F
	 y6QrEMGKIC5MTotMVPX8/H/P0zNEoS/G0Pj6gCwx5rBm7in+Eo9+oKmbqE782jh1GP
	 anZIZVu7K9lfINhXKbo1bDT3x/n4Ohim3Wpy7OhOlZvFVsmMjQa+vi0MjOikq3snYU
	 yGrTsI8xrISEIDN18o+B1A5RIjGGoZVDZOdgbLLJhNb0TYTobhhFP3HcqvIJOXM9p7
	 Y0RdqGFc7+VVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E505880874;
	Sun, 22 Nov 2026 16:48:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D8EB465
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4006E80874
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HEZDfgQx0Wp5 for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 16:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CAC480863
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.5;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=E7akBXGI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=tZgg9qBY
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CAC480863
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=ubRQ5ThQI9AqLcht1bDr27Rwvh04OPp1TnnabeZOklc=; b=E7akBXGIT2HOnZFocoIcUHeHWX
 dlThvc3MT1HuuKBppiQs7u0A/ukIUH3rukMuPeIwQz7f/zu/xPMEcOHn2gsag0Fvn+PxN/MYUjrEH
 JR7rhHX2u/7ebNQ3eeu7ukhSGZ6ObS5rt5+oOJ0G0or8CgTqnGS/I2ERuaQTOxD4hyWw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVAje-000000058hK-0GRc
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 16:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=ubRQ5ThQI9AqLcht1bDr27Rwvh04OPp1TnnabeZOklc=; b=tZgg9qBYcUcaQY1NUekc2JMnwu
 XeFjm0qg8IZzGg1gdEzjqiJRm4AwLuu/Z5HHy+p4ZyEBLoiWB2V41pzuDXQvTQhgTsqsgY4nsWeBA
 I2mJuCM/jcuVElfekJnR2KPAQaHchYujpy63Ngg4nmeTnO/fnhNGCRiekcZ8coS8Vb6s=;
Received: from [95.251.96.187] (port=63610 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVAjZ-000000003RU-1ulz; Sun, 22 Nov 2026 16:48:09 +0000
Date: Sun, 22 Nov 2026 17:48:07 +0100
From: Francesco Valla <francesco@valla.it>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 u-boot@lists.u-boot-project.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 regulators as bootph-all
Message-ID: <awMb3edX_gZRcjB1@bywater>
References: <20261121-beagley-regulators-fix-v1-1-467ace9d717f@valla.it>
 <awL1l3x5U0GRhY-K@bywater> <20261122140953.GK3176972@bill-the-cat>
 <5f8693a4-aba1-42d9-b814-ffa0f5529087@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8693a4-aba1-42d9-b814-ffa0f5529087@ti.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 802716b8595db6942a317f280146f9f3
X-AntiAbuse: ID - 802716b8595db6942a317f280146f9f3
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVAje-000000058hK-0GRc-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Udit,

On Sun, Nov 22, 2026 at 09:51:20PM +0530, Kumar, Udit wrote:
> Hi Francesco,
> 
> On 11/22/2026 7:39 PM, Tom Rini wrote:
> > On Sun, Nov 22, 2026 at 03:03:33PM +0100, Francesco Valla wrote:
> >> Hello,
> >>
> >> On Sat, Nov 21, 2026 at 10:35:13PM +0100, Francesco Valla wrote:
> >>> Commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
> >>> missing") changed the behavior of TPS65219 PMIC driver, which now fails
> >>> to probe if the regulators sub-node is missing. This leads to a hang if
> >>> a device marks as bootph-all the PMIC node but not the sub-nodes.
> >>>
> >>> On the BeagleY-AI, this results in no further messages after TF-A in
> >>> normal conditions or, if early debug is enabled, an explicit failure:
> >>>
> >>>   spl_early_init() failed: -6
> >>>
> >>>   resetting ...
> >>>   no sysreset
> >>>   ### ERROR ### Please RESET the board ###
> >>>
> >>> With the bootph-all property added to all regulators, the boot completes
> >>> successfully.
> >>>
> >>
> >> While preparing the corrsponding patch for linux-devicetree I stumbled
> >> upon the same done for the Beagleplay, and in particular the reply at
> >> [1]. Should we instead drop the bootph-all tag from the PMIC driver?
> >>
> >>> Signed-off-by: Francesco Valla <francesco@valla.it>
> >>> ---
> >>> I'll send the corresponding fix to the kernel as soon as possible, so
> >>> tit can be picked up at next DTS sync.
> >>> ---
> >>>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 24 ++++++++++++++++++++++++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> >>> index 0e810e7f492d..72f9284471e4 100644
> >>> --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> >>> +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
> 
> 
> PMIC is fixed function, for normal boot purpose, you can update board's
> config in u-boot to skip this.
> 

I think I'll follow this route. Less is better.

I'll send a different, updated patch set when ready. This can be
dropped.

> If you really want pmic, please check which nodes you need instead of
> enabling all, ref [0].
> And of course these changes shall come from linux DT sync.
> 
> [0]
> https://elixir.bootlin.com/linux/v7.3.1/source/arch/arm64/boot/dts/ti/k3-j722s-evm.dts#L511
> 
> 

Thank you!

Regards,
Francesco

