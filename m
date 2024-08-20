Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F386EC5320E
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 06:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEE889FC;
	Tue, 20 Aug 2024 08:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ACFq06vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8064588D38; Tue, 20 Aug 2024 08:40:13 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B8B889F1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 08:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37189d8e637so3058146f8f.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724136011; x=1724740811;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7DU5BWoZ7/0/kK1Kw4QHcJkrQlsmY6IvAQAo3ipo/Lo=;
 b=ACFq06vtdrIpcN87cnWDctZ8k49cCN37NnoG5FcHnV/ghv02VgyMxHSgJ0ZkV2ORi4
 4olGk7vhH9vZRvOvKHTRCP4V3w1iTnSjB7LdThzno0VJRgcHqSbicHr3q1scKtBIvNDB
 +6lNWczjLsaAA4nWDIiGBZunrw2apdtU7Lfk0SjOiFFZ301S0kNbYaXuD/jRNG/IVw9o
 K98vGfMKdNoUho0bWNrReAnTD8oQDE149ve/ynv/C3PtHC4x2fLjre7Lgau6cBCElRMz
 JDeG67W7Oh3jWG/XeEhgqt/g+wxbv+CpWQ2boCpx+edKBK7tvFW2E8tyDmE+4N9qwwRu
 6NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724136011; x=1724740811;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DU5BWoZ7/0/kK1Kw4QHcJkrQlsmY6IvAQAo3ipo/Lo=;
 b=Qlpk6udIG0mOslB+kqkEmRQ3ZMUzQciT+bt9YfBbTuEvySvP0v1/wfjyIDMBOYy6Fm
 g9FqUkm1SxGqrxphUnztlNTCqoWkhsLZAfciKtNPqwC6VLY22mP/RoYQgiMl3JwbOVjr
 hknDZX2DELi3GkeRHo4/U3e0TsUtYfiWMfNiYMdrJrCDWERSoLK0Lw0+c8bhiAItB2LY
 UBMlr7/9x8jd/dsl9EmAFrFS/nmEy3byZnAmPMxlB0ZU+dD92iqwikUSvpDn+e+Dn49D
 39IAhqE6NQ+IOX+Ly23EB5m3H8jMnxMybTcosRCy43+Ao73X6dgk2ciKsFxefdlGW/Un
 Q1Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO67+YYT+X0Ep2JtUShYS7cNTthKihePE/TF358S+HVxF+3OToeMlQYxZFc7zwsi2LmYnQAwI=@lists.denx.de
X-Gm-Message-State: AOJu0YxPZlwP0FmVQOBmVdYvl/7t4aIKaebXbQVYNDFCXyVFakb2toLA
 R9nVqe2Xdq4Q/m6/OE78nC9QdVNZepUzBbOtZtiK32BriRxZ92FWXGpyVmTmzx8=
X-Google-Smtp-Source: AGHT+IHN9+wt5TFLFlNP8ZsTwaWbdltAhiT3TeIt0S5VWVHcVRgb7oVbdSbpUI3I0EZlGeDFadxrjA==
X-Received: by 2002:a5d:452b:0:b0:371:9360:c4a8 with SMTP id
 ffacd0b85a97d-37194315205mr7961502f8f.6.1724136010243; 
 Mon, 19 Aug 2024 23:40:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985a286sm12280157f8f.54.2024.08.19.23.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 23:40:09 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>
Subject: Re: [PATCH 02/21] test: Fail when an empty line is expected but not
 present
In-Reply-To: <20240810205205.3403177-3-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-3-sjg@chromium.org>
Date: Tue, 20 Aug 2024 08:40:09 +0200
Message-ID: <87bk1nwvcm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

Thank you for the patch.

On sam., ao=C3=BBt 10, 2024 at 14:51, Simon Glass <sjg@chromium.org> wrote:

> The existing implementation of ut_assert_nextline_empty() cannot
> distinguish between an empty line and no line at all. It can in fact be
> called at the end of the recorded output and will happily return
> success.
>
> Adjust the logic so that this condition is detected. Show a failure
> message in this case.
>
> Fix the one test which falls foul of this fix.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 400175b0a7d ("test: Add a way to check each line of console...")

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  common/console.c     | 2 ++
>  include/console.h    | 2 +-
>  test/boot/bootflow.c | 2 --
>  test/ut.c            | 8 +++++---
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/common/console.c b/common/console.c
> index 63f78004fdb..85f627297ed 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -845,6 +845,8 @@ int console_record_readline(char *str, int maxlen)
>  {
>  	if (gd->flags & GD_FLG_RECORD_OVF)
>  		return -ENOSPC;
> +	if (console_record_isempty())
> +		return -ENOENT;
>=20=20
>  	return membuff_readline((struct membuff *)&gd->console_out, str,
>  				maxlen, '\0', false);
> diff --git a/include/console.h b/include/console.h
> index 2617e160073..6b6d0f9de73 100644
> --- a/include/console.h
> +++ b/include/console.h
> @@ -73,7 +73,7 @@ int console_record_reset_enable(void);
>   * @str: Place to put string
>   * @maxlen: Maximum length of @str including nul terminator
>   * Return: length of string returned, or -ENOSPC if the console buffer w=
as
> - *	overflowed by the output
> + *	overflowed by the output, or -ENOENT if there was nothing to read
>   */
>  int console_record_readline(char *str, int maxlen);
>=20=20
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 8b46256fa48..8bfc2a1b9b4 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -1151,8 +1151,6 @@ static int bootflow_cmdline(struct unit_test_state =
*uts)
>=20=20
>  	ut_asserteq(0, run_command("bootflow cmdline set mary abc", 0));
>  	ut_asserteq(0, run_command("bootflow cmdline set mary", 0));
> -	ut_assert_nextline_empty();
> -
>  	ut_assert_console_end();
>=20=20
>  	return 0;
> diff --git a/test/ut.c b/test/ut.c
> index ae99831ac8f..7454da3e001 100644
> --- a/test/ut.c
> +++ b/test/ut.c
> @@ -59,9 +59,11 @@ static int readline_check(struct unit_test_state *uts)
>  		ut_fail(uts, __FILE__, __LINE__, __func__,
>  			"Console record buffer too small - increase CONFIG_CONSOLE_RECORD_OUT=
_SIZE");
>  		return ret;
> +	} else if (ret =3D=3D -ENOENT) {
> +		strcpy(uts->actual_str, "<no-more-output>");
>  	}
>=20=20
> -	return 0;
> +	return ret;
>  }
>=20=20
>  int ut_check_console_line(struct unit_test_state *uts, const char *fmt, =
...)
> @@ -79,8 +81,8 @@ int ut_check_console_line(struct unit_test_state *uts, =
const char *fmt, ...)
>  		return -EOVERFLOW;
>  	}
>  	ret =3D readline_check(uts);
> -	if (ret < 0)
> -		return ret;
> +	if (ret =3D=3D -ENOENT)
> +		return 1;
>=20=20
>  	return strcmp(uts->expect_str, uts->actual_str);
>  }
> --=20
> 2.34.1
