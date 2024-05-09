Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524DAC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 08:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD008829B;
	Thu,  9 May 2024 10:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fIuHPpoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E268846C; Thu,  9 May 2024 10:07:04 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ECAD88252
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 10:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so129536266b.0
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715242021; x=1715846821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JnJzdHeb48Yzgej2ycBJWA3UHUjDwyxBtbOidnKWLJU=;
 b=fIuHPpoO7bAnIw10qkO7psCPCSAXQazX5fRBhi8fivU223TbOQHrlxovJbG3ZMpTff
 ZSFIbLIlsNMa49wH7ytoeYBlyhSpdMks0EwpiOhZvnamtNbymS6CHksXagslkaa6IlTx
 P1jM3KNS6foApGLNUddTNB02Z/2OP/mpkxLbMxEmLrgKpPaj52PB5Pq2+/+33IEsEMM2
 zJZsYfTbdZFeelxImebGuB2WToBLfqgCHpateZhO2ge+nzD/61l7ZxEaxUt5GYOstnzM
 WsCTQEOnbRgnz6jhdvJ4eSFpFux5Pi9MUFgdZyMYcvqnqQE5VCaLW2YXAoxEaISn8+y+
 zhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715242021; x=1715846821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnJzdHeb48Yzgej2ycBJWA3UHUjDwyxBtbOidnKWLJU=;
 b=V+X669S9IdYKEw0JKxoW7csDBDRiEz1Ek9JyzJqteGOeLjOXkd+U/g1Er22m08cKo0
 kDwJ1Aygmhb5fOAQZ+kqsVbsVDzQlk5jUqngtfDMwzOQgm2kyuAwgD2qYz7oydhkz0vn
 aUUvO1E459LEu2PgEaR32aoapSigraFpVIY1q/9MmzHTWUXp2VB20mGjz8RRuBGgFt0H
 cV0gqDo2IDYvIX4SqqXzEmXJYcZiJI8uEmwkT8oCkH76BgEqZ5wVd77cbLmiMZ8WEyVv
 CPAOt+C8SKldS891oBE8VsZ/INMOESJXMQaN5ohjyTYi9GJjjn4b93Lzv8OiCWZxAb+O
 GXVQ==
X-Gm-Message-State: AOJu0Ywf42WswHBgWPIBDJPliJ14kPzl8cdQ/X/gqk8JqmLKfzWctDbQ
 saoXXkMPlUgkusVuSpdhR8hkvb+vbV0P3AbCqgv0jd36+2fUys0SydmrBSlURmzZD41eyYRGb7o
 d9L/mGLl1I0zmP6PM12iBnat0jOe04NhNOI15Iw==
X-Google-Smtp-Source: AGHT+IENum0JV6Nj4kGSWUOmNyC7ObEKdcPGmjYrSi5Ck2c2WT8e2c7yxEpfjd8EE7x4YbLpYHhVLS7glg2TeKsf3ig=
X-Received: by 2002:a17:906:6db:b0:a59:a857:85ce with SMTP id
 a640c23a62f3a-a59fb9db786mr306698666b.52.1715242021443; Thu, 09 May 2024
 01:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-9-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-9-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 11:06:25 +0300
Message-ID: <CAC_iWj+d=8oevabbGnOjNM9Y0PJV6Mc+YzneNN=UJRrxqn9Pyw@mail.gmail.com>
Subject: Re: [PATCH v2 08/28] md5: Adapt to the changes of md5 header
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
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

On Tue, 7 May 2024 at 20:55, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> The md5 header is updated to adapt to both original lib and MbedTLS.
> Now we need to change the API callers accordingly.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
>
>  drivers/crypto/hash/hash_sw.c |  8 ++++----
>  lib/md5.c                     | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)
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
