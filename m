Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6E5C7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 07:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C3D82C4C;
	Tue, 24 Jun 2025 09:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="k6HS/iVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E38D82C84; Tue, 24 Jun 2025 09:21:06 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3524C82C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 09:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id DB10C1FE5C;
 Tue, 24 Jun 2025 09:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1750749662;
 bh=hK5dqYw1D4gY0et7QDkCcAhpU/u0hmQbw25gSp8ED5c=; h=From:To:Subject;
 b=k6HS/iVKfE5+Wqx+xspxL+LJTIadPfuGJ71LH07fiL29IuSyLGfCmelMQf798zh8e
 Zo8yLq48poDD7ELeTTyjaxmvU93eC2GvI1dYd6yVfbMAHkiU4o5wmtX+7sFnokxqPP
 kFLQTbcXXjAbxHYxcJQvKxp8MB2cPVSyDUyiRzlfFAMEojrkW5OUwr/3Wd4lBlQQoU
 +2cWt6PbJ+HwEg7uB9YfAOUemQ+SBt2mu8cqygi6dsEtllf2k3A7Ywr0fm8cjRr45I
 k3bQpGtfABT1KZkLp6DAcg6ve5jCcNJ5kTM6U2zCcagokOYwib8JluNaXGDtHC6r4t
 Wdd9gvrSjL0aw==
Date: Tue, 24 Jun 2025 09:20:57 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH 4/4] board: toradex: verdin-am62p: Add fixup for critical
 trip points
Message-ID: <20250624072057.GA13035@francesco-nb>
References: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
 <20250623-am62p-fdt-fixup-trip-points-v1-4-12355eb6a72f@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623-am62p-fdt-fixup-trip-points-v1-4-12355eb6a72f@toradex.com>
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

On Mon, Jun 23, 2025 at 02:39:57PM -0300, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> While TI AM62P supports up to 125°C junction temperature, Tj, for
> industrial and automotive parts, Toradex Verdin-AM62P hardware lifetime
> guarantees consider a 105°C Tj. Fixup the device tree temperature
> critical trip points to match the hardware specifications. The
> implementation ensures the architecture code will not overwrite the
> board specific changes by enabling CONFIG_OF_BOARD_SETUP_EXTENDED for
> the Verdin-AM62P.
> 
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

