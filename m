Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773A606A32D
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jdeiSkUh;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=M1ZAq9Ur
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24658607AE;
	Tue,  3 Nov 2026 14:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mMUDu4b1-s_2; Tue,  3 Nov 2026 14:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E36A60611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716259;
	b=RfAgfTzk11mUAzmSFtDAYOKobmSIGh9ak3ndFYxJPqqrRSOrevai0cnSHWVtIaX5T1DZ
	 flgUXh/m912FidIk3khozhI8sxzlNYc0gYU9mQEBckQnD5aXH263cEy8cOaA+x3LKJGwd
	 R08ONzfjAWW9xdJmPum5TxNCsvUviogJxptTEReo/Tb/h7DZ4gvx+Zjdq0BeRSMeuHrR5
	 Wb2GQBFwQCg4nEwYsHtagkoo39MhGpvGTqw0w5QkV+6VBAufAF8Mv9XjL3n+GQI+S1+SA
	 /CQe3U8sC8Kyn5SCTxrrml35OxsCJ+xOE82JDaf8DM5jx8udO4W0Hb5a7qHaxpIglzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x5382rynQLd0yPcosfiCibAmKV/SDzdSKiIEmdnnRIo=;
	b=emp+2a7NMs+i6QlvRFwtAqlY+CY7CstcJ7bueSAnEu4SvhZL/+eWiw6NkYtfZt1/v31J
	 GiwDrF3q2RT+F2cOnfCqVmgqZlF+cbWCVTCIfWHU9JhgfkzhsA8GW4K38TQEE5DBRpOdf
	 TlLiB8VVYJqXpui/S3P4fYgiwF0mSTSk+gtsgcx0lTKM4Ncfn7ZBzzC3sQWVJ/0u7W5gP
	 sK58ndwgl9RytsCwImwM45mYtTTTgqmxXLXOfFhYDjtN8I8PxOf6hiyJxltBDk1LzxYo6
	 iR8LzcADfJur9AYZmI3pxHHK1O/BgLxoiw1dtCg27rgWJZajfWhKhYmYApQPl0WcvmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793716259;
	bh=x5382rynQLd0yPcosfiCibAmKV/SDzdSKiIEmdnnRIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jdeiSkUhtYjVRySgpCl5pI2lRfb3UzR6wL4jyDSn+REQSeMh9ZvnonUSTO46S78PU
	 SgkGPApJ3n2T9sswU1+sXy3j1cniObQ/aXCUKVQVaHo5dmb1twL9YhmujbxYjdNj6p
	 thF3p8mWDMIqGyvSEeL+5qtrGQnonskrJKB+QxMWxO8t1Mq5VpuPz8AR25YrCP+VeG
	 X1QdxB4gXlzeh3H66aILIklv3oUl64iyNg/bHWCyQCJtEXctQ2zpUqXtEjBZI/Vydu
	 HDaezZyOXklw3mIsF5aqHe9Npb5/PbhaQlvo0DayYD4ZrVfcs7M53GMenMXi9vI8Pv
	 ZvrsoPovrE0zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E36A60611;
	Tue,  3 Nov 2026 14:30:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02DC5235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E82A0810CE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ql-R_YDl6np9 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5863A810CD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716257;
 b=rnZI6iD4jbEFrrbZO8kVNTgc02Pxmiue3aD4LuKu+8FcNpgFKyrwjV8rTtJ+fu367ptN
 rxRxJoX9X6jvPhYpgsKkPV2zj9tiHR31sDYGTDi0n02HGtz+86m2Wgci8NkSqw/pldavW
 gIrFNQwLwlItrZBeF5CIwtY9DVnbJCslirLwrs+dDO9mtfz7uE5iPVG2OaN952NxOzbUS
 1TqG4gix/mVutdm2fSfzIr9fVvBqXju0A+8z2A0xQlKIHKRIHDbxkC9xwCJnqlYRgtEpp
 VisUtV4OUKAyiWsv4jvsfACpf5LollM4q1B1D2luyIwqqJ6GZ6SUwOunWzM1SsQWAiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=x5382rynQLd0yPcosfiCibAmKV/SDzdSKiIEmdnnRIo=;
 b=spGj9toxKyDlB+Ql+fE7N5QTUELYfQhtrGeOOqrB4HIBPfvFNgh94R7Cx+rn0f7X+mJh
 NQzhZk72ipYNrRZ+uYi4BYz3hgphLh5HQ5FoGDhtQ1wtz7moJw0m9Mzaj2dRDnqpbBS9i
 jEjV98EYZlIcOlu5an5sWXS7FfqNKE3e2s8x5V/AjwylYDKlPr1C1Ph4DrRKjPUe/ToOs
 inC1z+7IdG9+bfu9CJl60jECwY5+q0ySl1OciBXF4oFXeoWne0mQYgRJRKS/oYuaHXNjq
 vznjp3mJUOIBhwWTd5XRvFyboErgYBZlIAqEfxLaN8I5FOqyGXz8pTXQ4HaQrH9pgXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=M1ZAq9Ur; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M1ZAq9Ur
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5863A810CD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:30:54 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6ddef424972so3061467eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793716253; x=1794321053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x5382rynQLd0yPcosfiCibAmKV/SDzdSKiIEmdnnRIo=;
 b=M1ZAq9UrEGs6UpqaBv27GUCgeN3QdgjyF6gaAJyNaZR3tbroO2ml0tenpgDTgoII43
 lw7QxM42VXqyI29xnzANQFuEzArhAuHhMU0yzdX34rK1K4OTagnNrCBYei4AM6UReuJv
 rezwM5zISncUraUIoF2pHOM3P1V9cpRs/+oUPme6SMtgata4oGf4PpDJUX1uuGkiigtd
 GyUtgXfQtU+gI2KsKoK5RwnXwSSGQZ6HkW9CxI9zON7xM5u7e2RCJY/krAhjU7Mk40Yt
 Y0ku1l0ymROAl2bSysnVsoQf0nxcuzpdJey5LLWzv3nwOr0FOdjD4+oOU2O3FpfJApFB
 3tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716253; x=1794321053;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x5382rynQLd0yPcosfiCibAmKV/SDzdSKiIEmdnnRIo=;
 b=E9ruJ+AQnCBuLmFjJpBMnGaXntO9/BURT7y6+j+LAzLINtR0jTE6A9eyYvkKYWXect
 DVcUXoo496k31fVyekV1ad/0rmi2Khtw0Snh0gL/Jb9TOdFZWTdYZh3eviax7IfUgOxU
 bdf/LTpyCLnZnMW7QxJgT4BbhAA1PiTuEzvdwrWm0pXAR9cphf5ScceFrQsllKKsNXCB
 8OpdI133saAPAARRyhtVcTk5l45ElQbhZw5LjOqeCUXihQw640uJZDcxKwV7X6SR1nXL
 cyvFK2vlSjQoCK9bYcQbAAF6YDF9FujqWfHjdAbRWAW8kwvMKHPjfM6IpBMo8lXqzOns
 2mxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkLB4H2ihuGsn/ugFkaTkWe7cr0j+waF+eM+VqUjuekx9QOUZwB02Sdl7HIJs4r55Geif2Jyg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9LnpXNjSUwdfoy906kdYffatZs1Sg2gwdAAcHoNk2Z4v4e5Mxk
 FM9j5XNQwhgq3hoiJC4+V2y+2xwGXi9v+4kXoXWlFGrRcgupbN/vjDY4VNpVHUKZ4Jk=
X-Gm-Gg: AYBFou2QF4x0jKGLKZt3ZXv4o8ujFBNQN645G75tsq2iPvK69cpJsdjzfLrFU1QVy4o
 yF3XekPQLLMdW77cNZrM4hXrrboUljVF16DhroC6D/jx6IvgYZ9/lHbZb55LxfDj7DOrvFCBNwR
 u7P0uku8cFPfVKbRCQXgmDB8E6Fq+BmTTdUx5ELnmK8yvKSfMuZd1q/V86fGstI55uyUE//tY/Y
 v3w34HZH75uZugF2RmqxIrAz3MKJMTYUhQrMewrX9DaMqAvWjbMtcqzP8kySToIdCJb6+yP7Id4
 AmBQXYMzFiqp6xBlfeOx3wcAUrcc7MPNejxvXXT6HRUhXZrW+2xCRkvvGsHLbiFqM/3S5JLaF/E
 hfE2Y3vWaDiqQFowwr3l8RU1lPWElGmV/h8YjGgsknzwWedHkZMESRCMQCi72C042gR29er2Hs7
 YoQfiOTZWIuQBIBY41T0F7gJigZWGBF88ecLhELgcQCprZzZVnxuPL0v81DIrPpPw2snLb7wSfE
 K43ZduiJaoSa9WHE7jxXG+nHufHYDJaTUKr55PpzvFfE6Cnx+dKxIX3IZepJ4fxGMyaBF/o+MHw
 AV8PXsyFDGVlRCEb0tMaC0EjQfhyTEv0wq1k9DvIBN9oWrwNlKxXKvL5s2PUr4Rqz41gD9Q4zlI
 =
X-Received: by 2002:a05:6820:1614:b0:6f8:e2ac:ecd2 with SMTP id
 006d021491bc7-714f29bf3b4mr7433163eaf.33.1793716253427; 
 Tue, 03 Nov 2026 06:30:53 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d5c1:c80:22dd:8a48?
 ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ee131267esm1696430a34.2.2026.11.03.06.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 06:30:45 -0800 (PST)
Message-ID: <d92d544d-bb7f-4fe8-a5ad-5598643fb6ff@baylibre.com>
Date: Tue, 3 Nov 2026 08:30:43 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] spl: atf: optionally pass the bloblist to BL33
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org,
 Carlo Caione <ccaione@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
 <20261026154825.GB646438@bill-the-cat>
 <fc38ac09-7f0a-4301-b78f-954dff0b475c@baylibre.com>
 <20261102225159.GK3309461@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261102225159.GK3309461@bill-the-cat>
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 4:51 PM, Tom Rini wrote:
> On Mon, Nov 02, 2026 at 04:28:55PM -0600, David Lechner wrote:
>> On 10/26/26 10:48 AM, Tom Rini wrote:
>>> On Fri, Oct 23, 2026 at 07:09:09PM -0500, David Lechner wrote:
>>>
>>>> Add SPL_ATF_BL33_BLOBLIST to pass the bloblist of SPL to BL33 with the
>>>> register convention of the Firmware Handoff specification, through the
>>>> BL33 entry point arguments that SPL gives to BL31. Without it, BL33
>>>> still gets the primary CPU MPID in x0.
>>>>
>>>> U-Boot proper already looks for a bloblist in its boot registers, but
>>>> when SPL starts it through BL31, the only other way for it to find the
>>>> bloblist is a fixed address in memory. Memory at a fixed address can
>>>> still hold a bloblist from an earlier boot, for example after a warm
>>>> reset, when an earlier stage did not write a new one. Passing it in
>>>> registers ties it to the current boot.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>>  common/spl/Kconfig   | 13 +++++++++++++
>>>>  common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
>>>>  2 files changed, 38 insertions(+), 4 deletions(-)
>>>
>>> Why are the existing BLOBLIST and HANDOFF options not enough? I mean
>>> that genuinely because it might be the case we didn't end up plumbing in
>>> something here, for the not fixed address case. But I would be expecting
>>> something like SPL_HANDOFF being added and maybe touching some more
>>> common code path too.
>>>
>>
>> HANDOFF would need quite a bit more work, from what I can tell.
>>
>> We are passing two kinds of information, the DRAM size and some reserved
>> regions. struct spl_handoff has a field for the RAM size, but neither
>> struct spl_handoff nor the ARM struct arch_spl_handoff has anything for
>> reserved regions.
>>
>> Also, the same info reaches U-Boot proper either through SPL (when a DDR
>> loader starts SPL) or directly from TF-A BL2 (no SPL), so it seemed
>> simpler to keep it in the same form for both. HANDOFF is only meant for
>> U-Boot to U-Boot. To use it, we would either have to teach the non-U-Boot
>> BL2 about U-Boot's struct and keep it in sync. Or we would have to have
>> add more code in U-Boot proper to apply the same info a second way so it
>> could handle either case.
>>
>> Instead, we chose to hand off the same bloblist containing a devicetree
>> overlay everywhere, since there is already code to apply overlays, so
>> everything just works without much effort.
>>
>> Also, HANDOFF currently requires BLOBLIST_FIXED, which means all of the
>> parts of the firmware have to agree on the same fixed address. To avoid
>> that, we would need a new option and the plumbing you mentioned, i.e.
>> passing the bloblist in registers from the default jump_to_image() as well
>> as the TF-A path from this patch.
>>
>> So I could replace SPL_ATF_BL33_BLOBLIST with a more generic option and
>> implement the jump_to_image() part, but it would have no users currently.
> 
> It has been a while since I had to last dig all the details out about
> what bloblist was implemented vs what was intended. A thing that I think
> might have been either not implemented, or perhaps conflated / tied with
> HANDOFF was passing the bloblist from SPL to U-Boot, and not relying on
> BLOBLIST_FIXED but instead doing the normal register setting convention.
> And that's what I'm getting at, it should be generic to have SPL pass
> along a bloblist in the normal expected fashion. The path on your

The normal expected fashion being, e.g. via x0 register on arm64?

> platform is:
> Something -> SPL -> BL33 .... -> U-Boot
> Yes?
> 
Something (DDR loader) -> SPL (U-Boot) -> BL31 (TF-A) -> BL32 (OP-TEE)
                                                      -> BL33 (U-Boot)
