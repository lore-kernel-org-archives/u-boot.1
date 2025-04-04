Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3969AC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 21:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC7382A56;
	Fri,  4 Apr 2025 23:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="skeELV2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB00182A16; Fri,  4 Apr 2025 23:32:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD8C82A59
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 23:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a667=WX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743802344;
 bh=vGNwVuG3/qzvpA6AKehIkARvwrBDEITyPJt6q/Usfts=;
 b=skeELV2kG8lN87NpHbJziSnKOgWLl7oBVHLQlwewZgIvLxvAzOKxMK2otv0dPunfJIO4vJc8E
 pF+gQb7FBFVQm4OwRwlbzUPXoisL+7/4zBPuHVzcJCeamQvp/adJVC5pVCtpZ7YxdYEyiA3OhbO
 u0ifoz+wpaeueiP8Ym2U9JnOKqgMusTv5ikHEUzaPJPn9dK+r5rN+mwCmYymZaUqrubxb1G0xEk
 ASQtNtC6eobO0cVPi34LArnV3sGXxVFoE7VURUDfFQlAQ6l6JpIIMYGCdzJ3D10i8FjZhj0fIe8
 wjGZWHrCaeKTXm31u353hmhO88+waWZMa6kNmXJLkgNQ==
X-Forward-Email-ID: 67f04fe3c2f7eb854e910c21
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2ad3b1c5-b6e7-47e2-b225-834b821cc5c4@kwiboo.se>
Date: Fri, 4 Apr 2025 23:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried
 <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <174234008117.1788726.14383009154862416750.b4-ty@konsulko.com>
 <10a57d25-d484-4903-8f25-e373c451bc21@kwiboo.se>
 <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszThrij_kGPdFcdJLoxJLpoZru=_M_vG4eVKwdPAqDfQJyg@mail.gmail.com>
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

Hi Simon,

On 2025-04-04 00:30, Simon Glass wrote:
> Hi Jonas,
> 
> On Fri, 4 Apr 2025 at 09:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Tom and Simon,
>>
>> On 2025-03-19 00:21, Tom Rini wrote:
>>> On Wed, 05 Mar 2025 17:24:54 -0700, Simon Glass wrote:
>>>
>>>> This series includes some patches related to allowing read_all() to be
>>>> used with the extlinux / PXE bootmeths.
>>>>
>>>> These patches were split out from the stb4 series, since it will need to
>>>> have additional patches for LWIP, to avoid breaking PXE booting when
>>>> LWIP is used.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>
>> This series broke booting a compressed arm64 defconfig Linux kernel
>> (without module loading) due to changes in decompression buffer length.
>>
>> My arm64 defconfig kernel (Image.gz) is ~24 MiB compressed and ~85 MiB
>> uncompressed.
>>
>> Before this series the decompression buffer was 10x the kernel_comp_size
>> and now it is instead limited by the SYS_BOOTM_LEN Kconfig symbol.
>>
>> A broken boot using current next branch:
>>
>>   Retrieving file: /Image.gz
>>   Retrieving file: /initramfs.cpio.gz
>>   append: earlycon
>>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16350' images 000000003ffe53a0
>>      kernel data at 0x02080000, len = 0x00000000 (0)
>>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
>>   find_other type 2 os 5
>>   ## Flattened Device Tree blob at 3df16350
>>      Booting using the fdt blob at 0x3df16350
>>   Working FDT set to 3df16350
>>   load_os load 8000000 image_start 2080000 image_len 2000000
>>      Uncompressing Kernel Image to 8000000
>>   Error: inflate() returned -5
>>   Image too large: increase CONFIG_SYS_BOOTM_LEN
>>   Must RESET board to recover
>>   Resetting the board...
>>
>> Changing SYS_BOOTM_LEN from default 64 MiB to 128 MiB fixed the boot:
>>
>>   Retrieving file: /Image.gz
>>   Retrieving file: /initramfs.cpio.gz
>>   append: earlycon
>>   cmd 'booti' states 1f1f addr_img '0x02080000' conf_ramdisk '0x06000000:394d3c' conf_fdt '3df16430' images 000000003ffe5480
>>      kernel data at 0x02080000, len = 0x00000000 (0)
>>   load 2080000 start 2080000 len 0 ep 0 os 5 comp 1
>>   find_other type 2 os 5
>>   ## Flattened Device Tree blob at 3df16430
>>      Booting using the fdt blob at 0x3df16430
>>   Working FDT set to 3df16430
>>   load_os load 8000000 image_start 2080000 image_len 2000000
>>      Uncompressing Kernel Image to 8000000
>>      kernel loaded at 0x08000000, end = 0x0d3b5a00
>>      Loading Ramdisk to 3cb51000, end 3cee5d3c ... OK
>>      Loading Device Tree to 000000003cb3f000, end 000000003cb509df ... OK
>>   Working FDT set to 3cb3f000
>>
>>   Starting kernel ...
>>
>> Do we need to increase the default SYS_BOOTM_LEN for ARM64 now?
> 
> Are you using the 'booti' command? Can you post a bit more console
> output or a script here as it isn't clear what boot command you are
> using? For now I'm going to assume booti

Above was using an extlinux.conf with bootstd, not using the booti cmd.

Use of booti cmd is not affected as it continue to use a 10x multiple
of the kernel_comp_size env var for buffer size.

The change this series introduced was instead of the 10x multiple of
kernel_comp_size now use SYS_BOOTM_LEN for buffer size (320 vs 32 MiB).

And because cmd/booti.c was not converted there is now two different
handling of this decompression buffer size.

If the change to now use SYS_BOOTM_LEN was intended this need to be
changed as it has mostly been irrelevant for booting Linux on AArch64
boards prior to this series.

Regards,
Jonas

> 
> do_booti() calls bootm_run_states() without the BOOTM_STATE_LOADOS
> state in the mask, so I wonder why (as it seems) bootm_run_states() is
> calling bootm_load_os()*
> 
> So from what I can tell it is loading the OS once in booti_start() and
> again in bootm_load_os(). If so, I don't know why.
> 
> In any case, honouring CONFIG_SYS_BOOTM_LEN for loaded files is the
> correct behaviour, so yes, I think we should increase that limit. For
> now, we could add the check to the booti command, since it might be a
> while before I get back to refactoring/removing that (now-unneeded)
> code.
> 
> Regards,
> Simon
> 
> * It should be possible to remove booti_start() now that bootm
> supports booti decompression properly, but I left that for another
> day.
> 
>>
>> Regards,
>> Jonas
>>
