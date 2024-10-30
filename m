Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B19D6B6B7
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251E789263;
	Wed, 30 Oct 2024 18:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="RJLUgS7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C5388FD2; Wed, 30 Oct 2024 16:15:42 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B055288CF1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 16:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso67026791fa.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1730301339; x=1730906139;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DaHuROcJP1n5j3F/ZcDDPrRn0a0hdPS1v6tq3+FOA80=;
 b=RJLUgS7q0mpEMnyiYek9+rm5DLXRRLdpb7zvHtaFX5a/ElPJ750WRemGL+LQspxYgm
 JNAj4pxfO1zciV9gsB4Mgk6NC3+0EU2I4aGUVAtX8Go0eni7xGrfUbnMGBKyaIHHjY4/
 zJOCShIGJ0TkDD4iVJm5bDt9xTSZ83o2Dc6kGBYnLh2Kyp33g9ApfQ9E25ofG70dWPiu
 un7rcwjDt2VU0Waa3T+4t2c2KREUYlHRk63JPD07ZTJKs0/fMVQY5Kx6YgJ+XJCihElW
 IzZpAtJOId23PIsWTCIKwenqPr39dhXIq12sAcKioV2znZNuAkDevlU+KvU4vbCsaA8r
 g2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301339; x=1730906139;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DaHuROcJP1n5j3F/ZcDDPrRn0a0hdPS1v6tq3+FOA80=;
 b=dBlz/l34lnqN6C2YFStsd0eg/+y5ZfRrF/cdsrBxNCgct+SLOwdt2HppRTlYjwZr5A
 xPODHoZO3rv66ArinPG/kIsVAIe/BJp8+lXyJVQuLpxnNmX2tU54AXzMmYGbmOCF7H9d
 9TUV7KKp1gBwDIEAViTHt6HC8X7LT1bUcX+1oX/Vtz0UYPT/VjIAZl0JbMpJCeJa5KRt
 o1QViWdjvoHs8KII6DeZpOIM7bCMiIehT1jRMSCS/VhTcWNMeqiHXHG/lWn3Ql8fUJjB
 JgihwIv6w3+LPK1lI8EouyrtxtHlBCMp1i96SVp3ig92oHEULsQeMPfvyMykakEKpPmi
 Zm/w==
X-Gm-Message-State: AOJu0Yy/7iWZwe9xTWuTI/U0aCcaNGNEOjmnTgkoeaRw4dQdF4gs2b50
 z3e+sGWvDn7c/qC9Vox56zhowTApym7I9NWEt3fNZH5C8kY9qBbTMhbRhma2aDIRDBvVn/UEO8q
 HuWlsrVKZgSTHcDwMugrAwlu1zzlVDHqYG1y9At4SeapQ8zfWpxA9eA==
X-Google-Smtp-Source: AGHT+IFsjVfZNvO+sftwoe2dsto4bE/KkXbLrL79bT5wcMTIaqhID2OkHZa1vbl5pbAHbyo3+2e96aHmXd6kBRXctC0=
X-Received: by 2002:a2e:b894:0:b0:2fb:570a:496e with SMTP id
 38308e7fff4ca-2fd058fc799mr23980401fa.9.1730301338747; Wed, 30 Oct 2024
 08:15:38 -0700 (PDT)
MIME-Version: 1.0
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 30 Oct 2024 16:15:28 +0100
Message-ID: <CA+GyqeYN4-Z_LajbPXrXtypDY4mePa2vJQ36NW+7oaZg8ww4pw@mail.gmail.com>
Subject: env: ENV_WRITEABLE_LIST with ".flags" variable
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 30 Oct 2024 18:20:04 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

I read the code about environment variable protection and an old
discussion: https://lists.denx.de/pipermail/u-boot/2021-April/446247.html
but I still have a question.

In env_flags_init() we have:
  if (first_call) {
    #ifdef CONFIG_ENV_WRITEABLE_LIST
      flags_list = ENV_FLAGS_LIST_STATIC;
    #else
      flags_list = env_get(ENV_FLAGS_VAR);
    #endif
    first_call = 0;
  }

When ENV_WRITEABLE_LIST is enabled, why do we have to initialize the list
with ENV_FLAGS_LIST_STATIC instead of ".flags" ? Doing so makes ".flags"
being ignored.

In env_flags_lookup() there is already a fallback when a flag is not
found, the static list will be checked.

Since default env is firstly loaded in env_load(), external ".flags" are
rejected and don't affect the security:
  change_ok() rejected setting variable .flags, skipping it!

Advantage of using .flags is being able to use a <board>.env file to
group all variables together without modifying the included header.

Best regards,
Zixun
