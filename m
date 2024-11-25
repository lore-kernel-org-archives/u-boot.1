Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86175D58060
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBEC8965D;
	Mon, 25 Nov 2024 12:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PXKoTtzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1BA89A37; Mon, 25 Nov 2024 12:02:53 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A888965D
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-72483f6e2fbso3635032b3a.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732532570; x=1733137370; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy0M23YSjY+w4UW2zNrPLvTpZOFIRvwPMsCP6oJ/P5Y=;
 b=PXKoTtzUeTg86v96jzkbCupDE7fZNGnYHhoX0tfOkTq2IlRZagS8M9pSs6krtjc3cy
 cj/fjDqg2KR6wXRJMaMRhrYgSs12Up+ZihjblmMisLFmrrxqTJYx77T5RGvL7ZIlUj3P
 6HhBzGNOK+YSUBuW/I1YgVOEAUWeMZkysMvfVgaFrCQgan0Wh8v9V0tI+iuDBkwTjn+t
 jX+nzE/f1GQFYozHyJVt5gRkXL/eGjRPfuFnBWlWY09FT1/XvKrMVQOvTlljTQokh6CS
 NmR+RuIjSKmUjYKc/QN3+D3HMexudSgEoLtUyndcml1WNzuBBWjwxTK9Mn/ITNarTocl
 WKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732532570; x=1733137370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dy0M23YSjY+w4UW2zNrPLvTpZOFIRvwPMsCP6oJ/P5Y=;
 b=O4DnSCW3sf58+gYiXnrR5SGmW2qwnWbvQ8222NNWgXwOC46HnkSTfQy6K4ExCatR6J
 5d4iCT9KMnmYKLlRncAzxoztPNF6CcLKSYVyGfAWH5vA1PfsT2rvyWrqQfs1Mt2qnahe
 fE13QFFOiUzGUOf79pZk+4VOBOHNHR4N8esO8A9aXGxNeQQAF2M9nGw/o+7xPWxBwFqQ
 fX9IrWIGxzaQyOfguYb7Fts9KDEUjmHnpL/0BukmRfEkZ56fyjFnH3qzqF/BcR62Fv55
 1fk1AJPEQpyveKfsVrmzK4sfD/Kg6JX4XgYKh1mxVa66AD0U1fFdnYnAzfSMo5BTInCu
 ozGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZHVu6ySfigP/d84UVruMZf987hjANfKTEOaaG4YFFmPGpUF/1C0CgIm5cT1PIWZFc0wxr+EY=@lists.denx.de
X-Gm-Message-State: AOJu0YxrMxr2VCIAiESI8GVicExuvwQzfqFLnVi43kAzEhYg0Cd7UN/y
 QTM5EJS5bexqWZSwuZBlOWCQETDkLlDv1Y2MhMbcFCgnTuV+V9pNDEl0nHqGIlvpLzFJJzxHKzo
 Dc51da/7sadJ18THC2QVkRsyLvP7yyLK8hJZhwQ==
X-Gm-Gg: ASbGncsyLXyQYyO0CEqw0+jnISLdFgn9keMPhSHXXeH+/LE7fABl0umubR9BMDUQ3gx
 cs54aA/plhhLCZewILv+gxQsDZxtqvA==
X-Google-Smtp-Source: AGHT+IHvzHtANY605NIk3G3uRb6wHBFCYMVvda/UaLHAfMkUzH3vNH0+pm4D6Tqriju/tK1EIdBnlY3EnxJS1MWwnDo=
X-Received: by 2002:a17:902:da8c:b0:211:18bf:e91d with SMTP id
 d9443c01a7336-2129f5f3176mr169636135ad.27.1732532570042; Mon, 25 Nov 2024
 03:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
 <20241124-b4-efistub-arm64-v1-1-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-1-3e33f0340071@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 13:02:14 +0200
Message-ID: <CAC_iWj+ukUtdBPOmUShG=0NaUYgrMFYD4U48gu4j49pYvfGXiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] cmd: efi: avoid unitialized read
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 24 Nov 2024 at 22:27, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The key variable might be unitialised when accessed for the printf().
> Zero initialise it to avoid this.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  cmd/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/efi.c b/cmd/efi.c
> index 687ccb520428..1fb67a83aae5 100644
> --- a/cmd/efi.c
> +++ b/cmd/efi.c
> @@ -220,9 +220,9 @@ static void efi_print_mem_table(struct efi_mem_desc *desc, int desc_size,
>  static int do_efi_mem(struct cmd_tbl *cmdtp, int flag, int argc,
>                       char *const argv[])
>  {
>         struct efi_mem_desc *orig, *desc;
> -       uint version, key;
> +       uint version, key = 0;
>         int desc_size;
>         int size, ret;
>         bool skip_bs;
>
>
> --
> 2.47.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
