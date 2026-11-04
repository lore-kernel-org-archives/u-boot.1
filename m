Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD47606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nwuQ//xh;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=ki2L0hGE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53B9940726;
	Wed,  4 Nov 2026 09:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DN0Op8zvtEne; Wed,  4 Nov 2026 09:25:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C5FA40653
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784345;
	b=UA8MBtVfBRlPhlmpcHPYblwLk+Vxvcbhaw0K6xIVldVw4SNrXghG1YGn7WH/eW/+SDaK
	 jznyBRyxuhuhmDyRjiGPeQnJWalcLIUTq0qpg1eU0rRudkfOHzEdbz6KtYqrxEQRsUqlG
	 Xcf80KAGPEwqrn9oNmkVXiD2VUA+wBCOBEAc9yqIjubXJdvPpbtFWHHms7yKFcM6BCKxE
	 usoGSbLWy88XNjG2QNNgqrEkqBIzT5JPNuqwyzpLwZd7nAU9kZm0KGTb2gcWNxf80Bkm0
	 jWpT9lkcKnuM478nAV4a+5/NMk49iAdhSSgUYGTMFTWBqZJFHKB4Dcg5BBWwiBCHd/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I6vLMN1PgVhwFCfUlusL28nqBdGkm6+REZOFUFc1Rfs=;
	b=C1xo45bG53l5LGQeA1/amVKF+6UfhNWXQ0np+JpruTUu5obedriqMqDLbhfgaYHIrb0d
	 WeF6fZ0DiQgq1SLOPEhY3fDgZgKkQUrO9uZWDFVWEpCIdBJJKtbx/xWAVN30OEt0p9vik
	 EttY60OklwJWvNh8j9gmGmlz9vaO2Hd5q7TkMqsOOpv4UM3jTZx8gHMPZbHOK/dtAYvjU
	 YERhkwjhyeNhxy1zLz5vPjket7dhpJsbtQZbWQRQz2zXDlTz3Ybpcff/NmX6KW1J4Aayr
	 Q3u1+Rpx+sGTzOwnZIs8d84VObZDZ7XA99Yu+EWErhSm20QQPK/uXHM/eY3gchqSgkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784345;
	bh=I6vLMN1PgVhwFCfUlusL28nqBdGkm6+REZOFUFc1Rfs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nwuQ//xh/IOyuUHU4jUXvWTO8NUFrWkAE0PQACxtWkBR5MJds3tPPNJGsCr1/mdw4
	 YaK+MzwEA5cSuAuivIfltePnzwJC2p8qyBPHOmp4HdVAZM4qDw6gpzYSuaYBm4KO0e
	 g1Mfh+85WLCCpwpzRpaxskCQEe3GuhN5IsTHrR9757FGrpxfo92brrvL6exf9vEpO9
	 U/y0NyANhDVpbnfjafBM7JqFPzP7OErI2baxjIIwPGleEWiFqfEuFR6Tsg+o3f4zC6
	 +cYX8FJyK+eSlzUE0ZMMjdrb6yEx4GJk6E1Jtvtm+csW60+IS3yImaufzpXSldzZwT
	 9i5XwPgZ7PxQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C5FA40653;
	Wed,  4 Nov 2026 09:25:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5C0E37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BE2C80E1E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6qE-WNKll7P for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:25:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B97D80A87
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793784342;
 b=qioGSsWoBJssJVTmDg9i3RF/XCg/bPuhfRqCuLB7Krqo2J2s/lXJFS5ZX9I4y1SHazLW
 Ls64e4muiTJP8tOYUcFYr/G/8RZUL7UO3g38mZkeguQwWKz4m/omLG2Cl7o2iBO78miat
 1RtLZ/TG4MBSwMpaFPyRzOaRyk7Z5lRe4oL2bHpHn03Cgt57UbBa25zWgacjEU5cIZYPP
 imhu09dPp+Jr54fF1q+LBVPVrIgU35Wle2KchzQGymamFnT+t4kjGxTmcf8e3lChBuWb1
 fMRvmZAPbcvARiScxuBa/YbIUtNGZrfzILElnpAOGf15fBPyzatbHJtWeBPKVuQqvDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784342;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 User-Agent:MIME-Version:X-Rspamd-Queue-Id;
 bh=I6vLMN1PgVhwFCfUlusL28nqBdGkm6+REZOFUFc1Rfs=;
 b=DZZCprJm3u6Sl56jmYw4DFRGBG4dp7STGQOvkVXxGsHYwjUEVwvxQhke+pAI1niomRaX
 pSSeS0Gvt+JnzDNRqf5Ul4pmuoykF+0cqPw+kMNG+HFEcdTzzvVuhAJik9rW4tnslMtG8
 GqybVW8W5p3egHFA08HkYzKxCjEH7JUQWbHO3Hkhr4v8gPbFG96WCdrFi7J7dWi6llwbn
 gi4Pm0L7w6tAvJC2EVMoxMoSSvwm7SUpJMZJd+RywlZG/bQyOXJKlu9Oj4u7Ldj4ygv9j
 S6xETH1yi08SENRrISrquK/Oys6YZx6qYELggeTxJnR9YhXQEeQgiHXT6QVPHk2UiAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=ki2L0hGE; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=ki2L0hGE
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B97D80A87
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:25:41 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jKKmf2YGZzKpBZ;
 Wed, 04 Nov 2026 10:25:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793784338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6vLMN1PgVhwFCfUlusL28nqBdGkm6+REZOFUFc1Rfs=;
 b=ki2L0hGEbhk0zL3oaM+HAQw0yGhMO5hD/U+s/RYi9hmnQkljs7QvTKVW9wLh25ovu7ax8x
 ngyUoIeW4RAsHzRzHKCFcn6Qbp0k+fRJhfZrTn85JCsgEsdgwu/83TYMUaspMXHNkdY7e/
 LEZ+wFXgFNeRogRy75nJ8sT1+TuBtjOtEZYhe+wfPJVq9BrIo71//7tDZ2DKyLCydF8J3T
 szPLtLmwUzez5+BV+si3OMnwLHEMRSdbiryRsle9Wd7sovKKXgYhqOSBHGVjrEOk1o8rg5
 ccZXHkDbWhStn0sAC7d4Ciet9mxiDMmHtbbCON5yYO9r+lfoEVXA3gqeu5jR0A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
Message-ID: <1126928901d49a1b987b4c6402f0adbab85ee43d.camel@dirkwinkel.cc>
Subject: Re: [PATCH 1/2] arm: mediatek: mt8188: enable the caches in SPL
From: Steffen Dirkwinkel <lists@steffen.cc>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Ilias
 Apalodimas	 <ilias.apalodimas@linaro.org>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao	 <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>,  Julien Stephan <jstephan@baylibre.com>, Chris
 Chen <chris-qj.chen@mediatek.com>
Date: Wed, 04 Nov 2026 10:25:36 +0100
In-Reply-To: <auSlW_sslFXp8aVs@macbook.homenet.telecomitalia.it>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
 <auSlW_sslFXp8aVs@macbook.homenet.telecomitalia.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jKKmf2YGZzKpBZ
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-30 at 15:21 +0100, Carlo Caione wrote:
> On Fri, Oct 30, 2026 at 09:57:41 +0100, Steffen Dirkwinkel wrote:
> > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> >=20
> > Running through spl without the dcache is very slow, especially when
> > hashing or checking signatures.
> >=20
> > Time from the SPL banner to entering BL31 on an MT8370 module loading a
> > 2.7 MB FIT with SHA-256 hashes from SPI NOR, two boots each:
> >=20
> >   FIT                    caches off            caches on
> >   unsigned               864.0 / 864.3 ms      95.8 / 95.8 ms
> >   RSA-3072 signature     1903.3 / 1903.8 ms    142.0 / 142.0 ms
> >=20
> > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > ---
> >  arch/arm/mach-mediatek/mt8188/init.c | 14 ++++++++++++++
> >  arch/arm/mach-mediatek/spl.c         |  7 +++++++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-media=
tek/mt8188/init.c
> > index b2cdec8c2189..2e6aa041c38f 100644
> > --- a/arch/arm/mach-mediatek/mt8188/init.c
> > +++ b/arch/arm/mach-mediatek/mt8188/init.c
> > @@ -6,6 +6,7 @@
> >   *         Chris-QJ Chen <chris-qj.chen@mediatek.com>
> >   */
> > =20
> > +#include <cpu_func.h>
> >  #include <asm/global_data.h>
> >  #include <asm/system.h>
> >  #include <dm/uclass.h>
> > @@ -47,3 +48,16 @@ int print_cpuinfo(void)
> >  =09printf("CPU:   MediaTek MT8188\n");
> >  =09return 0;
> >  }
> > +
> > +#if IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> > +/* Early page tables, in DRAM unused by SPL and by U-Boot before reloc=
ation */
> > +#define MT8188_EARLY_TLB_ADDR=090x4e000000
>=20
> Could we use an explicitly allocated/aligned buffer for the early tables
> instead of 0x4e000000? That address works with the current layout, but
> nothing reserves it against other image loads.
Yes, I'll switch to a static allocation. Other boards use the top of ram si=
ze,
but that's in dt currently and not available so early.

>=20
> > +
> > +/* Initialize the MMU and activate the data cache in SPL */
> > +void mtk_spl_enable_caches(void)
> > +{
> > +=09gd->arch.tlb_addr =3D MT8188_EARLY_TLB_ADDR;
> > +=09gd->arch.tlb_size =3D PGTABLE_SIZE;
> > +=09dcache_enable();
> > +}
> > +#endif
>=20
> With CONFIG_CMO_BY_VA_ONLY=3Dy, the baseline reaches the console, but
> this patch stops before BL31. SPL leaves gd->ram_base/ram_size unset, so
> VA-based cache flushing skips RAM. Could we handle this mode, or leave
> early caching disabled for it?
>=20
> > diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.=
c
> > index 125ebcd784fe..8073101e3ef6 100644
> > --- a/arch/arm/mach-mediatek/spl.c
> > +++ b/arch/arm/mach-mediatek/spl.c
> > @@ -14,10 +14,17 @@ __weak int mtk_soc_early_init(void)
> >  =09return 0;
> >  }
> > =20
> > +__weak void mtk_spl_enable_caches(void)
> > +{
> > +}
> > +
> >  void board_init_f(ulong dummy)
> >  {
> >  =09int ret;
> > =20
> > +=09/* enable caches early */
> > +=09mtk_spl_enable_caches();
> > +
>=20
> The BL31 path already disables D-cache/MMU, but jump_to_image() does
> not, so this patch is in general fine if we are jumping to BL31 but it
> is not if we directly jump to BL33 for example.
>=20
> I tried a direct jump to a proper U-Boot from SPL and indeed both remain
> enabled with this patch, whereas the baseline hands over with both
> disabled. Could we cover the direct handoff too?

Yes, I'll move to spl_board_prepare_for_boot to cover all paths.

>=20
> >  =09ret =3D spl_early_init();
> >  =09if (ret)
> >  =09=09hang();
> >=20
> > --=20
> > 2.56.0
> >=20
