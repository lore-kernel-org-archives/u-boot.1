Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCD8C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B18E878CF;
	Tue,  9 Jan 2024 14:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jdVFDSNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70473878DA; Tue,  9 Jan 2024 14:54:39 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FEBD878CD
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso33631295e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 05:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704808474; x=1705413274;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PVuN9+UN42uMKhRnYG9JEtXTDScaa1svFsLSHqjrjy0=;
 b=jdVFDSNcpkqBxRZQtY0zYeCMFSwiLJ81v9D6JSIbmx1aEcmNxg8CB8juH2eQYDTz1U
 83JyM7zuf60bYIUiyt+s21ZMn2UwkhvSVWePsJJ0LbeOFb+1wnRoqSWgrXnYVbmV1/72
 v7M51wS/7TCOOFO0sq8Sscz6YrI6RGrTmpFhnpYI8qT9zdFVyfcTakA4LrKywxevdQj5
 b4B/P9EhDVOQ1Ae5ZAZ1zxKpiWHbT9jaGjYFwMmZjKUp25jrIiS+cnAM1EFzUBMn3Czo
 oR/CB09bS9j0JfZZ2/5e0JM6HLtihZOnSdtdq5Z2hGnSwzO/xh4unVe2hQccfgd6qyCk
 Lv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704808474; x=1705413274;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PVuN9+UN42uMKhRnYG9JEtXTDScaa1svFsLSHqjrjy0=;
 b=qW1PL1B5X7ETvD8q1InW6Wamsx0NiIMYYyaTE+3kTgwbR5Pcn8CnuewxElsJ9x/OHC
 FExXtvh3xuL9EkmaW5ZLwO/PqkxkgjfhSYA9ISym7FAHxjGrx7xnID6mjHI+bJC6H5Fe
 H60OQXnOScXQMNjmBEATL9Us55EohEjwFHosoOfv1iHKYWtBjAcG/Pf+4fu/8tw33Iux
 AkOArvPztf2JagonW97IF/MC4qwqyU1/hIxdRBM3brRuPCLyp2kTfJeNU/RfdcFZ+2ka
 YpBJyOF4udRRR7CquAmmiP92qdoiiDqWHxjFpzCsR+XmEEv9OmNqtN2/BiTc5FY9nmbY
 Zezw==
X-Gm-Message-State: AOJu0YwCmiTQe3VToNT61R+DmJJOeoLBUjDtbzVvGx9t1UU/P9HnTaaO
 8uMHXbI7O9FHOZxkfSwBvUzwS2aU5kS0ZQ==
X-Google-Smtp-Source: AGHT+IE1O0VC1EP0VsWJ5feauM15sCocaoOa9QKulrLZ+UU6xE+YuT67wogL1N/Z5kVYS7cK1Kfd7w==
X-Received: by 2002:a05:600c:3154:b0:40d:3112:a2d7 with SMTP id
 h20-20020a05600c315400b0040d3112a2d7mr2812512wmo.187.1704808474349; 
 Tue, 09 Jan 2024 05:54:34 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c4e8900b0040e3bdff98asm12959739wmq.23.2024.01.09.05.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 05:54:34 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, Ramon
 Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>, Ion Agorria
 <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, Sean
 Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, Dmitrii
 Merkurev <dimorinny@google.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v7 7/7] test: hush: dollar: fix bagous behavior
In-Reply-To: <20240105072212.6615-8-clamor95@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
 <20240105072212.6615-8-clamor95@gmail.com>
Date: Tue, 09 Jan 2024 14:54:32 +0100
Message-ID: <87le8ywr1j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Svyatoslav,

Thank you for the patch.

On ven., janv. 05, 2024 at 09:22, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> The dollar test was merged with bagous console behavior, and
> instead of fixing it, this behavior was just workarounded.
>
> It seems like without the fix the ut_assert_skipline(); didn't clear
> console and running ut_assert_skipline(); many times would give always
> OK. With
>
> lib: membuff: fix readline not returning line in case of overflow
>
> the line is cleared correctly and next assert fails because now there
> is nothing to clean which is correct if we look the this a bit above
> the failing assert:
>
>     if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>          /*
>           * For some strange reasons, the console is not empty after
>           * running above command.
>           * So, we reset it to not have side effects for other tests.
>           */
>          console_record_reset_enable();
>     } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>          ut_assert_console_end();
>     }
>
> Which further confirms that tests workaround the old problem and now
> that problem is fixed we can remove the whole if blocks and simply
> place ut_assert_console_end() right after ut_assert_skipline() without
> any conditional and will pass green.
>
> So this part of code goes from:
>     ut_assert_skipline();
>     ut_assert_skipline();
>
>     if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>         /* See above comments. */
>         console_record_reset_enable();
>     } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>         ut_assert_console_end();
>     }
>
> to become:
>     ut_assert_skipline();
>     ut_assert_console_end();
>
> Same thing should be done with the if block mentioned above that calls
> console_record_reset_enable().
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

I confirm this fixes the problem reported in:
https://lore.kernel.org/all/87wmspm9e5.fsf@baylibre.com/

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

The commit message is a bit long, but I don't mind it staying this way.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  test/hush/dollar.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/test/hush/dollar.c b/test/hush/dollar.c
> index 4caa07c192..68d0874d90 100644
> --- a/test/hush/dollar.c
> +++ b/test/hush/dollar.c
> @@ -53,29 +53,12 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
>  	ut_asserteq(1, run_command("dollar_foo='bar quux", 0));
>  	/* Next line contains error message */
>  	ut_assert_skipline();
> -
> -	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
> -		/*
> -		 * For some strange reasons, the console is not empty after
> -		 * running above command.
> -		 * So, we reset it to not have side effects for other tests.
> -		 */
> -		console_record_reset_enable();
> -	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> -		ut_assert_console_end();
> -	}
> +	ut_assert_console_end();
>  
>  	ut_asserteq(1, run_command("dollar_foo=bar quux\"", 0));
> -	/* Two next lines contain error message */
> -	ut_assert_skipline();
> +	/* Next line contains error message */
>  	ut_assert_skipline();
> -
> -	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
> -		/* See above comments. */
> -		console_record_reset_enable();
> -	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
> -		ut_assert_console_end();
> -	}
> +	ut_assert_console_end();
>  
>  	ut_assertok(run_command("dollar_foo='bar \"quux'", 0));
>  
> -- 
> 2.40.1
