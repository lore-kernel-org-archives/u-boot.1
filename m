Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5468ACAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021A383236;
	Tue, 16 Sep 2025 20:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CwUJkJCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436F183335; Tue, 16 Sep 2025 20:27:49 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168D483335
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-74526ca7a46so2323468a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047266; x=1758652066; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zXT6vp0M91on8rXoPgOjHIj9m6nYFmap9JQZipcoa1Q=;
 b=CwUJkJCSsJSHRoG+lS63LfGmyFBbb097Q+I2iFW3IM6yK4+AXUSuw8KbJK7SnDucS1
 MAbdK5r7nBtE8bXb7N/n71gdckmF8rAJ58J8M4G8uzJh24SXAiW+bLmiJzxJe6+up32A
 W0NiS9dcCIrpGnfqDnyrBfWkdJGBAxLeTShT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047266; x=1758652066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXT6vp0M91on8rXoPgOjHIj9m6nYFmap9JQZipcoa1Q=;
 b=YpV7lJ7qiqFTVQX2RjSZRjdAsyVryWFYpU3mFI14U1nXNaeSibK05MksKOHo55azUg
 KekGnskqMQAMzBQPjR41EwLtVlGutIEZnkEnyQIMszulpejqgiIjNGMdOh/z2kQHtPhb
 VTcRsXvhXw8w2O7IyZ/HEpRdlg5UISIShIzDog2pqEMvDIKUVVvoZswpHoW1I68WBRLQ
 /0M3O5s+fms73QcImqmN+K3aZaMq+SZ+KIeNxXMzbeRctgf6TjiAn900riz8hE2DLmi5
 3DHjBNZ1x+PiH/tYY3N/ndUfFHBwAXZ9VYHMa2+X8dd5w+6CEziA0DRS1Wg6E7FxrFZ1
 hYmA==
X-Gm-Message-State: AOJu0YxdNwKxneNZfT9Nu+aoIZ7G7o2QUlfsx0y4U0KyOjVb7fMQfjjL
 6+BCg07tOMlGeVfS6idCs+JZodNxkir17oaIrGFuSL8pjMwpes2+wfWHb68d5YbAdb0=
X-Gm-Gg: ASbGncs+74s6VK/1W8d8D9W3dhWFa2OIV4pbroADbsqWLVpLHH8LQhxh1ZK8fdhGU2H
 EU6+mWeiV0w5ty8rYs6beNQdxCVXueEPMNvubXH8sWcdhSDtJEN44Bszb3EMd/vDnb0/144gTg0
 dyElm/Lju+i2JbrM1wVoruxiwwUZLlrI0exJjLvd1MGbUljMOiLWLXjniVfu0gdMHaPNtT+drIG
 VFuW8na1XwcNbgF64R9Inzhl9y2G+/Ml9VnjHI1ckLVpPfLXDO9WimscV2a7dSCGxykMvzWhMgx
 nHDml1H3oQSyFzzFTGSiAPVIQdwI5xvw67AMWVpnvsKKb2ftRDT5R1776GQLR/0W/t/2dx51yz2
 1/dXkpppMOqDfUS1RlFNBtD6qRQiOEQH2ktaJIP419rtiW/4QePTi9KDtTa7jgWngElw=
X-Google-Smtp-Source: AGHT+IHe97Ac+mqsOCvl6Q4sWvQsUSTRLDDRJ5LWMJWn3mRRid0aMzs2G94ZwGwGTwRU+H00rGw4yg==
X-Received: by 2002:a05:6808:444a:b0:439:b28b:3e62 with SMTP id
 5614622812f47-43b8da383ebmr9982645b6e.44.1758047265678; 
 Tue, 16 Sep 2025 11:27:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7a6cc75sm1969146eaf.0.2025.09.16.11.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:44 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
Message-ID: <20250916182742.GZ124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VG43eOHkD83/AZpg"
Content-Disposition: inline
In-Reply-To: <20250916161426.32259-3-raymond.mao@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--VG43eOHkD83/AZpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> Add a script which is running after buildman to fetch TF-A (v2.13.0)
> with MbedTLS (v3.6) and build 'flash.bin', linking built U-Boot as
> BL33 and OP-TEE as BL32, with both Firmware Handoff and Measured Boot
> enabled.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  .azure-pipelines.yml               |  1 +
>  .gitlab-ci.yml                     |  1 +
>  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+)
>  create mode 100755 tools/post_build_tfa_fw_handoff.sh
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 8209d2b329c..eb547606ddd 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -290,6 +290,7 @@ stages:
>            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_r=
iscv64.efi
>            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm6=
4.efi
>            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.e=
fi
> +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAVIS_BUILD_DIR=
} \${TEST_PY_BD} \${TEST_PY_ID}
>            # create sdcard / spi-nor images for sifive unleashed using ge=
nimage
>            if [[ "\${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then
>                mkdir -p root;
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 85401d3e09b..61e4af96c9a 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -79,6 +79,7 @@ stages:
>      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.=
efi
>      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
>      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
> +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} ${T=
EST_PY_BD} ${TEST_PY_ID}
>      # create sdcard / spi-nor images for sifive unleashed using genimage
>      - if [[ "${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; then
>          mkdir -p root;
> diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_build_tfa_fw=
_handoff.sh
> new file mode 100755
> index 00000000000..f876db593ba
> --- /dev/null
> +++ b/tools/post_build_tfa_fw_handoff.sh

The "is this a valid board" check should be in the pipeline file (like
where we do all the other board-specific things) instead of the helper
script.

> @@ -0,0 +1,87 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2025 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +#
> +# CI Post-buildman script for building TF-A 'flash.bin' with Measured
> +# Boot and Firmware Handoff enabled.
> +#
> +# Usage: from the top level U-Boot source tree, run:
> +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUILD_DIR} \
> +#     ${TEST_PY_BD} ${TEST_PY_ID}
> +#
> +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and copied
> +# to /tmp.
> +
> +set -e
> +
> +BUILDMAN_OUT_DIR=3D$(realpath "$1")
> +BOARD=3D$2
> +ID=3D$4
> +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID: $ID"

Can we not use fiptool to update the contents of a file here? And build
as much as possible in the Dockerfile, like we do for vexpress?

--=20
Tom

--VG43eOHkD83/AZpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmsHgAKCRAr4qD1Cr/k
CkrlAQDNwO12P0/mR7ze4HEJ6cP821Fq/2pwp6l9pHPJlfnuJQEAzMZ/EtD+O2Ds
5aG+Ev2gQmvt4NcQogYF9isN8v0eFwc=
=zXSu
-----END PGP SIGNATURE-----

--VG43eOHkD83/AZpg--
