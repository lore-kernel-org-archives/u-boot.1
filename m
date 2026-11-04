Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF3606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yh8PXIGI;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=QDzchfLp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11D6960697;
	Wed,  4 Nov 2026 09:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUS5RzB2jTmE; Wed,  4 Nov 2026 09:31:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AB7D606E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784683;
	b=NrnPzQKPu7MRnJ1+Qsm5jpCbCdmPlQfyrwo4a/jLkoI7GGC/+NWHY3oXxpqYxO1DE5c/
	 5gNzaFEIaAdhu4QpHgljWEpsREoCeikP/Rv4tmOY/MqGbYzDz7vuS6Hy6H4OqtrT0lpHJ
	 Fk2InjA0x5DB9at1UImoHwJh2AgtcLg1bOa8f+IFa2ny9RkJUid3e3KsaJZCjJumIgytE
	 Z0yQwbbOPQuEtgaVfMwa8Mr13k8zu3Z/4+dbcpuJu6DBUV/7yDSM8kywOTpNLqcN3wi/m
	 lf70sJAU9EWdM3OyqUgNFXOseCljdmH+bG8o2+X83kLCocmYonGh/L1/xbW2xuoE1sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q9frMj9SLFoAwOCaJrPX3NaC4KUJiH6UpKq/rEw7ONQ=;
	b=dX0OOP3D6pDyDo2hRcdccedbxH7v6vLN9zfJ9ourv0EX9z6DfR6a0GAW1LaocjzNYaAj
	 U5jpVoi+esFoh/C+iG/TpFqYbP/59NbGZcmsJUTpah0v2vll0c8CCSZmg5Qmgvl+VLVjI
	 bmzXMG/lFyVASzTWHpLXOCH3Wbds/JTdJ7FGoR/J9+4I8HMepdK3fFSWm1U6JbAXBVqUp
	 +KEJrr/1L9UGK+xJ0GPsxuTojxbgM9LCS0VoN1pfK/HuQmrli2MOIXFPSeT6OTbg466IU
	 L0Z4VxEOxqB8homsHytGOcOw/M6eKTSEtdGi4sijSI9FbiurT6JQz0Hbe5Ey11iAeZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784683;
	bh=q9frMj9SLFoAwOCaJrPX3NaC4KUJiH6UpKq/rEw7ONQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yh8PXIGIN3IBfNX/YH3FBGj0MLSGj5Ii4wcMqyumbxm0hWSRooedzv8sy2jC6iptN
	 nTRXNiVtd7VQt8VuM9IT2blcqWRDYoKFTUhfdLQF5P66CzqzLh5Zz0v+nbB2YoRuCE
	 ns/O5IW+2FUpqEfIUXJ8UwJOhhH5SMOWQ9vggSzQ73cPEB06Q2lPjpyNm/ZApsFQZb
	 WHBAn5YHS1n5CjS0FclUnKFo0gY4cnzGjlP4I8/fxmRlywFHHCOOwgNx7nC/VcJx4P
	 LL9sLT4P344aFNnTxTcvcHvgZJlV3mOGJFuRk1PbNGI8qOn8XSjW4ZR0GdcjiPbjso
	 3F9dRSHM51XRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AB7D606E8;
	Wed,  4 Nov 2026 09:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7096A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B417380F3E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqIvSWMRAD4t for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB26580E49
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793784680;
 b=C94dz00ZpbgUnxK0pl8cYaue4suYMdAkW7GQ+NQZbOoJGnNXyKvwTBnOnBThO51Vdj19
 5/Kl4lmo/SzpircQ/mF0kqz4WGq+Gtp3F8MmJT0pwbTL7ApFwS060OOiYDz6+DdZO+fHP
 HfUH7C0rwSQPevw/TObV2/7xs+u4dddonjHEg+JYW6TMgJXDd+MqD0pvtP0l1br38gpJV
 RLsJmr8N9WH8QI6wKQclYuL8LiC/kJxVWnNmHs5C/w75zir2biCsHBhDnJov6ACYXa0RP
 VZ30Yom8iUeTzzRArRi3ZPEs0e/vrxQsRxXz/DdWPQbG+j+czxeIMLnn2vvuXlZH8zA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784680;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Rspamd-Queue-Id;
 bh=q9frMj9SLFoAwOCaJrPX3NaC4KUJiH6UpKq/rEw7ONQ=;
 b=tE+nXdTMY+evhjLx2S+L+TBouYq88TL21fU5mZXnPKVG/4niVhRtTRdXc2qmxKomNUu0
 8Rjl80fXaVa/28Of+4ns2LrQtpPLwSuySxZaPxkufa5hs077uG6T7aAa/6E9/8ylUWIGm
 gh5ymJaHGyfG0qw+5e4pbbRPcF6whBfyg6/iF1cP9tzg9p+vWwtYqCqEjyTeh8sCW2XQ1
 8M5pn3/nDe2xQiwwNt9DqLu3Z8dhcmn+sa/H6rH/R4nkFZSKdO2kA1VrZv7Y4d/hnN6V0
 Nq2haC5vydqtwaFKcOyF0JDgEdxAjeIk6NXxs6vPb/52rOL0ARf2FIREdMTIpepk+lw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=QDzchfLp; 
 arc=none smtp.remote-ip=80.241.56.161
X-Greylist: delayed 1509 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 04 Nov 2026 09:31:19 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=QDzchfLp
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB26580E49
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:31:19 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKKv75t2rzKpCr;
 Wed, 04 Nov 2026 10:31:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793784675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9frMj9SLFoAwOCaJrPX3NaC4KUJiH6UpKq/rEw7ONQ=;
 b=QDzchfLp7cHErN+DtxTdjl+HDkp1Cxp6ifFUpMrZsUDJRosMKolR25gJ1ApaVdVU2LonCe
 D6qTXHGK02g3EXYhlJDAD+9cqVx33GrFuTXJT0GTRH4lkPt07645g9O2w9F5qK22n7HfOP
 4KMOGIHLEn2xzUR/2iLUtbRUbBBjk8h9B5FwW+Ea5CSBgzVuwOtvQNIiLBqUskJQiB7dUg
 OqN5W0hlqhpRCeJEzhr0msoi/wvXhZWTwBmzmd+1aotGjUsGxae8T3DkZu5/leNubzWo+N
 VyEd4ocyonO/BslDX6JPtacv2T4a8v2fUTNu1+wC4fWrRWM08Igk6kek0J45vA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <a37e3beae87c14ea190a8914d527eb242c6b0e62.camel@dirkwinkel.cc>
Subject: Re: [PATCH 2/2] arm: mediatek: mt8188: run board_init_f() with the
 caches on
From: Steffen Dirkwinkel <lists@steffen.cc>
To: David Lechner <dlechner@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ilias Apalodimas	
 <ilias.apalodimas@linaro.org>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao	 <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>,  Carlo Caione <ccaione@baylibre.com>, Chris Chen
 <chris-qj.chen@mediatek.com>
Date: Wed, 04 Nov 2026 10:31:14 +0100
In-Reply-To: <a5c37c1d-45a4-429c-bdd3-f68ab5030b9f@baylibre.com>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-2-b45905cb19c1@beckhoff.com>
 <a5c37c1d-45a4-429c-bdd3-f68ab5030b9f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jKKv75t2rzKpCr
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-02 at 10:42 -0600, David Lechner wrote:
> On 10/30/26 3:57 AM, Steffen Dirkwinkel wrote:
> > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> >=20
> > Device tree walks and other setup is very slow without caches, so turn
> > them on before relocation.
> >=20
> > On an MT8370 module, from bootstage marks before each initcall, two
> > boots each:
> >=20
> >   step                            caches off        caches on
> >   initf_dm                        349.8 / 349.7     4.6 / 4.6 ms
> >   serial_init                     204.7 / 204.7     3.0 / 3.0 ms
> >   dram_init                       162.2 / 162.1     2.3 / 2.3 ms
> >   relocate_code                   22.0 / 22.0       0.4 / 0.4 ms
> >   board_init_f() to main_loop()   819 / 819         87 / 87 ms
> >=20
> > and from the serial console, after power-on (includes 5s debug usb wait=
):
> >=20
> >   U-Boot banner                   7346 / 7346 ms    6772 / 6777 / 6765 =
ms
> >=20
> > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > ---
> >  arch/arm/mach-mediatek/cpu.c         | 14 ++++++++++++++
> >  arch/arm/mach-mediatek/mt8188/init.c | 23 ++++++++++++++++++++---
> >  2 files changed, 34 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.=
c
> > index 04ede8823b07..484a50f0a25c 100644
> > --- a/arch/arm/mach-mediatek/cpu.c
> > +++ b/arch/arm/mach-mediatek/cpu.c
> > @@ -7,10 +7,13 @@
> >  #include <dm.h>
> >  #include <init.h>
> >  #include <wdt.h>
> > +#include <asm/global_data.h>
> >  #include <dm/uclass-internal.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/types.h>
> > =20
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> >  #define MTK_SIP_PLAT_BINFO ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM=
_SMCCC_SMC_64, \
> >  =09=09=09=09=09      ARM_SMCCC_OWNER_SIP, 0x529)
> > =20
> > @@ -23,6 +26,17 @@ int arch_cpu_init(void)
> > =20
> >  void enable_caches(void)
> >  {
> > +#if IS_ENABLED(CONFIG_TARGET_MT8188) && !IS_ENABLED(CONFIG_XPL_BUILD) =
&& \
> > +=09!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
>=20
> instead of checking CONFIG_TARGET_MT8188, this would become the same conf=
ig
> option I suggested in the previous patch so that we don't have to keep ad=
ding
> additional targets.
>=20
> And U-boot preferred style is to use if statement instead of #if preproce=
ssor
> for things like this. The the compiler will still optimize it out the sam=
e.

I didn't do a generic implementation before, because I can only test on mt8=
188.
But it would be cleaner than doing the same thing for all SOCs and there is
still the DCACHE_OFF kconfigs to enable/disable it, so I'll make it generic=
 in
v2.

>=20
> > +=09/* Deactivate the data cache, enabled before relocation in mach_cpu=
_init() */
> > +=09dcache_disable();
> > +=09/*
> > +=09 * Force the call of setup_all_pgtables() in mmu_setup() by clearin=
g
> > +=09 * tlb_fillptr, to use the page tables reserved by arch_reserve_mmu=
()
> > +=09 */
> > +=09gd->arch.tlb_fillptr =3D 0;
> > +#endif
> > +
> >  =09/* Enable D-cache. I-cache is already enabled in start.S */
> >  =09dcache_enable();
> >  }
> > diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-media=
tek/mt8188/init.c
> > index 2e6aa041c38f..139412071131 100644
> > --- a/arch/arm/mach-mediatek/mt8188/init.c
> > +++ b/arch/arm/mach-mediatek/mt8188/init.c
>=20
> And similarly, we should try to avoid this target-specific boilerplate th=
at
> would have to be repeated for every target.
>=20
> > @@ -49,15 +49,32 @@ int print_cpuinfo(void)
> >  =09return 0;
> >  }
> > =20
> > -#if IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> > +#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> >  /* Early page tables, in DRAM unused by SPL and by U-Boot before reloc=
ation */
> >  #define MT8188_EARLY_TLB_ADDR=090x4e000000
> > =20
> > -/* Initialize the MMU and activate the data cache in SPL */
> > -void mtk_spl_enable_caches(void)
> > +/*
> > + * Initialize the MMU and activate the data cache in SPL and in the U-=
Boot
> > + * pre-reloc stage. The MMU/TLB is updated in enable_caches() after re=
location.
> > + */
> > +static void mt8188_enable_early_caches(void)
> >  {
> >  =09gd->arch.tlb_addr =3D MT8188_EARLY_TLB_ADDR;
> >  =09gd->arch.tlb_size =3D PGTABLE_SIZE;
> >  =09dcache_enable();
> >  }
> > +
> > +#if IS_ENABLED(CONFIG_XPL_BUILD)
> > +void mtk_spl_enable_caches(void)
> > +{
> > +=09mt8188_enable_early_caches();
> > +}
> > +#else
> > +int mach_cpu_init(void)
> > +{
> > +=09mt8188_enable_early_caches();
> > +
> > +=09return 0;
> > +}
> > +#endif
> >  #endif
> >=20
