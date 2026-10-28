Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9BF606A323
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wTglMrqZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0cE7Fao
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA7A581CE7;
	Wed, 28 Oct 2026 18:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a0cqB-WG7RW8; Wed, 28 Oct 2026 18:41:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAAD58151E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212867;
	b=JHpX5VznGR5Zh/tSRDRw2vSjEUDnpnlUgjiU/tuVYMskr6c9cnrOficrKzxjzhP86Qfh
	 xy0JYDUvqKIPqz2DAFBKrMI7z3EhPga/liRHP1E9oHnf8NJXQSS4po82s9Cp9mdsua2uv
	 GHTaGwAe96qjfNg1WaUvmeY4vvdiq26xK772XEF1aOEyuOIfN7k6T6W7B6/Mx38mVdmXz
	 l2s2eNUvd7WDYWgdTMOqAZsM90w6n74tF+XKVjmFehhW5AFi6CwAzqA3erEEhdjLp1SvZ
	 u8jQm4BwJsojlHINokujDIJwEll+VlcpwQ76kT73NzbWg1W3UoPQSc1hOclvdB7EXmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793212867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gUbXQXeAUyCzESBRBaUchp4olDVYaKMHFcKZ1qvrJUQ=;
	b=XEWrNMdvl7svor5eMxDMDvfFyfsfS9MQP+S7BKe15sO+ke9tU7ED37x7QSOyBWeWAgsQ
	 hy3MocJb5g0UBe5NUG6Z3OEctBLbtlTwSovrHOn2i9Ya6Brz5yK1qio5uJsJAu05Va66K
	 SOGxFgxSW0uHVTyiBNb2UWsN618C1/QPuQ2Y/p/VNIARliitJRXIqgbn16SMgjIEbk6EM
	 IJkSvpklgNorQEj4kOsdDPwgb71AvcVNasm9SJFTndiYFNhYhAKcNNuIDn9bPouZJIsk6
	 gp6pxEwLWE4LkJFgcy+4DqPdY8U7BLiiHO15FNiVHWjWRYl2UYXYZI7Wj0iIu13k7Yw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793212867;
	bh=gUbXQXeAUyCzESBRBaUchp4olDVYaKMHFcKZ1qvrJUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTglMrqZv5riwI9MMWdekySywzBsIMbphYZqKx+CFLVmLK2C4w5KAa7iGMyi5gfgQ
	 9O8ZVdzDaQqnnQ+ivyUNR4rt0vxy2FoQGkI61HvIZBYIHgk10u7W7fADh3WvA+unrP
	 792+G21HyvmLNo43vrLSUohEQJQ+05tPu8T1koFVK9I0+m2k6Zdh5ZBacvAtklfLCa
	 CN1fbnVLZ0a+Bil+16/uv7hJUMjVyMgbU2fcauBcTVpR2tbJ8RqriOOmN8MOGIuKlq
	 p6YXjH0w8Z3fTlxM46oYd18M6eWXVEdSwejFZSvY2ovJR8y416islyN4lNbUjuY5Ak
	 fGl5yDntko4CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAAD58151E;
	Wed, 28 Oct 2026 18:41:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A38F362
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B41A607BD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:41:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBi6Fg8MYUD7 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:41:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63D2B60763
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212864;
 b=kq/humdqo60nTuDjVk2vc5wSnKb39ta3s2q6AcrJA2TtLb/D6EtCnI2oZGn+pkumVYcn
 L7EYwduwl9vaNzUdWqsg61iMLCm1TgmKBviaNFe5fJnXKtlel9E6tvK2aQdt05Af+RS+S
 HfW0Z/ZeKJSy6NVz6FEp1jmYbue9Gppr7jULckiyNQkmh5PH1f0sz0uLzjn8d7MJUvouJ
 dd8fj85lOExqQvQtRGMY4TZbS7Lq6D+qNYAjVBh+Y1PCFwTnabffw73eflAVTLBiFalZO
 9ZYChLDfaDa17A3D4gCFOQV6BB8YCEOVcGsnsHkxMOjCC7jDGTiL8tIAtUrKlxR9z2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212864;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=gUbXQXeAUyCzESBRBaUchp4olDVYaKMHFcKZ1qvrJUQ=;
 b=hL9rAhuBmybv555oUEH0Uc5xwbu+HSShF/W51VoH8pthWW3U1Pi9dSMIAcZQbO/qF/ou
 2Ux32wsXVw63n1VBfIl/TVaDv66oMhBMUgSNUEi0aw9FhXAScQDhk59JVJw14+iLseFaK
 /UVa6/0DMTQPueaxYdznQNUsL+/qWHJ6FyOmhRr2NYwCcaatG2kWbE42F3bVvqrMzseq9
 hmQUDYu5z6P5GRZ9m1GAWDTHmHK2HqgOwUiQ+Jjr28Id8Mmg8IzJeisXox+mj9Wgu/RNW
 G732wIxxjLwHvoEcEuAbEJPGSUUGiQhtSplFO++X+k4yb079uE8wahNA8EBH0lOVdRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=S0cE7Fao; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=S0cE7Fao
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63D2B60763
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:41:03 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67990a45e02so1610348d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793212863; cv=none;
 d=google.com; s=arc-20260327;
 b=QhmdcSSIdCXN6/Eqe6aZOpwV22Jo/lLAZUCDwM1GBZVnjOKaWPEIvVbw9LJjHevjJk
 5Xp4Z12LVR9QkVn7+pGGMzrOr9fDyXHVhe9PRlfgzZaoBMoBxzSME0GKjVF5GczIZXrG
 YXAvHxzFLqFmupPMiMpKW6tmjBGmJAFCBmiqvxy0OIN+LH/aE9+5f0Cvox0oqPIP7D5f
 bHeJ4TWzbfr4W4Wyqoqy8Qv9xK9aCsyeg4GNcVbC9o765oTt6MebaC85lHXsLD5cAQM/
 F2CRfdkdE5jJ2Oa17DWi68Snm56yg5t4Cgh6p/zTkKHSd1dlp2z2ZUf7yaAUn/skOAr3
 wS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gUbXQXeAUyCzESBRBaUchp4olDVYaKMHFcKZ1qvrJUQ=;
 fh=KOwRTOaf66Pg0gm/6z9JokXnP96rcNH+yQLXFLcBtuI=;
 b=oO25T3ZVVMj2HSGQPt+vQQF1kZGlR9ZfLtMHlxj+q/pm4n0ShBB608wkNFgCjHQjAC
 rSODMGio/oFuIX172e556Eke4LQzq5UEF4bWIzDDokEgJgBd6QQEvCw+sacGPepTKb9N
 ltqGF+7Wp+YGA/2AgqKB2f803eHdQpvYEgXV9UKS/q3OqTe+/eQgNwFHHjc2Yu/+LCfa
 F5z7V4gCTN1G/YdVrDVBk+ijvggM0vIJwfu4LcoMshAydskwpMA+XJCfhQkDkrfSlzkT
 wlyUPdNV/mqGvzWVfkGoevz2edJE82JQiacpbGZz3fARl/pxO9F5TAfrTgEccusImGpu
 DPOA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793212863; x=1793817663;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gUbXQXeAUyCzESBRBaUchp4olDVYaKMHFcKZ1qvrJUQ=;
 b=S0cE7FaodU60yEmQxi0ksYnaaWe4UptsqKs7qhrFfY01foFkHTB6pellPOCg9pgGQC
 j0dsbq9XFxJEPoI7B7bN9J7Lw6JGDytNj6tPows2T0URt7GyOkWtXf6/Gv6kGoy7Xvc8
 GWVAP1B0dOpKvFx3AvnXgQnkzZc/AWhpkmlR9Zdq8J/ANkhZnXMSCzLUO8mljOjackEO
 mV/b5l120TS1ZTVsTe1ZZRrp0tdfpSuuMD5PlZDhK4fcWIRl2zf7Ch6kjdmZNjFhIK1S
 +e3j/nmcpskmgRVZ6XfyLu6ts7sm2rZrmwQiPHuG4+pZe9vH0hv787NzHyD68sTKidkc
 P2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212863; x=1793817663;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gUbXQXeAUyCzESBRBaUchp4olDVYaKMHFcKZ1qvrJUQ=;
 b=YwmBzh63y6dw/x8tg+O0GzFaZ7wD5T57Z+R5MyQWe2FO2bV/Y0T8sIDbsHbg2LMXI9
 BoCWf9gK20oZbc1eo1kwNbOgKKDNiKdHNPdcVfElJ/OBUjzG5IJk4iaTCo3IH6mPm2Ub
 EP/XqGmsdCop5sz3lxZC1UK1PPBhGtfhWWrDdY9SUesmNWprUr09WrGhSNsGyQnZAhER
 tUPPNCdqF+OB87WAx73VvrUHA+IsYNQovSb0tjdJANLkfb3Qhuu7Y7j8BNklT/wISJhY
 otMKX1E5eT6/2btU/qAcwdoXvWB8IBr3glZ2YRSU57JXObzg5GaD1I+vh6mbKUh5c9dO
 0vVA==
X-Gm-Message-State: AFq9FYIBhnVLOkclYtZL2h4wB3FRFKSEW7KURbVFSvEghHnRwMJDYNF3
 YBPnrkLx4pGyXzkeeczSfPxXln6UGB13xsGewINu0APVoWL4MZ0ZKVMG2NF9YI/rAWuUqbxJDbq
 eWzNMIv6DpV6FL83DxJBEOyD/SbgB3pxB2Yx9zaw=
X-Gm-Gg: AYBFou1+gLP4YqwuQPUqlruCCmnhc7PyP1/gZ5saKD8S4IgV+ClN32vD0qoiT9pnrBs
 KfqI7VSfjGilX2cOrV9OD1XZpVdv5l79IuMlUsdy62PltaSOWYo0grBtMKRfqHRwi7UMAa0hGsY
 Eox83Y2DpFepekVGq4WXVSJi8zPWcTQ+x6CtUO98ByhLP34iUOLy7Uf6fKzR0Mit0Wa5Ft8nqJx
 eJ3AZ0+3MbOoUDPd7QC2qT3c89U8DmmotFV3rulL8HguLSAT7/uTUZSjakEYw35yvMY4BzDjPBd
 4NG5dxqQRLGclQtuU1gHlQFe7mKzP1EMLBmhPjMMNRP+wG1hwJxbk4rdI0TRIehdTSl/N+FqRSi
 lalSUcSldGx2oDwGijSyJaS5Apce2aTholn3zb+Y2sLjbIwxPHOFGU/dvAH4ScUyJJ75t1eV4TM
 drfABfQYa1kh8zoJGvn/t6uL95UXZ1sOnTaric+DWgRNLnJ0mF2bswcRg=
X-Received: by 2002:a05:690e:4547:10b0:679:9be3:406f with SMTP id
 956f58d0204a3-67a7bce996bmr2050176d50.33.1793212862553; Wed, 28 Oct 2026
 11:41:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1791877299.git.pepe.schlehofer@gmail.com>
 <6b1531855e6557a015d83d97ebd0e80417f2e15d.1791877299.git.pepe.schlehofer@gmail.com>
 <20261020212819.GK720525@bill-the-cat>
In-Reply-To: <20261020212819.GK720525@bill-the-cat>
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
Date: Wed, 28 Oct 2026 19:40:51 +0100
X-Gm-Features: AclHuK_Jb0WYf7Xsh9L0V9UXuH0PxkvIhuD3V-RYJaKiqYnGqHkNSs91mLgTfXk
Message-ID: <CABPHAJyObw1fM=QQt5H7y6+Hz+5qE2y54u2UXrKp46K6eWHLjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: Set LTO_ENABLE before including config.mk
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Oops! That should not have happen. So sorry and thanks for spotting this.

I fixed it in v2 (patch 1/5) and checked that all 208 ARM LTO boards
build, am64x_evm_r5 included:
https://lore.kernel.org/u-boot/20261028121313.814-1-pepe.schlehofer@gmail.c=
om/

Hopefully, this time it is alright.

~ Josef

=C3=BAt 20. 10. 2026 v 23:28 odes=C3=ADlatel Tom Rini <trini@konsulko.com> =
napsal:
>
> On Tue, Oct 13, 2026 at 09:43:22AM +0200, Josef Schlehofer wrote:
>
> > Commit a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
> > made the condition in arch/arm/config.mk that leaves out
> > -ffunction-sections -fdata-sections with LTO test LTO_ENABLE. The top
> > Makefile, however, sets LTO_ENABLE only after it has included config.mk=
,
> > which reads arch/$(ARCH)/config.mk, so for U-Boot proper the condition
> > has seen an empty LTO_ENABLE since then. The xPL builds are not
> > affected, as scripts/Makefile.xpl adds these flags for them anyway.
> >
> > Set LTO_ENABLE before config.mk is included.
> >
> > Fixes: a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
> > Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Marek Beh=C3=BAn <kabel@kernel.org>
>
> This breaks, among other platforms, am64x_evm_r5
> +(am64x_evm_r5) /home/trini/.buildman-toolchains/gcc-14.2.0-nolibc/arm-li=
nux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/14.2.0/../../../../arm-linux-g=
nueabi/bin/ld: arch/arm/lib/cache-cp15.o: in function `mmu_set_region_dcach=
e_behaviour':
> +(am64x_evm_r5) arch/arm/lib/cache-cp15.c:331:(.text+0x8c): undefined ref=
erence to `mmu_set_region_dcache_behaviour_phys'
> +(am64x_evm_r5) collect2: error: ld returned 1 exit status
> +(am64x_evm_r5) make[1]: *** [Makefile:2131: u-boot] Error 1
> +(am64x_evm_r5) make: *** [Makefile:189: __sub-make] Error 2
>
> --
> Tom
