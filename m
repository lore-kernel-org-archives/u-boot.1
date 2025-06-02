Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE9C5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 08:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4613828F8;
	Mon,  2 Jun 2025 10:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RjoX+cyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B636982A25; Mon,  2 Jun 2025 10:11:24 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D1CF8212B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 10:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so669491f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748851882; x=1749456682; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFFj9Ig0NPJjx7Cme/luBCGjCug26BfR5jS0SKkoX4A=;
 b=RjoX+cyxqCDyS7GPZYJJ3Txu8BJlYYteKGkMUFROWULenRJw6MSNh7TczIab0ugapJ
 cU8S/8+9jx46fRo+P7TuG74I4uYFDlsahe18pL4PF2kmTnRV+n2SJFv+RcB89P+mIIdd
 ms02D6gtehU10KD03/w67W0TztQXuLpNA2wDk0oWVa9QhsMss9QqDQ3kmXyAtYsIErVs
 5Vht7sEH9AnrEUuPk0mOldefu3nUMsATCUxYI9yv3taIKobnyCKo3XZRDMV63zH/x+bg
 NYhmeiLTSkqvlvgYP89ph/D+TkjTakn/o2dM2LpytHjrPtEijSjKDm9CN47PtQgi/1V3
 9gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748851882; x=1749456682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFFj9Ig0NPJjx7Cme/luBCGjCug26BfR5jS0SKkoX4A=;
 b=jdHeBv1tUHPWI1h+pO8gsM+Ze9zUqW9Uu7xND2fwjVUwD9nRJXohXdyKEa8oDHVHJE
 LfCLYeU3uUlO89TdRcjcnEuP+TvNWxRLa6zpm1drfDJQJNvbdDZncUUdwBbpLHRJlSG+
 hv3CujWQmmo0dLG3mLX5QskwoM2JKUBsXj8LaybavaatRi0lbl0DZ5XybEJVWVr6LBv9
 fxphmU2UeiPtWRmOafwvFP7YdsJK/KbBSVUtaNFrHw8r4VubYczqaJt+SVVzm+OITASK
 mh5lag9IBJ+i1w8X7m4JcUjOkbvVh7qmEasQk6SEoxlNjmfxbABmvB/dAWTZKKve0hbx
 fldA==
X-Gm-Message-State: AOJu0YwiRAD8gej3sFx7pJ//CP2wYCLu2stbA61T5a/LyHq0tNUNXgpU
 9aABXkjr7G0fqMXA7h3dG/V1nBv+EmENrPFHZ+XZteodFbPCAVsoE/eH07Tn20WsdXg=
X-Gm-Gg: ASbGnctsQcv97fmdaP3RRoifxfoba9nHTVNhL67/2vEF30G34fVJtQjAmQ0TqH14SH1
 N53KN7eFmgCZu/SCm3am79ei0XmtdKUc5mu2E1aCTDrqxAjZhj/YO3tq4hnqwEtIzk4f4QFDR9B
 pL3KxeuNlmRU/9KLJz2V2BLlc7eyy3TeJ0z0dr1UcUsiMnR2mxTQfFm/ASxiGgdxYhcOrrJif4j
 XnfZrnZ3ByrsRc2YrjQeXieNbjX41nTr/lSynFEuFfMbrmROQv9REXI98CgxWncdqOr8Jq4vbBF
 zcv3loTTisbSUGYyfukpBC1hCliuk0y6mZGyVM833BbfnnEuXwOplvKvRJxAdMC7McNU2t7BGkJ
 hbvygq12dci89PeGicdnhnPtGPKY5C0E=
X-Google-Smtp-Source: AGHT+IHpUx8JOrDQ4G4uCXo1s0Sm3Oo8/1OcQniVT9bPekvQeZJTH9AJ3J+RYQeNi3gobKebg/OU+w==
X-Received: by 2002:a05:6000:3105:b0:3a4:d722:5278 with SMTP id
 ffacd0b85a97d-3a4f7a9d552mr10783838f8f.39.1748851881667; 
 Mon, 02 Jun 2025 01:11:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c3b6:f8ee:d9ea:872b?
 ([2a01:e0a:3cb:7bb0:c3b6:f8ee:d9ea:872b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6ca08sm14376668f8f.33.2025.06.02.01.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:11:21 -0700 (PDT)
Message-ID: <af397cfc-e222-4ed6-b8d7-802d9080dbfa@linaro.org>
Date: Mon, 2 Jun 2025 10:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sntp for NET_LWIP
To: Tim Harvey <tharvey@gateworks.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <CAJ+vNU08-=eWAceEedRg7RabqB-BKO_1F+8EkDHB8zHg79VK3g@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU08-=eWAceEedRg7RabqB-BKO_1F+8EkDHB8zHg79VK3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Tim,

On 5/30/25 17:46, Tim Harvey wrote:
> On Wed, May 21, 2025 at 8:15 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Implement the sntp command with lwIP (CONFIG_NET_LWIP=y). SNTP is
>> supported as an app in lib/lwip/lwip/src/apps/sntp/sntp.c so this is
>> mainly about adding that file to the build and writing do_sntp() to use
>> the sntp_*() API and run the receive & timer loop. There is a patch to
>> extract a small bit of common code from net/sntp.c to avoid duplication.
>> The QEMU arm64 lwIP defconfig is updated to provide the sntp command by
>> default for convenience.
>> I could not test the case when the NTP server IP is provided by DHCP. If
>> someone has access right away to such a configuration and in case it
>> does not work, please let me know.
>>
>>
>> Jerome Forissier (3):
>>   net: extract function net_sntp_set_rtc() from sntp_handler()
>>   net: lwip: add sntp command
>>   configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
>>
>>  cmd/Kconfig                       |  13 +--
>>  cmd/net-lwip.c                    |   5 ++
>>  configs/qemu_arm64_lwip_defconfig |   1 +
>>  include/net-common.h              |  13 +++
>>  lib/lwip/Makefile                 |   1 +
>>  lib/lwip/u-boot/arch/cc.h         |   4 +
>>  lib/lwip/u-boot/lwipopts.h        |   4 +
>>  net/lwip/Makefile                 |   1 +
>>  net/lwip/sntp.c                   | 128 ++++++++++++++++++++++++++++++
>>  net/net-common.c                  |  28 +++++++
>>  net/sntp.c                        |  23 +-----
>>  11 files changed, 195 insertions(+), 26 deletions(-)
>>  create mode 100644 net/lwip/sntp.c
>>
> 
> Hi Jerome,
> 
> Thanks for the continued work on lwIP!

Sure. Thank you for testing and fixing bugs :)
 
> For the series:
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> 
> Note that if this is merged before my series we'll want to have a
> followup that removes the sys_check_timeouts() after net_lwip_rx(udev,
> netif), or if it is merged before my series I can send a v3 that does
> it.

Both series are in my patchwork queue, so I'll take care of that. Thanks
for the heads up.

> Do you have a list of lwIP features you're still working on? I'm going
> to be moving the Gateworks venice boards to it as things look pretty
> good. The only thing I saw that was missing was TFTPPUT which I don't
> really care about.

I don't have any thing left in my to-do list for lwIP at the moment. There
are several U-Boot features that are still not supported with NET_LWIP. As
you said TFTP PUT but also IPv6, the bootp command, as well as ncsi, ethsw,
and wol (those are found in cmd/Kconfig). Maybe other things, I don't know.

BR,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
