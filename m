Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF88C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 06:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFF1817C4;
	Wed,  2 Apr 2025 08:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Arii0N+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BD481F0D; Wed,  2 Apr 2025 08:20:18 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBEC81703
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 08:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e589c258663so5882516276.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 23:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743574814; x=1744179614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WybUiIDzP3E1lzlr+74XPHZqPj2JRu3hDxVdo0QHc50=;
 b=Arii0N+s1COb6uBh/kKNNSswnr7SnF9PIaUGN4lhdzF+HbuM/jIV5n4YNvPQH2Flvv
 33DXhNN5dUZ7qQPriYRLT6Ayxxh9SnW+Ws/sm36YPd5rjXPrAw6BBLLUvDpZz+mFUJJZ
 hHZ6+mJ1DbcYdSBylMz1uJpElYfdblqJuRY5Hlyh474L4jdlPoXDAJfRFfdw8AggLSaO
 6MUMXBBI17dqoK9NAHB+Na/YZ9R93OQB52KzXFkScE6qtmaM7Pe8YOulgchY0FxXBGqf
 8sr0ZDrNRmcSJzcKvhxvJBDBSVuAqhIvQW7bO823uoeUS54xAl3QyM5j3bDQUpwgrmNB
 u0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743574814; x=1744179614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WybUiIDzP3E1lzlr+74XPHZqPj2JRu3hDxVdo0QHc50=;
 b=mtQXDW0CIx+r8zhEKy0OhxbObcp2T6dYRkazCxprAGU36mvbLjSuia5jUlcbYDZ6rG
 WWvVMDyKmgJPjd/B8dCY53sxeUD/Sch4BDH+DFi8jefEwaRJ2ow0xIsh8pafKixLIY2o
 KjMvvGBwRceDBQBUo2kWYC8jLO013POWiGw6vyK4R0KjKVrjlVfys2hcqJfyawMzlNSn
 +lgA5a0jPeAB0y9H3PZOu4pnD/d3aOoPNOmWqBgMs7Hm6OGHPbDIuvjC7+ZyhkCBJ6bt
 r9YW8QkhN2VH3hOUHXHy0MYmK8bsbRjDt9YRPrQlvsVqWyUfM5ezo7auS4R6UcqibArR
 hdrA==
X-Gm-Message-State: AOJu0Yzuqc/vdXkJp3bUOp7uy9/mGe/zSNNeoDPdl8tWuKCGq3aQeD+E
 c+0ddXSDe5LA+yJS+6l+PxQW8MOe3jKqLfn6Ys/M5OmzM66ZpCnzqAmUS9GVNUNGY5UmvDcyXTt
 maVXx/VaUaj+maeenrXHS+Iu0AD7dR5y4mzts0Q==
X-Gm-Gg: ASbGnctt4XwAjw9UDz74i3UONhmVdnGwE8Tpm3JoorHUh4Had9opNkZWcKKkyzfJW9N
 ooa0ilQojSJIQ8mddiZt5lSxzFUeyBbzjnQdMJx0iudSO2B2Bw3D9cmhE2geB7i1O06ZIL49AoB
 D+ZKE7SiNxYuSc7R3v/jtEWtH7
X-Google-Smtp-Source: AGHT+IFEuJ3GlOAi+QwokzsYOOaHBdV6MSrNCIrwt3jfBVseLou5NGRsySVTLH2qudcay5ZFR/Y4NXVZFMv9otJqYUM=
X-Received: by 2002:a05:6902:1b8b:b0:e6b:75cd:a36b with SMTP id
 3f1490d57ef6-e6b8391c052mr19667262276.11.1743574813850; Tue, 01 Apr 2025
 23:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250401212821.1363793-1-sjg@chromium.org>
In-Reply-To: <20250401212821.1363793-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Apr 2025 09:19:38 +0300
X-Gm-Features: AQ5f1JqJYiIwcq2K_7UlfKFmz0EmJE6KS9zz_DPArxcVRJYtZFeQB6IbOggrnl4
Message-ID: <CAC_iWjJLe6VF+gze3gCe_WTLON+5Xe7Kx3v3BgTCJ2KkX56f7A@mail.gmail.com>
Subject: Re: [PATCH] tpm: cr50: Support opening the TPM multiple times
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Wed, 2 Apr 2025 at 00:28, Simon Glass <sjg@chromium.org> wrote:
>
> The tpm_auto_start() function is used in tests and assumes that it can
> open the TPM even if it is already open and a locality claimed. The cr50
> driver does not use the common TPM2 TIS code so lacks a check for the
> is_open field of struct tpm_chip and in fact it doesn't use that struct.
>
> Add an equivalent check to cr50_i2c_open().
>
> This fixes tpm_auto_start() on coral.

Mind if I change this on the commit. it doesn't fix tpm_auto_start()
it fixes *all* init on that TPM because tpm init && tpminit hangs as
well

Other than that

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  drivers/tpm/cr50_i2c.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
> index 08ec179346e..5b2d5ccb146 100644
> --- a/drivers/tpm/cr50_i2c.c
> +++ b/drivers/tpm/cr50_i2c.c
> @@ -737,9 +737,13 @@ static int cr50_i2c_report_state(struct udevice *dev, char *str, int str_max)
>
>  static int cr50_i2c_open(struct udevice *dev)
>  {
> +       struct cr50_priv *priv = dev_get_priv(dev);
>         char buf[80];
>         int ret;
>
> +       if (priv->locality != -1)
> +               return -EBUSY;
> +
>         ret = process_reset(dev);
>         if (ret)
>                 return log_msg_ret("reset", ret);
> --
> 2.43.0
>
> base-commit: e0695b08a71e167bf5ce83ae25acfdebca554b8d
> branch: tpm
