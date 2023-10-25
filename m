Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380D0C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149D2879A6;
	Wed, 25 Oct 2023 14:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ftNukXUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13068747A; Wed, 25 Oct 2023 14:20:32 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6721E879A6
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27d1433c4ebso1429837a91.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698236428; x=1698841228; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZ6qkRehEWWZrHxaezzvoqqMNClHk2Frbbwo53T8KDg=;
 b=ftNukXUFTyy3z+6PPqxi4texN0xX3wyYizOzZKSBWdtmzwmwaz2Vf2e8LTzvUCM3GZ
 OVGow9BPxIfwZZqztfd3mHbpvi7QiFYZRn80lz90SbS4Aqe7fB7Fh/xzNst/wfzL9OxL
 xvMR7hrHD56weymzxOS9aeeqnAKhL43lWRSVfZr2U0DVTGUtNUlodjaKZmbgDzGaqrFs
 x2SxkxHoEpNWDJmJZPC/bg2+oC9WfRfnehCY3n8JxLyaXca5nbgbmVTurCJ9DXZeLjDQ
 fP5cVECKVbnFa9gYQpEWSjZXL8kfnCxDs056ezp3JZa9nsuOADZRuRB7kHN0yYrA6XXt
 pjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698236428; x=1698841228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZ6qkRehEWWZrHxaezzvoqqMNClHk2Frbbwo53T8KDg=;
 b=sW7SSivOqLGEf2fephNRxZthYu7C6vumRyrOVHq8cP00hMGZ6bPSB4aZMDBqU8dG5N
 WHTKMLnbme9+8htF44Pv3ELa7rW5oGFy6Fve9BWR0vn9Wxiajl/AoYWJzgZj6EFbJFv4
 /usD2saUE2vcQESUuCDzLqpYArP5kfTMiU1/F122i1Z6TMzHmZZ11830wiCS4s+6EDv2
 yoJDD/W/2k+BA8+xuy4+BKhuPPXYJy7OZV15Bbeq8nvMr89p2rHZS8nwdtREi5rGR6FI
 xFsj8peWSktsF48zGa/6GceMMuDoZ6enoOdYGoRb9Et1qygrJomfSPt5hRJNZGSS2BLU
 0oew==
X-Gm-Message-State: AOJu0Yx/hXhAvz7rd1KEln7aql2WKKkDi5kJhg4uG4RNEyUXfdBV4pT6
 d7avr3cdNoUnSBGgC9TcC830pTv1r1/wX1VNA2Ins+E9hHQ=
X-Google-Smtp-Source: AGHT+IG/7xQsR0vKNdZTXj4puLr73WdGEfEhYt84+ufyFqYYL2R4Y6vgDJ7YcT7LkDUpxCcKHH5hpObmmO5G3SJVZ5Y=
X-Received: by 2002:a17:90b:1d0e:b0:27d:193f:2130 with SMTP id
 on14-20020a17090b1d0e00b0027d193f2130mr17134266pjb.3.1698236428568; Wed, 25
 Oct 2023 05:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
 <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
In-Reply-To: <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Oct 2023 09:20:16 -0300
Message-ID: <CAOMZO5DsFcV1yLjeHyi=56Lph3G8JErMPejVo+FTADMufhBccQ@mail.gmail.com>
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "festevam@denx.de" <festevam@denx.de>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marcel,

On Tue, Oct 24, 2023 at 10:16=E2=80=AFAM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:

> Yes, regular eMMC boot. Serial download also works for me (note this requ=
ires a patch still not merged upstream

I tried the top of tree U-Boot on the imx8mp-evk and I was not able to
reproduce the error here.

Below is the boot log from the SD card:

U-Boot SPL 2024.01-rc1-00054-gfb428b618194 (Oct 25 2023 - 09:17:12 -0300)
SEC0:  RNG instantiated
Normal Boot
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
NOTICE:  BL31: v2.6(release):lf-6.1.1-1.0.0-0-g616a4588f333
NOTICE:  BL31: Built : 10:38:04, Oct 12 2023


U-Boot 2024.01-rc1-00054-gfb428b618194 (Oct 25 2023 - 09:17:12 -0300)

CPU:   Freescale i.MX8MP[8] rev1.0 at 1200 MHz
Reset cause: POR
Model: NXP i.MX8MPlus EVK board
DRAM:  6 GiB
Core:  103 devices, 26 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:
Error: ethernet@30bf0000 address not set.

Error: ethernet@30be0000 address not set.
Could not get PHY for FEC0: addr 1

Error: ethernet@30bf0000 address not set.

Error: ethernet@30bf0000 address not set.
No ethernet found.

Hit any key to stop autoboot:  0
u-boot=3D>
