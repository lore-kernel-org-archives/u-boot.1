Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C0BEF99C1
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E88C83D5D;
	Fri, 13 Feb 2026 18:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ezVi2L9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A8083DC9; Fri, 13 Feb 2026 18:53:44 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D45C83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8845cb580bso196065466b.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771005222; cv=none;
 d=google.com; s=arc-20240605;
 b=JiDxwGqf9c5q8BCgtq9lw76wIcHAx7r56/sKzrlJY2QTGevQfrx4X73P/5j7zN3CvT
 304UQ8zzNz3q8qCDZ4j220VMaiGc9m4iBjGNH0Dwh4GISQI9x0yOg3q15RFIQ8P1M47E
 sUHDwx5xEkpYMs/8h/BKguIni+7CbyDxM2w+EbgyyIc40Uu4jceAx8pefTprh6zYFAto
 sBD2ry1KePrTqOFzJFU1Yrf4F/V2vZKdAkdmoQGFyOkWnFORuqo/Lg3kI2CbDLhDCZC4
 MsPhAvudXxWgxfAhlG9RiWmf8gH7wvKAKtcEIA57++qYyM9fy8Vte1Gsp9/2epeCsjal
 MoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pp5AAH9bquSiTEu+kkNj5Kb0mOI49vb3oSuvRSreRFQ=;
 fh=BNXxXodM6x/TTtNw5dDUbIgJJ3THT0IIKdNrgcKqd+M=;
 b=YShpdQVLUiM8H4NXB5uyGFb3UjZBZJcAYWNbVurL5J+f0ZWVqzzewrhxLJnz+2m3v8
 bmDRkQf2BGw1FmGhs8Kb+QoM7dQiIWgr9YR6yebnZOqsaoIb/OKp1Byd6L+Mtea7BPbx
 mRHOFBUgTjIFtc3xOjEPyaY+nMMSv2SYH/CYmPspZ6yZ0xLP3CbVRfZo6tzgglqu5LUN
 O477afKWLKJauTXRfWL6S0F4d6bxFSpTbPrRmtni120VdSOVghKEMxbeOHHhefQeyEwr
 +m4X/KIoo/SmZBpNDBwtf2g9/c+FBnng2pDGbRdTGsECAyYEPT+1q140FGT2dXNVrSmt
 4kQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771005222; x=1771610022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pp5AAH9bquSiTEu+kkNj5Kb0mOI49vb3oSuvRSreRFQ=;
 b=ezVi2L9p8KR2X+pAHsVXb/Dt/cTCgYofFtiibbXs4T1FHdiAa+1HAZEtYUhHjOHsiJ
 vkdVMetsuCmKJGhztrng91FgWiO4DQLfqrFqP2KqwjHGGtj+uM0DLBZYH0NRMT/67gDb
 iAEtktnEEANPLrHFXJDcCcZ5bSW5sQ69OTg4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005222; x=1771610022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pp5AAH9bquSiTEu+kkNj5Kb0mOI49vb3oSuvRSreRFQ=;
 b=drlcS15CwlVkYEVYt/OfoxbKTLTY0iJIsjUE6DDCscZGCx+RORpcEEnNDvnHFkXCWa
 Eb9Sha795krGeOgtavjyJrzGy2YdYVS+YbmbO+eceWzRKTII2AmEgJNeHaZI4yybCCh8
 PNPKtQ7hUP2rVR1HIw6mPgv8h1SlFoQoPJGzm67OUWKTfdli75E32Kb2ElvyACDXwtIl
 S2K6oN6weRwizMGjkrHj6ol1BPxct5caRUQfVj/Q3/4SRlv7+ydQ7eUcU4XIjRU75NBM
 nYvzizJs3JO6TuJJ7NQan8Lyh7P88dLUIbbRb5szP14n6y0Cbhj2nSl56fpZ0J1ZyFKk
 +8FA==
X-Gm-Message-State: AOJu0YxLtQI9tKTZY7qZ3M7pmU2Njq0Szsm1vYGmvIBrRo5kv6X6sMNU
 XR3eVU6MvibMGReU8VbkCixKTEJ58y+Qq9ngnVyH4myOxHHUFXnjvk0gXm51MZANj2ff+Jgr8Nn
 xSRhjZpkiXGy+cWt9G6ug2GjC+v4PFbt28AIU/CkH
X-Gm-Gg: AZuq6aLBczPf0qRwgOqpeEqVyU10xHH0QvuqbEazk/Z4XeDdY2hwAYNU6ntVjku+3sT
 NNsYxDRFiSy5luUy5/fZpxHZca6rFpP2Lsnxds9t1XYtcvfhhvB2e21tcz4k1uUTVXW8SxpATCI
 S4MRjvs+H+pic2uHr+Aysa6fOX5tpQXiK11xJy8uhTRuT020Sf+FzQx2gwZzk4wAtL5ZLfbiKMs
 gJmQ7jFmcPu9RXBeZPfCp/UVHs+5IcwF0SGRWIlxNBBdnUr/tgAaCt0jdjzEc6ktcav5dFqzc3h
 MLnWxg==
X-Received: by 2002:a17:906:6a22:b0:b8f:9237:4933 with SMTP id
 a640c23a62f3a-b8fc3d3f906mr12856466b.64.1771005221895; Fri, 13 Feb 2026
 09:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20260213001212.157033-1-marex@nabladev.com>
In-Reply-To: <20260213001212.157033-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 10:53:23 -0700
X-Gm-Features: AZwV_QiBKOEVMou43dmQVPbj6QgW-oN0nmyAaRrtqZ6rLx5bjCVjzqqLBbRCUH4
Message-ID: <CAFLszTi1M=J6+R1CcAJRY4gnQa87ScFkQ-YOK+NWzsB02VKnwA@mail.gmail.com>
Subject: Re: [PATCH] binman: add CST backend selection for i.MX8M signing
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Thu, 12 Feb 2026 at 17:12, Marek Vasut <marex@nabladev.com> wrote:
>
> Add support for setting the CST backend, both via DT property and
> CST_BACKEND environment variable. The CST currently supports two
> backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
> CST tool is invoked without any -b parameter. Keep 'ssl' backend
> as the default, but explicitly pass it via the '-b' parameter,
> unless the user selects 'pkcs11' via either method.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  tools/binman/etype/nxp_imx8mcst.py | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index dd9f226b751..3a95da6a35d 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -90,6 +90,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>                  'SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt',
>                                                f'SRK1_{KEY_NAME}.pem'))
>
> +        self.backend = os.getenv(
> +            'CST_BACKEND', fdt_util.GetString(self._node, 'nxp,cst-backend',
> +                                              'ssl'))
> +
>          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
>          self.ReadEntries()
>
> @@ -161,8 +165,14 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          with open(cfg_fname, 'w') as cfgf:
>              config.write(cfgf)
>
> +        # SSL is the default backend, PKCS11 backend is optional
> +        if self.backend == "pkcs11":
> +            cst_backend = "pkcs11"
> +        else:
> +            cst_backend = "ssl"
> +
>          output_fname = tools.get_output_filename(f'nxp.csf-output-blob.{uniq}')
> -        args = ['-i', cfg_fname, '-o', output_fname]
> +        args = ['-i', cfg_fname, '-o', output_fname, '-b', cst_backend]
>          if self.cst.run_cmd(*args) is not None:
>              outdata = tools.read_file(output_fname)
>              # fixme: 0x2000 should be CONFIG_CSF_SIZE
> --
> 2.51.0
>

This should be documented somewhere, likely in the comment for this
entry type, so it ends up visible in the docs.

Also, this code path will need a test, please.

Regards,
Simon
