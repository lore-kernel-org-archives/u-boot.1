Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CB8D2F7D7
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 00:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DD188E43;
	Thu, 17 Oct 2024 02:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729124686;
	bh=zy6Xe+Tosn7fu0i2WWjUUi/eF4/VMc7tUjlp+YHzLkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hoi1bg4+nNct8UUwxD5Ne8JUu9SwNm3YNvTTo5trXQmgUC6TQaDL+rnDes73YKAzm
	 kge7YNo52gmOTOAquYNXJSOrUwylVGuNbW6wXQ2Oh7nQ6ooKzRFrKKHRBZsf+3rRLR
	 EPAKtZMdshpT5cEJAxCEMWUvuhnGDRJuP9PlMhAAMHqylcQHyeCmMOlyeC7CA428su
	 HVDaEBljgJmczyTfPfkKbp9Y0PP9rzwDHqpiFBASLe1wS7mlegtQ49u0IHCKYTzikS
	 SqiZ1WY+m9iW7h7DQ9b2sv+ym2udnOJTSQArxwlpE1XXyM7txLXn+Vz965FIpxNkEo
	 l8jrZ7FW7xHeA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EDE4388E21;
 Thu, 17 Oct 2024 02:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729124685;
 bh=zy6Xe+Tosn7fu0i2WWjUUi/eF4/VMc7tUjlp+YHzLkc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bK58j7Tvfnn1aL2ZdZVaofTcvL5IHdvQomISRgC9nwlcA9p766WybkiTVqOS9Iseh
 mm7yfyXbur3wid1yVdH6SoNSh123vkNudxs0VFoZH37NdxYfTvGVWJvI0f7AY0lRNT
 WFOUHscUL5LTd8QFGH7iPFhLGr2BOvOGlokHg7TAGMZCExxK8783wcIsee505soH+s
 DcNBsyfgyIm7i9J9SOsNtCdd39hoKZESiB5aMfnBYt20W/hkZqCbrdp4AKOs+alesV
 1GunzwP7NzucBEzE8dkJuD0f22IKnbe1WHzNIvuTmiZ5sBLGFKxf0TD/RPNzjgEahj
 VRasyLL6LgkRg==
Message-ID: <26054b3d-c86c-458d-ba23-11f49843787a@denx.de>
Date: Thu, 17 Oct 2024 02:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Add script to install U-Boot from SD/eMMC to
 SPI NOR on DH STM32MP15xx DHSOM
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240930192343.59359-1-marex@denx.de>
 <dc0a0638-0724-46d1-99c7-ee8b84e5541b@foss.st.com>
 <92a9153c-c948-43bb-8542-163ec245c74d@denx.de>
 <81cabd9f-2c4b-4b1f-a15b-0830b75a3df8@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <81cabd9f-2c4b-4b1f-a15b-0830b75a3df8@foss.st.com>
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

On 10/16/24 7:59 PM, Patrick DELAUNAY wrote:

Hello Patrick,

>>> b) you are using "sf" command and not "mtd" to udpate SPI NOR ?
>>>
>>>
>>> the MTD command allows to use the MTD partition name, defined in DT,
>>> so no need to know offset in script (and avoid "sf probe")
>>>
>>> mtd erase fsbl1; mtd write fsbl1 ${loadaddr1} 0 ${filesize1} \
>>> mtd erase fsbl2; mtd write fsbl2 ${loadaddr1} 0 ${filesize1} \
>>> mtd erase uboot; mtd write uboot ${loadaddr} 0 ${filesize}
>> Can you also do 'sf update' alike operation with 'mtd' command? I 
>> don't think you can. The 'sf update' often does significantly speed up 
>> the SPI NOR update process, because SPI NOR erase operation is very 
>> slow, while SPI NOR read operation is fast, so if the update can read 
>> and then skip many blocks which are already in the SPI NOR and erase 
>> and write only the changed blocks, the update is often very fast too.
> 
> 
> Good point....
> 
> an improve place for MTD command
> 
> I will try to propose something for mtd command
> 
> 
> and for the patch
> 
> 
> Applied to u-boot-stm/master, thanks!
btw look at doc/README.dfutftp , I use that to update R-Car boards which 
also require multiple blobs at various offsets in HyperFlash (HF behaves 
like a regular Parallel NOR). I can generate a fitImage which contains 
the blobs and their offsets and then run dfu tftp to download the 
fitImage from TFTP server and install the blobs automatically.
