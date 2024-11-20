Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA50AD711B8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8929E88C0F;
	Wed, 20 Nov 2024 16:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q7nPowcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E074788FAA; Wed, 20 Nov 2024 16:34:08 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32C787042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21269c8df64so12929405ad.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116845; x=1732721645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qHqBku3K8LiWOoR94qQ/l+yLaUsUMZKbiLYRYNfCrhY=;
 b=Q7nPowcnb+MZhM8phw0B1xOG6xZTxS8n4A642jTdETnlHoCYUoxHApvRF74SyoVIhZ
 GlHmsfqmNxV0BxriSCXRNXe1fhwwGWaccRPat7uyvVRalXFFZQ9afGmsTAQPbrDIFBp3
 7YMpv/86TuACd8Y/0OgKxiawmYvfPMxUjxEpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116845; x=1732721645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qHqBku3K8LiWOoR94qQ/l+yLaUsUMZKbiLYRYNfCrhY=;
 b=lDQf/gNj8WbVILhrIMQs6ffG/9MCNQbM8Xyymgl9hych4birM3xXeeuuT7hDi59YhX
 7URgMKbwGTItAf1J49l95A/Ai3BA+OmFK46aH0S20Gv93fFLj15jtX+rTnr0F4fEuj1p
 Sup2Ja88S7Tz45MC5P5Sc9CbFGh935z3UIInjpBt03PGYdU/f2VDiXX3/6O5M3z4Nnab
 JW/wDvFgWrzu4a76IpHusVFvywdXecOrkLPqghBOtLNVrIWGEeMai+RkxeIKjHP21bh9
 jb2sMwBZgoOMDM9P678odyB67wd/CPruBVdZV7FhGYx4ZiYCRlCggo3PlDns6/igNRIj
 h+lA==
X-Gm-Message-State: AOJu0Yy+Ww9dm/NpxvtaYutpjVz3binnQxRnr/hXvP5usKz0w8ddAAkh
 AF9g+gEuOqHRWRPGZ9R94Up2d5byRh8PdzN1TPiur2e/fklo9XRy25SJUEUfMmoSUIfnrpZxttr
 A6abJJoBiASx1Q9IcbB/6XJyyJe32ftI8W0Gv
X-Google-Smtp-Source: AGHT+IFZKIDpYAYICl83U6FmTBGNQZuKNCv6A4bYksvU7jCYUP8ezZyE/NxySuWNmwYloxDHZRybz5ikuy0m8y5ztLo=
X-Received: by 2002:a17:902:f708:b0:212:20c2:5fcd with SMTP id
 d9443c01a7336-2126a38ba57mr38732885ad.26.1732116845207; Wed, 20 Nov 2024
 07:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20241101130254.473017-1-andrew.goodbody@linaro.org>
 <20241101130254.473017-2-andrew.goodbody@linaro.org>
In-Reply-To: <20241101130254.473017-2-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:33:48 -0700
Message-ID: <CAFLszThokRsp6Zw=dpMt895Wb-QCZT-fERXbbHHiQ6F2iqvb5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: bootm: bootm_process_cmdline_env takes flags
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 1 Nov 2024 at 07:03, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> The function bootm_process_cmdline_env takes flags as its third
> parameter, not a bool. Correct the usage by replacing 'true'
> with BOOTM_CL_ALL so that the intent is clear.
> A similar change was made throughtout this file in the previous

spelling

> commit to the one mentioned below as being fixed.
>
> Fixes: 4448fe8e4e7c ("bootm: Allow updating the bootargs in a buffer")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
>  test/bootm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/bootm.c b/test/bootm.c
> index 26c15552bf..5f57ecb337 100644
> --- a/test/bootm.c
> +++ b/test/bootm.c
> @@ -27,11 +27,11 @@ static int bootm_test_nop(struct unit_test_state *uts)
>         char buf[BUF_SIZE];
>
>         *buf = '\0';
> -       ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, true));
> +       ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
>         ut_asserteq_str("", buf);
>
>         strcpy(buf, "test");
> -       ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, true));
> +       ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
>         ut_asserteq_str("test", buf);
>
>         return 0;
> @@ -45,21 +45,21 @@ static int bootm_test_nospace(struct unit_test_state *uts)
>
>         /* Zero buffer size */
>         *buf = '\0';
> -       ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, 0, true));
> +       ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, 0, BOOTM_CL_ALL));
>
>         /* Buffer string not terminated */
>         memset(buf, 'a', BUF_SIZE);
> -       ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, true));
> +       ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
>
>         /* Not enough space to copy string */
>         memset(buf, '\0', BUF_SIZE);
>         memset(buf, 'a', BUF_SIZE / 2);
> -       ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, true));
> +       ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
>
>         /* Just enough space */
>         memset(buf, '\0', BUF_SIZE);
>         memset(buf, 'a', BUF_SIZE / 2 - 1);
> -       ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, true));
> +       ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
>
>         return 0;
>  }
> --
> 2.39.5
>
