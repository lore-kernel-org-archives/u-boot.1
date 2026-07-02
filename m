Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF26BC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248A284C7B;
	Thu,  2 Jul 2026 11:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dVNRAMwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B973C84CA3; Thu,  2 Jul 2026 11:09:15 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A3384C5D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 11:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AB2560120;
 Thu,  2 Jul 2026 09:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700551F000E9;
 Thu,  2 Jul 2026 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782983351;
 bh=ArZdC9JNJSJ19ibNSzMmEhF917tibMjUBXrYSroUjk0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dVNRAMwgKe8KS05irJ9mYIXyIPMsQUv3N6nuqnG1dNuIInyVK0WMgtUtE8HuNzfL8
 xMfe6eLmReTVFKbK3Ccq7VUDEhRG6YOopbUGDAlW0SWFdhsKbFoD+VjpJ4rHzIjamZ
 uXIv/lTAGQ5tRC02EzPb4IZ3oY1MF7AGxI48N6pbvE7d0+DhZ3115s4SiHdZPpqrdw
 f/UrXp8YuSArLnl65GoL/biiscgG2iKPWes/XHWdKiUnbFReTpU5/EfmXB7cDYrc0I
 g63UdXORXQ/xWC/Lch8FiPxUHtzTjnb1Xz0Nbefl/9WBanW0fKdq5dFrq2BuJY7y8k
 Kv5OC0evc7XPA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Julien Masson
 <jmasson@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH] arm: dts: mediatek: add U-Boot dtsi overrides for Genio
 510 and Genio 700
In-Reply-To: <20260701-fix-genio-510-genio-700-dts-override-v1-1-cb571f8c9296@baylibre.com>
References: <20260701-fix-genio-510-genio-700-dts-override-v1-1-cb571f8c9296@baylibre.com>
Date: Thu, 02 Jul 2026 11:09:09 +0200
Message-ID: <87jyrd7o7e.fsf@kernel.org>
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

On Wed, Jul 01, 2026 at 17:05, Julien Stephan <jstephan@baylibre.com> wrote:

> U-Boot applies DTS overrides by searching for files in the following
> priority order [1]:
>
>   <orig_filename>-u-boot.dtsi
>   <CONFIG_SYS_SOC>-u-boot.dtsi
>   <CONFIG_SYS_CPU>-u-boot.dtsi
>   <CONFIG_SYS_VENDOR>-u-boot.dtsi
>   u-boot.dtsi
>
> For Genio 510 and Genio 700, the common mt8188-u-boot.dtsi override is
> never applied because none of the lookup paths resolve to it
> (CONFIG_SYS_SOC="mediatek", CONFIG_SYS_CPU="armv8",
> CONFIG_SYS_VENDOR="mediatek").
>
> Add board-specific overrides for mt8370-genio-510-evk and
> mt8390-genio-700-evk that include mt8188-u-boot.dtsi.
>
> While at it, also add mt8188-u-boot.dtsi into
> board/mediatek/MAINTAINERS.
>
> [1]: https://docs.u-boot.org/en/stable/develop/devicetree/control.html#adding-tweaks-for-u-boot
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

