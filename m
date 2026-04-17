Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618F6F8E4A7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 05:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A7783EEF;
	Fri, 17 Apr 2026 07:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="g8fzdx7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47DA783FC0; Fri, 17 Apr 2026 07:37:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA4A839D9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 07:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776404270; x=1777009070; i=xypron.glpk@gmx.de;
 bh=Ld3xGvJXWppwa9y/CV0cX6ZYra3guVoQWrG7QgsLUX4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g8fzdx7EvqZSCiHwYb3YJMayRkx8Wk1YOlLB5HIp+zmNuju6DEzmBlo+R1NGo74A
 2RotivntXEv2XSY2MEhb94WZQprnEBpI6W5Ir3hmmYoQQ6VCn4nNZNRnAtiw12/a7
 sjKReIvyQz0HmHSljto+jE0VcMhAeckK2yU0TpxTmt3bfBWNbSLAPGlfCIJ0Ms4kq
 t2wMccAff58naQ22tHl0Flczz0b9fGGrQtgPM3t06HIsRju0DN6dcuPIzpiHdCS8o
 YSW7auNeEtJuah5OP3iFoyVIFtYsuVHRICmfGGGoemxgZkBr0w81OYr+S9mLNbsvE
 n4vf/nEPlUlDMrsJfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1wIZiR3NS6-00EQ1i; Fri, 17
 Apr 2026 07:37:49 +0200
Message-ID: <4a2c3823-c5ae-4e97-ade1-d54ebb29751c@gmx.de>
Date: Fri, 17 Apr 2026 07:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Auto-generate binman entry and bintool documentation
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Aristo Chen <jj251510319013@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, Yannic Moog <y.moog@phytec.de>
References: <20260318132400.1856600-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260318132400.1856600-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J10esPQRErhskZiXL1ENlYTzo4ptwqJAegbs7pDXtuhZDt1f1Jk
 kUPCZLJ7eEFA5eUAYm1dDHkZZEFC8oPp3ToDPDVvFErJPc9V/npW5ZuchLzjM06BalRv/yE
 TxXJeh2hLBMPZ8kcKj8ubOz0qaS0PazziXDtqyl213INu0G/V7U5UcojJvZ8ttt5yzUHFMQ
 MsB069KkMqzUGOOM0d2BA==
UI-OutboundReport: notjunk:1;M01:P0:wRNkie2iU/4=;ly0xpgCtboTtGX/TiR+w06NlIQ5
 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
 Uas/bGXTep7sqJQ==
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

On 3/18/26 14:23, Simon Glass wrote:
> The entries.rst and bintools.rst files are currently generated manually
> by running 'binman entry-docs' and 'binman bintool-docs', then committed
> to the repo. This means the docs drift out of date when docstrings are
> updated but the RST files are not regenerated.
>=20
> This series provides a Sphinx extension to generate the file. This
> approach keeps the docs in sync with the source. It also avoids
> importing binman modules so as to remain compatible with readthedocs.io
>=20
>=20
> Simon Glass (2):
>    binman: Add Sphinx extension to auto-generate entry and bintool docs
>    binman: Remove pre-generated entries.rst and bintools.rst
>=20
>   doc/.gitignore                   |    2 +
>   doc/conf.py                      |    3 +-
>   doc/develop/package/bintools.rst |    1 -
>   doc/develop/package/entries.rst  |    1 -
>   doc/sphinx/binman_docs.py        |  207 ++
>   tools/binman/binman.rst          |   12 +-
>   tools/binman/bintools.rst        |  249 ---
>   tools/binman/entries.rst         | 3129 ------------------------------
>   8 files changed, 215 insertions(+), 3389 deletions(-)
>   delete mode 120000 doc/develop/package/bintools.rst
>   delete mode 120000 doc/develop/package/entries.rst
>   create mode 100644 doc/sphinx/binman_docs.py
>   delete mode 100644 tools/binman/bintools.rst
>   delete mode 100644 tools/binman/entries.rst
>=20

Hello Simon,

When applying the series I saw that generated documentation is missing for=
:

Bintool: p11_kit: p11-kit =E2=80=93 support tool for pkcs#11 libraries
Bintool: pkcs11_tool: pkcs11-tool =E2=80=93 support tool for managing pkcs=
#11 tokens
Bintool: softhsm2_util: SoftHSMv2 =E2=80=93 support tool for libsofthsm2

It would be great if in a future patch you could add the missing=20
docstrings for these.

Best regards

Heinrich


