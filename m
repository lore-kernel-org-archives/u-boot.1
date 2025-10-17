Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106B5CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5253E83829;
	Fri, 17 Oct 2025 17:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oP8pKA+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206DF8382E; Fri, 17 Oct 2025 17:01:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228DB83734
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760713265; x=1761318065; i=xypron.glpk@gmx.de;
 bh=bNu3dtsdfIhNh5iblPHky8CWnCSZ1Ph3kSyPvFB/GlE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oP8pKA+fnSdVs15YY0Q79Qjo3EVAHqM2qCiObYiMabKi4Xgwt9jMgc1NXwYD4B6F
 L4vkYxpmi1uyW5UKf/QhcawlSO8AKNxESa91bHTqLB/ghwUIk+mm2OULvPrWeihD1
 M+4/BmW/GDKB2L2RGaw8KEEeF+rqERepM6hsHqsLsHEcME/WZ0bcPXi5yodcOEwTf
 SHXdiraFJOxm2b9BNw3kDsLqiBoMnQy8Hw9vRS7nkxx6vcb1Qm2oI0mmG/0Tdoot5
 IDNFIhOg0yin0e72ujoF0Z4CszGLm8kboDV6HCT5aO7MFGpDPSFDSMUst6f95t1Kg
 WD9XC3CyN+/Gqi1kBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1v8eQH1SiC-009mEj; Fri, 17
 Oct 2025 17:01:05 +0200
Message-ID: <48b2ce1b-8d89-4298-a86d-54b092cfaba9@gmx.de>
Date: Fri, 17 Oct 2025 17:01:02 +0200
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
X-Provags-ID: V03:K1:hRS0Ugen+9hL3DbbTKICO4qkGolQRVJPhryN5Ya46cTrV+3Kr2z
 DW/jlTyv8MRW/eou5UBGRwyh7jXAZjmeJKhE/H9R2+mni3SMYGdnsQCfi56HzKERcgM2EW/
 vKF50qvBb0dCS5S0IYNHgW97ur03FgKC+qsB501YnxmKFgJ0JPM12r2Ii39NV3tJRD8VOWS
 maXFH/IFo3ci90F56IaEA==
UI-OutboundReport: notjunk:1;M01:P0:W/GTIQSL+YQ=;kx92Rxhxq6enlsqbrzyS9rXxlMm
 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
 ushgaaSr6YXtj9Joak0bXOuK90=
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

Please, add a patch that runs make pdfdocs on the CI.
Otherwise I would expect that it will stop building again.

Best regards

Heinrich

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
>=20

