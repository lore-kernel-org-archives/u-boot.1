Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B22C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 21:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 069D2810BC;
	Wed,  9 Sep 2026 21:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EpNC27mUsi39; Wed,  9 Sep 2026 21:00:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 308E5810AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788987645;
	b=TZvh3oD9j/eUjatW9L6aaNFd1Vg1ELP4Ejwp7WGcsqsfc0oi52kTgCk/SIAFyY6SJw2y
	 MFCc0hGdwp0Jmy8LhI0F6RmDYG5B4xBG/0QLhj2WkqH0hh1R4e+nkvXpwFox6s3QnoEPI
	 Sj31unH1PIjAg3i5J8yPWFxw2ytMEUYgGjvmLX0kupgeg75aR3icKkn3E1qr4a4N3oePo
	 zhCOkvgTGjWciZP9DWm1AJEEEXn1G3POc77+9EqbabZcIM22+g+Jh9HYkkLbO0TINv7Au
	 VbzHJJ1VQR/HVah3tOc25DyaNeUMIPeUN7pXWx7hu+8s3/hfZRMVb/q22nP/hkyNiLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788987645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gWZESuarRQs7UIWBPcoUSe3VtjfM7n05VPMFkeSvgHY=;
	b=WRttl83JtCnEP/u9hFKlImdeekxpafPGvw2Wx/uvJTBfQu6yJ9E+YSTGwGTEPOa1rltm
	 +gyIeXF9o4KuIiGL/a+l0aI4yNMoe14M0I7H2KZV77jA/NstCzRQj/pM2C9BTXwyc+UEf
	 eEvB7Jofo2pf/jEedesaWCEi+bMDGIN02Pd3EZV4IAGe3DGKaC2mC/2zj0KcicB5DfHIo
	 wg7PgzqWLcU/wS3rpuxVkX+fRZ4zD0cgpU3XqcQpLQwbIpUpMwh2wobsdkpQ1hatWult5
	 7qOvo6lgsBXXsMAVWIJQLjfO47V6ALYyo6sOXDTm83NM6SM59VKCpic0INMI5Vrcqxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788987645;
	bh=gWZESuarRQs7UIWBPcoUSe3VtjfM7n05VPMFkeSvgHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k1TXnARbSaS7nL2XWa+IHxlHtLWazUlncp6x7kVxVbHqfd6ag8TWNRote+7H3jXZh
	 hpMdIk5sTnQFNBdDMFKCWqtXIvJ+14rOWyTT3ZUrZ9K2m+siWVsLfTi9rkBeNL6TSu
	 VJ4ngU4+LRZH40ZJBshFLhIfvXc05cmiHiGpr63T0Nbv9f+IjyBbPcDODdAwyWcjRj
	 QEOnF16j8IegCsV8TmNNY24LCpW8/PyLLBz9Zo8tUUHlYlZqsOIs8jA8THA4NtYBa+
	 FOukWeSl5ByDkJZPRQuZxvMKCBFfB+5UzQe8AJuoNo0bHdWOMsZHQ12SFYAZb41yqY
	 fYkWxXPXtlOwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 308E5810AF;
	Wed,  9 Sep 2026 21:00:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D02143F
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2866607FF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdE17_MZe4OK for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 21:00:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DBD7C607F8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788987643;
 b=gC402rX0p12Ib87aqfaq7OmmLBwJMmEtahs4Tqr1ziImjtokFjDJ6Cj2osh/DHwjjBui
 Qx9TcuVhpcpfU/UsWDP7ao9RIgbgVg31vy4z5tkL5rts+uke4L2G5Agw+4gQzAlb1CIWw
 BsPkLl/4LdOlL99f3s9Anydu3U1/5VPgKlyQ/D9ZY46XsY8B7DFZXyyZx+6fTALPcnFmh
 /ze9FqtTvO5QDw/X60bn/qDCj09K0wHShEw6yuWTYH/5YEo92Y+N1cfsGavwe6R2ig3L4
 530nOQ4UEQut7l7iq2KWDstvARvKcbOWEB0hRiwrEfguT4JH/E1xSr/T+w5fTGnBWbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788987643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=gWZESuarRQs7UIWBPcoUSe3VtjfM7n05VPMFkeSvgHY=;
 b=V0Cc2k7KYlhQdjZmvMjM49Z/UIeJy41bbzTNONBeJwBqjiVo/VAXHcNM1badHssNAY82
 CfgBxayctDgJPUa5eawynPmw9VCY71Y5d6rMIVQuQYwSuJlmwkyh12EilQsXTPpQIcd5s
 3Nqjh7dnm6eH7kubSmmDZl+v4C04Y/yR7f3XGhgiwygQUxATXh8zu/Xna1wAkvEBg/H9i
 zc5GhuUNqK1Aelrj1aLqtWzzidgIq7TZB0I2jluJW+z/lZuefDaSJZsxA66z8sFq8R1aK
 s6pC8lmA8c+8ey1g8tqLdjWcYnFrIDPOV6iopOFON5HTzV7jN2MvDgg6nw31PHAlWPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="C3Cw/y/I"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C3Cw/y/I
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBD7C607F8
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 21:00:42 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4b28d7c729fso4301028b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788987641; x=1789592441;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gWZESuarRQs7UIWBPcoUSe3VtjfM7n05VPMFkeSvgHY=;
 b=C3Cw/y/I4jY1nEUYzY0VXhnhlRaHb6c7Z2RoiwY67NQud3LepQm/sIX4E/lB9aRG27
 kzTOy/WCZT9DLrHuMMcgFYuEFWOMDMfGLPR7+IRcAXcK6UFo2JPKzxkNAtMuBD4orijO
 Uawj6NAyTodkmQG2BNItt34+Bt+y8InsDu9U4x7361YdzsRRZmDlHMoGE0ZTrAX1iqB3
 rp3OcBZE0Xf02yQo4IQ+/Ymm4ZEXBce+HHH9rShJshR/9PP/x08hE8E8cKWHki1At8JD
 5sAVG36jtj93uYCH+WzoOBLQmtn/DvOd+gkFQpI6mmGrKaTqHaBTWqfeuDUn9XTAD30e
 56uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788987641; x=1789592441;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gWZESuarRQs7UIWBPcoUSe3VtjfM7n05VPMFkeSvgHY=;
 b=qFprGnXtfXt79Cqcef2pVqZEcS0LHb2gSawb+2OSEukBCC5bHRDJ2S4FqBp0inX0VX
 4SqEdqKSv/XqFKZhxGvzYHCCCLQGriL6AseBQPPvwWZHQL/CxeVzEV20fKZukDRjjaG1
 KO16GFv5gszQsMZzGnK9sKMFPtv6kPvXt3VVW0dV9bpwOgWdIDRb1JoAh4u0f8+I5R8Q
 HiVggrmz9iyEzleD3q2j9a9DNE32mmyZNxE+6zTE2sq30vcZuGJFk3UXVC+UjssMTzO1
 nfrh7tmdqEdPLUx0oUtw9ST/YQSMUQTtFO48g/br0BxgDd+nZ9aTrVHStAXpRgI3MYPi
 w0MA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/ym/U6x/U7UxxecBKoM6564ogAssL/FbAVaQcpfKBsbsQUn4oPdk5N1dO7C2Ykpdjcy9wfcc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nXy8jRErkpBM6H/4zdfi51PE8EsPiNw0Hf5ihRt9Y5FyaV/g1y
 ASwvHvVkcug0Al+bvd97xZdqyVgLSKxYRdKcMzY21w4ErPO9b8JTPAvi9PDTARQ7S6TyJpLJODN
 yGbLz
X-Gm-Gg: AYBFou2nQ0D4maAdjPkNETQpxRHJFWSbuuPf+jTOxKUwVAwERyf1ht740H0+ZF+h3Mh
 2fcyM3Zo+avZmixfqKQMbhWKJ5q8+qwNR2Gh6bTQ5LSfaK2BeguMyeBXWcP4VqxmBAvOGnJPLQ8
 JQ+OaSLfWdkWu+Pvx3l+AOQo8ElOofU1Gwf07wIxUekcN04I/h9bEv0pWIrIcFQSJcjKQr+HTYc
 KXgNxbP0alSFOJm0h/g49zPkD+v1suyNniXpqeO6wUxymYuq9JCvUUkdp1cXQERG/5WPcwV9z7w
 k6A46fb36742nPJdig7GWa2Iq2/gR2Bv5H0UMAwvqJZlCVfZjefG8aGz8MquS+xCkh3z4U4Z4Bc
 L4LPe/0RSn1poxBvTL2K+qU6k5De/d4lSPGIK7dHCkMphW+nMc9CWLLbr/DarEyOkzHLVDKXKRe
 jXoQSsimDfS25UXtdXfhKHtpxIGSiwaCXk7Bje/W/egh2vqpaR/th3ZOO681zAAluO7D5fSujT8
 4QSzJABRHGDocvR9G8zd0xRFTdKpt2XxbFefwmdyeAwz34=
X-Received: by 2002:a05:6820:624:b0:6b8:ef7d:e181 with SMTP id
 006d021491bc7-6b8ef7de33cmr15615711eaf.54.1788987641327; 
 Wed, 09 Sep 2026 14:00:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a8c5:6332:5ea:5b26?
 ([2600:8803:e7e4:500:a8c5:6332:5ea:5b26])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6bea1064888sm1796584eaf.4.2026.09.09.14.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 14:00:39 -0700 (PDT)
Message-ID: <d020ce2f-a6f7-4598-96f3-13f8415cc460@baylibre.com>
Date: Wed, 9 Sep 2026 16:00:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] doc: board: mediatek: document Genio 510 and 700
 SPL boot
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
 <20260906-ccaione-upstream-mt8390-spl-v6-6-4d4a11d5741d@baylibre.com>
 <f12ef161-582c-458d-b49d-974ab55e7788@baylibre.com>
 <aqHGk-XC59Ddhcl-@macbook>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aqHGk-XC59Ddhcl-@macbook>
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

On 9/9/26 3:54 PM, Carlo Caione wrote:
> On Wed, Sep 09, 2026 at 14:56:02 +0100, David Lechner wrote:
>> On 9/6/26 10:30 AM, Carlo Caione wrote:
>>> Document the common Genio 510 and Genio 700 eMMC boot chain,
>>> board-specific external firmware prerequisites, binman build invocation
>>> and generated images.
>>>
>>
>> ...
>>
>>> +DDR-loader handoff contract
>>> +---------------------------
>>> +
>>> +The DDR loader and U-Boot SPL have no parameter-block or firmware-call
>>> +interface. Their contract consists of a fixed image layout, initialized DRAM
>>> +and the execution state at the SPL entry point. Different DDR-loader
>>> +implementations may be used as long as they satisfy this contract for the
>>> +selected board. The BootROM loads the eMMC boot0 payload to
>>> +``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
>>> +
>>> +   offset 0                                     +----------------------+
>>> +                                                | DDR loader           |
>>> +                                                |                      |
>>> +   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
>>> +                                                | U-Boot SPL           |
>>> +                                                | CONFIG_SPL_MAX_SIZE  |
>>> +   image end                                    +----------------------+
>>> +
>>> +The DDR loader then performs the following handoff::
>>> +
>>> +   initialize and train DRAM
>>> +
>>> +   copy:
>>> +     source      = CONFIG_MTK_GENIO_BROM_LOAD_ADDR
>>> +                   + CONFIG_MTK_GENIO_DDR_LOADER_SIZE
>>> +     destination = CONFIG_SPL_TEXT_BASE
>>> +     size        = CONFIG_SPL_MAX_SIZE
>>
>> Do CONFIG_MTK_GENIO_DDR_LOADER_SIZE and CONFIG_SPL_MAX_SIZE need to be the
>> same or just CONFIG_SPL_MAX_SIZE >= CONFIG_MTK_GENIO_DDR_LOADER_SIZE?
> 
> They refer to two different things: CONFIG_MTK_GENIO_DDR_LOADER_SIZE
> reserves space for the DDR loader while CONFIG_MTK_GENIO_DDR_LOADER_SIZE
> is the size of the following SPL region which the loader copies to DRAM.
> 
> --
> Carlo Caione

Ah, makes sense now, the SPL source is appended right after the ddr loader.
