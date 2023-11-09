Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A258CC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 10:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C3B87159;
	Thu,  9 Nov 2023 11:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J4T/vbbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8C687159; Thu,  9 Nov 2023 11:29:21 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BBF870BE
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 11:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32faea0fa1fso402594f8f.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 02:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699525759; x=1700130559;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zetjP4MlVqXTpT+ZHmXKWvb1f6AtsFmHwcGtGqNFhJM=;
 b=J4T/vbbMLfgVi+2MX21BrJPAayM9UeqWFiSUOEXXIajQrDgoRnXfe0Wf1hGvunBJyE
 dPxH2+rZXvrK0+U1TIaTWvNBdqYcR2BkrWPVCsf3t08yymqXUUd6iMOcFLYrXKvK2JIm
 CG4U8ptJ6w1R30OGc/Utp+Phm1+JjDKSXZAw1lb4NvjHZceSdE/Cl9oFb6gZuIXyEx6r
 JRpRhCbEg9NRHq08aM2GoTQmL0ruw3QqnRHhdJ2bBRhjK1DVd1IxBk3YzSESyywY3Ii1
 YelrBOQv44b3cS5M/VawjoY1tWusMbdfsG68TtksQW5dwZPXYscQS9MPrhBf4ShfsLpD
 ImoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699525759; x=1700130559;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zetjP4MlVqXTpT+ZHmXKWvb1f6AtsFmHwcGtGqNFhJM=;
 b=VgU/XQ5N0V2Ls+GtEntmaXzXj2Ul7S8MRr2493rnqocASld8WVE6jgpAZ53V6IAMZT
 8Vd2XZw6V0S25SBaecSy+qJbpF7Lhz0Ajhl/Gx+BkxjQDeMQ5CZyld1PVLTOiafZHOCV
 6iJBgmsLbdOiZrqhV0DHfxlvsiuF2ec74w6H8GnTfuxfg0Yabp2nH3/WcL4E9/g1yclL
 eWwo3jvhe7+zEzWPKo1KHaos3yQUfJEF59ghcorftdHQwHB3pHO8/7jNcWdkAqoKI1BP
 9wW2nU2Lq0ED/id6mIvXu349AcgO7tgosjVsBlvpqM6DGVvwHvVyF5+4gCb9wKwEJhpb
 hM5Q==
X-Gm-Message-State: AOJu0YyTiEpKqM+WqL+bo7D93ZFCSJU4DXFclLDAPPKHMW9cTGO77dw4
 MxDYfSRvX01lRA+ktrErGsJTbTuWe07lh92w3KA=
X-Google-Smtp-Source: AGHT+IEa8P8Or0XFs4iY3yW7p72XnXhP9d7UhkW42sX5/0ZdtDhQ5RwqLG259tcQF50vlHavFDastQ==
X-Received: by 2002:a05:6000:154b:b0:32f:8b51:3708 with SMTP id
 11-20020a056000154b00b0032f8b513708mr5946391wry.2.1699525759020; 
 Thu, 09 Nov 2023 02:29:19 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 s1-20020adff801000000b003313069be5dsm2523357wrp.46.2023.11.09.02.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 02:29:18 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Maxime Ripard <mripard@redhat.com>, Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: eMMC broken on SK-AM62
In-Reply-To: <hsk5wejuf5maoer3aodjyndmyft56gag4cepfjep7lfthmwrcy@r2yoebb7stk6>
References: <hsk5wejuf5maoer3aodjyndmyft56gag4cepfjep7lfthmwrcy@r2yoebb7stk6>
Date: Thu, 09 Nov 2023 11:29:17 +0100
Message-ID: <871qcz9q4i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Maxime, Nishanth,

On mer., nov. 08, 2023 at 16:05, Maxime Ripard <mripard@redhat.com> wrote:

> Hi Nishanth,
>
> I've been trying for the last few days to get an SK-AM62 to boot from
> the eMMC user data area.
>
> I finally got the jumper configuration to make the CPU boot from there
> thanks to Mattijs, but it looks like the 2024.01-rc2 release doesn't
> support booting from there:
>
> U-Boot SPL 2024.01-rc2 (Nov 08 2023 - 14:11:12 +0100)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.5--v09.01.05 (Kool Koala)')
> SPL initial stack usage: 13368 bytes
> Trying to boot from MMC1
> MMC Device 0 not found
> spl: could not find mmc device 0. error: -19
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
>
> It looks like you tried to fix it with 0f1c1e8b368b ("arm: mach-k3:
> am625: Add support for UDA FS"), but it looks like it's not enough.

I confirm I reproduce the issue on AM62x SK EVM.

Beagle play seems to boot fine:

U-Boot SPL 2024.01-rc2 (Nov 09 2023 - 11:24:04 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
SPL initial stack usage: 13400 bytes
Trying to boot from MMC1
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Starting ATF on ARM64 core...

NOTICE:  BL31: v2.8(release):08.06.00.007
NOTICE:  BL31: Built : 11:17:33, Nov  9 2023

U-Boot SPL 2024.01-rc2 (Nov 09 2023 - 11:24:30 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
SPL initial stack usage: 1888 bytes
Trying to boot from MMC1
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted


U-Boot 2024.01-rc2 (Nov 09 2023 - 11:24:30 +0100)

SoC:   AM62X SR1.0 GP
Model: BeagleBoard.org BeaglePlay
DRAM:  2 GiB
Core:  98 devices, 27 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
Loading Environment from nowhere... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   No ethernet found.

Press SPACE to abort autoboot in 2 seconds
=>

Note that Beagle Play does not boot tiboot3 from UDA (User Data Area)
but from mmc0boot0 so the boot flow is not exactly the same.

>
> Thanks!
> Maxime
