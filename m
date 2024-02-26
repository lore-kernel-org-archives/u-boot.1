Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3EFC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A3D87F04;
	Mon, 26 Feb 2024 14:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708954591;
	bh=UEnZBE/FxkLv/EOrYXIIlr1QWC4+92dFlOcwsv7QcTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dN3BamPnVVy0H8fRIYA/4ft5VVgt49bSAB9J2uNx5OizBzzzlXCrCSj1/2qJcvNSv
	 uManZbQIbJGfD2aHxUWEvJPg3tfumZm2Vk3X2TMdIZeLi4fC7i4dzAesTLVFPxjWBJ
	 MmMmCIDyKLu/FZsP1d3uYUI4+4PhYtq9FUGnb524y5Sp1AeJeB43jPZJH9PsX4dJ+Q
	 X+B3uKFgmgvqN17rhlrXGi3PgA1ucx1AnP/tX7G6AjwJd89/AdGzXw8oLgQWOhYFw8
	 cKbd2ZX92nQKwbfALE6jMXrDhoVrU69MzU1Tci5Vmro2EXmKQgHzjQks7HUwwOy7xQ
	 QMKzWU3kl6+dA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3726487EED;
 Mon, 26 Feb 2024 14:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708954589;
 bh=UEnZBE/FxkLv/EOrYXIIlr1QWC4+92dFlOcwsv7QcTU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sBJFbvoXtxtMMavRVyNsu58JsJg1Jqi5PNiIvEWFlA6NwrKxJELymPEP7Rzn1FBTa
 +V4cPIL6JrJTWtwepEcvk139TjRnLeen1/tr6iNsMm4d3XI/2++ioAPFC/+9erWSZ8
 xSWY88GDYGxc+j+EKrsOTCk04QexB7pEfT8bMnrzT/fWVhhcwqsXbg85BoaZKg2XUp
 VIOfQkJW5ydIi5qH/M3PsR27dR/pSLC2l4paTXKfGhK6+mLPdt0hNgCa1+9SAepTco
 zTtUaa2stxy5GJzfaZrF7boHJjHSRbI8NXEhanqnRN3JIBEseeAj9yrOv1BSUqPz01
 Gd7OftW6aliKg==
Message-ID: <9a747aba-df77-405c-b179-4d5e5ee3234e@denx.de>
Date: Mon, 26 Feb 2024 14:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P}
 PCIe PHY
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, lukma@denx.de, seanga2@gmail.com
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it,
 trini@konsulko.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-6-sumit.garg@linaro.org>
 <609581c7-d221-4eff-862b-6f172ba9d4e8@denx.de>
 <CAFA6WYPdqsD7Xy1EwX7R_+A3UiskvxaTyvR6D9qP45WhUxxA6A@mail.gmail.com>
 <180d7078-ac13-4d56-8ef5-2b64f7f41937@denx.de>
 <CAFA6WYOGzrM076RJv6Mp_Qaa7Z8h3hUC4mRf8CerkVUB7Ac3oA@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYOGzrM076RJv6Mp_Qaa7Z8h3hUC4mRf8CerkVUB7Ac3oA@mail.gmail.com>
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

On 2/26/24 2:30 PM, Sumit Garg wrote:
> On Mon, 26 Feb 2024 at 18:34, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/26/24 1:50 PM, Sumit Garg wrote:
>>
>> [...]
>>
>>>>> +     ret = reset_get_by_name(dev, "pciephy", &imx8_phy->reset);
>>>>> +     if (ret) {
>>>>> +             dev_err(dev, "Failed to get PCIEPHY reset control\n");
>>>>> +             return ret;
>>>>> +     }
>>>>
>>>> Some clk_put() and co. fail path is missing here.
>>>
>>> Ditto for clk_put() not being available. However, I can add the fail
>>> path for the other reset.
>>
>> Oh, maybe reset_free() and clk_release*() then ?
> 
> AFAICS, clk_release*() APIs are internally only a wrapper around
> clk_disable(). So actually those APIs don't seem to do anything useful
> in the fail path here.
> 
> However, I will let clock tree maintainers chime in here if they plan
> to remove clk_release*() APIs on similar lines as with clk_free().

Maybe they should be in place so in case in the future clock should be 
torn down, it wouldn't be necessary to fix so many drivers ?
