Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF847D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1F283C72;
	Mon,  1 Dec 2025 18:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b4MqVAOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E27A983C93; Mon,  1 Dec 2025 18:36:24 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D70B83C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78ab03c30ceso39166727b3.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764610581; x=1765215381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LSIkJZzxgEP92IWCSvdhNj/A091Zgf2r2Udqgo6Sx9w=;
 b=b4MqVAOs5prvAPXWDSGmpY5RU78kndm+xWz+2IHpt1NYtkLDByaOCXdxWiQh49naUz
 kJI5MY6dEG6cvBw5Wj8oG+vMDecxz1MSsa7d+PQLigVtfBensrzT5sDFNua6DQMrTUBM
 uFKRJXHWVxEQ+eCMaQiZW3nfm7xtacxJPSqz6tTqU2duPdbC6SjY7sAMuU/cAu2FeUh8
 Q/tDbuFKj0na7ZFUN5iNNRMeFx4jhsl/0VVmzosaAfLmrFnTYK9pWD4vtn7B2HSduG/v
 sUf8D8uiE9Iw1+dQLbS1GYJGrSm5cZiVIb5l6/I2PtZHKvzPmtw19cI5U9qXIaTAa3uR
 x4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764610581; x=1765215381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSIkJZzxgEP92IWCSvdhNj/A091Zgf2r2Udqgo6Sx9w=;
 b=RomZ1xnvlgzWLiXiR7LtLHg+bLyycQh49m8ZpiGnHSe0DrA6uTcSuuLvgoT0T4CDlF
 3/pVewncReJFoszuIoo+OvsWHccc8qOjJ9MtZzRMGaHPjnNO0UzP1JVSEnSU5kSNzFnP
 9gcAScr5aNwXjEl2+Et8Yzg7nub9WqbLbAkl5AEnD2ibdiw2uQffFcqkR9DF1K9vV8k6
 bxu5xIIRh5PUx1V+QZXLPM2waAApmUCW63R0es6YYMInnpz7aWDPOtXm6KRxfRbcMMI6
 QTzRJqq+G9bHuPdg+ij2hKQmf+5VTZFLvv9SKH2tmxQt9vKTYGEujY6cuLMzw1kNfSz+
 eKUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeg+4bj3u0OWZ5h0bpGBU/PVEV6eR/4c6GBKbzifiCCq66CghtsoYKcH8a5K0WEXQPh0Wujyc=@lists.denx.de
X-Gm-Message-State: AOJu0YywODacVuwXO3NlI9vcw2olHDiAEJYydrZLuMrTtwvBKxu531Mx
 2Mm8FU/ZDJtimCCP6pC+wlb6AUv3qqoVgJDqGPkbEWKMc8kZamRNMj7Khua7OUVoRrfUaUYTL89
 tfLzU5pkQNnl0cA+awIUQTIDvJhzP0Xb5v1RUBAbA9TO1T7jWDuqIJ/NjMQ==
X-Gm-Gg: ASbGncttzwTViziGgk9wHqXgt6s2xAH8U1z7Cxa2vB0IIzC+yFzmULOg5/M7MjNxoWi
 i0DMFDdlge/WzxrtkeKmdErZnFKbAs+Eiby5UrlKs+fkY42kMSYFq9viVKtTiCZMY6irYmeY2nj
 RM9GUQubqUQBhBLYPzxWEvBBPPow029LtN0VPdCrHKPSx28BYiS/C8TxevAHu1bs1t2EojfIEr1
 UJAykKsAEAnIB0eXodhdpPXNB+KOpklmPGo+a6IAdzEL+j/CIyE43GiXQdGb3TqKHFOfJckAEDQ
 6P9cRMqnSLy7nZoBZhN32Sg30lRWeZq7Dkcz3RySBIsBxiwrFKrT+scp1jjWMQs/1oEzy5WAbs2
 psHpGlg==
X-Google-Smtp-Source: AGHT+IEz537YdkO5m8/Tkfaq0AAG3vkJpiiObUXvdp4swlEnSrFqgTb2+5bpFGC7ttWVoM6N3wWA+Yzm2cUfFaeZ2qc=
X-Received: by 2002:a05:690c:2781:b0:787:e9bc:fa1f with SMTP id
 00721157ae682-78a8b54d8cemr326146677b3.46.1764610581093; Mon, 01 Dec 2025
 09:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20251201151724.338924-1-zfsdt@canonical.com>
In-Reply-To: <20251201151724.338924-1-zfsdt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 1 Dec 2025 19:35:44 +0200
X-Gm-Features: AWmQ_bnL4gCybx1l5JcPUan3emjT7p77YqUMKKix9N2ge3rN_wIQEh9SNgSpqWs
Message-ID: <CAC_iWjK4Hqgzt==CTZRGvJ50teFe3SJkiuyCUidkV5Sdz1DBgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: lwip/wget: avoid NULL dereference in
 _set_cacert()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Michael Walle <mwalle@kernel.org>, u-boot@lists.denx.de
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

On Mon, 1 Dec 2025 at 17:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Running `wget cacert builtin` leads to a crash in _set_cacert():
>
>     Unhandled exception: Load access fault
>
> Function _set_cacert() dereferences variable wget_info.
> We must initialize it before executing the cacert sub-command.
>
> Fixes: d3761a31ef09 ("lwip: split net/lwip/wget.c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  cmd/lwip/wget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/lwip/wget.c b/cmd/lwip/wget.c
> index fc9bc11cd83..4883ad61bce 100644
> --- a/cmd/lwip/wget.c
> +++ b/cmd/lwip/wget.c
> @@ -180,6 +180,8 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>         ulong dst_addr;
>         char nurl[1024];
>
> +       wget_info = &default_wget_info;
> +
>  #if CONFIG_IS_ENABLED(WGET_CACERT)
>         if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
>                 return set_cacert(argv[2], argv[3]);
> @@ -214,7 +216,6 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>         if (parse_legacy_arg(url, nurl, sizeof(nurl)))
>                 return CMD_RET_FAILURE;
>
> -       wget_info = &default_wget_info;
>         if (wget_do_request(dst_addr, nurl))
>                 return CMD_RET_FAILURE;
>
> --
> 2.51.0
>
