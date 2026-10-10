Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F7CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 09:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69FF440875;
	Sat, 10 Oct 2026 09:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yykzwXKJwwtO; Sat, 10 Oct 2026 09:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E62B4082E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791623875;
	b=s0V1C1/H4wL1XvhHxuTfiPTOM+Eok3dk2xDdFZAn9bDWQox7QloqGbA2SheOp+w1YAI0
	 X3sV6fBQYtZ5Iq8M2IyI3qLA4U8yXDq/dNDalfRDeLedM6UKoqoZrB14rgvMqumy019nO
	 9LZSC5Yvy7wlRlvLuDj+fgDjTTXTKfIy8LFKesh6n/0mlHObeiorm/rUGMae86bfdUfKd
	 G5sFJnY0wnFgZvthd2WFnzmAaNxslYyOJQ/1rc2hvEdaRTRo9HehdYMwnOSUTDJbcYLQ4
	 DXDsufiGOspgi7LbjVzRdlo0EcW+UFzznsyvriCmNcI46ns6SOkOCyCvF/XZdre1W4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791623875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ezqsWbR2e+KQYBdKm6mhFXA9FJC/DGusPdbhQI3Yy1I=;
	b=T91/a4rAIn1ndf6j85k+ECQnQaC5zastD8anqh6F/rzSneOU4A8zO2otsq0xxGIkrbmm
	 zeVpSV2QbF0uph324dkhGP7h6bmrmrbZsd9VuKF1brfy/aOyWwRWP9ZRLF/6jGDiwfV6/
	 KxgCxASxCgblAWJJutQyiK4fhocXQtzbz7JDFlg0R87iRFMpkufDSaGzqjOR0WrFbvlQU
	 JmAmGdHMRPCPlBswep8+yNtipAEvpju52w9Lb5L0Tdgi7VWnQR/MEJv2LMx+Ycqm08/Lb
	 jGWszDlf/vJ/93qhl8C/ocgVICYAJAg9NslZTLC5TPbVwBxjImvx6OY5ii32EaNnQ1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791623875;
	bh=ezqsWbR2e+KQYBdKm6mhFXA9FJC/DGusPdbhQI3Yy1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XmbwPRdhNm/IiDDTthnfxVedFCDO6MhKYUUpyHM7TlmYAbxChGf74A02xLEiVUxKU
	 9zPOvXOIanBdc9EaYW6HBEH1W7OH3sxpOkvyxTtwadYwiZBWlfG9XnF5Hkj2V6pXki
	 5hkDTtlQ++oMxuzLGZgAX2hQxQxOaMhW0ZrtVkk+HzSDQbilEVmC3aY6mj4J0OsV4X
	 FJ0tARzAAkl7ApvetjqEokN6nEu8xz7rjBiLSmhNgxoKTeEwd3t4kTCtSfE1nqL4if
	 2yqctLx74JiZ1/4/851a8KVnItedJ+Z9d5MTaWLgVXjnt7LbeyrRgjiCOzJD4CkvBU
	 qSZiSvPBuPxfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E62B4082E;
	Sat, 10 Oct 2026 09:17:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78696356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 09:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75E84400AE
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 09:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gfUYsHYZcASg for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 09:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 208CC40004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791623873;
 b=ccRyT7JsaAeb6CK6na8nxEzfANKN8NEMVzVkmCrIks1D387j8wbLakVIDzm+oirnKNqp
 UBqiFfDiV7dIGcvlT7SbY1z05qJfeNkuHarF5DtDouNpDlX9ElQnwVAyk3dR0RGjLHNWV
 VKbojA/EAgj4m3oEwDMDGwbpGsODTe6pdQ06KEdmxA/RbibGoTc76e6/byAneGdfic8Yz
 DXVYATNXIKTgNR1pRWUpnVnYKT0yd9967vPqAEIMO+Drq7bPCBt2I9MrLSOJhFDaxs77s
 mmapk3vEaCYxuLInX7+SqMzA9HU/sxTwSw7GewOqZ7vx5Hf6UbyhOTRDoz/26YJpbHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791623873;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=ezqsWbR2e+KQYBdKm6mhFXA9FJC/DGusPdbhQI3Yy1I=;
 b=UhvpSczY+G2CqBVDkYIJpB9j4HQJCvuwdUoTgs38T5HdkRn3OKM+ibselzD7wbBZrHlU
 4BstTPu05GgIrdYUL4NHAg1xtzYx/VDtSSKuwyuSgVwVgcOWaEjoRnonJYWY7IO1S+st1
 wDGofXSszrbIRY3MoXmrBsDmucFcaR0h0uInICild2Sid+12OUgB+R1DoAMQdJeywYd0o
 1w6cfWfWonnOxxPlZIPJOQ1gfekykrAKEkoVO1OKH90/xb7PN01lhzRq4M06y/bU3Z9+l
 /i0XGxIKjoJDNzMxLqhAG12xytbQnBxf+NuEaVxR+L3o6lL207QH24NpYPXoaMSWiTQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="D/eTYcgg"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=D/eTYcgg
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 208CC40004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 09:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791623831;
 bh=ezqsWbR2e+KQYBdKm6mhFXA9FJC/DGusPdbhQI3Yy1I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D/eTYcggxhiEi1yZTULLlppSrha5YX+1MaCijyWOdIeBBvnCnle+xMLu3Ak1vBdv9
 AUNaaTAk1ZCsMlGAJpOdIJ/MlTpjbAdrRgMRO3Yx5J8kKWqbDsRTm7IAGbCGex3UZE
 55tXjHuMm9D2Eiucjg1fAXfsaYq2NOxRxNMjPfMl0Q3zaEKG6iBJc6+MOjqFLQWKbU
 JMFxVKKv2iQQ2uf3iQmHL1t6PnPJoJ6p1vEB7TLSAaAdDQn78SDrr2Fk+OXMU5PjV3
 Pr2zfclD6ZQHJhK95ZkAR7nQ027bySpTspnuiUYCEKQ9aQoWjGswJRamLbohWVWWFu
 6b3baH5f9Omhg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 89F0EB220F80;
 Sat, 10 Oct 2026 11:17:06 +0200 (CEST)
Message-ID: <1b3febf5-71f4-4306-b0c9-db65794f5041@freeshell.de>
Date: Sat, 10 Oct 2026 02:16:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Add fastboot to SPL
To: Carlo Caione <ccaione@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
 <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
 <xhkdb5wzws8dh.fsf@mkorpers-koolstof.csb>
 <asnsgPaKy_Ri3H4E@macbook.tail959722.ts.net>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <asnsgPaKy_Ri3H4E@macbook.tail959722.ts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/10/26 00:44, Carlo Caione wrote:
> On Wed, Sep 23, 2026 at 10:02:34 +0100, Mattijs Korpershoek wrote:
>> I've just applied the series. This means that they will go through CI.
>>
>> If everything goes well, it will be send to Tom for inclusion in next
>> when I send my next PR.
>>
>> If there are some issues with CI, I'll let you know.
>>
>> Thanks again for contributing to U-Boot
> 
> Hi Mattijs,
> 
> Did CI uncover any issues with this series? With the v2027.01 merge
> window closing soon-ish, I wanted to check whether you plan to include
> it in an upcoming pull request.
> 
> The MediaTek DA series depends on it so I'm trying to plan in advance :)
> 
> Thanks!
> 
> --
> Carlo Caione

Adding my opinion that I'm also positive on this series for the v2027.01
merge window.

All of the starfive_visionfive2 variant boards have some form of
SoC-connected USB and BootROM UART loader, but not always networking or
any physical access to eMMC for flashing. Without this series, then by
the moment of opportunity when we would have U-Boot main loaded and
could use fastboot then it's already several minutes' time of UART
transfer (of u-boot.itb) elapsed to get there. A proprietary vendor tool
exists which is an SPL loaded over UART and serves this same
functionality. I'm excited for the prospect of replacing any proprietary
vendor tools with mainline U-Boot :-)

-E
