Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CE7C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 20:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1BE82161;
	Tue,  8 Apr 2025 22:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dsn8dC6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1A3822D7; Tue,  8 Apr 2025 22:23:00 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276158213E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 22:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id D08091F9EA;
 Tue,  8 Apr 2025 22:22:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1744143777;
 bh=WY3Vl8VoDfq14PzHzwv4Wh82RmxhAKPAOSeM00t4RX4=; h=From:To:Subject;
 b=dsn8dC6zsLTWy/ikXN8LgWi3Culeb5PhHvipLMYFTCobKPQxwNkvPXu93TgR/LAyi
 gqpKY9Oc7W8kYfu1z8Wb+2IsEY4X+eTDOPk0dkUGyvIuM3lNvEnZyF8iTsBZ7XieSY
 mzeoDWlFVU/IxS/Xjs1UN9FFPVEGbAffE/oxg1UyHHE8zRF+h74Bi+I+2fYFFolb3c
 SmUtwYqnCuNV8yQUvvpXMne/n/TxAte/cNVrnOk0YKYjrOg0o19AVkJ8hDstOaQLMl
 QvMPHChgn+76YXCKO/3Muws/z8tZUYkGAqztaBbLhd0wHJevhb/vn5zmRET8I1PK9O
 7/t6DBwvZsOJg==
Date: Tue, 8 Apr 2025 22:22:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/3] Add support for Toradex SMARC i.MX8MP
Message-ID: <20250408202252.GA5336@francesco-nb>
References: <20250407130436.223645-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407130436.223645-1-ivitro@gmail.com>
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

On Mon, Apr 07, 2025 at 02:04:33PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> This series adds support for the new Toradex SMARC i.MX8MP
> System-on-Module (SoM), along with necessary
> updates to Toradex config block and device tree synchronization.

...

> Vitor Soares (3):
>   arm: dts: imx8mp: sync with Linux v6.15-rc1
>   toradex: tdx-cfg-block: add 0096 Toradex SMARC iMX95
>   board: toradex: add Toradex SMARC iMX8MP

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

