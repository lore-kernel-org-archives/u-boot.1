Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016C1C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88AF4812D9;
	Fri,  7 Mar 2025 00:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B5ul5JG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4CB81335; Fri,  7 Mar 2025 00:31:22 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C35E810EB
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abf45d8db04so185806066b.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741303879; x=1741908679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9VRDsZQdLZoMOtjWarB+QG2h8bMmI+cuKtDv9xvuREA=;
 b=B5ul5JG8LnYW1Sk4iQM5SyEiPFkmNfwd4i7QpRdI+NcWqQUfkYywKALh988/me0jzK
 eKZI0L+OHK44/sAy2DZ8rfIly+4fBkXLrcsEtuGZzu8goZJPBMlLXiZB2oxPLsDoHcLh
 dc6B5kVRFrdhb9ycOhCEjqdd1pCgN/boLZi1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303879; x=1741908679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9VRDsZQdLZoMOtjWarB+QG2h8bMmI+cuKtDv9xvuREA=;
 b=OZDCoIz3WqtrhRvqzDlRE24l/92j5WWzE6iOCYKy+602Uhf60N3lnlAPizezsWSrB9
 CvsXpn32k+S4W/BFbXx3/poM016wMDgyKh9wSDL//v6kFcvMrGCjkYWakM4fCsMRbkcF
 oUomiAu6o0DuRfjj7TgIfkCbCn5gN+y5FzbzsVAQSaw+WUuwdwNcB+O3itXQb6GZd1mg
 XGtadrs5kPSOs7X9wacLh/RMlz+0OA0qgFcjUTp1P6Abb4VVPiuIS7OhhXd8I1YQef0w
 rKaZqw1CfWMV830cozxaCrN02mPHFJtd5ENLch9bEUjGRD0Ux6fMyHCF/JtxRPzjAWNi
 sNAQ==
X-Gm-Message-State: AOJu0YyJUjMdsL1nz1tZssHWtwsAC8fsaHoUC3cBtJPpxjfTdRfL9iwv
 uPXupkdNGRGDGivOKi0gdZl4TQfUXjs5Qmsff1K12cOwx+IMaefCKdOh7M/3HOBM3RLcZV7rHF8
 JIUJoeomdyqgJPajWc64kU6QrzO4yHYvYORpUuT/I0kaLay4=
X-Gm-Gg: ASbGncsdK9GpXORA5D+M38nZIJxX/LodYlQZCfDY7jAuMCJuxWNjNWh0pRg9NKnm4IP
 +hL95ApugGVImWHBfrFsELheVkBdHv+TBnITFMD/Af6PdIlaWHbhBi+2ySGEA4fuTt4IrxnBMSj
 Pc8OpDl/L4FpQA/EW+zSOQpieDaGQ=
X-Google-Smtp-Source: AGHT+IHZRpXTzFNdSxxxUzVLT+oDRtuYcQ55uZKS3DppJCuL8ahLnSSNeJgjxxmdkc8iSWDQHrfYinT22HKX/lZHFCM=
X-Received: by 2002:a17:906:dc8e:b0:abf:53ef:6584 with SMTP id
 a640c23a62f3a-ac252efb0c0mr112797866b.50.1741303879457; Thu, 06 Mar 2025
 15:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20250306201540.127646-1-hd@os-cillation.de>
In-Reply-To: <20250306201540.127646-1-hd@os-cillation.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 16:31:06 -0700
X-Gm-Features: AQ5f1JoI86acYv54nPxiJzN8b3evjF_66rIZvAS4462n_DidbWRWyrf1bP437Ew
Message-ID: <CAFLszTgc6qkiDryrfeasjuLKk4F2xS8BvY0act4DNJqKnxuOcw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Report an error for CONFIG_xPL_BUILD in
 device trees
To: Hendrik Donner <hd@os-cillation.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Hendrik,

On Thu, 6 Mar 2025 at 13:16, Hendrik Donner <hd@os-cillation.de> wrote:
>
> The defines for the different build phases shouldn't be used in device
> trees, currently they aren't even defined for device tree pre processing,
> resulting in build errors.
>
> Link: https://lists.denx.de/pipermail/u-boot/2025-March/582787.html
> Signed-off-by: Hendrik Donner <hd@os-cillation.de>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for doing this. You could also add a test to test_checkpatch.py


> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b8eb57f38c7..119916d4c78 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2692,6 +2692,12 @@ sub u_boot_line {
>                 ERROR("PRE_SCHEMA",
>                       "Driver model schema uses 'bootph-...' tags now\n" . $herecurr);
>         }
> +
> +       # Do not allow CONFIG_xPL_BUILD in device trees
> +       if ($realfile =~ /\.dtsi?$/ && $line =~ /^\+.*CONFIG_(X|S|T|V)PL_BUILD.*/) {
> +               ERROR("CONFIG_xPL_BUILD",
> +                     "Do not use CONFIG_xPL_BUILD in device trees\n" . $herecurr);
> +       }
>  }
>
>  sub exclude_global_initialisers {
> --
> 2.43.0
>
