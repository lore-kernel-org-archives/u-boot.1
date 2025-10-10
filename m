Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC43CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79FC83F7B;
	Fri, 10 Oct 2025 16:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KM6BI/Jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DC883FCB; Fri, 10 Oct 2025 16:13:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE97083F4D
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DE0296265D;
 Fri, 10 Oct 2025 14:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40781C4CEF1;
 Fri, 10 Oct 2025 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760105584;
 bh=usiJxBzwOpjTGsYcLYbyCDjQOI/vkeNWkeqW2Ri3+MA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KM6BI/JwFu88kgIUtEJ2kjUXRCgn4kLzYg3gSwFqq7on2AJyX/sr5w2lVlE+S4gGm
 eO48Cl+gHtVbn/YF81l3eTsBPc6PA79sjKIqvLOTrPrbJxpyQt4x8ItWhljq13i+mz
 Wv5ynG/34AQZtYnyqjyHvff3CYXwocU82mmjH/OFx0ZO/27KcwfL0Yc+asLgQD1q/+
 8/CNQqZCZsxKzpYbXi7F659tqdCRVRBR7Qz7CscS+wX6JuhYyIPMuRHiYwhj6zdfAZ
 KmP2r4/HXE68zZymFb6OGwEvhY5WxXqGKMRTEeb/3rNR2pmuF5zPBdG+r1/X9m8UT7
 L1IdiTFufiiFw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jagan Teki
 <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: Re: [PATCH v2 01/18] MAINTAINERS: Add maintainer for extension
 board support
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-1-e09b39e54de5@bootlin.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-1-e09b39e54de5@bootlin.com>
Date: Fri, 10 Oct 2025 16:13:02 +0200
Message-ID: <87tt06vo9d.fsf@kernel.org>
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

Hi Kory,

Welcome to the MAINTAINERS file.

On Thu, Oct 09, 2025 at 16:50, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com> wrote:

> Add myself as maintainer for the extension board support that was
> originally added to track ongoing development and maintenance.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12043a1f82e..e411e266c94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1182,6 +1182,14 @@ F:	scripts/event_dump.py
>  F:	test/common/event.c
>  F:	test/py/tests/test_event_dump.py
>  
> +EXTENSION
> +M:	Kory Maincent <kory.maincent@bootlin.com>
> +S:	Maintained
> +F:	board/sunxi/chip.c
> +F:	board/ti/common/cape_detect.c
> +F:	cmd/extension_board.c
> +F:	include/extension_board.h
> +
>  FASTBOOT
>  M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
>  S:	Maintained
>
> -- 
> 2.43.0
