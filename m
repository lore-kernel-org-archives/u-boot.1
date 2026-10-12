Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ABFCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0FC980BCE;
	Mon, 12 Oct 2026 14:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RgyW1B2FOQGu; Mon, 12 Oct 2026 14:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33C2080B49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814358;
	b=IlP5Qsl48s8rexg/s1pE84MlD/WgD3EU08eRoiJkinpRLU+rOPxvsyvPqV5BVFagvaUf
	 MR/NMLfGgmMIjG1JvZJExWyjqwe3zc7s1l14K+K6lTZwQaDBf6Mx8rj1Haxd729qwvu8y
	 b1q3GiuWhQvTh/fhBk1VtbutOmNJI68vigMifDyYXpViDZ922kNBnYgPnx4fT4bBaJ1q7
	 7T15f7Dv0j3POQeCl8zjLC223M9jYPFdzCNptUI+09kZqVEeCVYJsuqwKQXn+ESbJucI9
	 b81gUhldJ8Z/FktZkLA/0UucItYxA6+ahx80QTZQYkOG7hUaTKufS4XF9Wn2PydTnJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TlEvDE1PxB76HAiqxQGFeqpqTxYp7iwD6CgL/MCvcYk=;
	b=YDBe6E1J9qxCaLRvMe0fkctX9YZaNn6EIjenAU4Pe2UORzlXhOsoBN3e89CD7/JqrRw3
	 pWvmgUTvCImqcQEiNkYR2R8zy9BeCWE49ECqfeT7ZYJxJilWyX7Ehjc8Q+s0q7+Pv/MTa
	 umGSNc1IWGvrI6QIsUf6b19wJBBqcqm5MdvMSqBpP/G1wJ/tjKb1eI4QNnnJEZIqt9LCi
	 9Dm7YfpI0PoDAnY0M92NOl8u8vQnwGhzfwyBAGjpve3P4ZBNZcRg89K9UqhegGi4ermSK
	 SWrWkm9rOMqiCpw4GvqoyRQ7+M1/HEqHYpwvnEkc+pyElxe5Zq3sysqss3rWe+/nCeg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814358;
	bh=TlEvDE1PxB76HAiqxQGFeqpqTxYp7iwD6CgL/MCvcYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0dOM8J+ElSdVCTn2lL3AXMmPAOF2hLX27/Jy4BeF3y3wcjV9zVu7F5evt7qE1w9G
	 5iMgOtSej5YVvlablLmD5cQC5xxnLYTzOzrCYLdkJX70OryyWX3gL0/C3QcB1TlViz
	 wlhLmpOTpvLtclC+13uSWgTDe2L9xRY4IJl1iPPtt3EmvnrrvyaoHJnRF8emhpi2+4
	 d3R2aj62JkRuaZN1qiR/Gul/XcM9fVzQgXiiE2CKEki5E2tSP/gkLxX5l/g8juQyDf
	 evpSuJZd8Ib55fwecmOlDtlyp+cqdPz52XU7VJ6v+Uq7HkSOkP7q3MdKaCNvl9AFZD
	 mMQm2E+L/Rv7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33C2080B49;
	Mon, 12 Oct 2026 14:12:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71C71156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 577B640057
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLKQQu6Ty_OS for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B3FA54004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814355;
 b=RzuHfmu5cKOT09Qm63GgR9Fu6Vofv8AwhPT1eQ5dD2yoasgLgr9+NdWfPIdMW/OMnrUi
 bnwpZG/wee3QDKbbUZJpGCmTJBgDmxQ5B0kavWpJ4LqGKmGeQdHkHIsNpyJ1iFw4/3LZg
 w6UotWP3Rsxzn/r/kSfXIgBs+F8PFqlU6muSkvTVXYv6+Rb8UhrucUK3pB7IcjeEEpBQT
 T4OTNNmBiNJGN8G9m8DTmizbCWl0QU1ZEGLDBmj3BQsa5we82SHM65WeseosYZRNhK6LT
 dVHadEn2sGWLwnTR0m1eMi7PjLlynGL+/JHkY398EyAVGo2ribXt7d8ga3vj1wq6+gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814355;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=TlEvDE1PxB76HAiqxQGFeqpqTxYp7iwD6CgL/MCvcYk=;
 b=iZcVhecxP0t/VQkDS1d/F19DBsmPA5LsOsNyiuAbEDczVbC27nRAVW0XwpW+yZ8vYThP
 NChL2aZHOyuHjh1QuojSiqffhbgp5zDTukgsX9Rl3JN1CuSecX0zz7Vg0Um0Ux9vjmaem
 JrxQHvlGjE7T6BSztJI4tNYSDTpGqJUToGW3JJCnjaD5y4xQXPG5pFd0FOIoX6MedF64m
 JT229RpZxXYvm8YCfvdwdzAYHtsIXAjCNLt7JK6ktXopWMSkOMl1WhUFkXbw0hIcCK4wA
 7IRYaUEqsXcgwtiw1zOGXbGKcCf/cF6J213ZbNplDadfdJNbDTJ9F7RRCfvDW5A9qFQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WLsURDFz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WLsURDFz
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3FA54004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:12:35 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc4ca696de6so1003316a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814354; cv=none;
 d=google.com; s=arc-20260327;
 b=Pw3faB1E0u19w02hVNk5Os3THMThgjeNsdicWWTu9RP+nqrK9/hIyGDcVA3/eIpT8j
 0o5OzfYS1Nqv2lby5iVodwEkYy7K4AbWRmJZa5mbEzgVD4pMgaEpOMSK2Woh0jvynlMJ
 eQMdv2ibBy8ZR8T/7JWM+01cLGFngzPOtCCfF2RZcwvhaeZZHMY/vv8XlE45J6zx8+86
 3cNZaaDPuHkBRNpOz9s3by9MulFCp8jTiVKp1hjGUEv8rBZsceMAbFkr5dngomftTZHD
 3DuTKYwXFkmZ4FO6lGyM2/5c4M5gPsQbwoWPhh/ZdK/ekBAiv4uIpDI00LKPYJa9Hfpl
 E6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TlEvDE1PxB76HAiqxQGFeqpqTxYp7iwD6CgL/MCvcYk=;
 fh=OZ23/CSc6NwpxFJX+wBgc989CQkxNGz0d9M0ExGAMQc=;
 b=n+2C9kNGt3Ldj6IAP6rnTPNUd1cOpzO1PHYiAaAd9O+AlincWdy7eeEqjd7KCYZSvh
 1hqoCFMUyIIULR/7geTYSejqeeWA/Pkrjy5fgNiPbtf7Q8RCYjA6mLLI2V84/AWGYwK5
 eTwshEDO0byWvNfMSlq7Qp+34oQclMIClAst+KRmhGWNmgXAoGbeBBk3G6Xs1TJxgdrz
 Xnvr2Y3bIM6SlgiClRQ5TUIaI0SLjI3d8kP3BAqt5cd4aoV5cHhAxQR2C6y3oJwi407N
 j8q0h1d3pmupHqjZ17AxUaYNJmsRHybMV7harMRRJp79DzZdxnzpzhX78RILYYJNKn35
 FvUQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814354; x=1792419154;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TlEvDE1PxB76HAiqxQGFeqpqTxYp7iwD6CgL/MCvcYk=;
 b=WLsURDFzb3becLQRyWf3JZTAhzq76VUDzOABxZv+082FK/5dTXVq8jpkLqvZseAzYZ
 su0gHM7HoaPo6852zBDLevs9E/vD7PfzKPbwelE8vWY5SLjbcL9QYPY7vW3aYBxJjgUw
 JquK7DUPJ/qhagxqhP7YthKPKj7f4X+KoXHEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814354; x=1792419154;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TlEvDE1PxB76HAiqxQGFeqpqTxYp7iwD6CgL/MCvcYk=;
 b=w0Lqc98MoO7vgpdazAw2Ervv+0t1VpYWUgOF7ckrnXLEHJ8jquhcOTlb/uithGcNW6
 zTiN7S+vxvqg2fPXLCeg+KlnJ//zOOseaqGYvMNrIdHgtF+BRoQLkd7ZIevXnvJfWImv
 eAFzg0cXySKkwRdsqPw5QCzyI9MIYYJ2qxgU1XtEA4i8LE1vodWNCa4N6XbfcqsErl+/
 WriCTKINgBQy7rrWNcPekp8wQeWl+f6SkSf63T4DumcBKCHEXSqoJ6iaMea1xPdYI2tE
 9ZBIBVwaT5ITpx22jbR97qQ141/G2BVg2+PC7Q9U2TBf9dmnemZ+rk/mpN1VpRxasu1V
 IPXQ==
X-Gm-Message-State: AFq9FYLLaLLRd8Qhw+SGVNarR+AOI6Q/NULshtEGNY2nUEgdSyZC3Pe4
 OZFafk6qHrwJ/X6HsEfKpdhQWZgZ5Kr6Wddi2MLqqelT5v5MMeWlvzu3us5iydEijAPjBVzyUwv
 cyk51BgqDR/XPC49U44WQq9iYWTv5JQTS7Fg1coSd
X-Gm-Gg: AYBFou2tAaU9vNFAtsuuCxo+O6YcYSJI1/g6cibsues5o7yAqp7YmzpEwBiEojL2n7a
 BWCU7FtI7HjGyEeK8IOkof6CVOJYUMiHVfQNv4wxtUTWreQQ7B09jCQm+d/6ubJh8e3BWYaxVax
 hS71Us1kiCpPNK6YaovRQBWdckFEMMMdIgAkjLkgoAbnYncB9/VXV88iV8AGs//Fc7MTbZboyRd
 kgQC6gHoy9V/77k90pHD8jooEKLCk8wi4Mi7FicPrAJIaEITXek+mjemPk8a6TC0JVngMYKmOG4
 fPVt3NwjsGG14I7CKB13dBzV+D8RywrzhY5A2LU/WhxbdWr9tI9L6Qs=
X-Received: by 2002:a17:90b:4fcb:b0:3ab:188b:c5c4 with SMTP id
 98e67ed59e1d1-3ab3a90e816mr8371406a91.19.1791814354363; Mon, 12 Oct 2026
 07:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
In-Reply-To: <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:12:17 +0100
X-Gm-Features: AclHuK-szq93cNWjgo6tU0jJ2S3r4AoVyccIP4kfzmnD_fKTD05uQ2LuM2gyWuA
Message-ID: <CAFLszThDcBYeM+-RFgYFREZ+V3JFX=LV1Hx3qekEpZSA6XQwfA@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ludwig,

On Mon, 12 Oct 2026 at 13:27, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 10/9/26 09:23, Simon Glass wrote:
> > On 2026-09-23T11:49:31, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >
> >> - Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
> >>    incompatible with the intent of the qemu DT merging feature, ie merge
> >>    built-in signature nodes into qemu's DT. To be sorted out at some
> >>    point.
> >
> > One thing I'd like to check before this series goes in.. with this
> > series applied, qemu_arm64_defconfig still ends up with
> > CONFIG_OF_OMIT_DTB=y, since ARCH_QEMU implies OF_HAS_PRIOR_STAGE and
> > BINMAN is not enabled. OF_OMIT_DTB no longer has a prompt, so the 'is
> > not set' line added to the defconfig in patch 1 has no effect and
> > savedefconfig drops it. As a result qemu_arm64 never has a built-in
> > DT, the merge code in patch 1 always takes the early exit, and the
> > problem in the cover letter (QEMU not seeing the public keys) remains
> > by default. The patch 1 commit message also says the defconfig change
> > enables the feature, which is no longer true.
> >
> > Please can you either fix the Kconfig (e.g. stop defaulting
> > OF_OMIT_DTB to y for QEMU when FIT_SIGNATURE is enabled, or let
> > ARCH_QEMU opt out some other way), or drop the defconfig change and
> > say clearly that the merge only happens on builds that include a DT? A
> > test for the merge itself would be good, perhaps as a follow-up, since
> > none of the vboot tests run on QEMU. This may also be worth checking
> > against the CI failure Tom reported.
>
> When I developed the patch OF_OMIT_DTB was "default". 68e65953400
> changed it to "def_bool". Would something like this make sense as a fix?
>
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
>            disabled in the board's defconfig file.
>
>   config OF_OMIT_DTB
> -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
> +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
> +       def_bool n if ARCH_QEMU
>          help
>            As a special case, avoid writing a device tree file
> u-boot.dtb when
>            building. Also don't include that file in u-boot.bin

That seems OK to me (haven't tested it).

Regards,
Simon
