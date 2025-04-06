Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CC5C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F70982B4A;
	Sun,  6 Apr 2025 17:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dzBeq7z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E9082B6C; Sun,  6 Apr 2025 17:40:00 +0200 (CEST)
Received: from mail-m19731119.qiye.163.com (mail-m19731119.qiye.163.com
 [220.197.31.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E73282AA3
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d06816c;
 Sun, 6 Apr 2025 23:39:54 +0800 (GMT+08:00)
Message-ID: <05c193fb-b260-499e-bd6c-518790108bd9@rock-chips.com>
Date: Sun, 6 Apr 2025 23:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: wens@kernel.org, Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20250204172319.3361870-1-wens@kernel.org>
 <CANAwSgQTMBLW2Y5YHpoAYDtXHyAbD9-s8KpWU1zBTRAB=rsJow@mail.gmail.com>
 <97223c88-8f32-4cfd-8465-dd034f85f3a5@rock-chips.com>
 <CANAwSgQB9ZdsE9vh2jOCGsATsjAUSUZQAfftPp=VsrogazmdOw@mail.gmail.com>
 <CANAwSgQS-ky7TF=k7OMOW4bQCJaozfYBjDS-5wXZ+3+3gU6crw@mail.gmail.com>
 <CAGb2v679u3aFwgMBA4y_B8sk-bO3OwRrj0py4hXc5anyG=FAKQ@mail.gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CAGb2v679u3aFwgMBA4y_B8sk-bO3OwRrj0py4hXc5anyG=FAKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGB0aVk5NQx4dGB0fHh0eQ1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960bc2221703afkunm10d06816c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjI6OBw6TjJPA0k4Nzw8PEsd
 MCsKCSlVSlVKTE9IQk5IQkJPQk9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFJQkNMNwY+
DKIM-Signature: a=rsa-sha256;
 b=dzBeq7z5yNi1dp4LxqAbq/EOVt0rs3SFqeSoVBiKn7ovJs4T6LI6uxbCwcpu9LldQPcomoIZ0gxIfAyRQz7im4pyrB7ZiPb2RNBPc+BCwhyzRkoF1OYP0t5XyUzYxzQjUkrvWJa1/mm6cCYm3cvJdhfBhUpHJSlnGG9g3GfYKoI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=XOeqTh6mtCf5MGac6Y4ctCiLZAinF/LLmHorMyj3c2s=;
 h=date:mime-version:subject:message-id:from;
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

Hi Chen-Yu,

On 2025/4/1 15:31, Chen-Yu Tsai wrote:
> On Tue, Apr 1, 2025 at 3:22 PM Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Kever,
>>
>> On Tue, 1 Apr 2025 at 09:11, Anand Moon <linux.amoon@gmail.com> wrote:
>>> Hi Kever,
>>>
>>> On Tue, 1 Apr 2025 at 08:30, Kever Yang <kever.yang@rock-chips.com> wrote:
>>>> Hi Anand,
>>>>
>>>> On 2025/3/30 21:33, Anand Moon wrote:
>>>>> Hi Chen-Yu
>>>>>
>>>>> On Wed, 5 Feb 2025 at 07:39, Chen-Yu Tsai <wens@kernel.org> wrote:
>>>>>> From: Chen-Yu Tsai <wens@csie.org>
>>>>>>
>>>>>> The IO domain driver controls the I/O voltage for various pins,
>>>>>> MMC included.
>>>>>>
>>>>>> Enable it by default for all supported Rockchip SoCs.
>>>>>>
>>>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>>> Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>>>>>
>>>>> Can we enable following config default for all the boards
>>>>>
>>>>> CONFIG_MMC_DW=y
>>>>> CONFIG_MMC_DW_ROCKCHIP=y
>>>>> CONFIG_MMC_SDHCI=y
>>>> These two driver, SD card and eMMC, are board specific, not all the
>>>> board has enable all these two interface.
>>>>
>>> Ok,I thought it should reduce the configuration options on all the boards.
>> But can we implement this for each SoC, such as the RK3399 and RK3588?"
> Of all the defconfigs that have ARCH_ROCKCHIP, only three don't have MMC_DW:
>
>      configs/coolpi-cm5-genbook-rk3588_defconfig
>      configs/evb-rv1108_defconfig
>      configs/geekbox_defconfig
>
> So maybe we could have the default by y, and negate the option where
> it makes sense.

Yes, sounds reasonable for DW MMC, both SD and eMMC use this controller 
for legacy SoCs.

For new SoCs, the eMMC is using MMC_SDHCI, and maybe more boards does 
not enable it.


Thanks,
- Kever
>
> For MMC_SDHCI there would be more defconfigs, but only a couple SoCs
> support this controller, and we could narrow it down to those.
>
>
> ChenYu
>
