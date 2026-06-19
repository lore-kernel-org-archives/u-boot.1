Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E63BCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 13:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91197849BF;
	Fri, 19 Jun 2026 15:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fw/C3Dhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97CBF84A12; Fri, 19 Jun 2026 15:39:01 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6ED801A9
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 15:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so2781560a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 06:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781876339; cv=none;
 d=google.com; s=arc-20240605;
 b=IH/8L/YnuWDUISNIlEyxN4sb32skLaTfIRBvG1N3kBJfveXMqJpi1hxhNRrCKybl5F
 DuGDpTmW3mexPvUlHQ14vwszwj/idQ99voPKvd941gCUXHZZByIuHD3p/6h0SFC0mFGc
 90nKAUBitvUovGyIuEbt0VQdRP+lGh/gsI1z91TscT4I6q0k8UJAD/UlBIpWLbBPmISJ
 f6mJFrodsmB30LMiYJhaCMGECPsmv6O8VWsTk+SASNSkYU9FV9pZ39XMTnW0//PMxCsJ
 nSL8HsD27ussQEDh8xg6iF5a7oPYEZkdHjDv9ipOLADkHr/h6YwPSszmHzIPFzBUzLDz
 yHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YhmNJv0tBBqorQ2zeQq9rrwqg7YD4fPxCyWWWje/8gQ=;
 fh=rdY9HAj/TUsXz7s2nKT/0L4YR9A/lqlP4ai30Pukds8=;
 b=IHIj3yB7Rt1GNTjJdOb3oYHXGWOgf6iZsZOwexCKuMfzjbmX90b6TM0rgPwScSMidE
 Nl722sgN2pU6sV4zI+hdv1zF6nnGWq7zBKpG3E+gnFitEUMiJQiIgcop6+et2gvvgsVT
 V/ezt4OBppx6pLqnf29Lhaq8QNBQqCGe3+c7q+4ksmcwRsjHXCBNadhSitoRVDRhyvi9
 mW6vHGeoXmEhE0WgzsullENYjDXJFa9JDPKk+OsG8M+8CLM+a+gRwyngMFsJ97QzhtrX
 IZ/fN3OHcebOZMaqVVsX2Uz9OLjxfc3v0UWGVAjbLmr2uJGkm5McY7fN9FL7IPxmul/g
 fZIg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781876339; x=1782481139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YhmNJv0tBBqorQ2zeQq9rrwqg7YD4fPxCyWWWje/8gQ=;
 b=Fw/C3DhnGZeMALYOtD+RK6BNhY7lBr1wVUz7d2AqPJctMRjq8GDAa8qL1wKbUhyueF
 k9J49fSVCP5iScm22ZwxBik5FDw85hx7JlLhMvqsPYAXa9EiZRGVRJcESBeFavKJxDH6
 MUjJz63tTspbrp3hH8iHuYS1fViz/SPI9wd34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876339; x=1782481139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhmNJv0tBBqorQ2zeQq9rrwqg7YD4fPxCyWWWje/8gQ=;
 b=nB67OLDCbzRXP/kgbhKLklzQpWe9/SqsHH0lKsNQ25k+/m7rmSaW9MIoJHUFErKuQ3
 b0V4In/+1BuKmJYHWbC0OWwR4HokszwtQN8VT37qUJmk8QuvC+vXTqFt+krpePm/rnAf
 L2Ie5N63OwwZwe+1aMQJTSTaST4JK7v7zYAtHnZw3qZxXKphCjISsDTZ9c1JnYMxOP4e
 oTkWkEJL1MZrVsYYV/bqVQUULRg+bP8JMlzGcWm4Xq3Y0eiayGwcU0voBqHDExw52o/0
 pQVBQwCJeNxq7RSAhWcZktDqZ2cnbzz/Zhvi7zmSbFAj0Zm8wdZqlOi9VnINcHSSEsOg
 9ggg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IWQqYPet3npnowdkUKRA9jZGqCuTHkSXmBk+GU2OAYvTQDid1VRE1Ob44PkqJxxhvS48z8Wg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb1OQItivlmhU6OVWvWpS5e2Nop/Tdyh9aOIr1k3ForqBy2fW5
 xmZ7t3SCytY9cbLcwvp30AdCFddPdhedoZdS5zgIb/8u/Sc1PzjTKz4v9IRBMu7re+Uef9F3NfT
 WDZM3fdvF8A54QEyAjXDyNxATrXz5aO2ebiIMLdRZ
X-Gm-Gg: AfdE7cn/Jm4sMKJbPEDXDEoSuyeQb1ZXSTQNmwG8sUgR5sNSyQkEMq3pE7ir6OAGDyk
 Q6WNdCuTM5vhE1u3A0MJpYWtSI9jrKZIV/HFdpRE7N+nmHzYJfpjNfic8xvjWbTcb4OJ4xKoZR9
 T7vn2SI26whepOANvArJCflSx9B18FEv+0tf7ucXaPsREJBRM/BNBA+P0KdcuRjcEb3zIgJ8XIF
 LM843WKGeBJR37EnV9wLsbnvBQFUeysQjYLgcX3UZ7eTndM+SEsK6TuYi+kM8ZXeE0T0XpClQ==
X-Received: by 2002:a05:6402:5194:b0:684:95a:4d05 with SMTP id
 4fb4d7f45d1cf-696edc8d1f8mr1968890a12.8.1781876338680; Fri, 19 Jun 2026
 06:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
 <20260616191845.6182-8-ansuelsmth@gmail.com>
In-Reply-To: <20260616191845.6182-8-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 14:38:46 +0100
X-Gm-Features: AVVi8Cdc1VPcb44lsHU6VCGYEYb61ru8UBuKTjgDIfcnmbe1RBLN8FB6YMAyTMw
Message-ID: <CAFLszThXdwM=6DoZbeYsd6d2Y2CrwOr2ZuW4rzB3C46nzDwOWw@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] test: dm: Add test for FW Loader feature
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Hi Christian,

On 2026-06-16T19:18:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> test: dm: Add test for FW Loader feature
>
> Add basic test for FW Loader feature for the Filesystem way.
>
> An additional MMC testing image is added that loads a dummy firmware.bin in
> a fat partition. Update all the affected test for this additional eMMC
> node.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> arch/sandbox/dts/test.dts          |  20 +++++++
>  configs/sandbox64_defconfig        |   1 +
>  configs/sandbox_defconfig          |   1 +
>  configs/sandbox_flattree_defconfig |   1 +
>  configs/sandbox_noinst_defconfig   |   1 +
>  configs/sandbox_spl_defconfig      |   1 +
>  configs/sandbox_vpl_defconfig      |   1 +
>  test/boot/bootdev.c                |  34 +++++++----
>  test/boot/bootflow.c               |  12 +++-
>  test/dm/Makefile                   |   1 +
>  test/dm/blk.c                      |  41 +++++++++-----
>  test/dm/fw_loader.c                | 112 +++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py           |  18 ++++++
>  13 files changed, 216 insertions(+), 28 deletions(-)

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -123,6 +123,7 @@ static int bootflow_cmd_label(struct unit_test_state *uts)
>        * 8   [   ]      OK  mmc       mmc2.bootdev
>        * 9   [ + ]      OK  mmc       mmc1.bootdev
>        * a   [   ]      OK  mmc       mmc0.bootdev
> +      * a   [   ]      OK  mmc       mmc11.bootdev
>        *

The label here should be b for the new bootdev, not a second a.

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,112 @@
> +static int dm_test_fw_loader_get_fw_size(struct unit_test_state *uts)
> +{
> +     struct udevice *mdio_dev, *fw_loader_dev = NULL;
> +     ofnode mdio_node, phy_node;
> +     int ret;
> +
> +     ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, 'mdio-test',
> +                                           &mdio_dev));
> +
> +     mdio_node = dev_ofnode(mdio_dev);
> +     ut_assert(ofnode_valid(mdio_node));
> +
> +     phy_node = ofnode_find_subnode(mdio_node, 'ethernet-phy@2');
> +     ut_assert(ofnode_valid(phy_node));
> +
> +     ret = get_fw_loader_from_node(phy_node, &fw_loader_dev);
> +     ut_assertok(ret);
> +     ut_assertnonnull(fw_loader_dev);

All three tests repeat the same six-line dance to look up the mdio
device, walk to ethernet-phy@2 and resolve the loader. Please factor
this into a helper (or per-suite fixture).

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,112 @@
> +     ret = request_firmware_into_buf(fw_loader_dev, 'firmware.bin',
> +                                     buf, firmware_size, firmware_size);
> +     ut_asserteq(0, ret);
> +
> +     ret = request_firmware_into_buf(fw_loader_dev, 'firmware.bin',
> +                                     buf, firmware_size, 0);
> +     ut_asserteq(firmware_size, ret);

Please also exercise the past-the-end case (offset > firmware_size)
and a missing-file case (does-not-exist.bin). Also free(buf) before
returning.

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,112 @@
> +DM_TEST(dm_test_fw_loader_get_fw_in_buf, UTF_SCAN_FDT);

The FIP loader is the headline feature of the series but has no
coverage here - only the FS loader path is exercised. Given that the
FIP parser does UUID lookups, header validation and offset accounting,
please add at least one test (a small canned FIP blob in an image, or
a sandbox helper to fabricate one). Otherwise regressions in
fip_loader.c will go unnoticed.

> diff --git a/test/dm/blk.c b/test/dm/blk.c
> @@ -208,14 +212,15 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
>       i = 0;
>       blk_foreach_probe(BLKF_REMOVABLE, dev)
> -             ut_asserteq_str(i++ ? 'mmc0.blk' : 'mmc1.blk', dev->name);
> -     ut_asserteq(2, i);
> +             ut_asserteq_str((++i == 1 ? 'mmc1.blk' : i == 2 ?
> +                     'mmc0.blk' : 'mmc11.blk'), dev->name);
> +     ut_asserteq(3, i);

The nested ternary is hard to read; with three entries a small const
char *expected[] = { ... } indexed by i would be clearer, matching the
BLKF_BOTH case below.

Regards,
Simon
