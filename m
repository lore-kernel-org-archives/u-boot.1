Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533D4C28B28
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 08:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C87801DE;
	Sun,  9 Mar 2025 09:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yq7wTAnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0310A8043C; Sun,  9 Mar 2025 09:42:30 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B690780107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 09:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fbaa0582a6so30386867b3.1
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741509746; x=1742114546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AwKY2lwv7YU0Urg6HAJFnEETbT8OdhwZBtxsUjhSqYY=;
 b=yq7wTAnB/XRhfDKIojzPInqQn/C0PSHqSaTJu978m/MqmMPCmVAcD656FrRiJzq2yR
 myCJUytdZlBObH4kAtpIW4HPGb+jCmGMQ/9yD3QbZ7F2jNoYz2z+56lZeozU3JNsPiaP
 FPqB3YPw6Y07A/JfL2Gsrz7W+EOcd0QU5zcpt9jQQDpfn9/8QhbYEgl8VPtI+Een5ziy
 rQ7RpLubMj0MVDLmTcRVCqZ/c/3Zt+PZnsHNiN+oDYBF0gGq247Pl3jwgowD/anXYObk
 WVc2+BfldfiO0F1yyt9WFz7lWUlBXSuVYaqHuKkd6VTC6fDVpKfgISfYj/b/fr7CyN7L
 bvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741509746; x=1742114546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AwKY2lwv7YU0Urg6HAJFnEETbT8OdhwZBtxsUjhSqYY=;
 b=KVgtLAVAtmgfciI3kg1KzJfsJWLeqXDEwSTXEKZBhSMe3ZBjAfO+u+V6r/7lmDkSjF
 xvRjT9hdAVN3ThdMXbKy9qmTu8f2Yns7TnLIHN4ZsW60H5ECZfZkgn/0VmtX/q4c5+5P
 yqI51VZhdF9iEZwOHYevQGCQhK+lB4taceTID/3QQ8DD6qU7DjI94RsyMPHg+a/X/I7P
 QAnIDRQGVOhBjnM45vSaMzETyarTXC048p5Ko3faRnJ5FqR3b+GNioh1HQw4CpCuiUPW
 v15vw1W6WnJekELaq85Czoqihp1O578/JTnPIPuOGw+pmNGaquDV050/UOd/wtWaBb8p
 GHDQ==
X-Gm-Message-State: AOJu0Yz7da8syAO6qmCOJXi3btH5ozDSoGwRLzpVp2P8Fnj8Bgns+9jz
 Rq2JtR35oB/Ysqh4zZB1/G3Uj6thI4+oLbYHRVus3M0T8My5RQvshJ5qBIc5OauegTLQCBFIAM2
 2/uPnjGp0b//PqZvbtwy2s5e1OCGOrhre0O600g==
X-Gm-Gg: ASbGncv0St1ZrAVMvdsCCLXv01b4RY6NPukJnkeF7cNkdVjgdMZ41Lxkft7APC82yFU
 eRsx8itugN4HI6akGg52icDUUfB+giS9o7MqA1cEnpLuwjycjEcEMfgG0pT6qMomStqXfMkocot
 /5odVoE1Adg/3eSbqmBGqBkSNAB3Y=
X-Google-Smtp-Source: AGHT+IGGhMWBn5cyf+vYZfUcYkqXLqPd+6oaJH2sD8in9h1tt15v0NUQfSkvwsmfRKeBZR8zQNt0Ql/ZurHm/yqqQk0=
X-Received: by 2002:a05:6902:1b8d:b0:e5d:9246:ebdd with SMTP id
 3f1490d57ef6-e636f8059c1mr7195377276.21.1741509746553; Sun, 09 Mar 2025
 00:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
 <20250304152510.2832340-14-jerome.forissier@linaro.org>
In-Reply-To: <20250304152510.2832340-14-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 10:41:50 +0200
X-Gm-Features: AQ5f1JrvG36-WvD3tMtfJhS2eKoeojeNvxiKhEYPrlMEIVlJe_yNNx1sLRk2ypM
Message-ID: <CAC_iWjLvQMbvqcEBPKqXLXTYcgV3GTEap3P3t6ArFknnTaUFMQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] test: cmd: add test for spawn and wait commands
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 4 Mar 2025 at 17:31, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Test the spawn and wait commands.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/cmd/Makefile |  1 +
>  test/cmd/spawn.c  | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 test/cmd/spawn.c
>
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index d8a5e77402d..cf47f04851c 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_CMD_WGET) += wget.o
>  endif
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
>  endif
> +obj-$(CONFIG_CMD_SPAWN) += spawn.o
> diff --git a/test/cmd/spawn.c b/test/cmd/spawn.c
> new file mode 100644
> index 00000000000..8f48f5ee25c
> --- /dev/null
> +++ b/test/cmd/spawn.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Tests for spawn and wait commands
> + *
> + * Copyright 2025, Linaro Ltd.
> + */
> +
> +#include <command.h>
> +#include <test/cmd.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +static int test_cmd_spawn(struct unit_test_state *uts)
> +{
> +       ut_assertok(run_command("wait; spawn sleep 2; setenv j ${job_id}; "
> +                               "spawn setenv spawned true; "
> +                               "setenv jj ${job_id}; wait; "
> +                               "echo ${j} ${jj} ${spawned}", 0));
> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +       ut_asserteq_ptr(uts->actual_str,
> +                       strstr(uts->actual_str, "1 2 true"));
> +
> +       ut_assertok(run_command("spawn true; wait; setenv t $?; spawn false; "
> +                               "wait; setenv f $?; wait; echo $t $f $?", 0));
> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +       ut_asserteq_ptr(uts->actual_str,
> +                       strstr(uts->actual_str, "0 1 0"));
> +       ut_assert_console_end();
> +
> +       return 0;
> +}
> +CMD_TEST(test_cmd_spawn, UTF_CONSOLE);
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
