Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E45C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 09:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F31E80E3F;
	Wed, 22 Jul 2026 09:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTMtboDir-P4; Wed, 22 Jul 2026 09:16:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5043380D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784711791;
	bh=fftjMuH9u0zyjSpQBZn56PEV39d40uBRvRBC5G/TN78=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RGIi8nMOXD7OLGAy9adgMeh/1a1NuTfAZnnsCoRRV6mJzh6/6XOD+NO9WYAcjRvGy
	 U45CNj3nNKK2O0UyIZOhAqqJTqyLXdSv4JzwHSM6QzNw5OQFQ5m1G5711xg+NGfJA6
	 XFp5AAi1nKxlAEYIptLpUQdzcoxiJYaXwq/ejH0NfKcZ46Baq0VCWU8i69qmXpNHz7
	 +ZJKTXyrB98rMxyqSkCkK0rHrXym49jSQZNSwnEAyoabs0uN2+sC3NCcDu2ILqiJ+U
	 50z38rGRUwC16zi2t5EUmOoXAVKh+U7LG/7QWburNb4Th+so+ve4oMU/KLnoHYdqSe
	 VsYQ6SoqRKRSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5043380D4F;
	Wed, 22 Jul 2026 09:16:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20A73224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0045980D4F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YiCwHQUxgZkS for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 09:16:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B5CBA80CB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5CBA80CB1
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5CBA80CB1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:16:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FF1848BA; Wed, 22 Jul 2026 11:16:26 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AAF803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:16:22 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698c1df9651so1804920a12.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 02:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784711782; x=1785316582;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fftjMuH9u0zyjSpQBZn56PEV39d40uBRvRBC5G/TN78=;
 b=FZ1KiCpDQSv2YtNDZux86o8eeD2fwzhkVg0cl5bk5Tc0nNC+kVpTMR62589GFuBQtK
 jnL9crHfqeGNFryJJ0/YQYtska2KV42LkWF7cW26EZ3bZEuih8RxCiQb0XNh5/37sI2m
 9sO32cTeWiP8XCOcBLd3QrXXZfZVETDenwMXYQ/2T0d6+TlWX9WUOUTcpHHuWxO5KLye
 xO5pEDn84E5ewj8zgrdK67rFu8UBc0tB3q0ZH161ZopXvydvcUPreCxwDPbZiKiqdA0H
 nsBRMC7O9EZA9UeXr5BrEd0np94kv2/T/IE1EoMy1A0UwBT+RXwUINPJEIq9uPhIcCfS
 k3CA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNq2cCMY0PMHoMzcw3UpSBmWi8Z+VqpFQ2Xr9K1q/vkwKIuka4XfVh7tSsIrdu2nXx3UGV+yQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzaqPse4SGM/E4rND/BTVZBjozaKOFJFiZ80skmPAdt8GMJcXh2
 OtoXB7p+qncAmhF46VpwmkcsrxTG5ZuAluTkXhdZjpbB1w7C8Op1598t
X-Gm-Gg: AR+sD13akbQW74s+0mEQi5Rfii46HHo35vGjx875EOOa6kNNaxtMRVx0qsKJMhIfEPs
 QAwrMMqZ2sMoAEkWOHo/BQirqkEnmgq0dTsQ4DdKb60UhL2Uzf1PfxaT9XeZVl7MYI5z6Wx/00F
 Wn3Wp0KFQSCwGOuWacBuElKGeWybrVwzUIk7oQoBrH6YRjX16NOg5xUZ3LZ/pwUcdPqWo9Bk7gn
 c9yUk24M5xM0wZE47q3hZ3H6NRYNwH1m/EaiTGwTKHwFed9JONyNzFeNjbhO+m2dPfizntfiT+F
 XIz9e1lbQTsxF+Biyvdkm5t+V4B43/dXrA3Av8fSqUDj+Y8jsxiKe7ORRFKIm/QYrl+rHV50ePD
 uJbYJD+h3qBPYu+Af9Gtjh+OSR2UC1a4A6wJIY2Qwxah+//PZvb4TFclmV9uEqInk0KHgjqU2VY
 3bh3Kjh7gthcivDYXTAXKoG2UB8eZlXGwA8THCU2n1
X-Received: by 2002:a17:907:1ca1:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c1c32f38df6mr73874366b.3.1784711781356; 
 Wed, 22 Jul 2026 02:16:21 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f13123sm73723066b.59.2026.07.22.02.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 02:16:20 -0700 (PDT)
Message-ID: <fdb929d4-19f9-4aad-ae2d-9d15e2552242@gmail.com>
Date: Wed, 22 Jul 2026 11:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: raw: rockchip_nfc: fix ecc setup
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de, quentin.schulz@cherry.de,
 boogiepop@gmx.com, Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at
References: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <de3c0d84-8490-4bc9-8702-12c060eeb329@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784711782; x=1785316582; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fftjMuH9u0zyjSpQBZn56PEV39d40uBRvRBC5G/TN78=;
 b=lAsErNSyh4WKxDAqANP3DycbyOMj57MndgpRdKdZqN1L57tQE0We/Mok8z47bKR3Dg
 1hY3rOS8kxPT8fjwZLe8SP9qlTsjebPc91z+KIa2bIQOYR0ku66OfWmwo8LLFfhqlrC0
 9b/y6YzNgyk7EWbRIJOKEv2rtUfjBUpmeKj6aoUf0wpgpfwbcrZV0Hm7tkXySJlJkhcG
 CqLoGlA5VvYftUMudaZdxvWXC0VZ5vrvIDXFcTInNDgLhUtturSuuviPPJX3XBUfXDdl
 wV9OfBP3b2bd2KUTqkfBc8tZHT9dy/30E7eOtyNj/wWz7XWwKACX/X8asaDG1dCfQLMB
 nLHw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lAsErNSy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jbx6244@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lAsErNSy"; 
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
From: Johan Jonker via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Johan Jonker <jbx6244@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Changed References:
Added Linux MTD maintainers. Question below.

Hi,

On 7/22/26 00:56, Boogie wrote:
> Hello Quentin
> 
> I had reported this bug to Johan so i can give detailed explanation.
> 
> The bug was really the lock of "&& nfc->selected_bank == 0" not existing for write_page_* variants.
> 
> When rockchip nfc was reading, it required bootblks to be a part of the first nand chip only with the condition "nfc->selected_bank == 0". But when writing it interpreted 'all' nand chips first boot_blks as boot blocks.
> 
> The practical problem. I had mentioned this in V1 and give more explicit details here.
> 
> I have 2 nand chips, and a partition (linux below) starts in nand chip 1 (CS=0 in below) and ends in chip2 (CS=2 below). And i am using UBI on top of that mtd.
> 
> nand@0 {
>     reg = <0>, <2>;
>     label = "rk-nand-0";
>     nand-bus-width = <8>;
>     nand-ecc-mode = "hw";
>     nand-ecc-step-size = <1024>;
>     nand-ecc-strength = <40>;

>     nand-is-boot-medium;

This property was introduced during review, but can't find the reason.
https://lore.kernel.org/linux-rockchip/20200426100250.14678-1-yifeng.zhao@rock-chips.com/

>     rockchip,boot-blks = <8>;
>     rockchip,boot-ecc-strength = <24>;

Describing 2 nands with 1 node also exposes properties to a second nand that result in reduced ecc strength in both.  

> 

>     // block 14 - end
>     linux@1C00000 {

The binding puts the partitions under 1 nand node, but says nothing about a partition across 2 or more nands.
Could the MTD maintainers inform us the support status of this 'feature' in Linux and U-Boot.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mtd/mtd.yaml#n39

>         label = "linux";
>         reg = <0x0 0x1C00000 0x3 0xFE400000>;
>     };
> };

I would like to produce a patch with "&& nfc->selected_bank == 0" for Linux.
Not sure if they are willing to merge.

Depending on the output/feedback put this patch on hold till I know more.

Johan

> 
> When i create the UBI volume the middle of this partition where the blocks are at 2nd chip block0-7, will be written in boot block strength [ECC:1024/24] but will be read with normal strength [ECC:1024/40].
> 
> This causes first UBI creation to be successful, and next scan to fail due to written strength is different that read.
> 
> You dont actually need to use UBI at all, any time you write those sectors, you wont be able to read them. A workaround it to mark them bad, but this is not nice, since the blocks are completely fine.
> 
> Rockchip NFC technically as minimum needs to know rockchip,boot-blks, & rockchip,boot-ecc-strength props only. Currently the checking condition is rockchip,boot-blks & applied affect is rockchip,boot-ecc-strength.
> 
> The bug is this is only applicable to first chip not all chips.
> 
> NAND_IS_BOOT_MEDIUM is actually coming from mainline linux. Similar bootrom tricks are also available in other socs. And detection of boot rom blocks is not always straight forward as rockchip's rockchip,boot-blks, they have to do some "if" case acrobatics to detect those. For simplicity reasons mainline linux introduced a global flag NAND_IS_BOOT_MEDIUM and it is applied to other socs as well.
> 
> Since this "&& nfc->selected_bank == 0" fix is exactly at the same line with mainline changes of NAND_IS_BOOT_MEDIUM check, i think Johan also integrated both at the same line.
> 
> In u-boot only mk808 is using nfc with boot blocks and it is already marking the nand device as boot medium, so the code change should not break existing devices.
> 
> Additional note: Linux mainline also is lacking the "nfc->selected_bank == 0" check, so i think similar patch should got to linux as well.
> 
> @johan if anything i am missing feel free to correct me.
> 
> hüseyin
> 
> On 7/20/26 20:25, Quentin Schulz via U-Boot wrote:
>> Hi Johan,
>>
>> Resending because the ML rejected my mail sent from my other address...
>> I have to figure out what I set up wrong to trigger the spam filter :)
>>
>> On 7/14/26 8:39 AM, Johan Jonker wrote:
>>   > The Rockchip boot ROM only checks for NAND chip 0 and with
>>   > reduced ECC strength. Currently only the read page functions
>>   > have this condition check added.
>>   >
>>   > Fix by adding the same condition to all read and write page
>>   > functions by dropping the existing 'selected_bank == 0' check
>>   > and use the NAND_IS_BOOT_MEDIUM option that was introduced to
>>   > U-Boot more recently than this driver to behave
>>   > identically to the Linux driver.
>>   >
>>   > It is now the users responsibility to apply the device tree
>>   > property "nand-is-boot-medium" to only NAND chip 0.
>>   >
>>   > Fixes: b12dc5d6fa76 ("mtd: nand: NFC drivers for RK3308, RK2928 and
>> others")
>>   > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>   > Tested-by: Hüseyin BIYIK <boogiepop@gmx.com>
>>   > Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> You don't explain how the bug can be triggered. It'd be nice to provide
>> the usecase when this is an issue so that other people looking on the
>> Internet for bug reports could somehow stumble upon this patch.
>>
>> I'm thinking the issue is that we currently verify all NAND chips use
>> the boot_blks and boot_ecc from the boot medium whereas they might not
>> be used as a boot medium (they are missing the nand-is-boot-medium
>> property) so we cannot actually make use of them. Is that correct?
>>
>> Considering boot_blks is 0 if rockchip,boot-blks property isn't set,
>> we'll never be able to meet the page < pages_per_blk * 0) condition
>> anyway so we would never enter the if block... or can page actually be
>> negative????
>>
>> To be clear, I don't disagree with the fix, I just am missing a lot of
>> information that should be in the commit log.
>>
>> Cheers,
>> Quentin
> 

