Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89216CE9D47
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 15:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0BD683AC5;
	Tue,  6 Jan 2026 16:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JkoY1y/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF5F83B7E; Tue,  6 Jan 2026 16:10:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7134F839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 16:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767712224; x=1768317024; i=xypron.glpk@gmx.de;
 bh=8RfQwnKekAw2b93VF8HkiSBnuknPhM4FLW6qLTOx9Rs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JkoY1y/oU28ml8HFBR+ETV2slkltto/pEITQcCgb9kwrxzHkC/mjwSBIoWz2fhg6
 yYQjaha6Wf1RFhp1kITsPoK49r4QwgrmNWKie1g4n9CDKRud2GrUZJ6m/zpxvs70e
 OmogFSs+k/MwYV1/2Wl1psnDhjXPJi2cedJwDB/YIcbmaUJa486sZtdTTmGqiP65O
 Lgli1gPAS9ETU5qiSNnr0lAKI5Fm6pSSUPTV6b934ixZZWOcR1GXWZ17RUJLX16Hh
 rFhLWdpa82gnSi8tiGYWsY3NcbzDWK2XznhFfHwfCpXnKnjrB/JJBUN/5l7CFun5a
 9tvJF/milLkUfkqYxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.126] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1vSjcI3BM2-00Vlli; Tue, 06
 Jan 2026 16:10:24 +0100
Message-ID: <7ead22f3-7278-47bf-9af3-15548ff93f9d@gmx.de>
Date: Tue, 6 Jan 2026 16:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Drop default y from CONFIG_EFI_GRUB_ARM32_WORKAROUND?
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, ilias.apalodimas@linaro.org
References: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
 <71CC4A73-1141-4B07-A766-98808F082734@gmx.de>
 <15bb48c8-a19a-4c0d-8cce-e886b891b5d9@siemens.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <15bb48c8-a19a-4c0d-8cce-e886b891b5d9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTxATiXyP8ErF94tVxm4VMkZqR22S6VLIMWVYCo/gmy06IMtVWi
 H4QQSqnCkxZpOwaxdoDIQiRRjoEurWsCs7+RSM71R5YBjYAs5NZjcu8S9AT/R5QKpzkWrFY
 3hrwEGBDF/+ehbaSdYq/Zk9xaUGKoqM8wq7m7QofnxwvShzl3i1s5DTulbp8abRhrxk91Xa
 ZCYGkdpPjRBXaLYKn7K6Q==
UI-OutboundReport: notjunk:1;M01:P0:KdhtkDWuAaw=;hFXfebwdPoLmrp9591aq3ItCt96
 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
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

On 1/6/26 15:38, Jan Kiszka wrote:
> On 06.01.26 15:30, Heinrich Schuchardt wrote:
>> Am 6. Januar 2026 14:47:30 MEZ schrieb Jan Kiszka <jan.kiszka@siemens.c=
om>:
>>> Hi,
>>>
>>> it seems that some kernel configs can cause problems with the
>>> CONFIG_EFI_GRUB_ARM32_WORKAROUND. Namely, 6.1-cip and 5.10-cip with it=
s
>>> current defconfigs [1] no longer boot on the BeagleBone Black (other
>>> boards still need validation), both with the more recommendable
>>> systemd-boot and grub. I do not have the motivation to debug the reaso=
n
>>> in the kernel / its config, given that everything works fine once the
>>> firmware behaves according to the UEFI spec.
>>>
>>> Meanwhile, grub reached 2.12 now which is far away from the old, broke=
n
>>> version of 2019. So, should we rather make this workaround opt-in in 2=
026?
>>>
>>> Jan
>>
>> Hello Jan,
>>
>> Looks ok to me. Will you send a patch?
>>
>=20
> Can do. Just one follow-up question:
>=20
> "This workaround currently is also needed on systems with caches that
> cannot be managed via CP15."
>=20
> Do we know them by name? Should we keep the default for those?
>=20
> Jan
>=20


arch/arm/cpu/armv7m/cache.c has its own d/icache_disable() routines but=20
it does not support EFI.

I also found these cache management routines
(git grep -n disable | grep cache | grep void):

arch/arm/mach-exynos/include/mach/sys_proto.h:12:void=20
l2_cache_disable(void);
arch/arm/mach-imx/cache.c:144:void v7_outer_cache_disable(void)
arch/arm/mach-ipq40xx/cpu.c:32:void disable_caches(void)
arch/arm/mach-kirkwood/cache.c:11:void l2_cache_disable()
arch/arm/mach-mvebu/cpu.c:683:void v7_outer_cache_disable(void)
arch/arm/mach-npcm/npcm7xx/cpu.c:62:void disable_caches(void)
arch/arm/mach-npcm/npcm7xx/l2_cache_pl310.c:26:void=20
v7_outer_cache_disable(void)
arch/arm/mach-omap2/omap3/board.c:447:void omap3_outer_cache_disable(void)
arch/arm/mach-s5pc1xx/cache.c:19:void disable_caches(void)
arch/arm/mach-s5pc1xx/cache.c:37:void v7_outer_cache_disable(void)
arch/arm/mach-socfpga/misc.c:92:void v7_outer_cache_disable(void)
arch/arm/mach-u8500/cache.c:23:void v7_outer_cache_disable(void)
arch/arm/mach-uniphier/arm32/cache-uniphier.c:211:static void=20
uniphier_cache_endisable(int enable)
arch/arm/mach-uniphier/arm32/cache-uniphier.c:228:void=20
uniphier_cache_disable(void)
arch/arm/mach-uniphier/arm32/cache-uniphier.c:283:void=20
v7_outer_cache_disable(void)
arch/arm/mach-uniphier/arm32/cache-uniphier.h:18:void=20
uniphier_cache_disable(void);

SYS_L2CACHE_OFF is another symbol worth grepping for for:

arch/arm/mach-exynos/common_setup.h:64:#if=20
!defined(CONFIG_SYS_L2CACHE_OFF) && defined(CONFIG_EXYNOS5420)
arch/arm/mach-exynos/lowlevel_init.c:90:#ifndef CONFIG_SYS_L2CACHE_OFF
arch/arm/mach-exynos/lowlevel_init.c:183:#if=20
!defined(CONFIG_SYS_L2CACHE_OFF) && defined(CONFIG_EXYNOS5420)
arch/arm/mach-imx/cache.c:80:#ifndef CONFIG_SYS_L2CACHE_OFF
arch/arm/mach-imx/cache.c:151:#endif /* !CONFIG_SYS_L2CACHE_OFF */
arch/arm/mach-npcm/npcm7xx/l2_cache_pl310_init.S:10:#ifndef=20
CONFIG_SYS_L2CACHE_OFF
arch/arm/mach-omap2/omap3/board.c:33:#ifndef CONFIG_SYS_L2CACHE_OFF
arch/arm/mach-omap2/omap3/board.c:196:#ifndef CONFIG_SYS_L2CACHE_OFF
arch/arm/mach-omap2/omap3/board.c:408:#ifndef CONFIG_SYS_L2CACHE_OFF
arch/arm/mach-omap2/omap3/board.c:457:#endif /* !CONFIG_SYS_L2CACHE_OFF */
arch/arm/mach-s5pc1xx/cache.c:25:#ifndef CONFIG_SYS_L2CACHE_OFF

Best regards

Heinrich
