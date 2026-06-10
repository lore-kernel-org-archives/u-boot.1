Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6DDCD98C6
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 06:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65A780087;
	Wed, 10 Jun 2026 08:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V26Dkh8e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746CB839A8; Wed, 10 Jun 2026 08:00:44 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170B180086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 08:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9E9FF4E42DF4;
 Wed, 10 Jun 2026 06:00:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5B8085FFC9;
 Wed, 10 Jun 2026 06:00:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 931C1106B87F8; 
 Wed, 10 Jun 2026 08:00:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781071240; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bK0tueFMsToUoSQsq5z6stGiUsPGSzAi+o9bcZk5bTg=;
 b=V26Dkh8evTmJhf/5Wl15sVB7gIMMhIZhUn5SqaHU1ldt0qogQHzrg5xInfXMuWzGpZ+zZf
 K3v8nZZef60JJWcL/hA3pAsl3ZddenxsX5onZecySPsww/qQeOBJyZFh5Ez+wtx1hlzBsx
 eAOyk3fVcvgUEHNeNTULG6pXyBds8m0pUkoLNXuOFe6N+POTd3rhu0PqKIdRPqRSGjBc6P
 qYGyb03uQjgSINdkPkvyGRnZ7PRx1Hs2JHPQ8e0obUCVG3w51mgBrzOLcm9zABMxEStbjU
 hTfJE/yPSIGqfwYochtd5c8XXQa/dcBinO0hnZpEVZy8B+ZV5QlWHwd62A4h1Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 08:00:38 +0200
Message-Id: <DJ552789PUMR.15DO58AA762ZG@bootlin.com>
Subject: Re: [PATCH] imx93_frdm: Add support for 2CS 2GB DRAM support
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, <u-boot@lists.denx.de>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Fabio Estevam"
 <festevam@gmail.com>, "Stefano Babic" <sbabic@nabladev.com>, "Tom Rini"
 <trini@konsulko.com>, "Alice Guo" <alice.guo@nxp.com>, "Peng Fan"
 <peng.fan@nxp.com>, "Tom Zheng" <haidong.zheng@nxp.com>, "Joseph Guo"
 <qijian.guo@nxp.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Peng Fan" <peng.fan@oss.nxp.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609-mathieu-ram-v1-1-72c18e8f24d9@bootlin.com>
 <aifytOZZxdUdHpnh@shlinux89>
In-Reply-To: <aifytOZZxdUdHpnh@shlinux89>
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue Jun 9, 2026 at 1:02 PM CEST, Peng Fan wrote:
> On Tue, Jun 09, 2026 at 09:47:32AM +0200, Mathieu Dubois-Briand wrote:
>>Import 2CS 2GB DRAM configuration from Tom Zheng commit in NXP u-boot
>>git. Revision B2 of the i.MX93 FRDM board is using this configuration.
>>
>>Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>>---
>>This is mostly an import of Tom Zheng work.
>>https://github.com/nxp-imx/uboot-imx/commit/4c35a6086aed
>
> Better place this link in commit message otherwise it is vague that
> commit/branch/repo. Then
>

It makes sense. I will wait a few days for other comments and send a new
version with modified message.

> Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

