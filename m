Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D8C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7643E88667;
	Fri, 12 Jul 2024 13:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="W7hX64Q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56878871F; Fri, 12 Jul 2024 13:26:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77C987DDF
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so15060895e9.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1720783597; x=1721388397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nlQJnhm7oHKOx4y3J81HiIEBoRQ0JhLqSuKD8c6FR4=;
 b=W7hX64Q/S90a1lSc4jvz+sJTpUrWUc8WrFAPeE+ZdwqaKixIEPbqskbQ+Ye+r/H4np
 c2FzqjDL+eEDWXEy1/thWP1TYLWjMT23bSkMrctJ6PdR8OkGlHpowmce7tR3ISbE1kBG
 i+sXv0F1obvJGm483q4cY3QnPwvKmoEpsSYGHHmu6ujwUAa1b5IM+e8shSZPFmfYJo0m
 Ex7lljLKhnIGnUliXhgNbUfvNInmSj1PLqc057G1GOkKUo25dp0dgrvVB4mCnezFKYZj
 4H8eWz2mWzLPrvk55bGv3qguxUMGR8b3sSleAPpg+BQSoOeNe+TafSmRtklDMQsgiMSG
 5oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720783597; x=1721388397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nlQJnhm7oHKOx4y3J81HiIEBoRQ0JhLqSuKD8c6FR4=;
 b=uXQvXrFtt4qym/esBZpvOkS6jgeomE0eBnUgb0f7HfsrvGr+keHlqE31SmlVDXcOX6
 80tVgI6nZDEAeT5F8BpWH9QVJAEJdWIG7ujvPb9/iblNTx6nqj2fjsPDX1qL+xLb2fn4
 tRvGvj19D4GhpDJ4CpLJFlpceZdH79KNiMlipYkSTLblMDLYHauiSho5nty8g+99Dlhy
 cLjnd4pgRlHDBz9ayOYdVrHRtmZkhR8We8yoFZ3EN5/Z3JJge28Tzr+Xtk30FjocGZkc
 oMQYW4r2+yvBkEREdy0TfnSeAI3UtBAYLiB5ZH09+q6eV6NHjfj+MYQ0G221l44pBH9k
 laMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUied31j1F/+5KqDVkDUynLf5kEvpIDWQqHtRxZygEOxTKXPqxhtOdpnKOYxwj2J93UE8ybX2OxjGxtJSJcF3KKQlZapw==
X-Gm-Message-State: AOJu0YzrH4OdXcBn425YvbfExrbnxsrEq1bxwYcTHVYqvUYINX7xVQZA
 SjtrDuBcumTS0FDB4RyS2sR23y8OKsEdYiVjdxONrOKFApzECa6OhUzIKP8QH5Y=
X-Google-Smtp-Source: AGHT+IEe1O/zFgAYqwGEjPuf9D+DhMlkuq/Ne2u8Vb1fois1FSZ2jpWifeF1fEt+Dc7anN6YswaLPA==
X-Received: by 2002:a05:600c:41c4:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-426708f1fabmr89978415e9.35.1720783597294; 
 Fri, 12 Jul 2024 04:26:37 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa0689sm10008513f8f.85.2024.07.12.04.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 04:26:37 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de, upstream@sigma-star.at,
 Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] ext4: Fix integer overflow in ext4fs_read_symlink()
Date: Fri, 12 Jul 2024 13:26:35 +0200
Message-ID: <3325697.VqM8IeB0Os@somecomputer>
In-Reply-To: <59ebc379-66f7-493a-b024-fcc3224b320c@gmx.de>
References: <20240702194223.31998-1-richard@nod.at>
 <3244366.vfdyTQepKt@somecomputer>
 <59ebc379-66f7-493a-b024-fcc3224b320c@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am Freitag, 12. Juli 2024, 13:19:32 CEST schrieb Heinrich Schuchardt:
> > Hm, I see man built-ins in the U-Boot source.
> > Why is this one special?
>=20
> See the definition of COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW in
> include/linux/compiler-clang.h.

So I can't use __builtin_add_overflow() because
u-boot is still supporting outdated compilers that don't offer __builtin_ad=
d_overflow()?

Maybe this is the ideal moment to raise the bar?
__builtin_add_overflow() is supported by gcc >=3D 5.1 and clang >=3D 8.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


