Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDCC7115A
	for <u-boot@archiver.kernel.org>; Sun, 22 Jun 2025 20:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD45582D60;
	Sun, 22 Jun 2025 22:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gcFKVLZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CFC82D2B; Sun, 22 Jun 2025 22:52:37 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4D98006D
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 22:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60d63174f05so735185eaf.0
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750625554; x=1751230354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgZMVb9brVIqXRLRFD5yRLLG1iHq/oP2Np5pC4s/LU8=;
 b=gcFKVLZAYxH8SqFfE2J5MCZrIQO7FWdnxTXL6ZmIgfx9AIsOl3ViBjX1qgVnyK9K8O
 74FFALCEGWJMxnx82z1qTUE8JL+teVS1VW+jVSYciBYmkO74Nmb0cXKQG/n8g3bC3x8k
 4m156ItAa/IXr/51AuB9zHr0TIgIcpcRCsEMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750625554; x=1751230354;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgZMVb9brVIqXRLRFD5yRLLG1iHq/oP2Np5pC4s/LU8=;
 b=XACYOu8xwQtIA+pEE9eCc8Y826zc3Nuya0AABnzzfHDETD5styyfFdomXd0aY0vsfm
 872OqNi5M7+QB+hjZ2UCTzb3tD2Pkrk0DkSA/FyDBUDRlVhtxNGVjNWqn4hhu/JlgK7B
 YEQL/wqx3C4K/mBW78M2m6m7+2zAJ0o80gi1iomNxlbUGYOGufjJXRgnmb/NQydryrPl
 10aor/H+nixC0N3wlPiAlbk0rlk/jsN2w/+va+wfsNV/QhqN1TACzIEDIxfUVWaBr/i+
 uU0gKg5y2Nlcl+J5nE6lNEBgkyc5UGaKtE0yim0t5FNu5rh/0FvJ4U0Tihw1/HpkZZ+1
 zd2w==
X-Gm-Message-State: AOJu0Yxv1cyf7usLnpzOIFxYG8DTlG122rY4qU1nk6U+rEM3KgSjLmes
 BX0oT6COBA/I3dUKo99Z9u5FjA9urE/dx0TlkvhbnEiIb6i6GQaC8AQM06GMg3m3e6w5S09hhQL
 pOqQWcMc=
X-Gm-Gg: ASbGncsF/pAvluWhEUvvfrmC5sMgSDqKNfXwgzavh1W3lY2Pr3dfTdD+pL1S9BBhj+Q
 8NeEIUyYWq8BkkpxflvrlN2lZ0ztqQakGkgXiWifILVS0JQk5AppSMX8Fz7VEq8nFBXoIj/qwL2
 MIurVq3c5WufbwLwgOjSi/bhaS7HSYeIrVMkhLUyz0DM0f0kS2wRN+ey2H8RAYtDUB4UT+PgjP/
 DUDTtEjPI8t/fBhvJga47z/0s2GXS/fYYs7dcE05VmVXQj5KL9zHMOS/5pcp6/kmBRW9COZ5bxh
 2aTuNMIe8oc1rklCb8x+mwZ1uGrqjVdstXpFnmP/YLFN6QjQ3LB5Vy0g1zLBQDsHy6mNRNSuVYD
 EiYr8t5Uf4qlXgAR1HB15WINXBmR4rjKQ
X-Google-Smtp-Source: AGHT+IHOp+bsuTIs0FuZVq3+4RjfB+s6836qb54ERhi0AkHCCUWzsMW76nnZC9+6LaYWAAtnV8wIUA==
X-Received: by 2002:a05:6871:547:b0:2d4:ce45:6993 with SMTP id
 586e51a60fabf-2eeee5c758bmr6875030fac.30.1750625554051; 
 Sun, 22 Jun 2025 13:52:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee665ad4a5sm1357117fac.18.2025.06.22.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 13:52:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Shiji Yang <yangshiji66@qq.com>
In-Reply-To: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH 0/2] rsa and fit_check_sign build fix for v2025.07-rc
Message-Id: <175062555250.3894397.1055498853974438511.b4-ty@konsulko.com>
Date: Sun, 22 Jun 2025 14:52:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 20 Jun 2025 00:38:16 +0800, Shiji Yang wrote:

> From: Shiji Yang <yangshiji66@qq.com>
> 
> This patchset fixes some compilation errors that I caught in version
> v2025.07-rc4 and branch next. If they are acceptable, please apply
> them to the master branch. If anyone has a better way to fix these
> issues, it's fine to ignore this patchset.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] lib: rsa: fix compilation error without openssl
      commit: 961e260cdcd01d68c8dae87eef67e116f1a67aed
[2/2] tools/fit_check_sign: make the module dependent on CONFIG_FIT_SIGNATURE
      commit: 1989eb65c50e2541373bc6657a85620ff0c6f573
-- 
Tom


