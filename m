Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3029ECDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981478495B;
	Thu, 25 Jun 2026 19:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="NNMpCnxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E568460E; Thu, 25 Jun 2026 19:34:22 +0200 (CEST)
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6785B846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1782408858; x=1782668058;
 bh=C/dw3o5TOfrqUjORm4pJVo1I56yW3CstqJ/Bg+TBiD8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NNMpCnxwQ14HjofkzEPd/IQCdByvungGfpIUqNsuOkjT1NBXGVZd3onF60Q+tMYG7
 45RyVCfHndBc2XXhLACaTcSiHeM7QvWFouLz4rJgFhyZz32KCIbGPTWWEs5PKOOQTr
 E25aIAsD8YoW+sBkLzYIRyiJlS/z+Lgzj+pmMdSVLHqoHO/H9waJS8cQpnpWA9p+ep
 +dwYcTexiFZb6/QsVzSFBpw4Uj1/FYgDdzxFwEPakAleWHbfggYrjy/y1h/Yw3Mj2S
 9Lhur9XAue1IxkbsdQ2o8ln+EadtFymqN/NZAkwVRjgyIL++YgLoAkcpeoNtTVRf+J
 8oBSQdTy1+XOQ==
Date: Thu, 25 Jun 2026 17:34:14 +0000
To: Quentin Schulz <foss+uboot@0leil.net>
From: Ben Schneider <ben@bens.haus>
Cc: Stefan Roese <sr@denx.de>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] arm64: a37xx: pinctrl: fix info->dev used but never set
Message-ID: <TKQwiswJcpOqe-OzThAsw2nWaAh3uUi9otQ_MY_cPYZY4rxpTrIpDHKXQI2WEGiwz-lzHyBM8MChVHUMyRdt4wj1790ukQXB2nChSi31ris=@bens.haus>
In-Reply-To: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
References: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: e7a7aab907bc393cb63ce2ef120a7f691182a4c8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:16 +0200
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

On Thursday, June 25th, 2026 at 2:46 AM, Quentin Schulz <foss+uboot@0leil.n=
et> wrote:

> This was apparently tested by Ben[1]
>
> [1] https://lore.kernel.org/u-boot/kaJS2I2TlB5214mKzY5xXgpgeJRX1riXHuO0FS=
KHKdxcmBCJrnYmp7s-ebQd7mIbJBd1_yubQEd2bxBUMcUK02KgDudVPXcBIdlIZRMTxF8=3D@be=
ns.haus/

Confirming this change was

Tested-by: Ben Schneider <ben@bens.haus>

on an Armada 3720 (Globalscale ESPRESSObin Ultra) which crashes
on boot without this patch. A patched bootloader image for
this device can be found at https://github.com/bschnei/ebu-bootloader/relea=
ses/tag/2026.05.26.
Thanks!

Ben
