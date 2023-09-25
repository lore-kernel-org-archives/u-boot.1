Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B91CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 04:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F6D86B3F;
	Mon, 25 Sep 2023 06:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HB8mKzUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492CA86B69; Mon, 25 Sep 2023 06:24:18 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3912986B18
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P4O5I2108667;
 Sun, 24 Sep 2023 23:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695615845;
 bh=xZQ4Zx7KFWvXZw1ED3GedC5xNjGoxRsGASShvSj/xak=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HB8mKzUdbp/wTKD4kRxW/NABxoG8QqkDlZrwJ7z1Oz1wWiVsEKF/Ss+5K65QEhWJD
 qNuqCwzylDnrV8xNHlMWB47vIlHpAIl0uzU/hDMdfGqNI0+Hd7R325zXFxdFXmB/0h
 04eALcYe7+3DjVkeDbHhZ1N8HPYgotmCPmc9xDnM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P4O5J7096630
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 24 Sep 2023 23:24:05 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Sep 2023 23:24:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Sep 2023 23:24:05 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P4O2Re037057;
 Sun, 24 Sep 2023 23:24:03 -0500
Message-ID: <c7c31d97-0bb1-0c87-e22d-d268f682e607@ti.com>
Date: Mon, 25 Sep 2023 09:54:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Question about boot failure of AM64-SK
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>
CC: Nishanth Menon <nm@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>
References: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Masahiro,

On 21/09/23 20:33, Masahiro Yamada wrote:
> Hi.
[...]

> spl: mmc boot mode: fs
> Found FIT
> Error reading cluster
> fit read sector 0, sectors=985528, dst=, count=18446744073709551615,
> size=0xf09b8
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
> 

Looks like SD card incompatibility to me. Could you try couple of things:

a) Different brand SD card
b) Degrade speeds to non UHS mode:

diff --git a/arch/arm/dts/k3-am642-sk.dts b/arch/arm/dts/k3-am642-sk.dts
index 2e2d40da360a..35da121de872 100644
--- a/arch/arm/dts/k3-am642-sk.dts
+++ b/arch/arm/dts/k3-am642-sk.dts
@@ -408,6 +408,7 @@
        pinctrl-0 = <&main_mmc1_pins_default>;
        ti,driver-strength-ohm = <50>;
        disable-wp;
+       no-1-8-v;
 };




> 
> 
> 
> 
> My build sequence is something like this:
> 
> 
> 
>       # for wakeup
>       make -j "$(nproc)" O=build-wakeup CROSS_COMPILE=arm-linux-gnueabihf- \
>           BINMAN_INDIRS="${SNAPCRAFT_STAGE}/ti-linux-firmware" \
>           am64x_evm_r5_defconfig all
>       cp build-wakeup/tiboot3-am64x-gp-evm.bin "${STAGE}/tiboot3.bin"
> 
>       # for main
>       make -j "$(nproc)" O=build-main am64x_evm_a53_defconfig
>       make -j "$(nproc)" O=build-main CROSS_COMPILE=aarch64-linux-gnu- \
>           BINMAN_INDIRS="${STAGE}/ti-linux-firmware" \
>           BL31="${STAGE}/bl31.bin" \
>           TEE="${STAGE}/tee-raw.bin" \
>           all
>       cp build-main/tispl.bin build-main/u-boot.img "${STAGE}"
> 
> 

Seems alright to me.

> 
> 
> 
> 
> Strangely, AM62-SK booted successfully,
> but AM64-SK failed.
> I do not know why.
> 
> 

-- 
Regards
Vignesh
