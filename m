Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20114C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 21:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2062282B34;
	Sat, 28 Jun 2025 23:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FNCON7ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5D482DA1; Sat, 28 Jun 2025 23:21:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF2E82977
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 23:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751145663; x=1751750463; i=xypron.glpk@gmx.de;
 bh=44rBkUvk2wOu3ZQ/wGvDwG9DQOtPCqaVeEjdtgLhT1U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FNCON7nipF6lY7kmPbRVQXgCgb+Kq3takpafLSBmJnDP934kFGdB+JTHsXKzrDZE
 7Qi02AZCdX9rxyr53PAWzS6Ssg2i4jsSHU1qJYt35JfroiJ69PkStwgxDUa87LcK3
 wfqs44pzoJ0TUhmP5fUPDlzotle9hQltz2DpH4HBBE1ABLEQj2/Oy+pj+HYjEzr0X
 evXsE1LKfNa+Q3CeekAqCnyFFnyGg1qbusHvw9vwvswfAU75pVQ5eIA6FGVjq6V0W
 mE+JhFZcf11SZNrXK811pxcETulhny7dQteA8z3UCzWZNBiPN2qBh37eNhpHd3myo
 Nvdnx+Aji1R4sIrcdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.106.132]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHAH-1vCMeC2Apf-00dtws; Sat, 28
 Jun 2025 23:21:03 +0200
Message-ID: <e6b3f1be-3b8f-44ce-8088-90abb37c07fc@gmx.de>
Date: Sat, 28 Jun 2025 23:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cmd: Introduce CMD_HELP
To: Michal Simek <michal.simek@amd.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 git@xilinx.com
References: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <3f2984f62d6bda6a4a432b51047eddb70e35571f.1751014184.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LYzj43QguHe90irGqrntXqW9rK+AYMQ3QFm5ez+Kl2t9/+u/cNk
 9E3hCYHcgIKZv8tmuB3MylWvtwYXl1ZZdoPbs9E3s+eTQMqqf32DQ5tVOofnoZ8AzuSFUcE
 OmLPmATWE7TpR/LksdH5vF5Df7tAq87/TFzBulENQ+P/wRM6ShRqTuSQRK/PSqYyy7Zti/v
 v84DZsRjcxdemDyrZS0GQ==
UI-OutboundReport: notjunk:1;M01:P0:6kteFfS8rOk=;MN9PFtpjfITQRPWNQ9+pkm0Ll1/
 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
 TVBxDV57FXQ==
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

On 27.06.25 10:49, Michal Simek wrote:
> Add option to disable help command in size constrained systems to save s=
ome
> space.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

The patch looks fine to me.

When I read through cmd/help.c I am wondering why it has

#ifdef CONFIG_CMDLINE

I would assume that without CMDLINE we wouldn't have this command.

Definitively after your patch this the case.

Please, update the tests in
test/py/tests/test_help.py
to depend on the new Kconfig symbol.

Best regards

Heinrich

> ---
>=20
>   cmd/Kconfig  | 6 ++++++
>   cmd/Makefile | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index f21d27cb27f2..3f4221cb4d02 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -189,6 +189,12 @@ config CMD_FWU_METADATA
>   	help
>   	  Command to read the metadata and dump it's contents
>  =20
> +config CMD_HELP
> +	bool "help"
> +	default y
> +	help
> +	  Command to show help information about other commands.
> +
>   config CMD_HISTORY
>   	bool "history"
>   	depends on CMDLINE_EDITING
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 80cf70b7fe8c..718eff4ed197 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -7,7 +7,7 @@ ifndef CONFIG_XPL_BUILD
>   # core command
>   obj-y +=3D boot.o
>   obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
> -obj-y +=3D help.o
> +obj-$(CONFIG_CMD_HELP) +=3D help.o
>   obj-y +=3D panic.o
>   obj-y +=3D version.o
>  =20

