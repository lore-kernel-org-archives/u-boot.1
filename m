Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DCBC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F19282B0E;
	Tue,  3 Jun 2025 17:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OvGR3W3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CD582B0E; Tue,  3 Jun 2025 17:22:16 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F30E82AA7
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso11198063a12.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748964133; x=1749568933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=up7mZsC/DpT4Vq1+mG/RlJC1nuUZqEa9RryuLF+8DiE=;
 b=OvGR3W3LjXVXGD8SHFtjmFydE5Ucl5rDSzniOTdSLxWskpS/R86tZr6jHeE6PfuUND
 qNa4fAI9KMzGPAGVpaaai/6cfqR5V67OINKOP6kcnZNfTFrV+Tt3N9nKAG0UVQYtsz07
 GHtyZ5z/YHANkvucAmEfINYMvV2ZejHPqirLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964133; x=1749568933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=up7mZsC/DpT4Vq1+mG/RlJC1nuUZqEa9RryuLF+8DiE=;
 b=S902H+KODITWcX5pqdbajiXORU0SLmdBwpAo6P8OSYBaeKR9EpMRBYxieVAkAs39VT
 dthkNJlFVWSj4gvf28BCcaOfTtsCs20g2Nnb7UuPvDZw2EoSd7JzC23XJtYY0jUWBJ+W
 /UvmGPpYu4RRKNO55JPpJ5xWuxuWPkgyNaUhqEDJdUCrGFQ6rMxf+S3mYujB8VRPzohG
 iDZEirfanHgnEx4vjrTkfHQ9ZeCGn1O9lNMEfZ7eX4CgwCFFUSu4DRG5FLvLWR5dvwye
 Val0L2lN5eTHYfI7TVCzcG7fUCv7m3O9arcGDVCObipkhEXITzOr82LbXtmZq1WXLk8L
 MFFA==
X-Gm-Message-State: AOJu0YxmWy4COrusZjUalxwVylAmQFs4Cww6hR4B1M3ghkx4GIA1iNhW
 +TWuKaxwGuvlU6/5tdG3zcHy1v6vxpSiHEg20w4CIJvcbwtiG9SYoTjRKg+JCmFbrQj89d8D2Gt
 ECe5egXUf+UzpiAalnAMxxBXxUhtjIyziZ0dDNh+H
X-Gm-Gg: ASbGncuUI13affB1Al5WceZv7yNn+ofv+7aeWuJ8uyB2G8hxGxsGVQ/CDpvn/sYKzVU
 Sk9Fc8/ipHWmyBbhuK4KEEBLC7dUAQesfCjpc/6yZjm3o61XhRAukK+y6Xe3Cn9EWw5RzMdQBjf
 cbshonH6dSA1NyC4ZToNr2cGU2tlCKabgbrQ==
X-Google-Smtp-Source: AGHT+IHaF5BzGFiONy2K0cA3ml3TTY4DAkYVlTZQK+0xTKe5GVMPF1KbxXRrrhOR6EBovlrEFFgAoS4YCcEdyz+umYo=
X-Received: by 2002:a05:6402:2682:b0:606:a26c:6f50 with SMTP id
 4fb4d7f45d1cf-606a26c7309mr3743814a12.5.1748964133537; Tue, 03 Jun 2025
 08:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <20250404135038.2134570-3-jerome.forissier@linaro.org>
In-Reply-To: <20250404135038.2134570-3-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Jun 2025 09:22:01 -0600
X-Gm-Features: AX0GCFvUsJqtrx6ypcr2S2pWpG0fYT5cVejv5u_UmgtwEcHoWOeaH7QHBDfcU58
Message-ID: <CAFLszThkuPyy+Z3gt1oo7ZDPo+60tzdqwevSD2HjA7KjLeNcQw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] common: board: make initcalls static
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
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

On Fri, 4 Apr 2025 at 07:50, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Change board_init_f(), board_init_f_r() and board_init_r() to make
> static calls instead of iterating over the init_sequence_f,
> init_sequence_f_r and init_sequence_r arrays, respectively. This makes
> the code a simpler (and even more so when initcall_run_list() is
> later removed) and it reduces the binary size as well. Tested with
> xilinx_zynqmp_kria_defconfig; bloat-o-meter results:
>
> - With LTO
> add/remove: 106/196 grow/shrink: 10/28 up/down: 31548/-33829 (-2281)
> Total: Before=1070471, After=1068190, chg -0.21%
> - Without LTO
> add/remove: 0/54 grow/shrink: 3/0 up/down: 2322/-2832 (-510)
> Total: Before=1121723, After=1121213, chg -0.05%
>
> Execution time does not change in a noticeable way.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/sh/lib/board.c         |   9 +-
>  common/board_f.c            | 223 ++++++++++++++++----------------
>  common/board_r.c            | 247 ++++++++++++++++++------------------
>  include/initcall.h          |  27 ++++
>  test/py/tests/test_trace.py |   8 +-
>  5 files changed, 273 insertions(+), 241 deletions(-)
>
[..]
> diff --git a/common/board_f.c b/common/board_f.c
> index baf98fb8ec8..a1bb8a01be5 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
[..]
> @@ -1049,8 +1056,8 @@ void board_init_f(ulong boot_flags)
>  /*
>   * For now this code is only used on x86.
>   *
> - * init_sequence_f_r is the list of init functions which are run when
> - * U-Boot is executing from Flash with a semi-limited 'C' environment.
> + * Run init functions which are run when U-Boot is executing from Flash with a
> + * semi-limited 'C' environment.
>   * The following limitations must be considered when implementing an
>   * '_f_r' function:
>   *  - 'static' variables are read-only
> @@ -1063,18 +1070,16 @@ void board_init_f(ulong boot_flags)
>   * NOTE: At present only x86 uses this route, but it is intended that
>   * all archs will move to this when generic relocation is implemented.
>   */
> -static const init_fnc_t init_sequence_f_r[] = {
> -#if !CONFIG_IS_ENABLED(X86_64)
> -       init_cache_f_r,
> +static void initcall_run_f_r(void)
> +{
> +#if CONFIG_IS_ENABLED(X86_64)

This is reversing the condition, which breaks link and coral in my lab.

> +       INITCALL(init_cache_f_r);
>  #endif
> -
> -       NULL,
> -};
> +}

Regards,
Simon
