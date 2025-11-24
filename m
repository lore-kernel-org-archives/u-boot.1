Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AF1CFD35F
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 23:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F01B83EAE;
	Tue, 25 Nov 2025 00:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OnqxbOwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4315483EDE; Tue, 25 Nov 2025 00:47:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDD283E8E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 00:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764028005; x=1764632805; i=xypron.glpk@gmx.de;
 bh=CPbVP2YiLTXPGJi0/NMHXbL+XqfhXRWxOw07OumJxpo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OnqxbOwlhhY8NF2Sipk5hIz8EvOwZBzE6pLWaPeoGPgTMP9L+z7jDmljPpsVwEge
 H6NKHoeFi7eiSUN27sDbpKDxIwWakGlEPPyYzqwENTZ0Rm3bQDmZrdjTE8o8v5zqi
 CEKqRpvV6rb9J+xzRLpmz+NoSE9rvTQnqyemtoRyXUPHVi9Ur5mLf20qUwIwIJNQW
 +vJchSeMRo8QZ5BBtKvEJdw6iXbSJpFA5F/pfPQlbgzZO1MHF8RXedqQ2k4btiBZ8
 FAysodxP59Pj0uOVQCBPS8mlXoR03WX++0n8zAcXD7ho60EL+lgvVongEV3fsB/Kk
 frYnRdr+qmtXoXnPag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1vNOss2mDn-003sWn; Tue, 25
 Nov 2025 00:46:45 +0100
Message-ID: <d4cad994-e978-4319-958a-95371224ace8@gmx.de>
Date: Tue, 25 Nov 2025 00:46:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: pytest: fix hook script environment variable
 names
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
 <20251124-doc-pytest-fix-script-env-vars-v1-1-fec5b54007f1@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251124-doc-pytest-fix-script-env-vars-v1-1-fec5b54007f1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tndhM7SGGO5zGFr8kSd7VTUQJ9in+ABP3lY+Z4ly0nhiglBWXsy
 2uYSXSV6qrxF+5sI1b7BlkPoD6kyRCN2Ued6D329H8PiID5iAhq9ArsUddxjHNishvWba19
 Wgsywl3MvE+jKBY6dR1laHNnPBgfwaXzacIMsrrCIUgbfc5datwV/fG2xwDScJ5PUXNshFR
 oHTCrRFQplJk7UKeuXesA==
UI-OutboundReport: notjunk:1;M01:P0:4D84rVCy4BI=;JwainezDHZ5U4pGFumSxBBgbsMQ
 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
 0yKgOxMX2yrDphQU9YRg
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

On 11/24/25 23:44, David Lechner wrote:
> Fix the names of environment variables set for hook scripts. These
> have a U_BOOT_ prefix, not UBOOT_.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   doc/develop/pytest/usage.rst | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> index 7335a39b9633bb16869dfc976adab32d78dc984f..7c42a31528fd0ef78d3e24f6=
5ee86ce2d61d6e87 100644
> --- a/doc/develop/pytest/usage.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -315,14 +315,14 @@ Environment variables
>  =20
>   The following environment variables are set when running hook scripts:
>  =20
> -- ``UBOOT_BOARD_TYPE`` the board type being tested.
> -- ``UBOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` i=
f none
> +- ``U_BOOT_BOARD_TYPE`` the board type being tested.

I checked for the variable names in U-Boot origin/next and=20
u-boot-test-hooks.

I could not find U_BOOT_BOARD_TYPE via grep.

> +- ``U_BOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` =
if none
>     was specified.
> -- ``UBOOT_SOURCE_DIR`` the U-Boot source directory.
> -- ``UBOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source dir=
ectory.
> -- ``UBOOT_BUILD_DIR`` the U-Boot build directory.
> -- ``UBOOT_RESULT_DIR`` the test result directory.
> -- ``UBOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.
> +- ``U_BOOT_SOURCE_DIR`` the U-Boot source directory.

ok

> +- ``U_BOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source di=
rectory.

U_BOOT_TEST_PY_DIR does not exist.

There is a variable TEST_PY_DIR used in test/py/conftest.py.

> +- ``U_BOOT_BUILD_DIR`` the U-Boot build directory.

ok

> +- ``U_BOOT_RESULT_DIR`` the test result directory.

U_BOOT_RESULT_DIR does not exist.

> +- ``U_BOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.

U_BOOT_BUILD_DIR_EXTRA (used in test/py/conftest.py:167) is missing in=20
the list.

Best regards

Heinrich

>  =20
>   u-boot-test-console
>   '''''''''''''''''''
>=20

