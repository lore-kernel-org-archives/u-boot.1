Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A1606A338
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oa6c/bM9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c/hekSP8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48EFD6082B;
	Wed, 21 Oct 2026 13:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnmxmziFKYaU; Wed, 21 Oct 2026 13:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F99760844
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588408;
	b=pp2nyIcsuw57TKlUv/EWUsfny5vKuFfGcjm630MiF23uYLzJfDM7Xg/IaMcP4yC7lhJg
	 ArcxU4nrUod+NX33kleV6dzMbgRNjGQ7cZfrzxlMz4y+e0aMgtFszo7kIU62XFZNREMa1
	 pQv/Nkb51SMx4f9Fk8BkONzJNxhx68PQyyM/ptlVpSyyK2s9zy+td0lJdYkq20Qzn0VjE
	 /5/C5QAC9XuNz9v7hluPTX/VGXCkWbCluk9GhhR6OQ2lHVHKIvmxGJLwO+YWFhB2Er/6e
	 JrbnisEzLxUIk2zzBSNdlxbiNWGODZdLYK+Y3PZglFEnM29VXLfTjTxoRrJE+xuEGwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9gZ99sjorERU/ngMkPyz9Jdtf8E3HpxS57C7oDRmXPI=;
	b=J24UEPilN5KECI/DIuaqFcBB7RQCBK7MSrAgJYEVnrudmby5HHqHZ12c08NteuwWeB/r
	 4qGacnp3u8hilU+mC1CL2y1jIO0T6ScFNzQtrRs2rXj6l01WmiLYDfe/Q+A4Xq/UKh+aD
	 fV2tJtF89nOc/SuJ3aAbc8vksmD63vrh7sbznFuBdSogkjmKtxRN0252WlX+19oxTful1
	 9glRQ/dfQqqK4OaPjr3kaB8WrbS5o/MOKoRgG1nM9bySTAZRgxQ3gUlAPbak0AjRkIDQR
	 cTq2+NiR/0dXeL/dm4fDQN6CCkqvJBRmx+9gczimxwkOMB76VXS1um08h2m+oS8eoTg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588408;
	bh=9gZ99sjorERU/ngMkPyz9Jdtf8E3HpxS57C7oDRmXPI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oa6c/bM9E1riWU2QlZI2YnmifMrGAfFkYrDe3x+pa/g8RdmcuHCMM78x7/I54aJ4Y
	 akk/1drdTIab+/G98QKH4zhfu1akuUmIZ+G+RC4lQGWbVdEx+QM3LRkNTcF7V8kQWs
	 FHb06+wfUpls0cU4onDc2N/35JuIBrno3nsSGr/wGnPeZINkB3s3guYfvW4E0Mw4J1
	 cQzebJqidVXBKXe47UYYMZ2mLipptvW1FE1KIm3DllnBXDLGU5InDciY6Uyz5ptVB4
	 lMRQyLvQqVhAnEzVbdLvJTBup+Pv00Lh5cvE6T3hfh1rq5SYYT+NjzTIf3Y2I+USNY
	 rogIxejnIPnTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F99760844;
	Wed, 21 Oct 2026 13:13:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0218930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D623B40895
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apPRkYwJE1Dx for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 165EF4084B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588406;
 b=QU3hTN4KKp5ZFCA6J6NREANt4zF7BaVzpkSqBUevDxiAKZdmKbj3Tyh56c+wIoXJWdho
 +tE5u5Y+PU1E15S1GNxVBHkDkt6y6jxU3CM3EKH4FwiZhfXsnixRvAp6IJ1fTH8iB6BI0
 g69jzQyiTvBEbVc1MIrdVVpXPX5XQCH+mH0BQBq1TT+8QWlUHNG/VVEtit5mxp4Z1PpTL
 nsGei/pvXkvQm+lZP9s0oe1JeTG2TyVAbaZMhgjmZ09Jo1+jnnbt5UKshTDbwOGlDE0jx
 plDnOE0tvPXEr8IC5r8+ImCKxOId8fbbF5oMBayL2K9YNLd9Lwj172wHDshElfmmx4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588406;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=9gZ99sjorERU/ngMkPyz9Jdtf8E3HpxS57C7oDRmXPI=;
 b=JFbzxjQFEdTJJgWq2zEL9jjDlgNtHFCD+TyT3mPKy+qqwR0YCKRneSxgOest41q12bod
 CcfmqhvqFQehVqyPYfeIU/upWxtXUDFNGqgq9QeEKR3n0dLFphjrchACIO5jCKV/57Y9o
 wW4J7CA7uTDjn0+5mh7GWZxu7Ug80hO2TzCJ6MGD8TdEtR57kq4fTu/J7c+p4mym3HNn/
 QYWF4ON35Kl89Rs01obPKG44HeKGKYWKdEYUzrrUHeyk5C6Tbn7ByxwdodLZdeptj+wfz
 f/pt6VWquxcQr+TZF8pnnI1axBtQfkI9+xOJjze1yBoX3quDisnU1uIdreB0IkObecw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="c/hekSP8"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=c/hekSP8
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 165EF4084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:25 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so387424a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588405; cv=none;
 d=google.com; s=arc-20260327;
 b=KjTDHb0D4fC832KvDfetqo2MAJwPBgbwz4aFLqpBIbDFn9ebRWsgUkbud0xpKS23oa
 u2dltg2V45gTVdYss+TYYBNV0Bvqvo9fx4TgQnCrOA26k7ycfZkh+fAIjjf8Z4XysVjy
 X0WFU2N4K6ix8+pCOmA4A0hi6eTWJ/KcqVu0JMep6DJ8ZUOyXz48oOn8y8dWAZu32rXV
 ZE9MVK/MO7afxEDKWPH10BRjUslCymB7EOI74q7IaGtA9II4R8c9dLFJCu1LLc87czPr
 dxG9qHuuYY+d4x7gCElphMuiuAUVWZx6n6i48o0wguy4eeoIQmzg2SJ0dkulQMLtg5Be
 80sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9gZ99sjorERU/ngMkPyz9Jdtf8E3HpxS57C7oDRmXPI=;
 fh=NE69m14VdS+iLI1i0Nk+Z7UEeZ7dZqybdllMvaA72+o=;
 b=KeIeVNWPv0i+VF7xAkp8acNvJRMmSoXdkWNf9z/kgzkCV7hEZZrhaMIyRA/Ppa0xOA
 tJp5/SqbTd9wK+el72waabfaKBle17oaGkzvI8/ecFNCkTAmTyyEwBp7q0sCdUF11Uen
 qxYpZUA5wDvf3bblD27wPizIQ9HfSQkUxRqsqhsKcWJA0SGtd0zxWS5UQuHGcPDC4ZAj
 YgHfhCClY4N5ZppAh6CjNSjpxyY04YtY9TQ15GGfT9UALXiAsfbylN4XmDnAcIGZIEO9
 mkccJ7zbmBapJYiSrQK3YzRuzS7B91HYQuqOju2UTtXdMfSBQCfhUrD6zpeJd8I+WqEA
 LzMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588405; x=1793193205;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9gZ99sjorERU/ngMkPyz9Jdtf8E3HpxS57C7oDRmXPI=;
 b=c/hekSP8PLLSsZPUkJ0dfR00Rs1M+yCMV6P5UIqwkYwy+wqq6eI/JBOqsP5IMekhMJ
 gCJehq7lPCNfKVItVCtwxV7R06Uco/FHEK+895ieeLYJ+TSUInbravBfJtvIQppM2wox
 ivFmmlKdzijLicCSCLPteNsar7N69jKqsbiyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588405; x=1793193205;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9gZ99sjorERU/ngMkPyz9Jdtf8E3HpxS57C7oDRmXPI=;
 b=Uq6boc0sRXBDx+EqMSwjbexhH4G2I17yjOIloRV4DFJCjvBfwTYrJqnWS9lXI1amAI
 2YGKi37CZ6QSL8IjGTWPEEfUbB+L6FTqnC33pForzsO31a+ApIgY0OrjKoak1UpWWM3f
 dMTzVJwetnSn7Bn73VeNmwcZQalSD0inlb+8zLcZXuCuGbNwzAYwTt976oGcxuUMcEy8
 YKUppaqZPd3k6KohYO9Ixpwsix0oYF4VNnOd0RMuWawPjTcfl7ktOJdgm0obGj42snMB
 ut1mhJMS32gf/7mIl9gMohK0daZp3r9mlJh8tw7EvfyQ/QAE6rSNMcsYkzYNAaI9ITKR
 KT3Q==
X-Gm-Message-State: AFq9FYKzVSMhWY4NPMPlSuN12F/3RZFTkPJcNiGpPqPE07vqmHUe+9e1
 e3rCdemaoQKwq/Ol68Zcon5vRpB0xJ2KYBOua8kGWupDJu87H7YgI7HBJhgMZRKdi2/hvFDjI3M
 1FrLnMQ//J564km3VKyEse5Gut6WfXRTvI1LUki4N
X-Gm-Gg: AYBFou0FwDnl6Jiwgtv+yaomciTHcrGozuKyJz0Efg9QxkRRl3PUsJbk4KXMdygIQqk
 cK1FNtnSsrJT5jnofqcUsHZ21YAoy1xmJoG47Sc384yNUyV/UIddTShkfYXqoDERgI8RGJ/cOj5
 DewlFypD4kZJlr5+AhtX1jbSGPRqSzXYgyduITg9whxgNee+U0saLfsq2nSTbPr/xgKIQ6T8AVt
 kpLclAHzSYV5wx/QdduUfHc3tEpAb8HB4bVswnokc3+E7Hfups+KmLzyKlOALJU8PlzTbiG3t+0
 3m6nizpyFVL6ZmbCpu+nOv7sQFSP/boOCdqVzfLLIM5ySvw6mir3BMJoAK9Oj+yJD+hN+MP3TUA
 OVC/KxFhctbeKw8dTv05dgk+gd2Gv/MK0VuI=
X-Received: by 2002:a17:90b:1810:b0:3a2:bb45:d37b with SMTP id
 98e67ed59e1d1-3ad86cf2c9dmr1644783a91.25.1792588405073; Wed, 21 Oct 2026
 06:13:25 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 15:13:22 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:29:57 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 15:13:22 +0200
X-Gm-Features: AclHuK8Zzd4U3wUSx77qDjIGlxsGA3idW_Y4NPBUdT4quBFeX51dTY35RxzQACo
Message-ID: <CAFLszTjxHLcG67khAjCSghXY3QQeM+C_FQbs+T99rkB4gxYsHw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Improve logging on missing uclass
To: jstephan@baylibre.com
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Julien,

On 2026-08-24T08:44:18, Julien Stephan <jstephan@baylibre.com> wrote:

> This series improves the situation in a few ways:
>  - a new dm_err() helper logs driver model errors at ERROR level, and the
>    boolean DM_WARN option becomes a per-stage log verbosity choice
>    (DM_NONE / DM_ERR / DM_WARN) with errors emitted by default.

This changes the default for U-Boot proper, SPL and TPL all at once.
Tom has already hit the size problem on am335x_evm, and I suspect
other boards are close to their SPL/TPL limits too. It would be worth
turning errors on by default only in U-Boot proper and leaving SPL and
TPL at DM_NONE, so that boards with room can opt in. Before v3, please
can you run a size comparison with buildman (e.g. 'buildman -b
<branch> -sS') so we can see the actual cost. What do you think?

> Unifying it into the new choice, along with converting the DM core debug()
> statements to log() as suggested in the "To Do" section of
> doc/develop/logging.rst, could be a follow-up series.

That is fine as a follow-up, but this series should still document
what it adds. The new choice and dm_err() are not mentioned anywhere
under doc/, and doc/develop/driver-model/design.rst still points SPL
users at CONFIG_DM_WARN as a plain option. Please can you add a short
doc patch, perhaps a few lines in doc/develop/logging.rst on how the
DM log levels map onto the log levels.

Apart from the CI failures Tom mentioned, a test that checks the
missing-uclass message appears with the default config would be good,
since that is the motivation for the series. It can be a follow-up if
it is awkward to set up in sandbox.

Regards,
Simon
