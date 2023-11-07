Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE7DC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924FE87694;
	Wed,  8 Nov 2023 00:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C/wJMqvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2702E876B5; Wed,  8 Nov 2023 00:50:15 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 7145B8761A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [10.7.98.35] (unknown [167.220.24.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id AB36A20B74C0;
 Tue,  7 Nov 2023 15:50:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB36A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1699401008;
 bh=g2K/COOjn4b6WCdwM19MHQpAq5LJo3gtRHqMT73bhS4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C/wJMqvoRF6eQKfELFtQ7eRiuwTa2EUel3LHtak8uEpu7KQBMf/KfJ+gkBViZMCYo
 t0zZlRMej6bLEzE4XpUMEfbROys3FlMF/La8eaOMWX4tkILbiClOpR9nyz2CTokjJv
 Y4anqx+rdK6cIexVWZAGaSJpC1LFAXjgSO+yf4kc=
Message-ID: <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
Date: Tue, 7 Nov 2023 15:50:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
Content-Language: en-GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
 <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2023-11-04 12:53 a.m., Heinrich Schuchardt wrote:
> On 11/4/23 03:03, Sean Edmond wrote:
>>
>> On 2023-10-23 10:54 p.m., Heinrich Schuchardt wrote:
>>> On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
>>>> From: Sean Edmond <seanedmond@microsoft.com>
>>>>
>>>> Allow dhcp server pass pxe config file full path by using option 209
>>>>
>>>> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
>>>> ---
>>>>   cmd/Kconfig |  4 ++++
>>>>   cmd/pxe.c   | 10 ++++++++++
>>>>   net/bootp.c | 21 +++++++++++++++++++++
>>>>   3 files changed, 35 insertions(+)
>>>>
>>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>>> index 5bc0a92d57..adbb1a6187 100644
>>>> --- a/cmd/Kconfig
>>>> +++ b/cmd/Kconfig
>>>> @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
>>>>       default 0x15 if ARM
>>>>       default 0x0 if X86
>>>>
>>>> +config BOOTP_PXE_DHCP_OPTION
>>>> +    bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
>>>> +    depends on BOOTP_PXE
>>>
>>> Why should this be disabled by default?
>>>
>>> Do we really want a separate config variable?
>>>
>> I expect most won't use this option to get the file path (they'll use
>> the default paths as per the PXE specification).  It makes more sense
>> for me to keep it optional, like many of the other options?
>
> RFC 5701 seems to require this option. Hence we should make it default
> yes. Boards that have a build size issue can opt out.

The PXELINUX specification 
(https://wiki.syslinux.org/wiki/index.php?title=PXELINUX) doesn't state 
that option 209 is required. In the abense of option 209, PXELINUX will 
try the following default configuration files (this example is provided 
on the wiki link):
  /mybootdir/pxelinux.cfg/b8945908-d6a6-41a9-611d-74a6ab80b83d
  /mybootdir/pxelinux.cfg/01-88-99-aa-bb-cc-dd
  /mybootdir/pxelinux.cfg/C0A8025B
  /mybootdir/pxelinux.cfg/C0A8025
  /mybootdir/pxelinux.cfg/C0A802
  /mybootdir/pxelinux.cfg/C0A80
  /mybootdir/pxelinux.cfg/C0A8
  /mybootdir/pxelinux.cfg/C0A
  /mybootdir/pxelinux.cfg/C0
  /mybootdir/pxelinux.cfg/C
  /mybootdir/pxelinux.cfg/default

If 209 is requested/provided it tries the provided "config file" before 
the default paths.  RFC 5071 should be seen as an extension for PXELINUX 
(not a requirement).  RFC 5071 only states "The Config File Option MUST 
be supplied by the DHCP server if it appears on the Parameter Request List".

>
> Best regards
>
> Heinrich
>
>>>> +
>>>>   config BOOTP_VCI_STRING
>>>>       string
>>>>       depends on CMD_BOOTP
>>>> diff --git a/cmd/pxe.c b/cmd/pxe.c
>>>> index 704589702f..9404f44518 100644
>>>> --- a/cmd/pxe.c
>>>> +++ b/cmd/pxe.c
>>>> @@ -65,6 +65,8 @@ static int pxe_dhcp_option_path(struct pxe_context
>>>> *ctx, unsigned long pxefile_a
>>>>       int ret = get_pxe_file(ctx, pxelinux_configfile, 
>>>> pxefile_addr_r);
>>>>
>>>>       free(pxelinux_configfile);
>>>> +    /* set to NULL to avoid double-free if DHCP is tried again */
>>>> +    pxelinux_configfile = NULL;
>>>>
>>>>       return ret;
>>>>   }
>>>> @@ -141,6 +143,14 @@ int pxe_get(ulong pxefile_addr_r, char
>>>> **bootdirp, ulong *sizep, bool use_ipv6)
>>>>                 env_get("bootfile"), use_ipv6))
>>>>           return -ENOMEM;
>>>>
>>>> +    if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
>>>> +        pxelinux_configfile && !use_ipv6) {
>>>> +        if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
>>>> +            goto done;
>>>> +
>>>> +        goto error_exit;
>>>> +    }
>>>> +
>>>>       if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OPTION) &&
>>>>           pxelinux_configfile && use_ipv6) {
>>>>           if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
>>>> diff --git a/net/bootp.c b/net/bootp.c
>>>> index 7b0f45e18a..6800290963 100644
>>>> --- a/net/bootp.c
>>>> +++ b/net/bootp.c
>>>> @@ -26,6 +26,7 @@
>>>>   #ifdef CONFIG_BOOTP_RANDOM_DELAY
>>>>   #include "net_rand.h"
>>>>   #endif
>>>> +#include <malloc.h>
>>>>
>>>>   #define BOOTP_VENDOR_MAGIC    0x63825363    /* RFC1048 Magic 
>>>> Cookie */
>>>>
>>>> @@ -601,6 +602,10 @@ static int dhcp_extended(u8 *e, int
>>>> message_type, struct in_addr server_ip,
>>>>       *e++  = 42;
>>>>       *cnt += 1;
>>>>   #endif
>>>> +    if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
>>>> +        *e++ = 209;    /* PXELINUX Config File */
>>>> +        *cnt += 1;
>>>> +    }
>>>>       /* no options, so back up to avoid sending an empty request
>>>> list */
>>>>       if (*cnt == 0)
>>>>           e -= 2;
>>>> @@ -909,6 +914,22 @@ static void dhcp_process_options(uchar *popt,
>>>> uchar *end)
>>>>                   net_boot_file_name[size] = 0;
>>>>               }
>>>>               break;
>>>> +        case 209:    /* PXELINUX Config File */
>>>
>>> This 209 appears in multiple places. Please, define a constant, e.g.
>>> DHCP_OPTION_CONFIG_FILE, in bootp.h and use the symbolic name. Please,
>>> document the constant referring to RFC 5071.
>> fixed in v3.
>>>
>>>> +            if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
>>>> +                /* In case it has already been allocated when get
>>>> DHCP Offer packet,
>>>> +                 * free first to avoid memory leak.
>>>> +                 */
>>>> +                if (pxelinux_configfile)
>>>> +                    free(pxelinux_configfile);
>>>> +
>>>> +                pxelinux_configfile = (char *)malloc((oplen + 1) *
>>>> sizeof(char));
>>>> +
>>>> +                if (pxelinux_configfile)
>>>> +                    strlcpy(pxelinux_configfile, popt + 2, oplen + 
>>>> 1);
>>>> +                else
>>>> +                    printf("Error: Failed to allocate
>>>> pxelinux_configfile\n");
>>>
>>> We do the same in dhcp6_parse_options(). Please, factor out a common
>>> function to avoid code duplication.
>> I would prefer to keep these seperate for several reasons:
>> - our DHCP server team has asked for the DHCP6 "pxe config file" parsing
>> to change.  I attempted to add to upstream here:
>> https://lore.kernel.org/u-boot/20230725231329.5653-1-seanedmond@linux.microsoft.com/. 
>> I will attempt to submitted that patch again
>> - PXE config file isn't standardized yet for DHCPv6 (the current
>> implementation was a proposal from our DHCP server team)
>> - LWIP will eventually superceed bootp.c in u-boot, but we'll probably
>> be keeping dhcpv6.c for a bit (keeping the duplicate code will make the
>> migration easier)
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>> +            }
>>>> +            break;
>>>>           default:
>>>>   #if defined(CONFIG_BOOTP_VENDOREX)
>>>>               if (dhcp_vendorex_proc(popt))
