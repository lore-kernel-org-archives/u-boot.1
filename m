Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA81C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 353A740927;
	Tue, 21 Jul 2026 14:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ft0X3MU80VRV; Tue, 21 Jul 2026 14:50:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F3354091B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784645437;
	bh=SuMcErdjQhlfwDhtmh49AheXHAIbdOo4YAZysnP/D4Y=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CXOtFxSHRbuCCKpKfF6yoRkKT/RULF03g6c/1PgdovDOR7gpEefK6J5SmtlFDCHm7
	 kbE9EA2FYPzf811WAslPz5o4lqvuVhQdL+tDfRkhT1LiDqzh6X7rMYXtAtk5QHBYvb
	 5ZnzVDu6OvoCdp98YdGPq1wPy7zTR+kMnKsQ6APqwIaQZsENU2bHUQPaADAHD1olGi
	 sKf9F2w0j+ADuMYIq6tmCC26lo1JyrJna+P6XDFtX6iRuBVceAtywQdQwTsaefAZqs
	 D0UWd6jcbOFyi3RdovJjonwXvUMhcBGItzCqZPPpKgJddboavEu/oHSWUsPzprOtxw
	 xbUHs55tU+s6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F3354091B;
	Tue, 21 Jul 2026 14:50:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF28B313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD1BE80BCF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cNR2s8UYNKR2 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:50:34 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 645F280E89
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 645F280E89
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 645F280E89
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:50:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9DE84659; Tue, 21 Jul 2026 16:50:31 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93043803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:50:28 +0200 (CEST)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so5001796a34.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645427; x=1785250227;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SuMcErdjQhlfwDhtmh49AheXHAIbdOo4YAZysnP/D4Y=;
 b=gr/vL3jSzo4QyZ3EoUvfDE19aE+7FbfrvRR6Ayt8wHasplIP95TfrU7iGVODkNhtQb
 mVuy63X2YIrLvUYFcxoyodp6FCeqn46FhSno8NmfcYFrvIKr0SP8e3t/ItPNEDBcIoI9
 zn5u/ZcjsBS59bbgpkNNl9OEcqZCI7kOZZCMdMpXx+5wR+EQ8pNTbuCiXWCa1ZFpJDZ0
 YSIBiE4Yky86dWMvklXO0KS3+BAPe7zQOrgKxcHtqJ2/a6w6tF5mLHRo4K4Y6jvIMTQj
 NjDDaF5Yb1TqjB+QTsyUPQ+7RKCWfBEBEeebQkKUMpq9TXux/Z/6fzEiMEzZSRF9dRYc
 ZKnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMacWhpnqhUiJ09cKWo+NBOhBuxqJe69pYeO0j20MBhIWMky1eHSYoy6n7ONCIcjNCi4/nQ+k=@lists.denx.de
X-Gm-Message-State: AOJu0YwBQTpLTYlznDfn59nBU6CD7e2LgvVjcmYS5cdZMN/0Ghtey5+2
 kxu9T6I8Iiu4Y7K+HiNXcG4XSuc69zzcfTQ4ZvfB2rDWkDXw5v9Drdl0BSIDn3u4s+c=
X-Gm-Gg: AfdE7cliYAaFXy1GHOW7Yiufjc1j52X4jypKXTTQK9oAPVt4O16cgCe12HcYC8DEEqb
 2I32Ia2V56DS0befI0CcR36kfT7uEy83WqFDVw20FtPvd/7yZcuTjoioZW5ZfSQOlhebLqVEPEl
 ivB0MK9rDcc8xk0uozB7DLbzYNVMsQP6HIKbtcOe4ueetgI/Zp+DTMKCbXGgz/A9u1+iq5IJhnQ
 FeLBbyknXEGoX0vO8+nwjrSEf6W8uAlv64OYwgh42ggouWmHHUhWKTyZA/XndCHYlkGszVnicjG
 YuW6af6sO4BVBNci/lGkDBuQ9rX3daAAWPLajc9lLvaXeuVVN1SrLN0Z+di6fXcxpuDeBYlVp6l
 XfO1EeUa3tHkcg7nrF7xnTIWg73we2I8lHkdIKZEoS9Q8ynO7KqG5KaFUeyCnK0xDNTa2LpL7ry
 xsXMlPwS+pB3kYosPS5MXBcUViukU1fvgsR1uORmeT7d4F6pmO1wPY
X-Received: by 2002:a05:6808:4fe1:b0:497:d3d6:6a40 with SMTP id
 5614622812f47-4a4d01645c7mr12904153b6e.3.1784645427076; 
 Tue, 21 Jul 2026 07:50:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0?
 ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3d4aa0dsm9878278b6e.17.2026.07.21.07.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:50:26 -0700 (PDT)
Message-ID: <2ca02789-5806-4672-99fd-30ea217fe5f5@baylibre.com>
Date: Tue, 21 Jul 2026 09:50:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] doc: board: mediatek: document Genio 700 SPL boot
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-4-1256b6dfda3f@baylibre.com>
 <7ec5f838-e62c-4a35-afaa-8320901cd8d3@baylibre.com>
 <DK47KU0R1WUG.1SFYMAO1PAA7B@baylibre.com>
Content-Language: en-US
In-Reply-To: <DK47KU0R1WUG.1SFYMAO1PAA7B@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784645427; x=1785250227; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SuMcErdjQhlfwDhtmh49AheXHAIbdOo4YAZysnP/D4Y=;
 b=Xu292C65y4VGYGgisZ1CQPkw6nHQlwhOj1Lluk1BSsmjMV+WRCF6EBvCtfQIH+RkLM
 xU/otKktIctJWbZFr6dEcMR5Ywi7ev1SHDfgFlZJ9LqQDz45ebCv+fYhTvDEOlCGFLB4
 60SakZldl4ZpQnG5IcSYxsoyvQBGIHwfgBpqUgVZXdrYTKkpUu6JWr2br6iDvrMBkf71
 +1wWH7+ATuzl8elfVBI2UwOreEWx6/0za8QOaezR7P+H3oyJtMzAkqyTYLTFBm8TuVpC
 rxser067K+0szF++3pXdOzGTuXKtAu/xuL/HswzqjffBbLBGC/iJjYCge+QQlLc38Y0s
 VRag==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Xu292C65
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="Xu292C65"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 6:22 AM, Carlo Caione wrote:
> On Tue Jul 21, 2026 at 2:38 AM CEST, David Lechner wrote:
>> On 7/18/26 11:16 AM, Carlo Caione wrote:
> 

...

>>> +``ddr-loader.bin``
>>> +   The MediaTek DDR loader for the board. The input may be shorter than
>>> +   ``0x4b000`` bytes; binman pads it with zeroes to the offset reserved before
>>> +   SPL. It must have been built with ``SPL_OFFSET=0x4b000``,
>>
>> Inconsistent formatting. Should be ...
>>
>> ``SPL``
>>   It must ...
>>
>> ?
> 
> I don't think I follow. The phrase is '... before SPL', SPL is not an
> external binary file, it should not be on its own line.

Sorry, the `` above threw me off, I thought for a minute that this was
starting a new section. Ignore that comment.

> 
>>> +   ``SPL_SIZE=CONFIG_SPL_MAX_SIZE`` and an SPL destination and entry address
>>> +   matching ``CONFIG_SPL_TEXT_BASE``.
>>> +
>>> +``BL31``
>>
>> Why is this BL31 instead of TF-A?
> 
> Because BL31 is compiled (it is) TF-A, they are basically the same
> thing. Is this a nomenclature problem?

I would either expect that the names (TF-A, OP-TEE, U-Boot) to be used
everywhere or BL31, BL32, BL33 to be used everywhere, not a mix of both.

However, I see now that these are existing variable names in binman.
So obviously can't change them.

> 
>>> +   The path to the TF-A BL31 binary built for MT8188/MT8390. It is loaded and
>>> +   entered at ``0x54601000``.
>>> +
>>> +``TEE``
>>> +   The path to the OP-TEE binary. A standard OP-TEE v1 ``tee.bin`` image is
>>> +   supported. The FIT loads it at ``0x431fffe4`` and enters it at
>>> +   ``0x43200000``.
>>> +

...

> 
>>> +Using Genio Tools
>>> +~~~~~~~~~~~~~~~~~
>>
>> Probably deserves an external link on where to get genio-tools and pre-build
>> images.
> 
> I'll add a link for the genio-tools. About the pre-build images there is
> no place the user can download them from (for now), they are currently
> compiled as part of the yocto image / distro.
> 
I was thinking of https://genio.mediatek.com/doc/iot-yocto/latest/sw/yocto/download.html
