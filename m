Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4B3CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A2DA8467A;
	Fri, 15 May 2026 15:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9Hu1Ekb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DED78468B; Fri, 15 May 2026 15:30:39 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999C284676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso4573700b3a.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778851835; cv=none;
 d=google.com; s=arc-20240605;
 b=YHLc1rN+IeCknlNPcLtM6dFSz7QM5vFHLNidrO1u9HIsH4pQOOklzFrfALyfWakY0X
 bOthUuKnt1wIsYWj9gGql4En1IW++HYJYiO66s//EvQ4UT3HCRfj5x7uFhZ2vEIzqdHY
 /myENlm4HEgvDp5J+ZJ+YEB8lPjzI+tyIuFDw/0I2BpG0q1g3F8Lcf+O90gVCezfR5v0
 f+nQZfCsAVYHTGAk6jzNVlL9XpeofupxXQK4zzO6A3kMBIJ3ykIFYia5h7CzmW6tY2Rk
 CXmsFWgtVHCzS4YBIxu5UGUpVDnRFBbfLFTvpaasIATntG9iWvElsAK/CJsw8WbzrCu5
 FIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lusWt3W4DLanuIrCa+JXC43jZPeT1FsRVS+Tu45w7vI=;
 fh=JSimUU2yN6DAOPrOYVkQTbBwLeAYFUGH5u16vPPi2dY=;
 b=lN5/tcSHa/NMHWstb/3GeDf692EUzge57pmPw/hMENwrzomrk7fR/JLYPntLZHCpBZ
 QBXBf8785FVBYlQGWsRQaoq9q/3iWR+RAIGbxQksNq1h/qpG0f4yd2o5dF+9iSNf/4nz
 NT03EqnX5MIW6b8mALq1wtUHi5MLOmuVbIy1TlNCW3k/ndtEeGt2/vJTe2Qps/nuzhR7
 Kn6+ycX7g7WIvzdvi4hxeypFjHuNLcdQZqAnmq1Bz6x9jjkuDFVZbFPSl99IZYv91b62
 wpjh26GbTUQo9X4obxWNVJpuost40PtlH1gCmN9wPvqdG241yNkkpb+xnpNv0bCUhWeB
 uCJQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778851835; x=1779456635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lusWt3W4DLanuIrCa+JXC43jZPeT1FsRVS+Tu45w7vI=;
 b=H9Hu1EkbJFBHiXEna8BZj2yluWulWXQED+3oamVUNb4YvfQGccTe5N23OaI9T2CY7v
 xn67XnL0p7UlV9PKoxXM5y0JSj4Q0mnuT26EFiUYuGhOH93Z/60/8qHf+q7wxlt1neP0
 f9h+qMm9wc1LAtmAsn1bmQts+J5iUIO10d/Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851835; x=1779456635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lusWt3W4DLanuIrCa+JXC43jZPeT1FsRVS+Tu45w7vI=;
 b=PjZIqBBRLIaG1qUHs/Ol7FGL2beQGhl9avs5cDZ32ExzHhEFmekrd0nuVkcXeq+3uL
 NepYOKPCQf3mbhTRdLZVIuWNHAcyQVC3+gRXKEvKTNB1bG6HiLGk9xUJMe0C55oUK/ax
 t/pLITNvMrNbPXlwVVE4V7v4CU7bVJrsl+k6T78nFuT5nr0xvg8N9/vtsFs2jUymLIsK
 DHbxW83nwR6gfc+c7ab1Fn+LyEY3kiSV10gqFVMhZ8SDHV1dV9NY5HaqKMPz4+4UTAxW
 2Uv2JblbtRFptybvehJqOkYo51d4+vtPILK7YuPgA6YajsBRY0JhWpngLnJyb+RidD8K
 Vr4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gBdHtSsGDwqoMWEjQNiFivLixFAggJ6q68kWAfJIWpi7Lm5j9YbgAivfymmQr6U2SYi3spo0=@lists.denx.de
X-Gm-Message-State: AOJu0YxNY9IYwFLsjZHiGk6N9PFK+mSPLn9kvyIPL2oRwqu8dwfHTsLa
 VUT0td1BB9YAVKm9Bj07lfPWlTAIcBqWNkOwzBeEtm801ibROirv15RRcwF7DAfp5IdGJC/UyVg
 KZ61TrYW1Nb/sDdAm1My7iDTcN+s8IOzOR/h4+VwG
X-Gm-Gg: Acq92OGbDc59I8ENS322YFkrjDjnOxzUjkGkZe3tCT0LyHNR7e+4PCMuarL3KBmosKv
 b/FMnD3c8JKfvjIGSy21wvfJ88oYyYua8afYYMCGPTFKZDKu/rgLZCf6KRRtun/HGQJf8+jDcmM
 +g6hayoyep8pm+DCLxMw80C6KNMdvAxLPsZ0MOv5EM0VcQv0CDezFrg4DC1OKXOux80gezoOE+V
 VESo57Axkt83x9xppPswZjUJMLlLK2MJgiUJW5QLLBGlcDtfamSJWli8zQyhdziAIyTujI3rl3j
 IOW1Ww==
X-Received: by 2002:a05:6a20:244d:b0:3a0:b65a:5df2 with SMTP id
 adf61e73a8af0-3b22e7d0fd9mr4578411637.23.1778851832005; Fri, 15 May 2026
 06:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778637233.git.daniel@makrotopia.org>
 <ded45a7963eb0c355a16fd9c64a1b583070b406d.1778637233.git.daniel@makrotopia.org>
In-Reply-To: <ded45a7963eb0c355a16fd9c64a1b583070b406d.1778637233.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:29:46 -0600
X-Gm-Features: AVHnY4KW86skedhzcSotDThtIBwPFdA7fD_9aHY-gC-DtdSoLRwzIK-PpbOZqhA
Message-ID: <CAFLszTj3=X7Xg-9Z3yVUDdhwLfihoqkMwaxHwN-smq31Bdf5OA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] tools: mkimage: add dm-verity Merkle-tree
 generation
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
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

On 2026-05-13T02:08:46, Daniel Golle <daniel@makrotopia.org> wrote:
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
>
> [...]
>
> tools/fit_image.c  | 116 +++++++++++++++++-
>  tools/image-host.c | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 455 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thoughts below

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +629,310 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
> +static int fit_image_process_verity(void *fit, const char *image_name,
> +                                 int image_noffset, int verity_noffset,
> +                                 const void *data, size_t data_size,
> +                                 void **expanded_data, size_t *expanded_size)

Please drop image_noffset - it is unused.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +629,310 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
> +     {
> +             static const char * const valid_algos[] = {
> +                     'sha1', 'sha224', 'sha256', 'sha384', 'sha512',
> +                     'ripemd160', 'whirlpool',
> +                     'sha3-224', 'sha3-256', 'sha3-384', 'sha3-512',
> +                     'stribog256', 'stribog512',
> +                     'sm3',
> +                     /* blake2b/blake2s with explicit digest sizes */
> +                     'blake2b-160', 'blake2b-256', 'blake2b-384',
> +                     'blake2b-512',
> +                     'blake2s-128', 'blake2s-160', 'blake2s-224',
> +                     'blake2s-256',
> +                     NULL
> +             };

This list will drift out of sync with what veritysetup supports, and
users get a misleading 'Unsupported dm-verity hash algorithm' from
mkimage when veritysetup would accept it.

The only reason for valid_algos[] is shell-injection avoidance from
popen, right?. I'd much rather see fork()/execvp() used directly: pass
the algo as an argv[] element and the list disappears. What do you
think?

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +629,310 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
> +     /*
> +      * Stash the temp-file path so that fit_extract_data() can use
> +      * the expanded content for the external-data section.
> +      */
> +     ret = fdt_setprop_string(fit, verity_noffset,
> +                              'verity-data-file', tmpfile);

Communicating a host-side tmpfile path through the FIT blob leaks a
transient filesystem detail into the FDT, and the in-memory expanded
buffer and on-disk copy of the same bytes coexist. Since you already
return expanded_data/expanded_size to the caller, can
fit_extract_data() consume that buffer directly? That removes both
verity-data-file and the second read in fit_copy_image_data().

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -667,9 +976,12 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
> -             if (ret < 0)
> +             if (ret < 0) {
> +                     free(verity_data);
>                       return ret;
> +             }
>       }
>
> +     free(verity_data);
>       return 0;
>  }

The temp file is only unlinked by fit_copy_image_data() on the happy
path. If pass 2 fails, or mkimage aborts before fit_extract_data()
runs, the tmpfile is leaked in /tmp. Please also unlink() on the error
return path (or drop the tmpfile mechanism - see other comment). We
try to have a blank line before the final return in a function.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +629,310 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
> +     int data_block_size, hash_block_size;

The v3 changelog notes these moved to unsigned int on the runtime side
- please apply the same here for consistency, otherwise a malformed
.its with a huge u32 sneaks through fdt32_to_cpu() as a negative int
and the >= 512 check fires for the wrong reason.

Regards,
Simon
