Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A0CFD317
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 09:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB9083BF1;
	Mon, 24 Nov 2025 10:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jauLzbxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCAE83D2E; Mon, 24 Nov 2025 10:52:57 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A0883BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 10:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 16F2D60138;
 Mon, 24 Nov 2025 09:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486DDC116D0;
 Mon, 24 Nov 2025 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763977957;
 bh=vF0I/Jb+ERdEqHI+svPM3bxloKP7T+D1ODidl3edXD4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jauLzbxVCrj7NxUZEVEl2FavBdoqv3otxJ5yRI+0gmLlYSsEuffzlHQx7dsQw4/yM
 45c3ivEmLrKDh/tmU0+4i0fO1FYcNopjNgYobX7fwMcpj/B7gcYVVxQLirQMsdMIKB
 hiQJhrBE3jR9Cy6AWj8E3Y+Wg5USaNlOZHLTyx9pLg4h8fIMmaY6fw4D3jf2dxXk+8
 eo1sxu9bCW0hYHG90lR1bbMc7ZQDN6D/uvlGHTu882SOXv8CF7ahUhj56iDprlDDH3
 OWUt1ULZnCal02o4PmGn6WEoPWSv2whP846KQYKpFzWiWfZkPxCuaAwyht81jbYem/
 DZdKwpwcRHhXg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
References: <20251121-topic-fastboot-blk-v7-0-9589d902fc91@linaro.org>
Subject: Re: [PATCH RFT v7 0/3] fastboot: add support for generic block
 flashing
Message-Id: <176397795481.56737.4917347593175524070.b4-ty@kernel.org>
Date: Mon, 24 Nov 2025 10:52:34 +0100
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

On Fri, 21 Nov 2025 11:53:30 +0100, Neil Armstrong wrote:
> This serie permits using any block device as target
> for fastboot by moving the generic block logic into
> a common set of helpers and also use them as generic
> backend.
> 
> The erase logic has been extended to support software
> erase since only 2 block drivers exposes the erase
> operation.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/3] fastboot: blk: introduce fastboot block flashing support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4bf92b541af628d899ea1dadf9147baa3482967a
[2/3] fastboot: blk: switch emmc to use the block helpers
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b63e85705d2c25a46b38db891a7957b5c6b8d263
[3/3] fastboot: integrate block flashing back-end
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/769c6cbbb53074025c3af53d8df5571ae18d74c3

--
Mattijs
