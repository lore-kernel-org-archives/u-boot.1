Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE497C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 16:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E4288256;
	Thu,  9 May 2024 18:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZbxQ9ciq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5497187DEF; Thu,  9 May 2024 18:17:57 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6008826D
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 18:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e428242a38so15367001fa.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715271474; x=1715876274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IkqSaWJ8Btnl0ohE0cah/xpx7nZ/Tu6zCNrtjhlp9eg=;
 b=ZbxQ9ciqaGhC25/xZmRcYdh0yPEl5mzrtMzX0DQjkT9tQp9HIKJ3ZFo3V2R+G+VCvK
 Ep2Ynq2i0OvDKsUDirFyVSJAv9gVbs1In8GgH3FyqECYxV9bzrch9tdgXimQY4o1QfK0
 DIaKJZ68cVD0FTasXepGlf12LdK09E8opcj39SkBob0CjVX3if3jwKY6zwAFETe8hGI8
 c7SXHiKYWZ/qgx8/h3V9YGSMWspCll4QlqlH5keHFM+5vtIHzZMuVXejzInGmt+OZ14B
 vtYESlZWDH1APXGp3Rr7kJvHKm1uyGz3KRvAa0Kion/tb4fukaiYUt9Y8+zf7LGxQ8TH
 rkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715271474; x=1715876274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IkqSaWJ8Btnl0ohE0cah/xpx7nZ/Tu6zCNrtjhlp9eg=;
 b=sy/sgY5U+LP1iWAn+KRNCUSz/KuRBwK/mK+8g2ddlCSRATBJVXrOnx9PxrgwxLn/0p
 TjeA3SC5pV/1hO+iH4umKbkrwKhbPZY2JxPVV/wPz3L49lT2ZGr2mhaKPrMKAOo9aoy5
 zC0mQlJa3lMrTb7gzDR1KEJaPkKJq61/MC38BEKhhJYlAnaXhQaQ7hj3vjZWPP0Sqsc0
 nKYIrKquDql42P67Np0OQKSU77RlSWnqj0sfHz9gshNenpplND24/bafB6FkPFLeo86S
 eaMSrRBqQv2RvZfx1gdP6/p8/bz8mnE/Al6Ir/j4uvveS8Rr4Ds8YUo9IwCqHXQhp2Po
 qUCw==
X-Gm-Message-State: AOJu0YzHFUpoPg8NorFLqIqL8zfhzt2Ih1Rszi2nNTvCeh4rvjYoETeU
 YU+5EPUodlj3dvt1SJ/mhU9LMJNFjjTSliPRc9lHIk967nujTAe5i5XXksL07skuetN8kpPYmko
 H5UWz+rE2iHZx6fRogT65mFs7+bzV0wG0Q+V+4Q==
X-Google-Smtp-Source: AGHT+IHU2MBRoLqLljBeZu73yyNYfo4zyH/qFXLDzrZUg9K3jBuc1NHcLk0L1g3+ADiALTNekd73d9W3lsFVa2TyPig=
X-Received: by 2002:a05:651c:4d0:b0:2e1:ed63:d153 with SMTP id
 38308e7fff4ca-2e446d82b61mr61826301fa.7.1715271474550; Thu, 09 May 2024
 09:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-4-raymond.mao@linaro.org>
In-Reply-To: <20240509143743.1496210-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 19:17:18 +0300
Message-ID: <CAC_iWjLhskn35dQwgJtahj+Yc4iTd9+Wb2_0uGKVHuU7XT4Ajg@mail.gmail.com>
Subject: Re: [PATCH 3/4] md5: Use typedef for MD5 context
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Thu, 9 May 2024 at 17:38, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Use of typedef is beneficial for porting with other crypto libs
> without changing the API callers.
> Secondly, it is for the code consistency with other digest libs.
> SHA1, SHA256 and SHA512 are all using typedef for their context.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  drivers/crypto/hash/hash_sw.c |  8 ++++----
>  include/u-boot/md5.h          | 10 +++++-----
>  lib/md5.c                     | 10 +++++-----
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
> index d8065d68ea4..a5033677930 100644
> --- a/drivers/crypto/hash/hash_sw.c
> +++ b/drivers/crypto/hash/hash_sw.c
> @@ -51,17 +51,17 @@ static void hash_finish_crc32(void *ctx, void *obuf)
>  /* MD5 */
>  static void hash_init_md5(void *ctx)
>  {
> -       MD5Init((struct MD5Context *)ctx);
> +       MD5Init((MD5Context *)ctx);
>  }
>
>  static void hash_update_md5(void *ctx, const void *ibuf, uint32_t ilen)
>  {
> -       MD5Update((struct MD5Context *)ctx, ibuf, ilen);
> +       MD5Update((MD5Context *)ctx, ibuf, ilen);
>  }
>
>  static void hash_finish_md5(void *ctx, void *obuf)
>  {
> -       MD5Final(obuf, (struct MD5Context *)ctx);
> +       MD5Final(obuf, (MD5Context *)ctx);
>  }
>
>  /* SHA1 */
> @@ -159,7 +159,7 @@ static struct sw_hash_impl sw_hash_impl[HASH_ALGO_NUM] = {
>                 .init = hash_init_md5,
>                 .update = hash_update_md5,
>                 .finish = hash_finish_md5,
> -               .ctx_alloc_sz = sizeof(struct MD5Context),
> +               .ctx_alloc_sz = sizeof(MD5Context),
>         },
>
>         [HASH_ALGO_SHA1] = {
> diff --git a/include/u-boot/md5.h b/include/u-boot/md5.h
> index d61364c0ae3..c465925ea8d 100644
> --- a/include/u-boot/md5.h
> +++ b/include/u-boot/md5.h
> @@ -10,18 +10,18 @@
>
>  #define MD5_SUM_LEN    16
>
> -struct MD5Context {
> +typedef struct MD5Context {
>         __u32 buf[4];
>         __u32 bits[2];
>         union {
>                 unsigned char in[64];
>                 __u32 in32[16];
>         };
> -};
> +} MD5Context;
>
> -void MD5Init(struct MD5Context *ctx);
> -void MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len);
> -void MD5Final(unsigned char digest[16], struct MD5Context *ctx);
> +void MD5Init(MD5Context *ctx);
> +void MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len);
> +void MD5Final(unsigned char digest[16], MD5Context *ctx);
>
>  /*
>   * Calculate and store in 'output' the MD5 digest of 'len' bytes at
> diff --git a/lib/md5.c b/lib/md5.c
> index faf3f78ab1e..34343cf8e23 100644
> --- a/lib/md5.c
> +++ b/lib/md5.c
> @@ -55,7 +55,7 @@ byteReverse(unsigned char *buf, unsigned longs)
>   * initialization constants.
>   */
>  void
> -MD5Init(struct MD5Context *ctx)
> +MD5Init(MD5Context *ctx)
>  {
>         ctx->buf[0] = 0x67452301;
>         ctx->buf[1] = 0xefcdab89;
> @@ -71,7 +71,7 @@ MD5Init(struct MD5Context *ctx)
>   * of bytes.
>   */
>  void
> -MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
> +MD5Update(MD5Context *ctx, unsigned char const *buf, unsigned int len)
>  {
>         register __u32 t;
>
> @@ -120,7 +120,7 @@ MD5Update(struct MD5Context *ctx, unsigned char const *buf, unsigned len)
>   * 1 0* (64-bit count of bits processed, MSB-first)
>   */
>  void
> -MD5Final(unsigned char digest[16], struct MD5Context *ctx)
> +MD5Final(unsigned char digest[16], MD5Context *ctx)
>  {
>         unsigned int count;
>         unsigned char *p;
> @@ -269,7 +269,7 @@ MD5Transform(__u32 buf[4], __u32 const in[16])
>  void
>  md5 (unsigned char *input, int len, unsigned char output[16])
>  {
> -       struct MD5Context context;
> +       MD5Context context;
>
>         MD5Init(&context);
>         MD5Update(&context, input, len);
> @@ -286,7 +286,7 @@ void
>  md5_wd(const unsigned char *input, unsigned int len, unsigned char output[16],
>         unsigned int chunk_sz)
>  {
> -       struct MD5Context context;
> +       MD5Context context;
>  #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
>         const unsigned char *end, *curr;
>         int chunk;
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
