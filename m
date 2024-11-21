Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D47D7877B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 16:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB9089672;
	Thu, 21 Nov 2024 17:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MqW4Dtag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34888967B; Thu, 21 Nov 2024 17:00:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D9389658
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 17:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D41773FD49
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732204845;
 bh=lzS3yz01YJOYJ9qTOvvJH1fZKkJm+Xjz20411z/aCYw=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=MqW4DtagbIYK2mzXCGiX0Zy+Dq7j2RLkPXSNc0VihrygwoGbu90yfLpuUCWhudSMt
 yMxU0y0KjSR7m0epMH5Eh6DGxuBvIL9i0z2Lt7BzORe3AEvswcjqm/YM0uwo8AOWa3
 d1ibAR2ogGyHtQ9WsUROeM3+lZBhyTxQYLwwfj2edfmroN2QN5y1uD41jUOO2YiQiM
 6zeLjs/3fDEHybAE9MTbXiOmbwBua7OJj99PpR91vAOT5M+MPEP2hiHEWjHWinPUzC
 lLdnTIB+7mCgY1P0xdlVz7P+RO+zVF6x6WM5t2zGMVdSrvvDUC6NLmsn5xxtZrfEyc
 pOwN/iUp7++EQ==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5cfcd4862b1so777860a12.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732204845; x=1732809645;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzS3yz01YJOYJ9qTOvvJH1fZKkJm+Xjz20411z/aCYw=;
 b=IJ3RJv3ZBl3PrTtaF00KmUDv2VRP3tbKtdUhbwDO+wrCWcIqIrznU8qIXcrhBbmIiS
 rlV89wj2czFMKq3HnXdUl1YBbVlee7hmskxNBu+qMIbWFaGuAXViw454u87lOY0ftRiA
 PDVAI8kOhGoE+XE4KgRWhfrBzAsmglPzz99xDg4+5WgicdOfVFcliGc2TDDsPZ6NwZ2z
 7SWCmMz2rznJvrDfclyl/jSuU8mpdhQGXlEztZPmOdBXUTIOSWc9cWG89HIA1PLE+eD6
 94BoRiGjNg+8Yjkc9/2rvW3IMtcGoffrZuv90JdioKRAgIdHoNwZoMqgpiw0mvujCXkO
 Rh2g==
X-Gm-Message-State: AOJu0YzkTUKB/PvOa/k1fbG5O1KgDG7kviMeZev3DTn3EMUln0g6Boo/
 6mgMYf0Dszk0CUgEgGfb7CWWFHhupJ1YlX2MTS0YtLoSboLNdw9iNhDpOagsOZBDcQ9jNlQMd21
 2mEf1oVxhz8E7hZVUa7xcwoUQKQ5xnNA0C+Nv5jozjr+DK55b1z9BykXD20JwOS++NQ4=
X-Gm-Gg: ASbGncvRuGRY8k7gy899pc4iQafZfhbQH6FYp0a1zrKLFxgyWOwORAOn8pS3zGQP+Zs
 gJ63oCiXOQMTR628kxH6lZOj3MtTURLQS4uGk5irH4gcLwjJJEX8IofP2m9OLp0Alg4+PWR/0op
 0RXekLZi+QSpijW00aRbdu0u1u4sCjYKbOMBraxnIPUvMHWCNxVInzyGkxav505BPejxKxu3jJn
 lJHYtx/XsxyDC0zXHm2pqvZvY1WDI0NIy6qTzbFne5FrZT7MJqNel0FCM8MxkR2p0pHSsSBFqOM
 lSmqGC3H6aHTVIuxvctNz5OLDHQh6mcQ1fjbG7yHRihRw8I=
X-Received: by 2002:a05:6402:22af:b0:5cf:f660:d58d with SMTP id
 4fb4d7f45d1cf-5cff660db28mr4036276a12.29.1732204844565; 
 Thu, 21 Nov 2024 08:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMB45Ao2G/0NXWGjiFZ+AESQNrO1hl5jb9oVsjWArK5wPvQn37liHpYKaU5fQIZfXAN20UTw==
X-Received: by 2002:a05:6402:22af:b0:5cf:f660:d58d with SMTP id
 4fb4d7f45d1cf-5cff660db28mr4036220a12.29.1732204843783; 
 Thu, 21 Nov 2024 08:00:43 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cff44efaf8sm1997306a12.33.2024.11.21.08.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 08:00:42 -0800 (PST)
Message-ID: <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com>
Date: Thu, 21 Nov 2024 17:00:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 2025.01-rc2 fails to boot on VisionFive2
To: Andreas Schwab <schwab@suse.de>
References: <mvm8qtnv310.fsf@suse.de>
Content-Language: en-US
Cc: u-boot@lists.denx.de, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <mvm8qtnv310.fsf@suse.de>
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

On 13.11.24 11:31, Andreas Schwab wrote:
> "Error reading cluster" is the new error.
> 
> U-Boot SPL 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
> DDR version: dc2e84f0.
> Trying to boot from MMC2
> 
> 
> U-Boot 2025.01-rc2 (Nov 08 2024 - 07:13:26 +0000)
> 
> CPU:   sifive,u74-mc
> Model: StarFive VisionFive 2 v1.2A
> DRAM:  4 GiB
> Core:  136 devices, 26 uclasses, devicetree: board
> WDT:   Not starting watchdog@13070000
> MMC:   mmc@16010000: 0, mmc@16020000: 1
> Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> *** Warning - bad CRC, using default environment
> 
> StarFive EEPROM format v2
> 
> --------EEPROM INFO--------
> Vendor : StarFive Technology Co., Ltd.
> Product full SN: VF7110A1-2249-D004E000-00000408
> data version: 0x2
> PCB revision: 0xa1
> BOM revision: A
> Ethernet MAC0 address: 6c:cf:39:00:16:8d
> Ethernet MAC1 address: 6c:cf:39:00:16:8e
> --------EEPROM INFO--------
> 
> starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
> In:    serial@10000000
> Out:   serial@10000000
> Err:   serial@10000000
> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> starting USB...
> Bus xhci_pci: Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> scanning bus xhci_pci for devices... 2 USB Device(s) found
>         scanning usb for storage devices... 0 Storage Device(s) found
> Working FDT set to ff72ca10
> Hit any key to stop autoboot:  0
> Card did not respond to voltage select! : -110
> ** Booting bootflow '<NULL>' with efi_mgr
> Error reading cluster

This is a message from the FAT file system driver.

Which image reproduces the problem?

Did you run dosfsck on the ESP?

Best regards

Heinrich

> Loading Boot0000 'mmc 1' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=-14)
> Card did not respond to voltage select! : -110
> 
