Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D14C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BD682E35;
	Fri, 27 Jun 2025 10:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZL8nMtgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BC382E9A; Fri, 27 Jun 2025 10:13:27 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9645282E27
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70e3c6b88dbso14630707b3.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751011991; x=1751616791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7D1yIww65ZaWsuePei/l+uDCjjs3cL4VN9W0UN15kSw=;
 b=ZL8nMtgI3UKT2sBvx0gxBGw83ujQlFTc2RN67prB13/eUfuNCNk7kqXVjDqVun2phb
 3mrnsWY+o9wCt/A2oY1MyK2DJhs4xYRFgykyre+AwvJ26Mp2h4omlr7VqA9J/2+IX57x
 UqqiP3muiVTNsQ0zXkD2+cEEhFUjHrzPlOpRc/Ggk/l4R1dFltrb1mt5txVJlRYBPcF1
 QT32q2FzyYMH5L2vOcWI6pu14XjJWV6EoYNaYVMvVy4BXJ1iW7FIvQfDXPDG0drd0Ixc
 pRCNM8bUQiyn1gzsVx/xL8RYXl7n4HMVBl+QAUEOE7T4SAVTQfmS0RKSxEx7ukPMmNwT
 HBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751011991; x=1751616791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7D1yIww65ZaWsuePei/l+uDCjjs3cL4VN9W0UN15kSw=;
 b=sk0r9I/pu6ViW2EzSYeUJy+6RnVWmRMLHJlq9ZqoiJeoiwEMa3+3QDy+TOLvjpDyAp
 HTaH3I9VwSQz4QMQSxQuvO1sZDmQPoPpibwgGVDOQ5jHjtEC5i1OUPzMuD2hvgfLmFu9
 XB0wH2k+U6MLXqaiEzaQ/kNn3qh/eeC0z99GTYqudsJuJaBym1dtWdFSFLQYSScUlOd4
 nfMexdczeqeeU/JFoVwRqOZ/0lNvh/lKScRZd0a5PDME5I6VojuI/UNymDr82A7yB2mW
 Cz3flS0N0uYw9jONZIiFHuFdTCnNAGAD0olb8XHleqdLsaHwi+ja9w9c3VIVRKHHRldl
 9ZDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVouXLay/7tGtVek7JPLQqHZCBf5+DOrGN1QB+VVA2/lbUv4zyO0u0nRE+TSW4UjsrSG1XStEw=@lists.denx.de
X-Gm-Message-State: AOJu0YxHOBv6GDS4xiviLLMMSXdxKbQ0DbQBUq1i7z/OqpIcJSIfdAk8
 LpuGPJSSAX/0IFBsGwag8150wPonrNyQGO79VcPMNrUr7Z0rYGSgDS5K0Tch7MjrN8F7BvNFWLb
 L4wPzthMDi6kPhGPowJqL/mqWMIBsMtmtL//l4yQRgw==
X-Gm-Gg: ASbGnctnkYI2A9l/j06hbICGLbGgOABOLPVYfXMPym6/CAGkXaKtTkNfdcV6VUADODg
 EXDBHgy9oORnBVtEJfcf4VVLC6PB5l6d1oSAUD/0Pa4uCw6ppNgvtoQfWzCrqQ6tEHi2G/4azAF
 sTUR8ChBtRMGJ1B6v/gWaRpNhsbSr26RseVYeFh7A0Oeetg7OOgwb15WM=
X-Google-Smtp-Source: AGHT+IFOZnLBbeZKZhCD6TWPGWnNk4pl+J7dK+rI3mQO/tjNSPhtXIrr6p+FVB+67mGGRjwGDSeiaSihsZ6rUcKasGo=
X-Received: by 2002:a05:690c:1e:b0:70f:6ec6:62b2 with SMTP id
 00721157ae682-71517150f8emr34319577b3.8.1751011991452; Fri, 27 Jun 2025
 01:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
In-Reply-To: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Jun 2025 11:12:35 +0300
X-Gm-Features: Ac12FXyUEVygyn1Fq0r4FE8G8GUn7H1TohLwk363N4jewnVSKk1RKKI59mbky5c
Message-ID: <CAC_iWjK2-8BcnES55_8hncqyfLjVvzk_O0UF_U5RwphBcUUBww@mail.gmail.com>
Subject: Re: [PATCH] cmd: ufetch: Initialise size before first use
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Thu, 26 Jun 2025 at 17:13, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The local variable size is not assigned to before it is used
> for the first time. Correct this.
>
> This issue was found by Smatch.
>
> Fixes: 86d462c05d57 (cmd: add a fetch utility)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  cmd/ufetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index 46bd16824e6..bc5db08eee1 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>         const char *model, *compatible;
>         char *ipaddr;
>         int n_cmds, n_cpus = 0, compatlen;
> -       size_t size;
> +       size_t size = 0;
>         ofnode np;
>         bool skip_ascii = false;
>
>
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250626-ufetch_fix-54b741710142
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>
