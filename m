Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFA8C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2CF87FC9;
	Fri, 15 Mar 2024 16:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="lX50KnYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118548800F; Fri, 15 Mar 2024 16:36:15 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3614B87FC9
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 004961FA91;
 Fri, 15 Mar 2024 16:36:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1710516972;
 bh=MtH2ATihL2ZBruf62lOzSLERbA7zQEmmy4DGdTyUwgo=; h=From:To:Subject;
 b=lX50KnYQcraDAuAdUxA7Gwq9NXFr+oWQ2buZpGEyM8bPg+qegTZrgYAG+a2JXpA1a
 iZNDwLcy1+Et1g2OihzlIVjfq/xqFVliuqed/m2lrKhDTh8raaVoO/wh7/U3v/zB6Q
 WQUP4aoIdaoyaX5p84+Zx2421s8lz3zPulO7Zu6aOZGJ+SQf0zU2cK1PGOII1UgUBC
 Xgld3mTHbhxfMnFRCitF7BmGfhmI5k5vHPmVR0nMSWRfF5wIe3iRLFgJlH5E0Z+enT
 qtJF1GNG+nuk5zYZxGrH4iWlsT/gcXo3AoQMojCgnfC9UB2MwAfKLc9i2Y6+Q4Jlhm
 eS3H9Y2+aC5cw==
Date: Fri, 15 Mar 2024 16:36:10 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: imx: imx8m: soc: Fix NPU/VPU fdt disable fixup
Message-ID: <20240315153610.GB4032@francesco-nb>
References: <20240315144426.38560-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315144426.38560-1-ivitro@gmail.com>
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

On Fri, Mar 15, 2024 at 02:44:25PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> On imx8m[m|p|q].dtsi, upstream Linux uses different names for NPU/VPU
> IP block nodes. It leads variants without such HW block having it
> enabled by default.
> 
> This patch adds the upstream Linux node's paths to the disable list while
> keep the compatibility with downstream Linux.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

