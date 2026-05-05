Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF56CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EDCC846D5;
	Tue,  5 May 2026 07:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YcoKmLj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0B8846D5; Tue,  5 May 2026 07:47:19 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D5C84683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so309772d50.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777960036; cv=none;
 d=google.com; s=arc-20240605;
 b=PGPJG18hFYVCR3uOzAzkP6Es5zgXqE6/qqs2rAbCmLK4Gm/O98/gZQ6el2ZaP23ieb
 drZcWxJwZhFXxH22xazkk7314RPP0qsVNECOA2BUovsS9J6pV3gyPw4pvXNDJZgEmhho
 V0D1BprD45SEwslqKsbaOWfJ8KzoC61ZlQp7KtKP3lD+qVod/rJGr1Wv4RhUF/xSndNO
 2DXVdrSDcd/ema4X174Hyne1UCHQrMllJE8CbaEF7KwRUFgDzgp1RS9RbO2vZdKf87d3
 mn0+I+hyqvxVD00cSTf2ce+5Q49q7Cp5zFsPixFzzph7jvFLCMsv1Io5jsXdKQ9p1j9g
 aXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nR4u5RzYDxoJ+x4zcm1oWW9Ugog3PHmCFbgJTBfqiwY=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=kYUsIGJhvlixhhxlrPQi3JbcevTnSLlTeRxWuIlT5K5V855GZwAjvgRzaQcqvej2tz
 FBdliJ6fwfY8EzX5f5Uc7mUD/+D+BLNPDtWCmN/gCIO7tyRPfW0O1i0yh6B30lSR18xI
 upaVesAtzyZQN420wxcWtW0MbJUeanlo1NxOTz3HSZFRWkaqZmsnveMd+4RN76eVKZki
 WEkASipeQqa2TCa6wrsTJdimVN8egGo0t8mEs50uj6DiljViLHsR791zmcw6Ih8k6tCR
 mU7wU2TPwmMhXfyYkrhzdNCacZvyPJvEuvMOX1iYbzsLrh0jtxErrid/PBoI4XR3AG+E
 uZXA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777960036; x=1778564836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nR4u5RzYDxoJ+x4zcm1oWW9Ugog3PHmCFbgJTBfqiwY=;
 b=YcoKmLj2U8jF5dHYGEwVtGzqbUi/7wbhkpVQhttgrFbltrC6vY62qCLiSMTFemsGx+
 8dTYbk2wUxM+YbjjRqeIt08//8WSGV5VLApCNFY4f7lARYxG6rFh8doc6yhGVCGLZONk
 lAgIGWkQAyDK7X0amL3DMcEy8P9Bv9INLmew5uC+eTMCF83yXui6ftxSS0RxktrPS9gQ
 7WuMhK0UgLsCD2Q+D2mI877An8Dq7e4U5BsTGsztMQ92AVevodG6XRsw/6TSgUJcwW4O
 rWTDJyqyHOJ2lSkaP1Qbba9/3rLyguGtWoLZXCG1HRUU2FZrJZUxsYjLQHAyqtb6s1sc
 qCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777960036; x=1778564836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nR4u5RzYDxoJ+x4zcm1oWW9Ugog3PHmCFbgJTBfqiwY=;
 b=eO32jAcKmrLltV1Vlg1PQ82d+spMrEQkPcB/Sy4oG7sdHWR+aYSSFW4KPbccJqPhKY
 aDi0bp9zroiYWNZsMb69kjX0bFLb+PM7uJ9h0aowFxLrqb0FW2iP/bpZLaNPfWdlVkYZ
 UElOGZqs+Vak6//OHh3h+mVyiqVJoLR8q21uzAIRUlW2Fs6CaqAwXPxQKEhnFSW/XDk7
 T654dRQDYNZ42EU5Gbe/Tn7GSc+VvVfissORBU4RCGMcRMjW/4BizQ8xH3ama8LMdMWC
 diQI86c1cIjLI+LejEyAukVbYffMOCEmJTDWECax9XdMdlixusTFb2CRRoQVBKJrOBOK
 u9pg==
X-Gm-Message-State: AOJu0Yy/LTgIs0KWh1hN0Dk+CZf159hRAmkh8j8hP10hfeVYj0eFxFUg
 kOG1buxc9gpWizDYbbX6YsZ7JfuNyP6lNwfo0b/K6Uk0FHl4mChmfQ61G+0veAL0v6WiqiusmeU
 ikGW8qVzbM6zJdtOjxpKF6NcAyO07o0M4SH9hjyJPEw==
X-Gm-Gg: AeBDieuwtWUqd8oIHrEwoHrMtHnj8SZr111QXioNXqcxoEubBCTFUCwc4B6gKlnKMhx
 E1VF55blc0C5RUKZsn0nZB7qH+nyjw4IYQsclW1PY4B8Uq0KetYN/P2GnLX4aRoScHqv5ODmnIo
 8bTUY3GJEi2hvrdfAvzf1rxSVi4NExIe/HWOrjEt5zm1ap7Y/aOi55uxnQRLWNlYf3hTRWWvMjP
 qUKDqnfGOqy8vTLaTf7T9p9lMJlhFASqnZ7d7ATMMobYRe103NfLY0Gr5pBLzRAgt8pDwD+moGe
 b5YY2aDIrLik9zutFmf79nD8rB2stupPHg8DGlMFl0YxpGHa/ybHUQAc5nJ2FvyyysyKlpYD9ZX
 bXzAiouE5n1+U0U6j/qqRDe34hAZ1O1Jwkc5vF0Q/cdNL/j87eBk99LAHObghhDp/Xn7cSYPmQd
 jdvZhyW5dYbggSOHW3WHfVwzT/TojDf4XgxkDvLYC2A7Db7mrfNn7f0llrgZqkOuIp6Xc2lHgD5
 sd8FwES7JrhtCfuZPm4v0sc8efIBkAZr3802A9V+Ic2OI57GKV3jKlbEteJwFHMqGLoX9PtbKO6
 bf07N6vLuhsflBcQWBmhtIyEBJ1D7fQ3kIVfZsVMJQzpHKWSYZcDjPYeoPsFjZ9tdeYnlyJK2cE
 rvfHt3nLG5BpsfO775Hc7zre5Kz4=
X-Received: by 2002:a05:690e:4385:b0:651:d199:51f3 with SMTP id
 956f58d0204a3-65c3da2aaa6mr10102344d50.25.1777960036402; Mon, 04 May 2026
 22:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-14-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-14-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:46:38 +0300
X-Gm-Features: AVHnY4IrMfqCvweqriSQ3i78FLu-B5YS397DEObWMhi0NSFPJRUh_x5m0j_p_0o
Message-ID: <CAC_iWj+eeVp6taRB4CV30HBVwSdmhEmoa+uioXWLvgAEJrZZ+w@mail.gmail.com>
Subject: Re: [PATCH RFC next 14/18] kbuild: respect CONFIG_WERROR for linker
 and assembler
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit ec4a3992bc0b5b659eceb44a9f8582b26f2c8489 ]
>
> Original commit log:
>
>   The linker and assembler do not share the compiler flags.
>
>   Make sure they also fail on warnings with CONFIG_WERROR and W=e.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/Makefile.extrawarn | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 2af90af594e..29b6aab5f72 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -104,6 +104,8 @@ endif
>  ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
>
>  KBUILD_CPPFLAGS                += -Werror
> +KBUILD_AFLAGS          += -Wa,--fatal-warnings
> +KBUILD_LDFLAGS         += --fatal-warnings
>  KBUILD_RUSTFLAGS       += -Dwarnings
>
>  endif
>
> --
> 2.54.0
>
