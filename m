Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784DED49C6F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 08:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F17D48420D;
	Fri, 30 Jan 2026 09:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h+QD4MNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEDF8429E; Fri, 30 Jan 2026 09:02:25 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240FB84206
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8109F41A72;
 Fri, 30 Jan 2026 08:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF97BC4CEF7;
 Fri, 30 Jan 2026 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769760136;
 bh=or/hFu8RftccAmgu1qchArzp2CC2zBpZqdarA9SiDF8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=h+QD4MNlc0E8A7K2arapcc4gPihPKTke5EeOkC1S7voHRFODC8dG9CvTxJxl0opMn
 VeGUwikmNfaPWdxtILifwrc2d8/K20BByMef7QUYHc+THXub/9aplEkKAQhwQdHrlA
 bt5H4cNBSCGoe21MpkPoYa6TW21N7pSolMUkUE37nq/hBTNa+lYTizUQwBwFXHwThN
 eTKiLg0LvASLjlLAXpAJOhSeG7TKwBOazYHRGVZXN50Ew2yHM68uMyO6aKI+GWnpGW
 D+CLlvLcQtKA1I9noOcworMaHo3h21iuCgjCK1/ftZK9goq7pzwqPIpS8HYzr7alD+
 gbG+gmrmNkFlg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260129195207.2260264-1-jonas@kwiboo.se>
References: <20260129195207.2260264-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2] usb: gadget: dwc2: Move dr_mode check from
 of_to_plat() to bind()
Message-Id: <176976013379.485994.8359705213936269649.b4-ty@kernel.org>
Date: Fri, 30 Jan 2026 09:02:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Thu, 29 Jan 2026 19:52:05 +0000, Jonas Karlman wrote:
> Rockchip RK3288 and RK3506 contain two DWC2 USB controllers, typically
> one controller use dr_mode=otg and the other one use dr_mode=host.
> 
> With USB_GADGET_DWC2_OTG, DM_USB_GADGET and USB_DWC2 enabled this result
> in the dwc2-udc-otg driver binding to both controllers, however only one
> will probe due to use of dr_mode=host on the other one.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: dwc2: Move dr_mode check from of_to_plat() to bind()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/e69841fa71d67c560d767b786f956bb6f2873130

--
Mattijs
