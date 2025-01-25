Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D54C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 16:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264AA807FE;
	Sat, 25 Jan 2025 17:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737823007;
	bh=502zxP4RuD2dt9x7RXDLbFVx3fN/QAXyGiRwlVrxP4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qBuWuLD1/ZbkEll1Y4jEyyvK5QkVf17TQ+zBoSH4ugQ0CYm6oPidwP3qh/Xb4ZHx+
	 /cYPgCodT4feOpWTw1tF3EibcusOLBU8l0uyn0Csh7vnXH88IbFMXZ7KN04S0fRjEb
	 4mwzA5TiXy2yYVIMHOAu5R5bSNE8uxVu+0Yec0J3Ri5L1h8RlRuc7caj58PNS8bf9b
	 jucgfY1iQwM/9bfyABbuhBjeKrqumaz+VQAgg7CMN0KQnyh2I3uS3NRGWMjcd85Bqk
	 YTMYENYEzvLrda2f0+e8+FtLGfpAgUHB4g4CTtIRyQHzUx28gHcah6YA1k+PxCNcX2
	 Xl4ebN3ze7h8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810FC80836; Sat, 25 Jan 2025 17:36:46 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CD88076E
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 17:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EZroXv/q"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 89DAF101ECB00; Sat, 25 Jan 2025 17:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737823002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=502zxP4RuD2dt9x7RXDLbFVx3fN/QAXyGiRwlVrxP4I=;
 b=EZroXv/qpTsY7McA9FAnR+4T7aRnCDGdpGcCto0/MvhM7YIqI/Hs2vlFVLS31gZjPC8J8p
 fflv9rjbMsjsNkXh7PRRoUqDJ89fb+ln79jkRkR//J2wAcRmkwHMmfr0p1dv9bS8np8rAU
 J+zZfKC9GXR48SvdP5NGRboLGzmNP4aWPp7sgrmyFwqehyUYjh8x4g8Z0RNxRACOJrhK3o
 8mgwhv6Qijy0g3q90Ruq6TDx1vsGHFIxKQZOzEWpFYDcWIkFhzSdeeyVSKNQ+7lBad/cpq
 OwwbzC2YQNl6w2VI2dsm7YGyDntdRc+Z6UCpQuAZVhBlBVWk9bWW+VEhqfqHkg==
Message-ID: <efaf3c1b-c3c7-44e2-9cee-c854cb67e74a@denx.de>
Date: Sat, 25 Jan 2025 17:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] pinctrl: imx: Push imx_pinctrl_ops into drivers and
 staticize
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>
References: <20250124145520.185414-1-marex@denx.de>
 <CAOMZO5DTbaq+ArihsEE68YbD8S-v9ny2+Nc8XbXZ-JWRRTUFTw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5DTbaq+ArihsEE68YbD8S-v9ny2+Nc8XbXZ-JWRRTUFTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/25/25 4:53 PM, Fabio Estevam wrote:
> Tom,
> 
> On Fri, Jan 24, 2025 at 11:55 AM Marek Vasut <marex@denx.de> wrote:
>>
>> Move imx_pinctrl_ops into drivers and staticize. This is preparatory
>> patch for follow up pinctrl drivers which will not use this variant
>> of imx_pinctrl_ops content. This should not change size, as most of
>> the deployments compiled in one pinctrl driver anyway. No functional
>> change.
> 
> The u-boot-imx/master-next fails with this series applied:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1005082
> 
> This is unrelated to this series, though.
> 
> Any ideas?

Does it always fail , i.e. did you try to rerun the pipeline ?

Did you try to rebase on current u-boot/master , does it still fail ?

The link I sent to Alice also has an associated build run, which does 
pass, but admittedly that has one extra patch on top, which should have 
no impact:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1005082
