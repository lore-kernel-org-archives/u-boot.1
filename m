Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64553C55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 12:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2130E80E62;
	Sat,  1 Aug 2026 12:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7RpGkN_JjjE; Sat,  1 Aug 2026 12:41:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA0E980DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785588087;
	bh=Ll4UAZA76lh6hsVu9PwI8jl3rR4Qk4vE4ZInbvmz2m4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UBDes0MXmakh3JVkJ/NloprY3fVER3DIu8t7eEqCcJ1v5GCqB9iaR7yi0MqeARkyB
	 6eU1V1oYnCDsd82UyeyEBJbADkgFe7J2f7h0l/Bugx36ObNDrk8GNnU2+VfzyfTAOa
	 YawxOUmTbX+tBxclUcE0ud5gfGXHyQ01SxkhmCLM5UhIIO9ThvMSZvNNjzwB3+H3/c
	 drHwQbt03QZzvLZWmrTN3JRL2e3d1m2oIMmJn59zSDgbKNYBlpA9/BNE/9Hz1zoCaf
	 5qbvEHSkFfDvLBbGBwJqk6KzRWx+wtGAOUH63EeeXLzq/JRbTQ8PGOHDodM1s+9jOr
	 BH1EDo5OSzoxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA0E980DF7;
	Sat,  1 Aug 2026 12:41:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 375C42CE
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 06:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D5CD60B8F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 06:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j3rDJVt5SstR for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 06:57:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=bhimesh.matsa@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E78FE60B57
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E78FE60B57
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E78FE60B57
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 06:57:39 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1f5208b38dso319460866b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 23:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785567458; cv=none;
 d=google.com; s=arc-20260327;
 b=Hsi9ueMp5CVNVOro7gkBqVLK9mx0IDR5Qi1QvZiuPT8fjG45BpuQddK3ANSLAIOXjw
 0pOaLfgoBvwtCv2HK94HgfdGnEm4y9u4Mx/dFwQ11TKt4G5TnWzknVsQzByDyM9Bv7fF
 ixNodAAKyJ7qxIGGQCYs3SiVnvkEGSECzYjTNrBKS9XVO5diOtvjuNCYslC8Dq9+VqKa
 fcXMuiMoQEWi3qsdpixerBHxnwCaIzPtlED8vaElS3m71jMjK2ZF680TCKUbP0rUG67Z
 v/9iaQ3SOPeBpzzVF2b17VVWQwTjI4UVF73KxShh7x0S92aE1/KGE/5n6/8rUjBk0yhe
 THLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q26TQhqwIjRL9TJw8aACui5PQdgWPUfWuyskavlGiRk=;
 fh=RRJDYQqVcTb8Ph94P6kbilJK6WbHlrfVD9W1Xew7P/4=;
 b=hE9Ji5blQ+NdLe0/gbraOXGQtO1rtk5UjP66ETZnBSbtr59WlqW1qXeKuw63Rap2cs
 1r7uLJMyAEaHTSs2LpZwpv3BdKLO+JQcOpwxiX8LHOdqLyrFnYeD+Lc8Omm5oYIEm7zx
 XoWzSuljXz2lMu7yVBXQtr8s73elIuTZaARu/b+287YdL8GIRamwDWNvzbZAobLcOGLh
 9IFsPYsMpGpOuxYoHVEYZpADYmj8xHRKkNe+x1R8wMfuOBsStWyRBVzsL3yT6gDxiKuG
 bLO1AB2UXopJ24s4d+d7WlEymbWiMBdA6tkkQaZP7xWMwUGuKlIrXnFrIpBH8ze9Dh4m
 gq8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785567458; x=1786172258;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q26TQhqwIjRL9TJw8aACui5PQdgWPUfWuyskavlGiRk=;
 b=O/NV6hmx8oHRGtgau90C7PKiFEsjYVK2NU6/EbxLsfMY3GYKobnzfVeFaFzMMy3YrW
 QffNTZJHaGGmozk7wcND7J+lRUxdklDNbQ5YCfLr7KQ5Oa+hOQz4sZnAycEnjyIyiy48
 A/lDADLAxL9vPXD7tRwjae/oBFFMbWClllVEZEGkTMBmufGkh5rEGWjN46CaA12QVXvK
 nPUzuO95kyI/aUXQn/lPaf2iXdGwBtfHShCS2Plb+y0vwhvRGa81NUOmJbaizhmEfbjl
 PUPdKaaoFI7v5GJKLSYgjzgUFjDjwMn3x7dASB+RI7fGGAsQk4fHEPKs8D1QsZnpfgGH
 P67Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfTQGkzOzqgTxcQaIokHS88CG1uv+RLuxGub/h6OHSW7dvydj1o+mvH/ebLFdkNHt9UMAk9pY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzjmddSb77i6pdkynXQGsxVJopdks0o+vMnS+xe606mMoBEERY+
 YknUZfUBxVqZzTcz3Eo+oG32VfUvU3D0S26TbXX23Yf88Rve/CvMlCXc/wPqfNypKUOSkL9rhbv
 ofKx0oOzg3y/T70b+g5fRh1zntqoxkPUzbNAUHpbdgg==
X-Gm-Gg: AR+sD11iE9U5g3vqe6pzvDW7NP6c/gQS5S4n1SWZRKHhhsg6qN9ryO5Nl/AQkNVXp0b
 m6iyNknJCHMqCPVd71wln8awlqAkcpBRJF6NvYY6e1XcbhWTS/WbqFGUcpVP0HYCb82MQNhBWAQ
 bH7470HE+cqzFrG0icrtgFZGyJE/4lA4V5ov+vBPxhJrTrgZduGiKOVLVJNbWpUteoZS3WfMlLz
 IqjAeS4tPt7QvFHQHAyBX7RbJHAtFy2dePQgcsr3bmf2IDD33ys84owNowsFeQYZHTgV3Y48iYT
 cx0Z7kei57nBZ+elwa+NHZBIziYRaZb6leaulmoJO8OGipkhtNkZP+wgBi6yLjTzx0k0PLGdEJl
 udFBKNIVK9tQnP7Tky/nuzaU9KRF74iEMJOARMGIT3Qk=
X-Received: by 2002:a17:907:1ca5:b0:c1c:6f0d:5b22 with SMTP id
 a640c23a62f3a-c1fe7ecadcfmr176893866b.11.1785567457633; Fri, 31 Jul 2026
 23:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
 <20260731125133.10998-1-bhimesh.matsa@gmail.com>
 <GV2PR05MB119411F0042BF3F6705E81E8E83C82@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB119411F0042BF3F6705E81E8E83C82@GV2PR05MB11941.eurprd05.prod.outlook.com>
From: Kumara Bhimeswararao <bhimesh.matsa@gmail.com>
Date: Sat, 1 Aug 2026 12:27:25 +0530
X-Gm-Features: AUfX_mzHLarAJaF1uZkCMEFvJE5oQTKNd_cusVb7jXpGCMFUYCYjmLaYWYn1VdI
Message-ID: <CAKoOE-J==fVUAj7uOjrymrOCoQy4=cKDm+Kj275+SvW-5wB05Q@mail.gmail.com>
Subject: Re: [PATCH v2] power: regulator: tps65219: Fix LDO selector boundaries
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Approved-At: Sat, 01 Aug 2026 12:41:25 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785567458; x=1786172258;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q26TQhqwIjRL9TJw8aACui5PQdgWPUfWuyskavlGiRk=;
 b=Saxb4yMPoTIfFplD45pBLgWyOdy2oQFBSFnp5SuJiIHUoDvRlgeD+YXLHr+3qdMZRK
 lyu+o5QXscSfj73KHOagpmAUypNWL+tKJ8vniIdK0758JjWZADlX+CUKCSTO8qxYYlyz
 1BWbW0eohD3JUhbrw6373C+k8TtfG2PnS2tET9mzJsXCuBFkKs48mzxpppYNEoLy2/0K
 JNLKgJmaJ6bYt0MwBg1BClhDVz6KrgI8MirW+wqkJ/Gt8l3ze7fyQ9POKcdnv6DuUR68
 3dxQBq/eyyQS9LXC9zowOZIpGYmjphxgcHKUq8SlHVbW0qmQLumTm28jMhSvk/hn8okJ
 pwyw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Saxb4yMP
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Maarten,

Thanks for the review.

These macros are used as the saturation boundaries in
tps65219_ldo_val2volt(), which uses:

if (val >=3D reg_max)
return max;
else if (val <=3D reg_base)
return base;

Therefore, they represent the first or last selector in the saturated
range rather than the numerically highest or lowest selector value.

According to Table 7-2 of the TPS65219 datasheet:

- LDO1/LDO2: selectors 0x38-0x3f all map to 3.4 V, so reg_max is 0x38.
- LDO3/LDO4: selectors 0x00-0x0c all map to 1.2 V, so reg_base is 0x0c.
- LDO3/LDO4: selectors 0x36-0x3f all map to 3.3 V, so reg_max is 0x36.

Using 0x3f or 0x00 here would not correctly cover the entire saturated
ranges with the current >=3D and <=3D comparisons.

Does that clarify the reasoning behind these boundary values?

Kind regards,
Kumara Bhimeswarao Matsa

On Fri, Jul 31, 2026 at 7:51=E2=80=AFPM Maarten Brock <Maarten.Brock@sttls.=
nl>
wrote:

> > From: U-Boot <u-boot-bounces@lists.u-boot-project.org> On Behalf Of
> Kumara Bhimeswararao Matsa
> >
> > According to the TPS65219 datasheet, selectors 0x38 through 0x3f
> > map to 3.4 V for LDO1 and LDO2.
> >
> > For LDO3 and LDO4, selectors 0x00 through 0x0c map to 1.2 V,
> > while selectors 0x36 through 0x3f map to 3.3 V.
> >
> > The driver currently uses 0x56, 0x12, and 0x54 as selector boundary
> > values. These values do not match the selector boundaries defined by
> > the datasheet.
> >
> > Use the correct selector boundary values of 0x38, 0x0c, and 0x36.
> >
> >  #define TPS65219_LDO12_VOLT_MIN               600000
> >  #define TPS65219_LDO12_VOLT_MAX              3400000
> >  #define TPS65219_LDO12_VOLT_REG_MIN  0
> > -#define TPS65219_LDO12_VOLT_REG_MAX  0x56
> > +#define TPS65219_LDO12_VOLT_REG_MAX  0x38
>
> If the maximum for 3.4V is 0x3f then why do you use 0x38 here?
>
> >  #define TPS65219_LDO34_VOLT_MIN              1200000
> >  #define TPS65219_LDO34_VOLT_MAX              3300000
> > -#define TPS65219_LDO34_VOLT_REG_MIN  0x12
> > -#define TPS65219_LDO34_VOLT_REG_MAX  0x54
> > +#define TPS65219_LDO34_VOLT_REG_MIN  0x0c
>
> If the minimum for 1.2V is 0x00 then why do you use 0x0c here?
>
> > +#define TPS65219_LDO34_VOLT_REG_MAX  0x36
>
> If the maximum for 3.3V is 0x3f then why do you use 0x36 here?
>
> Kind regards,
> Maarten Brock
>
>
