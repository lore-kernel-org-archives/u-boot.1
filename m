Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7B3C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 18:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BAB180F9C;
	Mon,  2 Jun 2025 20:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B0E811AC; Mon,  2 Jun 2025 20:06:15 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33AC80AE1
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 20:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.63.165])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2246DB4C34F9;
 Mon,  2 Jun 2025 20:06:09 +0200 (CEST)
Message-ID: <a3ee52c2-0ee9-48b0-9cfc-a0efcb02907a@freeshell.de>
Date: Mon, 2 Jun 2025 11:06:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sntp for NET_LWIP
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
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
 <af397cfc-e222-4ed6-b8d7-802d9080dbfa@linaro.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <af397cfc-e222-4ed6-b8d7-802d9080dbfa@linaro.org>
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



On 6/2/25 01:11, Jerome Forissier wrote:
> Hi Tim,
> 
> On 5/30/25 17:46, Tim Harvey wrote:
>> On Wed, May 21, 2025 at 8:15 AM Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> Implement the sntp command with lwIP (CONFIG_NET_LWIP=y). SNTP is
>>> supported as an app in lib/lwip/lwip/src/apps/sntp/sntp.c so this is
>>> mainly about adding that file to the build and writing do_sntp() to use
>>> the sntp_*() API and run the receive & timer loop. There is a patch to
>>> extract a small bit of common code from net/sntp.c to avoid duplication.
>>> The QEMU arm64 lwIP defconfig is updated to provide the sntp command by
>>> default for convenience.
>>> I could not test the case when the NTP server IP is provided by DHCP. If
>>> someone has access right away to such a configuration and in case it
>>> does not work, please let me know.
>>>
>>>
>>> Jerome Forissier (3):
>>>   net: extract function net_sntp_set_rtc() from sntp_handler()
>>>   net: lwip: add sntp command
>>>   configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
>>>
>>>  cmd/Kconfig                       |  13 +--
>>>  cmd/net-lwip.c                    |   5 ++
>>>  configs/qemu_arm64_lwip_defconfig |   1 +
>>>  include/net-common.h              |  13 +++
>>>  lib/lwip/Makefile                 |   1 +
>>>  lib/lwip/u-boot/arch/cc.h         |   4 +
>>>  lib/lwip/u-boot/lwipopts.h        |   4 +
>>>  net/lwip/Makefile                 |   1 +
>>>  net/lwip/sntp.c                   | 128 ++++++++++++++++++++++++++++++
>>>  net/net-common.c                  |  28 +++++++
>>>  net/sntp.c                        |  23 +-----
>>>  11 files changed, 195 insertions(+), 26 deletions(-)
>>>  create mode 100644 net/lwip/sntp.c
>>>
>>
>> Hi Jerome,
>>
>> Thanks for the continued work on lwIP!
> 
> Sure. Thank you for testing and fixing bugs :)
>  
>> For the series:
>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
>>
>> Note that if this is merged before my series we'll want to have a
>> followup that removes the sys_check_timeouts() after net_lwip_rx(udev,
>> netif), or if it is merged before my series I can send a v3 that does
>> it.
> 
> Both series are in my patchwork queue, so I'll take care of that. Thanks
> for the heads up.
> 
>> Do you have a list of lwIP features you're still working on? I'm going
>> to be moving the Gateworks venice boards to it as things look pretty
>> good. The only thing I saw that was missing was TFTPPUT which I don't
>> really care about.
> 
> I don't have any thing left in my to-do list for lwIP at the moment. There
> are several U-Boot features that are still not supported with NET_LWIP. As
> you said TFTP PUT but also IPv6, the bootp command, as well as ncsi, ethsw,
> and wol (those are found in cmd/Kconfig). Maybe other things, I don't know.
> 
> BR,

Getting data off from the U-Boot device under test is missing some
similar function today. It would be enough to re-implement tftpput but I
rather like the convenience of "wget" to do everything from host and
from U-Boot device.

Before LwIP and missing tftpput I did use tftpput:

1. Send data from memory address range read from some flash peripheral

2. Send data from files on attached storage filesystem (repeat
intermediate step to read each file to memory address).

The tftpput command is useful for (1) and is a problem for (2).

Suggestion is an HTTP server command to respond with data from a memory
address range or device filesystem i.e.:

httpd <[<address> <size>]|[<interface> [<dev[:part]>]> [filename]

The command responds to HTTP GET requests until a simple timeout in
seconds (default 0 no timeout), probably as an environment variable.
There might also be an environment variable to limit the maximum number
of requests handled (default 0 for unlimited) so that you could use this
in a script as a kind of network operated trigger or automation.

When first parameter is a valid memory address (default $loadaddr) then
second parameter (default $filesize) is the size. A size of 0 is valid
and does not read from the memory address also returns no data. Optional
third parameter unspecified or default responds to any GET request. If
third parameter is specified then only respond to GET request for that
filename with any leading pathname stripped from the parameter.

This would allow to simply command `httpd` after some other memory read
operation which has set env variables for us, and optionally `httpd - -
"filename"` if we want to be selective about the GET request that will
read our data. For an HTTP request viewer specify `httpd - 0` or in a
script for example if you want to hold up script execution until a
certain number of valid network requests for "secret" resource but don't
care about the return data, something like `httpd - 0 "secret"` and the
appropriate environment variable to limit successful responses before exit.

If first parameter not a valid memory address, then we assume a similar
invocation as `ls`. When responding to a request if filename parameter
is then a valid directory respond with a directory listing, else serve
that file. File not found is 404 response but does not exit.

This overloading of both memory address and device filesystem works if
there are not any devices that are named with address values. If that is
too much then split to `httpd` and `httpdmem` i.e. two commands.

Overall with LwIP adding HTTP `wget` command we are able to simply start
a host HTTP server to get files from, and this is easy on most host
systems that have Python lang:

$ python3 -m http.server 8080

I hope this description is useful?

- E Shattow
