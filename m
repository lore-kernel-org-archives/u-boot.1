Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCCFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6904484694;
	Mon,  4 May 2026 15:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zlw5gIu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9813C8469D; Mon,  4 May 2026 15:00:40 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1DB684694
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so614100466b.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777899638; cv=none;
 d=google.com; s=arc-20240605;
 b=cZhqUssMP66aCSJQWfAZ6n47DSim0GJDvCWmKE59my2ZqAsCY0OEdEw7oNh0vIvQr7
 VGl5ZmXYkylUQJA7Y3uconSEAPdecwMVFtNxgYABCD5bUdLKq0LurVQeRuQARetyiNWT
 IycReE9Cj/dfeMFpzDbj55oNbvLi0rMoa5n2LqY8N4yQYSlgWtXJBnAVO9KHG0F8CWBI
 1ScR612vwwBI+1rpVw+0BVJL9pAWfFt74x4JqFA7kai9Uafq2kp14xhZgY31CU39L/3y
 ic6SCsbNok1R1lFiOBi5wWjLPNakYpB91W3QIEDY2McYP65JT2OgdQ/orDh6ayi+qIMi
 w8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B1J7oSuX7mVJKn2FLI5PySLXlgKU6eYLoILBX3LEUAU=;
 fh=r1FKHKFsmdGawySOdjSszQZccIlP//niBHTy1beuYwY=;
 b=J86i1DD98wHYgBkJRGqjU6+szTt4/y0pWHIpmO57FN1QQMNjBj/uU1g7M/WZ7GUt9l
 acxJgFT14WzKGLLdgmt7RDCYDtnpqd7U8WXj4FmZxzzEceD2hPI6I/hWsiT9BrUaVgbo
 b6JEiTFoKna6cBWq/WMVuLO38d7v2rNW7miDUy+Sjh1eSujd2AFOQ9TX4qanDnpcy3kg
 VTB3tCfsZizrg7nQBDrHSb8EeqaPPYepONWGo3G7PTtByrk5tvsxcj9Oua0l0sp6S1Op
 hqyLI43qbbItSzYI2QDVSUDzsYWM/j5/yxThG9ixIZcFyVw2FRZceFVrHbUZi7XrXgBa
 kibw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777899638; x=1778504438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1J7oSuX7mVJKn2FLI5PySLXlgKU6eYLoILBX3LEUAU=;
 b=Zlw5gIu39UURwZ7dNHXQP6z4xIFY/DooGuUpirkABs9FyNHKroB815H10ZnAjubJUA
 lNC63Z2O+2J5Ies3sMfLQ63+nqqpUqVFOS0AWpOvoe7UfkBQcUWPmU253Jcn6xw195N0
 YplZF6rm1XtrGmE/+rQC8oJMWlXe7bqt98/rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899638; x=1778504438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1J7oSuX7mVJKn2FLI5PySLXlgKU6eYLoILBX3LEUAU=;
 b=Pw+rWZlPfT39b0tqmca8CYImK3T1KlQpEaZHP0v7K/sbs0ykxIUQrLb8klGKEIW1P8
 /AfCX8+7jA8L/qerQFwvGqtc4qXONOxpI7gmzhetEM1R87Du8ulbIMgw7oRzhNS6D+JU
 RIUJhLekl+AU3JtRfbvDSx2TtQjSVN+ehje/9+441U3rqMRPjVlLXAefJXgDUvx405jJ
 REi0xnqW02PkgJnw7XxVmiE4zkUT7ZIN7KBvuO9ZrIxy4lsThJLhDkGP/+W+nNXdT17P
 26QDs+UEPXoGkZ4U/BFwEj3nSFDMd88mOCn5ZK24CPpGpEbsclS9WZ0w5y3995So5IFW
 Aktw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/c18cmA5k2XFXN7dyN2qLqLVpYVksOyKpNP2vkYhYwRwrCID4ZtoV/nEGQn1wuksH0LoL4Oxs=@lists.denx.de
X-Gm-Message-State: AOJu0YwIcNuarKskxvjYWEGpQtDt9fdEeV/vV19iZ4zNMz7ELhdlQsDw
 myx0ppmnwsD19fxHnoUsQ9oelZlMDfZTP/FCJKHd5v5jJd3x9yz+LYbItPwTvMMEWE83cAt/KZj
 J6BHP1ARpoTz3qPUIBYt1Y0A/wPdPJYJsI9edpm3FzjOLmz9OV5Q=
X-Gm-Gg: AeBDietJp5/2LWrsK7X1UQXu4QK773l4Vubmd6BQrQiNoYO68t/OoHgllo93oxEhQ0m
 QZCANBRpnNo+as2/wN5PFX+QLAUPXw2tMjZLpYiUNWX540IKjuIGs4yEGwupm4eELhnYy4CpTEl
 AtTdVzKIUlgGrKUQ2J/D8lVbLCr2qIG9sVIgNyBDDdMS67wjAasin92QrejUx3fuQnIoZ50Hg4Z
 +niIOHeMnT2dJIWvcQjZF5u9njQNnYEbeecQdZUs3hJ/LUaDeuvx/e1uLugvB7iJAFc6PS75xTf
 aIKdecFkFSOP5c7B
X-Received: by 2002:a17:907:7b83:b0:b9c:2c55:3384 with SMTP id
 a640c23a62f3a-bbffb846e81mr541791966b.31.1777899637743; Mon, 04 May 2026
 06:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260501143850.2714779-1-bdklingerman@gmail.com>
In-Reply-To: <20260501143850.2714779-1-bdklingerman@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 07:00:23 -0600
X-Gm-Features: AVHnY4Ia-VIXxNHpjHhQQ-id6w2RA9oLRNnZeW345CkR2VJZ6to34gtpDaUirXs
Message-ID: <CAFLszTjBqqq9dOW=hOrqCPzQUXpgFwB4e3ZV7tO5y7hyZqZXyQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: remove block from conv=block, sync in SPL
 alignment dd
To: bdklingerman@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On 2026-05-01T14:38:50, Brad Klingerman <bdklingerman@gmail.com> wrote:
> Makefile: remove block from conv=block, sync in SPL alignment dd
>
> The line that produces $(SPL_BIN)-align.bin invokes dd with
> conv=block,sync but no cbs= operand. The result of dd conv=block
> without cbs= is unspecified. GNU coreutils outputs anyway, but
> uutils (default in Ubuntu 26.04 LTS) errors out for files with
> newlines, including SPL binaries, producing:
>
>     dd: conv=block or conv=ubnblock specified without cbs=N
>
> Either the block operand must be removed, or cbs=N must be added.
> conv=block is for converting newline-terminated variable-length
> records to fixed-length space-padded ones, which is meaningless
> for a binary SPL image. The intent of the rule is 4-byte
> alignment, which conv=sync alone provides by padding the final
> block to bs= bytes with NULs.
>
> During build, u-boot-spl-align.bin errors silently due to '@'.
>
> Reproduced with uutils dd 0.8.0:
>
>     $ dd if=/dev/urandom of=/tmp/in bs=1 count=10000
>     $ dd if=/tmp/in of=/tmp/out conv=block,sync bs=4
>     dd: conv=block or conv=unblock specified without cbs=N
>     $ dd if=/tmp/in of=/tmp/out conv=sync bs=4
>     [succeeds]
>
> Output is byte-identical to GNU dd's output for binary input.
>
> Signed-off-by: Brad Klingerman <bdklingerman@gmail.com>
>
> scripts/Makefile.xpl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
