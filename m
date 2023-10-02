Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719A0E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14E6D870BD;
	Mon,  2 Oct 2023 03:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FZjJn3Dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9754687134; Mon,  2 Oct 2023 03:20:39 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1D786CBD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59c215f2f4aso198630477b3.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209632; x=1696814432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pwBDJX7Yx4KZXohSmAdhDsizyVtzuTjzlhXAM6h6DsY=;
 b=FZjJn3DcesGg0Ll3Fckrm6/yVdV2t479YNGs4x/EbAWBZk+aPn59FND3hOMtKU/qrq
 2l8Gy2BkgXLhSeVYHOXBFpoVNQtaah71zijHL0PdGIIOHmFRy7P9vtMjI+WIpVek/Vny
 QZRAKKKiRYFp33VlYri7UO4E+PLEQqUAvEgaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209632; x=1696814432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwBDJX7Yx4KZXohSmAdhDsizyVtzuTjzlhXAM6h6DsY=;
 b=bKo/C1m9BhDv56cDT73xRLh7vBD3Ypx2qRSYF6MM1Q4j/P9pDuGVyKDrukkZJVF2w+
 osnD7G7ym4jM2Tdbp3ifiF01n3d/KVt0Fs24g788/oLwBfSF+330v2l1ITJ9JxrBpdB5
 rdjnkqEJdOY9cKKQDO1e7DKfSFibsPB6eGe2Ag9cYiS4sMruTZbjsaMH0r0q2rGNdqHp
 HfMe8ljL6sFvsb1cOHUSSwaiqY3Qc+MO5coORtvLy6X8az8llSRc4Dt+V9zGvQ0pRhVl
 47uGy8sVHYS3jpXGg62Xemco0iHzm0SXFAON9FvrvWL0YlUfG9vNOKUYlNLfwNrBsa8U
 d08Q==
X-Gm-Message-State: AOJu0Yy3XfyIIA33qBBgF9V/+rROKdqt+0Wq+U46ZdbWNycH4IH2tuo4
 +MU8NRLIw+ERWZIvdXsi4Rk537F2dSUi+T18NQRiEuq5pHyxz05FTzc=
X-Google-Smtp-Source: AGHT+IGFOi/umVy80nYN2i3gVNpHQLuVDjheF2ETtPyyIcBYB7kYCfLut7cYxnDYWKtBHb18ca0zeiqF6Lno9LHkq+0=
X-Received: by 2002:a81:4e17:0:b0:57a:63f:f760 with SMTP id
 c23-20020a814e17000000b0057a063ff760mr10274630ywb.7.1696209631782; Sun, 01
 Oct 2023 18:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230928094446.1798562-1-lars@bitbiz.be>
In-Reply-To: <20230928094446.1798562-1-lars@bitbiz.be>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:21 -0600
Message-ID: <CAPnjgZ2hj7Z=848r+KpVRD=+z0_+7OsMng+8r6xvuxNgo=ynew@mail.gmail.com>
Subject: Re: [PATCH] mkimage: allow internalization of data-position
To: Lars Feyaerts <lars@bitbiz.be>
Cc: u-boot@lists.denx.de, Massimo Pegorer <massimo.pegorer@vimar.com>
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

Hi Lars,

On Thu, 28 Sept 2023 at 03:45, Lars Feyaerts <lars@bitbiz.be> wrote:
>
> Make it possible for data that was externalized using a static external
> position (-p) to be internalized. Enables the ability to convert
> existing FIT images built with -p to be converted to a FIT image where the
> data is internal, to be converted to a FIT image where the data is
> external relative to the end of the FIT (-E) or change the initial
> static external position to a different static external position (-p).
>
> Removing the original external-data-related properties ensures that
> they're not present after conversion. Without this, they would still be
> present in the resulting FIT even if the FIT has been, for example,
> internalized.
>
> Have checkpatch.pl skip warnings for use of fdtdec_* functions in
> tooling; livetree isn't used there.
>
> Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
> ---
>
>  scripts/checkpatch.pl |  4 ++--
>  tools/fit_image.c     | 26 +++++++++++++++++++++-----
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 62b764f6c38..488d73a0ed7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2606,8 +2606,8 @@ sub u_boot_line {
>                      "Possible new uclass - make sure to add a sandbox driver, plus a test in test/dm/<name>.c\n" . $herecurr);
>         }
>
> -       # try to get people to use the livetree API
> -       if ($line =~ /^\+.*fdtdec_/) {
> +       # try to get people to use the livetree API, except when changing tooling
> +       if ($line =~ /^\+.*fdtdec_/ && $realfile !~ /^tools\//) {

Please put this in its own patch

>                 WARN("LIVETREE",
>                      "Use the livetree API (dev_read_...)\n" . $herecurr);
>         }
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 9fe69ea0d9f..10f36e93422 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -616,6 +616,8 @@ err:
>  static int fit_import_data(struct image_tool_params *params, const char *fname)
>  {
>         void *fdt, *old_fdt;
> +       void *data = NULL;
> +       const char *ext_data_prop = NULL;
>         int fit_size, new_size, size, data_base;
>         int fd;
>         struct stat sbuf;
> @@ -659,14 +661,28 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
>                 int buf_ptr;
>                 int len;
>
> -               buf_ptr = fdtdec_get_int(fdt, node, "data-offset", -1);
> -               len = fdtdec_get_int(fdt, node, "data-size", -1);
> -               if (buf_ptr == -1 || len == -1)
> +               /*
> +                * FIT_DATA_OFFSET_PROP and FIT_DATA_POSITION_PROP are never both present,
> +                *  but if they are, prefer FIT_DATA_OFFSET_PROP as it was there first
> +                */
> +               buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_POSITION_PROP, -1);
> +               if (buf_ptr != -1) {
> +                       ext_data_prop = FIT_DATA_POSITION_PROP;
> +                       data = old_fdt + buf_ptr;
> +               }
> +               buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_OFFSET_PROP, -1);
> +               if (buf_ptr != -1) {
> +                       ext_data_prop = FIT_DATA_OFFSET_PROP;
> +                       data = old_fdt + data_base + buf_ptr;
> +               }
> +               len = fdtdec_get_int(fdt, node, FIT_DATA_SIZE_PROP, -1);
> +               if (!data || len == -1)
>                         continue;
>                 debug("Importing data size %x\n", len);
>
> -               ret = fdt_setprop(fdt, node, "data",
> -                                 old_fdt + data_base + buf_ptr, len);
> +               ret = fdt_setprop(fdt, node, FIT_DATA_PROP, data, len);
> +               ret = fdt_delprop(fdt, node, ext_data_prop);
> +
>                 if (ret) {
>                         debug("%s: Failed to write property: %s\n", __func__,
>                               fdt_strerror(ret));
> --
> 2.34.1
>

This bit:

Reviewed-by: Simon Glass <sjg@chromium.org>

Can you add some docs about this, e.g. to mkimage.1 ?

Regards,
Simon
