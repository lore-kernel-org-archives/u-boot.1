Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDADCD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A31846CF;
	Tue, 16 Jun 2026 11:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eg0+mosA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D528484C; Tue, 16 Jun 2026 11:05:38 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A122846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D41B941B46;
 Tue, 16 Jun 2026 09:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143191F000E9;
 Tue, 16 Jun 2026 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781600734;
 bh=edUF+QOx/TeDzhQfVkcu8QfKrv325W2TYw+WZv4s3mI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=eg0+mosAF0+4P4rOhY+64iGtiFYdi9BbjtZGINUAmLPzBkSQmU18DZ590h5jmQJQ9
 3OawlpyKeIoPPqLIpOTc6W/rdLv+drym1Lj4Ej2D28Yrc2+ArQO0MH3hCspQi8gsPi
 Y7OvmfGg9XydStE2kT1jomFsCGaOEcn0ueerBZ2gnB3JStTK8O8yRQ9VEYXZBWafbV
 Qu397SQHGw1VlbUV/KsJycnqcKd/63ehk/0LpRBj8r5ybU62Mxv4obO6JDp1Lifbh1
 r+lcI5cxWduTUno6io4KVpdWncHUOz0UTo3z4wrvPjb2cwwdOb+LbvAt2x3sc3Difs
 W/C6ASZ6aZI6g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ye Li <ye.li@nxp.com>, lukma@denx.de, mkorpershoek@kernel.org,
 u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com,
 ye.li@oss.nxp.com, xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: Re: [PATCH 1/3] usb: ci_udc: set correct ep type in ep_enable()
In-Reply-To: <20260522075512.1291485-1-ye.li@nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
Date: Tue, 16 Jun 2026 11:05:32 +0200
Message-ID: <87ldcehn37.fsf@kernel.org>
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

Hi Ye,

Thank you for the patch.

On Fri, May 22, 2026 at 15:55, Ye Li <ye.li@nxp.com> wrote:

> From: Xu Yang <xu.yang_2@nxp.com>
>
> The Endpoint Type in ENDPTCTRL register should be correctly set
> according to endpoint descriptor, not fixed to bulk. Otherwise,
> unexpected behaviors may happen.
>
> Fixes: 26cc5129ee64 ("USB: gadaget: add Marvell controller support")
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
