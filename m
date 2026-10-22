Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86BB606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KFVsb5cg;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ihiA2EjK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1F496083E;
	Thu, 22 Oct 2026 07:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sr_SL5gNcU9j; Thu, 22 Oct 2026 07:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49DD06081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654912;
	b=joce5z9oLTF9vZ8FziapzZ18S65mMErxUCHWkaRX8L9JUiteJZYhA4EAjhs4LlLu4twy
	 COR9Khr0AKs3MWvsSTxxwRSQZ0meCdbXhDukbumVVlDM0Xk/ieuL+q264uKysIy2RQRf8
	 YOS3AHfdhTzFZPu2AkHfkvBq06a3a4M63lUhM1spbMN9kFnqoM5UEEmHSUCBL6bNk5ppk
	 nMwi6hQZwzDrVBNrQx26mUvMdyMZ+xrUlYMRcbI53px72f9KrryJtAWIDdZqnlQQ8Cx0I
	 n0bY/PfSzDwb6zrkzROhzoZh/9lUwQfbRHWhRuwAGiHLBXesytO+4XHulUvSvtuV4lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EgtuPhEjMc/zrNZ8PQagp8j+7HRX15lP4FjrtJsUBbM=;
	b=EKekVqrUIFNmMMcH8OiHoKC63fR7xwc2btboZkbqLb/GxXHWu7IyWhPfJlFvc7rl0qCy
	 P3BiH/6QJlupJzPrUOMJ1Qi5/UZ7yFOLpp3dGahmPGL06pfWQ6LmeLX5Of5QfAkDZeoKS
	 nKMBXq8Tu5FiGrT+kClipG2VXnFXxgWqJHne/z2VPz5gAkoDdk2q/nZjcl/rkeb9ROM6/
	 Ud+wxWIDldpDpwjwX/6CyRC5NtXI3GDw79bGV0u7GLKuIvRSm9JN/Vk7Gpci6W3ENaBIq
	 /zOLX1jRtkv0NZP2XAwyQoSZ+VOzHJyI//cAIF726GQSugv4yGJi91+AWpmoN1GMV8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654912;
	bh=EgtuPhEjMc/zrNZ8PQagp8j+7HRX15lP4FjrtJsUBbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFVsb5cgQT2bG3QD5LlZdFWZHRjxY2QS4bMTkjmz5Ztr/XEC22rkKDRXnliy7IJ4s
	 WvqjeJnN+Bjw/FZuoHIhjq5pEUIUvwemPsklRNrTRFFz8shNaXH6bopMlcQHFoso6k
	 EDBUvpEBIhxXq+XsksITElYPrh00+57j4FpC04ycXQCW8kaTB76haumQTVmZYpRJPC
	 i4lzL2vRGps6c4mgdqRU3OMR5nYf4KRTl3d7zuBSD2Akh4Jeaj41zA2NbGJALNLJyf
	 CoHbmUJjNNZ8BAVJ3njpxjTtkhJY1HCHWX3mkYoaMVr1uXA4eojguq3WxZzBcmwYDG
	 jmeFmH4hdBniw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49DD06081D;
	Thu, 22 Oct 2026 07:41:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15BC01AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1292340050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id znWKLA9u829c for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:41:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 834CD40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792654908;
 b=INnXtyvckVX/oP4GA80NHelPqio9R1VMXJ2Pk8g3cqxxxDzY1PRw1WjZRfrcecCfnrdp
 7q3TsZFS0mV329WVaHsI9Zm1rzDw5ajYHKzBFfQyUc1YUgNF9Jx2VkOOj0XaeTSPI/ADb
 8D6wl9MWNE0497Vf+fr8kMsrGtnUdVvrDSvlkTxtocXZ002Uj9EmwAzqi1YouieKRzki1
 vLh8B89q2ItOsv1+R93HkIIay2cAEXcHVdmtMB0uMQs6ARnyuuT2zs7dLkL4lM0o+eMm/
 TLnd7sgflRntjPqWrnzq95OZZdYoEGPc1O8KVIUL8Fdx4IZLEy0EzAcd+7ShkmoT9GA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792654908;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=EgtuPhEjMc/zrNZ8PQagp8j+7HRX15lP4FjrtJsUBbM=;
 b=WsMb/lH7GQTcMf/0EcE1AT5JVHaWjRId5aDCu4PwmA/bUlrw4M4BpG6ygtjLHFOu4Ud5
 gyAx6TivWjoOMuCHEL2w7LY75VlUmAbM7oDXNYC22+wv8PEY+c7qOVPdS4imhM250IzqQ
 M7urATO86Z6LoTO6I/0146v8KeZXEikDRFJ0PeZ/38c6bFg21D9Fs/52ls0mO02Zg5Ckh
 BZ09lu5xVZqBgGn9Wnlv0YEcKr2eZlQH+oNsli18AUJf0iYapbUJJmr0mMY9pHcJ/YwCA
 4xl7CcYbybFMMZA3/aKzq7uaHDOmVniDtDOWBwSxHpA39r75/CnZUixp6/r6mwkFbHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ihiA2EjK; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ihiA2EjK
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 834CD40042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792654889;
 bh=EgtuPhEjMc/zrNZ8PQagp8j+7HRX15lP4FjrtJsUBbM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ihiA2EjKNTuIJQRyiE4BRQzTo2H9goVNncS28s/85kV6/qjUyNngKFLPgx8qJFu0F
 SfvwRAV6oQ0newipmfErd5NKKwaMvFPjJlr71M0UFXN0gWAPJN66bRmrz5qGxBxUAa
 2SzJRrWwlIiXKHDh0WUxyCO2/7aRuw//PycOCixHjZ/nW1Czb9E9jpoe/V24WyRW1I
 698+P/UGWL0zSgn1UaFvWv1ygbdy+h9pHswyhzFfR/RikcHQuXaHZpuoXQWlWpg4ZJ
 3etaQ0JQC76SwoWEwYhJTzzumV/nhiRdR+UET6KMLG9BgMadKhu6Rb/0vSXzCQrGXA
 6QkUiJzzYr2VA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id DB476B22001A;
 Thu, 22 Oct 2026 09:41:28 +0200 (CEST)
Message-ID: <ed97f914-cdd0-4dcd-bf4c-7b8a10f8bb5e@freeshell.de>
Date: Thu, 22 Oct 2026 00:41:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: spacemit: k3: enable mtdparts on Pico-ITX in
 main app
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-3-e@freeshell.de>
 <20261021075605-GKD65567@kernel.org>
 <d0ce354d-71d0-4dab-9725-70e06998df2b@freeshell.de>
 <20261022005754-GKO26088@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261022005754-GKO26088@kernel.org>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On 10/21/26 17:57, Yixun Lan wrote:
> Hi E
> 
> On 07:35 Wed 21 Oct     , E Shattow wrote:
>> Hi Yixun,
>> ...
>> Let me know if you do yet prefer the bus address repeated for the name
>> of partition layout. I'd like to see this as part of a runtime-generated
>> mtdparts configuration, so anything is okay with me for the initial
>> manual layout here.
>>
> I've done a further check.. so quote from <uboot>/cmd/mtdparts.c
> 
>  * mtdparts=[mtdparts=]<mtd-def>[;<mtd-def>...]
>  *
>  * <mtd-def>  := <mtd-id>:<part-def>[,<part-def>...]
>  * <mtd-id>   := unique device tag used by linux kernel to find mtd device (mtd->name)
> 
> from kernel side, check file drivers/mtd/parsers/cmdlinepart.c which
> has the same format, on the linux console (if no mtdparts enabled)

Have a look also at comments in Linux function atmel_nand_attach_chip():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/nand/raw/atmel/nand-controller.c#n2008

"We keep the MTD name unchanged to avoid breaking platforms where the
MTD cmdline parser is used and the bootloader has not been updated to
use the new naming scheme."
"If the new bindings are used and the bootloader has not been updated to
pass a new mtdparts parameter on the cmdline, you should define the
following property in your nand node:"
label = "atmel_nand";
"This way, mtd->name will be set by the core when nand_set_flash_node()
is called."

The examples I can find of CONFIG_BOOTARGS in U-Boot source tree are:

      1 mtdparts=mtdparts=atmel_nand
      1 mtdparts=s3c-onenand
      2 mtdparts=1550000.spi
      2 mtdparts=1550000.spi-0
      6 mtdparts=60000000.nor
     45 mtdparts=atmel_nand

> 
> # cat /sys/class/mtd/mtd0/name
> d420c000.spi
> 
> so with bus address it's able to support cmdlinepart, although we
> currently use ofpart, but IMO, it's correct and in case people need it

Yes, although I will be clear to say this is some form of Linux
dev_name() and not the bus address, if that is yet a correct thing to
say. I'm only sure to confirm what you describe by running a build of
mainline Linux kernel with this configuration. For example:

# With StarFive JH-7110 SoC and mtdparts test Linux kernel
$ cat /sys/class/mtd/mtd0/name
13010000.spi.0

# With SpacemiT K3 SoC and mtdparts test Linux kernel
$ cat /sys/class/mtd/mtd0/name
d420c000.spi

If mtdparts=spi0.0... is on the commandline then it is not matched. Else
I use instead of spi0.0 the form of dev_name() as alluded to in the
mdtparts.c code then I do see the partitions appear in /proc/mtd

I would like to make a more exact description of where in mainline Linux
code that causes "d420c000.spi" (is this exactly the dev_name? and from
what code?) but it is at least enough for me now to confirm the effect
it has in testing and how to get this outcome without guessing.

Thanks again, and I'll send the requested changes shortly,

-E
