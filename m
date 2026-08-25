Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C7C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 20:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DCAC4064C;
	Tue, 25 Aug 2026 20:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9wbTG6TQPM1t; Tue, 25 Aug 2026 20:01:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787688071;
	bh=AZjZbR0v+WGeTBwBxd1DZzx/I7qGbkhFZKZDYit4Bbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bld/ujmrt8sNcK/p/v0AUa/BQ901EGo8mqJLTDd3hkOdSrdgw/0XiLqj/GkCiycIe
	 V4mnTWNxhNkHmpETLDOkHAs6PoMjweenbTL2Wd/8s+y2yXD9cvyx9y2NvCszbVFWEl
	 Byr9f/JEl/DcEj+gmJkmPsu13XLPN4aGk4Ap/nQTGhTTSbxMLfKRDCMFuG5neQqxDW
	 ZLl/yiHwsdAun0SVX1Akqf8Y2mob2n2NiSwUlCLSx7mp5qlCNCmSex57EG7xz+Yd3k
	 gAT9haXD02sLFZfX0oOVjXZfp5LwlLZD2X3XEyujSlTPULQ1f35aoecyAOWBUyu6+1
	 d3ub3FLco7Vjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7E054054C;
	Tue, 25 Aug 2026 20:01:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 332F2396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2511B6070D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:01:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VTUBGavj5GP9 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 20:01:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IUSxMlis
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70344605F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:01:07 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso141722a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787688066; x=1788292866;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AZjZbR0v+WGeTBwBxd1DZzx/I7qGbkhFZKZDYit4Bbg=;
 b=IUSxMlisZ2x7cpdUMIr0JoDKj24skWC4OmwdCzjqEpG026dx9xL717X84IdzJBYqJG
 +2MOrp6p4ASOkP6oItilntank+3tBNVn60Zo0Smxf3/czx+sDSvJ2HdzJer9zyT94BGY
 VJ/4Yox/kl0be+9wHEelZOyK7WqnpdixR2uKXOYwbRqHKvTz97LoJY6Vxv1GM51f4Z3F
 t1RYSdWpDtT5b4mCgWV15BERHljHCEP1cYYYiln/NQ3wo7N9a/aSy085zaVo8JUCWRVN
 atj0ltVI5FwyMGTbS9BhKqSjsQZC6F/amlboKbOwpDuZBXxRJnFONSFui67mr4ovcuA6
 5Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787688066; x=1788292866;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AZjZbR0v+WGeTBwBxd1DZzx/I7qGbkhFZKZDYit4Bbg=;
 b=W7imVbzTESNieVN5a8gx5XEeqOdTP5dCTNDzSu6rgVzNl19lukIkmB/U+703j419Rj
 5OWkMzZdt020aVBT1K9/m27HmhaXysrt8trNynwUVNepT6qL4wkPoBY+pwas99TLAaV1
 y2hmImiAaSFnibqXGqp3Kfc7mOnemZwFlnx5JKuvS95h8Vf7iAyZjGaaOc5ckyNOek8I
 3e1+/iYQRI7Vjd//s5ibNsajT3iZyIYy1QHpRrvrLsV+XG+bdpG+RB3A82rNbIV91xTZ
 Zl4mvVLxDG35zR9oDywHJpT39ogR0qh5/8HsgnoZ2GXgOI1Ys9drU5Qrs5H4LEbO5ycn
 Q3mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMK1x0TzOQ2qE0U1rOPdjLTDXdrdFB/ABQyjinn73+vmnj3Ju0YPnMj3yAdiRnRcmtYhr6zcI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kW06kExwHhCxtgTxEMzJsSkceCrcBd+IZ74jxWGgdZBCiNs6mW
 MvNm2+GYIgAPCV6kPu8ofQ3dBDnRYviocrR9WpsmrW06YBXda9lRUv1VrH2cpBD6FtI=
X-Gm-Gg: AR+sD13TsB61xAjG54yJPDAhKnFFqwcvLZ/5d9HW1eIceTekhjoGXyE7sc7sPkTrf7w
 lDU3tIcgYOHI/q0BapgGnEFxOA5F4ddwnsG/d+rN+LaX3WSwGdjm3pu2v8GGIEoR/w00c+ekayP
 oZgU0umvLMOskzjZErsCY/u7mMRJmkB6tPdN2L0jPR0+jzgZZju2QIcWDOF7aYE2Nz68+QnmbeK
 Kh/L8qzrX495f3DvEH1oMK/Psp0c2wYtU1QDpfxU9PGfaxGM6e9EQG5oqDQ6ior8P5iAkhWqkdb
 KNUJ5dKwpkmhs71VBA1KMo5TcoovPgvKnimEOdjh9zTIHfE1jC/aJfZzVZtbjxuAs62w1jQFEnE
 ndyYVpd1Q2Nb2wi9rZ9tYj5xbIAEA0Jcv0Ssqe1eMrjl82Bwgm5/dde/iBW952d2rFSJzvmswun
 cC+aWYVuuXcygvRqJqeGOF96xES44JcH0IyKM0adbonCUiFcCD1hygMsEIEM5FEGqC1tE3e2mUG
 sBIOr1DJesyk6R+9ViLOnrqeA2fQkgtrG8M
X-Received: by 2002:a05:6820:214:b0:6b1:a11a:eeaf with SMTP id
 006d021491bc7-6b1a11b04b5mr635627eaf.13.1787688066246; 
 Tue, 25 Aug 2026 13:01:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e96b:b637:f05:5bfd?
 ([2600:8803:e7e4:500:e96b:b637:f05:5bfd])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b03b5593sm318837fac.17.2026.08.25.13.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 13:01:04 -0700 (PDT)
Message-ID: <2f402d43-d5f1-44bb-831c-5fdc71e12da9@baylibre.com>
Date: Tue, 25 Aug 2026 15:01:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] configs: mt8188: enable eMMC FIT boot from SPL
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Johan Jonker
 <jbx6244@gmail.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
 <20260814-ccaione-upstream-mt8390-spl-v4-2-f4f92978a79e@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-2-f4f92978a79e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/14/26 9:47 AM, Carlo Caione wrote:
> Enable the Genio 510 and Genio 700 SPL path entered by the external DDR
> loader at 0x40000000. Bind the raw SPL to the loader's 0xaf000-byte copy
> window, place BSS separately in DRAM, and retain the non-overlapping SPL
> malloc region.
> 
> Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
> the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
> MT8188 CONFIG_TEXT_BASE of 0x4c000000.
> 
> The MediaTek BL31 used on these boards stalls when passed the runtime
> devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
> so SPL can still use the tree to locate OP-TEE and U-Boot while passing
> NULL as the separate BL31 platform parameter.

If we do another revision, it could be nice to explain where some more of
these parameters come from. For example, 0x400bb800 seem quite specific
like there would be a reason for it rather than a nice round number.

> 
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  configs/mt8188.config | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/configs/mt8188.config b/configs/mt8188.config
> index 29e2b3db878..a84e617e30f 100644
> --- a/configs/mt8188.config
> +++ b/configs/mt8188.config
> @@ -28,3 +28,30 @@ CONFIG_MTK_SERIAL=y
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y
>  # CONFIG_RANDOM_UUID is not set
> +CONFIG_SPL=y
> +CONFIG_SPL_TEXT_BASE=0x40000000
> +CONFIG_SPL_MAX_SIZE=0xaf000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x400bb800
> +CONFIG_SPL_BSS_LIMIT=y
> +CONFIG_SPL_BSS_MAX_SIZE=0x100000
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x9000000
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_SERIAL=y
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_SPL_PINCONF=y
> +CONFIG_SPL_WATCHDOG=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_EFI_PARTITION=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> 

