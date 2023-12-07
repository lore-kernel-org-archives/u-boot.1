Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94419C10F05
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 17:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC1187150;
	Thu,  7 Dec 2023 18:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FO7jX2rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6D0870F6; Thu,  7 Dec 2023 16:09:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D384386C47
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 16:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mzamazal@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701961743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJXKNdUzjLQpUYpo28T7FT5/29+qFOuwBs3kEZGwWNM=;
 b=FO7jX2rlE8kcND8/cCxo//pFbqiJPultInpeCdogLUHuyKFQViNSthtey6XMg8TNjrMZQ5
 B6XfJh+g/FhvEURSy/bbEhHSljGJ/ikUeToLDOkjflcKm74qzcksHD5RBiw7sFRKOYzpm+
 2gVclGKUkhnHrY6PQycsAMeOIYPvjNY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-eJSYJ4S1O_OOr3VZuWOwiA-1; Thu, 07 Dec 2023 10:09:02 -0500
X-MC-Unique: eJSYJ4S1O_OOr3VZuWOwiA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54dbe033977so494968a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 07:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701961740; x=1702566540;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJXKNdUzjLQpUYpo28T7FT5/29+qFOuwBs3kEZGwWNM=;
 b=RS+iRl6/J4AktwcjlKdhqmqcAbKAs/UqXJnVa1vCn111tj66hdp3eXm8rktdlqNZWY
 gmbCbmWZRlx+dreWMz0N1CBH/tTL2Y5jEcrsnw3M7A112OUvUsrGOFtDXoBVMCOV2ZPK
 Jepjd0aGZhLJPqCJaykexNNQ2uhTqDdMxoZmYS69OObIuffIuyYkj/XVsogb0QgxHO1W
 ScaMwj38K7uXYCvoaZ2hi3sg/s5PNCGnIKJ+AUnAbruIFm8nJ/Esw5o/cq3S2knyst0T
 WfFG9y/dxG76cMlYAJHXel54rAwAWTgpbUFH4PZ26fJHycaiCwL675xPfku0uie24r7T
 njJw==
X-Gm-Message-State: AOJu0YyWGpfXnjrrcMA752JgdVePF+UKz8Dl590IjFPycSy9VVAZnVuY
 UrU30wII3EyRWZPA0kKapgzcwd25Hp18A5LL9whfnJ1nFtVqx+aMrFrVxtht7yJPHlxPXXQLyBA
 asB2OP/Kanzr0ULSYzcyrEKJWKplgGhwPOt2qzd/NTsDWSGcx5n+ZDnyefhnA+UEVs/KipOCSqA
 ==
X-Received: by 2002:aa7:c648:0:b0:54c:c68e:95a7 with SMTP id
 z8-20020aa7c648000000b0054cc68e95a7mr839004edr.52.1701961740149; 
 Thu, 07 Dec 2023 07:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvXjBknqDTRT4Umc0oTIDOr0qp4WfcyjKdlLpGFqvPzEJMI3+RKDj3CryAPJM0ZLXoODg+Xw==
X-Received: by 2002:aa7:c648:0:b0:54c:c68e:95a7 with SMTP id
 z8-20020aa7c648000000b0054cc68e95a7mr838993edr.52.1701961739725; 
 Thu, 07 Dec 2023 07:08:59 -0800 (PST)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 eh11-20020a0564020f8b00b0054cba269d4fsm856300edb.16.2023.12.07.07.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 07:08:59 -0800 (PST)
From: Milan Zamazal <mzamazal@redhat.com>
To: Gilles Talis <gilles.talis@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, uboot-imx@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
In-Reply-To: <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com> (Peng Fan's
 message of "Thu, 25 May 2023 08:12:07 +0800")
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com>
Date: Thu, 07 Dec 2023 16:08:58 +0100
Message-ID: <877clq6odx.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 07 Dec 2023 18:15:43 +0100
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

Peng Fan <peng.fan@oss.nxp.com> writes:

> On 5/24/2023 3:21 AM, Gilles Talis wrote:
>> Add support for the Polyhex Debix Model A SBC board.
>> It is an industrial grade single board computer based on
>> NXP's i.MX 8M Plus.
>> Currently supported interfaces are:
>> - Serial console
>> - Micro SD
>> - eQOS and FEC Ethernet
>> imx8mp-debix-model-a.dts is taken from Linux 6.3.
>> Signed-off-by: Gilles Talis<gilles.talis@gmail.com>
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Do you know why the patch has been left (as far as I can see) without
further action?

BTW, I applied it to current master, compiled approximately following
https://docs.u-boot.org/en/latest/board/nxp/imx8mp_evk.html and tried to
use it on Debix Model A.  U-Boot starts but cannot find the partition
table on the SD card:

  U-Boot SPL 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00 +0000)
  Normal Boot
  WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
  Trying to boot from BOOTROM
  Boot Stage: Primary boot
  image offset 0x8000, pagesize 0x200, ivt offset 0x0
  NOTICE:  BL31: v2.2(release):rel_imx_5.4.70_2.3.6-0-g15e8ff164-dirty
  NOTICE:  BL31: Built : 00:00:00, Jan  1 1980


  U-Boot 2024.01-rc3-07226-g43f2873fa9-dirty (Jan 01 1980 - 00:00:00 +0000)

  CPU:   Freescale i.MX8MP[8] rev1.1 at 1200 MHz
  Reset cause: POR
  Model: Polyhex Debix Model A i.MX8MPlus board
  DRAM:  2 GiB
  Core:  83 devices, 22 uclasses, devicetree: separate
  WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
  MMC:   FSL_SDHC: 1, FSL_SDHC: 2
  Loading Environment from MMC... *** Warning - bad CRC, using default environment

  In:    serial@30890000
  Out:   serial@30890000
  Err:   serial@30890000
  Net:   eth1: ethernet@30bf0000 [PRIME]
  Hit any key to stop autoboot:  2 <0x08><0x08><0x08> 1 <0x08><0x08><0x08> 0 
  switch to partitions #0, OK
  mmc1 is current device
  Scanning mmc 1:1...
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  <0x1b>7<0x1b>[r<0x1b>[999;999H<0x1b>[6n<0x1b>8Card did not respond to voltage select! : -110
  No EFI system partition
  No EFI system partition
  Failed to persist EFI variables
  Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios
  BootOrder not defined
  EFI boot manager: Cannot load any image
  ,** No partition table - mmc 1 **
  Couldn't find partition mmc 1:1
  Card did not respond to voltage select! : -110
  u-boot=>

When I use an old U-Boot blob provided by Debix, it boots fine from the
same SD card.  The SD card contains a Fedora aarch64 image with a msdos
partition table.

Do you know what could be wrong?

Regards,
Milan

