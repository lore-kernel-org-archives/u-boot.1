Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B934CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D2C84693;
	Mon,  4 May 2026 15:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wcChmzPp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D4B8469A; Mon,  4 May 2026 15:23:37 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0A684374
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651c7ddf514so3605047d50.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777901014; cv=none;
 d=google.com; s=arc-20240605;
 b=EoG3sCexuCQvs7B23nszmyAdb1pK+kVR3qWddBMey/Ys5PeQycFySaXyAUNQREGU4B
 X9G+8ifcTb57PuAikZM6u2fIROB2g2xH3JNOydRTD6d/ceC8SLiVJsfcDzGiKvPPgYW8
 uwbSzQWHpFKsGCnA9z7nVAZjLzTGiOqXR6JKr8VT83Jxd/dtw//OL6V1XxI/uO5qEEXM
 lGns+gvLkxUhz5RcY/I9PnLKH8sn87wNIm1xUmZBcJ0e792mJZ3/+P6qJaDoVn5Yok3+
 oS3SLWdYMza27yR0wi+ZftU1Zp7oprk3Ba8TAIRV1GvjfYPu/Ni0EmRCK0+mRUFbHkDl
 PpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j6rAaZKoM1D+uLdzvKgMVCvlYbRu2j2P+mHB6ta3l44=;
 fh=Zq5m+2G+3hKr9p7jr+mfHrMuGDINym5BV2Che5+uyiA=;
 b=BquV9qqGN4jULI7x5I21bK8tQCjC3vuwySaPoKLKbDbiHRdxhkeOuSleOyRk9SKey6
 dx7QEpc0phqjfDlG4sFybLdvP+kio+m8HR/hNszmSUyCUp3T8vRYC+Q8SBsRPiqJNSHg
 srUmzwdKyoNFQljPQ0gsD38DAMHwBQnZSSzz4vGcst9LB7VktrhIK+YHdM7NUm/zP6EG
 a6u6B+MYvg6EwEHVeFSWUDp6THLMGoA/tOoVhOl48nua3Eg7aWFYIpa/Y88CrHWF7YfZ
 y9EL4WWVP+XtZenZNl+Llf7QpheNgMKMYLsBLAL5WkAiFUbFrYD7qlCETS2GrSk1COX5
 KZ5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777901014; x=1778505814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j6rAaZKoM1D+uLdzvKgMVCvlYbRu2j2P+mHB6ta3l44=;
 b=wcChmzPpLTkdokCM1bwAp24ZXxU+If1/2zTZnP+/Vy9CB0brdt19U4UK04MNMa0Eaq
 jFnYG9037fZO/I0M6LOr9yWZ4AOqd9balqzcoS82Tsv2L+g5FB+mPS9diP+MDEVyKzjG
 VUc5BMfVf7u2wYWYsd+D7MUs7/pKogF+frH/HSquKF2g64dqY9OM5oA0MZ2lXz0OLC44
 9RQ/jXAhUK4XqMwpYbQWTEVLOZam9yoCTRd2kmxYro0ASZrKySzlSHJ8S8fWNciXAnnK
 la7cx7k2e9fz2DzX005Yi93JRu/7HB1dmAiYyNcZIfCXAc92FfZCrM4uaEJ7p6M+yPXb
 /jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777901014; x=1778505814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6rAaZKoM1D+uLdzvKgMVCvlYbRu2j2P+mHB6ta3l44=;
 b=KcdzYxDNXWqdc80EwiovSxdF1pJM+uRI8kPCT3UsQ5UafYZAK4WDN25iv64oFLbDt/
 QVamT0KC4rYYsImXF5ZVv838paSgQgowlvELCmsDGDFDDOnBFy8ozS8TTnyAxhWj8PFn
 NbRoI+RcIqCIi0ELTkMf6adp19luXag5rwdOE7lOQO7ZlorxJ1UZ+/wO0E7H1mLNYVqH
 SKKROqVNypVYYHxnZj1vsciULWtmIXbRovjmoAoVNaV3Z2F0aaL+03v9R35ksE4qrYzt
 IBHXo71pHfgerQzsdgX5DKMiHCaabZ+MTKiiMhzMf7Udh64iZWTfNJflRA998arJ9Wt+
 ZfPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uKFsfNsn3jPD0QtpIlzrSUbcFJLy2QH5jWYz01UuaXNodbVbtfjf/oZR1YKbnK++Mny+Qd1k=@lists.denx.de
X-Gm-Message-State: AOJu0YxLC5e7jeUWMGL0jx1Orlj0TQktlVut2UxQuGQk3xI+g3yW8ujc
 qbDML+LyZRmAsNm00yxFtflpXRt3YKuhZQd+oUpsLXoGLxixqiSwX7pUItXAV1HopvuEabSh4WT
 KaeUEPmoNFZ75rhRFJtSVczBYgdObqWNQBRLDpvaNYw==
X-Gm-Gg: AeBDieviOq0Kzzx8hr+tsGz/wvuKBfjzKPbVKiK2341bYpiADUXQQ//RskqjgEwHZK1
 oRF7OtOZN6DMyQxz18pJB7HlRvi3/aRHSFF2GxkYdK8Fb7z/LJdVWy4e12ByVWSlmfwEIXVOuW4
 svnb1/h+fKiLKhhknjsrgcvCK42Cwr2rl2PTjgL3qLQ5udiY/I6Q1DByTZ/qC2fSisc+OJhCfwa
 be6/VjSHBM1aTeZCZw2wEPrw60BUTRd+aPSzHA8Jcv1KTljZxMBkoAN+b2p88eDD42MDFDNBARW
 XtMIYuVZRQNLKYFqB6WchoBZUcnZ4etg1M6dJsG43vou5I1WYmVohNVMo1mExG9lOXltXEhma71
 kdS5yxu86D4sffG2Mgj802HchVJXwi0I3HJTkGttjFWt5GHvJhSBZOdeJcYoB+vvRsISiIbYfCu
 3ZwxPxliwZFFVNJ+lpl10CnfX0RQIusL79//ubmUxsr3BkxZfkeLko8vPDGRJtptKMtwCNJeNIT
 O0OvGMhJgq8PNVrhNlSgNkF1dIx/cBaJAeG3BVtcjyYePACQPG37xLYVYTH9xxUdXEqQj1MOIPi
 x7aEr7+kDHvpcKS1F5uGEfZgjfz6YVyP9fPjGg2nXp+FDyaf+8PaT7pCy6VxgWrmodTYePPh6cd
 CKIMy46ozxhtmraeo
X-Received: by 2002:a05:690e:4845:b0:65c:3188:4461 with SMTP id
 956f58d0204a3-65c3db4e910mr7026223d50.41.1777901013880; Mon, 04 May 2026
 06:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260429154000.71351-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260429154000.71351-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 May 2026 16:22:57 +0300
X-Gm-Features: AVHnY4IIcvuzSNvTzsL-OYJSqsIres1o1XE4myjvHhTF_IAlHypfm6g4WFhSt5c
Message-ID: <CAC_iWj+j3Jh8eNeXGHMpGaSg6fO0+uSBSSU_k0qZHnaHgmA-Uw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: initialize variables in efi_dp_from_http()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
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

On Wed, 29 Apr 2026 at 18:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When using lwIP, efi_dp_from_http() may fail to initialize ip or mask.
> Initialize the variables before the call.
>
> Addresses-Coverity-ID: 645840 - Uninitialized variables (UNINIT)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_device_path.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index b3fb20b2501..9efb158f5dd 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -955,8 +955,8 @@ struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev
>         efi_uintn_t uridp_len;
>         char *pos;
>         char tmp[128];
> -       struct efi_ipv4_address ip;
> -       struct efi_ipv4_address mask;
> +       struct efi_ipv4_address ip = { .ip_addr = { 0, 0, 0, 0 } };
> +       struct efi_ipv4_address mask = { .ip_addr = { 0, 0, 0, 0 } };
>
>         if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
>             (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> --
> 2.53.0
>
