Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1705ACD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A4184154;
	Mon,  8 Jun 2026 10:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="es4Cy0nB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EEF8466E; Mon,  8 Jun 2026 10:04:51 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE7E83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA2A2601D8;
 Mon,  8 Jun 2026 08:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81271F00893;
 Mon,  8 Jun 2026 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780905888;
 bh=8ofSHvjN6R4B4P36w2bov5CRotrjkW6odD6hlR4AFIU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=es4Cy0nB6fL6fYfqz4sLR2qsqGoDtfyylVFUbaVF526cGtTNK/BlA90x7NNygojpC
 m9C+1rGlAwKTY2k8R3j9xUwX0UPOksMpWtuUlJUQQ2Hw9RsKfx5Qangb59DnVuAV11
 zAMIqFns5gM4T+MdaxoO2/Rnn4t/h/wQqFEhdA7YsoddZd1Xzf7LgcW2AnfnZciZS5
 eyVtHFTEwY840ZFvHWxJAL51GKRl0w0lQEfHBAD0YrEmobgUYJXOzsGWi+elvJdYcf
 JX9JwWcg62veMTTzZDfpjyYsulAcijz4iy5+6+0TJOruQivVAEd4vNP1G+cMaEe3cR
 6XgqTrPhwl0Cw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jerome Forissier <jerome.forissier@arm.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, Martin
 Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2 01/11] test: Create a common file for image utilities
In-Reply-To: <20260523085455.750591-2-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-2-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:04:45 +0200
Message-ID: <87fr2xzcde.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> Move mkdir_cond(), copy_partition(), and make_extlinux_disk() to a
> common module which can be used by the rest of the image-creation code.
>
> Add myself as a maintainer for this new directory, and the test/py
> framework itself.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Rename the setup_extlinux_image() helper to make_extlinux_disk()
>
>  MAINTAINERS              |  5 +++
>  test/py/img/common.py    | 86 ++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py | 77 ++---------------------------------
>  3 files changed, 94 insertions(+), 74 deletions(-)
>  create mode 100644 test/py/img/common.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dcc7243124..d33ea42116c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1829,6 +1829,11 @@ M:	Liviu Dudau <liviu.dudau@foss.arm.com>
>  S:	Maintained
>  F:	drivers/video/tda19988.c
>  
> +TEST FRAMEWORK (PYTHON)
> +M:	Simon Glass <sjg@chromium.org>

Add a S: line here as well, otherwise get_maintainers.pl reports this as
"unknown"

$ ./scripts/get_maintainer.pl -f test/py
Simon Glass <sjg@chromium.org> (unknown:TEST FRAMEWORK (PYTHON),commit_signer:51/90=57%,authored:42/90=47%)

When S: line is present:
$ ./scripts/get_maintainer.pl -f test/py
Simon Glass <sjg@chromium.org> (maintainer:TEST FRAMEWORK (PYTHON),commit_signer:51/90=57%,authored:42/90=47%)

With the above change:
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> +F:	test/py
> +F:	test/py/img
> +
>  TI LP5562 LED DRIVER
>  M:	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>  S:	Supported
> diff --git a/test/py/img/common.py b/test/py/img/common.py
> new file mode 100644
> index 00000000000..301b6c840d4
> --- /dev/null
> +++ b/test/py/img/common.py
> @@ -0,0 +1,86 @@
