Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YCtHycnr;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=g3itfd87
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BDD380DA8;
	Wed, 18 Nov 2026 12:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zC1YD7ngwDOq; Wed, 18 Nov 2026 12:23:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FE1280C47
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795004597;
	b=YkJM1Vv0ZUZ7dErjq7SKixiLdOr3xf1QF4CgTqKgs9cH6Ef+6iCNBX3h9SGFpfbwztDl
	 dLTDaJGGYW7RN4ADOrkCnUi5/PNEgTo9+mew2tRbXj4tS4GC9bjDNE7iNHXXB1PLzdkNJ
	 lAmf1wL6K/x5O/kHMVtk+ecA0Vn+49+9Y8WriTMCeqi1QGjRXhtxSXBM5ub4DXOedMU/Y
	 Q4yjvwdAVKxuwbe4/ctJ9BxwKQV3F1gy4pasmgZoWUIDU6iNosbS0i6MUGcRlDiKjo09k
	 nfu/AOR9Tgjdl3F1z4BDQgCZPR5C0zU+sDj0A64miCWjnBcO0Idz6kp13rKI0SniQ7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795004597;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G+3ZozmwBOYVdKINsBYcrTlJBMbknnwgusqM9jIrOOs=;
	b=d1CzO9524f98CiF6RxBchGpvKSZ1zmnhLiRLCo6+vDox8qL4SdQHuzBM8XzQXAIcxmnl
	 erxW2tZD6rJlQjA6zMgGO+loBePs8tSh3Dfc4wkktHjzX/XvFq88s4dkzaRNbK0W6zJDU
	 v6SLM326jdEGFEDujjx1FQFgX/1BJ2BPcfIETRJMHCZrO/Er1EV6jkH4pLul1SuMKHucj
	 tOmEG17sI6OXbK4Vf8aCE5ytI6AIb4KRqgYpdPMwKys3RgU1gsCXKbFu7F6lzliyR3Hmv
	 M+Pl6qHOIvY4pppw6cs7MdgwALq6LSnhxghlgYGPQKnbC/o6fbjWyBYOKbCR4bWFHBw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795004597;
	bh=G+3ZozmwBOYVdKINsBYcrTlJBMbknnwgusqM9jIrOOs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YCtHycnrAXrulSZkHJbRjjV0rvkYPCKKOKNDEo86gY3ORehDGjgNhv81yMBEvVN4u
	 tKIObZ0HcIGrdSzHQm5pY+9CE563gdc9Tk//2cvkSsbC4qYMLSUUjqW/KQ5Lks1ye1
	 b41rOhLvXUjVuJYnDdD/hlbTVkMv9C9+4qtxPfZrqzGx2aW8d9oa1T9e7zD1Bg0Gzn
	 mZEz/QbCrXKk1lZxBHXNFjekoSqFI9VGIyJkG38VV+WWYwQlwBTUd/xxpEZ0ZycmGr
	 5GAkDoDU4BuKhFCdl7eTCkQvkh9+QvPNvnsNd6RaMYRanVIpVMV7IaqemQLYvL8Qqb
	 nRXDlnZ8Uz4Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FE1280C47;
	Wed, 18 Nov 2026 12:23:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC96C9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1A63409CE
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oppSNWR7diQa for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 12:23:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62E874098B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=g3itfd87
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62E874098B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:23:13 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jV1324jvTz8vYj;
 Wed, 18 Nov 2026 13:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795004590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+3ZozmwBOYVdKINsBYcrTlJBMbknnwgusqM9jIrOOs=;
 b=g3itfd87c7ex4IzWU2zVZdiG7Bs+Cs/n46ZhwgilQO5TrbrNCpnlKwajoV5vE9wnxiC2VH
 Xqt1WaHesansbzE07JOCgS/tMMhyud1cbvSCiVbOW4q5Ybi2Y0Q/kjvTIHhLrASVFEHF1b
 yYKjIHNDOa43xvtebqzWyaUkkovL6gS44sKA1MFUo/AvwE1YfGO0Zg+L/NqLoM9mxhwceM
 9H22bQ3mgNt5I0QW48PZO/6lpnYDWfDrbZ24B8k7ebEuiNr3g61b8oD1lAPVDfJLeoPyHJ
 DDdBOFR7qBEEFEq4aOEY/AkaxbqYyUTtU4Qnudf93ATcKJRQpuDnRKeipcJPkg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
Message-ID: <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
From: Steffen Dirkwinkel <lists@steffen.cc>
To: David Lechner <dlechner@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ilias Apalodimas	
 <ilias.apalodimas@linaro.org>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao	 <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>,  Carlo Caione <ccaione@baylibre.com>, Chris Chen
 <chris-qj.chen@mediatek.com>
Date: Wed, 18 Nov 2026 13:23:08 +0100
In-Reply-To: <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
 <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
 <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jV1324jvTz8vYj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-16 at 10:43 -0600, David Lechner wrote:
> On 11/9/26 3:46 PM, David Lechner wrote:
> > On 11/9/26 9:13 AM, Steffen Dirkwinkel wrote:
> > > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > >=20
>=20
> ...
>=20
> > > +/*
> > > + * MMU and caches before U-Boot sets up its final page tables
> > > + */
> > > +
> > > +#include <cpu_func.h>
> > > +#include <asm/global_data.h>
> > > +#include <asm/system.h>
> > > +#include <asm/arch/misc.h>
> > > +#include <linux/sizes.h>
> > > +
> > > +DECLARE_GLOBAL_DATA_PTR;
> > > +
> > > +#define EARLY_TLB_SIZE=09SZ_32K
> >=20
> > Can we get a comment that explains why this size was chosen?
> >=20
> > > +
> > > +static u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(SZ_=
4K);
> > > +
> I was doing some testing with this and adding this to the .data section
> makes the image too big for the SPL download agent that Carlo has added
> recently. So we might need to use a different way to allocate this memory
> in SPL vs. U-Boot proper.

Yes, I also ran into it with the SPL of the U-Boot download agent and have
explored some options last week, but didn't really get to a conclusion:

1. A patch adding "CONFIG_SPL_MTK_EARLY_CACHES is not set" in mt8370-genio-=
da-
uboot-fastboot.config. This works and only makes the fastboot usecase sligh=
tly
slower

2. Using malloc_f: This works, but seemed quite complex to me. We'd have to
manage the sizes for all boards and might want to handle it differently in =
SPL
and U-Boot proper.  Increasing SYS_MALLOC_F_LEN breaks the stack offset che=
ck on
Genio 700 and the fastboot configs.
I also looked into moving the cache setup earlier as with your DRAM handoff
series fdtdec_setup takes around 400ms without caches (would use something =
like
"ARCH_VERY_EARLY_INIT"), requiring malloc_f would limit how early it could =
be.=20

3. Going back to v1 (fixed address used): This has the smallest image and n=
o
allocations but we'd have to avoid reusing the address range for something =
else
in early boot





