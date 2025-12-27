Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C8E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 13:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FDD83B9B;
	Sat, 27 Dec 2025 14:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ij0xOJE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67EE183BA1; Sat, 27 Dec 2025 14:45:57 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A067F83B72
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c7d0c5ddaso4317297a91.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766843153; x=1767447953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m+ZlkyEY8GO+Urs2+easilV/2nyJcyqHf2iKeeCfdGk=;
 b=ij0xOJE5qbJjj2nY4GreuJ1By5u0gDjR5sGR0grqdp+MJ1JVncmDtqI/J2EKVv+SQO
 N8JUItnky5m/6AR4nPDGhUaQM6T4QhqVHTBa43cq0C8WZ5TROhYYIa83E+77qyiakOzi
 b0NNkdiLuU0pfu/Tqm3F3JNpZZ/GYVxFB1IEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766843153; x=1767447953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+ZlkyEY8GO+Urs2+easilV/2nyJcyqHf2iKeeCfdGk=;
 b=LiRN1/+8tJnsj+odOf3VvWUWrVzX9R0xoyMAzlgn406T/VYV6A27yK/MWYDBKk7qEE
 /QlA+O7p2fr5KqLTlnwl6jQHWkYPAITUcC9UMTerIudBtr3iBuQmGX368mY7uZ5CP39T
 BMDweE/dkL5UGt2ZpD4+/rLsanptgoGpJXqXDlSi/w1QwHvIdbjm6sNF6/hGZhsZlOl3
 SWaWW0rXLd7+EbLuZ+D4s46WoCcokRhE74BtfCmvnAzymIuKJnqGqNWRyN29ehXY3MJs
 uptDb0vVlijswZ4aepX9sVB2ZhVU15TBNwfJnuRY1sUa6UPklTTQnqp7kAgsdlFxXR85
 FvZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMm/a8nJfMw8eZjCp7SSYUaXAhkwjSWwPv4K0mSMeJ3mk1CiH6yzoAAa+Wq/sC93muRIp1T0E=@lists.denx.de
X-Gm-Message-State: AOJu0Yws+B8ZVVNcf7w14ShqT/txLidIGVLCCRFmIJGVCiR+oNddeXzJ
 XYp1Oz6lrjQIdGwpps+yOWJFGeBizLJBIlQu+ZyvnqONAfGPJMjgCFmaDjKs/Z2Cd4HJgqwA0jb
 kinCJuwT26VgP5Z5xQ4hrz9QP4Apl+kbNTRs5n/Nc
X-Gm-Gg: AY/fxX5ztwjCD8Oatlh8mWv9IhnEHkQ0KU5olLJV02yciNJbO+e2rVdDTiu6Bm5h8ID
 z4x2D0nBbho5/fXPN2mI9mcuhfwfEnmx1XXYu/XrNBC9JIW/7DGJhsND27xxVdc7/a5XDd1jXAU
 /oZsiLUAiNZVrIkS6yH1pUT39598WzYIqoJTfh37cV0mVEZXKuZ4/OP2U1NgoTIPbFI7S7o5C1F
 Ff549Hc6SptJCAdCr76h+eHDxXnMbLdNwn1mJ2As4Tsp+rzymo+IwpiUU5ILxmRtYXJ+A==
X-Google-Smtp-Source: AGHT+IE5LyuWdsYNBYZjElNthhPzaqIdfR5ovMTe2y3M836NEEmjpb0i2SyjWZhzAxrSy6xsOpgbZZoJofUvmhsCqWA=
X-Received: by 2002:a17:90b:17cf:b0:34b:75f4:96d3 with SMTP id
 98e67ed59e1d1-34e71d80c4bmr23316677a91.5.1766843153055; Sat, 27 Dec 2025
 05:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 06:45:09 -0700
X-Gm-Features: AQt7F2peuaA5nZSlYaGqdw_5P-5-n_pfGBLHnZn7Nvm9BGmhMmp19Qa1qcYFJVY
Message-ID: <CAFLszTgOXPK_LvWVfnAkAgoWk5g8XXdh6rt9J==hax7BXA7KqA@mail.gmail.com>
Subject: Re: [RFC 6/8] test: cmd: consider configuration in meminfo test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The output of the meminfo command depends on several Kconfig variables.
> These need to be taken into account to provide valid test results.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/meminfo.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>



> diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
> index 9224b9589f3..d91fa6fcead 100644
> --- a/test/cmd/meminfo.c
> +++ b/test/cmd/meminfo.c
> @@ -15,24 +15,34 @@ static int cmd_test_meminfo(struct unit_test_state *uts)
>  {
>         ut_assertok(run_command("meminfo", 0));
>         ut_assert_nextlinen("DRAM:  ");
> +
> +       if (!IS_ENABLED(CMD_MEMINFO_MAP))
> +               return 0;
> +
>         ut_assert_nextline_empty();
>
>         ut_assert_nextline("Region                Base          Size           End           Gap");
>         ut_assert_nextlinen("-");
>
>         /* For now we don't worry about checking the values */
> -       ut_assert_nextlinen("video");
> +       if (IS_ENABLED(CONFIG_VIDEO))
> +               ut_assert_nextlinen("video");
> +       if (IS_ENABLED(CONFIG_TRACE))
> +               ut_assert_nextlinen("trace");
>         ut_assert_nextlinen("code");
>         ut_assert_nextlinen("malloc");
>         ut_assert_nextlinen("board_info");
>         ut_assert_nextlinen("global_data");
>         ut_assert_nextlinen("devicetree");
> -       ut_assert_nextlinen("bootstage");
> -       ut_assert_nextlinen("bloblist");
> +       if (IS_ENABLED(CONFIG_BOOTSTAGE))
> +               ut_assert_nextlinen("bootstage");
> +       if (IS_ENABLED(CONFIG_BLOBLIST))
> +               ut_assert_nextlinen("bloblist");
>         ut_assert_nextlinen("stack");
>
>         /* we expect at least one lmb line, but don't know how many */
> -       ut_assert_nextlinen("lmb");
> +       if (IS_ENABLED(CONFIG_LMB))
> +               ut_assert_nextlinen("lmb");
>         ut_assert_skip_to_linen("free");
>
>         ut_assert_console_end();
> --
> 2.51.0
>
