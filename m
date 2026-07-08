Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BB1C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0268496E;
	Wed,  8 Jul 2026 18:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="JtqtUH61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA888497A; Wed,  8 Jul 2026 18:30:38 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D15A843B6;
 Wed,  8 Jul 2026 18:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1783528226; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=myn8RKTvqHJLG2OPfF8WZ1AfakyCVRpt0aJl1sLjqIR1PlhjbIPoL+Mtoxn5tsIfyUavc0TFd659YFrZMMYAViyL53jnxjiV2tlWI0ipHexCsApqptyVDashHYQQ7FOkYWMZjkUoKaMgXdV99+P7+asyjtzNgPFnzE4w9NhYlgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783528226;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qnRE+t9LfIxJMrx+etHv0hwuwS8Quu0bl5byZx7o18Y=; 
 b=mXtg+7MiRuoL9G9IGx4I87rxOJCI0tSTCAj7BiNr9skqwoGiI7dxhm1Ag03ZnGGzH/7wbjj7pXM+Zgjmc0Lo9YGhDoqBkMmk/PcVk1ZkV6CKxosCBVVvf3pt0YMiAtFNC4dc+qvMTic/ri1/pinpdMQz8lFRq7I/xHYI07qZG54=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783528226; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:References:In-Reply-To:Reply-To;
 bh=qnRE+t9LfIxJMrx+etHv0hwuwS8Quu0bl5byZx7o18Y=;
 b=JtqtUH615OHAHfoVJNl46YZCYKDHKcGew4hn9xy6lWEVKNVu5KcO8q3PjaMSTgwv
 nz7fe01QJatV/r1reLZjv2TSSzusTYNNgqeUemJGr6q9f7R3WrmxCjregrjID7SqGzL
 4t8iHFgGSbbxPyZd0X43OSoSx0yMBFPzYNLdRgJI=
Received: by mx.zohomail.com with SMTPS id 1783528222436250.33926475826763;
 Wed, 8 Jul 2026 09:30:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 00:30:14 +0800
Message-Id: <DJTBZIJR5BOF.35DYSOL36RB6H@pigmoral.tech>
Cc: "Lukasz Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>,
 "Rick Chen" <rick@andestech.com>, "Leo" <ycliang@andestech.com>, "Kongyang
 Liu" <seashell11234455@gmail.com>, "Martin Herren" <sputnik@on-the-web.ch>,
 "Michal Simek" <michal.simek@amd.com>, "Randolph Sheng-Kai Lin"
 <randolph@andestech.com>, "Yao Zi" <me@ziyao.cc>, "Andreas Schwab"
 <schwab@suse.de>, "U-Boot" <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH 2/3] riscv: milkv_duo: Use upstream devicetree
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Zhuxu Ran" <zhuxu_ran@zohomail.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
 <20260706-milkv-duo-upstream-dts-v1-2-8d010ddda7ca@zohomail.com>
In-Reply-To: <20260706-milkv-duo-upstream-dts-v1-2-8d010ddda7ca@zohomail.com>
X-ZohoMailClient: External
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

Hi Zhuxu,

On Mon Jul 6, 2026 at 9:43 AM CST, Zhuxu Ran wrote:
> Switch Milk-V Duo to the upstream CV1800B devicetree by enabling
> CONFIG_OF_UPSTREAM and selecting sophgo/cv1800b-milkv-duo.
>
> The upstream devicetree keeps the Ethernet MAC disabled. Add a
> small U-Boot override to keep the existing U-Boot networking
> support enabled.
>
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 12 ++++++++++++
>  configs/milkv_duo_defconfig                  |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dt=
s/cv1800b-milkv-duo-u-boot.dtsi
> new file mode 100644
> index 00000000000..158b02a543a
> --- /dev/null
> +++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * U-Boot overrides for Milk-V Duo.
> + *
> + * The upstream Linux device tree describes the CV1800B Ethernet MAC, bu=
t
> + * keeps it disabled. Enable it here to preserve the existing U-Boot
> + * networking support when using the upstream device tree.
> + */

What about moving this comment to be right above the &gmac0 node,
instead of having it as a top-level file description? This file may be
extended with other U-Boot overrides in the future.

> +
> +&gmac0 {
> +	status =3D "okay";
> +};
> diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
> index f1f3930564b..9d6b80362d5 100644
> --- a/configs/milkv_duo_defconfig
> +++ b/configs/milkv_duo_defconfig
> @@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x8000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x82300000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"cv1800b-milkv-duo"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"sophgo/cv1800b-milkv-duo"
> +CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x80080000
>  CONFIG_IDENT_STRING=3D"milkv_duo"
>  CONFIG_TARGET_MILKV_DUO=3Dy

--=20
Best regards,
Junhui Liu

