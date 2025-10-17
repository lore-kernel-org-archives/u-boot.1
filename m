Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709F7CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7CB83734;
	Fri, 17 Oct 2025 15:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RjR0xY3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A4C1837E4; Fri, 17 Oct 2025 15:57:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2734A8004F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760709432; x=1761314232; i=xypron.glpk@gmx.de;
 bh=fpewJCbaSzK+jJ8H7qhIlsrdCjX3uG8IwxKLk/RfbAQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RjR0xY3rzO+7YrcCzFNNmX6ejH4Vxc9SiAjdgkJbrEePqR9g72a/iT2TH570oT52
 fWNggtPZ3VGLjNUjiiH+Dc0XWylSOiq3v3IpkbRF5A5Oil+MEGk7izzvUJkuqlStm
 Obm7TRJh44johvyshDJBG15JfOx8SGJOwkLayQFhfJXJx6PDuijme5HVBGbgE41QG
 uUXH/5GA22Axuv9nZ9XAbwhmrENdKJrBBkPw6GV8O02oCdU2QLR3pax8LH+axcTQE
 MAx1Tj9EZVblCeqgJ9rQwT1zU2vC3kQh8X8+Iw+jsdTyCDECfplfufCVQMIjWa2+H
 HJicVpCw91pgnJrTZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1uyWOp1Bjn-00HA29; Fri, 17
 Oct 2025 15:57:12 +0200
Message-ID: <263454e4-2602-4f61-9454-dae294729fa1@gmx.de>
Date: Fri, 17 Oct 2025 15:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] doc: make pdfdocs: Specify texlive-xetex as a
 prerequisite
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-2-adrianocarvalho.pt@gmail.com>
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
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 open list <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251005221057.255029-2-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OC0gVlHkKf0vVy6jybokETeyA6p2lo+E2y4sLQnHfJy8tOtFhMU
 SF72OygU9IHsBYIyYwzIJymFDTocgkgE90n2LQb5ARHLFf6SmhrsJ3kx5kASpoBQ7aAOUsu
 bMSlv7h/my0doWGC4qZVlDKjLJmbEEyQwUWyyqmVxQK+8cSldnMnNfacARceie8e+Fl+8Jh
 bYDwuliWt9NIwGNVlqugw==
UI-OutboundReport: notjunk:1;M01:P0:wrMHZ7T9Z8Y=;weV/HbCGjz+/5Ggyr4HdvgZoWfH
 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
 fnFJw==
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
> Dockerfile updated as well.
>=20
> If I don't apt install texlive-xetex, this is what I get with
> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
>    HOSTCC  scripts/basic/fixdep
> doc/Makefile:89: The 'xelatex' command was not found. Make sure you have=
 it installed and in PATH to produce PDF output.
>    SKIP    Sphinx pdfdocs target.
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>   doc/build/documentation.rst | 2 ++
>   tools/docker/Dockerfile     | 1 +
>   2 files changed, 3 insertions(+)
>=20
> diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
> index b55a4666643..81548390d78 100644
> --- a/doc/build/documentation.rst
> +++ b/doc/build/documentation.rst
> @@ -16,6 +16,8 @@ the following dependencies are needed to build the doc=
umentation:
>  =20
>   * texinfo (if building the `Infodoc documentation`_)
>  =20
> +* texlive-xetex (if building the `PDF documentation`_ through the *pdfd=
ocs* target)
> +
>   When submitting patches for documentation always build with KDOC_WERRO=
R=3D1 to
>   treat warnings as errors.
>  =20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 5b4c75f8400..8e166eda4bc 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -136,6 +136,7 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt,s=
haring=3Dlocked \
>   	sudo \
>   	swig \
>   	texinfo \
> +	texlive-xetex \

When I try to run `make pdfdocs` I see an error message

     ! LaTeX Error: File `xeCJK.sty' not found.

Why wouldn't you install package texlive-lang-cjk?

Best regards

Heinrich

>   	util-linux \
>   	uuid-dev \
>   	vboot-kernel-utils \

