Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EECC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 12:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FD387985;
	Thu, 11 Jan 2024 13:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iZUkexKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7873D86C39; Thu, 11 Jan 2024 13:25:13 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CF287985
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 13:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B668EB81F65;
 Thu, 11 Jan 2024 12:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3B7C433F1;
 Thu, 11 Jan 2024 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704975910;
 bh=lfLyTnkYLAPAXAL+iZ/zdV4hypHqiwSwds3XbtMc+zc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=iZUkexKLARin+CGTW3ucv0fx/qxX64xSadeknPdpnzOtGMHfVfZ9ptbknr945K+tJ
 ywzMLmiozuFH9DgKcjzGJFzuIrIju59KTWaC3W3gB9CLU+0Q/ROZo02Wob+2BfZjjO
 12SyA0nipbLgshD+zyHvDeaZ7SDVLbRgGq5qmzE6mgz4sE7TmmEAJz/BhjbJpWB7zn
 t6jTyZffxBC/NBdj98rqsM8o7OoYOq8dnLUD96t9ra0vUsqkHsuDYpbbtMXUqnPGrm
 gdN7pedwWBvW/6VF+yCpRdmixUxNhVsUUeti1TMpH4l9UAqVZtkGK6olWol2pOsg4z
 2qb98cPWWMiBA==
Message-ID: <0105d7fb-3f81-4435-832b-c97fdbdf0995@kernel.org>
Date: Thu, 11 Jan 2024 14:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/17] configs: Add am69_sk_* defconfig fragments
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-16-a-nandan@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231219191537.4039361-16-a-nandan@ti.com>
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



On 19/12/2023 21:15, Apurva Nandan wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> Add config fragments for am69_sk A72 and R5 configuration.
> 
> This applies on to:
> j784s4_evm_a72_defconfig -> am69_sk_a72.config
> j784s4_evm_r5_defconfig -> am69_sk_r5.config
> 
> The usage model (with the fragment) would be:
> make j784s4_evm_a72_defconfig am69_sk_a72.config
> make
> 
> OR
> 
> make j784s4_evm_r5_defconfig am69_sk_r5.config
> make
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  configs/am69_sk_a72.config | 3 +++
>  configs/am69_sk_r5.config  | 3 +++

Shouldn't the config fragments lie in the board/<board>/configs directory?
Else we will just keep polluting the configs directory.

e.g.

u-boot$ find . -name "*.config"
./tools/env/fw_env.config
./board/asus/transformer-t30/configs/tf300tl.config
./board/asus/transformer-t30/configs/tf300tg.config
./board/asus/transformer-t30/configs/tf201.config
./board/asus/transformer-t30/configs/tf300t.config
./board/asus/transformer-t30/configs/p1801-t.config
./board/asus/transformer-t30/configs/tf600t.config
./board/asus/transformer-t30/configs/tf700t.config
./board/asus/grouper/configs/grouper_PM269.config
./board/asus/grouper/configs/grouper_E1565.config
./board/asus/grouper/configs/tilapia.config
./board/lg/x3-t30/configs/p880.config
./board/lg/x3-t30/configs/p895.config


>  2 files changed, 6 insertions(+)
>  create mode 100644 configs/am69_sk_a72.config
>  create mode 100644 configs/am69_sk_r5.config
> 
> diff --git a/configs/am69_sk_a72.config b/configs/am69_sk_a72.config
> new file mode 100644
> index 0000000000..5668e23b37
> --- /dev/null
> +++ b/configs/am69_sk_a72.config
> @@ -0,0 +1,3 @@
> +# Defconfig fragment to apply on top of j784s4_evm_a72_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am69-sk"
> diff --git a/configs/am69_sk_r5.config b/configs/am69_sk_r5.config
> new file mode 100644
> index 0000000000..9194694393
> --- /dev/null
> +++ b/configs/am69_sk_r5.config
> @@ -0,0 +1,3 @@
> +# Defconfig fragment to apply on top of j784s4_evm_r5_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"

-- 
cheers,
-roger
