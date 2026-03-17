Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC0EFF6E89
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95D3840C1;
	Tue, 17 Mar 2026 23:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qXEw62ht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2F78410A; Tue, 17 Mar 2026 23:03:40 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8AA1840BE
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67ba6e63922so3681621eaf.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773785016; x=1774389816;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUJYAsy2UyBFgUUx5TeTVXc7erVdYB6xVNhFzLACPNs=;
 b=qXEw62htiNNTtASkn3Md9jm5oGzqDkJyV68Pfo5diVGYSH9aPJmvm+ey2CABUk3u4s
 71dYwIdpcmjx6dh6b6oV63fk7d1ADzMT+bmsEne04UXAdM3rAp4eijDw8LVi7JYAYnCa
 CtucNmEyRJ8C66w/HKxR5uVqupBo3cbEAvCm4O0DG6pSUVUzna2Kj6aheAZh8ZsTuRV9
 R9Vp4tqkoX5uP6R6AiatEr5w8WI2e3U236ZccRql7qYf6VYWk+xlmfJWbVi0uAU3cdPW
 ncdn0YwfE1QmS2Bq1eSgzYJyH45ED+sprGKzFMuG3FxWVaWWf8Rw8kCcG00TSMkD3LRc
 tx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773785016; x=1774389816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MUJYAsy2UyBFgUUx5TeTVXc7erVdYB6xVNhFzLACPNs=;
 b=mruFTDLGA5sdlR7Th3SvLCQzDlnuhNndrZDVIQqxdNjbDYajGk3IJUcMLbZqbzRqZX
 aAs4Nqc/o+rDPpJndff5thujG7d9OosvjIvmj6JX5WVjgyssikqqqTpLvW6Ny8qrHiPd
 GQD0flR5RxjibbDzcmxAL4pMOuyMbKBDL871Iew3oKJJoQ5wsdDZV3HMJyv7EYfDC6NU
 suoJc7+b+pdhPaan2dfyoLchCW9TpwJOOBQLZsnsXppRFHTwCBpxeAxAa7kA5APN4kPw
 me3qS7tKBpC91jK4M0FcF1ZT5nx+Cv8qTPj3qd/Ugh3sTqLC9fZH07o4Y6vA2DEG0r1N
 IZfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtM82cCb1errr+K4VINCuGBgHYYdd/Udz65M0cbZnWWJPOBM9XmdbQLSOLz58qFxVbCqY8wrM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5JvTJuO+yEY6WltzXIGwHJffEG2EY/ixYw48/x1aRFxQD4RQ+
 8gDXGF2fiJt1GhPyS6lRJZzxKieqxiFXSjkuYLjLbM2gbxds7pjQ9PJ21Fm+/78cyAk=
X-Gm-Gg: ATEYQzxFf5/7Oq8CqTvFU1/GE1pSg4ZdiF8iPoGX17pqdtf2o9vCo6Ke6hEr4qVP8YD
 Gu2JWCN5RWMweFOh+j/gbwKwvMDUAsFWc2w+kHO4xJwl3DjOZ2VigqzhXAY5Ew3btFU1VdJDI8V
 3asfK3daC77hwS7yzf404vJlnP3/IEpwc7WVIXM/MRqOYblXhPfOvbUXqbua8JMZnQzLQhH0VOC
 jHdnIQQBezhWUll7kyaPODzW/1v+ppg5tO0qZTclVYxsmybfz8eIbULS1sYiw/aLbxq3WqFkVU5
 hINkYGurYf3RxLIg/Uq73Zt422Zi/C/uVaEpOL31Qw1EWxRK8BBY6wA2iiJetWn6Kh/GUPfZIni
 huMbosE913vITAHAOf+bDIxclOLoFWlLGtt5NkUR1zHHPhqT9/ojEbAJB8LU8XyYTYGOMGjEiYo
 NQHP4GotfPGU2NtwXM56pagJGV7S364ijGUB6NIHQrfSNjPQGc6cAxYTEpjytU0j6/qHMN
X-Received: by 2002:a05:6820:1628:b0:67b:df0f:64eb with SMTP id
 006d021491bc7-67c0daff25amr669481eaf.45.1773785016380; 
 Tue, 17 Mar 2026 15:03:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:2fe3:965c:6248:c9?
 ([2600:8803:e7e4:500:2fe3:965c:6248:c9])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c0d7e5ca8sm540148eaf.1.2026.03.17.15.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 15:03:34 -0700 (PDT)
Message-ID: <2a4f651d-bdb4-4c3b-be58-e2b882556e7f@baylibre.com>
Date: Tue, 17 Mar 2026 17:03:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] configs: add new defconfig for mt8395_evk_ufs
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-11-7d731ec438ae@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-11-7d731ec438ae@baylibre.com>
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

On 3/17/26 9:24 AM, Julien Stephan wrote:
> This new defconfig is based on mt8395_evk, where we remove the mmc

We will still want MMC enabled here for the SD card slot. The
target OS could be on an SD card even when booting from UFS.

> configs and add all the ufs related ones.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  board/mediatek/MAINTAINERS       |  3 ++-
>  configs/mt8395_evk_ufs_defconfig | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 4f371592059..dba620e57d5 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -21,7 +21,8 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  S:	Maintained
>  F:	configs/mt8390_evk_defconfig
>  
> -MT8395 EVK
> +MT8395 EVK (UFS)

I think saying "(UFS)" here is a bit confusing. It is still the same
board (just different dip switch setting). I would not change this line.

>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  S:	Maintained
>  F:	configs/mt8395_evk_defconfig
> +F:	configs/mt8395_evk_ufs_defconfig
> diff --git a/configs/mt8395_evk_ufs_defconfig b/configs/mt8395_evk_ufs_defconfig
> new file mode 100644
> index 00000000000..9a9de689953
> --- /dev/null
> +++ b/configs/mt8395_evk_ufs_defconfig
> @@ -0,0 +1,33 @@
> +CONFIG_ARM=y
> +CONFIG_COUNTER_FREQUENCY=13000000
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_ARCH_MEDIATEK=y
> +CONFIG_TEXT_BASE=0x4c000000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk-ufs"
> +CONFIG_TARGET_MT8195=y
> +CONFIG_SYS_LOAD_ADDR=0x60000000
> +CONFIG_IDENT_STRING=" mt8395-evk"
> +# CONFIG_BOARD_INIT is not set
> +CONFIG_CMD_CLK=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_PART=y
> +CONFIG_CMD_UFS=y
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_CLK=y
> +CONFIG_PHY=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_MT8195=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_MTK_PWRAP=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_MT6359=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=921600
> +CONFIG_DM_SERIAL=y
> +CONFIG_MTK_SERIAL=y
> +CONFIG_UFS=y
> +CONFIG_UFS_MEDIATEK=y
> +CONFIG_WDT=y
> +CONFIG_WDT_MTK=y
> 

Can we make a .config file and #include it here so that we aren't
duplicating so much of mt8395_evk_defconfig?

