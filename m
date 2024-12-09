Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56141E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 06:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A11AF893ED;
	Mon,  9 Dec 2024 07:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bUITYfy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B1A894F0; Mon,  9 Dec 2024 07:59:12 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8174893D9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 07:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so1336220a12.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 22:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733727550; x=1734332350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oL31BuLrW+H2SUH5TwL385oGG04koPgPnJXyMBJ1dkM=;
 b=bUITYfy3ukjBIda4F9iZ2XWs5k35RjWqgsfT7QY8/Me/+ToEfxcoZpLSBF3SkeGNN5
 6b0DXJ8N4tiMFG765AWJya0gUUSA6nhUgH8XUlwm35RDCbEcTPn2WgYc3lPwHJs017nA
 JV5EJPIM52biqiDSyyh1feUkA5hSjMHhvEUzt01sNbjXy0sFEy1aB3+dcToouHPeFA1C
 g3Og+hLK4EmSHObsKW38A2mYN+EGg0Zy4YWzh52DBlBeHEU2TDw/B2SsxjGqFRVijNeH
 NUZHz2kHYqtQRaWkJptsfgTfYweXLdbBaGOqADfXZ+q4Mjy+0A8uVjdbyaPmOJ4278dW
 5KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733727550; x=1734332350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oL31BuLrW+H2SUH5TwL385oGG04koPgPnJXyMBJ1dkM=;
 b=OCAsWfMtwFl9rFj8YoBzyWsTh297gPIS7bkGhv6CIo7dN05Zc7eRdQPhnodo2HWJRF
 NUJDe4CSdrUglYN21CW8kkKcGbPLTQUmn65BtKgaLsxrS6cUbdbaR3OBje5pB9v/1v9W
 JH0JsI1QxbUq/nLlSTli/yp9bsoeFD1Wtnt/fwhvvuzFldHWIBg9Hm+d9COh5FbMs+sY
 kedijFKEFav0YzBgBysVg9MIrT3M2ClxE5tW6uskUbAqh2Uc7IYzS9b8xRofR0wNsaDk
 +Wm72L6gzc7Y+FS27rqG/Vx//NeZ2yo2p3efB5uLeQ7pY6p18FFB+Xy1mRfOxaXR5Q0L
 pzHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYh1pJCng1T2usSNyLMzVhDbSTHAzE3XqTPMMohwtVlvgczJRiztyA82BPZhhEgu8XXmVPxZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YzrpZZsUFCNyBOPsVP+nhgpBzjcNSih4TQHLBITDPOEdmxsVdxV
 jbnKv+vl0FYl30jhpNV+5fsVyYZk9jkq6AjGZCxpGUhKkEJ9XhBt9bQpkLrvnsd1PawfBnd71G+
 M34pRlBm24tafcnbWIrRZ1tG9i9YqWAHRJw7b8A==
X-Gm-Gg: ASbGnctzpjhW0Hs3IL6Pih13/QhotYlSxvfMJE8NYWsrpxSHcC+zja8aD+Km/V8HFJB
 7m+xiGqqC1BqLEvFFtZ1l1WDO56KXKfH9HySn
X-Google-Smtp-Source: AGHT+IH+wtxrQbrumBoFFUfstwuLg0wKGOUzUmFRDk+7UVrC8j9fMdG+MUBSahcJ5ftMnmv7L6jS2D6P6zMvXDhut1M=
X-Received: by 2002:a05:6402:354e:b0:5d3:e9fd:9a16 with SMTP id
 4fb4d7f45d1cf-5d3e9fd9c35mr5580577a12.12.1733727550068; Sun, 08 Dec 2024
 22:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-2-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-2-semen.protsenko@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Dec 2024 12:28:59 +0530
Message-ID: <CADg8p94F+qbos9tNUpQcRGy_xKVUnpFn7hcj+HsemVsDmvhavg@mail.gmail.com>
Subject: Re: [PATCH 1/6] lmb: Fix flags data type in lmb_add_region_flags()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 05:51, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> rgnflags variable in lmb_add_region_flags() has incorrect type: it's
> declared as phys_size_t when it should be enum lmb_flags. That
> copy-paste mistake was firstly introduced in commit 59c0ea5df33f ("lmb:
> Add support of flags for no-map properties"), and then copied further
> into commit ed17a33fed29 ("lmb: make LMB memory map persistent and
> global"). Fix it by using the correct type to match struct lmb_region
> field.
>
> No functional change.
>
> Fixes: ed17a33fed29 ("lmb: make LMB memory map persistent and global")
> Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

So this is the right code for sure. But is this fixing any issue? I
suspect not. If so, the Fixes tag should be removed when applying.

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>  lib/lmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b03237bc06cb..713f072f75ee 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -200,7 +200,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>         for (i = 0; i < lmb_rgn_lst->count; i++) {
>                 phys_addr_t rgnbase = rgn[i].base;
>                 phys_size_t rgnsize = rgn[i].size;
> -               phys_size_t rgnflags = rgn[i].flags;
> +               enum lmb_flags rgnflags = rgn[i].flags;
>
>                 ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
>                 if (ret > 0) {
> --
> 2.39.5
>
