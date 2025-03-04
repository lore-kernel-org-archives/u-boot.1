Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9816C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A9081B4B;
	Tue,  4 Mar 2025 14:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NP3U4Jzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1573819D9; Tue,  4 Mar 2025 14:14:19 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF68819D9
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e4f5cc3172so6582336a12.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741094057; x=1741698857; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2MTVwajP6USpnFVK6bWDXo4ULjxi5UKlgibUuZu0d1g=;
 b=NP3U4JzbQbLcF9F3NGli2wQ2rS4ftrjoPcMTVBgRKHaFQVA8G7K3fq1KronnK2LIjw
 wMGtg9r9ILMNlJTe7JauIi21iT20+jFKk1z9SYNBksM/Yrf9l3FISJ2ZYrRYttnQiIK9
 yc0cqDTF3YGsCEyVuCq3e/5sTucL/GfzoGO0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741094057; x=1741698857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2MTVwajP6USpnFVK6bWDXo4ULjxi5UKlgibUuZu0d1g=;
 b=unwWiKDkETVtyZGY1K/HN8ZnA4JNzeR31V68SewQZkDS1fLLK3B3g9o/q79X0rqSX/
 PYH/E77OqiQsjAdBVJDWEEmye7zUmatEA1L+Os6P2vvJN2fgeczSFPSbwKZS/jgA/xM3
 5h7184PwV0MYJTNeZkEw6upxgxveg3E5Wo00CPl0qvGvBQGiFG6I+EieeNtfUbEe/Jyd
 UVqRJjSrKNnZXVcTluYHbbeztNjfGfo7SSHkruK/mqXBfx2L6SGoMiszAV8hwIaMNeLo
 W4cpviQXd7ARyzBYmUQ8UqLLf7fFeeNNEuYdhTIt71KI3XhTyU7EFpCm3dM7YhUr/Q9z
 K8Jg==
X-Gm-Message-State: AOJu0YwSN1w3MG48izh7TtO9VziPpFdOowleZKeM8HlqCGC/itEVIoXl
 YAPnJ3X+9fAAQkrOcT165KKmoZvV2vvJKROu2rIsWCpEof9fY+wnp2aWJ4JTFVwkPLO3YGzr6Uc
 5sL1dXnLi37Dvlq12L8Q70Z70LvjJN+toHCbF
X-Gm-Gg: ASbGncvqNWwxXKwpQfMxANMrLiG7pNLxswsk+vk5VFm1IyD+Si5BRAkY3Cw5xZGKS65
 aRYJ4nnGWgHoXE7UcSRDxn02Oc2tinqlHf7cxVhWZwf88mVXMhKWuwu0O/hypPCJpJG9c8a4uMV
 3UuPYkxhD6moW5C571OkEkYl3NoRw=
X-Google-Smtp-Source: AGHT+IHfeqgcMbUO4kqF5ctEoCjvXSv3wPCazfO9DLki5hmaDlAxYjtVxVjlBHE6je3sFHIdqj9teFCp4okETMyBZDA=
X-Received: by 2002:a17:907:7211:b0:ac1:ee47:2bb2 with SMTP id
 a640c23a62f3a-ac1ee473001mr344674766b.5.1741094057083; Tue, 04 Mar 2025
 05:14:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <2f17fd7ec21b59218d5bf88f045c13db08f906ca.1740499185.git.jerome.forissier@linaro.org>
 <CAFLszTi_p4PFNkSFk+yMLaQoSUe6pVXvGiD2UX08Ka2j0jyS1Q@mail.gmail.com>
 <9bc38835-8050-4b6c-acb3-3f2d3db08e6c@linaro.org>
In-Reply-To: <9bc38835-8050-4b6c-acb3-3f2d3db08e6c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 06:14:02 -0700
X-Gm-Features: AQ5f1JrTiV9INZDvyiyEqCOApyziyLE2LgKG1Ix0WVqJTTIAaMAwAvkaOmuJsYc
Message-ID: <CAFLszTgaM6seivQXxdSRXWx7SE_MzP3LyJuJ3TmDEHvDdzoDCA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] test: dm: add test for spawn and wait commands
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jerome,

On Thu, 27 Feb 2025 at 10:12, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Simon,
>
> On 2/27/25 17:25, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Tue, 25 Feb 2025 at 09:35, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Test the spawn and wait commands.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>  test/cmd/Makefile |  1 +
> >>  test/cmd/spawn.c  | 33 +++++++++++++++++++++++++++++++++
> >>  2 files changed, 34 insertions(+)
> >>  create mode 100644 test/cmd/spawn.c
> >>
> >> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> >> index d8a5e77402d..cf47f04851c 100644
> >> --- a/test/cmd/Makefile
> >> +++ b/test/cmd/Makefile
> >> @@ -39,3 +39,4 @@ obj-$(CONFIG_CMD_WGET) += wget.o
> >>  endif
> >>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
> >>  endif
> >> +obj-$(CONFIG_CMD_SPAWN) += spawn.o
> >> diff --git a/test/cmd/spawn.c b/test/cmd/spawn.c
> >> new file mode 100644
> >> index 00000000000..5e0770858c0
> >> --- /dev/null
> >> +++ b/test/cmd/spawn.c
> >> @@ -0,0 +1,33 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Tests for spawn and wait commands
> >> + *
> >> + * Copyright 2025, Linaro Ltd.
> >> + */
> >> +
> >> +#include <command.h>
> >> +#include <dm.h>
> >> +#include <dm/test.h>
> >> +#include <test/test.h>
> >> +#include <test/ut.h>
> >> +
> >> +static int dm_test_cmd_spawn(struct unit_test_state *uts)
> >> +{
> >> +       ut_assertok(run_command("wait; spawn sleep 2; setenv j ${job_id}; "
> >> +                               "spawn setenv spawned true; "
> >> +                               "setenv jj ${job_id}; wait; "
> >> +                               "echo ${j} ${jj} ${spawned}", 0));
> >> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> >> +       ut_asserteq_ptr(uts->actual_str,
> >> +                       strstr(uts->actual_str, "1 2 true"));
> >> +
> >> +       ut_assertok(run_command("spawn true; wait; setenv t $?; spawn false; "
> >> +                               "wait; setenv f $?; wait; echo $t $f $?", 0));
> >> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> >> +       ut_asserteq_ptr(uts->actual_str,
> >> +                       strstr(uts->actual_str, "0 1 0"));
> >> +       ut_assert_console_end();
> >> +
> >> +       return 0;
> >> +}
> >> +DM_TEST(dm_test_cmd_spawn, UTF_CONSOLE);
> >> --
> >> 2.43.0
> >>
> >
> > This doesn't look like a DM test as it doesn't use devices. Could it
> > be a CMD test?
>
> Absolutely. In fact I started from a copy of test/cmd/hash.c, which is
> not a DM test either is it?

That's right. Since DM had the first tests nearly everything started
out as a DM test, so you could clean those up if you have time.

Regards,
SImon
