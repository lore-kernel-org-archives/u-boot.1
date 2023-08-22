Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C70DEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC8B8647D;
	Tue, 22 Aug 2023 17:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="Y7HxEpHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C2C8647F; Tue, 22 Aug 2023 17:55:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7C986474
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31963263938so4095859f8f.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692719724; x=1693324524; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=34eID9O4+PBEB3o7SJqQTxsS3MiFghkUkiAPDau7XoM=;
 b=Y7HxEpHOzNo5pnoUDTZckwCaM/NGnBs6sNg7qq+a0nlPkUou0e+i7ffkFsgN/HnMye
 Na5jZNmxFpsJSpN9opbEiI5iJV3OcaIP+QjC2GCB6e3u/mRAwMj7Jy5rV4xDT0kBukA9
 wPNO4CGbFcbqriMhWZGhlbhvShcW+S3ymYa0qbuf/D9h+3tDLR96iIbb9CmnGuyYcpAg
 KS+7IMiH5DFgzYbCBttByzbj5U3XZUo1/BuA0/U9Vz+Zj05htXC1M/KJvx8YL+8R6npk
 82RW9/7mLnrTYylVw/5L173u5D3qU/sU9ahIEEEew3LeHQzyXDoNKVSokx+S/LUIWYT+
 yc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719724; x=1693324524;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34eID9O4+PBEB3o7SJqQTxsS3MiFghkUkiAPDau7XoM=;
 b=hqi65cRlvkadaMgnU2yiblBmNmguYrZ520pyQzxLkoD9Xmmy8TIAEPQ1qFcRYYX0Oa
 UtIgl/glnfnKr26CP1+f1eXgPVKYwL1FOZVtcRPRkdVIWim55SXya9b7RWPgSPgqSTar
 9XXSnXrvnzc5WFu6jKsBZ3dAHrymdka45QHkfer7E7N8H4DU24FgD1p1pzoKWBAR0QzJ
 KiZpCMBhKKNjgDBITR62agpbIogN5nVgR/QWuKNFinXUXvC192rlOLnvip724Ead9zGh
 eAwRr8wvYMBCHGE9IPtF8Rem96WYIvB65jaqexsQVkODqa5nBgVR3wz+3irWiMKZQQA4
 aEDg==
X-Gm-Message-State: AOJu0Yx3Dg1h3ghplpv2hU4Lgce5fRrdqrCAeEU41KaFiCWdgthPM2Ym
 cfKBHRf70oaHLYu+U6pNf2A63Q==
X-Google-Smtp-Source: AGHT+IEz0BYRMjONLUGsiR90mumhdd0xB95L9odyE2yVxgNPChfk+xmKg1p/o0BVKmGMWaVAX9vjoA==
X-Received: by 2002:adf:f7c9:0:b0:313:eaf5:515 with SMTP id
 a9-20020adff7c9000000b00313eaf50515mr6785965wrq.6.1692719724368; 
 Tue, 22 Aug 2023 08:55:24 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f12-20020a0560001b0c00b0031c5d74ecd8sm4265717wrz.84.2023.08.22.08.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 08:55:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: n-francis@ti.com, trini@konsulko.com, bb@ti.com, praneeth@ti.com,
 afd@ti.com, Robert Nelson <robertcnelson@gmail.com>, vigneshr@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH V3 0/4] board: ti: Add support for BeaglePlay
In-Reply-To: <20230822154018.tcj6dlec5xanyzbc@overstay>
References: <20230815164440.2713726-1-nm@ti.com>
 <87ttsrrt1m.fsf@baylibre.com> <20230822154018.tcj6dlec5xanyzbc@overstay>
Date: Tue, 22 Aug 2023 17:55:23 +0200
Message-ID: <87r0nvrs0k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., ao=C3=BBt 22, 2023 at 10:40, Nishanth Menon <nm@ti.com> wrote:

> On 17:33-20230822, Mattijs Korpershoek wrote:
>> On mar., ao=C3=BBt 15, 2023 at 11:44, Nishanth Menon <nm@ti.com> wrote:
>>=20
>> > Add support for BeaglePlay - rev 3
>> >
>> > Boot log: https://gist.github.com/nmenon/3e99b44380873263e39ba4d84788d=
b89
>> >
>> > Full series(including dependencies) can be found at:
>> > https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3
>> >
>> > Caveats:
>> > * I have kept networking out of picture for now as it is still in debug
>> >  (See
>> >   https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3-ene=
t-debug
>> >   if anyone is interested)
>> >
>> > Changes since V2:
>> > * I have rebased to latest next branch
>> >   bdc682437a67 (origin/next) Merge branch '2023-08-14-assorted-general=
-updates' into next
>> > * Uses config fragments by default.
>> > * Updated MAINTAINER file as well
>> >
>> > V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
>> > V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/
>> >
>> > Nishanth Menon (3):
>> >   arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
>> >   board: ti: am62x: Add am62x_beagleplay_* defconfigs
>> >   doc: board: ti: Add BeaglePlay documentation
>> >
>> > Robert Nelson (1):
>> >   arm: dts: Add k3-am625-beagleplay
>>=20
>> I tried these series on top of next on my beagleplay with the intention =
of
>> booting U-Boot from eMMC.
>>=20
>> Base commit: 7e6e40c57233 ("Merge tag 'v2023.10-rc3' into next")
>>=20
>> I can't get this to boot. Seems to be stuck in the r5 spl.
>>=20
>> Boot log is:
>>=20
>> U-Boot SPL 2023.10-rc3-01591-ga4f9ddf99438 (Aug 22 2023 - 17:11:47 +0200)
>> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
>> SPL initial stack usage: 13400 bytes
>> Trying to boot from MMC1
>> mmc_load_image_raw_sector: mmc block read error
>> Partition 1 invalid on device 0
>> spl_register_fat_device: fat register err - -1
>> spl_load_image_fat: error reading image tispl.bin, err - -1
>> SPL: failed to boot from all boot devices
>> ### ERROR ### Please RESET the board ###
>>=20
>> It seems that when we try to find tispl.bin, we read from the mmc0boot0
>> hw partition instead of from the user partition.
>>=20
>> Per my understanding, BeaglePlay has the following (simplified) boot
>> flow:
>
> Thanks Mattijs, we have been discussing this in our discord channel, and

Indeed I saw some things on discord around this but wanted to notice a
broader audience (via the U-Boot list) that booting from eMMC was not
working for some folks.

> I have a new version I am working on. will fix it up and send it later
> today - fixing some other pending documentation aspects atm.

Looking forward to give it a try !

If it's not too much to ask, please cc me on the v4 series.

Thank you.

>
> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
