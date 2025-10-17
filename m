Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56F6CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EA9837E4;
	Fri, 17 Oct 2025 15:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O6t5z7oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6407983804; Fri, 17 Oct 2025 15:51:30 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367A983734
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760709086; x=1761313886; i=xypron.glpk@gmx.de;
 bh=zc7v8BeQRH4nH5bL6LnrF5HgmHBJtFgYG1ewkCP+JUA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=O6t5z7oYN+H9roeS1kzXgucyBKZHFYzjNSg5cc3V2D5r1Cfnk+cfVXXdfAPUoe3I
 TJS1+ZMt4VkjOnWPgBSVujIXCCL2GBbH8/qsnibbyuvsTTr0bUl/K9bMzP+RPCx3i
 8CG/fK0ibVgnjFEfs1X9eMppuJ3ORXlviKvfKmt3/2aYlEMLwzG279oQqq8FFJ5oL
 x1GsboE9rIqD5Cc+XXntl/aWnAK+kQahgkUhYm2AGhZPi28FcbfGAF6PAs6CFGJJT
 4RHdolpsr/E9e+hXwxer3jZWZBEncXbvTbUjuvR5cpHRb7L59h6HxWY31WloXkiN6
 yxlGFTe+IGRmyvVayQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1uNGxx2RcZ-00cXV8; Fri, 17
 Oct 2025 15:51:26 +0200
Message-ID: <de5cb786-0a26-40ed-b120-321afdd23624@gmx.de>
Date: Fri, 17 Oct 2025 15:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] doc: make pdfdocs: Add pip install -r
 test/py/requirements.txt to the list of needed steps
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-4-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 open list <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251005221057.255029-4-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YG4GJ1t1F2U5pTZK/tHO9AlObFTlGY06y0ngUF1Rr4BoFH+xQrN
 EUyn2AKUrvTJBCrkUtvkYPdKP2XFVFYfAQqbNWa0WogEHhCgz5P4OYD83EWgrmTu3IQJ615
 1l/ihqpt2rW+9LIL/Cpp6W15xmIiRxTn29rdKzpxK/K+oRqMebY9707pnR6Hj+I7NxHEVuV
 Ct0W++HwUL5DlBRd65yIQ==
UI-OutboundReport: notjunk:1;M01:P0:v5c6C+ChNz4=;uA12LcZ4HL8LMR79+E0BFCo0mGT
 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
 aWoV+enO917gnAaBI=
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
> As requested, I added this step to all doc targets.

This change looks wrong to me.

Everything needed to build the documentation should be in=20
doc/sphinx/requirements.txt.

Everything needed to run tests should be in test/py/requirements.txt.

If there is an overlap that is fine. But, please, abstain from confusing=
=20
the two.

Please, add missing dependencies to doc/sphinx/requirements.txt.

>=20
> If I don't do this, this is what I get with
> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
> [...]
> WARNING: autodoc: failed to import module 'test_bind'; the following exc=
eption was raised:
> No module named 'pytest' [autodoc.import_object]

Why should pytest be needed to build documentation?

Something must be really wrong in the pdfdocs make target if this error=20
comes up.

Best regards

Heinrich

> WARNING: autodoc: failed to import module 'test_bootmenu'; the following=
 exception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_bootstage'; the followin=
g exception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_button'; the following e=
xception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_efi_loader'; the followi=
ng exception was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_net'; the following exce=
ption was raised:
> No module named 'pytest' [autodoc.import_object]
> WARNING: autodoc: failed to import module 'test_net_boot'; the following=
 exception was raised:
> No module named 'pytest' [autodoc.import_object]
> [...]
> build finished with problems, 7 warnings (with warnings treated as error=
s).
> make[1]: *** [doc/Makefile:84: latexdocs] Error 1
> make: *** [Makefile:2687: pdfdocs] Error 2
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   doc/build/documentation.rst | 5 +++++
>   1 file changed, 5 insertions(+)
>=20
> diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
> index f977781184d..483bdc42227 100644
> --- a/doc/build/documentation.rst
> +++ b/doc/build/documentation.rst
> @@ -35,6 +35,7 @@ The *htmldocs* target is used to build the HTML docume=
ntation. It uses the
>       . myenv/bin/activate
>       # Install build requirements
>       python3 -m pip install -r doc/sphinx/requirements.txt
> +    python3 -m pip install -r test/py/requirements.txt
>       # Build the documentation
>       make htmldocs
>       # Deactivate the Python environment
> @@ -58,6 +59,7 @@ The *infodocs* target builds both a texinfo and an inf=
o file:
>       . myenv/bin/activate
>       # Install build requirements
>       python3 -m pip install -r doc/sphinx/requirements.txt
> +    python3 -m pip install -r test/py/requirements.txt
>       # Build the documentation
>       make infodocs
>       # Deactivate the Python environment
> @@ -78,6 +80,7 @@ The *pdfdocs* target is meant to be used to build PDF =
documentation:
>       . myenv/bin/activate
>       # Install build requirements
>       python3 -m pip install -r doc/sphinx/requirements.txt
> +    python3 -m pip install -r test/py/requirements.txt
>       # Build the documentation
>       make pdfdocs
>       # Deactivate the Python environment
> @@ -95,6 +98,7 @@ We can use texi2pdf instead:
>       . myenv/bin/activate
>       # Install build requirements
>       python3 -m pip install -r doc/sphinx/requirements.txt
> +    python3 -m pip install -r test/py/requirements.txt
>       # Build the documentation
>       make texinfodocs
>       # Deactivate the Python environment
> @@ -115,6 +119,7 @@ To build only the texinfo documentation the *texinfo=
docs* target is used:
>       . myenv/bin/activate
>       # Install build requirements
>       python3 -m pip install -r doc/sphinx/requirements.txt
> +    python3 -m pip install -r test/py/requirements.txt
>       # Build the documentation
>       make texinfodocs
>       # Deactivate the Python environment

