Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28EBC2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 10:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECED884AC;
	Tue, 25 Jun 2024 12:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="m7urWdNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 891FA8845A; Tue, 25 Jun 2024 12:25:09 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88964883CD
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 12:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1719311106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNPH3eqbTwm0xWX+zyyAa5tvbg3IC77QWA9/arhFsYM=;
 b=m7urWdNoc4Y44Yy9hiaKzYhXr7Rwyq0K7jche9ydH5rY1MxO33i8iIdZvN2vyeSn48R3n+
 3Cjl5I165BqNt9rUPYS+BWIN+rma93ZKFpTwUOdgXTtJuDnptNnFE/4YV2bnAR7m5iyvuT
 GpdM8a0iVS/7T1WUHjpSTrfvZpnrug6a6kfNiRka3Bpww3rz0zYNnFa1ejg2ykuaqA5eIV
 FXaHPkvb81a90k4vBpPWfY5Zhu+l+v9K5QkH4BgJhMFvuSkYg9nEroxwqgzixmvYZwVNUa
 mg1gtXsfre6H8W+INh7bKYxW4ljVMk04J1zZRYl+HrxkFV6rLbBlsFSO65KnOg==
Date: Tue, 25 Jun 2024 12:25:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>, Ramon Fried <rfried.dev@gmail.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, u-boot
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
In-Reply-To: <f8be5725-e8a5-454c-82db-4aaeb293673c@cherry.de>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
 <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
 <f8be5725-e8a5-454c-82db-4aaeb293673c@cherry.de>
Message-ID: <a7dbf00b11304f80cacd5821a5e19127@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello,

On 2024-06-25 12:03, Quentin Schulz wrote:
> On 6/25/24 8:38 AM, Etienne Dublé wrote:
>> Thanks for reviewing my patches.
>> 
>> Le 24/06/2024 à 15:08, Quentin Schulz a écrit :
>>> [...]
>>> 
>>>>   1 file changed, 11 insertions(+)
>>>> 
>>>> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
>>>> index 93e83661ce..b30d51731f 100644
>>>> --- a/drivers/net/rtl8169.c
>>>> +++ b/drivers/net/rtl8169.c
>>>> @@ -1091,6 +1091,16 @@ static int rtl8169_eth_probe(struct udevice 
>>>> *dev)
>>>>       return 0;
>>>>   }
>>>>   +static int rtl8169_eth_bind(struct udevice *dev)
>>>> +{
>>>> +    static int card_number;
>>>> +    char name[16];
>>>> +
>>>> +    sprintf(name, "RTL8169#%u", card_number++);
>>>> +
>>>> +    return device_set_name(dev, name);
>>>> +}
>>>> +
>>> 
>>> I don't think we can guarantee bind order so this may not be stable 
>>> over time.
>>> 
>>> I'm wondering if there isn't a way to use the "ethernet" (ethernet0, 
>>> ethernet1) alias in DT instead?
>> 
>> Actually the ethernet interfaces are not declared in the device tree, 
>> only PCI buses are (at least on this Nanopi board).
>> The ethernet interfaces are only detected when running "pci enum".
>> 
> 
> Ah shoot.
> 
>> Another option may be to name them "rtl8169@<hexa>", with "<hexa>" 
>> reflecting the PCI region address (so it is unique and stable). What 
>> do you think?
>> 
> 
> I guess that's one way, I'm also wondering how systemd renames those
> to be unique but stable on the same machine, maybe we could take some
> inspiration from them for that?

Systemd also allows renaming of network interfaces using some rules
predefined by the user, so there's also the possibility to rename the
interfaces in U-Boot to ethernet0 and ethernet1, using fixed rules
that would be based on the PCI region address.

> FYI, for NVMEs I also have
> /dev/disk/by-path/platform-fe190000.pcie-pci-0004:41:00.0-nvme-1 for
> example. platform-fe19000.pcie- being the pcie controller at address
> fe19000 on the platform root bus, no clue about what's after that
> though. I also assume the N in nvme-N isn't necessarily stable over
> time but whatever's before should be? Maybe there's something like
> ports/addresses on the PCIe bus that will never change or rely on
> probe order/timings to keep a stable naming?
> Sorry, don't know much about PCIe so cannot suggest anything meaningful 
> :/
