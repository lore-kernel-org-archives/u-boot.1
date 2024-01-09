Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED43C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 10:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CFA87120;
	Tue,  9 Jan 2024 11:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="J41JjgNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9EB8771E; Tue,  9 Jan 2024 11:55:32 +0100 (CET)
Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com
 [45.254.49.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32B1986EF1
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 11:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=J41JjgNeiBOU75S8+hYWEI7wKaKs2ZJgf//ezdobI0TqRzbS8FH7x8Y6yBkWuy+Izug1FaVjZhUJYH4iL/CRODXhVAzZTEQCFV9YQPdmrL8RQsQHzaAcr9+gdkaWKLfvGs4Q1qn64tMA/j1xiJrayORbGceu9Xl96WWLmrLIwMU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Lk0zAPR/hQCdm7mEziULQ5VLd5Pw+apUSIqte+yZ/u8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 69F28400568;
 Tue,  9 Jan 2024 18:54:36 +0800 (CST)
Message-ID: <5430e6c4-5d0d-4ddf-bc95-e3fbd2b046cd@rock-chips.com>
Date: Tue, 9 Jan 2024 18:54:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
 <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
 <20231209204507.GH2513409@bill-the-cat>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231209204507.GH2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIYGlZOHktDS0gZSkhIT05VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ceddc23fd2eb3kusn69f28400568
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSo6Lyo4EzwqHDUODCo3Ti09
 Mh8wCglVSlVKTEtPTEJMTUxNQk5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITEpMNwY+
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

Hi Shantur, Tom,

On 2023/12/10 04:45, Tom Rini wrote:
> On Sat, Dec 09, 2023 at 07:49:04PM +0000, Shantur Rathore wrote:
>> On Sat, Dec 9, 2023 at 7:18 PM Tom Rini <trini@konsulko.com> wrote:
>>> On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
>>>
>>>> Hi Tom / Kever
>>>>
>>>> On Sun, Nov 19, 2023 at 5:24 PM Shantur Rathore <i@shantur.com> wrote:
>>>>> Rockchip SoCs can support wide range of bootflows.
>>>>> Without full bootflow commands, it can be difficult to
>>>>> figure out issues if any, hence enable by default.
>>>>>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>>>> ---
>>>>>
>>>>> (no changes since v1)
>>>>>
>>>>>   arch/arm/Kconfig | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index d812685c98..fca6ef6d7e 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
>>>>>          imply CMD_DM
>>>>>          imply DEBUG_UART_BOARD_INIT
>>>>>          imply BOOTSTD_DEFAULTS
>>>>> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
>>>>>          imply FAT_WRITE
>>>>>          imply SARADC_ROCKCHIP
>>>>>          imply SPL_SYSRESET
>>>> Can this please be merged in ?
>>> I wonder if we shouldn't really globally default to BOOTSTD_FULL if
>>> BOOTSTD_DEFAULTS for everyone.
>>>
>> Its matter of ~21KB in size, unless any platform is really to its
>> limits it should be alright.
> Maybe I need to re-check things too, since I wonder how much of that
> growth is re-enabling things that were removed when dropping the DISTRO
> stuff, and so for platforms just migrating over now it would be smaller
> in size if much.

A board maintainer is free to enable this option, but I don't agree to 
enable this for everyone.

Not like rk3399 and rk3588, some of other SoCs always want a clean and 
simple but usable U-Boot,

eg. rk3036 and rk3308 are still in the list.


Thanks,
- Kever
>
