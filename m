Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF4AC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 14:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47E6380F14;
	Mon, 17 Aug 2026 14:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n50mw-oHri5b; Mon, 17 Aug 2026 14:26:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6847F80F09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786976796;
	bh=ED6DTI8Mc1tSjT5ouW1hNNYK1SIXi4jnNPqqFKf6PCM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ard3WN2SLFTE32alWebaKlizp4m+7rf3NRTlJqgvf641LRWrNdOxV6Ca+5re03gix
	 BxW+qA1QENW/rrAzarD6NC6KulX+iB/tMRLrBcug0eaDoNMYX08Q4Fe9tVticx8sKD
	 xLBREm/wnUzFgUK0bjFHStg+o5yUADJncv4h8WhXwHx9N8MDZoq0IKF9UpOWJW3sst
	 ZJ/ZydJsS1FIaZMJYhVPPpjiYAkmp3saUZn0OkyN4BzB4jLuIL44IUb+LVL2kvq9Qk
	 WXMBd4Jmkr0hl40GTI9U3KRJKJHq5JMLCAqhUxP0xoDnOaToiWDDJ5FwRkyto0QGRC
	 Y5A82XWysgnTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6847F80F09;
	Mon, 17 Aug 2026 14:26:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41B95282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2756C6072A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYKkMboTHde7 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 14:26:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3F1DA606DA
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F1DA606DA
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=AwBMQ3uJ
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F1DA606DA
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786976743; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EqrCZDqtIohszmswQ8Sm63RRPWiO/caVInoDVUF3z5XgtuMF8lBxT3p/T/y02vVBlxjnNA1PbkktrhvKEPmNggd8cRZx2RqPsFHp/NMu6FlGq71+dZvP80D3HqhnrQdOrpu/qrMHjNkfKz1RHvlFQvplkW0zgWTjxEusc1gSCj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786976743;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ED6DTI8Mc1tSjT5ouW1hNNYK1SIXi4jnNPqqFKf6PCM=; 
 b=jktRSqOrtfyr7gwFAEGPvmtAu5do4hSQP0V5MPSFGIvoGvkJyHBa0yC+40nE7eUBxhIdrfrNXsdsipT7E9zuOCY52Y1DETg1mEhVCGGnIcWJjEFO6eHbJ1MeXTMBUMRwOA7cU68b4AXSc00lOCV16ZhM23+Pc5SnXAeblyt4wn8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786976743; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=ED6DTI8Mc1tSjT5ouW1hNNYK1SIXi4jnNPqqFKf6PCM=;
 b=AwBMQ3uJRCUdNw8froQL10G7sazEMOaoP1BYwdeYVVQosDIwlK6eMw6Wxjmh5RoK
 2bNH/kX05Q+ATGydBo2PSD5qbdmOxkFAzn0/hymUgpQQmLSq9wlk4BxBvUcZ9/a/YkV
 57gYc5p3gtCjvnJG0zvVtuV4SFuhoAA+WoZvjuaI=
Received: by mx.zohomail.com with SMTPS id 1786976740834828.1309380603295;
 Mon, 17 Aug 2026 07:25:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 22:25:30 +0800
Message-Id: <DKRADSUN4GN9.299FCK1VIS6EH@pigmoral.tech>
Cc: "Heiko Schocher" <hs@nabladev.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>, "Huan Zhou" <pericycle.cc@gmail.com>,
 "Guodong Xu" <guodong.xu@oss.qualcomm.com>, "Tom Rini"
 <trini@konsulko.com>, "Raymond Mao" <raymond.mao@riscstar.com>, "Lukasz
 Majewski" <lukma@denx.de>, "Yixun Lan" <dlan@kernel.org>
Subject: Re: [PATCH v2 1/4] i2c: k1: fix wrong bus speed setting
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.21.0
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-1-7d2a48607233@pigmoral.tech>
 <DKR3Q808Z4E0.27KFK7LNAM3K7@linux.spacemit.com>
In-Reply-To: <DKR3Q808Z4E0.27KFK7LNAM3K7@linux.spacemit.com>
X-ZohoMailClient: External
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

Hi Troy,
Thanks for the review.

On Mon Aug 17, 2026 at 5:12 PM CST, Troy Mitchell wrote:
>> The controller bus mode should be selected according to the requested
>> I2C bus speed. However, the driver currently passes the functional clock
>> rate to k1_i2c_set_bus_speed(), so the selected mode does not reflect
>> the requested bus speed.
>>
>> Fix this by reading the clock-frequency property from the Device Tree,
>> defaulting to standard speed, and drop the unused clk_rate field.
>
> `clock-frequency` is the requested SCL rate, but this patch only changes =
the
> value passed to `k1_i2c_set_bus_speed()`.
>
>> @@ -496,10 +496,13 @@ static int k1_i2c_probe(struct udevice *bus)
>>  		debug("%s: failed to enable clock\n", __func__);
>>  		return ret;
>>  	}
>> -	priv->clk_rate =3D clk_get_rate(&priv->clk);
>>
>>  	priv->base =3D (void *)devfdt_get_addr_ptr(bus);
>> -	k1_i2c_set_bus_speed(bus, priv->clk_rate);
>> +
>> +	speed =3D dev_read_u32_default(bus, "clock-frequency",
>> +				     I2C_SPEED_STANDARD_RATE);
>> +	k1_i2c_set_bus_speed(bus, speed);
>
> `k1_i2c_set_bus_speed()` only changes `ICR_MODE_MASK`. It does not progra=
m
> the ILCR divider or initialize IWCR, so the actual SCL rate still depends=
 on
> the register reset values and may not match the Device Tree.

Yes. This patch only aims to fix the ICR_MODE selection. On the K1 board
I tested, the register reset defaults are enough for both the PMIC and
the EEPROM to work under U-Boot.

>
> Please calculate and program ILCR from the functional clock rate and the
> requested SCL rate, initialize IWCR as required by the hardware, and reje=
ct
> unsupported rates. The functional clock handle or rate therefore needs to
> remain available to `k1_i2c_set_bus_speed()`.

That's a fair point. The current driver is aligned with the mainline
Linux K1 I2C driver. It does not include your later work to program
ILCR/IWCR:
https://lore.kernel.org/linux-riscv/20260508-k1-i2c-ilcr-v7-1-8c2dde5c3ed5@=
linux.spacemit.com/

Porting that change to U-Boot is not a small amount of work. I'd prefer
to keep that as a follow-up series rather than mix it into this ICR_MODE
fix.

>
>                                             - Troy

--=20
Best regards,
Junhui Liu
