Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448FACCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CD1836A3;
	Fri, 24 Oct 2025 19:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="fFcuAh3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE4A836A3; Fri, 24 Oct 2025 18:32:51 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688DC82E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 18:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 081CC25D53;
 Fri, 24 Oct 2025 18:32:49 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_BKkOxbFgW9; Fri, 24 Oct 2025 18:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761323568; bh=oe7wMnbbrURWY/dtnCcxOhtJ/ZYkI0Ir8/SdHEyQUqc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fFcuAh3bcNDJyDd0za6RmFAJiFVI1oj4N091s+eqSb+fZBbSVUkh0oeVGibGxWb2V
 jftOHbTiXNgbWsdcoOyhVpAZGZcqUCtBSKNiymAZGf9fO1oeSu7BJeHwWzrcTYOrT/
 PWbq/qeqw/f85vgSJMGdmx1UCs8cX3A1UM2tWHCQAQi3Px4oi+Ac0MU+4kc/rLZCCV
 mhui98CB4HkStYVP43caz+QED8vu0oolT9q+D/sfqtouslJ3ZgOpDBg/r1Bw7GdfcA
 1PqkrlcvYFXA1NIkA0za8C9e3lMLdgHQsvkJywYSoT4hd3xljFNmLBgqr6bJ64FIMZ
 kqazuMf61Jpxg==
MIME-Version: 1.0
Date: Fri, 24 Oct 2025 16:32:47 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] mmc: exynos_dw_mmc: guard execute_tuning
In-Reply-To: <20251024104033.21653-1-peng.fan@oss.nxp.com>
References: <20251024104033.21653-1-peng.fan@oss.nxp.com>
Message-ID: <200583cb535bc28d1933c4eaab699d83@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 24 Oct 2025 19:37:56 +0200
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

On 2025-10-24 10:40, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Guard execute_tuning with MMC_SUPPORTS_TUNING, otherwise there will be
> build failure:
> drivers/mmc/exynos_dw_mmc.c:484:10: error: 'struct dm_mmc_ops' has no member
> named 'execute_tuning'
>          .execute_tuning = exynos_dwmmc_execute_tuning,
>           ^~~~~~~~~~~~~~
> 
> Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Kaustabh Chakraborty <kauschluss@disroot.org>
