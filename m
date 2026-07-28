Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC025C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 16:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1DC78143A;
	Tue, 28 Jul 2026 16:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I-zh_eq8ONaC; Tue, 28 Jul 2026 16:01:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44A79813CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785254465;
	bh=QdNBkWwAqPKZf/kTqyy93AiXg9Q3qzwT5k+IM+DF2XU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rrbk9pD6Tn1JjKpnQxtBpRDEotvewubGex3nq+SdXpuEpQ7kAirZlZqUPx9qf89TK
	 gRKNVoZJqaB+Il2lSRxArfbEHQlvBKLPe8d+ldjbbZSXpmUucH3+sW50VX6F/HdHHR
	 0GtVKZqAEvi3xTk3Vir/M8vI829SSUNVg6Zfb9wuP8D0VRgFSbRVlVpG4e6Vli44r6
	 vOIhdxthj5IQ+MnZR5p+eqrCSAC70HtxDE3F5JqHWHTFdJyEm6NLRhsD5N3Xkxdc0o
	 qBTORUx+Nksobc92Aj72oM0ti/xNEiTKSfIguyV6PgNamjH7j2fgw2ZXHl9uCIPj0x
	 ba8Xxe03UrpmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44A79813CF;
	Tue, 28 Jul 2026 16:01:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E78E4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78DD540506
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZoZZ2VLjOWK for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:01:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 93FAE4040F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93FAE4040F
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93FAE4040F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:01:03 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so67866b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254461; cv=none;
 d=google.com; s=arc-20260327;
 b=Zov+53cMub2gxEUz36YZdCyvO10aTMVN2mIuogyCEMl0Ce3VXhclAND5F4NDLCpOr3
 O2xA51l7Ztq+sWOcUOjqs7Xrdx/CE13zaJhlgGyHM1Bpx2D7NCM4bwGwH0NfOE962Cx4
 YGyWQfh5DBj7neqYG0z8pb8QBJqnXyZuESkqAvI0ottwyZWoWcJEAYZ+HAnDrwMiLoKM
 +PZxCYd/ylSs7+zDLwpImld7JJA/RrNW6uQA1D0BeLvddP0q296jo6ydpcCYflYW8HG5
 BX+ZOuipPMrWHHgKyz+/MIdRTzD9VgUscKOxENKHVDOy59AXLWxqPzl7hIu80rC0wrA+
 SyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QdNBkWwAqPKZf/kTqyy93AiXg9Q3qzwT5k+IM+DF2XU=;
 fh=KluuETnnFUKbE6d/vcC8wHb/xux8cL1p50vcM+baTZo=;
 b=Sh5IrGFK7qDqAdrSg9YvOwYNnUgYavqFlEe4nwiT/wFbqQ/r4s0QW8KSxE/pLAIbLj
 P7u30LXG1ZJ2J2DbuWQOmACVdLHiZ6WIK3FfGYaC5azgg4ibT4dxV5DN42OEG1QdOciO
 5gVpIffn8iLRto8pBjBdXbCcLfonA3xInd3CV0xx8WanJf9YmdDNJVMr77E7DcrsOeUR
 177WxwGeOgscS8tcZwHIklXDAHSs5X7nrJbNvc7m660/KLjcbN9tQCnp1Kr/Ke9blKmV
 NVsDrOceXUSnb1jG7sCMS8+Gasc+qSUZVslHjOxMWDyW5hBuknV5hT3NuQfpkJsLYeiB
 B8qg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785254461; x=1785859261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QdNBkWwAqPKZf/kTqyy93AiXg9Q3qzwT5k+IM+DF2XU=;
 b=K2N+xpV+EX2/jF2Jd+J9FQYgmZlUkZFgkA44K4JdOFX2hWOI6UqPaOGFMO5TcPNTrm
 E8RVg8wyJcqBZ8qNIBpiPYmtGvZwB+iG3co7yxe/RlpNE8kBrRycvrXF0I9QvPok4XTV
 qqA+mklmLGEeglt/DNyybm7/M4hAddAzBJBYczMEap+FOKNnGQDtyPrG/hNtP/rTyWTl
 KiAlPavQkHWUdKXuFK5toZacyQpqx9ww/FRho/VORpG5gShjzuzQeTchi7qk37bt9g/P
 rc1ThJEU8HKuIm8BIOgYVRVaiLJBtNie4C2z5YYVHOPuuB7eqxKdncwYqJXnRPhuEsh9
 7RkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdybnH40y7xfqXU5weuvDhq4DQ/ewzFlavrnIdPArdMQxHRdEXJFr+rrXBBssAgfpqqFO/+r0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw61zm3T6Vknvez87VRzf+1aAgIMyZrxpQXtTtrkEI4t1H13jmf
 Wjlc0fGXJiIk4A4KoFoutsJfxiu2GbfefK3qgEJUkKw730mylUDi0QrlWz4DEjrNEwXatuiXGc5
 LK1l5jvB8cYPR8cc9LrPys3LpUpCnDp+UxZWQ8+GVow==
X-Gm-Gg: AR+sD137vtYa7hJyhT/vsCudx37oruUerJKOwXwYKRfkfUocBOCrpO8NZm/4bQyyIuH
 Rk+02yiheL0KnMn0TArUA1AA58jct4Mw2J/hN3EkiAenBxaKBJszIkL7BP0KPs/R6bNrmrUjClH
 MomXpjMEbi/LzUOm4OirsAZfojX9qzCWozQ6NO5xDpwC90qVDNZALZE84iC58nsHr6LTl/VIWkF
 KvdxsfAHKPyPMGVDF0dn19oGZymI/T2u6R9Bg9t+kF0GvAv53yebN6XlF9mbAmxzTAiUlla1Yhi
 bc21zK0ZdrLvJtqF286iF08A3fJtoBGleELQMLZBdCvkr7P0xJZqgqw/FA+l4NGcCyZAFVFcTe7
 D7+usPSovVMfK3UkA
X-Received: by 2002:a17:907:e1d1:20b0:c1c:2aa5:322b with SMTP id
 a640c23a62f3a-c1f71d2d186mr117181866b.2.1785254461324; Tue, 28 Jul 2026
 09:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
 <20260722-ccaione-upstream-mt8390-spl-v2-2-7aa005345711@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mt8390-spl-v2-2-7aa005345711@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 18:00:54 +0200
X-Gm-Features: AUfX_mx0qMdpAC_cuDEXqwbYSKUD8WUoZVqpKJBHPgiLxIjTtTmhypQzuEpLVJk
Message-ID: <CAEHHSvaAAJB_c6CVQTzF2_Ete6u038p2M3_y83V-Y6_Pt5stjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] configs: mt8390: enable eMMC FIT boot from SPL
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785254461; x=1785859261;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QdNBkWwAqPKZf/kTqyy93AiXg9Q3qzwT5k+IM+DF2XU=;
 b=jW++M2opmqORLnMbaAxeHjfSELtli7/U30zkuPvEoIrqRYxUHYoQ8CTfgW/kyiYqD6
 Xuxs3M1KZNWfO7Po/NUxP7u/bUOOqLjNaJlkB1JOD4l359SBpYUYflSsZB3yWaGnmRJg
 QIdH/f2UwyLWYf0lUYPKLBaGKqCOB3gqpYWw0PsF6qNIsX2JDVsfONcOsjkTXo2RbMAG
 a1zGqb98guG0KssEn0Kn/LjWEBhJk4jEe/Awo8TWrG2MjlV/Wt4rYTgSxdKRmxhhOGMZ
 /THg2xvtaYe8jpq2hpVfBYgXgYeQlYGTkQocTEPtq8yzyD4eZ8vFc6ntIrElTVpWPbhu
 dLqA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jW++M2op
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mer. 22 juil. 2026 =C3=A0 23:36, Carlo Caione <ccaione@baylibre.com> a =
=C3=A9crit :
>
> Enable the normal Genio 700 SPL path entered by the external DDR
> loader at 0x40000000. Bind the raw SPL to the loader's 0xaf000-byte
> copy window, place BSS separately in DRAM, and retain the
> non-overlapping SPL malloc region.
>
> Use generic SPL MMC, GPT, FIT, and Arm Trusted Firmware support to load
> the firmware FIT from eMMC partition 1. Keep U-Boot proper at the shared
> MT8188 CONFIG_TEXT_BASE of 0x4c000000.
>
> The MediaTek BL31 used on Genio 700 stalls when passed the runtime
> devicetree as its platform parameter. Enable SPL_ATF_NO_PLATFORM_PARAM
> so SPL can still use the tree to locate OP-TEE and U-Boot while passing
> NULL as the separate BL31 platform parameter.
>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  configs/mt8390_genio_700_evk_defconfig | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_geni=
o_700_evk_defconfig
> index fe4f6ad9016..5730b056e29 100644
> --- a/configs/mt8390_genio_700_evk_defconfig
> +++ b/configs/mt8390_genio_700_evk_defconfig
> @@ -1,3 +1,30 @@
>  #include <configs/mt8188.config>
>
>  CONFIG_DEFAULT_DEVICE_TREE=3D"mediatek/mt8390-genio-700-evk"
> +CONFIG_SPL=3Dy
> +CONFIG_SPL_TEXT_BASE=3D0x40000000
> +CONFIG_SPL_MAX_SIZE=3D0xaf000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> +CONFIG_SPL_BSS_START_ADDR=3D0x400bb800
> +CONFIG_SPL_BSS_LIMIT=3Dy
> +CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> +CONFIG_SPL_SYS_MALLOC=3Dy
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x5c000000
> +CONFIG_SPL_SYS_MALLOC_SIZE=3D0x9000000
> +CONFIG_SPL_SYSCON=3Dy
> +CONFIG_SPL_CLK=3Dy
> +CONFIG_SPL_SERIAL=3Dy
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_SPL_PINCTRL=3Dy
> +CONFIG_SPL_PINCONF=3Dy
> +CONFIG_SPL_WATCHDOG=3Dy
> +CONFIG_SPL_MMC=3Dy
> +CONFIG_SPL_LIBDISK_SUPPORT=3Dy
> +CONFIG_SPL_EFI_PARTITION=3Dy
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D1
> +CONFIG_SPL_LOAD_FIT=3Dy
> +CONFIG_SPL_ATF=3Dy
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
>

Hi Carlo,

Did you test on Genio 510? AFAIK Genio 510 and Genio 700 are very similar.
If it works on Genio 510, then all theses configs could be placed into
 configs/mt8188.config.

Cheers
Julien

> --
> 2.55.0
>
