Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FADD3ABF5
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 20:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7469889387;
	Mon, 11 Nov 2024 21:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLovTAxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFE98938F; Mon, 11 Nov 2024 21:45:09 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C16D8936B
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 21:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7f4324503d7so2286998a12.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 12:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731357905; x=1731962705; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBYZ+1yLicWhvTkEbxs3eEqwvfEAmco8ZnXskuPUY5Q=;
 b=iLovTAxZDKlpZ3A4H4egzmxYUd/V/PDJmPr0B1XXkz1A1ZfsY8SYrxuVezTqkUPfYM
 kQZOKlETPHt1tCgxkLnwKzijfTrNlRplyYFzctoY5N7SbMhGTEVMn6Rk0oGyPDaEGfDR
 qYkUtIkrTIb/+rozRPa4EYYfad+3y99V4nZc93Novxu1t1fWjj9wCnfc+Cz9hTXROeKi
 793OvpcBzqfKVarvpscM5jYUkbKZZJxhm/XhQUbrLyAmBQT+TlWUst87PRX7YzQ0rZfr
 39W9CfpBp83PM6l3JCryTwF1flsSpdZXY8fGOO+BPe1IfK6PI+wu90t1pw6SIdDaYuq7
 hcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731357905; x=1731962705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBYZ+1yLicWhvTkEbxs3eEqwvfEAmco8ZnXskuPUY5Q=;
 b=M01FNRI23hX8Eblt9QNbzgg4w4LSwB9reKE85nXO1DWAV6SeHbcbqnNmmXfWGo6D64
 y3/UKxsPv4EHYtn7IORz475LNie9CVK2N4fcJVU4RX2DqkeO1qF5rOBK0JO1HY6xaLhl
 lrK9r9y0JvawiJQLlzc8fDbIqWeHaygeArH0yiCw8+QhWUAw8xjILnCgEBjoYODImpVe
 6KnsXeI9rljtpgI+6f//uOev9Wbz81kjHnXH+h4SSX0m1pycPD3vMnYF+XtrhzlnImAZ
 8yp7gQn3ybehf9Im2BPIzEM/4pNLusPVW6GOS85/fZBT9KnP8tGwNwE5Llf9zOBOe2Py
 MVsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlU750h9dm7LeA8wOnILICmUI1sIk/Kr+MZs1Nr05rTHUIfA0XSoYwOpAruC09rnJY82ZIqf0=@lists.denx.de
X-Gm-Message-State: AOJu0YwHGya3ThbwzrGpml23Iy2K/yMulCD6S/AIvrNnIbeQovz2vLzs
 9wNpvlPuWfQFVU0ENJvDMQucRFrMAmLtlavZXrt52ugEda3Q0loIQRvKiZtQnkLHZI0sChuMsyV
 g59I292jDVye7f3f32cEk/wQNj/xluB34AD+LdA==
X-Google-Smtp-Source: AGHT+IGfwuccRsEk+AP20tqdAleJHbuTUM5GvqozUHg/dojlf6jkb8z9xaOmY2XdDf+8ZySWOT4ihP+d8EPLLvOh1p0=
X-Received: by 2002:a17:90b:2ecb:b0:2e5:5ab5:ba52 with SMTP id
 98e67ed59e1d1-2e9b173f1ddmr18863135a91.20.1731357905629; Mon, 11 Nov 2024
 12:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20241103035015.29486-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103035015.29486-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 22:44:29 +0200
Message-ID: <CAC_iWjKytfnvZai4ZT-s83wB5wB_rn-2Mkv0FTNov8BrBn0Lcg@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: vsprintf: fix API build
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, 3 Nov 2024 at 05:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Avoid a build failure when building with CONFIG_API=3Dy, CONFIG_EXAMPLES=
=3Dy:
>
>     lib/vsprintf.c:312:14: warning:
>     =E2=80=98device_path_string=E2=80=99 defined but not used [-Wunused-f=
unction]
>      312 | static char *device_path_string(char *buf, char *end, void *dp=
, int field_width,
>          |              ^~~~~~~~~~~~~~~~~~
>
> Fixes: 64b5ba4d293a ("efi_loader: make device path to text protocol custo=
mizable")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index e5802866632..c7340a047b2 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -308,7 +308,7 @@ static __maybe_unused char *string16(char *buf, char =
*end, u16 *s,
>         return buf;
>  }
>
> -#if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT)
> +#if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT) && !defined(API_BUILD)
>  static char *device_path_string(char *buf, char *end, void *dp, int fiel=
d_width,
>                                 int precision, int flags)
>  {
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
