Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25107CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A59583AEC;
	Tue, 11 Nov 2025 09:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FlKT6Dl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0760C83E36; Tue, 11 Nov 2025 09:31:07 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB1183AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-786572c14e3so37978957b3.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762849860; x=1763454660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SjrGmcln1b+l5tGcqaKUtHN72tWF1/WRQncbXhnIJ/c=;
 b=FlKT6Dl6zJK8kTJdg78/0vEckbsGPpHEdhxJQT2PY+HE8cixjxbJ6tmipAX/DPsOmk
 sNsNzmg27nojGorWlUJSnwUZLuqWy7KO9VCNussWRK8pCCXV3hSwLfrjJdge6zcAzOC8
 fcOcVBK+o2cbCIifOp6Ge6VDmoVp4fqqNSnlG/wTd4o2WwX+z9Onv6YYNeWJyaObrb+i
 UYQY4i04DPXxru1ztBRCd7OnjQfFWZkPWEgsBXWk1KrwfDfkFSh/WfuNP3Wz2f2Q9Np2
 N09kBYV/n5MkxjCX51zyKKJJle+XMZGYdNhHs5GTzvUky0lOve7oJKifOe07SsgTUMNp
 t6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762849860; x=1763454660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjrGmcln1b+l5tGcqaKUtHN72tWF1/WRQncbXhnIJ/c=;
 b=k6XOxssddoRZYYOF/pauxBAobyeIZu6VI3CZoCqKHWQrYOxDV0swG/vLxMsKsaP4HM
 0LS2RVSDoL96ZLWQo9UwytWsXHJe07tP7P8UPpQf4qFI3B2rt9m3tzAI9I+5plX1WCSn
 mJ99buXe1R6fz2dGPhSinQUGiSFp2Eshp8qW1o3ckD6VFlOtVLOBqAh8wELGBZER0daX
 FUYSw8kWHOAs3cMc+jo9qWn5WtyE6bz6IsdYrhmH9UMgQIdCFBIEJ51Z2bPB/wpevLk5
 SmC1cX6hBGR+e+Z644qAkUvRvXV7nPDerHwO3qV19nb2fm+DCrTcxjodpyBW4affFfR0
 zz0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWal5uzbMXASqQkH26+Xjeyzr+R45EgPuGNWf+X1MbaPm8G/6XzwR6fGqCrzafHNUIG2XCSxnQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywml+zRzCJY7v+FR6pau81CVcnkvW8208W9UwHba4YTGsOtr2E4
 iBWUDo9MZ9ZNdvuN6RY8DAyb97If4BrElbt+1ob0wzn1Yh7RGgQiwBIFoj2eP6SNF+E5HLzGuuJ
 4lVnGdSaWptMV4zPQmUTy2KXaYMumhmjdSZICMiWj6w==
X-Gm-Gg: ASbGnct7KaohUPpgUELWCn1modXLuV1ai4Vl50lIqG9HlcdKS1ssJ1nusIftEmbkpZz
 p/r2haqXlBiFafn/9rz6rNM3y4Tg9rZxO+OkkhAaAF6n8AFJAi0yBlS2tYumlwtxqgyH4xbBayQ
 OZ6jwljcIpWVWHvchW6u82OZRF1WmbwZ+EOstgV+7F8FMMDtfvK0boBvrPYTsUR/wnZK6fU+m70
 NNNVqJAYMiFUJM0AHLiNuC457z1qVTcmWzRQjGd4Nu81qcMn9CWyqXlmTlHxUzYBgssoIzFu2ah
 Ye/G46Vy3C6Mcs3/2RdkRHmNUBeAaiwnYUM6iozL
X-Google-Smtp-Source: AGHT+IE4B+iWAytcLDLL19nqBjLXyS9UXDzSf2j1GOW3KKq4v4vOgh2PxAgvCmEk4iwhHfMEL+xZZKav6ZrXguvmPME=
X-Received: by 2002:a05:690c:2f82:b0:786:7797:6d73 with SMTP id
 00721157ae682-787d543da0emr72769157b3.40.1762849860227; Tue, 11 Nov 2025
 00:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:30:24 +0200
X-Gm-Features: AWmQ_bkglcFU_EftT-QrzUXAC8lpv_hW0NhtY6QzTKOD31g78HL-BdDxc2SnBOA
Message-ID: <CAC_iWjJwOwm+Uno4ULvna0wSKZYbKVgC8E-NF6+x_Q=EtvnEZQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] test: cmd/bdinfo: make no flash assumption
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The location and size of flash is device-dependent. Do not make any
> assumption about the location and size.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/bdinfo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> index 09f44ee41ed..214b237152b 100644
> --- a/test/cmd/bdinfo.c
> +++ b/test/cmd/bdinfo.c
> @@ -161,9 +161,9 @@ static int bdinfo_test_all(struct unit_test_state *uts)
>         ut_assertok(bdinfo_check_mem(uts));
>
>         /* CONFIG_SYS_HAS_SRAM testing not supported */
> -       ut_assertok(test_num_l(uts, "flashstart", 0));
> -       ut_assertok(test_num_l(uts, "flashsize", 0));
> -       ut_assertok(test_num_l(uts, "flashoffset", 0));
> +       ut_check_console_linen(uts, "flashstart");
> +       ut_check_console_linen(uts, "flashsize");
> +       ut_check_console_linen(uts, "flashoffset");
>         ut_assert_nextline("baudrate    = %lu bps",
>                            env_get_ulong("baudrate", 10, 1234));
>         ut_assertok(test_num_l(uts, "relocaddr", gd->relocaddr));
> --
> 2.51.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
