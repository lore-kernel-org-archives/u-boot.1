Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592FD358F1
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F46083CBD;
	Thu, 29 Jan 2026 11:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C04Qa+fE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708C783E69; Thu, 29 Jan 2026 11:17:49 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1807383C8C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8043D41895;
 Thu, 29 Jan 2026 10:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1914C116D0;
 Thu, 29 Jan 2026 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769681865;
 bh=nU32ti1/40TzZb5ZIkqfX3qsxtga1TGutbw74KFOkrY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=C04Qa+fEELYflpyN97mc/o93GNIIHgBQoKMKhyDimkhnQsDKZVF0gm9K7oVjYqMu5
 bR561KVPXmg/qGHVaaZz++xZX4LIqmIgu+zfddbAgbFSge2Zr5PYLPxkE9xSUqxqX8
 FfXgcMAQLZb4Oo3SB0VTRF1f4D+88X8oK78w9vi6ftJXE9WYBhJ3GcUMs1di9yoFjD
 lz89gbiJnPoJDHELeNbIZWEwTC3SpjEyJ96nSS+kx/WQvUYH2hKjLvBI2hxfXn9Pe1
 ovfnbKUY5Qk2I8B3LlV8+E+6GY/Wuchw8dVrYAnI39rc8EpAbMuFEWsDH+SiZf44Rr
 zreh9DaQM4atA==
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
Subject: Re: [PATCH] board: mediatek: add MT8390 EVK board support
In-Reply-To: <20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com>
References: <20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com>
Date: Thu, 29 Jan 2026 11:17:42 +0100
Message-ID: <87343ooh89.fsf@kernel.org>
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

On Fri, Jan 23, 2026 at 09:37, Julien Stephan <jstephan@baylibre.com> wrote:

> From: Julien Masson <jmasson@baylibre.com>
>
> This adds support for the MT8390 EVK board with the following
> features enabled/tested: Boot, UART, Watchdog and MMC.
>
> MT8390 is based on MT8188.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  board/mediatek/mt8390_evk/MAINTAINERS  |  5 +++++
>  board/mediatek/mt8390_evk/Makefile     |  3 +++
>  board/mediatek/mt8390_evk/mt8390_evk.c | 34 ++++++++++++++++++++++++++++++++++
>  configs/mt8390_evk_defconfig           | 27 +++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+)
>
> diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt8390_evk/MAINTAINERS
> new file mode 100644
> index 00000000000..73fc28b096e
> --- /dev/null
> +++ b/board/mediatek/mt8390_evk/MAINTAINERS
> @@ -0,0 +1,5 @@
> +MT8390 EVK
> +M:	Julien Masson <jmasson@baylibre.com>

Since Julien Masson is marked as maintainer here, can we guarantee he
will be doing some testing/reviewing on patches for this particular
board?

If not, maybe find another maintainer.

> +S:	Maintained
> +F:	board/mediatek/mt8390_evk/
> +F:	configs/mt8390_evk_defconfig

Could we add this board to the MediaTek board documentation?

https://docs.u-boot.org/en/latest/board/mediatek/index.html

I know that doc is a bit outdated but it would be nice to improve it and
list this board.

For me, that can be done in a future series/improvement.

Thanks
Mattijs

