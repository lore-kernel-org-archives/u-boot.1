Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8AEC47258
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 03:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72DD8798D;
	Thu, 18 Jan 2024 04:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GfSO8hFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC1B879C4; Thu, 18 Jan 2024 04:10:34 +0100 (CET)
Received: from mail-m127101.qiye.163.com (mail-m127101.qiye.163.com
 [115.236.127.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BC987971
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GfSO8hFDJuoMR0jPg9rK2e8SRjMKbG4KfRE0WNscf286UEC15srRWujRjZvSM/S0Jkm7Nnhxw+eUigS3HS9z75oqUvnmP5fMO/S0wo7+bLrJ1buAsk8Qa++oUJgQlpqXo9fP5o7QrxUv8xt3H5EMYp+boEDpcu2LqQi2mLH3XFQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=094lgqavAldHJlTP93eZ0DDgaanMQUqotOlQ312breI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 709CA203C4;
 Thu, 18 Jan 2024 11:09:58 +0800 (CST)
Message-ID: <f5332c95-c269-4ee4-85f0-c41476727be2@rock-chips.com>
Date: Thu, 18 Jan 2024 11:09:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
 <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
 <20231209204507.GH2513409@bill-the-cat>
 <5430e6c4-5d0d-4ddf-bc95-e3fbd2b046cd@rock-chips.com>
 <CABEcMwWfLJ_vHDBLNdFRe4U=+e2fWswF0FD0JAaDF49TtyDp1A@mail.gmail.com>
 <CABEcMwWt2yMXoRZG_s45G+AMDsuEVvNkdVo-8VA5pxN4wXWvCA@mail.gmail.com>
 <df499977-c373-4a95-abe7-3ec596d66050@rock-chips.com>
 <CABEcMwV3NWqjjdWP3aKj1iKSF7kn3FuDY=BAPr=UO-OEX6gcsA@mail.gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CABEcMwV3NWqjjdWP3aKj1iKSF7kn3FuDY=BAPr=UO-OEX6gcsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1IHVZPTU1OSBlKHx5PGRhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1a8bfdb72eb6kusn709ca203c4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6TDo4HDwuMhE1GR8uCTAd
 DVEaFBFVSlVKTEtOTk9MSEJCSkJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTU5DNwY+
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

Hi Shantur,

On 2024/1/17 17:38, Shantur Rathore wrote:
> Hi Kever,
>
> On Wed, Jan 17, 2024 at 9:18 AM Kever Yang <kever.yang@rock-chips.com> wrote:
>> Hi Shantur,
>>
>> On 2024/1/17 14:26, Shantur Rathore wrote:
>>
>> Hi Kever,
>>
>> On Wed, Jan 10, 2024 at 11:58 AM Shantur Rathore <i@shantur.com> wrote:
>>
>> Hi Kever,
>>
>> On Tue, Jan 9, 2024 at 10:55 AM Kever Yang <kever.yang@rock-chips.com> wrote:
>>
>> Hi Shantur, Tom,
>>
>> On 2023/12/10 04:45, Tom Rini wrote:
>>
>> On Sat, Dec 09, 2023 at 07:49:04PM +0000, Shantur Rathore wrote:
>>
>> On Sat, Dec 9, 2023 at 7:18 PM Tom Rini <trini@konsulko.com> wrote:
>>
>> On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
>>
>> Hi Tom / Kever
>>
>> On Sun, Nov 19, 2023 at 5:24 PM Shantur Rathore <i@shantur.com> wrote:
>>
>> Rockchip SoCs can support wide range of bootflows.
>> Without full bootflow commands, it can be difficult to
>> figure out issues if any, hence enable by default.
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> ---
>>
>> (no changes since v1)
>>
>>    arch/arm/Kconfig | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index d812685c98..fca6ef6d7e 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
>>           imply CMD_DM
>>           imply DEBUG_UART_BOARD_INIT
>>           imply BOOTSTD_DEFAULTS
>> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
>>           imply FAT_WRITE
>>           imply SARADC_ROCKCHIP
>>           imply SPL_SYSRESET
>>
>> Can this please be merged in ?
>>
>> I wonder if we shouldn't really globally default to BOOTSTD_FULL if
>> BOOTSTD_DEFAULTS for everyone.
>>
>> Its matter of ~21KB in size, unless any platform is really to its
>> limits it should be alright.
>>
>> Maybe I need to re-check things too, since I wonder how much of that
>> growth is re-enabling things that were removed when dropping the DISTRO
>> stuff, and so for platforms just migrating over now it would be smaller
>> in size if much.
>>
>> A board maintainer is free to enable this option, but I don't agree to
>> enable this for everyone.
>>
>> Not like rk3399 and rk3588, some of other SoCs always want a clean and
>> simple but usable U-Boot,
>>
>> eg. rk3036 and rk3308 are still in the list.
>>
>> The discussion is what we consider "usable U-Boot"
>> By default bootstd doesn't have any options and not even to show what
>> it's going to boot.
>>
>> Would it be acceptable if BOOTSTD_FULL is enabled for SoCs rather than boards?
>>
>> Can you please suggest the way forward?
>> Initially the patch was for RockPro64 and then after discussion it was
>> suggested that as BOOTSTD_DEFAULT is very very limited
>> we should enable BOOTSTD_FULL for SoCs that can support multiple boot modes.
>>
>> Let's enable it for RK3588 first and then maybe other SoCs which not code size sensitive.
>>
> My requirement is for RK3399, so I will enable BOOTSTD_FULL for it.
> While at it do you want me to enable it for RK3588 as well ?

You can add for RK3399 or both RK3399 and RK3588.

Thanks,

- Kever

>
> Kind regards,
> Shantur
