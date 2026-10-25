Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C5606A31F
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gEeTz6eV;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=RkmJdJt6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D3C681359;
	Sun, 25 Oct 2026 13:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCRq4D4BTSCg; Sun, 25 Oct 2026 13:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6C47812BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792935027;
	b=O49F1uw6gTrNd6YbOGzbEsZJQVZw+onXHu8dIXVFECMZ2WVDS5FkZ9Bvl9iOhHXueHuI
	 gdi1/mU1T30ulAv1h1JQJiwJVFaxfCDn0UG5QxanhN8Q5FzeKQaVqjkXMKj0Dtaukh9qO
	 nco0TXL5zkqBRGJrZGc9tikU9IL5g5Rf58sD89XVFl72vqQ1tNAsG5GjSOOhF2pnsDgNP
	 PZcSKUn2JjQXodDZgSfPcMa/qWh5zk65RSXaETmG8YHDk/rJkluvwTFljZSxExhaTvPQb
	 dxqPl76xkI0yNem4HGOnPFrSH5qv98sC+38FwkLZWj8qXlc8V8Q/S8v/7dgp8P/Yzpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792935027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w8L8mGjph2J+dMq15OBxeLxRcP8AYE0/aFh/kHnaF6Q=;
	b=qmJel52NsxtK/IjnkfctIvSklct259zfBVGeqoxwoMf5Jt/WqwQQVMfiErVSmusil2yG
	 vIeEhvyhkRe73/BXUuoIU2wNZCFD2HFOKu5em6i+uo50tE0bPnWRAlqfk+Vrnj+C2MSlJ
	 C3K3djdTLvDKBK6JwYi+ePxfw4p6TShyDheaNeQKdhJzhutrKiXYOKx3DIJsEZFedMyvF
	 mK8fUUhZTu3U2MvaVlqOeNQJpeJWTLwmX6gkOw6D3OrkedMcP0k7Eza4C4EEIJEYuqPWU
	 gXSH2khyV6Lr5RYyiIskFIir97Ntsrlhp6neuXxxYcB+ENjIc3v7W8WkjcoVQ4TlJ4g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792935026;
	bh=w8L8mGjph2J+dMq15OBxeLxRcP8AYE0/aFh/kHnaF6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEeTz6eVXYmd9uwujqbuQ38n3L1q0QWHUELfuYvU5filCTlfI5Gumz3NoNo7SPRVI
	 /PWBCbmmiv1MhDIBmu4IMeQX48oXy1mtV7l+DWAF8j2yD6GzAzXhgU3nlFdMk/zjHq
	 +AcK4nqv1EV8E4kjXeZXwAhdccDlMTK+/kcLxksefQrHUOISh3tjMcUjqfdEbUf2Jo
	 y/4b6yJjjhL9RbPx5yQ0amSYwspVP6sOp9wKuPpIMHwMlPECKNilxXgyUB2Hone5mK
	 E5ItkZ+z2PJwLP6dQMyrG6yi1WRjI7wubWggnWRM/asTwWs6rVn43/cFY9Ec6IiFJO
	 ygac3u0DeP/hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6C47812BB;
	Sun, 25 Oct 2026 13:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87987380
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79AC7407D4
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oc1rpGTwnPnd for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 56D05407C7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792935024;
 b=HcwL60MYDRKUw18eFQP5kYtfReMiGr/68LYIrHp2CkUS8xNa1wlDDZpXS2eAgYdtWi4W
 WQgHU1h+qFA5HZBEdWYVz5OCZfNUchDQ2Yx0662QjbCwtm81u1kyt14LuV84IBeuhgfcF
 zjbw2AJ/F4IDzaiQHceUPzKocyVGM8zUr+aHUDC+j2mMhW3jc7MDBVgkn2Nwrn3Zf+nVJ
 fF4MzfYV7HxntYiAV8DiNDOgwa5UZhziQL7Ke4TYfZ3lXvJLbuAQ+zHH2VdNVV/w1ZNq/
 nqxs7INvoDeu6tsPsx20PVEIUWuyNoKho0ShA7rqIEDD/wWqF6KOP4cebQc5ezuIwQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792935024;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=w8L8mGjph2J+dMq15OBxeLxRcP8AYE0/aFh/kHnaF6Q=;
 b=i9xZVBitv5jH0zxjHC3AovSz8vTi0kantYvdzXeowcjSG6vImCvEwyWAI5B0tOi9sVTC
 ljzM4azNuu2+e0M2OApRC5jppMdbqZyiSyp+Gz+T7/2SuW45ffk7Tqru9LuJfj40INYuA
 TV+ikCnEf8p554dU1/xbyihSTKgklWuK8W8sTKgItGCfHuGV1oFigv9YQD+2rhf4VYO1p
 b2USAYkQQMkTAumExyAOtGlnEyX0vkvYdRfmo+GBYAtLk+x67FjkD1GCd02fl1mPaBAcF
 r1mNvAAAdSYp75A+XneSIZkGQQwWriZClhb+lreSwQScIu0cayezbzFbm1hhZq7no2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=RkmJdJt6; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=RkmJdJt6
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56D05407C7
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792934987;
 bh=w8L8mGjph2J+dMq15OBxeLxRcP8AYE0/aFh/kHnaF6Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RkmJdJt6x4WqBM21HrPl7TN0+41lkhyHKNT/yjDj3Es8CLG81sYLfpXqIhQuXglCf
 /vINaW31vMbjDnbVSeIAG49OBUCCCj8IQIweHTcC+8KRAPtlDi11q8n+0z/B2pmyjZ
 xMkfXF2T2Y7DzGdzkf4wuXgJUraqMB0QvvfVIYfKZZOFslV5xerPJPrar1YYg9zhGa
 P3o4WKIu1r87dPsWygYYgTzWJazcag98GkwF5fDcZyFtf9GG419wsgdNlR1zXe2oAk
 Ufg1kp+FT6x7ddqXFp+9pJHBYY/nzZawTVZtIYzlFyD1XTrYMM9+sLji6f490LN7ie
 hQL1qSl0KGrJw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8C595B2279BA;
 Sun, 25 Oct 2026 14:29:45 +0100 (CET)
Message-ID: <0c4fb416-62e8-4ed1-b7f0-a8021092db59@freeshell.de>
Date: Sun, 25 Oct 2026 06:29:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
To: Marek Vasut <marex@nabladev.com>, Stefan Monnier <monnier@iro.umontreal.ca>
Cc: Alexander Koch <akoch@initse.com>, David Lechner <dlechner@baylibre.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.u-boot-project.org
References: <20260611224544.210172-1-marex@nabladev.com>
 <jwv8q3ni16j.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <099f49b0-2704-4ceb-a730-92107bd09643@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/24/26 11:05, Marek Vasut wrote:
> On 10/24/26 5:14 PM, Stefan Monnier wrote:
>>> to the fixed indent:
>>>
>>> "
>>> DRAM:  3.5 GiB
>>> Core:  310 devices, 34 uclasses, devicetree: separate
>>> SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB,
>>> total 16 MiB
>>>      ^^^
>>
>> I'm probably not the targeted audience, but FWIW, I find the meaning of
>> "SF" non-obvious, so maybe instead of adding spaces, we could use those
>> 3 extra characters to come up with a slightly more
>> self-explanatory abbreviation?
> SF is SPI Flash , it is used all over the code base.

I also find the meaning of "SF" non-obvious, and nothing better comes to
mind to abbreviate it. You cannot get to "sf" command from "spi flash"
or "flash" commands. If the probe message would say "SPI [NOR|NAND]
Flash detected ...." or "SPI: [NOR|NAND] Flash detected ..." it would
have the context needed, else I have to look up a part number or make a
guess what that is about, remembering the first time I was confused
about this. It could be easier, but I don't know if that's better.

The indent change looks okay to me, a few bytes' increase, if there is
no \t tabstop to reduce byte count and get the same effect.

-E
