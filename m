Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CBED0D17C
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 23:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4416683A2D;
	Thu,  8 Jan 2026 00:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBXO7eer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66E884047; Thu,  8 Jan 2026 00:16:01 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3996C83A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 00:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47755de027eso15642025e9.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767827759; x=1768432559; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=77nnLK5tVaB6xp/2BITlGqrP1RJOIsJbFxh2yUay8MA=;
 b=IBXO7eerE8XHx0uEFB0i58g/wOHhcxQUsgRYwGyoNvNCGcrKgRD4Ylq0JNWFTQ5YEI
 wSmM1dCDHd/Djz9Up/nplBH4JfUtxhX3mutZ91wEuqqojfVKRygR3FFkx6CM3T/YTaTf
 uwhcaK4eGKC+wBb1Sb52ZykBdZHqlLN/PHvLDKFfzQgHONCBgLvgmCn5rPhggvL4m5yr
 SqfkZQeBy796dMwyZh6YUR04TjdaeKf9cFrq/oQPhU3IRTarYm51NOxbaNUVcSoUo2os
 plvbCxXJx/D28+QRf2WQkyImYK2YMQMbsRosFlkNMnlzoBj6zrhvmGdrZMFDgKjsGmvq
 7jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767827759; x=1768432559;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=77nnLK5tVaB6xp/2BITlGqrP1RJOIsJbFxh2yUay8MA=;
 b=QcuteXaNI0Boa9zuzNTZWFPtx9gK2mLSQOAiFeWr6Zf0SGRwZbfpKV1KfGh5zp+SOx
 jaSbvxQFjild0cBBX8vsmbO6J7qALTXhnZpxvyY3BZzK6skvW916Xj1Poq5GmmvIR1gT
 uoUcqdQS7WnThmmqhhFu0eLvPwfiSmx/yGeCZgiz/IwHhKsZEDBWfdO57oHXhGEHQwGl
 dkbyi/4YfttctBj8H06YTn344BaY5VR2tldJ5KpcnSj/9OUiILyV8cf84Iu18ymW/OiN
 wfP9hm2/1nFRMxImBiPOPqsbloNor1C9jCcux1Cikqim1cz7Z9Gl1w9JjJFaPz7XhV48
 gH9Q==
X-Gm-Message-State: AOJu0Ywvogzj8sL8ueGAylRN27tu0jX1PrpUMfbrP7a/Px1HIxJ9VI3b
 qupVcOMurw5xmjQLr50KSriL+HuhqT383eIxH/fPXZoTjb5OlBImMKIq3Wsd9Q==
X-Gm-Gg: AY/fxX5IZN24sD0Jt5DVe6lAhcoLp/PkEBLrLP40T8euf4Hr4HxlpmWZiGJ947Y62kP
 6aWet8R6LdpGKpiDx01K8TTngptQD9zG0tgwshjkuum83nxPNXsSsFuthhhACEA5B0/XtZGuyIj
 EPwqf5n7xBYf11EMPAH1r9JOMUOSLLP9XbiRrG7UtC7XDJS/WJNqMbpkIJQwB5pyq+L+O/Gnuye
 lLQ55haWx2YEnffWV/L1ORo/728WrYybrX+Fxanx69rFWx0OTn9Alj/JJbh7wMnhMkJf2y1xAWe
 8j9Hgd48BaMqa82Tz7j1nTaZiF49jKN1fc7kymarKZ5310D8SrKPilEi8I5QpExTMqf4XL0by3k
 BEsEFsyiRFEs+f5ecFSHkKbj95YUxlCntbYlMMWjcsiNSJITMY4/WBECxOsQbynOf7P1IqQ9fUQ
 ZtCSahn95J/6k8CRsUI4EM5Qo2pL5lOA6WQh0=
X-Google-Smtp-Source: AGHT+IGX2snRxeCt/O6A9onqH+mLZCmDU4Jsf4ME7sFI/nazFFEofO4DrOHGILSYUThLqHAwqb8b0A==
X-Received: by 2002:a05:600c:190e:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-47d84b3f21fmr48825485e9.35.1767827758419; 
 Wed, 07 Jan 2026 15:15:58 -0800 (PST)
Received: from [10.25.35.209] (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d871ac28bsm22403535e9.20.2026.01.07.15.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 15:15:56 -0800 (PST)
Message-ID: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
Subject: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
From: Vitor Soares <ivitro@gmail.com>
To: u-boot@lists.denx.de
Cc: vitor.soares@toradex.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 trini@konsulko.com, tanmay.kathpalia@altera.com, marex@denx.de, 
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Date: Wed, 07 Jan 2026 23:15:55 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 08 Jan 2026 00:36:38 +0100
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

U-Boot 2026.01 fails to initialize MMC devices on multiple platforms
with "unable to select a mode: -5" during mmc_select_mode().

Affected platforms:
- Verdin iMX8M Mini (SPL boot failure - cannot boot at all)
- Verdin iMX8M Plus (MMC init fails in U-Boot proper - cannot boot)
- SMARC iMX8M Plus (MMC init fails in U-Boot proper)
- Verdin AM62 (boot failure, no output)

All platforms use eMMC and worked correctly prior to this regression.

Bisect results:
- Last known good commit: 228810d0bac3
- Known bad commit: 36aeeb591b0d

Between these commits, several MMC-related changes were merged. These
seem particularly relevant:
commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device tree w=
ith
default handling")
commit 1e40e419aeb2 ("mmc: sdhci-cadence: Use max-frequency property from d=
evice
tree")
commit fa7e82127fad ("mmc: sdhci-cadence: Set controller and PHY speed mode=
s for
SD and eMMC cards")

Could someone familiar with these recent changes help identify what might h=
ave
changed in the mode selection logic?

=3D=3D=3D Example logs =3D=3D=3D

Verdin iMX8M Mini (SPL failure):

U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +00=
00)
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Trying to boot from MMC1
unable to select a mode: -5
spl: mmc init failed with error: -524
Error: -524
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

---

Verdin iMX8M Plus (U-Boot proper failure):

U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +00=
00)
DDR configured as dual rank
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
Find img info 0x?, size 1208151552
Need continue download 1024
load_simple_fit: Skip load 'tee': image size is 0!
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0-dirty
NOTICE:  BL31: Built : 08:15:07, May  9 2025

U-Boot 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)

CPU:   NXP i.MX8MP[8] Rev1.1 A53 at 1200 MHz
CPU:   Industrial temperature grade (-40C to 105C) at 23C
DRAM:  8 GiB
Core:  309 devices, 31 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... unable to select a mode: -5

Verdin iMX8MP # saveenv
Saving Environment to MMC... unable to select a mode: -5
No block device
Failed (1)

---

SMARC iMX8M Plus:

U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +00=
00)
Training FAILED
DDR configured as single rank
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
Find img info 0x?, size 1208152064
Need continue download 1024
load_simple_fit: Skip load 'tee': image size is 0!
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0-dirty
NOTICE:  BL31: Built : 08:15:07, May  9 2025

U-Boot 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +0000)

CPU:   NXP i.MX8MP[8] Rev1.1 A53 at 1200 MHz
CPU:   Industrial temperature grade (-40C to 105C) at 23C
DRAM:  4 GiB
Core:  317 devices, 32 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 0
Loading Environment from MMC... unable to select a mode: -5
*** Warning - No block device, using default environment
unable to select a mode: -5
MMC init failed
---

I'm available to test patches or provide additional debug output if needed.

Best regards,
Vitor Soares
