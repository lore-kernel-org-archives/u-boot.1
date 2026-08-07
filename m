Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF480C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 13:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E87B607E6;
	Fri,  7 Aug 2026 13:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LRfbJdDvDqE; Fri,  7 Aug 2026 13:58:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10AEF60A43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786111095;
	bh=PZAtvBdhCyxMRxAj9NEL7Mulg9tZ1whLLVCG7wm+2ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b+/teGx44zK/KaJrDkrorvoH8gwjUMbsMX1H9RnWhc/IrXKNYHMJcfX5VTUk8Whh1
	 KfMIko2dkiHl329v+dF3rMHlORWsiVshFFD8POSg48CBqt/m85iysANVgVLGxPlfQv
	 5yRG7DOzNUM1+j65H0GfwA9o+gW/uviib8TABQe1ydpLKlCAiAw4kHwojIKqQHB0Nt
	 28qwmRzshEIJ+/QgrEfYI7v2v47Ib2oSzH+VPAv5fkPGJ33sFuJ6wr2IFd+UOJ6Iyo
	 4JYwdtCyQR04I5owz8k7xuS0pF4Oyui9dSNCjiOhj3awQKtdPFzeoUecGww6Ip3P74
	 Nd1QT3SCixU/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10AEF60A43;
	Fri,  7 Aug 2026 13:58:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E496198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1036940A3F
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2H_Os0_2RkTJ for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 13:58:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1031340A22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1031340A22
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1031340A22
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 13:58:12 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso1482601a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 06:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786111092; x=1786715892;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PZAtvBdhCyxMRxAj9NEL7Mulg9tZ1whLLVCG7wm+2ww=;
 b=kCSdFnOVh2v/0vh5UuVZQTfVlIAeevQvrefplnHsFjhenimEQnjJ3NSkjfongLHFQw
 s7ftHAOjuayErmV5UzzEvr4hndyyr2QwkHntqpL4jU3nJt7RldIuBESnnyFqrVXtNjiI
 SwWJNxMwrl31vUpNbelP0e8uhp4b0JKYXa9Vl5H6JngmyPP01gy6XrhRF6PsvfkWaweN
 ZfyWYogcA3WhUExHwcmt3YyOuuBicDqxjEfagAdkkgePGWIbu0dirGON6dweUEJOHpEF
 iuPoqt0BCtLXvZhwl+2Eao5i2QcibMMNdiZQRZXHlgSjRbD8qZdxVN6fnt9BL0/g5Eg8
 kMSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpndOVfXplSu4ct2osYBTnTv1svgatj+Lelai9lPpalAE2UUwoXZh0omNRTt+UUkffnKxJ7cHk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzID7V62QKLabBgB9fbKiR83e1akyfe0T30OahitysrXjEvna7n
 hak1i+TKtn3DAXx5NJmQ7mh7bO6YD0ofwzz5dHVDr40uifUsZRNIlU6+3YFuIf3qOqQ=
X-Gm-Gg: AR+sD11sIV5ztWiouXAuAYGTysWs2rOh+NACELVlFsv5SF5vkWRlkDUBFV7GWqcyv6k
 TMD2kiGfQdL7Ol+2yG1Bfb7gge7xmLSiEoznVZpgowdGlUwvGSTmH8qvjKmLJ8FLvFZFCqgqM32
 trHnB+K8kgptNoHsDvRSlz9m38xN4Wdr0RRU/PWCahL9iJNzWEHP5Q68X3vQI7Fh/fU2fjZKfEf
 ULqO/Y4SWrZjAGkPXqlEy/FW9+dr85yuhjlGICmouZe24pMy+k/ufCZ/u0wP2bnTP6mb4wLh3/b
 jYnGPgVWoN/hshxQ5nB6/9D7WMXxHrpFO3vFCodIIqaJTtuVbzzx7QuJ5WJdlp//OoTrSwynZP0
 9gjXqETbmAg7IrqvdTOhYKA64ie6+ueBqjh6B4OBw0sqkDbp/Q/zyVeKNYYyF4h9L/+3A3yaj0u
 5fjgu6IrXw+YxoT+ZkTWMYjgLq+st9b+ZmNe1EjqA1NSUU4msay8ujzdAUCD8UB2uCAUMqmHygP
 1IzyfFHOOpx4wtKbhasuVo+6z2OzlJPn0dV
X-Received: by 2002:a05:6830:3692:b0:7e9:e094:db6d with SMTP id
 46e09a7af769-7f1e5cb15f9mr14351772a34.4.1786111091964; 
 Fri, 07 Aug 2026 06:58:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2?
 ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b76ff85sm1234883a34.13.2026.08.07.06.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 06:58:11 -0700 (PDT)
Message-ID: <344a36ef-70d8-4a54-a66a-23013e0e9f33@baylibre.com>
Date: Fri, 7 Aug 2026 08:58:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm: mediatek: Genio 360 EVK bringup
To: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Irving-CH Lin <irving-ch.lin@mediatek.com>,
 Deep Pani <deep.pani@mediatek.com>, Chris Chen <chris-qj.chen@mediatek.com>
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
 <CAEHHSvb1PhXXiRj-fdWKQghsF428K+Y1K4uBDaYXHR88ja_LfA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvb1PhXXiRj-fdWKQghsF428K+Y1K4uBDaYXHR88ja_LfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786111092; x=1786715892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PZAtvBdhCyxMRxAj9NEL7Mulg9tZ1whLLVCG7wm+2ww=;
 b=O59cePZHZvj07zvJpA2SN7ngcZvF3hDve9Tkuly1W6HN7SQex9XjBmmAV6ZvGhmpMG
 LTrjFAb0O2qNxYJUYhgbJKa/MIpa77e6WvnuJuuCdqqlC79gokGm7fXrOkhxWlJGIxUM
 gCZLyqzJzgyW/u4PXYxvnviE3oNolqKoilVJwHXHoofd+k2PRXNKeEkyiVj+qL2y0lfk
 rJl29d/X+OPb/tSSuvRtXkSlTPWd1yD5fu7Z3LdwFFYXSDaQHpcbopFAUZei8i8447Q1
 g+sbLy7bAHFAek4k+sum24czWLVPKFgXv4yQCxGlD7mWZDCrtzFfyOAOIW2LDLTlpvqC
 nl/Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=O59cePZH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/7/26 8:53 AM, Julien Stephan wrote:
> Le mar. 4 août 2026 à 01:21, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> This series is doing a basic bringup of the MediaTek Genio 360
>> Evaluation Kit board. This contains a new application processor
>> (MT8366) that hasn't been seen in U-Boot yet, so basic support for
>> that is added as well. Clock and pinctrl drivers were sent as
>> standalone patches.
>>
> Hi David,
> 
> I already did the review of clock driver but I realize that it should
> be part of this series (or at least depends on it) for mt8366-clk.h

My plan was to merge the clock driver first. Nothing would compile
it until this series, so should not be a problem. Maybe I should
include the header in the clock series anyway though.

> 
>> There isn't an upstream devicetree at this point, so most of this is
>> picking up the downstream devicetree along with a little init code
>> and a defconfig.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> Chris Chen (1):
>>       arm: mediatek: add MT8366 application processor
>>
>> Deep Pani (1):
>>       dt-bindings: pinctrl: add MT8366 pin function header
>>
>> Irving-CH Lin (1):
>>       dt-bindings: clock: add MT8366 clock header
>>
>> Macpaul Lin (3):
>>       arm: dts: add MT8366 application processor
>>       arm: dts: mediatek: add Genio 360 EVK
>>       board: mediatek: add Genio 360 EVK defconfig
>>
>>  arch/arm/dts/Makefile                              |    1 +
>>  arch/arm/dts/mt8366-genio-360-evk-common.dtsi      |  405 ++++++++
>>  arch/arm/dts/mt8366-genio-360-evk.dts              |   14 +
>>  arch/arm/dts/mt8366.dtsi                           |  662 ++++++++++++
>>  arch/arm/mach-mediatek/Kconfig                     |   12 +-
>>  arch/arm/mach-mediatek/Makefile                    |    1 +
>>  arch/arm/mach-mediatek/cpu.c                       |    3 +-
>>  arch/arm/mach-mediatek/mt8366/Makefile             |    3 +
>>  arch/arm/mach-mediatek/mt8366/init.c               |   58 ++
>>  board/mediatek/MAINTAINERS                         |    8 +
>>  configs/mt8366_genio_360_evk_defconfig             |   25 +
>>  include/dt-bindings/clock/mt8366-clk.h             |  342 +++++++
>>  .../dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h  | 1069 ++++++++++++++++++++
>>  13 files changed, 2601 insertions(+), 2 deletions(-)
>> ---
>> base-commit: 54930fd153a443a67fe56b89df16541048132513
>> change-id: 20260729-mtk-genio-360-bringup-de3bedc2ec94
>>
>> Best regards,
>> --
>> David Lechner <dlechner@baylibre.com>
>>

