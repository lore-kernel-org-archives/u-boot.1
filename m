Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E6606A333
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fIFo5Oux;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=YH2XgM/o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=G1acbJKH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 136094053E;
	Tue, 24 Nov 2026 20:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0Pw3hz_wRFN; Tue, 24 Nov 2026 20:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54748404EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795551594;
	b=VTzHG/J13juY3SKQFS1UcvbsCnmDATWdPICO4Ne3jDIIGH3zJYELwhYGU4YRX5q7f/+n
	 HCdk3WjknQPvHfLj6pZoWXb1BsFteUXMfdxTvkRe3cUrVGVNzsDcnS37/hXZBMjdDOpGJ
	 kdGGVOLcnj1F1N4gpj+cE7iY9esh3Hgz4n/i3GeJwInF9UylPVJUeHp2rY9sgvXCOJyUk
	 BWmE5S2/jICC5UYw4qw+oElSRQUneFOZroekrYyLKX1kILB1oJM2dwXBhU+JkoIkhw5ln
	 Z4FPH1noNVJCUNzMAGgF2Jw6E2Yf4zOYlhNnrmct43JYzNTEr0dcEdXKMwktqQmsBYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795551594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6hkXFf+Ps5SUhC71AnYskJ4sQo5s1JeCxmJb1dB+9Po=;
	b=mjSo36wifGT37kxZ02iaslYM5EMHSQQrpjqYrShkOC/0QyWlFPG6WxgONo5eoHu2B0PJ
	 pNCMB8so+mtoC/6ybya/VLSdoNOe2YJ09i8Anvc9dwrIAok9zyRaBXSoQ2LWKYAV9XOyn
	 /7uga1InFMAkQy8bw5OvcBMZIdiIhf6fLa7FUr4xHKrkHlToNI2JIfas14o+6JC5WQhkL
	 pwAr9BXQsc5IzLucefIVaIFC24vRjSdfk2cPJs/czRt6O9CPXO0tm8QjjQ2BT8FOhxhdX
	 ZQ2GK4PrbGmcnDS9J3Wst3xTWfPfmmPUqbeiAG8d4txTJ3Y6VtzTIsuG0kgjx0wQuqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b="YH2XgM/o";
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=G1acbJKH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795551594;
	bh=6hkXFf+Ps5SUhC71AnYskJ4sQo5s1JeCxmJb1dB+9Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIFo5OuxQW9pG9BYzRQy6ALIW6h5JArPk56c5OgLQSJIYSAIW4hMSpKvDOo0gSIeV
	 6YS/varh3S1M9iLA2rwdTsQ3Bm1WEZm6gZzx1gBBncg6BAbZjuYoZLbLE5yuxk1DKz
	 DSPiRv9b2u5Bkgu0YdUlIIhy+NjFLUijyTypZfNqmRMutZvEd6O73ccIFE2lYiEUcn
	 USm8B+LW2/brkiZ97LqYS75grY8EhJTUgTe/ON8LoLMwEvBDr4LSKVZYNhRV7OIzj2
	 C4UDP3oPwGP5xDzZ4/DIYdYLhxY+93pwx29+WiZbLyQB8HKK41W7gQiA+6FS8iLADm
	 PtvYLvTVofT8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54748404EF;
	Tue, 24 Nov 2026 20:19:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F7CA325
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2624A404EF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qo12oCj9mfL1 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 20:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7BBC2404EC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.0;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=YH2XgM/o; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=G1acbJKH
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.0])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BBC2404EC
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=6hkXFf+Ps5SUhC71AnYskJ4sQo5s1JeCxmJb1dB+9Po=; b=YH2XgM/ojs0HFgaNMrvAzfPU2y
 M6A5ehzVexeWVkcB41kPRHAgFaWe3qUx98sDlkpHdsk4TFyar8DA2In5JVQx4aRZIWcPuaILzFghE
 mbpGAhC85toLPPVX+Fud9mqqkRoGN236B10jUXf4pflgh1fKUStFXb9L8jXgaihpwIcc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVwzS-0000000Evv7-3fbo
 for u-boot@lists.u-boot-project.org; Tue, 24 Nov 2026 20:19:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=6hkXFf+Ps5SUhC71AnYskJ4sQo5s1JeCxmJb1dB+9Po=; b=G1acbJKHVOgjmpZSKRXN2etP4/
 bCB3Ig2M1xNU03R+BE+9BTvO+6RNZ00x8je8fzd9nPSte0qB122VWPlbivT9vMKmHyK7UilBjBVIg
 mxWcOFv9keed3sOVPgbHQljSscf6BeZ9kDztCAMphP5DlGmWa/Lhr6F6j1ZCLQ9LB7qA=;
Received: from [79.28.115.6] (port=63953 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVwzN-00000000KUP-408M; Tue, 24 Nov 2026 20:19:42 +0000
Date: Tue, 24 Nov 2026 21:19:39 +0100
From: Francesco Valla <francesco@valla.it>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 u-boot@lists.u-boot-project.org, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Joy Zou <joy.zou@nxp.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
Message-ID: <awXws804rjW5jkXL@bywater>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
 <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 6f98e34b7ba5f3f103cef7f65d005157
X-AntiAbuse: ID - 6f98e34b7ba5f3f103cef7f65d005157
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVwzS-0000000Evv7-3fbo-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Kumar,

On Tue, Nov 24, 2026 at 10:16:20AM +0530, Kumar, Udit wrote:
> Hi Francesco,
> 
> On 11/23/2026 3:41 AM, Francesco Valla wrote:
> > The TPS65219 is a family of fixed-function PMICs for which the output
> > configuration is determined by the part number. For this reason, usage
> > during the SPL phase is unlikely.
> > 
> > Add a SPL-specific option for the drivers of the TPS65219 itself and its
> > regulators, to allow its exclusion during the SPL build. Since none of
> > the supported platforms that have this PMIC onboard modifies its
> > configuration during SPL, default it to N.
> > 
> > This fixes boot hangs on the boards compiling this driver but that don't
> > have the regulators sub-node marked as bootph-all; since commit
> > 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> > this absence was leading to a silent boot failure.
> > 
> > Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
> > the same configs, so it's affected as well.
> > 
> > Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> 
> Thanks for update,
> 
> I see this PMIC is enabled for below boards,
> 
> configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
> configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y
> 
> 
> I am wondering, if PMIC is really needed here,
> Do you see possibility to mark PMIC as N in respective board ?
> 

I'll take a look, but PMIC support can probably be dropped altogether
for them. I still believe the proposed change applies: in case we drop
the support in U-Boot proper, we can maintain it only in SPL.

> 
> If you look at other boards from TI/K3 using PMIC at R5 stage not at A
> core stage
> 
> configs/j7200_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
> configs/j721e_beagleboneai64_r5_defconfig:CONFIG_PMIC_TPS65941=y
> configs/j721e_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
> configs/j721s2_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
> configs/j722s_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
> configs/j784s4_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
> 
> 
> 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  drivers/power/pmic/Kconfig       | 7 +++++++
> >  drivers/power/pmic/Makefile      | 2 +-
> >  drivers/power/regulator/Kconfig  | 9 +++++++++
> >  drivers/power/regulator/Makefile | 2 +-
> >  4 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > [..]

Regards,
Francesco

