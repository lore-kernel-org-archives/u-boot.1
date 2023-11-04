Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7212C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A7F87007;
	Sat,  4 Nov 2023 08:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QMpFB0VA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BF486A6B; Sat,  4 Nov 2023 08:53:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7E486A6B
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699084381; x=1699689181; i=xypron.glpk@gmx.de;
 bh=LiSVTFFrZ332jYjF0XUn9inQe+lIrUxdFEDdK503vSg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QMpFB0VAEks52GO41pcq08gTUOI+XUK7lWmsZ01yBObmYn/nLxJv03J47ek7dNr4
 TUZGsTuCfCSB96IQ0c7CiUB7AJjQP3V2+spk08aOS4ry2TTNh4z3xbcgOpx/xlu9g
 KeLgP+bUikt7uB5kR4UNbT1kZJZdT2IaI+Bsf4OIKC8pO5uhPioWrEwBbXceWvFQZ
 OFlbpGe+dSo4rz99KWpfdGWstQk5N5wdSJAHlOa15McwE3BxiOVPliDpeB17sC0LT
 kdZdpjCkIu49eLrKmO3AlJcLIZiDERbC7HuAfCN8zbwuL4TAzPTYO5MejWzPdw86m
 NOYhdqE7SMP7VFhkWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1rA8lJ2ECO-00B7dd; Sat, 04
 Nov 2023 08:53:01 +0100
Message-ID: <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
Date: Sat, 4 Nov 2023 09:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
Content-Language: en-US, de-DE
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ejAjfgXv2F7RAD2/BjsAEQp9c8TCD/s0ZnVJvaratq8EpCxe8TS
 2pYdgBDDQGmkH9bSBSoXVpOu5tY3GH+aQ8CkYbV8Mlwn/kmwVKtz/qaCZdwbCNvKTAAIM1y
 e/4aruEyP/3CuiLhtrljQvifLejkm70QMzP7EZIB2bz+KOHegCBfsjJ4U3NWmcs/BJw8z0N
 xjHtASHlq1NZCPMChcj6g==
UI-OutboundReport: notjunk:1;M01:P0:m9oPmqyUcUk=;xfjY6i3qwPkn1KapWmcOuULOfki
 lhmlhF5BoFGWG7t0Tm67GMYshfYiB7ehcuylL8Yhj0jhPRsYjbi8FwjkXu5QDy1j9lKcCwM15
 sDzZzw/OsxDqCgI/oyYD8jQ7Xnu4OadH2jvydGx995gbpxlZsIGORi2+aceAzjamx80zm9QV8
 yXGnrqjSRyzlSjtVJmEpduTuJvWW6IjgAxkY47WGYeB2mudAJeOTWxnZvREo+sosFiSIGqgKs
 eV368BY4GbymLUF1gb0yKazrVKQbSIkQHFrMPMvARW/CrVXm+MkzgZR7HnUlfbDQULraXRBEJ
 kSlbjj2ik/y7wEDz8uRQlXIxbCr3AlEESUNLGPI+R6pLPqmyV8DXEOUICT0vTH7eBjwkmB2Or
 eHoY5aqDacFLwbhGYzJ0miz20iUKkDWUAD/pmd6aT9K8lmjvNw1QuZCxw4m7PmoZXT/8RCP4p
 yqZJwBtbz1CwwOVzi84phoF4Ve8NeawjiJRGo2d93UTLRrcd8JQNz6jNAIuqOSt5YogY2J/LJ
 IYzPtBoPA8rGSjFdDSJq8heC/BxiL5YDdUl7xs2egXiSB1Z95J1uSgp6m4oaRuySXcU6Ctqlw
 frY4v4oQquAd8l99dZM8zPzHjjbETwSG3r4XgL0G2giqvhfTo8Z5tdgSa6G8TnDNf+x/eMAFf
 cm0z8ODlDRmd7PbwntGV2YZ79vGtTZrivoxlrI2jC16aAZnB+HhUIbHUHg/uNXDS01BJCL8W9
 cHJY5CdhbP0Lu3xKXV5lxV9prbIZzIgE595JZhThbRCviDCxTLKYq1Lzk2N4pMCtj6jWtovxu
 jNacapkoowCOYCFDWyBye8XJwJtk8zJY4LIXNi7qTrlEltHXSa2RO8asWbg/teAMjXeinu2K0
 +9ImXlfsDavH4yss2MJtKlaaRuemCUY/j2ePbeI+e0pg7n3mDrZ4bMPTdBZFDBA32SJIXhMlb
 Pjapa74EnJ6pt3RmkL8BePNKhmA=
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

On 11/4/23 03:03, Sean Edmond wrote:
>
> On 2023-10-23 10:54 p.m., Heinrich Schuchardt wrote:
>> On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
>>> From: Sean Edmond <seanedmond@microsoft.com>
>>>
>>> Allow dhcp server pass pxe config file full path by using option 209
>>>
>>> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
>>> ---
>>> =C2=A0 cmd/Kconfig |=C2=A0 4 ++++
>>> =C2=A0 cmd/pxe.c=C2=A0=C2=A0 | 10 ++++++++++
>>> =C2=A0 net/bootp.c | 21 +++++++++++++++++++++
>>> =C2=A0 3 files changed, 35 insertions(+)
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index 5bc0a92d57..adbb1a6187 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default 0x15 if ARM
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default 0x0 if X86
>>>
>>> +config BOOTP_PXE_DHCP_OPTION
>>> +=C2=A0=C2=A0=C2=A0 bool "Request & store 'pxe_configfile' from BOOTP/=
DHCP server"
>>> +=C2=A0=C2=A0=C2=A0 depends on BOOTP_PXE
>>
>> Why should this be disabled by default?
>>
>> Do we really want a separate config variable?
>>
> I expect most won't use this option to get the file path (they'll use
> the default paths as per the PXE specification).=C2=A0 It makes more sen=
se
> for me to keep it optional, like many of the other options?

RFC 5701 seems to require this option. Hence we should make it default
yes. Boards that have a build size issue can opt out.

Best regards

Heinrich

>>> +
>>> =C2=A0 config BOOTP_VCI_STRING
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on CMD_BOOTP
>>> diff --git a/cmd/pxe.c b/cmd/pxe.c
>>> index 704589702f..9404f44518 100644
>>> --- a/cmd/pxe.c
>>> +++ b/cmd/pxe.c
>>> @@ -65,6 +65,8 @@ static int pxe_dhcp_option_path(struct pxe_context
>>> *ctx, unsigned long pxefile_a
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D get_pxe_file(ctx, pxelinux_=
configfile, pxefile_addr_r);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(pxelinux_configfile);
>>> +=C2=A0=C2=A0=C2=A0 /* set to NULL to avoid double-free if DHCP is tri=
ed again */
>>> +=C2=A0=C2=A0=C2=A0 pxelinux_configfile =3D NULL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> @@ -141,6 +143,14 @@ int pxe_get(ulong pxefile_addr_r, char
>>> **bootdirp, ulong *sizep, bool use_ipv6)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env_get("bootfile"), use_ipv6))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pxelinux_configfile && !us=
e_ipv6) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pxe_dhcp_option_path(&=
ctx, pxefile_addr_r) > 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to done;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_exit;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OP=
TION) &&
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pxelinux_config=
file && use_ipv6) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pxe_dhcp_op=
tion_path(&ctx, pxefile_addr_r) > 0)
>>> diff --git a/net/bootp.c b/net/bootp.c
>>> index 7b0f45e18a..6800290963 100644
>>> --- a/net/bootp.c
>>> +++ b/net/bootp.c
>>> @@ -26,6 +26,7 @@
>>> =C2=A0 #ifdef CONFIG_BOOTP_RANDOM_DELAY
>>> =C2=A0 #include "net_rand.h"
>>> =C2=A0 #endif
>>> +#include <malloc.h>
>>>
>>> =C2=A0 #define BOOTP_VENDOR_MAGIC=C2=A0=C2=A0=C2=A0 0x63825363=C2=A0=
=C2=A0=C2=A0 /* RFC1048 Magic Cookie */
>>>
>>> @@ -601,6 +602,10 @@ static int dhcp_extended(u8 *e, int
>>> message_type, struct in_addr server_ip,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *e++=C2=A0 =3D 42;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *cnt +=3D 1;
>>> =C2=A0 #endif
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *e++ =3D 209;=C2=A0=C2=A0=
=C2=A0 /* PXELINUX Config File */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *cnt +=3D 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no options, so back up to avoid send=
ing an empty request
>>> list */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*cnt =3D=3D 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e -=3D 2;
>>> @@ -909,6 +914,22 @@ static void dhcp_process_options(uchar *popt,
>>> uchar *end)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_boot_file_name[size] =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 209:=C2=A0=C2=A0=C2=
=A0 /* PXELINUX Config File */
>>
>> This 209 appears in multiple places. Please, define a constant, e.g.
>> DHCP_OPTION_CONFIG_FILE, in bootp.h and use the symbolic name. Please,
>> document the constant referring to RFC 5071.
> fixed in v3.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* In case it has already been allocated when get
>>> DHCP Offer packet,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * free first to avoid memory leak.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (pxelinux_configfile)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(pxelinux_configfile);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pxelinux_configfile =3D (char *)malloc((oplen + 1) *
>>> sizeof(char));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (pxelinux_configfile)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strlcpy(pxelinux_configfile,=
 popt + 2, oplen + 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Error: Failed to all=
ocate
>>> pxelinux_configfile\n");
>>
>> We do the same in dhcp6_parse_options(). Please, factor out a common
>> function to avoid code duplication.
> I would prefer to keep these seperate for several reasons:
> - our DHCP server team has asked for the DHCP6 "pxe config file" parsing
> to change.=C2=A0 I attempted to add to upstream here:
> https://lore.kernel.org/u-boot/20230725231329.5653-1-seanedmond@linux.mi=
crosoft.com/. I will attempt to submitted that patch again
> - PXE config file isn't standardized yet for DHCPv6 (the current
> implementation was a proposal from our DHCP server team)
> - LWIP will eventually superceed bootp.c in u-boot, but we'll probably
> be keeping dhcpv6.c for a bit (keeping the duplicate code will make the
> migration easier)
>>
>> Best regards
>>
>> Heinrich
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> =C2=A0 #if defined(CONFIG_BOOTP_VENDOREX)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (dhcp_vendorex_proc(popt))

