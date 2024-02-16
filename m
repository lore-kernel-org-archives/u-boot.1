Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA35EC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 05:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C05387E44;
	Fri, 16 Feb 2024 06:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iwABEu8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FEF87E44; Fri, 16 Feb 2024 06:01:44 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F2287E50
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 06:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sahaj.sarup@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d0f7585d89so3945251fa.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708059692; x=1708664492; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=045cEGbQgVKMeKRFsw5kqxEKs77t2Znhca/Dm4rZg4c=;
 b=iwABEu8UlH0J6mMQhj6rcaWVn9STA6KJESiFbJ2OJy6zpVO7hJiMOHJm4F54OJjaoX
 QT9btN00zwXyFVr/1cylV3G357DXo5gh5COqc1UWDfztSQ7HEEgrIDBOWVjsEluwkx6b
 X4fE2Q0P3yk4fAtLB0HISRtLAm3Bieegvcxyl8aEg2Ya5yShvDd7dlHf4Kgc43zEevD9
 ZawS7Ib1GKyuk3QeNEBioxOzN2tFpUn63B1ixS8EdTND2C4uFwekBan5Yh+w4z/pAlC2
 dXfq/MPXyhxVmuwEFGWRLy9E+pNx6wGUCOwkFT3fzrN08cJsDYIMCo5DnRqyMMQRl/0r
 8J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708059692; x=1708664492;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=045cEGbQgVKMeKRFsw5kqxEKs77t2Znhca/Dm4rZg4c=;
 b=YBtEz6AHYvtixUwL3BY+sKn4Fgj4DSz9RA4IGPU+ovgZwQnJmX/DrMmx3uOcy5mSBA
 qPwWgtg1lbKv1poh9DgPSjV0ATSkeqZTDpuGop/V8LKDlvLoV3J2UWeN+pPTVOAyic6d
 96RqvdVpIo3LQGOrQlif1JiqCqWHrtZoCP7T7AP/PmXYe8Jv8WrGf7AKRbcSQneFVw/H
 cQbJhfDcAzauJ/Du7absbHXXyKTdLew8IvwPajZjFA5ZL3sg64ZGVkXVGldWrQ0Kev+k
 JdPGgHvhXUB2ncmuikwm/RRpXN4kyEbDr7L9QFyLF7Mq+oOqaNWXQ3qzq3sddQJt7i1C
 8TYw==
X-Gm-Message-State: AOJu0Yx5pjVpEAabToPcvo33dMUJSJS8GK/xxv4g8IgKwMYXfcG/wnTu
 9SE5uu1nz82zVdZCsVB+KnWdeAEViLlv9X4We3b5zAGncjk5Q9mbCWJHJe8PFsby4sasSJ6TQck
 yN0FtLL0WzFcxY5+3zoFu+GvX9j6Vlr63mp12dAzhWiZ08bpPpG4=
X-Google-Smtp-Source: AGHT+IHEp4i+Wsbv3jLTTNmPXVDi9Il2OH/OEbUzsvD+dOXk8I8xks5wZjJgWX5jVdAnVFdlK639VZZo2C2hiK2keRg=
X-Received: by 2002:a2e:9198:0:b0:2d0:ac7f:eef9 with SMTP id
 f24-20020a2e9198000000b002d0ac7feef9mr2863596ljg.34.1708059691326; Thu, 15
 Feb 2024 21:01:31 -0800 (PST)
MIME-Version: 1.0
From: Sahaj Sarup <sahaj.sarup@linaro.org>
Date: Fri, 16 Feb 2024 10:31:20 +0530
Message-ID: <CAKZ1LvM45MB8N0CqgU+C7i9=Bjb6kqNTxWo2Tv407HKLWtCMkA@mail.gmail.com>
Subject: verdin-imx8mp: Ethernet does not load at boot
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On a verdin-imx8mp platform I am now unable to use the ethernet ports.
My last build was from December
(8f5043ee6d378d7c10d947cf48b047a5954ef5b3) so it was working fine
then.

Boot log:

```
U-Boot SPL 2024.04-rc2-00002-gbef352dd57-dirty (Feb 16 2024 - 10:07:17 +0530)
Training FAILED
DDR configured as single rank
SEC0:  RNG instantiated
Normal Boot
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
Trying to boot from BOOTROM
Boot Stage: Primary boot
Find img info 0x4802ae00, size 1044
Need continue download 1024
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.10.0  (release):v2.10.0-44-g2e1e1664c
NOTICE:  BL31: Built : 13:09:20, Dec  1 2023


U-Boot 2024.04-rc2-00002-gbef352dd57-dirty (Feb 16 2024 - 10:07:17 +0530)

CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
CPU:   Industrial temperature grade (-40C to 105C) at 36C
Reset cause: POR
DRAM:  4 GiB
Core:  171 devices, 28 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... *** Warning - bad CRC, using default environment

In:    serial@30880000
Out:   serial@30880000
Err:   serial@30880000
Model: Toradex Verdin iMX8M Plus WB on Verdin Development Board
SEC0:  RNG instantiated
Setting variant to nonwifi
Net:
Error: ethernet@30bf0000 No valid MAC address found.
Can't find FEC0 clk rate: -22

Error: ethernet@30bf0000 No valid MAC address found.
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Could not get PHY for mdio: addr 7
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Could not get PHY for FEC1: addr 7

Error: ethernet@30bf0000 No valid MAC address found.
Can't find FEC0 clk rate: -22

Error: ethernet@30bf0000 No valid MAC address found.
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Could not get PHY for mdio: addr 7
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Read MDIO failed...
Could not get PHY for FEC1: addr 7

Error: ethernet@30bf0000 No valid MAC address found.

Error: ethernet@30bf0000 No valid MAC address found.
No ethernet found.

Hit any key to stop autoboot:  0

```
