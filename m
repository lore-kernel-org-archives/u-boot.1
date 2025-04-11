Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07895C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7768084047;
	Fri, 11 Apr 2025 15:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0EA483EE2; Fri, 11 Apr 2025 09:24:11 +0200 (CEST)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B1C82B39
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=05Ho=W5=kaod.org=clg@ozlabs.org
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZYp8P4nYbz4x43;
 Fri, 11 Apr 2025 17:24:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZYp8M1jj4z4wbZ;
 Fri, 11 Apr 2025 17:24:02 +1000 (AEST)
Message-ID: <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
Date: Fri, 11 Apr 2025 09:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
To: Tom Rini <trini@konsulko.com>, Joel Stanley <joel@jms.id.au>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, open list
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
 <20250410231444.GK5495@bill-the-cat>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250410231444.GK5495@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 11 Apr 2025 15:04:17 +0200
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

Hi,

On 4/11/25 01:14, Tom Rini wrote:
> On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
>> On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>>
>>> Hi everyone,
>>>
>>> I keep getting an error on running the CI loop on -next on my tree :
>>>
>>> https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517
>>
>> Thanks for the report.
>>
>>>
>>> ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no other
>>> tests will run !
>>>
>>> Any clue ? It's been like this for few days. It doesn't look like a
>>> faulty patch.
>>
>> I can't see that link you sent me, it 403s.
>>
>> Do you have any other traces or information to share?
> 
> It's been intermittent recently. I was able to put qemu + gdb together
> and see it's one of the early initcalls that fails and hang()s but
> didn't see why. You should be able to use commit 1f0281294d8b ("Merge
> patch series "Annotate switch/case fallthrough cases"") as a starting
> point of failure.
> 

Do you have logs ?

Things look ok from the QEMU side (latest 10.0.0-rc and 9.1) :
     
     uboot_build=/path/to/u-boot/
     flashsize=65536
     flash=./flash-ast2600-evb-uboot
     dd of=$flash bs=1K if=/dev/zero count=$flashsize
     dd of=$flash conv=notrunc bs=1K if=$uboot_build/spl/u-boot-spl.bin
     dd of=$flash conv=notrunc bs=1K if=$uboot_build/u-boot.img seek=64
     
     $ qemu-system-arm -M ast2600-evb -net nic,netdev=net0 -netdev user,id=net0 -nographic -snapshot -serial mon:stdio   -drive file=flash-ast2600-evb-uboot,format=raw,if=mtd
     qemu-system-arm: warning: nic ftgmac100.1 has no peer
     qemu-system-arm: warning: nic ftgmac100.2 has no peer
     qemu-system-arm: warning: nic ftgmac100.3 has no peer
     
     U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200)
     Trying to boot from RAM
     ## Checking hash(es) for config conf-1 ... OK
     ## Checking hash(es) for Image firmware-1 ... crc32+ OK
     ## Checking hash(es) for Image fdt-1 ... crc32+ OK
     
     
     U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200)
     
     Model: Aspeed BMC
     DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64 MiB), ECC off
     Core:  266 devices, 24 uclasses, devicetree: separate
     WDT:   Started watchdog@1e785000 with servicing every 1000ms (60s timeout)
     MMC:   sdhci@1e750100: 0
     Loading Environment from SPIFlash... SF: Detected mx25u51245g with page size 256 Bytes, erase size 64 KiB, total 64 MiB
     *** Warning - bad CRC, using default environment
     
     In:    serial@1e784000
     Out:   serial@1e784000
     Err:   serial@1e784000
     Net:   eth0: ftgmac@1e660000, eth1: ftgmac@1e680000, eth2: ftgmac@1e670000, eth3: ftgmac@1e690000
     Hit any key to stop autoboot:  0
     libfdt fdt_check_header(): FDT_ERR_BADMAGIC
     Error loading kernel FIT image
     =>
     

Thanks,

C.


