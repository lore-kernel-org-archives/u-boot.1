Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24D4CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 22:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD0384713;
	Sat, 16 May 2026 00:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aPV2wF3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD544847D9; Sat, 16 May 2026 00:27:43 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BF88467C
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8b8abc633f4so420166d6.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778884060; x=1779488860; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oi52S5W2MJhnSz2n7q57KbZXFHNeE1JnJd8L5o9vUEc=;
 b=aPV2wF3GOti9IJFI01o0lWw1tPSrjc9o3Z4GP+gC/CBisc39tHvtURJH7Tzo/wQj+w
 EimWMlcDBjY5hFhFYdlCn+aER4NZy7COxqWd1emQDprPDyTXzSDjsFqBsNyXJoCeJCf4
 KwPJI8f2jv4aN4RQ0MMuA9eP1fCJsFLADi0d8LACXKU0XrZWcXi7lUWBt0hsAbN67jBS
 bMD/buO7s7ozJ2mDUyxo7PI6mr3uMEA0xWWVik0cbwQ5pZGbqyHJemKDEDCFv7PQN2Z1
 WhJ7H7Ia5w6VVrCB0ABTtrOLTOJlRpViDkeshhvy05ZxSmyYsgRRNW1rQ2nmrlpsxXaH
 XqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778884060; x=1779488860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oi52S5W2MJhnSz2n7q57KbZXFHNeE1JnJd8L5o9vUEc=;
 b=f6gZHBBnlqbpYbdLRAI7mIH5hF1/LmO5g7aTIaBqwXnG5NtPZyjRF5QNClpNYBjzN+
 ETfyUyjf9qIq/OMf8KF+aUpud5n2+oEHFRyIvk8r1KnCp4mNbPpbJnbQ2CCEaln/L/Y5
 aOKuLh5P18L2+J9eyWkeGoPxCFw/xundXxjyItCHGUUSPyNGrxpp/r7Oycxz3yN3UBhJ
 L6+HXdd1l+oII7WevODG83QGfE8J0ZvCx/1ZmWyfzzlvRpd+FgFxAIYn6M5OqLHLewdg
 V2+4VYA7hvbmq4sJoX+zea2etu5YMtsWG4tG3G4509VI+4yuy6W/Nxndf1vU19Yd4Fhz
 fHNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ufLczw2rW62g9QYcFWkJRgLWXKuo5zfnpmEEvICKc9DeSBV85Vm79qZlFYe6hTlCYK1Raxms=@lists.denx.de
X-Gm-Message-State: AOJu0YwM/mWuq0Yqqc6HaQZxqoNXRyOtgBWh6ANwqupLihMSAruNr1kv
 giHSf0TFVbzoDiay35sOa22ZR7PcLT33pPT5kj8zAXwL3UcgS0s01RWg
X-Gm-Gg: Acq92OExkYgZKaiKYDZ1mZgZDibA7TONoJ49lPrCtWK9TM65C4rjY0+7RjVTUAc3jiR
 sut6mVw+UNhUi5K/uldaSKolwjGe2wCfEEckmG8HUAXGEAvemcRO432e4g3LNnmWf6ewYN9nU+I
 nyhQo8tvv79zyohljlUYoYvxCp2WHehjfSgjpARfNU9T3heQgTMVDm/1nuCiZBTy3JVyXkzHlTF
 6JxOTDXfa85EJuueUovqPG00TklwT335obCghKV37WbV8YLXv808wIJYSnaKzUILrkfr7VlppGa
 qEfNJUGAp2D5As5E//oXNFf3hLCDXeEoBsFPdHxRTzD10vtfnn1HW87ojSPBs90v8Ich7k3jm2K
 hkwCW2VBcRnNa/BdiObtxnokIwxCEUute0xxJJqHfrjfONA3h5wPBKtGQFb1mW7NzLrKFezrEK6
 wdOZvC8Mu6uaYo9Ahw/ozsMaGfn2xrJvEkaSq3latAVO91lDPDVqTG+GBRqvWZgfb9khI=
X-Received: by 2002:a05:6214:4585:b0:8ac:a0f4:5aa0 with SMTP id
 6a1803df08f44-8ca0fc20b8cmr72274616d6.8.1778884060473; 
 Fri, 15 May 2026 15:27:40 -0700 (PDT)
Received: from ?IPV6:2600:4040:4477:d400:2d8:61ff:fe7c:5d59?
 ([2600:4040:4477:d400:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908d1d2e7sm64486636d6.16.2026.05.15.15.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 15:27:39 -0700 (PDT)
Message-ID: <936f6df3-2bb9-f99a-45f1-4dcfa915f2c0@gmail.com>
Date: Fri, 15 May 2026 18:27:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>, Daniel Palmer
 <daniel@thingy.jp>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515214305.GL1858239@bill-the-cat>
 <15041974-8838-56b6-b9d5-250383ed2625@gmail.com>
 <aa023095-2b32-070f-ff43-1f6922918b51@gmail.com>
 <20260515222107.GN1858239@bill-the-cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260515222107.GN1858239@bill-the-cat>
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

On 5/15/26 18:21, Tom Rini wrote:
> On Fri, May 15, 2026 at 06:06:38PM -0400, Sean Anderson wrote:
>> On 5/15/26 17:59, Sean Anderson wrote:
>>> On 5/15/26 17:43, Tom Rini wrote:
>>>> On Fri, May 15, 2026 at 02:32:51PM -0600, Simon Glass wrote:
>>>>
>>>>> We have had getopt() for over five years but it is not much used. It is
>>>>> much easier to understand arg-parsing using getopt() and it avoids
>>>>> common errors. As the named maintainer I decided to look at how to make
>>>>> more use of it.
>>>>>
>>>>> So this series explores the impact of converting a few commands to use
>>>>> getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
>>>>> anywhere in the cmdline and provides a few helpers to reduce
>>>>> boilerplate.
>>>>>
>>>>> The chosen commands are:
>>>>>
>>>>> - echo: very simple with no flags
>>>>> - hash: fairly simple with just one flag
>>>>> - env grep/export/import - fuller examples
>>>>>
>>>>> The series also adds a recommendation to use getopt() for new commands.
>>>>>
>>>>> To try to reduce the code-size increase, a lower-case function is added
>>>>> and called from a few places. The difference is fairly marginal.
>>>>>
>>>>> Overall, the result is not pretty (see below) with about a 1.1K size
>>>>> increase on arm64:
>>>>
>>>> I think that means this is a no-go, and you need to work out what might
>>>> lead to a much smaller growth here.
>>>>
>>>
>>> Unfortunately, the only way to get a size reduction is to convert as many
>>> commands as possible.
>>>
>>> --Sean
>>
>> And to expand on this, you really only get a reduction for any given command
>> when there are several options being parsed already like in the nvedit stuff.
>> Since most U-Boot commands don't use options it will be difficult to get a
>> reduction even when converting most commands on a board.
> 
> We don't even see a reduction on "qcom" which is a platform that already
> enabled GETOPT. nvedit is growth too:
> 01: Prepare v2026.07-rc2
> 02: lib: string: Add strlower()
>     aarch64: (for 1/1 boards) data -40.0 rodata +40.0
>              qcom           : data -40 rodata +40
> 03: cmd: ini: Use strlower() to normalise case
> 04: fs: fat: Use strlower() to normalise case
> 05: boot: pxe_utils: Use strlower() in get_string()
> 06: lib: getopt: Permute by default with inline reorder
>     aarch64: (for 1/1 boards) all -6.0 data -24.0 rodata +18.0
>              qcom           : all -6 data -24 rodata +18
>                 u-boot: add: 0/0, grow: 5/-1 bytes: 272/-8 (264)
>                   function                                   old     new   delta
>                   __getopt                                   576     756    +180
>                   getopt_init_state                           12      88     +76
>                   do_log_filter_remove                       364     372      +8
>                   do_log_filter_list                         444     448      +4
>                   do_log_filter_add                          580     584      +4
>                   do_bdinfo                                  160     152      -8

I expected this to grow due to reordering

> 07: lib: getopt: Add getopt_pop() helper
> 08: cmd: echo: Use getopt() with '+' prefix for option parsing
>     aarch64: (for 1/1 boards) all +3.0 rodata +3.0
>              qcom           : all +3 rodata +3
>                 u-boot: add: 0/0, grow: 1/0 bytes: 68/0 (68)
>                   function                                   old     new   delta
>                   do_echo                                    156     224     +68
> 09: cmd: hash: Use getopt() for option parsing
> 10: cmd: nvedit: Use getopt() in env grep
> 11: cmd: nvedit: Use getopt() in env export and env import
>     aarch64: (for 1/1 boards) all -4.0 data -16.0 rodata +12.0
>              qcom           : all -4 data -16 rodata +12
>                 u-boot: add: 0/0, grow: 2/0 bytes: 164/0 (164)
>                   function                                   old     new   delta
>                   do_env_import                              692     832    +140
>                   do_env_export                              608     632     +24

But I thought the nvedit stuff would result in a size reduction. There are 4-5 options
for each command, so the env stuff is basically a best-case scenario. Maybe we
need to revisit the getopt interface.

> 12: doc: commands: Recommend getopt() for option parsing
> 
>> That's why I used it for new commands where no one could complain that
>> I grew their board.
>>
>> I think it would be nice for all u-boot commands to have proper option support
>> like in barebox, but it's a lot of effort.
> 
> Yes, it would be good to move in that direction. But we need to figure
> out how to do it in such a way that's not such a big size loss. If we
> have to do a big conversion to start with, fine. If we have to
> restructure a few other things, fine. But "convert echo so everyone
> links it now and it's sunk-cost" isn't the right path.

