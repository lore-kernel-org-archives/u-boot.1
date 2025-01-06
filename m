Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FA5E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 20:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0968E805E1;
	Mon,  6 Jan 2025 21:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736196690;
	bh=b8Zc6hwibEB9a8gf+/U3+ShlVXI0MQTTsPrejiy6F2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sr88O9cH4J/QNURrq5yI+/I6qz9ZpxkrZIWP5Lk83ueqXSpNizmPlzqWsQSj92K4L
	 Tdn3J2wXKneGaWMfqEywbsNhSADMomKQE/dLzMsgYxiP4crwpGft6YzXsS2XeU1CfQ
	 Fg2Vy9gOuKN6EJZWbThSOuyMXcU0vnnJDbGb7llsGggMyi/gSsI3M8ij87kN4uncLM
	 WHFU5ZpZjzAO8w+tDZc6A3/QqYOGylMAhywopR2UKGYhaFky3tp/RQdMIYlJ9hN7sh
	 0KG3EBRfdjBIKD7N1Q5srTvszPvZ6PUfYV8A4005MuST1izneObMERu1i5/FIbEWTB
	 jGoGcU+ZGvYCA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D2C8036B; Mon,  6 Jan 2025 21:51:28 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C09805E1
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 21:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Uaz5VcP6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F023210A4C6C4; Mon,  6 Jan 2025 21:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736196685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8Zc6hwibEB9a8gf+/U3+ShlVXI0MQTTsPrejiy6F2g=;
 b=Uaz5VcP6chf9b9QGbWtdw0xLz3fRmoBaL5OLk5t+eVB5Jf9Hw8SuvgM/Db5BdkabVuje91
 xmfm2wkj2ZbhIieUryZDstKO8QrWnlB8iorEBsfld0eh2gOQhHnM97zBMQ+bbIGaN1Y5wy
 PB2lguTu8d+JS4UlZ7r6qjJQWOwgNHI9rJeVnyC1wPsz61eanUSfDT+qnOYXHiIaV6LfoX
 lCJk/LlzCSpuTKmhvv7c2kPEeKV0a0Nf+s+Bs9q5FAijqHTd5+daigcrJN9GM6l+GxoxsQ
 +f1A4R34VNHzQX7YNLw/eltKl/AzDIKtBfAIvHnZisUy5B1CoDDvtP0ezO9COA==
Message-ID: <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
Date: Mon, 6 Jan 2025 21:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/6/25 3:38 PM, Simon Glass wrote:

[...]

> I wonder if the cst needs to be updated (binman tool -f cst)? At
> present it is using apt-get and has:
> 
> $ dpkg -l imx-code-signing-tool
> Desired=Unknown/Install/Remove/Purge/Hold
> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> ||/ Name                  Version             Architecture Description
> +++-=====================-===================-============-===================================
> ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
> signing tool for i.MX platform
Perhaps. Can you suggest a fix ?

I am also unsure how to get the CST test to 100%.

I still don't fully understand what exactly are these tests testing or 
whether they are even valid.
