Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B1CC55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 21:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4DCF6066F;
	Mon,  3 Aug 2026 21:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3pcbPM172UZp; Mon,  3 Aug 2026 21:04:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46F1960683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785791075;
	bh=OxILjdXBfe05471nhnSDMm92JsF6j/afDrTz4ZoG4NE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WAICWAtCp8AkGZr1PsRmk4vE5UzusFu23iMYeqjgL4LLtR2FZnPF3rAZ549dXrvYT
	 XKDxEcOJbUnkbJjCcpohfShy1xm7CZlaYhlKwahDCdW1vaDaCTYlV4/Kok8jHkDJGv
	 WkSxHpF/+ELGKiB+H4mKZcfWVV07tn7Z4CG+aKmTuMV6NXUhTGAOl0BGEUFnV1CAgs
	 rgfuawxZ4VNtnWE//Ht7hKK27PKA+JmVSvYxSjUoFKxxTUdf6BhVJD0hEki+VmkHcN
	 bhgx7NCjzMaagbj2Jrw2SMd5oK5Qp/fp56hS2ve0uWMm5uZ7YkVnz0drOaghXaWi4R
	 U4RTlMn4aeqQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46F1960683;
	Mon,  3 Aug 2026 21:04:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A79D8194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 21:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 873AB4064B
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 21:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 60_J1jma9uHt for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 21:04:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8237B40591
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8237B40591
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8237B40591
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 21:04:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C643E8404D; Mon,  3 Aug 2026 23:04:28 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C63C80087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 23:04:25 +0200 (CEST)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44cd237446cso2545159fac.1
 for <u-boot@lists.denx.de>; Mon, 03 Aug 2026 14:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785791064; x=1786395864;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OxILjdXBfe05471nhnSDMm92JsF6j/afDrTz4ZoG4NE=;
 b=ZX5Xx5Tat9kjDGnABpfezq7rRx0C3HIHu+dTrlfghddvx/BvsJC0I+1YDsgJshJinz
 Q+qgiBt8kyhPK9cOVtxCzm/8rJafP/+GBDl7A4wC537rqEAcwr4phFhVZ8A5jXyel+Km
 RiG3LPfGm/Un7QbV4bRM+TaoWxXNFihBGM52hk/2SvCdztBprt5YSfFfZqi3ahIKTNdC
 /WgGR0EvIVXll85IezqyXhLxDpdt+6FUFa44Ij/Ev+Cqs+KhoMCVwJTB/nKppvcz0eJJ
 P0gq5OdDUxvCe7lsFGRwI2X8X/1k/s631VePJKNqe2+S9Go4oMw9xEb/17xCC553BlYe
 wnmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5QxhIGnVWTV9O2BA0Ran3xCzX1uEi0tpyI+qblpxZ/MdeFzRCfBIFaDXExBv3VxjkZvqcS48=@lists.denx.de
X-Gm-Message-State: AOJu0YxXkkvuxIFlZESAwNNgYj71PR9g5fa931JBDb9925PQ3/MfGvck
 K8qHzZvQg/7yxmq5G1XxXMFiWFetEc+OoC6W4LinpcJepgd1TaFpokJTf+hgQwVyvS0=
X-Gm-Gg: AR+sD13B+LIiMIPjcg5AGltoIXficp6lVLyqbBZTOeIKzfqqOHJ/sbFazsDPKxRpm7F
 X+rWOO0e8q3hYkfPnzxhU5tAaZe2NmJKPMj24D/RP5j5aqaSoET+tMfas9mcO3IxNhr/hBBE6Xs
 vFWDV3ZDPb1n+I47GsP9/dyHJrqoPlwpzk4dkMEVAGFKoTn/r6ib5HdL37LHuiR08o+HHUnX3kZ
 fU+DTlJi7/QQni2mz6Pp9TbwJp4m7mTwkO03Ed64V8e8FpdKqHnd5ikqapT6bGWKpnyzUn++vmM
 43gBRVQ+kC1R9iNwQ9KSXzf9H6D+LNMxo6mXz9iXJMhKvdnqAXYEfoFlMIvpAZS6u8pyVWyZbN3
 84TDBqEdOoZ5PTlaaTaDolx0dA6yA3BIpWPq7ZB4/043fkjMxEUMGUzHmAIqcv9kdhpDY7VO5I8
 LpZQtss+uTbSsstyAatw2BlrqDmXy+KQqOzuiKe9RnG1YHFNMIgai1uHCgSnZqZj60Rwg1ElbpN
 hFt+LeHwxMPRWgKuzJH6pGxANzxe5xLTg==
X-Received: by 2002:a05:6870:5064:b0:41b:e633:baf4 with SMTP id
 586e51a60fabf-45905746272mr18401460fac.3.1785791064505; 
 Mon, 03 Aug 2026 14:04:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1?
 ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f664d7e1sm10169650fac.10.2026.08.03.14.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 14:04:23 -0700 (PDT)
Message-ID: <e241fa42-59fa-4aed-a92b-7e45f40fcf6d@baylibre.com>
Date: Mon, 3 Aug 2026 16:04:22 -0500
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
 <eee9d4dd-a9ee-477e-b748-020577040f0f@baylibre.com>
 <62fde4b6-0e0c-4507-b081-a8473090e692@mailbox.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <62fde4b6-0e0c-4507-b081-a8473090e692@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785791064; x=1786395864; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OxILjdXBfe05471nhnSDMm92JsF6j/afDrTz4ZoG4NE=;
 b=WwJHDkGR6IBfXYc5vp5UYwm8UhC9ToEFAg8lDwM5iL/ZXaY8vXzl2tqT5KaO3TGVR4
 NpEsW9B4yujxD6Pf32j/mwLJBFbdWACyXs8WS3IUh41MXKLPtLquBUGJXs8dqh0LTtPi
 KHahHp/fTIkUEEZJ8DL9TOFzdGy9b9jUBVrvpAsJBauZdz0Uy2F7AmHVL7DnQYFZT7Qz
 E9IAPbL9z2C0WcAEWzF2EyfsF6v8FjeMbLiOj8m6KIyDB1ZDOzVrQ9Tz+TY0BZkZQ35Z
 WL9rvAL6Xs+7hPdUuW2YGyAlfL+mETYQObtIty59elmdvPAuhwsv/tfqMUpL2kK1ujI1
 iapg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WwJHDkGR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="WwJHDkGR"; 
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

On 8/3/26 12:05 PM, Marek Vasut wrote:
> On 8/3/26 2:59 PM, David Lechner wrote:
> 
> Hello David,
> 
>>> Which other series do you refer to ?
>>
>> v4 of "Add support for the MTU3 upstream devicetree binding"
>>
>> https://patchwork.ozlabs.org/project/uboot/list/?series=515127
> 
> I think I commented on that one.
> 
> Also, are your concerns from V3 addressed ?
> 

Yes.

