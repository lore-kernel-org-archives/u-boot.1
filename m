Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F869CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CE487880;
	Mon, 23 Oct 2023 09:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Xq+jMkKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA7B878B0; Mon, 23 Oct 2023 09:05:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F51F878B5
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so847407066b.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698044713; x=1698649513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/CSTHC9nloFVVE0SiYuvZ3M7EyisLXIfIxAjQaNmff4=;
 b=Xq+jMkKiVv7e/TdlDrslddM9sIEu+O2eD4boZ0IPvdhShN5dpRJbitvaMHTTsF5z+i
 6JaWkWCMhd4L9mP5TWFD3lDbUy5ZTKwl7xpgzYhz9oTiPrqWGCtBIKZpSO8TiF++iNbl
 hlN6V4GaanyqzOHniyDtUbmbg71RC9w+1N9UC7aJ+egO3VxAMzrFwNL/VMUpCTFAAbC0
 EnqJC+7j1U7RpitclQO/2VLz6XcNI1r/s/Rn9VdLBkZydVT+skC7v+fDqZKk1q4qgV9q
 ABYIPVhFuqnMyhgLeOqB2BBd0rMfXcxqjY1yTHWSnRahyMxsztTJWSRm/Z+ix845dzID
 W9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044713; x=1698649513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/CSTHC9nloFVVE0SiYuvZ3M7EyisLXIfIxAjQaNmff4=;
 b=IXiPTl0bg3R74J8lGaZ/BW5n9ylO2pqTHryzFD1gsmV+pg1u/nKnbWa9exZMSM2+fm
 6b1C200zFUqS8rKLeZQTTzkOj7crzGWIx0NpVZ/tXakBH+QjJUDz+nDDPIZKmG2RhP0Q
 JRbm9La9sE4hVWoKvM/mB9lDX1wn+AvISMJQ5DFrqnYL6pGlGrkYE9eaj4nW1lG8Y9Mm
 Pdjdf/+gRbHwos+5S97HzqGA740laPTrvnuKwTGmF91cygJhx4t4vTFJIz4fw+YIjVFG
 Mv9ZuvpLHCvLIJWzHNSunq0/7oNLpG+lGPMc186cdI1Zi4YmnyiXWp7Sr7v1M2jpsZFg
 LQgg==
X-Gm-Message-State: AOJu0YzQRoVIUZQW+7ZHLXCLNc03RuY64EtVeHq5eUmv7tXrGU8PWhrW
 g9gJkr6FeSuMeR3BAKgTo42r3LGh1GFDy7TPK8rK1Q==
X-Google-Smtp-Source: AGHT+IFFRYSCqyMUsndCddXRk+7n6QmVzJqWKhAC5fzPbS+4VR0ARDeD/4/2SIYTFsco0X+4MSglZ365ZEOJzmTNyyg=
X-Received: by 2002:a17:906:6a13:b0:9ad:8a96:ad55 with SMTP id
 qw19-20020a1709066a1300b009ad8a96ad55mr11140735ejc.14.1698044713499; Mon, 23
 Oct 2023 00:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231022174707.72695-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 23 Oct 2023 00:05:01 -0700
Message-ID: <CAPnjgZ3q1im+5GwvZ_U8KMERFczD4EbR9T9gG1aeKews3yyZRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] general: fix GPL-2.0-or-later SPDX headers
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sun, 22 Oct 2023 at 10:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> SPDX headers should use GPL-2.0-or-later and not GPL-2.0+.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Makefile                                                   | 2 +-
>  README                                                     | 2 +-
>  api/Makefile                                               | 2 +-
>  api/api.c                                                  | 2 +-
>  api/api_display.c                                          | 2 +-
>  api/api_net.c                                              | 2 +-
>  api/api_platform-arm.c                                     | 2 +-
>  api/api_platform-mips.c                                    | 2 +-

In License/README it shows the identifier as 'GPL-2.0+'.

Regards,
simon
