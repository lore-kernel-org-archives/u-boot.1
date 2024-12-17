Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58BE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF99D801CE;
	Tue, 17 Dec 2024 15:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JJmY70D2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C446801FB; Tue, 17 Dec 2024 15:55:07 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C950680107
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 15:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fc99fc2b16so3639998a12.3
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734447303; x=1735052103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l3hOSwCpzswNSUOruIxVsca19WaH7vIPrqWCTzzRmPQ=;
 b=JJmY70D2fOjXsXCxGs191LADH2RNxP/AfNMhtuBTPmc0A7r7zofGpkTIaIKiWYAcfZ
 Ety/InrPQoT29Sien6sDZSquSNq09mdDSBOUxIPYM+uuNDomg65J7cSCvX7whCU6+6/P
 KTWfs0qQEQlsx37bBZgXs+cZXWTGisZS2W65pVKtMrMVRhiSCi/hn14dbH+//qUO8V8U
 AjX7ntGz+1I23MimBEPP+mk9QyO3pgP/0hQVyuDZDLvI9cTQi9+riTv0H7pwNTFCv2sU
 pLEx+vfog5zdf2kdUstf7vQBg3vd3u99QG78JPjwHz1wmKF1LUY+EnvdSPHV4tzrwqZD
 e/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734447303; x=1735052103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3hOSwCpzswNSUOruIxVsca19WaH7vIPrqWCTzzRmPQ=;
 b=jizWGPVYLYL2DfY5OuKrnJvGGlrYrbQo5zgdBeJIEmnlGM4Fc8JRPIv6iLbjQ2VxKh
 atB0UTwRTv4Rl4Pad5sJtZkJKvqLovoQS2X2kTK0WpnfkpOSV7t79cMG2gb+S7BAZmFr
 gNHnuAp+zWKpDF4RUmoolQ60FSfHo6ZxQxVjz+dQBLXpX/OCw/whBo6YDJ79fq61g4jy
 hgGSIErGhTaSpS134Puw56xrLd8IOd+uEC80LDmTgLQQ3oGKRTATlkCumAgKxZVgpeaj
 xXNPB2G7eGo+Xi6tfjvBdlf2YzMc78xKT2lsb/VW6mW7XdTya2YtS+yCQ+JueYb1zhw2
 Cfbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcUg/4oPTg29370P5zMjrUigYyRwLwpe9URdsysUrZVe2RwBZsTY5r3kEipgnVBQvCNRsA+ys=@lists.denx.de
X-Gm-Message-State: AOJu0YyKljYZxxf6P6FI3PyaD7SoWqWbGa5+r03LuWY4CZXfg3kRyj91
 gXhdmoKuNZC+fFrGGDQe9wxrAs9P6XM4gb+FZXGfgDQklGDlBRQqtdi1X1kun7VY2YkJ53eUYQB
 M09sHkc8tN2zbVMkxKKMReCm+4Tf4NUXbZfDqjA==
X-Gm-Gg: ASbGncswMIhohIXSP5Zi5QYaZe+Oiob2LUlFlQRoIrUTIlKpFiHsW5b74BS+rL4xLp9
 tRTI77t0/he4c+Gc1AmUOWOkQz0IDdsVCsczxoSizMY5mA0iWj8FKazUpqjJDoW6YFHJqpfk=
X-Google-Smtp-Source: AGHT+IEqSsSUuOQC8SkQNgU3C7IS55lM/NcKqr4+w0l0/ckBSZuIVHvA4qGEEvqUPCoEjvRu8j/hVsR144fUui6PeqY=
X-Received: by 2002:a17:90b:3807:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-2f28fb700e5mr26546683a91.14.1734447303175; Tue, 17 Dec 2024
 06:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
 <20241217083212.70330-6-philippe.reynes@softathome.com>
In-Reply-To: <20241217083212.70330-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 17 Dec 2024 09:54:51 -0500
Message-ID: <CAEfUkU+LkwSMNwsiQfwUx8HEijCDOJUNqSU_fQ7YcinhkWdwyA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] lib: sha256: add feature sha256_hmac
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

On Tue, 17 Dec 2024 at 03:32, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds the support of the hmac based on sha256.
> This implementation is based on rfc2104.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  4 ++++
>  lib/mbedtls/sha256.c    | 15 +++++++++++++
>  lib/sha256.c            | 50 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
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
> index 827bd9a872b..a18aec3928b 100644
> --- a/lib/sha256.c
> +++ b/lib/sha256.c
> @@ -264,3 +264,53 @@ void sha256_finish(sha256_context * ctx, uint8_t
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
> +               memcpy(keybuf, key, keylen);
> +               keybuf_len = keylen;
>

All looks fine but keys shorter than 64 bytes are copied as is, without
explicit zero-padding, this might be an issue.

+       }
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
Regards,
Raymond
