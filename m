Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACEEC021AB
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 22:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF43E80843;
	Mon, 17 Feb 2025 23:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KPVKaD7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA398809A4; Mon, 17 Feb 2025 23:10:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BA5807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a97e=VJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739830246;
 bh=5tN12xb3NU45rqkgMzL1LjDGltVtvgVqApHNRwITFjA=;
 b=KPVKaD7CGLbwd8SSuTPiMWansO5lAo0OFmSkMCptYr/hDbkM+LnIl6TMNPahOUgS3Ev9TH8kr
 T9IHuEyFHsirYtczNVeJlATZ4DrJXmWUgNoD/dvs7oXxaYHUArCjdJzylVl8LPF9xBOwq/QDOg8
 wmuwwGmltr2gN1e585g8IsiZk4y57NbwLIOK1TFmoeNbkN1a5gR9artkI8/cxjQMAVhw+e42PmP
 Uu+e6Xcb9YY+lIOyPCLXrB47QZymk8GXB+a3dbznoDJZ7tZRAWPb03DOlm3fpONIDQhrQ3ZS9Mx
 WEPzaY3S0hx+bDzvjpYjztlPxdeTbl2Lf8hbOkwViJ8g==
X-Forward-Email-ID: 67b3b3e4179e723bb8e57b76
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0140a9ed-2f9e-460d-85e6-c3490a9223db@kwiboo.se>
Date: Mon, 17 Feb 2025 23:10:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/35] rockchip: Set the skip-at-start property
 correctly
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-31-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250209211502.2299245-31-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 2025-02-09 22:14, Simon Glass wrote:
> The rockchip image is written to the media at block 64, which is a 32K
> offset, so set the skip-at-start property to 0x8000
> 
> Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
> Binman is dealing with the 'missing' 32K now.

This confuses me, to me the image is the output binary image. And the
offset in the image is what SPL_PAD_TO already is referring to.

The help for SPL_PAD_TO mention "Image offset to which the SPL should be
padded before appending the SPL payload.".

I can be fine with changing it to payload location in storage, however
do such mass change in a separate series and with a clear explanation
why SPL_PAD_TO should mean the offset on storage and not offset in the
output binary image written to storage.

With one patch that just add the skip-at-start prop and adjust to use
<(CONFIG_SPL_PAD_TO + 0x8000)> for the offset prop. And put the mass
change to defconfig in a separate patch.

Another option could possible be to use SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
in a calculation and drop use of the SPL_PAD_TO symbol.

Else this blocks others from adding new boards, and/or will break them
if a defconfig was missed. With a separate series adding a new board can
just reference the smaller series.

Regards,
Jonas

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Move this patch to the end of the series
> - Drop 0x8000 offset for SPI
> 
>  arch/arm/dts/rockchip-u-boot.dtsi             | 1 +
>  configs/anbernic-rgxx3-rk3566_defconfig       | 2 +-
>  configs/bpi-r2-pro-rk3568_defconfig           | 2 +-
>  configs/chromebit_mickey_defconfig            | 2 +-
>  configs/chromebook_bob_defconfig              | 2 +-
>  configs/chromebook_jerry_defconfig            | 2 +-
>  configs/chromebook_kevin_defconfig            | 2 +-
>  configs/chromebook_minnie_defconfig           | 2 +-
>  configs/chromebook_speedy_defconfig           | 2 +-
>  configs/cm3588-nas-rk3588_defconfig           | 2 +-
>  configs/coolpi-4b-rk3588s_defconfig           | 2 +-
>  configs/coolpi-cm5-evb-rk3588_defconfig       | 2 +-
>  configs/coolpi-cm5-genbook-rk3588_defconfig   | 2 +-
>  configs/eaidk-610-rk3399_defconfig            | 2 +-
>  configs/evb-px30_defconfig                    | 2 +-
>  configs/evb-px5_defconfig                     | 2 +-
>  configs/evb-rk3036_defconfig                  | 2 +-
>  configs/evb-rk3229_defconfig                  | 2 +-
>  configs/evb-rk3288_defconfig                  | 2 +-
>  configs/evb-rk3308_defconfig                  | 2 +-
>  configs/evb-rk3328_defconfig                  | 2 +-
>  configs/evb-rk3399_defconfig                  | 2 +-
>  configs/evb-rk3568_defconfig                  | 2 +-
>  configs/evb-rk3588_defconfig                  | 2 +-
>  configs/ficus-rk3399_defconfig                | 2 +-
>  configs/firefly-px30_defconfig                | 2 +-
>  configs/firefly-rk3288_defconfig              | 2 +-
>  configs/firefly-rk3399_defconfig              | 2 +-
>  configs/generic-rk3568_defconfig              | 2 +-
>  configs/generic-rk3588_defconfig              | 2 +-
>  configs/jaguar-rk3588_defconfig               | 2 +-
>  configs/khadas-edge-captain-rk3399_defconfig  | 2 +-
>  configs/khadas-edge-rk3399_defconfig          | 2 +-
>  configs/khadas-edge-v-rk3399_defconfig        | 2 +-
>  configs/khadas-edge2-rk3588s_defconfig        | 2 +-
>  configs/kylin-rk3036_defconfig                | 2 +-
>  configs/leez-rk3399_defconfig                 | 2 +-
>  configs/lubancat-2-rk3568_defconfig           | 2 +-
>  configs/miqi-rk3288_defconfig                 | 2 +-
>  configs/mk808_defconfig                       | 2 +-
>  configs/nanopc-t4-rk3399_defconfig            | 2 +-
>  configs/nanopc-t6-rk3588_defconfig            | 2 +-
>  configs/nanopi-m4-2gb-rk3399_defconfig        | 2 +-
>  configs/nanopi-m4-rk3399_defconfig            | 2 +-
>  configs/nanopi-m4b-rk3399_defconfig           | 2 +-
>  configs/nanopi-neo4-rk3399_defconfig          | 2 +-
>  configs/nanopi-r2c-plus-rk3328_defconfig      | 2 +-
>  configs/nanopi-r2c-rk3328_defconfig           | 2 +-
>  configs/nanopi-r2s-plus-rk3328_defconfig      | 2 +-
>  configs/nanopi-r2s-rk3328_defconfig           | 2 +-
>  configs/nanopi-r3s-rk3566_defconfig           | 2 +-
>  configs/nanopi-r4s-rk3399_defconfig           | 2 +-
>  configs/nanopi-r5c-rk3568_defconfig           | 2 +-
>  configs/nanopi-r5s-rk3568_defconfig           | 2 +-
>  configs/nanopi-r6c-rk3588s_defconfig          | 2 +-
>  configs/nanopi-r6s-rk3588s_defconfig          | 2 +-
>  configs/neu2-io-rv1126_defconfig              | 2 +-
>  configs/neu6a-io-rk3588_defconfig             | 2 +-
>  configs/neu6b-io-rk3588_defconfig             | 2 +-
>  configs/nova-rk3588s_defconfig                | 2 +-
>  configs/odroid-go2_defconfig                  | 2 +-
>  configs/odroid-m1-rk3568_defconfig            | 2 +-
>  configs/odroid-m1s-rk3566_defconfig           | 2 +-
>  configs/odroid-m2-rk3588s_defconfig           | 2 +-
>  configs/orangepi-3b-rk3566_defconfig          | 2 +-
>  configs/orangepi-5-plus-rk3588_defconfig      | 2 +-
>  configs/orangepi-5-rk3588s_defconfig          | 2 +-
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 +-
>  configs/orangepi-r1-plus-rk3328_defconfig     | 2 +-
>  configs/orangepi-rk3399_defconfig             | 2 +-
>  configs/phycore-rk3288_defconfig              | 2 +-
>  configs/pinebook-pro-rk3399_defconfig         | 2 +-
>  configs/pinephone-pro-rk3399_defconfig        | 2 +-
>  configs/pinetab2-rk3566_defconfig             | 2 +-
>  configs/popmetal-rk3288_defconfig             | 2 +-
>  configs/powkiddy-x55-rk3566_defconfig         | 2 +-
>  configs/puma-rk3399_defconfig                 | 2 +-
>  configs/px30-core-ctouch2-of10-px30_defconfig | 2 +-
>  configs/px30-core-ctouch2-px30_defconfig      | 2 +-
>  configs/px30-core-edimm2.2-px30_defconfig     | 2 +-
>  configs/qnap-ts433-rk3568_defconfig           | 2 +-
>  configs/quartz64-a-rk3566_defconfig           | 2 +-
>  configs/quartz64-b-rk3566_defconfig           | 2 +-
>  configs/quartzpro64-rk3588_defconfig          | 2 +-
>  configs/radxa-cm3-io-rk3566_defconfig         | 2 +-
>  configs/radxa-e25-rk3568_defconfig            | 2 +-
>  configs/radxa-zero-3-rk3566_defconfig         | 2 +-
>  configs/rk3399-generic-ddr3_defconfig         | 2 +-
>  configs/roc-cc-rk3308_defconfig               | 2 +-
>  configs/roc-cc-rk3328_defconfig               | 2 +-
>  configs/roc-pc-mezzanine-rk3399_defconfig     | 2 +-
>  configs/roc-pc-rk3399_defconfig               | 2 +-
>  configs/rock-3a-rk3568_defconfig              | 2 +-
>  configs/rock-3b-rk3568_defconfig              | 2 +-
>  configs/rock-3c-rk3566_defconfig              | 2 +-
>  configs/rock-4c-plus-rk3399_defconfig         | 2 +-
>  configs/rock-4se-rk3399_defconfig             | 2 +-
>  configs/rock-5-itx-rk3588_defconfig           | 2 +-
>  configs/rock-5c-rk3588s_defconfig             | 2 +-
>  configs/rock-pi-4-rk3399_defconfig            | 2 +-
>  configs/rock-pi-4c-rk3399_defconfig           | 2 +-
>  configs/rock-pi-e-rk3328_defconfig            | 2 +-
>  configs/rock-pi-e-v3-rk3328_defconfig         | 2 +-
>  configs/rock-pi-n10-rk3399pro_defconfig       | 2 +-
>  configs/rock-pi-n8-rk3288_defconfig           | 2 +-
>  configs/rock-pi-s-rk3308_defconfig            | 2 +-
>  configs/rock-s0-rk3308_defconfig              | 2 +-
>  configs/rock2_defconfig                       | 2 +-
>  configs/rock5a-rk3588s_defconfig              | 2 +-
>  configs/rock5b-rk3588_defconfig               | 2 +-
>  configs/rock64-rk3328_defconfig               | 2 +-
>  configs/rock960-rk3399_defconfig              | 2 +-
>  configs/rock_defconfig                        | 2 +-
>  configs/rockpro64-rk3399_defconfig            | 2 +-
>  configs/sige7-rk3588_defconfig                | 2 +-
>  configs/sonoff-ihost-rv1126_defconfig         | 2 +-
>  configs/soquartz-blade-rk3566_defconfig       | 2 +-
>  configs/soquartz-cm4-rk3566_defconfig         | 2 +-
>  configs/soquartz-model-a-rk3566_defconfig     | 2 +-
>  configs/tiger-rk3588_defconfig                | 2 +-
>  configs/tinker-rk3288_defconfig               | 2 +-
>  configs/tinker-s-rk3288_defconfig             | 2 +-
>  configs/toybrick-rk3588_defconfig             | 2 +-
>  configs/turing-rk1-rk3588_defconfig           | 2 +-
>  configs/vyasa-rk3288_defconfig                | 2 +-
>  125 files changed, 125 insertions(+), 124 deletions(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 0d59aad86bf..937d5a81742 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -201,6 +201,7 @@
>  	simple-bin {
>  		filename = "u-boot-rockchip.bin";
>  		pad-byte = <0xff>;
> +		skip-at-start = <0x8000>;
>  
>  #ifndef CONFIG_VPL
>  		mkimage {
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
> index 14c97b4c5bf..972d4c71b14 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -28,7 +28,7 @@ CONFIG_BOARD_TYPES=y
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_BOARD_RNG_SEED=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> -CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_PAD_TO=0x800000
>  CONFIG_SPL_BOARD_INIT=y
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>  CONFIG_SPL_POWER=y

[snip]
