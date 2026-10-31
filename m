Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CB606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UZopDx+Y;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jwQJMNiU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06A6960AE6;
	Sat, 31 Oct 2026 08:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpG0KOdmdhcH; Sat, 31 Oct 2026 08:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0900E60895
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436196;
	b=G61GOMk7DmZp/L2GPsn/kt3Ev3osYRyuwi6IG3iSgCyeiLaJqLQxC9XaCLL8b6koxGjN
	 aQ1oZqoGm3wAqc1T1S5jqS0GRNY69QgNgxQ3bNZ1btQfQtgdim96m4eqwfGaktmUpyldu
	 kmyyDSNu+RG/CSw/eEg8pGvLeWLujj6ru4BK3OQKO9fa37AC5WtWmJGkkepIpAqTWsPLW
	 wkNwJZyeptevLF5erXj+8kjxEiMBhkkSgQOigw0tgMUAYIVkMMC7B7T1tLSDLgsE7RJOb
	 AsIe+CXSIsoYBk+PCafsXc/aG9Pic0mfE6Wn6UP7rQHgGHTmmO7CQ5UeioaDCztBsQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=udlb6rKWKmcThJ3mUf+TIxARH2TjXqujU4KEfU8PwOU=;
	b=Rj0R0bWIFi0aVWYPaHc+pGWTuhMSCBjfdyvT7GqXU1vLSU8lUNpcr6K6Sk3yAuDceCZs
	 r94tcofl9g7YiIddDyFxTHhntZHZc+7P7HaZJvXHPgLWk0UESazrmMt5jLqVO5bj4D7i3
	 nJGsm1vcEufkJ5b71GUd/3IQJOyxrRG5KRuHXwSu9Bqg/s/d0WzWygxyVPmHt/tWe5vqg
	 va8LHdajw2l4OpygWzOrhihBWgkGX0E/hP4UV2frIzj6efbZbXCEqixiWj5js8TqsqPS/
	 yhIshacJWOpzBG6xBALlSq3xcmiIwrLMOqPyETDCwuA8uUe18NVDZrLxtD2ye7p/3fw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436196;
	bh=udlb6rKWKmcThJ3mUf+TIxARH2TjXqujU4KEfU8PwOU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZopDx+Yt+vyuJzCnI3/cIugHqNWwxsRnVXvHHuoukDLDaqoVFbl/j/keKX/kaNtI
	 7DMmtw6w2098B0GyRVlk5cqEPIKAPGIpwkAAZk5BoRbpfXVjJ6hSL5ddz4wHay70i2
	 G/AA4vX8Hl+WPHblC8SKWTX4Nu3LrXef3m+MLhecRJ0UpmuxDmybOzUfaGeuuhElbA
	 UT2RHN0pUjC9xkmwUIW0x5tUQxRHcniFG9VfQFerQMQcxcXcVZac8BvLXMtlp1h/31
	 z9R+UzUVkMd6AT2blzbF8NPF5XTMX/vEkP2otTo2cQCZtPUkorjPYFAA2qvl7sgxPg
	 RbrAm9ml0napA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0900E60895;
	Sat, 31 Oct 2026 08:43:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 42091380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27B2140B03
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlapX39kzInz for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66D7540ADB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436193;
 b=Y/Wo506GYPX6lgCq3fDUwDZaIPYnlH3mNKZgBvyVJO4S7T806ZxCwo3uh4YxszRPtNWs
 oske0lBkGup0Gh1x0WiWbf4YI8CrtUU+Ngea9PDs7wuRdwNii+aUYyjmVHhheKo6oDL+l
 cb26dPUu86kmCDm0QimkVLOGZmi8vguLznbZ0BAgiWJWeQqETlQFecCoxU9CxpUBTdJdy
 VsYaKwNivugg0qHAnjYuTmz/yBNwbW/TOXB8mup9xKpjAZU5agfRlcis2lY0La771+zvQ
 J5fPoK0dR+zRN0AUbKNsbeByVVZv0imIGlF5RZQK2vMSO4E5FOeMWcl+Bc/GcJIGSXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436193;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=udlb6rKWKmcThJ3mUf+TIxARH2TjXqujU4KEfU8PwOU=;
 b=VSs/y5oJ1qNDgjL3u1+ay8itqlmhDvoVhIr+xjUyl0QYnC82M8Umlc/JgyA0HMVS+BPB
 ILRytiQnT2XOtKgYklUhTmlDamLOL2h/ZHelTFU5YvXMWny5XX+nPZDu9lI0fg1HBv+LT
 yeEFkF249vFkfmgI9seJU/BUY8qtVXVBB374DVVvYTAlNjaF/bZnQMWYfsJ5+VEfTFwV7
 2REleQm+MMwl8SMyVhWOYxpeugXpkB1IMIKnBFPi/HuBbLXkwSbr3slJ290caqlsUP9N7
 WGL7YuiZDjYcJ8aIWBzV9frFs7TEZLfFKu9y0rTse/0ZIfLyYzDLyUaD1S3RWHJaLPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jwQJMNiU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jwQJMNiU
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66D7540ADB
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:12 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ad787b79ffso902002a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436192; cv=none;
 d=google.com; s=arc-20260327;
 b=AseNP6ZcSofOuBk5nnuS68xkkh1IRD9dC7Pr/qtjLOeQOlKNTU6Zb7aOCr1WAmoPo2
 kxkOe03U+VFZ4tBRxx6ni6laF7WddZxn2u62jr9fPEwLM0mcyC3/yPHCgCKYLRiJYjs6
 ZfOT9vBQ+JhdZGKMwNaKh/gqBC7D0r8ThJtvPGU96l3kq+BXoeHYcOoDoU6TgDwfF8Jh
 K/Cwzz7cnViGTqdf7d2E5kzfEV6e0l0ny5aqzDMTaJtcIjKquGiXf2fY+aqRN9mSoQX8
 NnCX4s3vtQz3EWOoGfqmjA+VFDxU2W+Vzbxn1F7vVtY1RXuPGUa71uwTh4yeD7emSIJy
 zwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=udlb6rKWKmcThJ3mUf+TIxARH2TjXqujU4KEfU8PwOU=;
 fh=vsf8uV1pw7SKUN2n3AaYJQa+/5bpwmvYSHb53t53wVE=;
 b=j5HajcpFXASS5tlc+c/M4OjkQuGS8wQFCJBwRp/OQmbsXtcj5KCt5Kp+VO+a5eMGto
 7MuXQt8K1YnUqFQCpWxq17Tr0I/7J66vB87mopbu2FxI/1Dnm+uXf6Eggr7NFqLZP01H
 HFodJp3fNiTDf/0kUiHYExnhF9Sbklh15NFpIJtE3oA3+DMhlWeno9LXZIToFaVInNr6
 1mAMlY3BcdA1KGYn5MrUc3mP/r2gy3HH1gl6mbWwS7HZ+vbEhvAjyo1ABV1f38Tal6gb
 GbXJad+IekyGQY9tW0U0m2H3dXRQtPOn/LO1wRCQPyCaJ+7kQeRyu6aR0yZsPRiP/PxZ
 oDfA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436192; x=1794040992;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=udlb6rKWKmcThJ3mUf+TIxARH2TjXqujU4KEfU8PwOU=;
 b=jwQJMNiUgncMsDroUPO1OF4mLik+HqqMW7rTFVzdVfks430hdp6/Pk7TZMYr3obsYm
 XnynNQMA9HFQjg0nhpe91O6VC10zrYhjE/0NThQ8qvOQH8JvO+Acx6XH8sowOOv9xyAI
 FswPsmImnPC/1tZJndioAuXca2U3Mv61+Ost4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436192; x=1794040992;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=udlb6rKWKmcThJ3mUf+TIxARH2TjXqujU4KEfU8PwOU=;
 b=2WLk9dSANIAhOZyujOVqcNSpx+1b+BppCIFQYBcREQh+zMSXCm359310pJ4EmUb38Q
 aFDkDw+ijBh285d7Hvknf1UQweeTCGLv1o9cfr8kXkBe5bMFVWaK1U9BNlQuC9hyCcNF
 6Z8+l24glZHyTHKTyy0CXkbEGNn+6YgdLzRmCp4nt/FDs+ChJy056mn0GcQZUEHFP7/i
 fbOH4LgAD3eb1Vdjf6Rj+xapyUg7MOUbPuXvv3OpkLVTCeoilIXgXGaEjR0Wfr8qWKJy
 QnlwkZ0L+BMYrkSBCJUArRIFUY2ERg2jPq2ol29y54ltpN8HdQn+bpCo+0ngSh5hAeHu
 /8ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYBYb8zJ7BOWT5YJ6ub/fQxhfIXL+V3hcrf0VtZtbDrK+tt8ivBtvRPpPaKYsY9wEWxgsoPyk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIPUmwgrZDpHN0Wv2854Enm7keGrbEdtjGVNfJ6VMYHUIUE6cRN
 a9tKihn75Zwcrr+fudPg1V7/hlSgI4276jfjVEHGCbCdgQmxP3EKVeM3dNKjuWaWvxRyAHqPzsN
 91j8QehQfb6qj525s3l9gRtQbo68OQVSur2y9D3ob
X-Gm-Gg: AYBFou3XLoFH29BCgsdxnTtmYONzP6GfD0WADTVRcUKYNR+eQjoYASOKTYlfEXopD/T
 hT+JKiUz3293SP09OIozVZND46l+voW2SRoCN7efbt4rjEiAn+aYviaWO3F/AUH3RzzU+yqxEuc
 7FFyCU5XbeiB0BQ/99AMCotMWKkHhVhBYFs+cnXrqH/iUQEogDy2rNeqEIEvR+GghfG1YPBDIgw
 d028WSLm+kWkuko7GNXnDv/vrID+ZWrqFY14xlxAf3OPf3f08tPuhoUuoN2vh+RhSn2tvW5mxQA
 BJ06d7O88l97+B6rJCZpPvaBi6l0XlPCC5K+xwFkHcY3MywSAb6JPLt5tpB1ziWf9AVcabJgzk8
 FowjxQCpxXKD0ic2kwZsPOdDDtPUfzc159rJHwxiDpQNwGMiKoig9KpP6Bu11IjUaIFB1ddU=
X-Received: by 2002:a17:90b:5886:b0:3a8:a98c:ea07 with SMTP id
 98e67ed59e1d1-3ae896f8551mr3546261a91.13.1793436192361; Sat, 31 Oct 2026
 01:43:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:43:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:46:19 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-4-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-4-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:43:08 -0700
X-Gm-Features: AclHuK-Byfu6Do8aXTplHFKrbmIUg4ZGT_aiCTuZ8suay9iYhrkK0IA6mA72djQ
Message-ID: <CAFLszThdS6tZ5Nz2JVQtw=NGiiSCxHwP+RZ+bp5ykNM84ouvUQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] image: Take entry point as an output of
 booti_setup
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> image: Take entry point as an output of booti_setup
>
> For LoongArch, the start of the image is not the entry point. Refactor
> the code base to allow entry point to be supplied by booti_setup().
> Also update the kerneldoc comment for booti_setup() to reflect the
> latest argument lists.
>
> Link: https://www.kernel.org/doc/html/v7.2/arch/loongarch/booting.html#header-of-linux-loongarch-kernel-images
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
>  arch/arm/lib/image.c     | 3 ++-
>  arch/riscv/lib/image.c   | 4 +++-
>  arch/sandbox/lib/bootm.c | 2 +-
>  boot/bootm.c             | 5 +++--
>  cmd/booti.c              | 5 +++--
>  common/spl/spl.c         | 9 +++++----
>  include/image.h          | 7 ++++---
>  7 files changed, 21 insertions(+), 14 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
