Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29771C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9B588B0A;
	Thu,  1 Aug 2024 16:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="leqKtuL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F11788667; Thu,  1 Aug 2024 16:40:09 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B19886BB
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f15790b472so7959591fa.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722523205; x=1723128005; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d+kscTsyHXdsbBzKsghuRhmcv80lotrInqPF16Klm6g=;
 b=leqKtuL+LnBXCvGrxn8AcmsAMuozpJEjP3xOiWys7dbqpozC4yKip9PbS+9SwKFi3S
 eZiRc5LFnq1SWAkMvHOG2ux/wEzUNHHY2UocyahhzeJjn90fwdjcwKKYvqWivb7VBHSh
 07CYycUEsYzgFzH9Edn6ul+4X36cluDlV3+OFdUDtddLskr5/fs6Xg8Ez3Ybuo15WW7R
 5Mw+Lb0QEc66wuV8H8A1SIPKr0rPF75eImc+3ZCmdRY2Dj0Bt/7eMK1Cq0Fjtiuimb9K
 6VuzRLPKIZ5Mu5sEVG9jI2DQms6Mtwl+drupdTqkzsCHb5egzLEtGpHQMhcP3HqzKcPA
 jHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523205; x=1723128005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d+kscTsyHXdsbBzKsghuRhmcv80lotrInqPF16Klm6g=;
 b=BHzLFqNnIlT+QDkKLtLkKUSpvUtrjoOLQkCAgktxEx8DSH6D6Ai9mKsppSD+G4S5/B
 v+aquP83iJGGhjhavm+phQ+HofcUllUYsyVSqnQJvhZasBHd2Vqzs6wECUa72mu17UTB
 jR1G6bUHLPJYwY7f8GcRtDB39GGwPsf2rATi+4mn2IzzkC2x9XkgQkRqwWlwQV13YZ1Y
 /8+OV81fRt2rEPYRa4NI4wpY5KcARdaKVreYAqePHEHD6qHLWnurCeXFq85gjfvWyeD7
 Jmgq5doTGo0mxtITKEq9Wr0omZOE8tcRZKUU8YDKgbGhav0DYbLsSTiwlAerueD5x7V9
 6AZA==
X-Gm-Message-State: AOJu0YzYVJD3pHUXBjYcGbYyoQvYsHNbAkskHK30hRxbi2ej/kvxBFMd
 wX8cAAA8ewA1QfmoO6oP0FSGUPvx8S4p6PkBQliM8qu4UXxP3QKvf/u1pv8dJe0=
X-Google-Smtp-Source: AGHT+IHAVPiS56qwxguFIrz/3mP7XAAALoEqBhczSzUiOrB337cjON6RiIl1PFhwE7VZKLBmQnNzlg==
X-Received: by 2002:a2e:9a88:0:b0:2f0:1a19:f3f1 with SMTP id
 38308e7fff4ca-2f15aa84fb9mr3537911fa.7.1722523204650; 
 Thu, 01 Aug 2024 07:40:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:10f0:14b5:e4e1:d5ec?
 ([2a01:e0a:3cb:7bb0:10f0:14b5:e4e1:d5ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bac7349sm60498555e9.27.2024.08.01.07.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 07:40:04 -0700 (PDT)
Message-ID: <ebc992d6-93e8-4e7e-99dc-834cc981f5a3@linaro.org>
Date: Thu, 1 Aug 2024 16:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <20240725172220.GA989285@bill-the-cat> <20240725223401.GD989285@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240725223401.GD989285@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 7/26/24 00:34, Tom Rini wrote:
> On Thu, Jul 25, 2024 at 11:22:20AM -0600, Tom Rini wrote:
>> On Thu, Jul 25, 2024 at 02:57:21PM +0200, Jerome Forissier wrote:
>>
>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>> stack [2] [3] as an alternative to the current implementation in net/,
>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>> reasons for doing so are:
>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>> so. With that it becomes possible to fetch and launch a distro installer
>>> such as Debian etc. using a secure, authenticated connection directly
>>> from the U-Boot shell. Several use cases:
>>>   * Authentication: prevent MITM attack (third party replacing the
>>> binary with a different one)
>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>> image as it is being downloaded
>>>   * Allow connection to servers that do not support plain HTTP anymore
>>> (this is becoming more and more common on the Internet these days)
>>> - Possibly benefit from additional features implemented in lwIP
>>> - Less code to maintain in U-Boot
>>>
>>> Prior to applying this series, the lwIP stack needs to be added as a
>>> Git subtree with the following command:
>>>
>>>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>>
>> This is better than v4, and on the hardware platforms I could build and
>> boot on (which was most of mine except the am62x_beagleplay), the tests
>> ran and completed, including the tftp+boot a Linux kernel.
>>
>> The bad news is CI blows up, a lot:
>> https://source.denx.de/u-boot/u-boot/-/pipelines/21764
>> And:
>> https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/build/builds/9014/logs/106
>> which is another Kconfig dependency problem. I don't _think_ I
>> introduced that, but since this wasn't against top of tree, I had to
>> apply the cmd/Kconfig patch manually.
>>
>> I have my world build running still and may have more comments based on
>> that.
> 
> First, with NET_LWIP being default rather than NET, there's a lot of
> other Kconfig dependency issues. Unfortunately I don't see an easy tool
> for making sure this is all clean aside from a shell loop like:
> for C in `(cd configs;ls)`;do make -s $C;done

I have run this loop successfully with the upcoming v6 version. Some
configs do print some warnings but there is no error.


> Once those are fixed, this is feeling pretty OK I think. I assume PXE
> support is high on the follow-up TODO list?

Certainly, although I'm not sure I'll be able to spend time on it in the
very near future.

> That said, after taking
> tiger-rk3588 as an example platform and hacking out PXE related stuff and
> turning on lwIP:
>    aarch64: (for 1/1 boards) all +10144.0 bss -4040.0 data -64.0 rodata -100.0 text +14348.0
>             tiger-rk3588   : all +10144 bss -4040 data -64 rodata -100 text +14348
>                u-boot: add: 161/-115, grow: 8/-6 bytes: 24552/-14382 (10170)
[snip]
 
> Although I'm not 100% sure that config is functionally equivalent, so
> perhaps it would be helpful if you could take a board or two and
> reconfigure them with the legacy stack, but equivalent functionality to
> with lwIP, for comparison sake? Thanks!

I tried two boards and compared NET (u-boot.net) agains NET_LWIP
(u-boot). I will give more details on how to remove PXE from the NET
build and select/unselect the proper Kconfig symbols to obtain equivalent
functionality in the cover letter for v6. Note that dhcp, ping, dns, tftp
and wget are enabled in both builds. Here are the results.

- For imx8mp_evk_defconfig:

$ ~/work/linux/scripts/bloat-o-meter u-boot.net u-boot | sed -n '1p;$p'
add/remove: 228/162 grow/shrink: 49/4 up/down: 51217/-29078 (22139)
Total: Before=651990, After=674129, chg +3.40%

- For rpi_3_32b_defconfig:

$ ~/work/linux/scripts/bloat-o-meter u-boot.net u-boot | sed -n '1p;$p'
add/remove: 256/92 grow/shrink: 5/8 up/down: 50934/-16780 (34154)
Total: Before=418877, After=453031, chg +8.15%

I will post v6 soon.

Thanks,
-- 
Jerome
