Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC3FCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 22:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D865B83B22;
	Fri, 31 Oct 2025 23:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NUtfq7qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4024F83B23; Fri, 31 Oct 2025 23:07:14 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DE88397B
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3c96de7fe7eso1949805fac.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761948431; x=1762553231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DfSnq+MD7D4vBhXgmeG7Ucs+2ueg9UsVGgdCut9kPEM=;
 b=NUtfq7qpkjDwCLKnsj4MNMI82J/UpRAKthsp+K5JiV7QaUIOmOKaRHIOsrE2kNPQ3U
 GDAm5/nmjGDsppYs8DYprAt49lH3dzBafDNn7WcUBDNg8hefhf3JXIcPR52GEJSGV0lZ
 J/XvXptM2VDcgFhE+NBIc3MoSKTWBQ/9SYU3/D8+n6gQOKqT3f8cM2uxB8GwNtfjpvcL
 WQM96s1LtiyY7UEtgCVldAJKOMRzDlfXBWP9Fs/88b4S1Q0HU4pT3hlbAqx/eqzfivw7
 9gvnY0d8HY2NJynH9YkxpiBgT91ZY6F0QOEHU9hALmC5RW23Y4zPjoId098BWF7flJR/
 vr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761948431; x=1762553231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DfSnq+MD7D4vBhXgmeG7Ucs+2ueg9UsVGgdCut9kPEM=;
 b=LwqJZe7Uf4ZQKkyty/Z6BrYjjB/VSEZKQV9O0GAhva1rU/TM1D8XM5a8ZpD/wCJ+Fb
 XebG2zwLbzFS4foUZWrF8G+S08oDHRiDUxHSV286oGFzPHuW9fuPbBpSvqj1/fNgLpEw
 fvG/wJBJRt7/fp2I4PMsdob6m/yHNfoKmuDBN/UoOYPrSTqOFUMwRTKNI+L43EpycKXM
 Zc/oRi47wdzDnaUbi9jpoTOpL4qfpe55wDRlJHrn/7HRDoMb11FBQrEUdoQNZ6bKMgY2
 iMk8ulWItXVfJ+4CpCNQDoCoM7vd5et79pHTH4iQNUiFYZiPjhorrLHoXeQcU3hrP10J
 JHoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKEY1oXM/DtZ58arlrG0UyEyvIlZuMFatCMSf75vMUGRHsTiSc/he2WntCv3LxvEVzjBHrE+M=@lists.denx.de
X-Gm-Message-State: AOJu0YxuOfsjrCYsQxWAPzlpstWNnHT+UBqzZ3+rwdukAJ2OiUfD6+OT
 zmPxG4ErK1vR88sr4TXdctju4Lj3Z2y9YD3FMMaB5CMDC2KhHDPNoZxSzuagfWkf2YT78igalx7
 uCYTySWn+VHZaGtIbzyA8AqOuMWQr9BM=
X-Gm-Gg: ASbGncv9EEYsnffh3xeCSqmkC3UZgtQbk7Bnegdq5Ud8ifY8CGPe0f3x35czjr651WK
 O8uYc9OTnysHrvoHMMloKyHnRUCPUDuF/4vxjjeK0eDEsGyDYkFlhFgUaXFc2Udi25WqPmmkoIC
 hrCMt09jeROZi+eP5R+Rpzyu9443mC2bHNv5M6ino9n+USTmC+UrKMZeD7hEN3DvW9FHipCKwYq
 cKvIHVbl1POe3BC9LQbjE290ivblZk9WZzUSWyAdnK0WSPNgQ93B0Ixe8l2jw==
X-Google-Smtp-Source: AGHT+IGcV0Db3imcwXzzZ46p8VGy0fJmPfzm392cF3PXrohk/K/4lAyFdwgiTqoodZCMNn8ZXdIPkmQ6hNqYMO/sS+g=
X-Received: by 2002:a05:6870:cc84:b0:344:a994:2ad4 with SMTP id
 586e51a60fabf-3dacd10ca2dmr1975504fac.20.1761948430698; Fri, 31 Oct 2025
 15:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <20251031191728.GG6688@bill-the-cat>
 <97a6d067-8c57-48cb-ab9b-c5094a798d99@kwiboo.se>
 <CAN7C2SCquwnP5tUE0KLE15wGPqbNE10adEgshXLjRQnTK+JM4g@mail.gmail.com>
 <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
In-Reply-To: <af9255c6-4217-4784-bfcb-b6d90d79d0aa@kwiboo.se>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 1 Nov 2025 06:06:59 +0800
X-Gm-Features: AWmQ_bmQGrZfPMufTZnx_E2Dyy-wiaNBR-_CK1IlkeA-qh_lN_52ugYzvj6pypE
Message-ID: <CAN7C2SBAf7K3eRnSWqXWC0Ffp3+KtdFVFTn0i=XzAsJyM-JP6Q@mail.gmail.com>
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

> Please try my suggestion above, the datasheet for the LDO mention 50us
> start-time and card may need one ms to fully init. Defining this timing
> requirement in the device tree that U-Boot SPL uses should match the
> workaround/fix you mention in your original mail.

Modification on dts as such:

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
startup-delay-us = <2000>;
vin-supply = <&vcc3v3_sys>;
};

SD node on dts roll back to latest U-Boot as such:

&sdmmc {
bus-width = <4>;
cap-sd-highspeed;
cap-mmc-highspeed;
cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
disable-wp;
pinctrl-names = "default";
pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc0_det_l>;
sd-uhs-sdr104;
vmmc-supply = <&vcc3v0_sd>;
vqmmc-supply = <&vcc_sdio>;
status = "okay";
};

Test Result:


U-Boot TPL 2026.01-rc1-00070-ge34d01d23e45-dirty (Nov 01 2025 - 06:01:06)
Channel 0: DDR3, 933MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS=1 Die BW=16 Size=1024MB
no stride
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2026.01-rc1-00070-ge34d01d23e45-dirty (Nov 01 2025 - 06:01:06 +0800)
Trying to boot from MMC2
spl: mmc init failed with error: -5
Error: -5
Trying to boot from MMC1
Card did not respond to voltage select! : -110
spl: mmc init failed with error: -95
Error: -95
Trying to boot from MMC2
spl: mmc init failed with error: -5
Error: -5
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

Thank you Jonas ' feedback on dts.
But sadly stall.

Thank you,
Brian
