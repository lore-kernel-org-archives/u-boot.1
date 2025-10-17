Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349B1CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 14:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B225A83700;
	Fri, 17 Oct 2025 16:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="N1tmJXu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AD583826; Fri, 17 Oct 2025 16:29:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872B78309A
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760711362; x=1761316162; i=xypron.glpk@gmx.de;
 bh=SGn9pzvTSVTiBPwzk2kVBYmAUFkw2//9DXq8/qh4yms=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N1tmJXu/2ilEolCOxJ2RnFm/eV8QvtE+L0MXfuO6kAvNZasEdul6/2/dLjkcL+sC
 axHsTiHlLj9YDXgYdsp32LJguzy7YzGwiLLyD2PRbMzk8S5vkJnyUS+9ysbftX5Ed
 V6PAhRt1wiaRS19t0loymrShjRbm8fvRT8wKxQaYUWmeVtNxw6w2E1HMhviQPxVgq
 JD6KDwWPy7c2ZD+U6+PVJxov8hZ1Mk2+oJhhfIjC3HMztYV/HVTyQc6nTsGa0x9I8
 TfH4wVLe4zUb4Nm9PJIr/tNet32Yxfit/APsXVum6VqkblqIh+NMQpKfLlL0KeG0P
 rhryrP1SDQWvhUc5xQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1uwaBd3DTE-004Io5; Fri, 17
 Oct 2025 16:29:21 +0200
Message-ID: <279f61aa-4328-453a-8ba3-802848dffd86@gmx.de>
Date: Fri, 17 Oct 2025 16:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] doc: make pdfdocs: Address issues with the make
 pdfdocs target
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Garrett Giordano <ggiordano@phytec.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 open list <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gh7MUhT03gEnOxNsR2dz6AyPLKJ8t8agXvSS43PFNjBXEI4nAds
 YpR0q+wT6Y5mgVfjdZ8gaFn+pMIgJ6J0O0WCU+4FzzETKHlJHGuOIwjMxv6FJ13x1lbwIGY
 FzoPeNmQDL52vq8MhBoQb7IhVEpuDyhQhIGyjWXptqcyFIkbwUFXBzcGcZsAwEcOPSh3R2E
 F4jNOXAA5Z+Lmw1RcQnwA==
UI-OutboundReport: notjunk:1;M01:P0:H7GZkWKdw9M=;T8xcEpWflvpayd1V3LilXh1ZkqS
 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
 wHGWqUVyc1ro1P9jyCYmgMxldQ=
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

On 10/6/25 00:10, Adriano Carvalho wrote:
> This patch series address several issues that were affecting the make
> pdfdocs target.
>=20
> In the end, the make pdfdocs could be considered fixed. It is at least
> with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025.
>=20
> The thing is fixed only after the 6th commit. Each commit solves one
> issue, in the order as they appeared. I hope it makes sense.

Thanks for investigating the build failure.

The output seems to be separate pdfs usage.pdf, develop.pdf, ... .
Does this really make sense?

I still wonder if anybody ever would use such pdf files when he can have=
=20
HTML documentation. Maybe you could use the files when dealing with a=20
regulatory authority.

Best regards

Heinrich

>=20
> Changes from v1:
> - Use already in place kfigure sphinx extension instead of
>    sphinxcontrib.inkscapeconverter.
> - I have kept the dependency on inkscape because: (1) ImageMagick's
>    convert fails to the job, and (2) it's what's done in the Linux kerne=
l
>    on which kfigure is based.
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
>=20
> Adriano Carvalho (7):
>    doc: make pdfdocs: Specify texlive-xetex as a prerequisite
>    doc: make pdfdocs: Update the description with the needed steps
>    doc: make pdfdocs: Add pip install -r test/py/requirements.txt to the
>      list of needed steps
>    doc: make pdfdocs: Ensure SVG files are converted to PDF before the
>      compilation of *.tex files
>    doc: make pdfdocs: Update kfigure sphinx extension to support inkscap=
e
>      as well
>    doc: make pdfdocs: Increase the maximum list depth
>    doc: make pdfdocs: Remove redundant "-j" option
>=20
>   doc/Makefile                              |   1 -
>   doc/board/beagle/am62x_beagleplay.rst     |   8 +-
>   doc/board/beagle/am67a_beagley_ai.rst     |   6 +-
>   doc/board/beagle/j721e_beagleboneai64.rst |  10 +-
>   doc/board/samsung/e850-96.rst             |   2 +-
>   doc/board/ti/am62ax_sk.rst                |   6 +-
>   doc/board/ti/am62px_sk.rst                |   8 +-
>   doc/board/ti/am62x_sk.rst                 |   8 +-
>   doc/board/ti/am64x_evm.rst                |   8 +-
>   doc/board/ti/am65x_evm.rst                |  12 +-
>   doc/board/ti/j7200_evm.rst                |  10 +-
>   doc/board/ti/j721e_evm.rst                |  10 +-
>   doc/board/ti/j721s2_evm.rst               |   6 +-
>   doc/board/ti/j722s_evm.rst                |   6 +-
>   doc/board/ti/j784s4_evm.rst               |   8 +-
>   doc/board/ti/k3.rst                       |   8 +-
>   doc/build/documentation.rst               |  28 ++-
>   doc/conf.py                               |   4 +
>   doc/develop/memory.rst                    |   4 +-
>   doc/develop/trace.rst                     |  10 +-
>   doc/sphinx/kfigure.py                     | 212 ++++++++++++++++------
>   tools/docker/Dockerfile                   |   2 +
>   tools/patman/patman.rst                   |   2 +-
>   23 files changed, 252 insertions(+), 127 deletions(-)

