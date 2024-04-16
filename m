Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D708C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE5588325;
	Tue, 16 Apr 2024 11:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LFZfyd9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEE88832A; Tue, 16 Apr 2024 11:59:44 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3D38831C
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34782776b19so1773050f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713261581; x=1713866381;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kYATZ6riV2+x8Gy0ZXnef25YXZJXop0dlAhh/czpvuE=;
 b=LFZfyd9KB1DbfJy0qFIw3zTYEH8j3R51YpMfG7xhcqmwjkX5DUf06C0/WeKTDtZlkh
 LYL1VZMplh1zFOIkbRVwx3jwNju+lIDfxwhWJDsOKNlNHvE7LRpwl48F+TYSWreeOwaT
 LnPOLVIvPY0ikUGUrmUnTlhtDqcddGtUoOZdKne01Kf4ycqa4Z1GFK+gd7ySIzJkv1QF
 oZwsKRgwEUJGt9Vky3eytIhvisUilmGhuqxZTSwbgbMbi8P07K29D41fq8eyCci6Mt70
 2CIkQsPWDnC3hnPf/r1/fjiZD4fa/HlTQBkXdnTyr/7c+gg7vo33WMCEXanUyZBkxFNT
 gAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713261581; x=1713866381;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYATZ6riV2+x8Gy0ZXnef25YXZJXop0dlAhh/czpvuE=;
 b=d/H783jXze3l5X6xCF6aWHrBaiYI/g/mmCRr+qQHSZVgONZCNcdArdkg8O5ZoOXUEs
 q9rrtS0NZQWVgOFp84qBywe7a/uLqcsDoaZWoN7XEuTUSdbJWxLFDtrU2wXeJ/yU1B9y
 PxdhCvf1cQuGG+WCoNccJlAOhWYLk1zuHt4CJzGFO2jX4nPJO8D+euBJNasTp0l0AAjJ
 dOItVfJCpxP28zsXU+NAg1O4tT2elOAhcqH2gcOrpxA62GbnPyvYhp5e07UV/3GE+hVV
 THzyg/wwPKDVo/VanlBFefoffan6nrPmn5ijZeJ3WNOmFSwm09/u9Ln58H70qRfKIZgd
 U2+Q==
X-Gm-Message-State: AOJu0YyOouNVqLssoZ+ti6K61gBogQyw6XTHvcYgyVmYCUu+dSNlbHrg
 LiDXqrIKPQFMGpAUPwH+PtC9FP9RteHYSyG+Wp+1URkBHIZaVvMBurGT48fGr6I=
X-Google-Smtp-Source: AGHT+IG6XC5TZayyq2zf/xaWgoNdnITgBoNQX+qaAcdzAYoqM2luAoa8Qm5GOj1l3H6KrNpirYYolQ==
X-Received: by 2002:a5d:6e55:0:b0:346:afab:9702 with SMTP id
 j21-20020a5d6e55000000b00346afab9702mr7606891wrz.13.1713261580521; 
 Tue, 16 Apr 2024 02:59:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e3-20020a5d5943000000b00346c169362esm13946080wri.23.2024.04.16.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 02:59:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jon Humphreys <j-humphreys@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, Simon
 Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, Roger
 Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 12/16] arm: dts: k3-am625-sk-u-boot: Add
 sysreset-controller node
In-Reply-To: <86edbbzlod.fsf@udb0321960.dhcp.ti.com>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-13-j-humphreys@ti.com>
 <87cyqwe3lt.fsf@baylibre.com> <86edbbzlod.fsf@udb0321960.dhcp.ti.com>
Date: Tue, 16 Apr 2024 11:59:37 +0200
Message-ID: <87frvl4ohi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jon,

On jeu., avril 11, 2024 at 15:30, Jon Humphreys <j-humphreys@ti.com> wrote:

> Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:
>
>> Hi Jonathan,
>>
>> Thank you for the patch.
>>
>> On lun., avril 08, 2024 at 17:31, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>>
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>
>> Please consider adding a commit message body.
>
> Got it.  thanks.
>
> BTW, the next version of this series will drop this patch as Andrew has
> submitted another patch removing the need for this one.  See
> https://lore.kernel.org/r/20240402160908.508974-1-afd@ti.com.

I was not aware of that one. thank you for pointing it out. That seems
indeed a better solution.

>
>>
>> On the TI vendor tree, there is a similar patch with a commit message:
>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=c5296d943c2c84dd6dcb3b91305d006ac46f3157
>>
>> Before patch:
>> => reset
>> resetting ...
>> System reset not supported on this platform
>> ### ERROR ### Please RESET the board ###
>>
>> With patch applied:
>> => reset
>> resetting ...
>>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on am62x sk evm
>>
>> Andrew also suggested to me that if we are interested by A53 reset only,
>> we can PSCI reset instead for all k3 architecture:
>>
>>  --- a/arch/arm/Kconfig
>>  +++ b/arch/arm/Kconfig
>>  @@ -784,6 +784,9 @@ config ARCH_K3
>>           bool "Texas Instruments' K3 Architecture"
>>           select SPL
>>           select SUPPORT_SPL
>>  +       select PSCI_RESET if ARM64
>>  +       select SYSRESET if ARM64
>>  +       select SYSRESET_PSCI if ARM64
>>           select FIT
>>           select REGEX
>>           select FIT_SIGNATURE if ARM64
>>
>> Has the above been considered?
>
> I am not aware.  I would think that you want full reset, unless you are
> thinking about specifying a reset level?

On my end, I was mostly interested in resetting from the A53 core, but
the solution you linked previously should work for me.

>
> Jon
>
>>
>>
>>> ---
>>>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>> index fa778b0ff4c..35bfeae75a0 100644
>>> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>>> @@ -46,3 +46,12 @@
>>>  &cpsw_port2 {
>>>  	status = "disabled";
>>>  };
>>> +
>>> +&dmsc {
>>> +	bootph-pre-ram;
>>> +
>>> +	k3_sysreset: sysreset-controller {
>>> +		compatible = "ti,sci-sysreset";
>>> +		bootph-pre-ram;
>>> +	};
>>> +};
>>> -- 
>>> 2.34.1
