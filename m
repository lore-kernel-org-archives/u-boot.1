Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC8C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7C582A36;
	Fri, 16 May 2025 17:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IiaPnd8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A74B8006D; Fri, 16 May 2025 17:40:15 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5061B82A8D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad1d1f57a01so370995266b.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747410012; x=1748014812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VkoOF0B3R4NFFAOqIHlheEk5f+5IwMMo7rYNiDC5Noo=;
 b=IiaPnd8DXTQ9gyw2cay1i4w7NNjAFZ4tknEoIyWTNXlcVIdjsKO1wrzOyCY0atUTHZ
 9C3OHQuzVzyio5ri6rpHXGzwHrPkxpiilF8RrxB0SzU6eiei1Wpf1EKn5YKBTBMmn9+j
 iitjv/afDJMhHlOBwztG1XaMmDXYdGJ0vWS6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747410012; x=1748014812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VkoOF0B3R4NFFAOqIHlheEk5f+5IwMMo7rYNiDC5Noo=;
 b=DQWPcM0ZsRwjpGrk4thytNpnZa4yZXxHLRByrDF9I+upHSb3sqpTW+wQDLBhR6MTkS
 2qHwdHqOybHihQ0Lz/X9Ph2Hayvy0dFcdS4Let8Mb8dJNCHmBrl5MDu2SNW4dsoToLpH
 P0wCUxtvujk1lCTAUaTFrYjpWQ5rWLY0r7fOW3LrlojxLw3MH6LN2cVf7KB8yPObFKDL
 /YzIAMHhFId32b1QlvI3eL2uSHHePaBaMhZM+kzgk4B4Swet+Sb4ux4K9ougUN9XAOTT
 CPEP6SXprqNI0UHzB/D5u64nyhPEX7W2zdY4edhivBDjODeC5vfbI+RmRP/Z5dUwt9i+
 J0mw==
X-Gm-Message-State: AOJu0YwlSm8Qk4PbqG4O1IK9HXd1j3yP9AvkSj3gN3uKHkVNzYrzNLhN
 LQKHu3AI3IBLrdHJ0ijv++0p2WKnLnkjY167Lw+qp1aS+3NyWHtj+roOiBiMaLedkVJ+rs6ee0r
 +8BhGrwTT5ZiuFaTNOlhFWPnvynPOLTyHQLR6GWJf
X-Gm-Gg: ASbGnctIfvlGTh0SbfTH5hA96BpIUK7kfy604nkjfKWifqMhhDsIWlCNm7TEgJn0VNC
 rhn7n9zXpUkDC51tNpzG9mqzGgQ7+2zNCK5RBYvlAkU2ZlnLF9mGN+6aGiXwX1Oa0VGDr8bwyU/
 7OaHiiCbcqgvq6qevzQ8KYhCvboEhxTOs/VdDGBpiljkYV
X-Google-Smtp-Source: AGHT+IGSW/U2lXBvgGoXtY+tMZ68/fprb8wGCfinBCdSv+O8+fUMQ4KiYy0AJ6ubdHjsg/fyEaufair3nIfFI7usYSg=
X-Received: by 2002:a17:906:f5a0:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-ad52d4f8b8emr324885166b.24.1747410011676; Fri, 16 May 2025
 08:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250516125430.1361912-1-ravi@prevas.dk>
In-Reply-To: <20250516125430.1361912-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 May 2025 17:39:57 +0200
X-Gm-Features: AX0GCFvl6eSNwD35HGh_Wlk0dpBCN7zxROauRgWSXoGCMWXu5PhZ80Gg0-kK4D0
Message-ID: <CAFLszTjHnxzTxGUVOkTBo6CxoZc3DxO4q8=R8_Y847g_WHWM1w@mail.gmail.com>
Subject: Re: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Fri, 16 May 2025 at 14:54, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Background:
>
> I have several customers that will be using a certain remote signing
> service for signing their images, in order that the private keys are
> never exposed outside that company's secure servers. This is done via
> a pkcs#11 interface that talks to the remote signing server, and all
> of that works quite well.
>
> However, the way this particular signing service works is that one
> must upfront create a "signing session", where one indicates which
> keys one will use and, importantly, how many times each key will (may)
> be used. Then, depending on the keys requested and the customer's
> configuration, one or more humans must authorize that signing session
> So for example, if official release keys are to be used, maybe two
> different people from upper management must authorize, while if
> development keys are requested, the developer himself can authorize
> the session.
>
> Once authorized, the requester receives a token that must then be used
> for signing via one of the keys associated to that session.
>
> I have that integrated in Yocto in a way that when a CI starts a BSP
> build, it automatically works out which keys will be needed (e.g. one
> for signing U-Boot, another for signing a kernel FIT image) based on
> bitbake metadata, requests an appropriate signing session, and the
> appropriate people are then notified and can then look at the details
> of that CI pipeline and confirm that it is legitimate.
>
> The problem:
>
> The way mkimage does FIT image signing means that the remote server
> can be asked to perform a signature an unbounded number of times, or
> at least a number of times that cannot be determined upfront. This
> means that currently, I need to artificially say that a kernel key
> will be used, say, 10 times, even when only a single FIT image with
> just one configuration node is created.
>
> Part of the security model is that once the number of signings using a
> given key has been depleted, the authorization token becomes useless
> even if somehow leaked from the CI - and _if_ it is leaked/compromised
> and abused before the CI has gotten around to do its signings, the
> build will then fail with a clear indication of the
> compromise. Clearly, having to specify a "high enough" expected use
> count is counter to that part of the security model, because it will
> inevitably leave some allowed uses behind.
>
> While not perfect, we can give a reasonable estimate of an upper bound
> on the necessary extra size by simply counting the number of hash and
> signature nodes in the FIT image.
>
> As indicated in the comments, one could probably make it even more
> precise, and if there would ever be signatures larger than 512 bytes,
> probably one would have to do that. But this works well enough in
> practice for now, and is in fact an improvement in the normal case:
> Currently, starting with size_inc of 0 is guaranteed to fail, so we
> always enter the loop at least twice, even when not doing any signing
> but merely filling hash values.
>
> Just in case I've missed anything, keep the loop incrementing 1024
> bytes at a time, and also, in case the estimate turns out to be over
> 64K, ensure that we do at least one attempt by changing to a do-while
> loop.
>
> With a little debug printf, creating a FIT image with three
> configuration nodes previously resulted in
>
>   Trying size_inc=0
>   Trying size_inc=1024
>   Trying size_inc=2048
>   Trying size_inc=3072
>   Succeeded at size_inc=3072
>
> and dumping info from the signing session (where I've artifically
> asked for 10 uses of the kernel key) shows
>
>       "keyid": "kernel-dev-20250218",
>       "usagecount": 9,
>       "maxusagecount": 10
>
> corresponding to 1+2+3+3 signatures requested (so while the loop count
> is roughly linear in the number of config nodes, the number of
> signings is quadratic).
>
> With this, I instead get
>
>   Trying size_inc=3456
>   Succeeded at size_inc=3456
>
> and the expected
>
>       "keyid": "kernel-dev-20250218",
>       "usagecount": 3,
>       "maxusagecount": 10
>
> thus allowing me to set maxusagecount correctly.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  tools/fit_image.c | 80 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index caed8d5f901..65c83e0b950 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -24,6 +24,65 @@
>
>  static struct legacy_img_hdr header;
>
> +static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
> +{
> +       bool signing = IMAGE_ENABLE_SIGN && (params->keydir || params->keyfile);
> +       struct stat sbuf;
> +       void *fdt;
> +       int fd;
> +       int estimate = 0;
> +       int depth, noffset;
> +       const char *name;
> +
> +       fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, true);
> +       if (fd < 0)
> +               return -EIO;
> +
> +       /*
> +        * Walk the FIT image, looking for nodes named hash* and
> +        * signature*. Since the interesting nodes are subnodes of an
> +        * image or configuration node, we are only interested in
> +        * those at depth exactly 3.
> +        *
> +        * The estimate for a hash node is based on a sha512 digest
> +        * being 64 bytes, with another 64 bytes added to account for
> +        * fdt structure overhead (the tags and the name of the
> +        * "value" property).
> +        *
> +        * The estimate for a signature node is based on an rsa4096
> +        * signature being 512 bytes, with another 512 bytes to
> +        * account for fdt overhead and the various other properties
> +        * (hashed-nodes etc.) that will also be filled in.
> +        *
> +        * One could try to be more precise in the estimates by
> +        * looking at the "algo" property and, in the case of
> +        * configuration signatures, the sign-images property. Also,
> +        * when signing an already created FIT image, the hash nodes
> +        * already have properly sized value properties, so one could
> +        * also take pre-existence of "value" properties in hash nodes
> +        * into account. But this rather simple approach should work
> +        * well enough in practice.
> +        */
> +       for (depth = 0, noffset = fdt_next_node(fdt, 0, &depth);
> +            noffset >= 0 && depth > 0;
> +            noffset = fdt_next_node(fdt, noffset, &depth)) {
> +               if (depth != 3)
> +                       continue;
> +
> +               name = fdt_get_name(fdt, noffset, NULL);
> +               if (!strncmp(name, FIT_HASH_NODENAME, strlen(FIT_HASH_NODENAME)))
> +                       estimate += 128;
> +
> +               if (signing && !strncmp(name, FIT_SIG_NODENAME, strlen(FIT_SIG_NODENAME)))
> +                       estimate += 1024;
> +       }
> +
> +       munmap(fdt, sbuf.st_size);
> +       close(fd);
> +
> +       return estimate;
> +}
> +
>  static int fit_add_file_data(struct image_tool_params *params, size_t size_inc,
>                              const char *tmpfile)
>  {
> @@ -806,16 +865,16 @@ static int fit_handle_file(struct image_tool_params *params)
>         rename(tmpfile, bakfile);
>
>         /*
> -        * Set hashes for images in the blob. Unfortunately we may need more
> -        * space in either FDT, so keep trying until we succeed.
> -        *
> -        * Note: this is pretty inefficient for signing, since we must
> -        * calculate the signature every time. It would be better to calculate
> -        * all the data and then store it in a separate step. However, this
> -        * would be considerably more complex to implement. Generally a few
> -        * steps of this loop is enough to sign with several keys.
> +        * Set hashes for images in the blob and compute
> +        * signatures. We do an attempt at estimating the expected
> +        * extra size, but just in case that is not sufficient, keep
> +        * trying adding 1K, with a reasonable upper bound of 64K
> +        * total, until we succeed.
>          */
> -       for (size_inc = 0; size_inc < 64 * 1024; size_inc += 1024) {
> +       size_inc = fit_estimate_hash_sig_size(params, bakfile);
> +       if (size_inc < 0)
> +               goto err_system;
> +       do {
>                 if (copyfile(bakfile, tmpfile) < 0) {
>                         printf("Can't copy %s to %s\n", bakfile, tmpfile);
>                         ret = -EIO;
> @@ -824,7 +883,8 @@ static int fit_handle_file(struct image_tool_params *params)
>                 ret = fit_add_file_data(params, size_inc, tmpfile);
>                 if (!ret || ret != -ENOSPC)
>                         break;
> -       }
> +               size_inc += 1024;
> +       } while (size_inc < 64 * 1024);
>
>         if (ret) {
>                 fprintf(stderr, "%s Can't add hashes to FIT blob: %d\n",
> --
> 2.49.0
>

I have no particular objection here if you really want to go this way,
but it seems to me that it would be better to have a way to determine
the size of signatures using a new (or existing?) API call. Then you
can make this deterministic and always correct.

Regards,
Simon
