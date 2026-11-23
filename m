Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32B606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wih8yjEY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBiDpoc/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAC3B40556;
	Mon, 23 Nov 2026 18:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8JEsJfc4G4y5; Mon, 23 Nov 2026 18:49:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7D37403FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795459761;
	b=NTZHFy/FvpA1+Ga4puadMUg75WB2lJXSeulLMgFBpuIvCYW4dFY7HIRuo25gqIhd0aXe
	 sHVtTy90O2TFODmxAyqWjMgjy5Geh74A3XMNJMJyZFcBUgsz+ZkT69KwAbjucQUW1YLvh
	 OFzp8285NaedSOqbm0RvKSk30avwI9nhAYA609CJRw+q+Z6LdQJInwf6B9/jV3Bn0d9yV
	 bAoIrnIFKmUlTN1OClgDyF51I+AEmf7lffE7et836CcKz+vI8sGFj3gaLA0p/L/JPohHj
	 9qa/o6QMjebmb+Cbvie50Ti3UKGQCIvRSqgXaNJwacFJVjvR2KctnigHKlWizkp16Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bPxdoeiSAyx4n5l2rX4rXcRx+E+Nk+P4N+iD/rWk1x8=;
	b=ODNSr4qI4V8gq288qjMLKGVtHR9oHOHGvf73qi/jEP03xcT0vv2ZsnlHllRlUePQ8Gab
	 eYb1EOlOdEOYanEpO89YiyaebVi/132zaNaQ/TytZgVCSkg39IvOgKdbYc1EX0IUzRx7J
	 sgWcgtzawjHiLrhtMDat9KYOMj29RzNjZdfA04Vn2FSJnwV6p91RJsccRKotEMYOUDqZm
	 h5F756kXNzDMYkLDnPBQv2bqMf/miPjR6xixOP+i3VAgXEmpoXC+0YAQvLC+4Jmm5N9oA
	 iP98pIndGUodbyzdo/wH6V3rQtjyfo6yxa4lqq7ZWXIjC//4VYCndP6k06+unTbMVbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795459761;
	bh=bPxdoeiSAyx4n5l2rX4rXcRx+E+Nk+P4N+iD/rWk1x8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wih8yjEYtXtQQcwKXJVyKZWLspkLpM/fb2QQSDMtEa6Qy27ot+IceHoarlhME3uas
	 cCJNaMo4L1CDLcFlgrfReu4A/NzTocBmAo/okQOH+sB3P+IQorRvVIqgfzwhZUCpA+
	 jsMup1h7T9O6Sp/X4Tt9sru8/6TReidqn0QYOzmO3dYhMjwAH9X6ghjEAn9E5sDV1B
	 yfXVPW6KFXwofS4tzM8jWK5qnecMkUp2pQ5YqMTj1yQCnc/o8ByLVJOdsSq0WBKpaL
	 1OXR66ALbY2AkAXEqjVTw4aIDlrHLcPiyxMwV8p+GIToQgAgYgBKRYXtO/W8OF+TkG
	 xqAt6b0K1RCYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7D37403FC;
	Mon, 23 Nov 2026 18:49:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 575D7260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 493BA60640
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vq8h9En-dXmj for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:49:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52A3C605B7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com;
 envelope-from=malysagreg@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xBiDpoc/
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52A3C605B7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:49:18 +0000 (UTC)
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1b3ada81853so4183213c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795459758; x=1796064558;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bPxdoeiSAyx4n5l2rX4rXcRx+E+Nk+P4N+iD/rWk1x8=;
 b=xBiDpoc/EiW9sw/XUXagYvHvY0+cB5T/8EL0O/PZ1TqNkGoiGOe5W54ryQ8jO/p7q/
 2YvPO5aiGUDlago+zTK+IYD6DrQg73aL84DXerUBAdjHhqjGQpbFWsdN00VF1ok8Ynj2
 y+XUaRLuD6RhBjPV9KovS4CNNXiIYovjs3aVVEMJ5Yu4SLwacNacUIFvKxZf8tgKP5DM
 /xba25X7Uf94wq97y4lOWXYKS5gvcBBEmLtfgXYXMpDkayGhyUb2zIYxF6Q/jVkTjb/u
 wCSwPrz59n7rxjgzBI/GWi3cQYNMCFd1apqANl4Vi013jw0uKwKd4Ukcjc6orwEuokPi
 /DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459758; x=1796064558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bPxdoeiSAyx4n5l2rX4rXcRx+E+Nk+P4N+iD/rWk1x8=;
 b=A/U+tPCND7D9yLsLaz6IZWOtUBmKqVEDN6bHVD6Xm5lOY5hq74oe79Gk9qcypXQxWD
 +QxSOolcP8LyB1usnz7hcvqj2JOOEZTzLjIK9EsoMVp41hq337MiUEGepsEABJvSs61V
 Bqr9HwAtaMSTFtFy02kQWCP0myvSrcAuzEx4mNlEyKadpwUQXyny48mgMrelwZtiXp4V
 Oy+QmIA9qyrOVy591nPAqh4NNFkrZbGgA5mji0KgCqenwHCs2PajyiFL3ZCGkTUF4hsi
 Tr99qnWMV/jdG4F0/QJsdqcwFgUHzoNJRkGHFhBNBtj7xIEqTeDjFv9cs9JdqB+hf7Jy
 Z0hQ==
X-Gm-Message-State: APuU4Z8OFxhEaWg+9OP5+kCdrpWg9mJ3vZcTRh4RL/9yYSLWbJjs9kCu
 zskLcuI3aXbL8x9IVs4esXhbVhb6OdXEqjtKmmiorAiCraUnED1ZRMEPZKN8YUyYIBZEqU93tPj
 S97rhuM3H/DvSvtl6mXxbG8qLNmI/Ow==
X-Gm-Gg: AZFdTZdmIeZn8/HPfjh40MUzx10pse9lD9c3e3zE8s4/mIVvkIFl4xZ9H4WT/RAKLNH
 Nd2FKAfkhiNyws1lKvEYAfRDP/3Y6k57mp4JIXJRYevGqGxouUD9R1Eyahw4j+J2X1xqR9OuxLJ
 fFGdZvhA7XGOvrAb7yfE0XuFQ4raKQWiGz7fMup+rBkU1YIknb6KNUO6GJSrsHDuNJk0h55vb+S
 A+t6qzSSNzoD4lj6fOBxn/IuMR36UUQi4Q5MMVu4lky2vQfQCEWMjT7FAL5ZOIDp4jQlbdQ2VOy
 P1Y/hd7ua7hYe+GnAkZ5Tb1XJnrxzXID4PUa0Y7BWSDpfyCuurVvvkxzejxAXHIPmPVC1tnGYpM
 919XO2YGpgn33XGUvTqjiAcnf36cUQaHwbifU6OhFH61Wfhe4F4zpAV/mH3Xo/nB1w6dobg==
X-Received: by 2002:a05:701b:2215:b0:1b2:42db:8a54 with SMTP id
 a92af1059eb24-1b5568b3154mr12860775c88.23.1795459757933; Mon, 23 Nov 2026
 10:49:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
In-Reply-To: <20261118-ldr3-v1-0-6ffe43aa8c6c@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 23 Nov 2026 13:48:20 -0500
X-Gm-Features: Aa3M54ox4gzprm8cN887fGdOTEHSIvC9wS03LuY1pP81KQMR00A_HxkQ0hYbTvA
Message-ID: <CABdDSeUkt_s6PJ61Xq9Xc8aU6UG2k+dHOvCe8hCET2W2RLESnQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mach-sc5xx: Generate LDR artifacts only if ldr tool
 is available
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, linux@analog.com, 
 Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On Wed, Nov 18, 2026 at 12:47=E2=80=AFPM Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> The ldr tool, used to package artifacts in LDR format, is neither part
> of toolchains nor available as a utility in common host distributions.
> When missing, all of the builds of Analog Devices SC5XX SoC defconfigs
> fail, including buildman ones when testing these platforms.
>
> Indeed, the LDR format artifacts (u-boot.ldr and spl/u-boot-spl.ldr) are
> final ones and not prerequisites for other targets. Therefore, consider
> them optional and generate only if the ldr tool is available, silently
> skipping if it is not, without raising any errors.
>
> Align the CI Dockerfile, too.
>
> Note: the only targets using the LDR boot stream format are the Analog
> Device SC5XX ones, therefore the *.ldr make targets could maybe be moved
> from common Makefiles to arch/arm/mach-sc5xx/config.mk. I do not know if
> others have used the LDR format in the past.
>
> Currently, the ldr tool sources can be downloaded from [1] and built as
> done by the CI Docker image (tools/docker/Dockerfile). Alternatively,
> install the adsp-ldr package from ADI repository as described in [1].
>
> [1] https://github.com/analogdevicesinc/adsp-ldr
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
> Massimo Pegorer (4):
>       Makefile: Drop $(CROSS_COMPILE) prefix from LDR variable definition
>       CI: Dockerfile: Drop $(CROSS_COMPILE) prefixed symlinks to ldr
>       CI: Dockerfile: Install ldr and clean instead of just build
>       mach-sc5xx: Generate LDR artifacts only if ldr is available
>
>  Makefile                      |  2 +-
>  arch/arm/mach-sc5xx/config.mk |  9 +++++++++
>  tools/docker/Dockerfile       | 17 ++++++-----------
>  3 files changed, 16 insertions(+), 12 deletions(-)
> ---
> base-commit: 6201222134cd704b5717211fc917e2ca6263577a
> change-id: 20261116-ldr3-25540c4e1c14
>
> Best regards,
> --
> Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>

Looks good to me. Same caveat as the other thread that I don't have
the resources for CI locally right now, but the changes look good and
it works the same as before for me.

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
