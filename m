Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1388C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 18:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767F08490A;
	Sun, 12 Jul 2026 20:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="K4kYXNsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8505884A29; Sun, 12 Jul 2026 20:36:07 +0200 (CEST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6804984852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 20:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:6498:9c4a:923d:5bd7])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 300CD5FFAA;
 Sun, 12 Jul 2026 20:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783881365;
 bh=gtXP5Fhrutv7iG7SojMlR40B3orBcatVRETBt291BaU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K4kYXNsHpl1NOQn/s5wbW+3HM6/TBgWXbT2bMPcsbfQzbUrPyhYtXGHH5d22oCWGe
 YZnoTs9MSEVRHcMZNNZq/PmfX/jCobbIDUPTQ48dV43aGyCIFqsAaUNQ0d6OI0h4U8
 GYR2Zyp7qxc4tDO5IrxY0wt8hR0TC7PMcMh+Ud74ON9t/RCkLgvRzJq87P/Y0rnoS2
 wthcmzg3lHvTv5aBklp4Jh+F79zfDlpWtZSmB7Y54vuC+LCkGbRlElKscCFvuCkNh+
 3ThDotkc02dG1Gv+uGsBP4u5yECp54SM/gnDqkSZiO6hiSayIUYXFWMmD1Gz1p2RKo
 EyZTRNoStxGYA==
Date: Sun, 12 Jul 2026 20:35:54 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alice Guo <alice.guo@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH v4 0/7] pmbus: PMBus 1.x framework, CLI, regulator and
 thermal support
Message-ID: <alPeioT2T4LF0M5t@L30177.local>
References: <20260710201631.2469728-1-vjardin@free.fr>
 <alNOwfA-Jqqfuv5y@nxa18884-linux-1.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alNOwfA-Jqqfuv5y@nxa18884-linux-1.ap.freescale.net>
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

Hi Peng,

> +board/nxp/ls1088a/ls1088a.c:703:43: error: 'PMBUS_CMD_VOUT_COMMAND' undeclared (first use in this function)
> +  703 |         u8 buff[5] = {0x04, PWM_CHANNEL0, PMBUS_CMD_VOUT_COMMAND,
 
> Please run a CI build next build.

Thanks !, I did miss it, fixed for the v5 serie::
  https://lists.denx.de/pipermail/u-boot/2026-July/624774.html

Best regards,
  Vincent
