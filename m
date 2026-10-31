Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB38606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tzq3S2Ru;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NeOxMwNI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DDC0605C7;
	Sat, 31 Oct 2026 08:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rk3HdfHTdg5z; Sat, 31 Oct 2026 08:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 788B56079D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436805;
	b=RgGia6o1Oc3e5/qRO1PkMhIW+pBi3RUYOw0sChWTahWmbAyWdCtCyf9/SvZC54mBoWy/
	 VtqeiCopv0Rzxdl1MJrc4hjajMYnfoXwkcwXy8NI4JhPAw61A7entdYGvUGkIgSOvClqh
	 +qWyhd9swQt+pCuVB2n1u7Gks8o06kDzDBjrHIaBjSdqTgirGaDm5o4f+Wh4KJ1ALKg+E
	 iGY+Noi9V3fRrXkniD8bE5UPdZusmQH9SXJ3JievqTJ4cwa4Z51T/P/1Uhez/y3N7bAhi
	 N482FSFdXkwkjVPeAkuz7s3Ouo+koPNLBfeLgTh/ztR9/o0UG0XvFEmc7Obk1FNJUFQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1l/hGDfT3DIkMozZOB2mo1S8u/AYrNanIxTFOvaBySo=;
	b=bKQOqZRYkhy1Cf0xLjTCm7iv/G80uEgLpcu/e/FOHON1noK4W8oJSTrm6MwjOZ3oonum
	 1NmtD9fOj5fCCTDyHL5w4DQsp/X651qH7tGcUnj9ObHQp8E6w5cdB3LSnOte86W+rM3YA
	 c8lP++GOq08OEMPspAFPu/ln/w0chEkhBsQPm0U1KaczyQoiyc8+72MVo7s71aIOUBc8G
	 ZY1dpHFBtTFo1J49XZ96zlyAkY8QMyfUC/KWiPwZAAroy+Ux0C34k8xT1Sadayhbz9JjT
	 EVOwzQiTDd4JS9qOia7MxGAGGTjv+gyYTjEi3lDt0e2qAOdEE4ZC1DXz55NxHqAromA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436805;
	bh=1l/hGDfT3DIkMozZOB2mo1S8u/AYrNanIxTFOvaBySo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzq3S2RuBtgGl67GBFYtHZcNUI6NHIZXfg5SxbQosCCc8NZaKG3xmp+IlPkYc/l2Q
	 prl7YHKc3yatfqv9c5AG8Qeo1B/GXzmRqD1Lhm8RzODsdv/2TzbyAh2PncJ0lKwnDx
	 lULnloJyKSVQVyNcCuqp93cAi0FJNVne/hfPOr4+6fVQ34hqK7B2SLCtEVBMBTYhf5
	 6ms9hNdElHyGND8+O2+7oFRVyliTsI34w/IdKL58UnclGHYTNi+YNdfwU6Orq54u3E
	 oNc4tT226MmlFxWKq++IrNkDTHFaKTt/Tnmyp6WBfwKeaVfJTi+JWalqrz31haZgoD
	 xIWPsQuRFkDEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 788B56079D;
	Sat, 31 Oct 2026 08:53:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 612CA156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E6D481117
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9uNyzpPO6srX for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:53:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2ED281116
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436803;
 b=sUPATs2ij9xQsvhtZuyWbofH1kjL3vhK4ByW78bAM2a1leUMW9id2Jt/hXWSbaariLqt
 CREO8Iabii2Z+tqLE5oaZRdXrtekFXXaAXPQ/dxk31OiZeGLFfrxuVbc7T0m/TVIa729d
 5Yo/mX35rZ3XvBDHfY1F3h5KEcbRQCnWJ+CyI4Dyd3RSiqv0js5MCycY3dbYZv2AY+E0o
 lWVECTq8UPp4NhBt5FVMSLQq/VN3rYAr2k3VcmRWX0doACQGyNe+hVRVSavnFdXfdmmRe
 1epySbiJPCHI5xiLe9m5DtC8czBi1hcyAeBc10WcJlruloeTA6C7bkNs3P9df5Cjoxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436803;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=1l/hGDfT3DIkMozZOB2mo1S8u/AYrNanIxTFOvaBySo=;
 b=K0FmmBLaP+KK2+qyAjbQT89jdbuzMs4EL3tefqUfcOB9MFyP6gjYtJmRFgIThcXKzRFX
 6ncEdmB02an1BtBhkZT1T3R7VUgSNEX9sF0QUPHS0CWwANBy26uHlTWbtp3620azEdE6g
 9YWfEoVexWaU83XKgEPpqBWrRVSpKb3dpmxt+2KCy2v+M0t5BlmH9X/0BNzOg2iR1XI91
 wrZRELEGKBNZHOXHk17ShpPSO/pGyGiReP6H7g9kpecIA2DgAkvydYGcGqfzowZjbdyTP
 FA8RbWJ9Ur9qgclhTJ43Ic9lD0/F0awVaLi7M7RdTYOAOWF0lpvZ14VB1RgZBYBKC7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NeOxMwNI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NeOxMwNI
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2ED281116
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:22 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so605338a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436802; cv=none;
 d=google.com; s=arc-20260327;
 b=YLlTIMGUjh86/p++x93agrmM+UmGVTtZea2vwxM+D25pisF/Zv4Fq5D0GE5/yJX+79
 fr0/JjrXfjpVTCKB1D4EDXq/cvRhekGoWdGQ0UGgj/LyQci7D5eQ3prHizle9+l6uKUe
 yoCM0jHEpmiLm2Uii0ObC6boiavV/q+76Jtnz36NXYyfId+BW6tpTSdcNnggPw5DgfY5
 OYsYqU/9sYxTcMa3M+PbZOp7wqYeYtd2WTuBKNUSsNigK1V2F9ewHUKp5QIu1lMyoM+6
 H/4b8UoVlVW5WyP7GZ4XufxYq20g8aR5s8Nu53E6EzRUYyzIgxdprBCVTnj0JGQU/ttm
 s5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1l/hGDfT3DIkMozZOB2mo1S8u/AYrNanIxTFOvaBySo=;
 fh=14V5QZ2qJWOmkUpIay8f5wLH4+hU5ubxJ+YNB0Krams=;
 b=J+k2g78HM9fxUQ1HwmAixzGgvwQNBhCyIJcgveEm9VNX4jkqjVBYxt+Z28iGZ/juSO
 25K7akKj4WGMRcMS7SJ2Ho0yqVAzx3+Ts1k8I2Rk2b8RybFXFYsv+loLsxcEIMMW51Fb
 hlWta1yGjrPjR+/Ej+fR50VzOelTqE7qoQDD1NoXNy6JZUz4M/xh+XMD02OaoFY6JRow
 lMHMuZ3Gc/7GRW+8fhYTxVDG5cJWUSxO22gcJXn7y4U7+avh9GrTxvJvgz5Gwy8G/zyH
 ERmkd8Ocx6qKhdiq7EkedhHhBp5wZ3iHZHdmTGwfmoHUiGeeeYY8rkD6MfAO31VIn5Cu
 njhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436802; x=1794041602;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1l/hGDfT3DIkMozZOB2mo1S8u/AYrNanIxTFOvaBySo=;
 b=NeOxMwNIUQaabERJtD2q0xipxjxQlRb6wl7qAoOXZz9nr8qJ4b48f+cnS4nBmRXhBO
 mZxsN7CWm5JlbJ5xEGk+K0kpbz2PyxL3V4+8f+E1fCfId48MPeh53T63WiadDp3ecpTN
 mb+QLgW83WPuapJxFfHuSxICwiwFhT082w7Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436802; x=1794041602;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1l/hGDfT3DIkMozZOB2mo1S8u/AYrNanIxTFOvaBySo=;
 b=TaqicsRC0E3epTVRhKAj5xu8Gbeud0BjzlfUJbRGNI6JhZbRUZJPYardm1wLSDFY4Z
 6x825LEzWe33Ifok0UhYQc4OfT+hEhG5jVQecYiQ7wP8BHqsL8VVCeg27bkABwM2Mmcu
 z9ZoNDp/UclOGsuY59HC/kRPOHU66hR/qoiNrFUdT16do4BNOak4voOKzbU2dtaZ4bJr
 dTICVQy/v0BGNO6B6TJ02ouCZquaHdI3ErltmAFolqwydEmh0NoL+O20w/b2P+u3OKQ8
 3ViTGEZOMpYFvt5ZRPyzrxg9xlzvbOf5lr2cN+OEBKOWpBnbzGj3xeuEHW2TNcB4qYp5
 F1vw==
X-Gm-Message-State: AFq9FYKZhIYLcRdiTQlsLmiU5BEdDM/tzWp2sVJHfPv3zhXJPnK0ZQ/G
 0dbWqas8DHuAZqoLessJhnCYYV4LymA/e2F3r98x2KhYRxAWAPzDIcdrjFlEimKa8hdCfYG4+66
 +RGdu704Uk6hLYTK+CIPXev0FuuEl9HKtUA7kajBN
X-Gm-Gg: AYBFou0E2gA61g46VW6udC8Iw+flp53Bq5NxHZ1F6P4/rA+eERfwZYka+6veVITSxnD
 i+JJL344gxiL+PeISiFWIYKCTcIx3AWDxOg90S6FcT5Gvo3ICbnaXIOAYUmJSOAAzCIgAv7h7/3
 sAHgNle9ekCCPcxD/srggrOWGMoIMJ1ZZI+TvP09sddG/7NQwQlav91P+7Kjc8L0RJL4NWyUw4G
 Gy0J7Ee8GmnMVt3J9YzfpAX1YYsMsYQSSR8JRXCox/BWPjzNHOj3UtS+hQwq+lQJMB4A4dKZqd5
 0uPNVAUrb6ek5LrlG86g0SCECUksfY0rsLRLmE6ayNGPCiMlNnXnrwJll+opbc20eCUP5dcWE56
 Z3WieHNmWE8AvWd4BzkBC8x53wRwJMs3BynXtRKdjovvui9XSEr0PWbk1YBiEfeha+PERE50=
X-Received: by 2002:a17:90b:5847:b0:3ac:17c:6e89 with SMTP id
 98e67ed59e1d1-3ae89773f17mr3614616a91.19.1793436802413; Sat, 31 Oct 2026
 01:53:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:53:18 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:46:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:53:18 -0700
X-Gm-Features: AclHuK8x9TkemZm8vvVFEY64412yNB1_iOWmikWQMvMHgkOL627GhZphwwbRNVs
Message-ID: <CAFLszTjVQ7YB7eHL+BTy0G1wQ=B7H+i2+wvoG+97g+et7MP9yA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mkimage: Accept .key and .pem private keys for FIT
 signing
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-28T10:31:01+11:00, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:

> Allow mkimage -k to use either .key or .pem for PEM-encoded private keys.
> Preserve the existing filename preference for backward compatibility.
> Try the alternate extension only when the preferred key file is missing.

The fallback logic is now written twice, in the ECDSA read_key() and
in rsa_pem_get_priv_key(), with different shapes and messages. The
only real difference is which extension comes first. The rule (try the
preferred file, then the other one only on ENOENT) is the same for
both, so should be in a helper shared by RSA and ECDSA, with the
preferred extension passed in. Both are already linked into the tools
alongside lib/fdt-libcrypto.c so there is a natural place for it.

> Binman's FIT signing-key lookup still requires <key-name-hint>.key.
> Support for .pem files in that lookup needs a separate contribution.

Just to check, is there a reason to keep this separate? With patch 3
binman can sign ECDSA images from a .key file, which is nice, but the
.pem change looks small: _get_keys_dir() in tools/binman/etype/fit.py
just needs to accept either extension. It would be worth adding it to
this series (with a binman test) so that mkimage and binman agree on
which key files are accepted. What do you think?

Regards,
Simon
