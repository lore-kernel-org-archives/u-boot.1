Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F38C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C2F740669;
	Mon,  3 Aug 2026 12:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FU3jnROMtwUl; Mon,  3 Aug 2026 12:59:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99E9340651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785761965;
	bh=UhXva2UqoOgnMoNO5P2FbaDr3cIQ8kg7xGqkLby0+Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u11UV+EVAqcl0QpnXUMpr4LGfWUpJSsdDLTqqsYgRFP8ubk2CJWQ7ZHU/xJK9dkQ/
	 qH0WKpiBF2wx3Pb+d2kfqdaAAEeekMnHfE9MKC1oYffeAwCBuo1IRCrVNmRybUc4Zx
	 j+h4UDLyEX0+dmC8lJqLetxHp6/AQqA5dyAmXWeNIlhV/bUpdgOlC8HU88U7JdRFpj
	 7wV6MJG48CbiOtzz6wE1XgOM3aN0mCm09BpbecrlPRVXkm8HqF9ZfWLLP+SDviG9Jx
	 0IA6xhPTdU0LkiLdJDsorDHtqmYFO+EE98VyGc394MzOBYuIJwmuJiakzA7nHWgjn9
	 p3WXv6cK7fuyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99E9340651;
	Mon,  3 Aug 2026 12:59:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50C83282
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3711B40651
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMfpcRaSFWaL for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:59:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A446A4061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A446A4061D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A446A4061D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:59:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DA68467F; Mon,  3 Aug 2026 14:59:18 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916D680087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 14:59:15 +0200 (CEST)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6ae4aff94c2so1147070eaf.3
 for <u-boot@lists.denx.de>; Mon, 03 Aug 2026 05:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761954; x=1786366754;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UhXva2UqoOgnMoNO5P2FbaDr3cIQ8kg7xGqkLby0+Js=;
 b=cSiMfrGx+23c6e1yYuf893tlvTQ/tAswFtNvSvqsqNeAnYGEAwXH5JxWNxzZH3UAOS
 RbgUYq1ALOrDFLYxfTSQ0qzTyyesiQJjjrDlpnxv+L13pDJAhQKtn07MlFXKhuXRgTfd
 4qCsQJ3y6ae/v23fSbH/fdvuyLxUDEViu5uOhx35FM20idIA3LAMzrwFYaKrc+ZjvmBc
 Z2KKa+BnbZ1Ilcb9SRfSLEAOErCaf57CZbax0K0yD/XbVyATOT3gvr0RQT3ZoWedekPa
 RmmqJfolY2OxqWTEe4bMEUZt41NRRnl/UbddeF6CRQZDOTckZGj8Bp7xnxDwY9YqRcTy
 NZ/w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9br1VZ9mboe4gr4wOO6jpB3yvijGt3eguPr35xevVhrFtttXh0XNTJTRuXs6qUGcN3zvuYuE=@lists.denx.de
X-Gm-Message-State: AOJu0YyK99h85J7eLMk73rLh5ARseHamuSB/QKCI8LkuP9etVoeYDJTf
 iqPK98/CtiKvqKebBfsPEAKGyFqfzf6p6mLVDSYma7F7S3J1rJgptt5OM8P7yqaiXtY=
X-Gm-Gg: AR+sD13pvuOse6j6oNcpOgMAW1wl3vcN66dd/aeQ/4LAa5zmgcD9dk8nZFQbCImkvPp
 aOovyh3h/yf+cs6zscrjUSd6JoD2UOd6YNhFUykFJzKSkC16iyRYgTW7MZI14J3iGnBd6s01JYD
 2QhW3TuP3X5PDc9vdR4SJcALKjWwflamE6OCF0o2awdwusd/RrJHZN/EpFNxwiY2yxLUOSJ8g3p
 0k962ILdZaeeaa2N9VLt7wxeM4uZ58fc21qVgCBE/JYQmlsNDYqVd3GpwrZIcOhfWMAW8fCydrK
 iRj6YjSZcsKg0C1wCzcmHbv+KjjGAHAYxfkx7vX6C8bv4i3Pmetbej+YEQmDYv7FLjeT87dr96D
 oA2tu0sjJzCgjuNNP78gjOWYAHIr6EiAS3i/eaZkhpqozf4BH9mm1dGSq7TF6KuVtPdN3JOXB3X
 FgcGbxC7hmWr2ttwXo7Y8eaSXldvUu/Qm1wHwgbVG4Zk2BkzVsWb2Zqq+SRVMiax3T1zBrl5GWO
 +50PyAamK5YKhLVE3cDhPQBW7x9bb7B2g==
X-Received: by 2002:a05:6820:290b:b0:6a1:4507:3544 with SMTP id
 006d021491bc7-6ae43590c12mr14928278eaf.28.1785761949303; 
 Mon, 03 Aug 2026 05:59:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1?
 ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458fbec4bbesm8608598fac.15.2026.08.03.05.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:59:08 -0700 (PDT)
Message-ID: <eee9d4dd-a9ee-477e-b748-020577040f0f@baylibre.com>
Date: Mon, 3 Aug 2026 07:59:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Marek Vasut <marek.vasut@mailbox.org>, Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
 <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
 <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
 <a5ef6e24-cf8a-4463-aea0-8533de3d7521@baylibre.com>
 <223e00f2-4a77-40af-b7c3-2226f5a5bde1@mailbox.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <223e00f2-4a77-40af-b7c3-2226f5a5bde1@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785761954; x=1786366754; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UhXva2UqoOgnMoNO5P2FbaDr3cIQ8kg7xGqkLby0+Js=;
 b=FRZ6UoX46+i1fXWl/vRbEiFjpPnGl3A/u89ZDyUwoCpcsSKKVScsjl8dd4kLbkyLR6
 BLw3Ed5DEs/xMSheCz04OP8aLf8crZ/y7nHNKTAZZBWabZniZcdsYX9n6fabiDzF0/ll
 jN/u7FqzgaJnuXON72KDlfNKTuqg3GTbiZidVM5HZVam8sNTmb7OCW76yVivIi3js7LD
 dxzfexrIbsnGrVtuaoy+If0NTihN+aRI7ZFKd1H/mcDb3wqUmufGYh9MWed8VlQ0rf/P
 sNJtyNYuSSoUT4ebLJarKKge4Mac5U7IYWRziDiMZJSF7ezX/KQ2LTUp9enw/JLNOhpa
 XykQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FRZ6UoX4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="FRZ6UoX4"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/2/26 12:34 PM, Marek Vasut wrote:
> On 8/2/26 5:06 PM, David Lechner wrote:
>> On 8/2/26 1:57 AM, Carlo Caione wrote:
>>> On Sat Aug 1, 2026 at 11:52 AM CEST, Marek Vasut wrote:
>>>> On 8/1/26 8:42 AM, Carlo Caione wrote:
>>>
>>>>> Hi Marek,
>>>>> can you PTAL? Thanks,
>>>>
>>>> What does this mean ?
>>>
>>> Please Take A Look? :)
>>>
>>> Cheers,
>>>
>>> -- 
>>> Carlo Caione
>>
>> The question I had is that this patch (v3) is assigned to marex in patchwork
>> and is marked as "Superseded" [1], but there is no v4 that I saw that would
>> superseded it, so maybe it was marked that way by mistake?
> 
> Probably, Tom ?
> 
>> I just wanted
>> to make sure this patch didn't get forgotten because of that. (And I assume
>> Marek will pick up this and the other mtu3 series from Carlo in due time
>> rather than me picking them up via the MediaTek tree.)
> 
> Which other series do you refer to ?

v4 of "Add support for the MTU3 upstream devicetree binding"

https://patchwork.ozlabs.org/project/uboot/list/?series=515127

> 
>> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com/
> 

