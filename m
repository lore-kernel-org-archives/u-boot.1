Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B8E7314E
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 09:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B0883DCA;
	Mon,  2 Feb 2026 10:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UweQCnPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C9683DDD; Mon,  2 Feb 2026 10:27:22 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3EC83DA7
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 10:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A73AB600C3;
 Mon,  2 Feb 2026 09:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4F6C116D0;
 Mon,  2 Feb 2026 09:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770024438;
 bh=EkeMFWJOnFjOtbNOrSVSrGVPkw+8gkzJHqmc9jQ/8po=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UweQCnPQ9WdgXMKo5q/tdS7OMF3epG40CxG63E5O42FAMmh4xAEmFQlbMwAnTOeHs
 ZHjoMuA4y5abQuiN9flkPW1Vx/pbgDXzWhkLdOyRIHm1PxZMI4ZScrUeJfGvKlpC/J
 3QBF1jU9Gq64VWCW9w/bGHDYGE8LNjcD2iQbRDqN2QpZX4jbO2iYjEF+oRbMzBRLhQ
 2+t58Xa9fVhhEjVdIBQZlXC0u7qHVdPXa7d2gGG4aiM5iI1Yuv+XK9DaJ59CaqjXDL
 RHOeD2BHNA2CW2Ldd10zOEDTDTrbSiVALmQva6gM6oU90kzMXt1K1sKFsj9wkCczCA
 SmMZziWSkE3ew==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Julien
 Masson <jmasson@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, Tom Rini
 <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v2] board: mediatek: add MT8390 EVK board support
In-Reply-To: <20260202-add-genio-700-board-v2-1-06d375b877e7@baylibre.com>
References: <20260202-add-genio-700-board-v2-1-06d375b877e7@baylibre.com>
Date: Mon, 02 Feb 2026 10:27:16 +0100
Message-ID: <871pj3mr63.fsf@kernel.org>
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

Hi Julien,

Thank you for the patch.

On Mon, Feb 02, 2026 at 09:23, Julien Stephan <jstephan@baylibre.com> wrote:

> From: Julien Masson <jmasson@baylibre.com>
>
> This adds support for the MT8390 EVK board with the following
> features enabled/tested: Boot, UART, Watchdog and MMC.
>
> MT8390 is based on MT8188.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - Add Macpaul Lin from Mediatek as co-maintainer
> - Rebased on master
> - Removed series dependency, as the pinctrl series for MT8188 was
>   applied on master
> - Link to v1: https://lore.kernel.org/r/20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com
> ---
>  board/mediatek/mt8390_evk/MAINTAINERS  |  6 ++++++
>  board/mediatek/mt8390_evk/Makefile     |  3 +++
>  board/mediatek/mt8390_evk/mt8390_evk.c | 34 ++++++++++++++++++++++++++++++++++
>  configs/mt8390_evk_defconfig           | 27 +++++++++++++++++++++++++++
>  4 files changed, 70 insertions(+)
>
