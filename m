Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F04CD2E00A
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 03:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FD3892E0;
	Wed, 23 Oct 2024 05:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A/EcHM9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672E0892DE; Wed, 23 Oct 2024 05:39:27 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 134F98919D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 05:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso905756666b.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729654761; x=1730259561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IcHgdf8UZ7z43o4luS3WXOEPHcGFFvAzTzV84WqNqgc=;
 b=A/EcHM9KWr8MxFBfSppbrTM1wVKHnL5dAPoJ8WqxeVbrbGLdh0xGvoiaY9kLCosFri
 acmFHe5vqpjY2iNV3N/TUJi1ZdkPhQRvm12gNbUTQbtGPNu5LjYIUjpkwUj4Drcr8ah8
 vd0mjPCHU4f7Jfs8yZCE7e8i6EvUahQQO9dMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654761; x=1730259561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IcHgdf8UZ7z43o4luS3WXOEPHcGFFvAzTzV84WqNqgc=;
 b=c3r8EEsRe+aVJlFMl8ibEJG0xWTLh+HxWmB6ZhGsRLcR39kqC42X2IbWdhanS7V2L4
 6QeSyCoTbEtFHWV0S4/lhL3ra9rsTC4VvMajyeLqoGHSKnWJfuMMzK6Ywoj6Z74tpWky
 +FV8GNvJQdHTUh0ZDcl7TlOacUzQ1nBVS2GFOKFLwEJQO3n0Lzt40v6Sm4c10dF3SLFf
 B/Tu8sVvpQ6P72WmxhItg2PTBimzd9JhFtFXMZZthc+u4j/L84z9xaA4biEqv66X+9L8
 NMu0FyLyf09eZCKUNMgDUgz6f2JwlDg5zjgs2Sql2cOboGO/i5eDa0WruMzIPpq/XG8I
 Cgvw==
X-Gm-Message-State: AOJu0YzhSjZop3U4LUeRZ9e2GkfDmvkxz7DtONJx01X7G5j5y83aASdz
 tMB091qNK1t0y/p0rGaw3T1tcS9O1qjL+M76cKUwJD4dfRuO83eD4mOSZwLYNpR3IOxcE4dAmZF
 wPIlz27JS3TttPa5kkUDDqoJwQjb6VJDXtLME
X-Google-Smtp-Source: AGHT+IHJ7M/bKgpUHkn8Bc8GtnpvB+u8mzkDrUIrSLwuYV4L1ffeX9iQEktLPv8Av4efZ/wyzhMuccj09s0OcgQWrGs=
X-Received: by 2002:a17:906:dc8f:b0:a99:e1a1:473f with SMTP id
 a640c23a62f3a-a9abf96d0e2mr89593766b.57.1729654761525; Tue, 22 Oct 2024
 20:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
 <a7031021-c8b9-4bbd-8089-c35a4d4e7ee4@siemens.com>
In-Reply-To: <a7031021-c8b9-4bbd-8089-c35a4d4e7ee4@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Oct 2024 05:39:08 +0200
Message-ID: <CAFLszTjxD+DjGYUd+o3mELCctOnJZO6U6FSkSjr1su7iVTcmpg@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
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

Hi Jan,

On Tue, 22 Oct 2024 at 21:41, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 22.10.24 19:00, Simon Glass wrote:
> > On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
> >> be first used by the IOT2050 boards.
> >>
> >> Based on original patch by Li Hua Qian.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  include/sysinfo.h | 1 +
> >>  lib/smbios.c      | 4 ++++
> >>  2 files changed, 5 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > What is this used for? Would you mind adding a comment for it? Should
> > mention that it is a struct uuid
> >
>
> What exactly is unclear here? The System UUID is a part of the SMBIOS
> spec that U-Boot just ignored so far.

OK, well that just mention that, along with the data type.

Regards,
Simon
