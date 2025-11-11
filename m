Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76229CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D708F83AEC;
	Tue, 11 Nov 2025 09:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s/SdN/br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFCC83B9B; Tue, 11 Nov 2025 09:31:50 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B7FD83AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7868b7b90b8so37366507b3.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762849907; x=1763454707; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yxIxCgHjCkCFKfqW1hXaAY7fdM12G//7xzGJb1mg1qM=;
 b=s/SdN/brQMzpFPSXKF9xApN0vmhXe047joiHRkcBztxgqN5uJ84p9uMSLQI5nhPVYD
 NH8h2UUTQXktnrX79Fa3QdxgaorKoX12tNa6yL5VdSnxQlJtrIASPTXsFogz+BsahgKA
 EO41X/Ji5SLpxFK8z4brycQEfs2oT6wuQ9BVgwjdeLsqCB1eFHZEgnrDRp2ZA1EP5csC
 7a/sK/kPoJ8z+Zu/4wRMfu8+8IXIsDveDibRlHYjogXzfcpqzQSXjtroHtR+zn9H6IRB
 r5OUYjq4P95Q5HLzpAU2Kqof/R2lQ2JG3AgR6OAx3PwapQp3ShbBYjH1E8DpiQuliWD8
 WsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762849907; x=1763454707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxIxCgHjCkCFKfqW1hXaAY7fdM12G//7xzGJb1mg1qM=;
 b=MEF9NcSnFPtMZEGpEtJmuTbu/HhZpEUpTcw3EF8/z94IoV2zo9sHBaSuortLiUj31u
 0vlyGyoZ7ewHZw39UgtmYAaiXK2UgP6yTHrkxNv/liDJYAiD3ShzTo1bqf3KH0U8/d0f
 +HL6/sEoehzQkDsakL0UChhwNNDQC39eqjJspqXWdYt1S6PZdCSr7cafcS0Zh2hYt2BM
 V4puaF9YHjWxOQgowckzgt9U7Ee7TCyGdNvnu3gQmlmZp8mCl2V8iCw6RMxA4fPIuUtS
 33ZPBKaidoWD+ja8GJkbCwsY2mB3Y2fhGopGAsJBoEPw9HZTJgbw7MH6MNEh+Jh1Yd3d
 CGKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcoKEmFUOv1zFLzNyRqlwVDRXYqfrKgL8Q1VJL2Dc74KbhL9Adh0MRGncDEo+j7HO2G6v5XyA=@lists.denx.de
X-Gm-Message-State: AOJu0YyNSAJvvDGxsxHqwhrppPKDKAuDTd96E85yjbga9kAQGRJfpOki
 7I9pc/ZyctIuoNoT4h/eV8hhsuncVcRUmS599Agd+ABo8n1MmszJmepjYrvs6Xgno4mNwMKmPmW
 IsQRKpglQ3GUfWQJ0P7siFVGBsxBimTtw7bxl95hluQ==
X-Gm-Gg: ASbGncvJMmtaEze4eOL3peeJHCfi1xrUXXCke015xQ2Lnxv8UAp8D0Xb5m2oX3Nv9Cx
 phyd5DG9mM1qnmlt/NCagKiLFQpI9rlTsVwv9Mfoo8EGq1BT20E7zQep1r8qDHEvbLQR++LzfVj
 p+kjM5zOa4UozzpAkG4+1zwZxs9gWGqWI9A2Mjwluh9PGq0KKad96RK+COpBWoFvfpGLak3Rn7x
 Ul9lUaneUXWMVXSHgo3fYwbF+IPD9RR8bvit6SRIl6NcM9eQA2U9t8o9qpjaeq5w8JLgLgAKpxA
 GnL9USvqGOKK5qMKpSE9FXJrnsp8PH0YwwSkxUdlUzqszi+R96YX+SFew0VLkA==
X-Google-Smtp-Source: AGHT+IH8uODyvDXlLst/v5EX5C4EXtFlkeLOYGmG+CzR1Auh/Fe7gZ/RpJiMmZARsbVgPKtLolp8XrAkT1xe9w40LV4=
X-Received: by 2002:a05:690c:670f:b0:786:61c6:7e70 with SMTP id
 00721157ae682-787d543858bmr106074357b3.38.1762849907386; Tue, 11 Nov 2025
 00:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-8-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:31:11 +0200
X-Gm-Features: AWmQ_bmJvOyiBlh45-vRnM8oSEINE-4T_QfM9QGiYXkbPTZwWlcyAd_ZKKK3we0
Message-ID: <CAC_iWjKmwO=UGpGoHG3E=P+6mkSBS1E0n-WFxX0SNj6nTwC7Mw@mail.gmail.com>
Subject: Re: [PATCH 7/9] common: default CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
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
> For some tests the current default of 0x400 for
> CONFIG_CONSOLE_RECORD_OUT_SIZE is too small.
>
> Raise the value to 0x6000 which is already the most common value.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index 0c25a8fc866..47d17f4e7c6 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -26,7 +26,7 @@ config CONSOLE_RECORD_INIT_F
>  config CONSOLE_RECORD_OUT_SIZE
>         hex "Output buffer size"
>         depends on CONSOLE_RECORD
> -       default 0x400 if CONSOLE_RECORD
> +       default 0x6000
>         help
>           Set the size of the console recording output buffer. When this fills
>           up, no more data will be recorded until some is removed. The buffer
> --
> 2.51.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
