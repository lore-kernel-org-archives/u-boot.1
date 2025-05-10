Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F36AC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F4382935;
	Sat, 10 May 2025 15:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W5Trp5WC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076E982952; Sat, 10 May 2025 15:04:35 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99FB826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5fbf29d0ff1so4610922a12.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882272; x=1747487072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QOSI8I4/75BhWiGidTzjYTWUVcSzIERv12hA3tT9uFQ=;
 b=W5Trp5WCE8EEkJay2Uekq2/PTnEScmakOjXdrdpIn8hS4sZ9oGbveYyxw64w/MfQcc
 SmjfU6ZcxfLgib+RC9bk9zDkQDFzQGKo9hjK82XY48chOGTPhO28jMvqQ0WOpY5Qb0cC
 I7Q4Gvvnp4rxiLuruG/uX8PKQLU2yrQZ81TC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882272; x=1747487072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOSI8I4/75BhWiGidTzjYTWUVcSzIERv12hA3tT9uFQ=;
 b=e7dxyjpTxTa5qw1hZL6v19B07M5A29GnSlGlPnO0dpA+FbprO+Sbb6MoWqJDJ9ZC2o
 oAD+Jb2peQeI3KNv5r0MiK3IwwqmVMkAvog8C24Rir8gIIqCGuPRNMlozjTFuc/4mLtj
 DbJaMFW9AwUhWbAcQx80P0TO9rQnIeO3TdYYsqS2MHjg8DP5Fmdb0l5AW5iXVjdGKc97
 W5HuIB5Vn04lNmf1WuYE6ZA/+7TltT6hDmuOBfLk/YrOR93MOEUB4OemagyH9lsgI1C6
 kBUZG7NBnZo52JY5WA8iFnp8TmfYn+IF8cotP9gBvsa9NAs8gFdTIhli9crOKysRhR/X
 xrdA==
X-Gm-Message-State: AOJu0YyMAaLzhLlX0uSxA+GJj0rLtwPh0XAM7BZQhkhzmOXX5T/+1gcE
 Tu9LUX1qkTDoijbI7q4ZAQ6373mThcVVx456Y+xVebFgDGXGLRnsF8voB9yKRO8Kaw2AjYwWI3O
 bIAaqdobwstaHRmDZX5FSEJT1meLFUCF9yDlT
X-Gm-Gg: ASbGncsUHMnT4fJ/mhT6ZsOsYtXntlHy5IvJz78/plKAS3jTRdC995pylNAowgjElDB
 GJR2vJihlayAVfJCX1XlDU6hU0x0fhe0xYtMphLZ92yuqGFwKp1LHWQNDfykz1f5PUICSZTl795
 LjwBUSW6HihXd6lhPTcUymUhjC0S5C88tM2Q==
X-Google-Smtp-Source: AGHT+IETu9kEJRoyT7Pl0LtB5vH1CRTHGWsLJ818aqRNSoXd4rgJ6bTKjENHCs6YpCwFwpfb1WTLUdZqLDEFMvddBYg=
X-Received: by 2002:a17:906:4fca:b0:ad2:425c:27ce with SMTP id
 a640c23a62f3a-ad2425c2925mr67488966b.2.1746882272318; Sat, 10 May 2025
 06:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417121601.v3.10.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
 <30F80A76-8600-4747-A277-83A3D997BDA8@gmx.de>
In-Reply-To: <30F80A76-8600-4747-A277-83A3D997BDA8@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 15:04:20 +0200
X-Gm-Features: AX0GCFv42GzrraUeDgjmlBpzdkYY8MGKwpodPwEqnHjRl1wk2wqPTte438kB9lQ
Message-ID: <CAFLszTj5dny7wQRr-sPfzcaMr5-8EBudk=uz1OYqeH=GWz7E5g@mail.gmail.com>
Subject: Re: [PATCH v3 10/22] passage: arm: Accept a passage from the previous
 phase
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Xu Zhang <423756212@qq.com>
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

Hi Heinrich,

On Sun, 4 May 2025 at 11:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 17. April 2025 20:15:52 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Accept a bloblist and control devicetree from a previous phase in
> >registers 0 to 3, as documented in the Firmware Handoff
> >specification[1].
> >
> >[1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html
>
> Creating an interface that is only defined on a single architecture seems not to fit into today's world. One would expect a specification team to reach out to other architectures.

I was working with Intel on this actually, as part of the Universal
Payload Specification effort, but Arm would not agree to hosting the
spec on the Open Source Firmware Foundation's github, then Intel would
not agree to use what they considered to be an Arm spec :-) I did my
best.

>
> Please, adjust the wording of this patch to match the specification which speaks of a transfer list and not of a blob list.

Within U-Boot it is a bloblist. The naming in the spec was chosen so
as not to indicate it had anything to do with U-Boot.

Regards,
Simon
