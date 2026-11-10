Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9BA606A321
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V0oxVIf4;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=exgvFD1h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B26B280DEB;
	Tue, 10 Nov 2026 06:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oWSIb1g6jdVd; Tue, 10 Nov 2026 06:17:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1473E80DF8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794291452;
	b=KBT8P0ESDLw2Pp2X9pa8MEHt4kZFIxRsoy4BHHzERgofM5y/djQyG21CLOquLVWfq/Ng
	 Xl24Ep3jM5Wxv0o+VW2F/4vZFmVbfRmWViJZLUX0E9+yohr4Hs1wc7bCmyNGqQKP7ebGl
	 cm4IeN1Hzb6tdryXYSOv3pDU/7enwbvcxMaJ0NAoRNMtRXzNVQMi/XkS/SAho7ONOkml0
	 5RPMmzvJzIjEyfbhOCns1AMJWtKBlHxp5nJs/ym+R57qnKov1+WTws3FLA2UcTbhfIm1O
	 WKT9S6HWLp16uQUVe01blAqC44gui81lr4pf9aBVZu3C0SBjiOopEAHu2Aj85xO6eYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794291452;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jz/IKRaUzZVGU9um6Wn5dNOKwC6+tmwP/YLTihEwnJc=;
	b=nGRVB9F7CieBhJPt5DlBFjwvAROWazJFcaHZDeNOVleKeMFSfAuy+OhOhK6qa8v4x7ZE
	 nrejpOaVfEggjue8ZrqU6d4trgKYsPPLooOfx8GB41WR5KtNkxV7MrRNvk/U+Zlbphtsu
	 VmK4QaktUrh+42MB1fl98i4wop2zEwc7G6ZJpURLLGQbICaEARor+RskVWCo/PvaDTs7H
	 MXRj305uunpuIa4zWM7KU+DOcWPgkPy/YHRc9sK7bayUlj8ve8dp0oWxuOt78pijqnsry
	 Tshwyi+uKB3Gidl1F/E/BAFak5uhg83Fvi2UVEPOdD2zUl71v/dJBQ0INfuuB9xFTPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=exgvFD1h;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794291452;
	bh=Jz/IKRaUzZVGU9um6Wn5dNOKwC6+tmwP/YLTihEwnJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V0oxVIf41kYCOf2CRShLqlUtjY0+cUtsPbTIcXdBJwv63G5B165+yMkkaeyEEWEV0
	 wI04qW+HXY3TIenjIwlW8pfe2aNlB8e/NDja3CEeaTVR54gdyqYlgcuJN7eYpiZW9n
	 vxzX6KZTN3Kb0kZivxATziUX43HB/TI1mGgDxeInRhjmm+vtwueSFGIZgdjPU0Lsbp
	 jdOtxuAE3wJWGh1/whxulMYLhcHkPuZ1S8mVkE44koTM90XKjVAg1e5R0Y7CWKa+vb
	 WQjG5eSGe0U7r9PlH4DpWvJX/y7wraZyqJaihbaDKy+F4RjxqsVoS+ys+hKxMvPwO3
	 JUez5R0YwZnUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1473E80DF8;
	Tue, 10 Nov 2026 06:17:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DCBDAF2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72D3D80DEB
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZJ5_UlJ4ppg for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 748B180DE9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=exgvFD1h
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 748B180DE9
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:17:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6E8F510DA6E; Tue, 10 Nov 2026 07:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794291446;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Jz/IKRaUzZVGU9um6Wn5dNOKwC6+tmwP/YLTihEwnJc=;
 b=exgvFD1hjjILGT4RP7wimjQVXWY6PCRlErf0p6uvnBEVI6Oe3FqEdglCXZJwc1A++oH/af
 ob+ZovPc03C1NqCxhUrqCn6HcRSEKhbxX0Wwk0qOiXvcq/YaCZeK7G6U/601sTCQ5xhcUi
 8x8jh8f1/kFkygd1L/eOXqRZmemjt6abTuQPo2wpi6NBASc8onb/9vIWefHt52Eq8zINrz
 7PlUSs33c+H/yr82HNSrwBUG8tL7OpEMk89TucKgc5agv//U0L+VAwPqRknnKdo2YAFSZC
 lgE0mm00tpHebzeMH1lx0RIbUVp1ApPzyDvWRfrQ4MWSygtJZfEaEn4lU4Ky+w==
Message-ID: <43501e58-7e4d-49f6-ac18-d4ef882f9efc@nabladev.com>
Date: Tue, 10 Nov 2026 06:27:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx: Switch Data Modul i.MX8M eDM SBC to
 OF_UPSTREAM
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260902163748.1003274-1-marex@nabladev.com>
 <a6365f6f-b87c-4d6a-8be3-c315931bf36b@nabladev.com>
 <CAOMZO5B=PRD-miBT8HASshW5FaStdVGXDx9Vxbnw19z9Afwzjg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAOMZO5B=PRD-miBT8HASshW5FaStdVGXDx9Vxbnw19z9Afwzjg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 3:09 AM, Fabio Estevam wrote:

Hello Fabio,

> On Mon, Nov 9, 2026 at 10:42 PM Marek Vasut <marex@nabladev.com> wrote:
> 
>> Hello Fabio,
>>
>> have you had a chance to pick this patch ?
> 
> For some reason, I didn't find it in Patchwork, but I have just
> downloaded it from the list, and it applies cleanly.
> 
> It will be part of my next pull request to Tom.
> 
> Sorry about that.

No worries. Thank you !
