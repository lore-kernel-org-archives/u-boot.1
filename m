Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CBACAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97508329F;
	Tue, 16 Sep 2025 20:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B8SmxKB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98E4832AD; Tue, 16 Sep 2025 20:27:30 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7274A81E13
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-750b77699b4so4516440a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047247; x=1758652047; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QcnaAg3MgiH2eX05hvlKAV5oP0IJ3bY00ynJ+hDj+uw=;
 b=B8SmxKB/QaZD0Hxo++2Dt0flERwfteMd/6qDDOGM8w4OFK1E3CUe+No/uMnfIpCKxr
 sQKCaAOKSseOmICC4wfydOhiNeDNbWliFDZhZDu/jmeQz0mDTKbOTq92dpoIHw5ADcUb
 WQ8i9RNBzLtRSACMIH5xfVlaroP/ts4yJ2mR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047247; x=1758652047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcnaAg3MgiH2eX05hvlKAV5oP0IJ3bY00ynJ+hDj+uw=;
 b=WCgxpXsZnKspiBfoFfB6hugTiePz03mnJTmFbAD8+QEKW0CmzbkPNev3ZTI2uvLHcK
 EVWA7PS3jmC1wT+mhkJxnA0dqbsM3tp5Qz1IUCErevaaHTtjAdC7y/a1u7HjDzGuaIE5
 TN5m/4DlgXH4bViHqHftzp/vkxpKkU81vqehcWteiH6Q8ts4APh+Bh7grajZPoCrJ9qT
 OiY0CHlHXxe9SkjyBMfMwgyZzMjTJVjbtL1McuEuOgLox3RhwmQvUhaO8XadhMa4DiNu
 i96VqUEn9lXRMXL4c5QQvYqf5bOIVCJZ9Jd+g7Y/otpu273Q/pelaa9jEe3iXx4FJjNR
 85+g==
X-Gm-Message-State: AOJu0YzENHHNEUbuHJP2hseJ9ilezt3QhUzGKimiwbjnJ4nhjOUdMLuD
 C1XOIuGCzufT4myxc1ELFcC+fAZR7TOI4j5GxbRKxjPCnthBfVBB7NumF7zgXVvjOqQ=
X-Gm-Gg: ASbGncvrLlRUfbXcp7PYtpAO2HqgizqL76UrJvX85lajenMSkXWGv8HWXuPBUwZZLfE
 rSunsV/jGcM7J0XeJl9/p26cFJXpofzJx2lSdXQlTzSrVy4W1RzGTdkFRZ8FzT86dFsnGpkZ99A
 aawaUfswMfjwqXBQy40WxgOGKLnSSIk6ba4CG0IU1bpjCKZ53YqsJy8wWdE0ngWb8zKxiL4Apz7
 ka8odE76jdu3i6cM0/3pytyvPYIZmyY5SMJht/lzeIFS3Lj43tQli7/rKr6eiLUUdspTJaAlUyk
 eRtX6nwKfGt6lEzQNeGPs9OnOg7cIHZ4b25vgz24CoL0YTKIA12cGWGwZeuPj6CxShS6bf6aphy
 P9bNQTPhUCeLkeClbifgV0avv2TtvTq+Wb6yrnMCwlKasv19sYnd81ajYaGhD/Imy0KI=
X-Google-Smtp-Source: AGHT+IFfED0q7alCBOB6vE2Mo6+vSsIkAzJTMItH+YJSBvGXMts1Yo+Aq/rPU1rjoKKDeHEFTkvLrA==
X-Received: by 2002:a05:6830:6d18:b0:741:bf2f:ee88 with SMTP id
 46e09a7af769-753555c1d2emr8608138a34.24.1758047247144; 
 Tue, 16 Sep 2025 11:27:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7a6cc75sm1968947eaf.0.2025.09.16.11.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:26 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:24 -0600
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
Subject: Re: [PATCH u-boot-test-hooks 1/2] bin: add helper script for testing
 swtmp with TF-A
Message-ID: <20250916182724.GW124814@bill-the-cat>
References: <20250916161230.32140-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mTCdx0NNRadn1sHg"
Content-Disposition: inline
In-Reply-To: <20250916161230.32140-1-raymond.mao@linaro.org>
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


--mTCdx0NNRadn1sHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 09:12:24AM -0700, Raymond Mao wrote:

> The existing 'qemu.swtpm' does not run swtpm_setup to configure the
> algorithm, by default it enables all algorithms it supports, but TF-A
> currently only support sha256 and measured with sha256-only, enabling
> other algorithms causes more measurements at U-Boot and then leads
> to eventlog mismatching.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  bin/qemu.swtpm-tfa | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 bin/qemu.swtpm-tfa
>=20
> diff --git a/bin/qemu.swtpm-tfa b/bin/qemu.swtpm-tfa
> new file mode 100644
> index 0000000..cbcddef
> --- /dev/null
> +++ b/bin/qemu.swtpm-tfa
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: BSD-2
> +#
> +# Copyright (c) 2025 Linaro Limited
> +# Author: Raymond Mao <raymond.mao@linaro.org>
> +# Based on qemu.swtpm
> +#
> +# This script launches swtpm to emulate a TPMv2.
> +# It explicitly configures swtpm with sha256-only.
> +#
> +# The parameter -t makes it unload when the connection to QEMU is
> +# terminated.
> +#
> +# To make use of it add
> +#
> +#     qemu_helper_script=3D"swtpm-tfa"
> +#
> +# to the board script and the following arguments to qemu_extra_args
> +#
> +#     -chardev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock \
> +#     -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +#     -device tpm-tis-device,tpmdev=3Dtpm0
> +#
> +# U-Boot must be built with CONFIG_TPM2_MMIO=3Dy.
> +
> +rm -rf /tmp/tpm
> +mkdir -p /tmp/tpm
> +swtpm_setup --tpmstate /tmp/tpm --tpm2 --pcr-banks sha256
> +swtpm socket -d -t --tpmstate dir=3D/tmp/tpm --tpm2 \
> +--ctrl type=3Dunixio,path=3D/tmp/tpm/swtpm-sock

I think we need to abstract the current script to take arguments and
then pass them as needed in the conf.board file.

--=20
Tom

--mTCdx0NNRadn1sHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmsCAAKCRAr4qD1Cr/k
CpohAQCU9J9AqKy+mVKkT1tDKFOXmXdW+WAk9jL5E/OZUuCnSAEAvESWR3rkJgDm
dTx9ev1YZzblQuQdTIADnfCwvj8/Mgw=
=OcUk
-----END PGP SIGNATURE-----

--mTCdx0NNRadn1sHg--
