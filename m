Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4077CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4F284975;
	Wed, 10 Jun 2026 14:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ykaNGdR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FCC84979; Wed, 10 Jun 2026 14:21:52 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3491384971
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gb4dm3cMFz9tsw;
 Wed, 10 Jun 2026 14:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhbZ2eim0515QXC/4GobY51ja4/HU3hf2YnTigxISsk=;
 b=ykaNGdR6eH1+IrFXhyen8Ur0I2QdBBOJyYXjd3NfgehtF04yWaJrPrIpYc3PcwlO3C6n/s
 7V1yTL7g7FCr0JjZuVxSl3+KxiPAnUgTzMq1LQrMnoC6xPpoSICUFmQsnk2Gx2C3qRR0Rt
 Vm7XEIdCthFcTlLfrH1IGDT2hrZWwed91gwJtFlBmjbwK3VNYcRVaOmAqZVptHEcC7hx1K
 dDlfETp8RlBpEQvoc4SgY6GvQZfzytJh3IUj2r0eZfP/xFrlosjYPcUmZhZ3iPDnPkLg2s
 J8uY3GH1n82L45Bx4Zd3uy2jVb+mxgNvPt9UCG6jMriQAxl7JAfXa3E/EcG12Q==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Vincent Jardin <vjardin@free.fr>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 2/5] board: freebox: add Nodebox 10G board support
Date: Wed, 10 Jun 2026 14:21:28 +0200
Message-ID: <20260610122132.2674311-12-stefan.roese@mailbox.org>
In-Reply-To: <f1dcac4aecffc144ef4ba49c8ba6e9de57599221.1778247592.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
 <f1dcac4aecffc144ef4ba49c8ba6e9de57599221.1778247592.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 043f903928335e7de04
X-MBO-RS-META: pg3k3wabmy9q97xqpqkhduqa9xbyzexf
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

On 5/8/26 15:54, Vincent Jardin wrote:

> Add board support for the Freebox Nodebox 10G based on the Marvell
> Armada 8040 SoC. This board features:
>
> - Quad-core ARMv8 AP806 with dual CP110 companions
> - eMMC storage via Xenon SDHCI controller
> - 1G SGMII Ethernet on CP0 lane 5
> - I2C buses for peripheral access
> - NS16550 UART console at 115200 baud
>
> The implementation includes:
> - Device tree for the Nodebox 10G hardware
> - Dedicated board directory (board/freebox/nbx10g/)
> - Board-specific Kconfig and defconfig
>
> The U-Boot comphy bindings (phy-type/phy-speed) differ from the
> mainline Linux PHY framework bindings used by phy-mvebu-cp110-comphy,
> so U-Boot and the kernel each have their own device tree.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
