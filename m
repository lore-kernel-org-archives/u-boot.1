Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA23F3D600
	for <u-boot@archiver.kernel.org>; Sun, 29 Mar 2026 12:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2CC83D71;
	Sun, 29 Mar 2026 14:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kzt0gRid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4358E83EB3; Sun, 29 Mar 2026 14:09:35 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A1F83B8F
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 14:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66abe08cdf5so5541963a12.0
 for <u-boot@lists.denx.de>; Sun, 29 Mar 2026 05:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774786172; cv=none;
 d=google.com; s=arc-20240605;
 b=hC265HTpLFKmlj0PbMe3enL4BXlehUgldwCJbDPobDvC6bQMJpENbU0oHxGvsn27q3
 nSwDUHB2i7FrCXtdRp5xGcFx80f9eYFVVMrGeYVWAwFMNAhLfsox8F9I0LA+7TsEbvqb
 fQkiWdPgOY0vrAylurb7Eaq9sEhdkHVbekV6GgIEg1i+eoTnhqHup7U3mQ6ABk0dNayo
 tDHh11+98+eNaqD8ZcvYNctExf8VtylQS97MFJIog3/drvPKMtBrHAMiWBKFQsTZMdEm
 5/O8i0FSAmn6HjZULv2JV+Pt5Gw0Ha9ojgShI4GxVIqyv5n2n3EagmPkky7cOPnEkA4A
 LpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cbNRqe1CMMp74DB1pDrlaKz4mKuVAGx+T61zR0QitE8=;
 fh=BNXxXodM6x/TTtNw5dDUbIgJJ3THT0IIKdNrgcKqd+M=;
 b=ZvITMOFKnkCdKG0gw06t7ZQR7dorxp+unBCa+EMOHXiqjRYZzWl0Kx2br+QxL6hNWJ
 Dj82jPpzkqj2SYAfGd67Q4WDHA4ueaiGnaaUiEuHjr5fW68I+ktF73IA+zJAIEBNGLgk
 GdakgkFL421pb2HonkXs1bpxR8npVFI55SRmJIpPsy5w4/ejNNW76ksd37JrW58R2+Pi
 g7V8HL6RtAYIEmurrUbC65JBiPkCo1Srh8gXtY9cUXLBuvD3idKQmZ/BMTNgnTByN3m+
 fwHCW2gNMJBYH1ppjMfICo0id3a3Npphw3X9s6lg5RwTDvILqol3GK6+N61qLustGSI2
 oyUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774786172; x=1775390972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cbNRqe1CMMp74DB1pDrlaKz4mKuVAGx+T61zR0QitE8=;
 b=Kzt0gRidgslhw6T40jUuTRR8CeB16LADzVYO8yBGeLOkn1vxmSxCyVLTv74QhtiB0E
 +P1sIBdnXRLRuwHy2svBIyl1+CO1BgW6cWFCdnghObnuCvxzeFdfMgyEcFc4vCnogQ6M
 mchNHj8GF9PQFHU/uDkvPF728xhzG0+KRFl/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774786172; x=1775390972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbNRqe1CMMp74DB1pDrlaKz4mKuVAGx+T61zR0QitE8=;
 b=kQqsnG3KyJftNGDyBEruWQB2QywVWGw/d9ECW/ROq9J3OO6PnFLhv5C1gGeXaXlFiI
 PJ3fIOaldbY3ZCiJc8ZsfYCZu+ZMAnEdF2g50Ei/pgfBXa6nscnPp0SxXmZk41jnbR4T
 dVPQf1uRyaX0az0777wHqeUTJx8pRfftIL7UxDEcOglGJ1jXmLtDhvCSv5MR3mbe0tu0
 SFACD/2LHiPUMtV9r9eNs2bQsDAQ2eKCpTirSqG8hzG3uuEdb9Hf3oqHwIKjgAiaFMxL
 dR6gBl1kK7h2+8MowXuSjzQUpy19xDv69WSRC7nDBj9ULYss2FM1f72J1rlVtf/T+S4h
 c92g==
X-Gm-Message-State: AOJu0Yza0/N5TpkxxCGIzIpbXKn2IJViAxS+JJXuo/ekl/0wyROOFzpX
 H7qkaSPS9d4RaMeavseCtYqy46tn5N4a1TRT5Mw/vZSPeEP0aig2qCcFAcZGKJFh7ER5kIOKg08
 hGkXSmO8nQ3IHUNX0DG0qofOJ2MQCSto7Dsimal0niX+7qUX68C8=
X-Gm-Gg: ATEYQzyJdj67u4DC9E5HesTcedWaB+D1ilLLFXD8Kqxd1QiiDCdqfjB0jQZjNpHCfWl
 rfxqizRDj2qXqAVV/mvAaP7n0cEQkVdR7pULtII8cp5fa2yrC3YGR3bMwMnIgwUdDX+7kza+l7O
 SrIl8yiuQijpBfHreUIXFaVtrOVOkjADfpWteylEpWjIabU5mHLO1jKG0T0GGuk5afaetjX74jk
 jjqgPOBA7kFSZNzL2evq/aRHs3N28Ves1cwOGoyzFCQJ0mXnoRGWBaQKMEnfwwuoXYagypc5qTN
 LtOKGg==
X-Received: by 2002:a17:906:ef08:b0:b98:549d:8367 with SMTP id
 a640c23a62f3a-b9b5033e19cmr569326066b.17.1774786171976; Sun, 29 Mar 2026
 05:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260321195238.174658-1-marex@nabladev.com>
In-Reply-To: <20260321195238.174658-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Mar 2026 06:09:20 -0600
X-Gm-Features: AQROBzDHvdYXyrLiboMk3hFD2JgE1_hU6eUUivw8VtWudLSVWfYPAFEEvU-Cprc
Message-ID: <CAFLszTjdv78kSfFwBXxGq=wxP7y-bc4O_8jDeVTtQFtLct4L4Q@mail.gmail.com>
Subject: Re: [PATCH v3] binman: add CST backend selection for i.MX8M signing
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

On Sat, 21 Mar 2026 at 13:52, Marek Vasut <marex@nabladev.com> wrote:
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
> V3: Fill third copy of documentation into nxp_imx8mcst.py
> ---
>  doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 ++++++++++++-------
>  tools/binman/entries.rst                      |  7 +++++
>  tools/binman/etype/nxp_imx8mcst.py            | 19 +++++++++++-
>  3 files changed, 44 insertions(+), 12 deletions(-)
>

This is missing coverage for line 177 of nxp_imx8mcst.py:

   cst_backend = "pkcs11"

Please can you use (or mock) this feature in a test.

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
>
>
> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index dd9f226b751..a10f61aa01f 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -65,6 +65,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>
>      Properties / Entry arguments:
>          - nxp,loader-address - loader address (SPL text base)
> +        - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> +        - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> +        - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> +        - nxp,fast-auth - enable fast authentication method
> +        - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
> +        - nxp,unlock - unlock CAAM in SPL
> +        - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
>      """
>
>      def __init__(self, section, etype, node):
> @@ -90,6 +97,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
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
> @@ -161,8 +172,14 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
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
> 2.53.0
>

Regards,
SImon
