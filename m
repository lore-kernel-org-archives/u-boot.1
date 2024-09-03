Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067BCD342F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 07:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C976588C19;
	Tue,  3 Sep 2024 09:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oXcv4zHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE30D88C1C; Tue,  3 Sep 2024 09:27:22 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F7588363
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 09:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374c3eef39eso1560574f8f.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725348440; x=1725953240;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nlnt1bjZz/qf94oYHpuJZLuOpDp1IVgIgxb52Rvw3iE=;
 b=oXcv4zHAoJxv3VSCVCL3jq13hXo4lEn1LckwprY2Ggd2Zuw3yWeZKF2fLoIPSymLk+
 FWcFKbWeQ4lj7QtCUzM7DISr+w1uFfHu/Va64DPwgKb2VBUNdHR+phj0q5wLPQUD2lf9
 8jkU2p53KlgwnWcJ0aI53yS5b3FFqjy++PCWIKJWfWky0RdLah5E8hQVlASarxqPnCtI
 7mmBBZyVChJ4DXjrwbjSlmFju2AkONJiWAqWM+MxheSMbf0RHv+PkP7teScO4jbTtvf9
 deNgL+gBR3JoECypA5xKmgHKQEcV92vP9A08btHmWJVvo8IlCm7s/43DUMho49fkNy36
 xsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725348440; x=1725953240;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlnt1bjZz/qf94oYHpuJZLuOpDp1IVgIgxb52Rvw3iE=;
 b=TovzzEzgNEPyR9jLVBM9+mw+mIEOfwg9qxR27EAjA5hefR9oBc5GS2UmWdO2oBRLAf
 8BPnM3diFjkjNdYKihSRC2TysmH40z/Grw4mtVsSuRELxpbJSdYQVlAbqhQAkOuRT3/q
 e1wn7fLiA6Ay30iTT5e1Zt7wR43uXL9Ky6SM1VpGC4vOXMzntdgSKb/QuQmE4ip3cnyA
 BgUYHhHLeIAevz2akiPOv3zeRI5veiPbpNs8H1Ubhrlx9ND3T62reLf9To3R+vNekENs
 Jqb7B6s9Y1IPrAK341rIu/p7FL9iRPuEfepkL7pvXXMEMCR0bPCtTYNAoUyQFKFe5Dhg
 bGvQ==
X-Gm-Message-State: AOJu0YycFf5wYZ4xUjvzwoa+ZMdrYgfP8voM+CoJi8iaTHjLifB8Snax
 BD/n9iWm6WJpbc5rB1dYxCAXINmS3c6CSAk9nMGvncfp2RJoCpNVzPPMAlp2IPY=
X-Google-Smtp-Source: AGHT+IHHblmrD4Jco7mbVXduGrTqIcM4LOjFx0BdD74Y3gswZufe7/V4PWPkbzIQrX3Z6IDJVExVOQ==
X-Received: by 2002:a5d:6d01:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-374c94714c4mr5465446f8f.40.1725348439948; 
 Tue, 03 Sep 2024 00:27:19 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbf15b9b1sm120457315e9.10.2024.09.03.00.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 00:27:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, Guillaume La
 Roque <glaroque@baylibre.com>
Subject: Re: [PATCH 2/3] board: beagle: beagleplay: Add android bootflow
 support
In-Reply-To: <20240902-sitaraupstream-v1-2-0c478c33c08b@baylibre.com>
References: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
 <20240902-sitaraupstream-v1-2-0c478c33c08b@baylibre.com>
Date: Tue, 03 Sep 2024 09:27:15 +0200
Message-ID: <8734mh8aek.fsf@baylibre.com>
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

Hi Guillaume,

Thank you for the patch.

On lun., sept. 02, 2024 at 18:31, Guillaume La Roque <glaroque@baylibre.com> wrote:

> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> Beagle Play has a different boot flow than the AM62x SK EVM.
>
> AM62x SK EVM:
> 1. Boot rom reads UDA (User Data Area), looking for tiboot3
> 2. Boot rom finds tiboot3 and loads it
>
> Beagle Play:
> 1. Boot rom looks for tiboot3 in mmc0boot0
> 2. Boot rom finds tiboot3 and loads it
>
> Because of this difference, we need to have a different
> partitioning table than the generic TI one.
>
> Include generic TI android support and override the partitioning table
> to boot Android.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  board/beagle/beagleplay/beagleplay.env | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> index 354bc987d12b..fc29d49712db 100644
> --- a/board/beagle/beagleplay/beagleplay.env
> +++ b/board/beagle/beagleplay/beagleplay.env
> @@ -17,3 +17,33 @@ bootdir=/boot
>  boot_targets=mmc1 mmc0
>  bootmeths=script extlinux efi pxe
>  rd_spec=-
> +
> +#if CONFIG_BOOTMETH_ANDROID
> +#include <env/ti/android.env>
> +/* Override Android partitions
> + * Required because tiboot3 is in mmc0boot0, not in UDA
> + * note that += is needed because \n is converted by space in .env files */
> +partitions=
> +       name=bootloader,start=5M,size=8M,uuid=${uuid_gpt_bootloader};
> +partitions+=name=misc,start=13824K,size=512K,uuid=${uuid_gpt_misc};
> +partitions+=name=frp,size=512K,uuid=${uuid_gpt_frp};
> +partitions+=name=boot_a,size=40M,uuid=${uuid_gpt_boot_a};
> +partitions+=name=boot_b,size=40M,uuid=${uuid_gpt_boot_b};
> +partitions+=name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};
> +partitions+=name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};
> +partitions+=name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};
> +partitions+=name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};
> +partitions+=name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};
> +partitions+=name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};
> +partitions+=name=vbmeta_a,size=64K,uuid=${uuid_gpt_vbmeta_a};
> +partitions+=name=vbmeta_b,size=64K,uuid=${uuid_gpt_vbmeta_b};
> +partitions+=name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};
> +partitions+=name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};
> +partitions+=name=super,size=4608M,uuid=${uuid_gpt_super};
> +partitions+=name=metadata,size=64M,uuid=${uuid_gpt_metadata};
> +partitions+=name=persist,size=32M,uuid=${uuid_gpt_persist};
> +partitions+=name=userdata,size=-,uuid=${uuid_gpt_userdata}
> +fastboot_raw_partition_tiboot3="0x0 0x800 mmcpart 1"
> +
> +adtb_idx=2
> +#endif
>
> -- 
> 2.34.1
