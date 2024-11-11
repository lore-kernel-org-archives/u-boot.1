Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DEFD2E9DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 11:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188408936B;
	Mon, 11 Nov 2024 12:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731326230;
	bh=uZBuJi5i9vr1D+mlvdAP0dQPX+heIPmhSST/j8WsDa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GFqcc4NUOP3xsV7DmpjAPmLLalRl+8wjPujVfFHxOQBkhjN28FaCE0jYWxRAz7Dgb
	 fbdkqbVcRtaRJE41CYHUF+XUQ6c+/0sRvtp5m2rTO05+LmsJSlzSkx1ux7GkskpQVj
	 amhJXpb96RfZCJiURnNRjUogo94gycUZm5jcZk5KwABLdgvrYL05orT0jsxS5BNflS
	 V114C9AHxmhUmCwDEEWQTuyx/3i5kWk966T5Zqt0/ASvlMB+XmTGZNVjNhBRkmLpuq
	 IlOhTw168xjjyqTxC1IbXvZgTTD9n21AfGFD9/uxsEGRKBOmC+tZOxwjEbBpKT3D7e
	 MISbvUzmrNEKw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E62E38919A;
 Mon, 11 Nov 2024 12:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731326228;
 bh=uZBuJi5i9vr1D+mlvdAP0dQPX+heIPmhSST/j8WsDa4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Hjv3XpfjcI3iBDxb9YWhVZZiw3o/L4yZv7b5EYlc//W97PlWv81chBCzdfxpJcLDp
 ZZy7apOb5dUCymt4YMMiIxjzPX53NtIe8rOM/VJQ4FfQRNENIhA1TFXvjstzHcWhCB
 C3iOQvRab0JenOSDw/idhHuTXMdc8+gRPNUbCseMZy7JgSMVN7OxhOtwRSYTIwglbe
 +jFXy8fKQ+wCPpzNiPXHUifKLD7IXoxfz5lKx+gCAtRKRpTkANZDUptez2uGjvKzeY
 Ir9IQ2qUhARZrBeuR5rrP4fnlCoxcuG7hnPI2XR8uQzLwcuHpxgAKLmAU1xg+Y6yh6
 3tjqs/TqY2DPw==
Message-ID: <62f78783-99f0-4f81-bc71-c28bfe5fe9aa@denx.de>
Date: Mon, 11 Nov 2024 11:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, lukma@denx.de,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
 <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
 <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
 <187dd32c-642e-4595-a90f-4213fd68f6cc@denx.de>
 <CAHCN7xL1Cp0kkmo3bTPRsKPaqbQFqTXu7spgY2LjOYU0FS3heg@mail.gmail.com>
 <33d0df3d-afff-4cbe-8383-ffb33edb01a6@denx.de>
 <CAHCN7xK7Z8TPLqFRfie2TCfND-4_u2wbds4a9M=x8ocSh_JTwQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xK7Z8TPLqFRfie2TCfND-4_u2wbds4a9M=x8ocSh_JTwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/11/24 2:46 AM, Adam Ford wrote:

[...]

>> I am hoping Simon could offer some input here ...
>>
>> Can you try the attached diff on MX8MM (use "git show -w" to view the
>> diff better) ? It will generate two files, flash.bin and flash-fspi.bin
>> , the later should have the fspi header and maybe even correct offsets?
> 
> I reset my branch to to U-Boot master from wedneday a7a96a37cbd8
> "Merge https://source.denx.de/u-boot/custodians/u-boot-riscv")
> 
> I verified the FCFB header is present.  Unfortunately, when I burn the
> FSPI on my 8MM and attempt to boot, nothing happens.
> 
> However, I changed the "nxp,boot-from" parameter to "fspi" and it booted!

Uh oh, look at tools/imx8mimage.c and search for both 'fspi' and 
'CONFIG_FSPI_CONF_HEADER' . I have a feeling that building with the 
CONFIG_FSPI_CONF_HEADER changes mkimage -T imx8mimage behavior, which 
may even interfere with binman.

Can you try and remove all the CONFIG_FSPI_CONF_HEADER stuff from 
imx8mimage.c , so it doesn't accidentally generate FSPI header, but 
keeps the fspi 0x1000 offset ?

> U-Boot SPL 2025.01-rc1-00168-ga7a96a37cbd8-dirty (Nov 10 2024 - 19:27:21 -0600)
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> SEC0:  RNG instantiated
> Trying to boot from NOR
> <snip>
> 
> I looked at your patch, and noticed your FIXME. Once we get the code
> working, we'll likely need a way to pass the header offset, because
> it's different between Mini (0x0) and Nano / Plus (0x400).

Try and add offset=<0x400> into fspi_conf_block {} for MX8MN/MP .

> I'd like to suggest we #iifndef the section filename where "flash.bin"
> currently sits, and remove it if we are building for flexspi.  This
> way we get what you originally requested, which is a single binary.

I was hoping we would be able to generate both SD capable and FSPI 
capable boot blob at the same time, maybe we can even do it with one 
binman description.

> I have attached my diff file, so you can see my proposal. I am happy
> to test either Mini or Nano, but I am traveling this week starting
> Wednesday afternoon (US Central time) until Sunday night, so I won't
> be able to test in that window.

No worries

> Let me know how/if you want to proceed.

I suspect a patch to imx8mimage.c to remove the fspi stuff would be 
good, and then DT changes are also fine. I am not sure about the python 
part though.

> Thanks for looking into this.
You're welcome

[...]
