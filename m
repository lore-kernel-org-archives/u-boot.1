Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFCE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656B28021D;
	Thu, 19 Dec 2024 16:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QUKhK0O+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED058022B; Thu, 19 Dec 2024 16:00:28 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148DF801F5
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 16:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso621497a91.1
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734620423; x=1735225223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pgkO3A4lBLm9qaw1LQiY3CsfrseegGNGnV1cQXPGFHI=;
 b=QUKhK0O+JknVlyX8Ix3xAX27r5H19MnX16spq8LHUeU2NeJsKnQl4DDbCBz4eFwJv7
 NuEGufl4NA8sSH4qmg6pd4IAfj/qO6sqkybmfkozOC3hbh3DKnIZiyRSy5gLfbmRr0jP
 pDNVhCKMJ0exhuxZfpGRqSRlFpWbeOCYh+aO5/4XmgXleOU5I4aZrbhxYbwPAI1TitEe
 0SuzaeQOY26wxK9t4GLaWhCSAkca1g1/JiYWoYP2JnBV4N5GT1VjAaPxZgCmdQLa5hL4
 D0CvTSUA5wB9+BTya/uCTH4LkaUE2IT2DV+7ur8pkHG5NZ116NKEWmFGAHtmhnsbjUWm
 OGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620423; x=1735225223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgkO3A4lBLm9qaw1LQiY3CsfrseegGNGnV1cQXPGFHI=;
 b=sJwmsIBU7HO/xZUe1I9HzcFi8dALeyEdmYaExK4z9IRJD7EWDpjbS52fN2NxyQpW70
 Ce4itpHWqUAeTuQ378POp2dNw1D+KDbwWEXVGcfJpuNcJIPqcOELh+phOFtBOT8eZF/I
 jDqTzUdYOpxS8lbKsEdSw+JO5DElIw4tKRowkeEF5DYZI4+XM1YAq+xIkSSetRpv3+0w
 llh4gTYcTcNO9MxzR2EWhSBrXaAlmVW5vftt9hbMAMctUCAqGhsZ+/61CMdHItMNiPH2
 SsbUJo63C7tSjeY/JyvhTYpsALZyeO9xHBVCsrG5AMKv1xsZJXEn/UqEx/g9+voiQfpD
 N9kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVQJwHFsKFsuJmxMVDojOjz+44Yoj18bdsHmdXC5zi5Y+ikXPEOF3q1TRAiXmlA1YUuXIaxG0=@lists.denx.de
X-Gm-Message-State: AOJu0YxBgzzI1V7i0wL5quMIaXYuqzcUhDNXYJQhm4277S2p2uTmzcFW
 XF8/gakXwcLCc+4s06an6FWHBLqUAtbld2eKpN4lnS/ZXzO+CIfFP1Uj2A7bIb0pLydaedZgdE/
 fuCl0CiBPey7PeLKp5PAjqzwfMielaqrh9L31Bhn6/cTW6MfD8Lg=
X-Gm-Gg: ASbGncsz23RnxqJcc0waswi/WIpyT7DFk2J7+3HRsRsqNvwWlTVGbLtXc1apyMIzGZ9
 GHxMRdV96qSKT72M1usxwswl3sqNwk6TVa7EXb1+FhEYrGxBO1FdRxBWD1r3KDMaqboX91g8=
X-Google-Smtp-Source: AGHT+IH1DKkzLkqfxiTvroSArrIZtBb4fahTAo73qrLq+4BzAKTUOWfqMUruZoBMhfpCKG+4M9KgB50DWBci/xBCFss=
X-Received: by 2002:a17:90b:54c4:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2f443ce980emr6465886a91.12.1734620422539; Thu, 19 Dec 2024
 07:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
 <20241219130554.49825-6-philippe.reynes@softathome.com>
In-Reply-To: <20241219130554.49825-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 19 Dec 2024 10:00:10 -0500
Message-ID: <CAEfUkULtQgp5JbGMU8H9h8dViLbprHW3azyAx3CiJ7311JOtKQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] lib: sha256: add feature sha256_hmac
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
 u-boot+nodisclaimer@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Philippe,

On Thu, 19 Dec 2024 at 08:06, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds the support of the hmac based on sha256.
> This implementation is based on rfc2104.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  4 ++++
>  lib/mbedtls/sha256.c    | 15 ++++++++++++
>  lib/sha256.c            | 51 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 44a9b528b48..99cf78e204c 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
> digest[SHA256_SUM_LEN]);
>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                 unsigned char *output, unsigned int chunk_sz);
>
> +int sha256_hmac(const unsigned char *key, int keylen,
> +               const unsigned char *input, unsigned int ilen,
> +               unsigned char *output);
> +
>  #endif /* _SHA256_H */
> diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
> index 2128e598834..7d456a82017 100644
> --- a/lib/mbedtls/sha256.c
> +++ b/lib/mbedtls/sha256.c
> @@ -10,6 +10,8 @@
>  #endif /* USE_HOSTCC */
>  #include <u-boot/sha256.h>
>
> +#include <mbedtls/md.h>
> +
>  const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>         0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>         0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
> @@ -33,3 +35,16 @@ void sha256_finish(sha256_context *ctx, uint8_t
> digest[SHA256_SUM_LEN])
>         mbedtls_sha256_finish(ctx, digest);
>         mbedtls_sha256_free(ctx);
>  }
> +
> +int sha256_hmac(const unsigned char *key, int keylen,
> +               const unsigned char *input, unsigned int ilen,
> +               unsigned char *output)
> +{
> +       const mbedtls_md_info_t *md;
> +
> +       md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
> +       if (!md)
> +               return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
> +
> +       return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
> +}
> diff --git a/lib/sha256.c b/lib/sha256.c
> index 827bd9a872b..c2e77c854b9 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -264,3 +264,54 @@ void sha256_finish(sha256_context * ctx, uint8_t
> digest[32])
>         PUT_UINT32_BE(ctx->state[6], digest, 24);
>         PUT_UINT32_BE(ctx->state[7], digest, 28);
>  }
> +
> +int sha256_hmac(const unsigned char *key, int keylen,
> +               const unsigned char *input, unsigned int ilen,
> +               unsigned char *output)
> +{
> +       int i;
> +       sha256_context ctx;
> +       unsigned char keybuf[64];
> +       unsigned char k_ipad[64];
> +       unsigned char k_opad[64];
> +       unsigned char tmpbuf[32];
> +       int keybuf_len;
> +
> +       if (keylen > 64) {
> +               sha256_starts(&ctx);
> +               sha256_update(&ctx, key, keylen);
> +               sha256_finish(&ctx, keybuf);
> +
> +               keybuf_len = 32;
> +       } else {
> +               memset(keybuf, 0, sizeof(keybuf));
> +               memcpy(keybuf, key, keylen);
> +               keybuf_len = keylen;
> +       }
> +
> +       memset(k_ipad, 0x36, 64);
> +       memset(k_opad, 0x5C, 64);
> +
> +       for (i = 0; i < keybuf_len; i++) {
> +               k_ipad[i] ^= keybuf[i];
> +               k_opad[i] ^= keybuf[i];
> +       }
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
> +       sha256_update(&ctx, input, ilen);
> +       sha256_finish(&ctx, tmpbuf);
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_opad, sizeof(k_opad));
> +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
> +       sha256_finish(&ctx, output);
> +
> +       memset(k_ipad, 0, sizeof(k_ipad));
> +       memset(k_opad, 0, sizeof(k_opad));
> +       memset(tmpbuf, 0, sizeof(tmpbuf));
> +       memset(keybuf, 0, sizeof(keybuf));
> +       memset(&ctx, 0, sizeof(sha256_context));
> +
> +       return 0;
> +}
> --
> 2.25.1
>
>
Sounds good to me.
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
