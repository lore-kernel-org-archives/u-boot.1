Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B9ECDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 08:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3357848BA;
	Mon, 22 Jun 2026 10:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P6pSrFTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC5084931; Mon, 22 Jun 2026 10:08:13 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0D484832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 10:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7fe4808741eso42286697b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 01:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782115689; cv=none;
 d=google.com; s=arc-20240605;
 b=Wcnn4Y3GQsjYks4kNsuzqWVX3CFAr1KFxsesRTyIzdnueP1vi/mM0Zo5grrkVfca7R
 BJUorIWUqV+ecxSY7vTLsqJVt4B7w+1t17C/63yiYeJu7gZf9a08AIJxTzglizqVKhbv
 +rzTxgkCDQiIToNIJWtKP+/J9Np+qC5NnDNGQxK2D3f9Edx8mjetHwYlwhl4v62x87J4
 r5sx8fLi9VuVRG4EK93ATEL3RHAeYbeZTml1ohBvpcCxwV0WophRqkA7ByCdYY/dPOGQ
 C77pTX8UM1ZCZQp5O8kzK9gEdcSQ/2kEExSUrQOk2xSEUVSfSCJ//jd3dvB8nYULTRJQ
 CZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2pQGXVNjWH8IzzX6lJ9ijujwMmJ45adAuHhGB2k3Xnw=;
 fh=gaeWcp5Q+WAw3gm0DQAOUCMdJT/yTo0o4pv138PGZTk=;
 b=H+8wFhLvuCd1mxR1ssw/tRKDHQvY85EovpxG5/UNQHnC9119O4K04HIYkX0LcMdrj/
 0qHPJ8jj25+ByYbXUEGGuTS7z+lTx4CXB9B8dcHb+GCPgX75afOPczhMzhnEuZEAEbvA
 2g4/1nhC8WKT6Jsqb1+B5RQOnRpWVQehrUOHw/hMMam3AUwgs/4/61WeXz1y5C1KWL8d
 Snbm4r3e3vHZ9tyKO6U22TAigQ1i1srPLyIIGte9yaDsQTWSQcQF3oiD+pn8hSpFi8SN
 g4Kfozk4UjT/wL9Su1jK0B6EQI43LEVDAGarhfCBYQ7z4WXE1Dkz3icffChLEPGu9BAK
 /smA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782115689; x=1782720489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2pQGXVNjWH8IzzX6lJ9ijujwMmJ45adAuHhGB2k3Xnw=;
 b=P6pSrFTVfAWg7Wp2Nu1N1ecKRJZ+Yr59q9Apk0lYtWuZ4bzdAjB7b7mRqxV6+CaVvN
 /zHCsjU46T2fQzlzLP1hdmali/mAjy5zzCkSpc0C69/MNd7nFLVBI7c3hfAGax5jX06X
 O4Cpjz/DPec2shlfTsEjQKh/Opb5EbnSV1Fx2Mnq1eo3m68VCJfVwbwceekjtqoWvgmL
 Yd3AFXh96HCyk9RcdCcm1wXoK/jxyyVTph1xKASyngXtX1fVY19SjColfctRHpBq9eLB
 9M3mIrSGHWn+l62tVVny8gyS0BxyrOMCFGRMrcJOq2WcWZvf88iIj2Lo/56DRnJkrUac
 f6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115689; x=1782720489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pQGXVNjWH8IzzX6lJ9ijujwMmJ45adAuHhGB2k3Xnw=;
 b=M/ezPTSX1/r+5t/hEQl4r6QxT63ohzOLciC4JFNpFsC9X9SBOI5ZVOaKRLwGGD2HVG
 UCL3YKXuX/TVh0N20Pol6/UmCy1jpehyX8vc8xh43rS2cqQTs4xFu2mxM/9b8r9mFX2v
 M2jobeVm5kjY9LKLH1PrusoKNaps4t/kAa5Q+ghwnLdsp4nW87Ij1IYvB7Xos8BXpRpT
 NLKfJTquXsnRmdn0rgS93QYaoyPQkH3Mr6SaabQ3tgb6aAytn+9wpUp7A6iZD5Dqt3Hs
 e7HouH1AW29DStaZVQFS9RPrfAo6TlWdKeTXkAo06NvYujBObNecnpdczL/+TCO2ltCq
 ED7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0T9FrLvnfkikaS1DURKUvfu/6bYB9Hc0/LCUsbov2KioiYG0in5sVUEwP5BcAIq3sJtaXA/4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt0stsEPqjksTadXGGq3GNOfFe/mMrU5H07FzPs+bklswIIPm4
 MeCYtjPZ4nJXAaXckLRwsK4DbT8qS4i69+6EQHUaD5zklVJRysLcjoWEh3zlgcVlVjoPLJdFS/W
 ucK+c7SXQ6GMIA+XUQSoRfNUR+VUWPMvdpwVvu4Xgzg==
X-Gm-Gg: AfdE7ckcOrH+c8iNcDP2qCOiV4mXddFLMN7HYQ3lORAsLD/QT9eoSEd4PuZsUuogqmu
 d6KJXWs9aoxylzB6f1wwtdah+TF74R1Nx9wTw86g6eNzoSPu+D3imL/UZABRIyjsLMssgDy6Fbp
 rnd79FOhUzK8ZtwrP+4+Uw+0m8K+37WSb78UnzceCm+H28fIkUGC4ivn5dlgiYj3F6gTdmxByYK
 XOAnzwpukGJt/VxK6GLOifogAnIO2JuXOsJSBDfVvq3ZkrnexGDcnuJjuIivvCDaDXM7mVCvQb4
 o7ulwuTlILSh57cyzuaDXxju4d7/faRBg5s/5M7flEj5xmJoDt5FScBoFfMrWZ0E07iugYYS1Dw
 g8tvW6JWCmS7ScbaY+hPayr8Oz55asZYQaA216uqJqt0WAFg2fvdfosuhdx8Ibk/DgKYDc+Tija
 gm9xZC3UwPTfABRUTOtCfzMNapO5Z0IPBsb+FPMN+QU/22N4AOAmf0lmxigiDyDSKGJWfjxDrI/
 ZdXkDjVzCFl3W9UCe/2m2wiurB0Jq2mhDH0/+DTl/wChthv/TQF+XLX5Nb1ftmZDiM2s3XchGH5
 nDRly+dPyC6jjd8We/E0nB6C/Bx1CjYUSSHNOa8S4akzX/a8/rlx+BpJt8P3WzkQcrF42DqkSDw
 SpANa0Q==
X-Received: by 2002:a05:690e:14cf:b0:651:b2e4:63c1 with SMTP id
 956f58d0204a3-662ffce78aemr11656289d50.22.1782115689062; Mon, 22 Jun 2026
 01:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jun 2026 11:07:32 +0300
X-Gm-Features: AVVi8Ccdw1ujlfXFZACAupRKsqFHJy-Upbhpb2HFUjTv8XBwv82iGpJar-un1IU
Message-ID: <CAC_iWjL7QPfRazNS0h0znWhD-K1iA+p93FHrTK-SPsj6rHBAUA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] efi_loader: smbiosdump: fix starts_with()
 returning NULL
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On Sun, 21 Jun 2026 at 11:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> starts_with() is declared as returning bool, but the null-argument
> guard returned NULL (a pointer cast to bool) instead of false.
> While harmless on most platforms where NULL and false both have
> value zero, it is technically incorrect.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
>  lib/efi_loader/smbiosdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> index d7f2ba30a95..974728a43af 100644
> --- a/lib/efi_loader/smbiosdump.c
> +++ b/lib/efi_loader/smbiosdump.c
> @@ -199,7 +199,7 @@ static u16 *skip_whitespace(u16 *pos)
>  static bool starts_with(u16 *string, u16 *keyword)
>  {
>         if (!string || !keyword)
> -               return NULL;
> +               return false;
>
>         for (; *keyword; ++string, ++keyword) {
>                 if (*string != *keyword)
> --
> 2.53.0
>
