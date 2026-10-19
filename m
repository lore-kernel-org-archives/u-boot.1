Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F904CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59CA880F8B;
	Mon, 19 Oct 2026 13:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BM2UxpNL1u0t; Mon, 19 Oct 2026 13:27:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B3C980FF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416461;
	b=KFdHwKhYhOwVjpqfHp0EyLN9KjJd1Q/+dKjr/TLIBiGKp5i7zfTg6yats/XspXxkoIgr
	 DUv0go/ZwlLX/0bF1R1E/PDx04vOBKBRTQpcmZCtVnp4TAmXdKEiMV6X3trcjne1X13uX
	 BXcD+5svnmvwQblRa9aHpoYIcjzYyfcUVz6TDCOcssygn9LfrcL15f7y6+u5s2nFAgGgs
	 bxarS5FNxSmzzgjzEdOFPwwnFt2vF2IJdowiYy2/rdGGKsUvoyuL2XapcSwPMKibJSQEN
	 AoZjJIk+k/fvarQmMxty3joKsxzM40tgnU4JT9wYAIAu2t779T0TsIh670fMbbjH2jQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IduCf8tEnMSdCDjjUQDrOn0HbRmtquViUEbJehlAVbc=;
	b=jE7OJGPbOE7634zYmVQp0uS2RyU4XJYqF6jQrnXMTFDERSXWQ4vBZhgctIQqh6LLmYsx
	 k/RCnmq/keK9w2fYvWXc0gPHZ2XohjM1clmvbeB5ql10fsBBL5cDHsq38szz6nZVgSGv0
	 zEPqbI4zQFmWFXJUbderR8WhcEnC9FCAkJuvPOezH7UnEG1hTZ18rJVP+OXFklEGtz2C5
	 P6k56O1PtZwVBilmUsuOd5m8JfpzUeCIMp8QLxAYPudsFsR/4MYEXvXFB/9qGaN3Gh7Qb
	 s9bklLYcx+dfpJrYSdqC2RBACTfKlqyCGGUqp8Gyg/P1E+XUykgHW1xeRP4XbQcEbiA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416461;
	bh=IduCf8tEnMSdCDjjUQDrOn0HbRmtquViUEbJehlAVbc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lx1dAHUZTFr2VnLvdz9r7PLOx7ztjctkU53qz6nSE9z+Seir4z1wbiIseFam5Psn1
	 X6IJaDur1EFl+OtXOsNerRGNf6wMUef+AFnAmJclCyRNZ7uXvJjF8l+koxY7vv+sVn
	 ZIevTaqyz1rEBJ5H+3KxTu/sKmn6tYYlu1nJCXXKY/PPT4QO2dnFbOngYw8y5Nsmmd
	 Zvvuu9j/PStXPIJdpYKuIwGgmaoV5SgKLKg4zPO2XIJlkWA4iXJ6/alDWn8sqV7kNv
	 o/cPnCv4NLugTUlib4566Y2kT85y+pPwCjS1psYZG5JLLgYxd7Au/gqzyU5JZ/O2uD
	 if4YwtVQO/4Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B3C980FF3;
	Mon, 19 Oct 2026 13:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F34331E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA5C940049
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zzu6I1cld7Xw for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E1E1A4010C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416458;
 b=mXH92UIrHBmNwRWthkZhDNwpwPm2oKZ4eJXqUe9X6obZ/zXvZi6aN8EvYWe4/w12tEVQ
 pRBoyFmZNv92RQdxLyO25b3mWTckp+AA1KAnJ+PvQTFSgSLQvLgI9qIFz/TQqklqzWciT
 fIuge/nLmI9BoSHgEiz7Tr2txoSBYR+I/D9745jxExAwwIAIFdKgGh3JpIEwBluijv9Ei
 m3j8WeQfhTSl1vL2JNmHCGrPXahMsjThmmN8pgAQT1YqTihpb2bM9VzuHm1ijNSurg7yN
 qjgxCyavege79pa90jwekMedtYw92Gm+ucgOlcfRnexNcSALgfaz/BRyHYRW1nL4oVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416458;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=IduCf8tEnMSdCDjjUQDrOn0HbRmtquViUEbJehlAVbc=;
 b=Wsn9xmiphXkUmxQdqWudX4OriKca/LKcEEheDOBfUp4R6mldXKpDqs/i6d85x5k3ZhJz
 HBGV0/sBBhkxFrSY6zsAxFxvrEZQrvtmzyPiC9XFPHIXYDeOkOfG+zQcoC/daZADLKhXp
 U81o8sPLWsr6MVUCxv9SieaE43PvrpE0vrWkL3Y3dt3mFG6m5kBjgP0LbwLJpYqwQ1Ab5
 QUgBy3VJATMRN9g4kjzWi5vGYPB362416QJ2cCqAK2vnzyGGP0HXpR2ebE1yDxiE647Rz
 Z90fFNLzz0nz5MjDaNXFz0DhKuLMOHiV60FESo9eQc9ogxOF8OtqO2OQPcLorsb/cUw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h6g+fxHp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=h6g+fxHp
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1E1A4010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:37 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso3559538a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416455; cv=none;
 d=google.com; s=arc-20260327;
 b=ajASYjcMIVTwXqLZYsIjDjOUPAo8+aF1LR1uPxUgaC89VlSblrU2VSZJjSKgyXdqmh
 IePJ/RVfg5ZX8Kk1aZFdeEsG4pJ+DxmBT5a80s91MSqyUFBnyikkD5ivo63Ne3jL1EdP
 BBdlpo7vWSJ0cv1osG8JZfwWASuhyKtsTBB3lLP9Ak1FBLYT+/3fntQzeXK4mrySgz3d
 x6Ik7zs9HkC3cN7Lr08a984uLkac2IzyNXZ93CwFPs4tHiPMKM5EUZLoiIRDXHWmExAY
 N6u41Y6HWkkLdigaLXYE97wHfPY/oD0wUg9zZOXw3SCjf4irEH27Ba5TdAljNvlA6OKG
 x0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=IduCf8tEnMSdCDjjUQDrOn0HbRmtquViUEbJehlAVbc=;
 fh=a4zbmfz73RbDgWASpo/WaU9lZVz0NNAZouipGzlV9jw=;
 b=Iqf9ywKVi5YtowEOiNyHKuKB07K13DUC2JZl9LTlgwqlCGEKsH1qdUUtd4YVWzTUsW
 +Os1u4Q/hkuHU4pa5T1oHQmb0Lq2soRBSNOvYQZobNcl/ziDv8uaVUJIJS5yV2BE48/f
 0p5YTNBMeHsTGzHVQM33feyeNu0H3Z0jawsvr2HB/5qudDsbJWCz9FB7fmIr34K/LjA+
 yqNimHg/g8TJnUe5ynnH87Dc56uM0KJ8nrP5DYpuGnWKcgURvT0oUYLj0QI3HZQHWgye
 kDugxGRtDHS/O9Vh51bbCJOI33MdlpMZmp+aMUWtUC69OCMsYsZIkYS28k+MSln6eIHR
 Jv0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416455; x=1793021255;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IduCf8tEnMSdCDjjUQDrOn0HbRmtquViUEbJehlAVbc=;
 b=h6g+fxHpU7cIl5ZWQDBaKMVgpeniFkAwx+APvXp0QOPT1l7GacHKXsHJGh2fR/szyL
 zHm5wENwSGoXxIAn1OjyN9Tzbbx90oujIMDLuyjf9S6hiRsybVEVG7X4yt9qro7yfFwD
 of2qru8M3wRqJZTZeRoon6q+3G1ZfWmRhXg7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416455; x=1793021255;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IduCf8tEnMSdCDjjUQDrOn0HbRmtquViUEbJehlAVbc=;
 b=MZDqt14hslo6kqElXktaQ+LvGqlDNuKkAXHjoGZrLdychQE5ftaP+nSLyi+Qq108wf
 siBhlooT8URDZdiIc7tK7bi+d2S8glOuNo/gRAkKfJZs2yu0Qu1AKV5T2GQYFxuVmXgW
 w5tYVmuGw0dDaiPq4pIVNEZ5Pk1sRRj6JyWB9HYZIDK/j+G/8X+/tufBL6WM1fpvonua
 FDg886Yp1MdoCD5ZnlkjsYsCoiAMTVJwSKFHmhEykn9vB2g65sId+SZGSo9mVWbdlPaT
 I3sEfaNf4B5ktpHNw4PPk1QKOkYHp82Cm2JBiZR50itejrbv3k/2vqUeOhLIPbK0Hbtb
 TKQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkl2HJ2DfKjiXKFWGl6oyf/0Ay6FCmNnA+Iy9kgx5NW0KrJal5dtSReQV8vqPDbarqxSDFo18=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLKahAjqHz1TGeToF5leuDkp7SxsS55DbIYjK3GTQUtzoeyLjIq
 +uYhkKkJVLCUnwPGZKoQgQGefcJSBRjA9GFLYMw2HyegmQtCaA5bzRzJd/sAPnHA686I8ZXAWf9
 mRVJi1GrUyBbe66u1YzxbxqAMTS+SOhZxqarweOxrhU8FsNKDymcKAw==
X-Gm-Gg: AYBFou09LEYbdY5rupTTWCkT9SDIRgQYLnGU8CdFmVbshjj8gcysozAgBI+te1sKjlo
 FL1eEFWtIkUP2PVfHFJ2nxy1ux1kZppKIsnh3y7SHoWSbmeUcxE7MZoY8ASYV6hhbKjToGIoc11
 NIIwhLstMxPAHeyF6drTvdYLUqqW5ngdhwbHwPFTGAgXW0OcvmCsW3ZtzBUMXcZYosi0S14amcy
 iESDqhTmD1muX7B1mwopHICO6p+WR6ue0IpkLnWKZMSk7GhML1XxI8aIl3Pz2p1SQTACXOaF2Tg
 wzwZF2qycF4gTNVoYd4EgbSYTVItjlGnovQfU/upeCVjE3ctdHvrVw==
X-Received: by 2002:a05:6402:44c6:b0:6b3:af8e:c88d with SMTP id
 4fb4d7f45d1cf-6b3af8f0044mr3323658a12.35.1792416455468; Mon, 19 Oct 2026
 06:27:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:27:33 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:01:12 -0700
MIME-Version: 1.0
In-Reply-To: <20261016040216.3636305-2-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-2-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:27:33 -0700
X-Gm-Features: AclHuK8zazFDtomxR2XX8bJ1uh-FfvzlsjtQIre4drLOQf6twpCvrYS66H06wlM
Message-ID: <CAFLszTgxQdAq5Q0cFM4yHLt_mFnMWaUWrUgaWOv+cYTjzZUXUg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm: Add Google Tensor SoC architecture support
To: visitorckw@gmail.com
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com, 
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
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

Hi Kuan-Wei,

On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> arm: Add Google Tensor SoC architecture support
>
> The first four Google Tensor SoCs were offshoots of Samsung Exynos
> SoCs. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
> Google Tensor SoCs are of Google's own design. Add ARCH_GOOGLE and
> the mach-google directory to support this SoC family.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
>  MAINTAINERS                  |  6 ++++++
>  arch/arm/Kconfig             | 21 +++++++++++++++++++++
>  arch/arm/mach-google/Kconfig |  7 +++++++
>  3 files changed, 34 insertions(+)

> diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kconfig
> new file mode 100644
> index 00000000000..a9e605ebb82
> --- /dev/null
> +++ b/arch/arm/mach-google/Kconfig
> @@ -0,0 +1,7 @@
> +
> +if ARCH_GOOGLE

The SPDX header is missing, and patch 2/4 adds it to a file this patch
created. Please can you add '# SPDX-License-Identifier:
GPL-2.0-or-later' as the first line here, and drop the leading blank
line, so the file is correct from the start.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -2252,6 +2252,25 @@ config ARCH_GXP
> +config ARCH_GOOGLE
> +	bool "Google-Designed SoC family"

"Google-designed SoC family" would be more usual. It is also worth
considering "Google Tensor SoC family" since that is the name used
everywhere else in the series and in the help text.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -2252,6 +2252,25 @@ config ARCH_GXP
> +	select OF_UPSTREAM
> +	select POSITION_INDEPENDENT

Just to check, is POSITION_INDEPENDENT actually required, or just a
convenience given the BL33 load address ? Forcing it on means
downstream boards cannot opt out. If it is only needed for the current
defconfig, 'imply' would be a better fit than 'select'.

Regards,
Simon
