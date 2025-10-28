Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F812CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E9082A9E;
	Tue, 28 Oct 2025 15:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TgZI6ZL4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ycW2NWno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7054E836D1; Tue, 28 Oct 2025 15:31:01 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE2F80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwt8f3rK6z9ssx;
 Tue, 28 Oct 2025 15:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lje5tPsbzw02JYAeJy+KGYnwTs3hX4DmUccGlkFQvg4=;
 b=TgZI6ZL4+xHfJXkgsl4F4Fby/OuTNqjoz8esKpBFE9R796hxo9xKlPhX3hIHN9RsPOvJ65
 gJ1m90ssNNI6FIHd1V+FZZvHhymCBXs0epq9RXo3fdVSV0yQiV3AfXsCrEsuNOipYkz9hg
 KdYm/x17SK6rqSqCZq2udOER1KKyFQy1aO92L7azhHPVMqoH3nLiYG6Lbve1xNlcaHcLYk
 nCQkd+K8OoBx7FjMRQlgRNciSR5rPqLMFQz66ycuCNJDRxySlK17KoGZnvun5Gg5VhixRR
 HUTaJYf/weROCeTxmbI/sP1CSwOncr3xKr/KK4uAUg2yvmHK2cTFILtlSMBamA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ycW2NWno;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <3e6cd3f4-c49e-4cad-8b0a-c8ab65251f02@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lje5tPsbzw02JYAeJy+KGYnwTs3hX4DmUccGlkFQvg4=;
 b=ycW2NWnot5SiGHG79Ck4kQyfW8eRMn1D/hUFzU2hc3GI3jqZ4rchIP6tyyCx0g/B7nHlPE
 pCNsIxchlr61jXsyCa2oGbLRtF5eZuuIOESTecCP8AlB+jKRj5R9LeHDUVFb1Cf1dVzRvS
 mfV8OUOTfeziatIXUhf9GFhM5t8/Lbp8SFg0JFJRGvuE+Z2arpY0m4nrToG8cfhj8HSzRJ
 TyEsjUVKBXjQtqJ76ganPRHDPY8YMldi/DoG213MrYvzb3SMnGO7avT+4Kbx3ozQI7yOg9
 /7gIdZM/jIFlG8pXBxWlzP+ivx1GFn/efeo1nCikqBo5ZprIm33So7cOgmXaVg==
Date: Tue, 28 Oct 2025 15:30:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] i2c: rcar_i2c: Add R-Car Gen5 support
To: Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Minh Le <minh.le.aj@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251027163826.11785-1-marek.vasut+renesas@mailbox.org>
 <52939ad9-ef5a-14c4-003b-892b9794c9c8@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <52939ad9-ef5a-14c4-003b-892b9794c9c8@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nzcx1w3jibd3m8hnjtujdoth3j8ipzks
X-MBO-RS-ID: 22828bc024b12f43286
X-Rspamd-Queue-Id: 4cwt8f3rK6z9ssx
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

On 10/28/25 6:25 AM, Heiko Schocher wrote:

Hello Heiko,

>> diff --git a/drivers/i2c/rcar_i2c.c b/drivers/i2c/rcar_i2c.c
>> index 3bd5108fd23..9562119bb5b 100644
>> --- a/drivers/i2c/rcar_i2c.c
>> +++ b/drivers/i2c/rcar_i2c.c
>> @@ -368,6 +368,7 @@ static const struct udevice_id rcar_i2c_ids[] = {
>>       { .compatible = "renesas,rcar-gen2-i2c", .data = 
>> RCAR_I2C_TYPE_GEN2 },
>>       { .compatible = "renesas,rcar-gen3-i2c", .data = 
>> RCAR_I2C_TYPE_GEN3 },
>>       { .compatible = "renesas,rcar-gen4-i2c", .data = 
>> RCAR_I2C_TYPE_GEN3 },
>> +    { .compatible = "renesas,rcar-gen5-i2c", .data = 
>> RCAR_I2C_TYPE_GEN3 },
>>       { }
>>   };
> 
> .. I cannot find this new compatible node in U-Boot
> 
> $ grep -lr "renesas,rcar-gen5-i2c" doc/device-tree-bindings/
> $ grep -lr "renesas,rcar-gen5-i2c" dts/upstream/
> $
> 
> nor in current (v6.18-rc3) linux tree... is there already a patch
> for linux, which introduces it? But is seems trivial to me, so I
> am fine with it.
The SoC and board support was sent separately in

[PATCH 2/3] arm64: dts: renesas: Add Renesas R-Car X5H R8A78000 SoC DTs

https://patchwork.ozlabs.org/project/uboot/patch/20251027172219.30437-2-marek.vasut+renesas@mailbox.org/

Linux kernel patches are being prepared, I don't think they are posted yet.
