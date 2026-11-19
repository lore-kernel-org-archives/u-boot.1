Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB36606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V2pR3P+d;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=lTjGeFmT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D7E4605A7;
	Thu, 19 Nov 2026 10:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YBWcp4osnhT; Thu, 19 Nov 2026 10:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E48ED60ADF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795085024;
	b=EhzFlleYx5wd7ieWHVRzNq75+7Uu3/MFEgBpgR+BHoFJ4KPvAVqFYtQnRZ2j6GZmRms5
	 5iBrUziNSEINqB18L2lt+Wojo+xNyCBciz7K19ArHwuMoXFFkB663i2qkcFXPf/kql5gR
	 QE51iHwcXN9S6t9SeoOJtT3t2xMsgDJoOS/2oyc+oFfTmNMAT7fA0044Pvy3x68ZB8R4z
	 u0ZEELCwjki/TMlv6hpXZwh7vvWCCqNPWGVlPAebHyzn6NkWAY0oh/AY+ILpPFEGtiVxg
	 AksQ+Pbx97YXnrnuYnz7d8fWuHi6bv14lz9FGzXXrRPsX/RHqDJNsV3bVaqKOsObucg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795085024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uvYZEK2isrHzeJAsAPeQUiGmZxOBtdvliW4gEn4WeEE=;
	b=M8bP9tz+NOrUO7leyRf6EmW+N53vToiRM695VMkPI8GdxLZ9eJPWePr0ho0CX7Gqm+i+
	 BgZCnHwnW2kTImypEkOEvqAOpKUoToOwm/5BdLhcksk5E8p2POnduY8bGZidTKlbraJBA
	 oE8j+/gJLlGObsn34nQvAWonyjLtn8B/s4YFD9Oy1BJ2mdtFL8FdnC/T/9cuV0Kg/0ahy
	 6ZJaboB3zf3SonzElR+eI+Kuj52PXkfXlYIVQZrxyPEmuP1v9a4Qu6xJmZIcoLJlhv2yT
	 KOJfDWL/XgjLht29kj8SypoCbL4Ywxqf0xNuHqKdgHKNpl0h9/GgR1DuLmoz33i5tgw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795085024;
	bh=uvYZEK2isrHzeJAsAPeQUiGmZxOBtdvliW4gEn4WeEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V2pR3P+dIzGPj3IJ5n4V+HR09YpusMZ6YDzfdu7tKX7SDx3HPTAfWBWnjfIXKikUY
	 /dlVZVxILlh5OUfll+pDa2Mw4byb5jwAfq3jopxIt84epqQBMXYRHIEEni17MpO9PF
	 Cx1eFo2dZNd70sIr57+dU9JlsrjGvMWJythxLqyAUyQS2QnHcfEiTE/frMpxHVrUa/
	 StJ3osfrsyZ7YLaOZSShzhktLTZHH/qQfbybaY2pFCtXs99bjNrL2oh4SQ5NDtcZXh
	 wM+gsvlJ7KaH7izsj0JeBK0+cvMmCDTYsUbThrtgk6KBH0sGjWUNH7ZzTBumZCXM4D
	 h91I8A5lxG8+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E48ED60ADF;
	Thu, 19 Nov 2026 10:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C9181E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5271D40A48
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PZWQURMcQrR for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 10:43:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D5FF40A47
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lTjGeFmT
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D5FF40A47
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795084996;
 bh=uvYZEK2isrHzeJAsAPeQUiGmZxOBtdvliW4gEn4WeEE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lTjGeFmTJJw0Uqbt++7wiGgr9IN4vTuJhFfw6DmjQEGSVLwtkVwgHTWpw2Kx2k3TA
 XgcdDaBOpQLfYRLM5e81ijYZlmJ2zln+CrIp8oUfesYrzR0Fs1SvsOK10MV8Eb29vl
 xux0yJg2X6Tu0DmiRRVjtN5blWmj2551PETWtjTdMHGj2CRS9LgD+EjTZJXVd137az
 jgtAjPqZ8WfwdNh1G8b0mjavcLSaoK1+s+dLEJuBD9GM+Q+4WSb1C60lFAqd15y/XR
 WL8/VVZJRcsHVBvaV/dKG3aG4hIoAutYrtrB239HW0ftqztDM7P0XFCWWdqpjABV3x
 eEXWqDJcqXfLw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A2FE4B2201BC;
 Thu, 19 Nov 2026 11:43:14 +0100 (CET)
Message-ID: <3a1eb830-1a49-4c24-b8c6-b63abbeb722f@freeshell.de>
Date: Thu, 19 Nov 2026 02:43:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] riscv: Describe SBI_V02 in terms of the SBI version
To: Zhouqi Jiang <luojia@rustsbi.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>, Daniel Maslowski <info@orangecms.org>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
 <C333C8B0E169374B+20261119091842.3062208-2-luojia@rustsbi.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <C333C8B0E169374B+20261119091842.3062208-2-luojia@rustsbi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zhougi,

On 11/19/26 01:18, Zhouqi Jiang wrote:
> Describe SBI_V02 by the SBI version it requires so the help applies
> to any SBI firmware implementing v0.2 or later.
> 
> Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
> ---
> Changes in v2:
> - Split the SBI_V02 help update into a standalone patch.
> 
>  arch/riscv/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 386241efd4a..0edf0247983 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -476,8 +476,7 @@ config SBI_V02
>  	  single hart needs to boot and enter the operating system. The booting
>  	  hart can bring up secondary harts one by one afterwards.
>  
> -	  Choose this option if OpenSBI release v0.7 or above is used together
> -	  with U-Boot.
> +	  Choose this option if the SBI firmware implements SBI v0.2 or later.

SBI is not necessarily firmware in that sense.

"Choose this option if a RISC-V Supervisor Binary Interface
Specification v0.2-or-later conformant implementation is used together
with U-Boot. For example, OpenSBI release v0.7 or above."

Most users do not know or care about the specification. However if you
want this to be applicable to all OpenSBI compatible implementations at
this specific level of compatibility then we should mention it in terms
of OpenSBI or else it becomes very confusing to see OPENSBI= in
documentation.

[..]

-E
