Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED91D148AE
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 07:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A47983B95;
	Thu,  8 Jan 2026 08:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Cad/h+Rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4F183BE1; Thu,  8 Jan 2026 08:04:16 +0100 (CET)
Received: from mx-relay130-hz1.antispameurope.com
 (mx-relay130-hz1.antispameurope.com [94.100.133.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D2C83B8A
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 08:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=04619a1675=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate130-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=rS9bhDUi1x5TLExpJ9M/thIj5MJrOo4Z/t54C3cqJlY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1767855852;
 b=emUDqGFfArWoAid9TcNlY6/r1Knno9zmBnWlhtwWmKIMD5Kc+pVrYJFNucnAOneBRlowWtkg
 krvdtJbwkHAFlibs/EaDAHbT1LA5cq3akA8Yzema01YARM67EvKN632Oss6VBCh4fV8vdjDPvdh
 gKj54hIJ/WqIHZ90pEz1XsNGUXnKoPYfC8Bm5LZ9Pj5dBjlCgg9p7na7a3QmaqWlhOcaJocHT1M
 pf0Z41f1y6Olk7C+csDsm+PKhsTsEMx9Z+gc4punyK1PvoFXEUdvwmJ948gsoJ2Ybtd+wl4lmpH
 CpusbiGeQso0YCpdOBifAEbP9jxba8UZr0tyTPP2BM+gw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1767855852;
 b=jh4jr9QabKezAoy8InjswnwFfNe6KpW1Pj/unSLSpG1NbKPm4DW0PRULvMhfD//JEKdrmKqx
 v4cz52j6NqIv2IHYx7DtuMmEudBmnN6lKCdZPdg3STvrwwJNKsRvp6MlklToPHNzhLa3TulIFC1
 tO5x6VxZOq00LUDfvPYsnQ+H/SK5c5JmnFMBgtMK+7s92tG4zNUaX508xvSqvZzqy0BZ89SqpsP
 2AlBQ7ab4glrgqgL/ZafgNap7xvG694BdZNJ3PFyWqpJZGnk1Vr/mEU+IUmGva4PtriConkw3Hp
 Pan54m3t4QP73dCI6P/vlWjy6EvI1dXJTH6S/4PY1B3Gg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay130-hz1.antispameurope.com; Thu, 08 Jan 2026 08:04:12 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 15464CC0CC9; Thu,  8 Jan 2026 08:03:56 +0100 (CET)
Message-ID: <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
Date: Thu, 8 Jan 2026 08:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Vitor Soares <ivitro@gmail.com>, u-boot@lists.denx.de
Cc: vitor.soares@toradex.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, tanmay.kathpalia@altera.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay130-hz1.antispameurope.com with 4dmwqc61f0z29vH0
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: cf16d12689146fdcb9fb68f3b3651328
X-cloud-security: scantime:2.207
DKIM-Signature: a=rsa-sha256;
 bh=rS9bhDUi1x5TLExpJ9M/thIj5MJrOo4Z/t54C3cqJlY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1767855851; v=1;
 b=Cad/h+RwdLw6E/O+JneFviYg5He4+ucnr5/Cg1wTOqx4UbT1+46M7TRZySCE6InmzorqX/tf
 pRH0ObMCB9cpu03FsJ4t6uupJphdPyen37T1+TiyE1bsi+gMyWUaOzUeYBjXsD+oH96nvecQRuy
 JgTwZy3TyexWeA7TEdLfESHh3h1CXQECi42+KeDBBR7fjPapWkEJViIqQ4bhaXA+9kdVz8A5cBr
 BH3g0KQOm5HeB6EScGZbJnf4sTcVmiH7mGTOu7emBRUSIgRmcXON0JPuG/hYTytuh0maLbkcJh9
 7HL7XxL+WPu9C9wico7tRUDTn2Z3QvMmoCDWIiI+Y9oig==
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



Am 08.01.26 um 00:15 schrieb Vitor Soares:
> Hi,
> 
> U-Boot 2026.01 fails to initialize MMC devices on multiple platforms
> with "unable to select a mode: -5" during mmc_select_mode().
> 
> Affected platforms:
> - Verdin iMX8M Mini (SPL boot failure - cannot boot at all)
> - Verdin iMX8M Plus (MMC init fails in U-Boot proper - cannot boot)
> - SMARC iMX8M Plus (MMC init fails in U-Boot proper)
> - Verdin AM62 (boot failure, no output)
> 
> All platforms use eMMC and worked correctly prior to this regression.
> 
> Bisect results:
> - Last known good commit: 228810d0bac3
> - Known bad commit: 36aeeb591b0d
> 
> Between these commits, several MMC-related changes were merged. These
> seem particularly relevant:
> commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device tree with
> default handling")
> commit 1e40e419aeb2 ("mmc: sdhci-cadence: Use max-frequency property from device
> tree")
> commit fa7e82127fad ("mmc: sdhci-cadence: Set controller and PHY speed modes for
> SD and eMMC cards")
> 
> Could someone familiar with these recent changes help identify what might have
> changed in the mode selection logic?
> 
> === Example logs ===
> 
> Verdin iMX8M Mini (SPL failure):
> 
> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> SEC0:  RNG instantiated
> Trying to boot from MMC1
> unable to select a mode: -5
> spl: mmc init failed with error: -524
> Error: -524
> SPL: Unsupported Boot Device!
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
> 
> ---
> 
> Verdin iMX8M Plus (U-Boot proper failure):
> 
> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)
> DDR configured as dual rank
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x?, size 1208151552
> Need continue download 1024
> load_simple_fit: Skip load 'tee': image size is 0!
> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0-dirty
> NOTICE:  BL31: Built : 08:15:07, May  9 2025
> 
> U-Boot 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)
> 
> CPU:   NXP i.MX8MP[8] Rev1.1 A53 at 1200 MHz
> CPU:   Industrial temperature grade (-40C to 105C) at 23C
> DRAM:  8 GiB
> Core:  309 devices, 31 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... unable to select a mode: -5
> 
> Verdin iMX8MP # saveenv
> Saving Environment to MMC... unable to select a mode: -5
> No block device
> Failed (1)
> 
> ---
> 
> SMARC iMX8M Plus:
> 
> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)
> Training FAILED
> DDR configured as single rank
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> Find img info 0x?, size 1208152064
> Need continue download 1024
> load_simple_fit: Skip load 'tee': image size is 0!
> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0-dirty
> NOTICE:  BL31: Built : 08:15:07, May  9 2025
> 
> U-Boot 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)
> 
> CPU:   NXP i.MX8MP[8] Rev1.1 A53 at 1200 MHz
> CPU:   Industrial temperature grade (-40C to 105C) at 23C
> DRAM:  4 GiB
> Core:  317 devices, 32 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 0
> Loading Environment from MMC... unable to select a mode: -5
> *** Warning - No block device, using default environment
> unable to select a mode: -5
> MMC init failed
> ---
> 
> I'm available to test patches or provide additional debug output if needed.
> 
> Best regards,
> Vitor Soares

Hi Victor,

what frequencies are output when you enable DEBUG output in mmc.c?

I'm currently trying to find a solution for why the SD card and MMC in 
U-Boot (they work fine in SPL) are only running at a minimum frequency 
on the TQMa6 (iMX6) and TQMa6UL (iMX6UL).

My problem comes from commit aebb523a2381 ("mmc: mmc-uclass: Use 
max-frequency from device tree with.


=== Example logs ===

U-Boot SPL 2026.01+g6955caf8885+p13111 (Jan 07 2026 - 15:26:17 +0100)
SD
Trying to boot from MMC2
clock is disabled (0Hz)
clock is enabled (400000Hz)
clock is enabled (50000000Hz)
Device tree: imx6q-mba6a


U-Boot 2026.01+g6955caf8885+p13111 (Jan 07 2026 - 15:26:17 +0100)

CPU:   Freescale i.MX6D rev1.3 at 792MHz
CPU:   Industrial temperature grade (-40C to 105C) at 20C
Reset cause: POR
Model: TQ TQMa6Q on MBa6x
Board: TQMa6D on a MBa6x
Enet workaround: Unknown
DRAM:  1 GiB
Core:  104 devices, 27 uclasses, devicetree: separate
WDT:   Started watchdog@20bc000 with servicing every 1000ms (128s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 0
Loading Environment from MMC... clock is disabled (0Hz)
clock is enabled (400000Hz)
clock is enabled (400000Hz)
Reading from redundant MMC(1)... OK
In:    serial@21e8000
Out:   serial@21e8000
Err:   serial@21e8000
clock is disabled (0Hz)
clock is enabled (400000Hz)
clock is enabled (400000Hz)
switch to partitions #0, OK
mmc1 is current device

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

