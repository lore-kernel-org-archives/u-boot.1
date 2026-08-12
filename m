Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB123C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 08:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B59B608DC;
	Wed, 12 Aug 2026 08:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgngQf3avhYM; Wed, 12 Aug 2026 08:05:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DECE60889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786521908;
	bh=3IiHc47dVMQ5UT13Vp/eEacxVwCCbgCmIJ2y2GGgT1E=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KsbHBATsdePe+mK9pRGsudd11qlvHGVZ9AI/5+YSs9AGTJr5ebQ+dfr3+vo+OpOpg
	 v4Kxp2oE0+YcismaXntAyqA2wPA6OEZGPHB7TbasucfJh1fTkfD2RRY6iYWR4clTsQ
	 GuqzkyM4alz+G9phZdHVRiAZx3RCyTr1gkgVnmqOMBpASm8VIiAjBuQ68+1fI5jYzl
	 i0jw6uoGnfUBVA4DQ0JUYv8HY/oeVavnJCt6PZ0fuzb0M9XBx4pJmFQ6SsAzccsD3R
	 tNlYDq3TgzF23oAnYET6QNhgOjPaCIZCz8Eg7lBljjia1U70bNk9Hg2hNCjEUQjdtK
	 ylkGcZviI2FvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DECE60889;
	Wed, 12 Aug 2026 08:05:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E851F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCB214083D
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EijOiMQXiJSa for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 08:05:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.11;
 helo=smtp-190b.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6AB4E40824
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AB4E40824
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AB4E40824
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 08:05:04 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKgyP2YJ8zRgg;
 Wed, 12 Aug 2026 10:05:01 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKgyN2P6hzjDH; Wed, 12 Aug 2026 10:05:00 +0200 (CEST)
Message-ID: <e5aaed12-ec8c-4c8b-8cf8-1c4f9bdc2174@0leil.net>
Date: Wed, 12 Aug 2026 10:04:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-3-festevam@gmail.com>
 <d4d49e17-e125-4121-b0be-e486e1be5393@0leil.net>
 <CAOMZO5DULY0wE_U-4aX9sfrnum++J9iJ02_H8L+g3qdY156KCA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5DULY0wE_U-4aX9sfrnum++J9iJ02_H8L+g3qdY156KCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786521901;
 bh=3IiHc47dVMQ5UT13Vp/eEacxVwCCbgCmIJ2y2GGgT1E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KLcUdbBkkgKmncbiw84O6X9y8ODEyqoppL2p2u8HBt52uyv6RfRA/C0eWOE+BShE+
 EJ/3BMYLza/uGjMYIHYKc9ZpqIgf4Zr+vVSpouadjqDGrn7jPqPTqpjwV9xdWJu/Hl
 +3hwZb9piUMULlulyYKfv07egsPIpXjN9VmEMDQOUmTiOviL6TavicIY56/D+Alkc3
 HHicKFCblhIhCu+2a0deQf98c0SEp33KFvYCzYev6gfPD5Ju/2ZWymv8VnY54A5I7d
 o7aMmgNL4mm//90m3byAzgCuKvcmcHiqfqiA3SNEPPpe75BrbeXPe5XT1j1aCZKY6d
 xAQGc2suYu89Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=KLcUdbBk
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 8/12/26 1:01 AM, Fabio Estevam wrote:
> Hi Quentin,
> 
> On Tue, Aug 11, 2026 at 8:55 AM Quentin Schulz <u-boot@0leil.net> wrote:
> 
>> Ideally, we should be able to automatically detect whether it's a
>> roc-pc-mezzanine-rk3399, but I couldn't find schematics for it and from
>> the Device Tree, there doesn't seem to be something we could use to
>> detect it like we do for ROC-PC-PLUS/ROC-PC. So instead I recommend to
>> check for CONFIG_IS_ENABLED(DM_I2C). If it ever gets enabled for
>> roc-pc-mezzanine-rk3399_defconfig, the logic will return that it's NOT a
>> ROC-PC-PLUS and thus use CONFIG_DEFAULT_FDT_FILE which is
>> rockchip/rk3399-roc-pc-mezzanine.dtb which is correct.
> 
> DM_I2C is also selected by roc-pc-mezzanine-rk3399_defconfig.
> 

Yes, but it's missing SPL_DM_I2C.

> We can use SPL_I2C to distinguish, like this:
> 

Unfortunately, we cannot simply rely on SPL_I2C as the function is only 
implemented in i2c-uclass.c which is only compiled when SPL_DM_I2C (and 
SPL_I2C) is enabled.

There's also an issue in the dependencies for SPL_DM_I2C and TPL_DM_I2C 
as they both depend on I2C (via the if at the top of 
drivers/i2c/Kconfig) and DM_I2C while they should depend on SPL_I2C 
(respectively TPL_I2C). I'm not sure why they depend on DM_I2C as it's 
for proper, not xPL...

TPL_SYS_I2C_LEGACY depends on !SPL_DM_I2C but I'm assuming it should 
rather depend on !TPL_DM_I2C.

Same for SPL_DM_I2C_GPIO, not sure why it depends on DM_I2C_GPIO. 
SPL_I2C_MUX also depends on I2C_MUX, for what reason?

VPL_DM_I2C should depend on VPL_I2C but it doesn't exist, so we probably 
should just remove the symbol since it won't do anything as is.

None are a blocker for this series.

> --- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> +++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> @@ -68,6 +68,9 @@ static bool is_roc_pc_plus(void)
>   {
>          struct udevice *bus, *dev;
> 
> +       /* roc-pc-mezzanine-rk3399_defconfig does not select SPL_I2C */
> +       if (!CONFIG_IS_ENABLED(SPL_I2C))
> +               return false;

Please add a newline after the return false;

It should be !CONFIG_IS_ENABLED(DM_I2C) as CONFIG_IS_ENABLED is going to 
add the appropriate prefix based on the current stage being built (so 
definitely no SPL/TPL/VPL to be added manually) and CONFIG_SPL_I2C is 
not enough to build the dm_i2c_probe implementation, we need 
CONFIG_SPL_DM_I2C (well, and CONFIG_SPL_I2C because otherwise the 
drivers/i2c directory isn't traversed and because SPL_DM_I2C is missing 
a dependency on it).

Cheers,
Quentin
