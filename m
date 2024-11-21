Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F676D7879B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 17:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE1D89647;
	Thu, 21 Nov 2024 18:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z5HVV+ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5756C896B5; Thu, 21 Nov 2024 18:21:27 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95C488785
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 18:21:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 291AE3F6BB
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732209684;
 bh=FyR0Ca1qaJooUk7Jx1mj9gmnywrxcfK+87WfubwQ8qo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Z5HVV+eaGQGLn05QMdLwzYGwK8dbAP56hkEFEm3A2VETWJmQjkThowF2iVBPX24Il
 147TkILk0BzF/7FLFG5AmxqsSorvmd8OIzVBYTxQV8rkRz4heAvWTQcxrpsAALsdQg
 HreAaP7xUls6rfBAT/xc8J8Cl/Im6TyKUSajYAG2eS8p+zOaDNMO0ZnetyDqGQbNPo
 y1iBbK+oPt7oSZrsfhwZwh86NpEJm3nhPnNy5Nuo1/N7QsD/KJVEiGfwIoOt14cSb3
 H99fHvOTMV2gvhoR1vE/JRa++veHf94ESENaEbjhD3JXy3U5JzscpNrhIhoasXCCeU
 RDdsQlZFYLS2Q==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9a194d672bso114855566b.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 09:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732209684; x=1732814484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FyR0Ca1qaJooUk7Jx1mj9gmnywrxcfK+87WfubwQ8qo=;
 b=S0qWpqdZaxZkuFFJL7o/pdVnYV+i/rlgH0BhI0gegITAjSD9DKK90wtkFJNeHa2nDe
 lXL8fnxTLrmoW5TjSb9SABYLGce63SF2gYlmndecT8UYA2fKcxa7aFM9umpLBi0jvDFC
 A2wCtK1uc2VtmXbGe7xRrPH9bWBq1bNYT/WosrI/cqwO1A3UKQIaUbpXgWb18trqB2MM
 aST1acjmL4v7yHok5zBBAvSV5TJnpCiLmxOtIWZHC6gxQNcIqjKCq8GvFaSmspPJ9SYf
 MSSTuCPWcXTcJl5YG5cV4jim2ctMnwbWG4M8j6AfoKtuxQynbS8tZmByCEPmdITeI5rU
 p82A==
X-Gm-Message-State: AOJu0YxvrZHd0MbhvcaTzVLcBhDkLtcMcnhcjgk3Y23KpLE1LtXJ88Hq
 KBoUcZBiiS1dgoUVa/wICKikxCOLye5nQ7aYd69/PfiZmqyTW9E0FckPA3lCyLy4OlpzvJcW2a5
 bjwK7irKoosHSkP78YXhw50ept1/vNs1LKrC9KCG4UlSan31mvgAiaehnnQCLmRaU2II=
X-Gm-Gg: ASbGnctHbgEyhfgzaq1TxxdDHvVcNht44tQXkYA+hVB9eIOGnj8DdEXbhLIYSeH4XpW
 saE5wLkJ80hmn/6E8CMTfUnE7glkdU/oYcn8pwF4SGzoQSIFq7KVgDhOQ1RLw9aCJntkf46yi9a
 UJEUVYTsecWxUI1i5uVJQP0ITLRp1qCHJUIgBN98sx6iHHj2V0aDIwUl+1tPzS5v4qB3/udgiPC
 ITTdTzr4/x5ooEnIj8p1YUfOq4YD2iRJ+ImcsQltIL7n3c1moeok9qP01rb8V21bXQwKVCYOTcC
 sjVY3Ee3csFW9NOtQg2HqN4fBFKrzIeuPpjvQLr2tKmXTWk=
X-Received: by 2002:a17:907:9726:b0:a99:e1a1:473f with SMTP id
 a640c23a62f3a-aa4dd74a0b8mr778143466b.57.1732209683720; 
 Thu, 21 Nov 2024 09:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDKgL9iZPZRzHaJLPGx+nRKOS85Q8a9exjAV1K1EmHJaG5oH0fXjbGV1T9GFWsXpbGOsJBPg==
X-Received: by 2002:a17:907:9726:b0:a99:e1a1:473f with SMTP id
 a640c23a62f3a-aa4dd74a0b8mr778141266b.57.1732209683314; 
 Thu, 21 Nov 2024 09:21:23 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f418017asm102998866b.58.2024.11.21.09.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 09:21:22 -0800 (PST)
Message-ID: <7610b940-63ae-4b52-a71e-555b2d2db35e@canonical.com>
Date: Thu, 21 Nov 2024 18:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 2025.01-rc2 fails to boot on VisionFive2
To: Andreas Schwab <schwab@suse.de>
Cc: u-boot@lists.denx.de, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <mvm8qtnv310.fsf@suse.de>
 <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com>
 <mvmfrnko8tk.fsf@suse.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <mvmfrnko8tk.fsf@suse.de>
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

On 21.11.24 17:22, Andreas Schwab wrote:
> On Nov 21 2024, Heinrich Schuchardt wrote:
> 
>> On 13.11.24 11:31, Andreas Schwab wrote:
>>> "Error reading cluster" is the new error.
>>> U-Boot SPL 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
>>> DDR version: dc2e84f0.
>>> Trying to boot from MMC2
>>> U-Boot 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
>>> CPU:   sifive,u74-mc
>>> Model: StarFive VisionFive 2 v1.2A
>>> DRAM:  4 GiB
>>> Core:  136 devices, 26 uclasses, devicetree: board
>>> WDT:   Not starting watchdog@13070000
>>> MMC:   mmc@16010000: 0, mmc@16020000: 1
>>> Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>>> *** Warning - bad CRC, using default environment
>>> StarFive EEPROM format v2
>>> --------EEPROM INFO--------
>>> Vendor : StarFive Technology Co., Ltd.
>>> Product full SN: VF7110A1-2249-D004E000-00000408
>>> data version: 0x2
>>> PCB revision: 0xa1
>>> BOM revision: A
>>> Ethernet MAC0 address: 6c:cf:39:00:16:8d
>>> Ethernet MAC1 address: 6c:cf:39:00:16:8e
>>> --------EEPROM INFO--------
>>> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
>>> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
>>> In:    serial@10000000
>>> Out:   serial@10000000
>>> Err:   serial@10000000
>>> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
>>> starting USB...
>>> Bus xhci_pci: Register 5000420 NbrPorts 5
>>> Starting the controller
>>> USB XHCI 1.00
>>> scanning bus xhci_pci for devices... 2 USB Device(s) found
>>>          scanning usb for storage devices... 0 Storage Device(s) found
>>> Working FDT set to ff72ca10
>>> Hit any key to stop autoboot:  0
>>> Card did not respond to voltage select! : -110
>>> ** Booting bootflow '<NULL>' with efi_mgr
>>> Error reading cluster
>>
>> This is a message from the FAT file system driver.
> 
> The file system is ok when read after interrupting the boot.

That ls works does not mean that the file system is not corrupted.

dosfsck will tell you if there is something wrong.

> 
> StarFive # mmc dev 1
> switch to partitions #0, OK
> mmc1 is current device
> StarFive # ls mmc 1:1
>              EFI/
>        304   ubootefi.var
> 
> 1 file(s), 1 dir(s)
> 
> StarFive # ls mmc 1:1 EFI
>              ./
>              ../
>              BOOT/
> 
> 0 file(s), 3 dir(s)
> 
> StarFive # ls mmc 1:1 EFI/BOOT
>              ./
>              ../
>     167936   BOOTRISCV64.EFI
>        164   grub.cfg
> 
> 2 file(s), 2 dir(s)
> 
> But running boot will end with the above error, and mmc 1 no longer
> works.
> 
>> Which image reproduces the problem?
> 
> I've built U-Boot here
> <https://build.opensuse.org/project/show/home:Andreas_Schwab:riscv:u-boot>.
> 

I was asking which SD-card image that was used, e.g. some Suse 
preinstalled image.

Best regards

Heinrich
