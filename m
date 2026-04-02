Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8455D6AAF0
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A6B83F8F;
	Thu,  2 Apr 2026 18:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nMM192nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86252840F5; Thu,  2 Apr 2026 18:39:40 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 859C083F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so1720396a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147978; cv=none;
 d=google.com; s=arc-20240605;
 b=XsxbGPnq9r5TReRL5bQkVpNqwgs9GJykcoLUE6vL0Ozt+njcAZw7H3SI8Qt3e9vr0x
 z/T1UY418Q1nUKvgBwaP0j9OVi2JBHjkXmYokxEWZh4GlxkW4Perq124M+q0FtyUEPbs
 8x+Lj8S30nkZgcurGRfPrY71R4FkPvm4OXBYIKsFHO8FrWKnTK/lhDik3DsAsaRG8cKc
 orLDPReZRcGKo+uKXHKzbmaXKdCsOkG/F8K91IlJLghIeUb5cWGETNiVl09JcyeY+O3r
 ssQCi1db+iGdQvgVrrpj0J8MmPQm0svL/nSG+F0bIeHfDI7cbvDyEFzYDLI3iTp+tVSP
 A6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Vw8tbd8h1gywUx+ZTV8KeTqgt/I1qUtF4J1DcUQUDGI=;
 fh=eKQCGjpYGCu1+wIlNspHoX8z2CU2UfWMTQ6onZW+Ic4=;
 b=g8EVtheMl4XQehXNKuNrnNjpQ+gT9oLXkouGodDbKfw0MUozJIAtQ5tq0SUUblQgZc
 J+SE4Vn/tqa2ykLwgrVXq+8TUeey81UyM0epmj99X0y6rZHOJEa5DC9lp4cGVLzTQ2VB
 8OXlaEwTePBYRLKAadV9LWrvvFJS+CMnsbaIef0aIAFYejfEmaOAQjMys2KvzgsItgCl
 POqnfze0fraiTsKpEgCnB0dShrRkQbR6NYGnMEFHB9eCpSaBB5koV8bPYw5ervO4JaT0
 qcwIHRSmFdcdRZpK4WJcwFrum/1FE31ghEe1I02npuu1m7idiy71exNcwHZyiJaCBn05
 Aexg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775147978; x=1775752778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Vw8tbd8h1gywUx+ZTV8KeTqgt/I1qUtF4J1DcUQUDGI=;
 b=nMM192nfH+Lvl4DIsyNaJQ7yajw9NBidOSeMm6Wih6xd0QkWc1StfWZ73ycvNdCqsp
 DrPzRVcX4D8R+cI4mA2dv0UxaI64EX0bjVzXBWwMNzJVgB4JBR43/DsCEAx2Ri+7v7sX
 j0ikRTnR/coxkl5vWzOZLqokD7gcI/d8EU+Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147978; x=1775752778;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vw8tbd8h1gywUx+ZTV8KeTqgt/I1qUtF4J1DcUQUDGI=;
 b=YuPtmIzhdTIUWhQRf7exdw9ZGezRSlC/C+DLsBEylydX4INUzzd+stVwWc7POn0ID5
 L3Chk1jrcpNNQHArQWYqUDpVPhVsoZnXfzKncLUZtlILP3lrUuUS61yfB0o4bqw/8vJl
 9yV5uP1hT6pt+ATlTg/qqdqoiIJsD1e17e1NnSMMoWpddqyRE/iQkHznkOeoRKRWNRtH
 zafUewrKLPnr1C1xnLs+N8T5GccnZCOJlUQiwAA7cQWhntsCzLW/AYAldUUFZ64tNQW8
 fIfRsMxApOw2DBz5Bv598MeH2hjlTGItaXmn1V9Cs3cABEvYaoeEJWRspzxz3Yil+Vz1
 UWEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmFxNkk2dB/OUCTuvI3aE7l6HE55ahmkHs8wRTSUpoiITy1yb2jaFbC6Ipf5z8dt9aLRtmyJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YyA1yuwucO8Xdr8IyIsec1hY8MefJZbLCUN8WBFmxq6NAz2XwMY
 twAB3PCK80PZWfQgX7s/Zv659keENAlnajYaye/iZny+zAJFhaaaVJkwr8DwXhLBeFShkWthy89
 Vx3d7n2xIU1TeQmtEXhjGZJE5vmXgoKVMTc1LHN/C
X-Gm-Gg: AeBDiev9eelVOIhonpw+MfQZRUY3i2v10cj+iImOEReZMwm9k9Ju9icfDTSvFDzGZDn
 4jpkea1/NjMH37wSeR8Qb1NInCk0gVIUAWcddDlO4h03z+CPXMz5IV9KxYxmXXIqHKZVv8YC+3R
 T04Q2yLLwFQLoxoPKeTdIaukDf01TTQx1bzexvPjUt9ZVnoEcbA0JzhJWf6a9ExtHpxAqc6kcVG
 2MUcr08RxLJirbjqsVFB161wyOvM/GUgwIlI/1VyUOni8NIJ65qgZT5b/sPS4pJIo4yogHwTOhy
 SDQWOZhuQFiuzf01
X-Received: by 2002:a17:906:4912:b0:b98:695:ec53 with SMTP id
 a640c23a62f3a-b9c138c110amr426113266b.18.1775147977705; Thu, 02 Apr 2026
 09:39:37 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 10:39:26 -0600
X-Gm-Features: AQROBzCICW749bLfp2o3VwFXNjDZ0szojRC2Bv-M08kXUSgV7u3zG6cqEUh-I14
Message-ID: <CAFLszTiODuyubCxA6YLg419+grHFhX_u3opd5fJUgg8h0+-Fng@mail.gmail.com>
Subject: Re: [3/4] tools: mkimage: add dm-verity Merkle-tree generation
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Aristo Chen <jj251510319013@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, Shiji Yang <yangshiji66@outlook.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Daniel,

On 2026-04-02T03:08:27, Daniel Golle <daniel@makrotopia.org> wrote:
> tools: mkimage: add dm-verity Merkle-tree generation
> tools: mkimage: add dm-verity Merkle-tree generation
>
> When mkimage encounters a dm-verity subnode inside a component image
> node it now automatically invokes veritysetup(8) with --no-superblock
> to generate the Merkle hash tree, screen-scrapes the Root hash and Salt
> from the tool output, and writes the computed properties back into the
> FIT blob.
>
> The user only needs to specify algorithm, data-block-size, and
> hash-block-size in the ITS; mkimage fills in digest, salt,
> num-data-blocks, and hash-start-block.  Because --no-superblock is
> used, hash-start-block equals num-data-blocks with no off-by-one.
>
> The image data property is replaced with the expanded content (original
> data followed directly by the hash tree) so that subsequent hash and
> signature subnodes operate on the complete image.
>
> fit_image_add_verification_data() is restructured into two passes:
> dm-verity first (may grow data), then hashes and signatures.
> [...]

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +657,301 @@ int fit_image_cipher_data(...)
> + * The expanded data (original + verity superblock + hash tree) is returned

Since --no-superblock is passed to veritysetup, the output contains no
superblock. The docstring should say "original data + hash tree" to
match the actual behaviour.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -24,6 +26,35 @@
> +static int fit_hex2bin(uint8_t *dst, const char *src, size_t count)
> +{
> +     while (count--) {
> +             int hi, lo;
> +             char c;
> +
> +             c = *src++;
> +             hi = (c >= '0' && c <= '9') ? c - '0' :
> +                  (c >= 'a' && c <= 'f') ? c - 'a' + 10 :
> +                  (c >= 'A' && c <= 'F') ? c - 'A' + 10 : -1;

There is an existing hex2bin() in include/hexdump.h - is that easily
available to host tools?

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +657,301 @@ int fit_image_cipher_data(...)
> +     int data_block_size, hash_block_size;
> +     size_t num_data_blocks, hash_offset;

num_data_blocks is size_t here but is later passed to
fdt_setprop_u32(). On 64-bit hosts with images larger than 2TB (at
512-byte blocks) this would silently truncate. Please can you either
use uint32_t with an explicit overflow check, or add a check that
(data_size / data_block_size) fits in 32 bits.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +657,301 @@ int fit_image_cipher_data(...)
> +     if (data_block_size < 512 || hash_block_size < 512) {
> +             fprintf(stderr,
> +                     "Invalid block sizes in dm-verity node of '%s'\n",
> +                     image_name);
> +             return -EINVAL;
> +     }

dm-verity requires block sizes to be powers of two. veritysetup will
reject non-power-of-two values, but a clearer error from mkimage would
help users. Please can you add a power-of-2 check here, something
like:

    if (data_block_size & (data_block_size - 1))

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -470,6 +486,62 @@ static int fit_write_images(...)
> +     /* Copy path -- FDT shifts after delprop */
> +     snprintf(vfile_buf, sizeof(vfile_buf), "%s", vfile);
> +     fdt_delprop(fdt, vn, "verity-data-file");

Other uses of fdt_delprop() in this file check the return value -
please do so here too.

Regards,
Simon
