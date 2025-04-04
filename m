Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B6AC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 21:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0698829E7;
	Fri,  4 Apr 2025 23:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rWnSgQ05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D90829E7; Fri,  4 Apr 2025 23:21:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FB29829C3
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 23:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a667=WX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743801660;
 bh=pgwwT6nWp7O8bBpe9IiVdqVZ5M8ntQOsoXxSZpc40yI=;
 b=rWnSgQ05Qkxj1SoCg4mdMS7KbeBRiU0Or2HNdo6Mbd6aPXIY0mUmNaJu60HMYbZk0Y4VpzPiG
 S6o1R/mqP/Cq8wlqbijVH0EgqM6WySdGGXSYbNuMst5qoLt9DbrJOg3R6SAGyhqVEUTmZbzlVqS
 GJ45Bvxg0vaUPt8jS7Oind/EP+rBdMoUJvNMaoKKZqjNxHTyiu6N675HtwrDHN53ga3XEI6xHEo
 EEibHNqvSVyJE2JiPmwl3L6ayTXUQLqnHq9j620tIAF/2buuT38nkA0wbUbh2N7yl5cR+MddoEM
 gR+aKHBhiWVIJ0hOWB+gguJp5NtiFP/2X87G/o30WSbQ==
X-Forward-Email-ID: 67f04d36c2f7eb854e910651
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f8e19d51-7656-4d3f-81ea-05b4e8c6f0f6@kwiboo.se>
Date: Fri, 4 Apr 2025 23:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/29] pxe: Precursor series for supporting read_all()
 in extlinux / PXE
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
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
 <20250403215618.GP5495@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250403215618.GP5495@bill-the-cat>
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

Hi Tom,

On 2025-04-03 23:56, Tom Rini wrote:
> On Thu, Apr 03, 2025 at 10:57:24PM +0200, Jonas Karlman wrote:
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
> Ugh. I thought the decompression buffer, which we would be just lmb'ing,
> was some multiple of the compressed image. Can you please bisect down to
> which commit in the series broke this?
> 

The commit b13408021d36 ("boot: pxe: Use bootm_...() functions where
possible") contains the change from using current do_booti() from
cmd/booti.c to use the bootm based booti_run().

do_booti() from cmd/booti.c was not migrated to use the new booti_run()
and thus continue to use a 10x multiple of the kernel_comp_size env var
as the size for decompression buffer.

However the bootm based booti_run() instead use SYS_BOOTM_LEN as the
size for decompression buffer, so this is a change for extlinux boot
that should not affect when the booti cmd in a boot script.

Additionally the booti cmd should probably have been converted to use
the bootm base booti_run() in this series. As-is there is two different
handing for booti in next.

Regards,
Jonas

