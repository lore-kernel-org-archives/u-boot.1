Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3BCCFD31F
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 23:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4140583EAE;
	Tue, 25 Nov 2025 00:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HTO62YcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5803A83EDE; Tue, 25 Nov 2025 00:53:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6D283E8E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 00:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764028409; x=1764633209; i=xypron.glpk@gmx.de;
 bh=a0AlzBneLcC2x3Fuv+u5JewrArtLYoAWNEbDaaMuZ40=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HTO62YcQCDKxwOaHRFziYmdOgZ2Eibwqat0mKEFfFCoLr+jCZM3ADW+8FUlCiv0k
 O5aCP0fJlu+eyVNvMmPUdJWQN/HEQLKbuhmF9OgY6QpoVdpUC4tJwqBl0Kx9VPoxj
 MuSt9nGfMY7UEJk9jc9kJKfigzlN9AZofeY3VarNmuNwYUgEPdJfKSgOIwlz8A+1c
 oQQPSxc+1Iox4gNwekASOg/Iqh8vdgt2gDGAJdpJfywlSHRPPO88+LOkDUO5zxEQX
 rp/Au1h6jSf4dMVl6RvttqCFEman1OICkEkD0iP0g2kpQJyXrfhS0hWJDmHGJnHKb
 LQaa97DoZbrWDUJIYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1vgIcP28se-00QMpy; Tue, 25
 Nov 2025 00:53:29 +0100
Message-ID: <5b53a23e-1679-46e0-92c3-7574a35ae8f3@gmx.de>
Date: Tue, 25 Nov 2025 00:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: pytest: add missing hook script env vars
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
 <20251124-doc-pytest-fix-script-env-vars-v1-2-fec5b54007f1@baylibre.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251124-doc-pytest-fix-script-env-vars-v1-2-fec5b54007f1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BLX4c/FJU2NqL00e0gntBAnYzcLNRDg2QNs9EPKcv1bSE4r4vgv
 bUly9UdBfoKaFpbisz2HcuHwHSIma/iJeF2EVfhTIgZkgMqmYgM5zd/ItWFYZW/JurtMK+r
 Or3mKnTmiuMh/MXkU7CfE3jSf5ZhyIM4pQfoGf1WUNzPST29OM/guv2HfXpUm1vwILFMo6k
 82Nv2rnMcqrI+0GpDERIw==
UI-OutboundReport: notjunk:1;M01:P0:lluUg8p62sQ=;fJyAqulUM5sA4alJNFndVgZVR4w
 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
 LAruHPN6DocNzb16KLE0IKjjhh5Li5/91U+oTs
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
> Add the _EXTRA variants of U_BOOT_BUILD_DIR and U_BOOT_RESULT_DIR to the
> list of environment variables set for hook scripts.
>=20
> These were added in commit 8f2a9fa7d6e7 ("test: Support testing with two
> board-builds") but were not documented.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   doc/develop/pytest/usage.rst | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
> index 7c42a31528fd0ef78d3e24f65ee86ce2d61d6e87..df3821da20dd6e4199947a59=
4e5e2eb2198e6e6d 100644
> --- a/doc/develop/pytest/usage.rst
> +++ b/doc/develop/pytest/usage.rst
> @@ -316,11 +316,13 @@ Environment variables
>   The following environment variables are set when running hook scripts:
>  =20
>   - ``U_BOOT_BOARD_TYPE`` the board type being tested.
> +- ``U_BOOT_BOARD_TYPE_EXTRA`` the 2nd board type being tested, if appli=
cable.

I cannot find the two strings above in U-Boot. The mentioned patch adds=20
'board_type_extra'. Where is U_BOOT_ prepended to the capitalized string?

Best regards

Heinrich

>   - ``U_BOOT_BOARD_IDENTITY`` the board identity being tested, or ``na``=
 if none
>     was specified.
>   - ``U_BOOT_SOURCE_DIR`` the U-Boot source directory.
>   - ``U_BOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source d=
irectory.
>   - ``U_BOOT_BUILD_DIR`` the U-Boot build directory.
> +- ``U_BOOT_BUILD_DIR_EXTRA`` the 2nd U-Boot build directory, if applica=
ble.
>   - ``U_BOOT_RESULT_DIR`` the test result directory.
>   - ``U_BOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.
>  =20
>=20

