Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03536C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 07:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE05805C2;
	Mon, 10 Feb 2025 08:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC95807FE; Mon, 10 Feb 2025 08:41:32 +0100 (CET)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F1A801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1739173245tbiodxr
X-QQ-Originating-IP: zj1i6icMDFBvF4GjNPLuTJxOcsRikAmLD6KWSw436kM=
Received: from [IPV6:240f:10b:7440:1:1909:205b ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 10 Feb 2025 15:40:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11701021609477190902
Message-ID: <5218BE268A6A8515+cb97e216-3ce6-4056-8d29-8304fb3e43e6@radxa.com>
Date: Mon, 10 Feb 2025 16:40:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: Fix binman error
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, jonas@kwiboo.se,
 dsimic@manjaro.org, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-3-naoki@radxa.com>
 <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
 <CAFLszTi7EuM36eSrKehuH_fOkbkE0ZX79jkpZAAn7PonS1EgNQ@mail.gmail.com>
 <7178d2ce-9c13-4ab7-9c56-aff84b65461a@cherry.de>
 <CAFLszThsSbQL8ijj7TOdZFX21cZCa2AzKEb4bfUqe5FVOiN7qQ@mail.gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <CAFLszThsSbQL8ijj7TOdZFX21cZCa2AzKEb4bfUqe5FVOiN7qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NgGgWkiEV4QI5YHYmzzVemqo+hhDf90NoSfgN9N7UsQ65kHmfOnM/c6t
 00r/ua6VQnxaU2nHX5b5ImpR/0/DD1G0UdvDraGapnMIrctHdWqN/pHaf3g515xR7eJNRWK
 jocZEf4Vvokd8zEHyMXTd7ZSYosizVyGOzvUiD/sdXbYzmTiD17AItW5/PECNyoP5jWw5X7
 D5dEwGngjnVjKCtaHA5QdT2vVrBxwfSuz8ecxu17b4iGk8bHim9zkpHpIhNrwh+PqDtBd5s
 LARkDwPnFEFdohqh7vC/rTWlypqfWpgVWPb5qKmeYF7lzds+W4HDi3M/3o22X0UsRToMX8l
 p9u/wqLPtKuVAILH8HctJmK/7wMiMz8CPMEfwx5BWutDRM1yA+Dh5Kn5aQKrYXYasiMvcGY
 iJgbCS9hsQZMxPGDqd7QLg7Tg+OD2OcgcRXnF8DYt/Z6WEBO4ZjepPbsUnhkPhhv8MgUgwI
 yussqYUIfnA2BmQ3tr8dj2RS2bGpJYUMwX68f8F53yfawkHrCNT3poUZ4VXsTSwAdgCAqXD
 VveyIcEqXkzEEJBp0KmWDE+M6i6DkI3M5sgov8aIZE1W83SXeMf8UhmIzOmL9LSF1QQZ8fl
 pDJspEJaNgKLJsM06m+RvlQGhnw9IFEJwtKkh7xuA0QtQ6QgWocE7erca2W2cxK/mYwdxdo
 AAvJlL39Zh0NArGHdeM9ULrbRxNMwImtu7qSqabeu/e98PrUvCxFzBUiueV6IiQE3eFrJHh
 N/229H91iraUKekmA7PO4SAN+0LTOuQuHaFNgmr/GazcrYZ9zdKYhpKKG5vB4tpDx0FYR/+
 1+zO/5Sn026KjCnIGBscLR30z3wxmw/WAG17o3WWkU/gghNmjZoqT+qGm88lLHb8z85r7RU
 6+b3lsXdvCzTVh+hVxzqQQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

Hi,

On 2/9/25 23:27, Simon Glass wrote:
> Hi Quentin,
> 
> On Thu, 6 Feb 2025 at 09:54, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 2/6/25 1:46 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Wed, 5 Feb 2025 at 06:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Naoki,
>>>>
>>>> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
>>>>> After adding the below configs, binman produces an error.
>>>>>
>>>>>     CONFIG_SPL_DFU
>>>>>     CONFIG_SPL_ENV_SUPPORT
>>>>>     CONFIG_SPL_USB_DWC3_GENERIC
>>>>>     CONFIG_SPL_USB_GADGET
>>>>>
>>>>> binman: Section '/binman/simple-bin-spi': Symbol '_binman_u_boot_any_prop_size'
>>>>>       in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl-nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot-tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot-spl,mkimage,fit,simple-bin-spi)
>>>>>
>>>>> Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.
>>>>>
>>>>
>>>> I'll be frank with you, I have no clue what's happening :)
>>>
>>> I means that simple-bin-spi has a binary inside it, u-boot-spl, which
>>> uses binman_sym_declare(ulong, u_boot_any, size). Most likely it is
>>> the one at the top of common/spl.c
>>>
>>> This symbol is filled in (by binman, at build-time) with the size of
>>> the U-Boot binary. If there is no such U-Boot image then it cannot do
>>> this.
>>>
>>
>> Why is it not failing right now? Why does it fail when you enable
>> CONFIG_SPL_DFU, CONFIG_SPL_ENV_SUPPORT, CONFIG_SPL_USB_DWC3_GENERIC,
>> CONFIG_SPL_USB_GADGET for Rock-Pi-4?
> 
> I added these to the end of configs/rock-pi-4-rk3399_defconfig
> 
> CONFIG_SPL_DFU=y
> CONFIG_SPL_ENV_SUPPORT=y
> CONFIG_SPL_USB_DWC3_GENERIC=y
> CONFIG_SPL_USB_GADGET=y
> CONFIG_DM_USB=y
> 
> then build and don't see these errors. Can you please give a little
> more detail so I can repeat this?

This occurs when adding the above CONFIG to the following defconfig and 
building on today's master and next branch.

  rock-4c-plus-rk3399_defconfig
  rock-4se-rk3399_defconfig
  rock-pi-4-rk3399_defconfig
  rock-pi-4c-rk3399_defconfig

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>> This doesn't generate the
>> u-boot.itb file we need for simple-bin-spi as we anyway take the fit
>> blob generated by simple-bin instead.
>>
>> It would make sense to always fail if this relies on u-boot.itb to be
>> built for simple-bin-spi as well?
>>
>> I suggested to use only blobs from simple-bin in simple-bin-spi but
>> according to
>> https://docs.u-boot.org/en/latest/develop/package/binman.html#image-dependencies
>> this is undefined behavior. Maybe we should use a template
>> (https://docs.u-boot.org/en/latest/develop/package/binman.html#templates)
>> and rebuild everything for the SPI image as well. I saw such a patch in
>> your VBE part H series I believe, maybe it makes sense to have this
>> merged separately?
> 
> Yes I am adding a template in that series, but I would rather get that
> submitted, since Binman does currently process images in series.
> 
>>
>> This feels somewhat wrong though, if I'm not mistaken every binary used
>> in simple-bin and simple-bin-spi is the same, to the exception of how
>> the idbloader.img is generated (-T rkspi/rksd), so it doesn't make a lot
>> of sense to me to go through a complete rebuild of all binaries, instead
>> of just running mkimage a second time with the same set of binaries. But
>> if that's the only way to have something with defined behavior AND
>> working, then so be it.
> 
> For now at least I think it is best to keep the images independent,
> with a template to reduce the duplication.
> 
> Regards.
> 
> Simon
> 


