Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12DCC5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 18:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DD3811AC;
	Mon,  2 Jun 2025 20:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fUgruJxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CBC8144A; Mon,  2 Jun 2025 20:35:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9093280584
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 20:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748889337; x=1749494137; i=xypron.glpk@gmx.de;
 bh=WyQzYGhDAvQdspvvAefkFUXro/2ap3WDB8wEPvF/Ofw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fUgruJxe8jgcZLnW/PeY2osn5p4FuAQZSOTCqgr8HWk3aOzEfP24OihZrNYBmV+F
 VkmxzkolWvrxAplsQizQBIZlkQwrlHEKtTK4sWF1A1rlDYWf5aOSjyz3g+BkKkhVG
 9+5wPtSJwLi8O5NA78tCuAZyJGcdLqZpYmzKLy+ySRBl273Qr4MUfB0wII/3+F47w
 dwg+8ikMlxju5J96Zb2nMJpSP1Os6fvS/Ltm4JrVkWEowe7vRSmLYjTFZoNVWlFpq
 WA5u8SLUjrmw5BP05iFBSRlgDL4jM2msTfTjKe16B0/4A0MC6hAidBMymUr73vCLR
 5ZCctQZVB9Mpad9OGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1uvDi50OH2-00kJq9; Mon, 02
 Jun 2025 20:35:37 +0200
Date: Mon, 02 Jun 2025 20:35:31 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
CC: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH 0/3] sntp for NET_LWIP
User-Agent: Thunderbird for Android
In-Reply-To: <a3ee52c2-0ee9-48b0-9cfc-a0efcb02907a@freeshell.de>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <CAJ+vNU08-=eWAceEedRg7RabqB-BKO_1F+8EkDHB8zHg79VK3g@mail.gmail.com>
 <af397cfc-e222-4ed6-b8d7-802d9080dbfa@linaro.org>
 <a3ee52c2-0ee9-48b0-9cfc-a0efcb02907a@freeshell.de>
Message-ID: <91F2F809-9971-45FD-8B45-30AE56E166A1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:diH+WKYSZMj27nkhCaIciKxUWThPAsneZ2a12R85/0FK6acpZIu
 ul8hzpeebOKmpaL5N7jksjQZPqrgEno8n1GzNmXeFjrNuBctwpcZTVaeNto/Alij1XWYef3
 99rc+cRVhat6461i4vzVmrEc6vuU4bX0QXVISrF52S4htJHkZUO4AwxXDav8SLiySpoe/68
 WB8K2QGz/gFlQSFU2892A==
UI-OutboundReport: notjunk:1;M01:P0:ZEt2H073oLE=;mbIV/OJ2Bk5wXndQjbGN1bQPWk+
 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
 uuHk=
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

Am 2=2E Juni 2025 20:06:08 MESZ schrieb E Shattow <e@freeshell=2Ede>:
>
>
>On 6/2/25 01:11, Jerome Forissier wrote:
>> Hi Tim,
>>=20
>> On 5/30/25 17:46, Tim Harvey wrote:
>>> On Wed, May 21, 2025 at 8:15=E2=80=AFAM Jerome Forissier
>>> <jerome=2Eforissier@linaro=2Eorg> wrote:
>>>>
>>>> Implement the sntp command with lwIP (CONFIG_NET_LWIP=3Dy)=2E SNTP is
>>>> supported as an app in lib/lwip/lwip/src/apps/sntp/sntp=2Ec so this i=
s
>>>> mainly about adding that file to the build and writing do_sntp() to u=
se
>>>> the sntp_*() API and run the receive & timer loop=2E There is a patch=
 to
>>>> extract a small bit of common code from net/sntp=2Ec to avoid duplica=
tion=2E
>>>> The QEMU arm64 lwIP defconfig is updated to provide the sntp command =
by
>>>> default for convenience=2E
>>>> I could not test the case when the NTP server IP is provided by DHCP=
=2E If
>>>> someone has access right away to such a configuration and in case it
>>>> does not work, please let me know=2E
>>>>
>>>>
>>>> Jerome Forissier (3):
>>>>   net: extract function net_sntp_set_rtc() from sntp_handler()
>>>>   net: lwip: add sntp command
>>>>   configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
>>>>
>>>>  cmd/Kconfig                       |  13 +--
>>>>  cmd/net-lwip=2Ec                    |   5 ++
>>>>  configs/qemu_arm64_lwip_defconfig |   1 +
>>>>  include/net-common=2Eh              |  13 +++
>>>>  lib/lwip/Makefile                 |   1 +
>>>>  lib/lwip/u-boot/arch/cc=2Eh         |   4 +
>>>>  lib/lwip/u-boot/lwipopts=2Eh        |   4 +
>>>>  net/lwip/Makefile                 |   1 +
>>>>  net/lwip/sntp=2Ec                   | 128 ++++++++++++++++++++++++++=
++++
>>>>  net/net-common=2Ec                  |  28 +++++++
>>>>  net/sntp=2Ec                        |  23 +-----
>>>>  11 files changed, 195 insertions(+), 26 deletions(-)
>>>>  create mode 100644 net/lwip/sntp=2Ec
>>>>
>>>
>>> Hi Jerome,
>>>
>>> Thanks for the continued work on lwIP!
>>=20
>> Sure=2E Thank you for testing and fixing bugs :)
>> =20
>>> For the series:
>>> Reviewed-by: Tim Harvey <tharvey@gateworks=2Ecom>
>>>
>>> Note that if this is merged before my series we'll want to have a
>>> followup that removes the sys_check_timeouts() after net_lwip_rx(udev,
>>> netif), or if it is merged before my series I can send a v3 that does
>>> it=2E
>>=20
>> Both series are in my patchwork queue, so I'll take care of that=2E Tha=
nks
>> for the heads up=2E
>>=20
>>> Do you have a list of lwIP features you're still working on? I'm going
>>> to be moving the Gateworks venice boards to it as things look pretty
>>> good=2E The only thing I saw that was missing was TFTPPUT which I don'=
t
>>> really care about=2E
>>=20
>> I don't have any thing left in my to-do list for lwIP at the moment=2E =
There
>> are several U-Boot features that are still not supported with NET_LWIP=
=2E As
>> you said TFTP PUT but also IPv6, the bootp command, as well as ncsi, et=
hsw,
>> and wol (those are found in cmd/Kconfig)=2E Maybe other things, I don't=
 know=2E
>>=20
>> BR,
>
>Getting data off from the U-Boot device under test is missing some
>similar function today=2E It would be enough to re-implement tftpput but =
I
>rather like the convenience of "wget" to do everything from host and
>from U-Boot device=2E
>
>Before LwIP and missing tftpput I did use tftpput:
>
>1=2E Send data from memory address range read from some flash peripheral
>
>2=2E Send data from files on attached storage filesystem (repeat
>intermediate step to read each file to memory address)=2E
>
>The tftpput command is useful for (1) and is a problem for (2)=2E
>
>Suggestion is an HTTP server command to respond with data from a memory
>address range or device filesystem i=2Ee=2E:
>
>httpd <[<address> <size>]|[<interface> [<dev[:part]>]> [filename]
>
>The command responds to HTTP GET requests until a simple timeout in
>seconds (default 0 no timeout), probably as an environment variable=2E
>There might also be an environment variable to limit the maximum number
>of requests handled (default 0 for unlimited) so that you could use this
>in a script as a kind of network operated trigger or automation=2E
>
>When first parameter is a valid memory address (default $loadaddr) then
>second parameter (default $filesize) is the size=2E A size of 0 is valid
>and does not read from the memory address also returns no data=2E Optiona=
l
>third parameter unspecified or default responds to any GET request=2E If
>third parameter is specified then only respond to GET request for that
>filename with any leading pathname stripped from the parameter=2E
>
>This would allow to simply command `httpd` after some other memory read
>operation which has set env variables for us, and optionally `httpd - -
>"filename"` if we want to be selective about the GET request that will
>read our data=2E For an HTTP request viewer specify `httpd - 0` or in a
>script for example if you want to hold up script execution until a
>certain number of valid network requests for "secret" resource but don't
>care about the return data, something like `httpd - 0 "secret"` and the
>appropriate environment variable to limit successful responses before exi=
t=2E
>
>If first parameter not a valid memory address, then we assume a similar
>invocation as `ls`=2E When responding to a request if filename parameter
>is then a valid directory respond with a directory listing, else serve
>that file=2E File not found is 404 response but does not exit=2E
>
>This overloading of both memory address and device filesystem works if
>there are not any devices that are named with address values=2E If that i=
s
>too much then split to `httpd` and `httpdmem` i=2Ee=2E two commands=2E
>
>Overall with LwIP adding HTTP `wget` command we are able to simply start
>a host HTTP server to get files from, and this is easy on most host
>systems that have Python lang:
>
>$ python3 -m http=2Eserver 8080
>
>I hope this description is useful?
>
>- E Shattow

Implementing a robust and safe HTTP server is not trivial=2E

If you want to use http to transport a file out of U-Boot, you should impl=
ement a HTTP POST command=2E

https://pypi=2Eorg/project/uploadserver/ allows you to easily spin up an H=
TTP server=2E

I would favor focussing on reaching feature parity to eliminate the old ne=
twork stack before implementing new features=2E

Best regards

Heinrich


