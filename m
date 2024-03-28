Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306FC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 14:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E97F88166;
	Thu, 28 Mar 2024 15:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="SOa7S9Ky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8762288150; Thu, 28 Mar 2024 14:44:42 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4819D87E9D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 14:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rpq3X-0007lw-KY; Thu, 28 Mar 2024 09:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=kn6BLOOit+S33lW4j+ZvdM4TiAcF7xspEcRqe96HfWs=; b=SOa7S9KyhsKnBHQKpKDC
 sI6zE06K92fOztOVqZgDOmjT7HdidMQ3KMPU7culJUsPj/leDZ9wkKv7+kzTyoKPzZOS/w3CPsAv2
 m8yaYaz0dgM0kg7DRVwgxV5jqZAnTxjoVgjl6yeZ+sckmIRm89zFRiLJQp8jbH3O7YQoXiunnh7vR
 ea5XNGn5fKR26bUp5Y81nEYhJSVF5Fw1pfrdm0/VPoKmlsE0lFKHU4t74vyVLmta33G7AyHZKuyyo
 s3A0rgxXG7EXR4iLLNstk+xTKB5smbM0mPTd0FF29x+UQTewnLaIA6Oj/D8p8O6afCdakKgNkEXfq
 0a97VCwdVdhrkw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 Stefano Babic
 <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>,  u-boot@lists.denx.de,  Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH v4 0/5] imx93: Conver to OF_UPSTREAM
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com> (Peng Fan's
 message of "Thu, 28 Mar 2024 13:05:44 +0800")
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
Date: Thu, 28 Mar 2024 14:43:50 +0100
Message-ID: <87r0fucvzd.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 28 Mar 2024 15:10:19 +0100
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


Hello,

>  Mathieu: please help test the boards you maintain when you have time.

I have tried both imx93_var_som and imx93-phyboard-segin
configurations. Compilation works but I only get garbage on the UART on
those two different boards.

I will try to conduct further investigations later on, but the booting
test is KO here.

Thanks,

Mathieu
