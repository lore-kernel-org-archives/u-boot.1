Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199B606A33E
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tBQu3tS7;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=nM/UNAT0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 610F74052B;
	Wed,  4 Nov 2026 09:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TKJB4sFsQ0Px; Wed,  4 Nov 2026 09:28:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9134F40692
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793784537;
	b=prv/R2+HJevA6/XKJDNo67+pAUkKs4XvXZ/33Ws5DjIxJKr50sN/FXbsRBBfJAT9kwU8
	 KANbhDoabbcBrpaGzpqN2RTItYtwleahSo2EtQg0OsZ2MXhnHLZEKduNcRubS7C8hU5z0
	 PFI4fC2nZxUPpdBTW7jfBgtrx6XePZrsT4Y9IvMXk/CHqogmJXtQ2NLIaqK71ryaTi8y7
	 E2T9trFK60bvmnqAMU9ZpmoJ1PDZSqo5rXRnLWB0pq2Kay3UOxKovj3m97A++xuoYWmmb
	 z1f9x5ph7CqAwS8TBQqKK+uT1nJR9HiQeg5s2BM3XpLCkk1QBSQm03TSt1jh+E26hzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793784537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dmw9yvqj3AwcybGRnJlwYM2VOvtfOEIPyl2wjvR1cKU=;
	b=MA4x8XIyEZVVl8t2H9zPuBk87pfr6XYWppwaiD+8RKQRg0eoyIAQjSGZUGW+PirHxujL
	 ft22S24JDTXR1SRz2/1kONsrRYHQo0PGTCMBrl0VzwyqcvMQb/fZXWI2KQm/CFDVMAuil
	 f5iycHcmT4NLN1AN/Mo74My4hINTE47EFbSDU9hzj1WQri3oTxeI/5FlgeB4uO0OIQ+xt
	 40G5oo0hCIEKE5P2DA1EoulYCfn8QK/dvjfB0IS3SalK8DM8mpGH9Ct1OSb32ngwXgSlD
	 avvjaE87EO+Y3nJgQuKwEaTn4OI35dk6LIb0Cwbc9yhbV22vEc3hpXqpJXl8BEZD3gA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793784537;
	bh=dmw9yvqj3AwcybGRnJlwYM2VOvtfOEIPyl2wjvR1cKU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tBQu3tS7yERCG1JegeNuWtD+Ra6fpUnji+olO0BwvLU2v30FZT7HtA4TNNushwSF1
	 qpE1W4Hw2zpixxRGsNu3a1XTj7lbFcx1NXFM9nS2CLOjKFjDnmxcbdMFJrRt/LX3Po
	 piBW5zRwoWt+VFMHe73RsbSDBWAEHHji0t7i9SNHjghSqWdMpIE2DY8QYhwXCMiiX2
	 qAMlGF0nGzltvgQZj/l2v5p6EZf2auamlhqOvXWdP3UJv8XQ/hkORUbzuIwGmf39VT
	 oOeXExuqk6WyF1TIoAOKHVcsTagTSai80GpNEUmKxRYOfGgBUT5tRy7xvWMw/JygfP
	 UVdbujwUjvG4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9134F40692;
	Wed,  4 Nov 2026 09:28:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ADFA37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B90F402C5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqu7mgCZZAHu for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 60EE4402B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793784534;
 b=hqJrXU0+EH8rq5B10fvF40eCm20jR2wjZvHLj9Ekd7f8VAw9F5sooQZ+U3KYobzZGqkO
 DowzwFGJbO8KLp+5fJaU7Sz46LQIXLKq0BVz6YNMsCqzLMHwJ6l1XEAyivEosJ06kvS01
 ropKTimsC8ANfp4r+VpmEbfCV9mwXkCq9QJyPXjSVYZdPyYI3sxNVdEw/Pz57TJT8Hqk1
 R/0Z7GFZycdhavWRs+2d5V6NXi/j2S+B6jIGdO9T3OVRiaMDli4aCh01uqDmeAGxdozNs
 LgreBhIhtKbOVSOQV1b0fxyOLryIvcZRRxAtL6UYxkIioGWXTXSsWXhEuUoGNf3VANw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793784534;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 User-Agent:MIME-Version:X-Rspamd-Queue-Id;
 bh=dmw9yvqj3AwcybGRnJlwYM2VOvtfOEIPyl2wjvR1cKU=;
 b=Rq8PxWajrZkJ/BrcN0l1aGIDsiXrISJoWkm5F9SJqmZ9mpxGOLim13Ghc2Ky5sbyb5ZK
 4s4ZXgPCehZrHlxTLPmW0r/Jzvt3ibkr8oJoKoytww74rrHWHrRLN66rkrEpwEBrRo+4s
 5osuwligYs0g7CPtcc0QorLZyzg3EFDSJokboME15ahGS9dIguKhm2Rr61DaFb+q/mZiM
 yHev6SbJqfdc/MynXbyqlQA/cJJ2+c0/hfPl1VQP/3V10xoo4NeD3W+0XHcTosBEjJMWI
 Jxp41lslaNYcxk9ItL5ZC2WPH0pS0r2xwnWyzzcKswsrjzrCn8djDL8x9XCsoad7WMg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b="nM/UNAT0"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=nM/UNAT0
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60EE4402B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:28:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKKrL3c0fz8vlm;
 Wed, 04 Nov 2026 10:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793784530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmw9yvqj3AwcybGRnJlwYM2VOvtfOEIPyl2wjvR1cKU=;
 b=nM/UNAT0tZlsasl53DP6pSIe/XacWpbx2FYEZ5Yah2UBju3knc6T30ydlnGCEJSdTCA1ye
 YzDnz0VVMSBjCgWzdwoZJxw56FuGRTGDuSUHvrFzgtzhj0i7t71Abdvm6vQcJnO9UASkH/
 AfZ1pASOFsmd2OMvy4ouaNrQOC5olaxwafXd+1pQbhU3Ujp+344T7lMSIdtGXFgqVhFpB5
 EXlDwoX3pZFP5pzEXrB+Q5yzgvnqg2LhIjPGAMuZykUOp3I+bDXn58g2Vvt6FCfyY1P8pC
 ZY3y9S47Zz+GUiqmnKsMptyI/B4vJvmTOXuOlRIG6ahA4GjNoaFfC4nUQK+8DA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
Message-ID: <4a8d6b91d9048fa39056406944eefe7390b6c8ad.camel@dirkwinkel.cc>
Subject: Re: [PATCH 1/2] arm: mediatek: mt8188: enable the caches in SPL
From: Steffen Dirkwinkel <lists@steffen.cc>
To: David Lechner <dlechner@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ilias Apalodimas	
 <ilias.apalodimas@linaro.org>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao	 <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>,  Carlo Caione <ccaione@baylibre.com>, Chris Chen
 <chris-qj.chen@mediatek.com>
Date: Wed, 04 Nov 2026 10:28:49 +0100
In-Reply-To: <a208fe67-c8f8-4a82-9636-553477307f6b@baylibre.com>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
 <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
 <a208fe67-c8f8-4a82-9636-553477307f6b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jKKrL3c0fz8vlm
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

On Mon, 2026-11-02 at 10:31 -0600, David Lechner wrote:
> On 10/30/26 3:57 AM, Steffen Dirkwinkel wrote:
> > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>=20
> A couple things in addition to Carlo's comments...
>=20
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
> > +
> > +/* Initialize the MMU and activate the data cache in SPL */
> > +void mtk_spl_enable_caches(void)
> > +{
> > +=09gd->arch.tlb_addr =3D MT8188_EARLY_TLB_ADDR;
> > +=09gd->arch.tlb_size =3D PGTABLE_SIZE;
> > +=09dcache_enable();
>=20
> Why not also icache?

I tested it and it didn't really help (boot wasn't faster). But it's cleane=
r to
have both on, I'll do it in the next version.

>=20
> > +}
> > +#endif
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
>=20
> Can we make this a config option instead of a weak function so that we do=
n't
> have to implement the same function on every board?
>=20
> > +
> >  void board_init_f(ulong dummy)
> >  {
> >  =09int ret;
> > =20
> > +=09/* enable caches early */
> > +=09mtk_spl_enable_caches();
> > +
> >  =09ret =3D spl_early_init();
> >  =09if (ret)
> >  =09=09hang();
> >=20
