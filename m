Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D96E1088E58
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 01:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DAA838FA;
	Thu, 19 Mar 2026 02:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="Cgo3c3RI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F0A83952; Thu, 19 Mar 2026 02:18:39 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CA2836D3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 02:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1773883110;
 bh=jaCpE/W38L134pmWsQU3E3os5hLeARCaH6zm/a1WJlM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Cgo3c3RIAeIVpPMe7KMDeQuOvqypkfbJFKGdNhXy/BZzc2JpwEfVBYXlelgMiVCMq
 D+8kVjyJKbkwpsOzZlm8rrvF/O1SbfeHDyzi+gtuM3xZhksgq6P03WQFOzpQGovDrj
 Vkg7/MqB7YcpYimaM52VqITWMHvLChW7pyl51s1FZWwtur3xnN0lrm5qhLXRNCfcyu
 4Cb2CNENEzGQrB3mdXUOfqTnu8soFhsQaBBw8fURDVd8JqXyWDc0dtO+kaTApr+lg4
 9wzDmFaHKpKXLyQOC3lxOKZybSc8LCdm1dG5/0vJe5Zesskzz8r8/6t3qodlchXGts
 ojXDfnLJzQEUQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6F754B22007B;
 Thu, 19 Mar 2026 02:18:29 +0100 (CET)
Message-ID: <24f7f483-b02e-46dc-ad87-bc033324d277@freeshell.de>
Date: Wed, 18 Mar 2026 18:18:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
To: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20260317012449.4162666-1-trini@konsulko.com>
 <CAC_iWj+WHh14nTdYu2BUTqvSwrtHiJBJVncArPwrBqWb6kXnTA@mail.gmail.com>
 <9F36DE37-16FF-4519-9F66-A4A79F618794@gmx.de>
 <20260317134427.GU502704@bill-the-cat>
 <CALeDE9MVgs--ABnZZ4RJDOnTLM-+imKxG6iJBGmQFHHXivLMxw@mail.gmail.com>
 <20260318014701.GJ502704@bill-the-cat>
 <CALeDE9O=y6fGKd50eiW3Och7vQWKvj_DzuB9UeNLnvj0rqezmg@mail.gmail.com>
 <20260318145723.GL502704@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260318145723.GL502704@bill-the-cat>
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


On 3/18/26 07:57, Tom Rini wrote:
> On Wed, Mar 18, 2026 at 11:00:14AM +0000, Peter Robinson wrote:
>> On Wed, 18 Mar 2026 at 01:47, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Tue, Mar 17, 2026 at 04:08:22PM +0000, Peter Robinson wrote:
>>>> On Tue, 17 Mar 2026 at 13:51, Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Tue, Mar 17, 2026 at 08:42:39AM +0100, Heinrich Schuchardt wrote:
>>>>>> Am 17. März 2026 08:03:47 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
>>>>>>> Hi Tom,
>>>>>>>
>>>>>>> On Tue, 17 Mar 2026 at 03:24, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>>
>>>>>>>> As exposed by "make randconfig", we have an issue with the dependencies
>>>>>>>> for EFI_HTTP_BOOT. As this is implemeneted by running commands (as seen
>>>>>>>> by what it selects) it must depend on CMDLINE as well.
>>>>>>>>
>>>>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>>>>>
>>>>>>> In theory, you can configure UEFI with a set of prebuilt boot options.
>>>>>>> If one of them is http(s) the device will boot even if CMDLINE is not
>>>>>>> selected. I am not against this patch, but we will remove the
>>>>>>> possibility to build a firmware without cmdline that just boots to
>>>>>>> whatever is was preconfigured
>>>>>>>
>>>>>>> Cheers
>>>>>>> /Ilias
>>>>>>>> ---
>>>>>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>>>>> ---
>>>>>>>>  lib/efi_loader/Kconfig | 1 +
>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>>>>>>> index b5f81e0ff530..a9b2f813e1d5 100644
>>>>>>>> --- a/lib/efi_loader/Kconfig
>>>>>>>> +++ b/lib/efi_loader/Kconfig
>>>>>>>> @@ -600,6 +600,7 @@ config EFI_BOOTMGR
>>>>>>>>  config EFI_HTTP_BOOT
>>>>>>>>         bool "EFI HTTP Boot support"
>>>>>>>>         depends on NET || NET_LWIP
>>>>>>>> +       depends on CMDLINE
>>>>>>>>         select CMD_NET
>>>>>>>>         select CMD_DHCP
>>>>>>>>         select CMD_DNS
>>>>>>
>>>>>> Having to select commands here to get network is what needs to change. The network commands and EFI_HTTP_BOOT both should depend on configuration symbols for the protocol implementations.
>>>>>
>>>>> Yes. And this is about fixing missing dependencies, today.
>>>>>
>>>>>> @Tom: Do we have a target release when to finish the move to the LWIP stack?
>>>>>
>>>>> We do not. I'm not yet sure if all the various use cases of the legacy
>>>>> stack are fully supported now (I don't recall off-hand the NFS series
>>>>> state right now for example).
>>>>
>>>> I did see NFS patches go through the list.
>>>
>>> I saw the NFS support as well shortly after hitting send, as part of a
>>> randconfig build.
>>>
>>>> I think there's also likely some legacy usecases where non parity is
>>>> likely fine too.
>>>
>>> Perhaps the question really is, for the distribution folks, what are the
>>> use cases you know of where lwIP doesn't have support yet? That's the
>>> first big hurdle towards, likely, saying EFI_LOADER implies NET_LWIP
>>> maybe, since I know there's cases there lwIP is better for.
>>
>> I don't know of any problems or missing features, I turned in on by
>> default in Fedora across all devices for Fedora 43 (The 2025.07
>> builds) because I wanted UEFI HTTP boot and haven't had any bug
>> reports, and I suspect the features like UEFI HTTP is more useful for
>> most distros than loss of other features because a lot of vendors are
>> moving away from legacy tech like BOOTP/TFTP because of lack of
>> security and the fact most of those technologies are not usable on the
>> Edge/outside of the data centre.
>>
>> I know of one device which has tight SPI flash space (Jetson p3450)
>> which I need to look at closer to see what I can trim, but that's a
>> side point on that device.
> 
> OK. I know the NFS for lwIP request came from somewhere and wasn't just
> a fun side project. Pretty sure anyhow. So I wonder if there's other
> things like that that someone knows of.
> 

The ability to push data from memory to a remote file is missing from
LwIP (no tftpput). I have suggested previously that an simple U-Boot
HTTP server configured to respond with data from a memory address and
range, and/or to serve files from a filesystem, would be interesting
although not exactly replacing the functionality missing from the lack
of tftpput.

-E
