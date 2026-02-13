Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EF4EF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA5383AA9;
	Fri, 13 Feb 2026 21:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZO1DiCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BAE83E0E; Fri, 13 Feb 2026 21:20:41 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91EB83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so11419515ad.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014037; cv=none;
 d=google.com; s=arc-20240605;
 b=HhfqfF7mPyV+UkUW9nryzYz365sEZosNx7vcdnBTWJvCDsQNUt5G2HtSquAJGOIlgL
 85kVvaykSUI/oNTf0hfSAMSlcHBrW/ZclzRWtFzgX2MDeTsNnPt1Gh6Ixs79fMASYYua
 X9nubCmbksUeOWZ+QJKyenSDR05FIawXqVTl6O2tTzStA/sXtN0n13tdlMFPQ2fHLZiQ
 G2bhXSHMsWbiAFOfZnB87MTa9mGw62EXmvlIdAentNtjPfGknZWwtqd9fMIh9Vcrh5gu
 qNBzO6/QurYnPJGc6DU/MI66E7wRW5d5978WHLEa4PB6VlZmRup8jVOI/e6sEU334XmL
 /mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tasgvjg/9rSr6PqqAnpgZqUjxPALpLATTvHnlFo8jJg=;
 fh=BNXxXodM6x/TTtNw5dDUbIgJJ3THT0IIKdNrgcKqd+M=;
 b=SMb1GmDHyb+zbrgHm2VFHc8JGupE1BnvzFtlgtafjp7rxpHq8DiT6WeKfRaikal0fd
 MuDQriNJBM+5zvhYTep1qU4W/bsWTBelbtuNpzCOfYPB8FroxzzpLk1aomVwxkyz7ebI
 iEcVcyoEIcFkjRvT3aJAp92WQKdEO/kUMVnEStz+VJaIfcn/L8nGQvW1Ly0bYuzn6Zt6
 77JNYNGOsfhZLbN94jHozdnzApUFeSnoUPfvtiMEW7+Jws84+R+sg0SqALzfUV5PGFas
 bdIpKbFPggZkLW0wVm9fDetIv8oPEV/9iKEBd89Dn9+n4b3+q6EwFa/T9uSuZJ2SEfIs
 og2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014037; x=1771618837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tasgvjg/9rSr6PqqAnpgZqUjxPALpLATTvHnlFo8jJg=;
 b=oZO1DiClkREW6imJU4kl9JeCyyXy7kMDe+iFjs1SlMqZNhAY0CtNuR4BdZ3FFBZWGy
 rt9cFc2qZf+d9u/hnjnRX4Q32mJFuZSI01vbcCsl6pSkPqGYLNPMhPqgFLcUf6Jc9M1N
 N76Sf7Eg7Cxme6mR2Nmy+MJuS4+JKoKMc9WJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014037; x=1771618837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tasgvjg/9rSr6PqqAnpgZqUjxPALpLATTvHnlFo8jJg=;
 b=Po2BjfrKN4UaRN+wnW36eTHVvOkMfKQvB3eX/19WmjXmrj6Zid0mOcTrvmKuWoi433
 OZ4orFl9l+TQohtDUymWb3q8X9Tm5YPyHv5/pDm2KyTUzr5IjkzaraxCYS57uW+lfEOI
 fS8h5NYyEyoPTtnXnN0tL9iLul6zlMdTqg+MB5/mEPqoEp4kce4fq1PXur7EeXS+M81b
 fxq64yY2G7JkJScThsLqYvN5aKbXjnTsBp3F8DyBv2hO6Tm5JoORubCyha/lfZxZRDH/
 i/ow7LQHBwaz32xRF3+T46qCgEzMh7L9OlduxsBeuHawrw0AGwPW/S6+snbtq2T5CsI6
 NQHQ==
X-Gm-Message-State: AOJu0YzhRHP/3Ol7AsGEOwLgcHK/YilrNFdMEeKMiQidRlIV/Qf/M9oD
 BPmypRliC37vYt6IpytR8KvaeFbER6GsKp7FeKoNKKVPNDWE1Ut4oa60s8OnZUz4aBiWm4khNYc
 oweF7rrHeh1YAUSlol1IDOt/ZwJ096luDPMUI9dqO
X-Gm-Gg: AZuq6aIAinBE74IqL3zCIE+Ewzm6DcUIZB5VvsaSHL9yCcf48NSe1IzokkK/gD0HDDg
 YP5wDCvYRcOgC94a+KKYopz2cQNfZG6+7/8cZTn3cJO8IpihibJ7jrudoNEyBATgsqJ3Gf9J/3p
 NqUIeRFLpKHHurUaoD/Ms2FcmPhQsSACvf3oyNAzIov8U1TcKtpOc3GxrFiT/zQ40EhU6fMqmBT
 3p/+DFqM482cFP0bcyH25fMB7Se3psmzk8ex9I+UW0hI0sMrrZ0zC9DGp4EZ+DEukOeN/vkl8NP
 tIl7
X-Received: by 2002:a17:902:e745:b0:2aa:e0c2:3bcf with SMTP id
 d9443c01a7336-2acba48ea44mr12648475ad.22.1771014037392; Fri, 13 Feb 2026
 12:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20260213192838.157084-1-marex@nabladev.com>
In-Reply-To: <20260213192838.157084-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:20:06 -0700
X-Gm-Features: AZwV_QhAFZf7t2HWTevsZGO2b_E1XRkTfQ4gwdYKQNsT4PGUDjQ2vAbv_bScYB4
Message-ID: <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
Subject: Re: [PATCH v2] binman: add CST backend selection for i.MX8M signing
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

On Fri, 13 Feb 2026 at 12:28, Marek Vasut <marex@nabladev.com> wrote:
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
> V2: Fill in documentation for all used DT properties
> ---
>  doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 ++++++++++++-------
>  tools/binman/entries.rst                      |  7 +++++
>  tools/binman/etype/nxp_imx8mcst.py            | 12 +++++++-
>  3 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> index 1bea091344d..a3ebd397d82 100644
> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using either DT properties or environment
>  variables. The following DT properties and environment variables are supported.
>  Note that environment variables override DT properties.
>
> -+--------------------+-----------+------------------------------------------------------------------+
> -| DT property        | Variable  | Description                                                      |
> -+====================+===========+==================================================================+
> -| nxp,loader-address |           | SPL base address                                                 |
> -+--------------------+-----------+------------------------------------------------------------------+
> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin                               |
> -+--------------------+-----------+------------------------------------------------------------------+
> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> -+--------------------+-----------+------------------------------------------------------------------+
> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> -+--------------------+-----------+------------------------------------------------------------------+
> ++--------------------+-------------+------------------------------------------------------------------+
> +| DT property        | Variable    | Description                                                      |
> ++====================+=============+==================================================================+
> +| nxp,loader-address |             | SPL base address                                                 |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,fast-auth      |             | enable fast authentication method                                |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,unlock         |             | unlock CAAM in SPL                                               |
> ++--------------------+-------------+------------------------------------------------------------------+
> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is 'ssl', or selectable 'pkcs11'       |
> ++--------------------+-------------+------------------------------------------------------------------+

Perhaps point to an example?

>
>  Environment variables can be set as follows to point the build process
>  to external key material:
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 8922d6cd070..29bc778d0e5 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
>
>  Properties / Entry arguments:
>      - nxp,loader-address - loader address (SPL text base)
> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> +    - nxp,fast-auth - enable fast authentication method
> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
> +    - nxp,unlock - unlock CAAM in SPL
> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
>

The way it works is you add this as a comment in nxp_imx8mcst.py and
then run 'binman entry-docs' to generate entries.rst - see here:

https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation

>
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

Regards,
Simon
