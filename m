Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C10606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tGMV0C3C;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oOKEF8uf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EB8B40B06;
	Fri, 30 Oct 2026 18:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qP7KiO2E3HAv; Fri, 30 Oct 2026 18:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0739240A74
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793384749;
	b=WosPiSeso7476kmKfzuR39j36sgnOHKRC5MraYxb9OFIa0ajc1J0jivb9ELF6avMHhGH
	 /aIxwdAxx2dgVoONBDvawx+cWkLWp3RsIyEnykIZIizTjvp9zpC9+P5W7/Exk9mbu/Dy7
	 mxoJgIkujQnOLcAh5UgZgshlqKu8C11fMao7OA6OSNw/W+FQ9NTBM7BSuXNY64Sfismy8
	 P8rkG8u9kd3ygY5gLHaRaFKuirO/KyU6g5twlIAKCrxESOqAVfhHuHqZyO+HPejE2tu95
	 rYcgYkphDPHdSwsmfN4MPIDbJWur8Y4TJ6FHOOfsRAGZpWeb5qh7AB/l2+hMnH6JABQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793384749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j3FMkvXCfbMcaBJ7KwRbTo9CSv5eL1Ka8SXfNlO6iQc=;
	b=CNmanDtg/CFPP20g608uy2jyKUnBnZBTvwmK3QkKACt0sXqAOf56PdsDISA1hl4nptpl
	 dtWlMBcqh7UddH6TlZ6ZNWYUUbwkVSgvCU2J+qIty3bNe264Fiidqeb1oLgV+AN08dlcu
	 vwNXGA+OHavTH0EWl+URaYNXetSiLtrZfx1rG3cgLW99wLaWTx0VxlzSmqSoGq/qH94ct
	 S8xzcfWVtuU91OyP1wWxoUgU9bOP6baoHOhDe/x1EC9vCA3Sm5AWm+pk55mmkDUGr80PU
	 GHaiYhJ0PkUkz2AGmI6s2Ynk8dbUvc+61lQipRdws021jC8kgRsGi+hTYztbHjUmSHg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793384749;
	bh=j3FMkvXCfbMcaBJ7KwRbTo9CSv5eL1Ka8SXfNlO6iQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGMV0C3CUUoC8fNtTYTZXHXfp5gzKJjkNL7XMP324w392/gNYsstHJhen2lGCEHFw
	 LVI/7voKessoXxGr/Fup/h4Ed5kEFkaAINDjzj1/5ODcZvj/sRkOxnHRXgte+4yTXE
	 Z+Kjp6NmHlUr3Os8XjgkzrcmmGRZWGLGkTY/h/Pu+exdXXYLvVjkDl46pi0GWr0+Qu
	 p+7vclasGw70xQZ86/c11wgelayo/IXMUB3x947xkUV8d6iqFwKeW6BQSD9uEoHBSE
	 kSd1nyoUy675+8ac394s7a3wVFNLypUXKqNb1KXYXwBGWyQHPvBaTMXSYl7V13J8js
	 r2zylQFM7VoIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0739240A74;
	Fri, 30 Oct 2026 18:25:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39D422AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36D81400B3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njQIs-131npI for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 18:25:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1BF3740083
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::31"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793384746;
 b=rPPNdFRHl3TJFtI8Y8peWQVIY7V36KtwATM78fEosRun6fLFwvGxA4HfMRrNach+6YOu
 m0ZD2qygQLByZ7d/swn9H/VOOMU2BZAMv+U9BQ4Y9IH1am9F7xrzT84LsmpCV/tb79uQG
 IFCDv48Qb2rgCszL51+N4gmUAundMSWOda0DB7tNNTOSzxc0Jzea6Fh+qCccWfGnyoDUp
 lSrWyhdbbPeu7kvu7rEsmyWTTTwKhDvT7BacYlcTwtFio845Q+xECZD/MIaoLGKsVJuD3
 azm91Wny5N8zueuWciwN1QSnsm8cxyBzw2Ath2gPtnKeWobCuIVS5nqnQlmevmpRGYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793384746;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=j3FMkvXCfbMcaBJ7KwRbTo9CSv5eL1Ka8SXfNlO6iQc=;
 b=BUnp0BzFzOLxrzULv1KtI7hUyICRWJTVSRsxq5LluOKQC8RL6maB7ERQjtqda/agDXfw
 JzvJ8LWfVjrdxAPUI0Bh9YQQYr8hLrEjWaHxl5oAuOWQSw5S/NxatbmPuAU4RY3t060pF
 JGR3JyXGb5DwGBrLGtUqYAYMQw3LuVMkVSbMNvFnZG1b2fQD0pGB59OK/fJicOy9aqgS4
 OpJYZ3RtFXqfvoy8IrYIIn8Zh9/7VgeVRUgyCHjZYz+MFEnVG7HlcputBj8KJ73r9Ypkf
 Jb7nNbhWQ5+nm2W4IekEoCwaoGPJ/JK5KVu5YkzLtX67YgMSQxdsq9oHbOehiYgnEZA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oOKEF8uf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oOKEF8uf
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BF3740083
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:25:45 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-499f20c7054so582157fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793384744; cv=none;
 d=google.com; s=arc-20260327;
 b=JKaqM3QRmRHgY5xMLL8J0XMR2RZbqW4JdK02voS8w5EL+fx+sqT3XNJi6yfbiOptnX
 n4gQ6jySZ7tftli8ZJSv67nDjzcik0LRUBqBHSxE2wHBdZDnePNsQbzWSDYUpWyZmvqF
 Wqye6cZpiTovsfg9kjUfaM+8unpN1a1aK7bPV4A7ZL3dG94awxyPJGm5flxG6pY43i/1
 JHwIfkmh2n7V8+wjWyYspFv7Tb4usca3XUm8d6JvLbrYjL/nv9FrWo0iG1jppmZlimQk
 NJshLCRnSvstJHUNbj5GRlYVStoiFai1JXuONzB6HWpfJxQLkmSR1ThUhGDb9Au/KcVc
 DtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j3FMkvXCfbMcaBJ7KwRbTo9CSv5eL1Ka8SXfNlO6iQc=;
 fh=icA7CuO1vEj6oH0kM29b1RClNWAOKLaaFlaSVbBsi48=;
 b=LgWlauqRoEAHr0LCRLcSTA2cmOKDG+7a+DLKCG+FVcBSxhcCdkDd5dntaQKtKuVRhU
 W4xJHmWUVc1bxxT8Y4tmVCwb3oO4mYKA2rnQdihkkAUv2Rh+p4IKTiT6Z3L4w2oJsLbR
 c4lZtTWbNYXnUeeg0nC0o422VUiX41oIdqefKD4ymMI05s4xZNSHDVbU4sG8KNxwJ7rO
 fJcZMJ9bolhToGnwCorCkdiP3FWfXWHrY7VypPUv8rtOMfRRGpUVT/WUnOupw1xZHUdC
 n8uyZP7gE9eVlWhuf9sJegmLXp99Rfgi2vQGqpX/ttXp+gz9Hi9R6wgucjpHMGDI/y9O
 Hbnw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793384744; x=1793989544;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j3FMkvXCfbMcaBJ7KwRbTo9CSv5eL1Ka8SXfNlO6iQc=;
 b=oOKEF8ufmZ7ZtK4CL6yE9IegWwE7q0wyDeFc3J6UQ22vSzGpbGxuEfIMmYmc3sTjLg
 alplHfFUaGFBnpTuGd4rPDf26noAifO7d7qfRkSIHMsLQVNQ1jGmpxqB/GMbFapizA2U
 870PYo2G4p+W1EcNfQDX23e/ztY8OYO9i5Kgbv4ZiWhGjNQ/QFd7RBh/DMG37ST7CAd8
 nFmMjeS/nekEH4DeUqDcRLrbfGiw5g7gKKOOVSV6dlrg53lbBIkpDbbHHZUlBf2RC23n
 qAA4nSJ26voU/wEiAPcbo25TxzYZX6LcAHWl9YVLX6RqgqEt97tFCQ2/7kV1lu/JNFsk
 nMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384744; x=1793989544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j3FMkvXCfbMcaBJ7KwRbTo9CSv5eL1Ka8SXfNlO6iQc=;
 b=OBPHMCKkEYGVZt+CLzJAFQRE1DnidME2ZF+htgg01nESSH6QXg5pFdEU9+hM2mBkaC
 vQuVvXQAEwO1ChAGLTYqODZNImoXFJRscPiZbYAk2Q9m7OAn9IHl34qG2m6Rne/ye/sf
 46rBDhgQaMQQkLrm0v96ca9psjc60wNJPTnUbyacMzmPE4e46AWuBOwGDK6P3OFiODiy
 WE0Vy3R0O3WJ+ORwVEAr//iE3eTREX98995TyJz8qM2s7v0k10Zvdulyi1rXVDCPskrX
 93NGxA+D7oyoPsARTv0N+duZJ0bj9ClBg9eGZvwkVC1bFrGl2jOmGDopXE2zBFETsaR+
 biwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzU9aicqo4hWBHQf7GiqNrX77yHr/6YTd3K8YSlcHxe6FZbsDCn/H39X+5RGFrpL59PSUGZhuw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK89OqmWABai1Yhk/XA9jANqW1ocGS1Ka4mOgNomz8BzSYZ/w9h
 BSlnG1D8qwk3uvGUs+rrvF/c3WlmPHvEVBOQon8c92tUUQltoGbeGId98fwMMo3N3vPEgBfGJry
 1Ly8cEqegQaHqrzfW2QS882/9tNNWi3w=
X-Gm-Gg: AYBFou1kj3dnO1m2AQv/Q1Jjea991yqXlIT3UY5jOmZXuGZBKT9r1e2ZzJ+C6r/xDJT
 oCJ/3jev2E60U06ak3WzCuM17bgysK+l1IJAtvDQZEFr9/zzZhE/f+QFoAXawEkYJdZdlv3CsdH
 C3wNkTvEFB/jqSANQEikoMfjahOk0MnE0X7+vN55efMKCByuYl+Ot3MW5I+VUbEb1xTvunmIdJJ
 3cqbN/E/S92XhtNbnbYLhVMo6/9jN1RpgvotXiSqoGKVX3+O0cJzw0iPNaPwUkUovkBFRZEHTvA
 pbVxPYB/QLVGPmZqzdKe2gGu5HwpfzbxFUD1y1VHK6Q5Ih1fD9XPJkltb2/4Bo6BBDVVz46S8+d
 +u6a6eaPpnPcvI3gsD/hkdNhKx1d4xsKaqAeLH+uqQExMH+w5QoZ/b8Ql6/yUC+gmrdYb3Q==
X-Received: by 2002:a05:6870:9d18:b0:468:2c18:a031 with SMTP id
 586e51a60fabf-4a907640ecdmr2146485fac.12.1793384744348; Fri, 30 Oct 2026
 11:25:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-2-maxin.john@gmail.com>
 <980bde4c-b077-4291-9cf9-30fe59526ff9@gmx.de>
 <CAMhs6Yxa0wdzkE3py=Ns5j+D8-8_+Z-ngnuxRKcTvQ+0qDpt-Q@mail.gmail.com>
 <20261030163953.GD3309461@bill-the-cat>
In-Reply-To: <20261030163953.GD3309461@bill-the-cat>
From: Maxin John <maxin.john@gmail.com>
Date: Fri, 30 Oct 2026 20:25:32 +0200
X-Gm-Features: AclHuK96RJbbH7GjCGcFciBvsaEALlET1zUvZIMURQVczGODIzd4hQq6b_PESoo
Message-ID: <CAMhs6YybMn7Q2SqoaoU55s=b39LNufV=hT7ccAK9fD4sC4xxag@mail.gmail.com>
Subject: Re: [PATCH 1/2] configs: sandbox: Enable binop command
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.u-boot-project.org
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

Hi Tom,

On Fri, Oct 30, 2026 at 6:39=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Oct 30, 2026 at 05:58:58PM +0200, Maxin John wrote:
> > Hi Heinrich,
> >
> > On Fri, Oct 30, 2026 at 1:26=E2=80=AFAM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > >
> > > On 10/29/26 18:34, Maxin B. John wrote:
> > > > Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
> > > > built and run in CI on both 32-bit and 64-bit builds.
> > > >
> > > > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> > >
> > > Which tests? I could not find any depending on CONFIG_CMD_BINOP.
> >
> > This change is a follow-up to my recently submitted binop clean-up patc=
h:
> > https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637804.h=
tml
> >
> > Following the review comments on that patch, I have also submitted test=
s to
> > improve binop test coverage:
> > https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637974.h=
tml
> >
> > These tests depend on CONFIG_CMD_BINOP, which is why I enabled it in
> > sandbox and sandbox64.
> >
> > > HTML documentation for the command does not exist.
> > > The online documentation leaves the user clueless:
> >
> > Agreed. The documentation for binop is insufficient and could be improv=
ed.
> >
> > > Usage:
> > > binop op count [*]src1 [*]src2 [[*]dest]
> > >      - compute binary operation of data at/in src1 and
> > >        src2 (either *memaddr, env var name or hex string)
> > >        and store result in/at dest, where op is one of
> > >        xor, or, and.
> > >
> > > What is count good for?
> > > What should a variable contain?
> > >
> > > Can we simply eliminate the command? It is only used by a single boar=
d.
> >
> > I am not aware of any other users of this command apart from the
> > gazerbeam board.
> > Personally, I can work around its removal if that is what the
> > maintainers decide.
>
> Perhaps what's missing here is what your motivation is for this cleanup?

My primary motivation for the cleanup was to address existing safety issues
and make the command more robust, specifically fixing corner cases such as =
heap
corruption and crashes caused by over-sized input.

I originally enabled binop while experimenting with U-Boot on the Milk-V Du=
o.
There, I was exploring ways to manipulate binary configuration data using b=
inop.

I agree that the command has limited usage today, and that similar function=
ality
can often be achieved using other U-Boot commands. I don't have a strong
preference either way and am happy to go with whatever the maintainers
feel is best.

> --
> Tom

Best Regards,
Maxin
