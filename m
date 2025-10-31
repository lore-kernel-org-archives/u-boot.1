Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A191CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 22:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FA483B24;
	Fri, 31 Oct 2025 23:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hk+BSibf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A33583B27; Fri, 31 Oct 2025 23:14:25 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D1183B23
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 23:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c5333e7099so1813486a34.3
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761948862; x=1762553662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+3MCoBhlE1xZeQDkxnU96f0+jKLJ+7oFw/26X9IrIug=;
 b=hk+BSibfbXowusvfzyxvmDpl+2mTnN05h7uXz5Eisz+PzViFypg5qcL/HNTsHrKFY8
 l+0/rYL/JxWx7nidj28/vN7nLMBiJJKV6z4qqEsmiQPClVNFPKnM5nlAbgNLeuX5Vxno
 6Q/K7m/idxkvri8WDnHIbOq9Uke0aSFuQCFzSGeRy9HSV+i1+OFz9FSkcTjL+/+xan5o
 M0fOYJ36FRd/nIr6kgm2xmWhJIW3HvEF57Iw/7GbrsvgT18vgfAhF70SLkn1+pfB6ibq
 usLOgEqDrSqBasiXeLSIGoWJ7Dx9dc9lfyp7YI8SEsx/h0H0dtwTVsXQ0c1Hso3vkqR+
 LZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761948862; x=1762553662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3MCoBhlE1xZeQDkxnU96f0+jKLJ+7oFw/26X9IrIug=;
 b=QaNbtuCqDHPimsvs+g/t+xnXEeI3gVPaWRi6vcNkyhCInyHry3DXwifsQMRGPbQlWv
 htCXKNliQBiCD4OQfbixLaCkNZgJYeAtXkS6M5tro3IN2qajaJ9QjqlbyJkLXR9MtSl6
 3+baU/2nUvCj+X8y4iyz84sLvfPQRZw+IR0+hAthL3lo67EZJfpWb44F7e9HdCca+p9F
 OB3hHEiS++hbvNAyazQmwWtpd+20LXZB68GpSxzK1t9Fgw/OMO6XyCu4On8heAzI4h69
 J9Q5uwqHc66E581KHXPQfbudf7/P7BuFym+mjFEuIvOu2LocGRbX61iXzjLpPlUo08zo
 yVBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0n91LSPa8lWSSG8kElFpLjK3d+6hgBpXhg3t4zjRVkrYJ/5Q2iSnr8q+1aYjs73C4CBx8W80=@lists.denx.de
X-Gm-Message-State: AOJu0YyDsZbM2R3VFv5R+wfmU9N5EkpEhEeaibdydfIMRJQ98BQIZ6OH
 DmefiJEDgMg693UzkHNJRZn1l/453/2Zi3K7KDXGBsWKVnYyz7D5MIYBkyoNHkSJOhPIX5Zgfi7
 0OfUmC8yXioFKbrqTSJGFEaQJceI7f/w=
X-Gm-Gg: ASbGncuD9GljmNAMH2+RxG+q690B+1w7Xm4WMxNAD3ghCoaLfVpgB66mxOjEGvvmPAa
 Vn4dufUemDj7QZOp330FJRADPhc6g8D5FwHvtonOm2otVEca0CXuP4vpMpQuMUbQjuhsN4EANcQ
 Lf25XP5BjG2Yz/Nvt8V7bh5NbDefWxz3A3DHekFCIzTKnpxA6m/g0zguKikRDiDnpR7tSJvG/4M
 tjVtG5LidbqcNlWT/lM1i9aBQ4JxbP9KPhOgwe7bpc+4ELDmHZmKEAOgYCY1g==
X-Google-Smtp-Source: AGHT+IH1CHdyZzVBo+fWJFf6WUFg+AM6m+wZZ4fCKJjWgzHzUgQIUj3KIf1cRQVd6TcHFtCIe35vaH2Ky4IJrNYTJ24=
X-Received: by 2002:a05:6830:3812:b0:758:71cd:897f with SMTP id
 46e09a7af769-7c6966fe731mr2534284a34.7.1761948861893; Fri, 31 Oct 2025
 15:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
 <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
 <CAN7C2SBAf7K3eRnSWqXWC0Ffp3+KtdFVFTn0i=XzAsJyM-JP6Q@mail.gmail.com>
In-Reply-To: <CAN7C2SBAf7K3eRnSWqXWC0Ffp3+KtdFVFTn0i=XzAsJyM-JP6Q@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 06:14:11 +0800
X-Gm-Features: AWmQ_bm9V9b5jC2ebk_PSYYWrewJEtYpdc1cxJIx1fGI57h2QaEM6aAOSzBmkGk
Message-ID: <CAN7C2SDDeNpHoWBHnuKAc5kzCK5Z-1VpWoKNXqvm8_-MWkpSCA@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

> Thank you Jonas ' feedback on dts.
> But sadly stall.

More info on this issue:

LDO node on dts:

vcc3v0_sd: regulator-vcc3v0-sd {
compatible = "regulator-fixed";
enable-active-high;
gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
pinctrl-names = "default";
pinctrl-0 = <&sdmmc0_pwr_h>;
regulator-always-on;
regulator-min-microvolt = <3000000>;
regulator-max-microvolt = <3000000>;
regulator-name = "vcc3v0_sd";
vin-supply = <&vcc3v3_sys>;
};

SD node on dts:

&sdmmc {
bus-width = <4>;
cap-sd-highspeed;
cap-mmc-highspeed;
cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
disable-wp;
pinctrl-names = "default";
pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc0_det_l>;
sd-uhs-sdr104;
// vmmc-supply = <&vcc3v0_sd>;
vqmmc-supply = <&vcc_sdio>;
status = "okay";
};

Test Result:


U-Boot TPL 2026.01-rc1-00070-ge34d01d23e45-dirty (Nov 01 2025 - 06:07:29)
Channel 0: DDR3, 933MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS=1 Die BW=16 Size=1024MB
no stride
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2026.01-rc1-00070-ge34d01d23e45-dirty (Nov 01 2025 - 06:07:29 +0800)
Trying to boot from MMC2
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
load_simple_fit: Skip load 'atf-5': image size is 0!
NOTICE:  BL31: v2.13.0(release):v2.13.0-1123-g6cec8315a
NOTICE:  BL31: Built : 00:43:13, Oct 31 2025


U-Boot 2026.01-rc1-00070-ge34d01d23e45-dirty (Nov 01 2025 - 06:07:29 +0800)

SoC: Rockchip rk3399
Reset cause: POR
Model: FriendlyARM NanoPi NEO4 2025/10 Build
DRAM:  1 GiB (total 1022 MiB)
PMIC:  RK808
Core:  305 devices, 31 uclasses, devicetree: separate
MMC:   mmc@fe310000: 3, mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from MMC... Reading from MMC(1)... OK
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: FriendlyARM NanoPi NEO4 2025/10 Build
Net:   eth0: ethernet@fe300000

Hit any key to stop autoboot: 2

According to a simple comment on the SD node of
" vmmc-supply = <&vcc3v0_sd>;"

The boot is working properly.
Based on the above observation I can only narrow down
to LDO timing or power rail sanity issues.

Brian
