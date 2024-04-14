Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2744C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 15:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E749087F0E;
	Sun, 14 Apr 2024 17:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="PGdaHKK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55B3880A7; Sun, 14 Apr 2024 16:33:12 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D236A88049
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 16:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rw0uq-0005Vk-JA; Sun, 14 Apr 2024 10:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=rPUEDlN8rfjY2k/ENqX+QbJik3+D1oDymhZINsOfGGc=; b=PGdaHKK0AY9fApmXYZeN
 lww/26y7ttJSVnRovJSe93d5mPRsDJUVOv4K3nr/9pLWSf8KyTKbDAHo7mFF/lmc0GeGysNtjfxIA
 p3LYbC0wzxebA6Mq9JkOma2V1dPBpxVj9cMMif2mG+4dZnLZKVrKCF1HbTLNt15GDI8c40qep8ETg
 86FOTpjTf+yOz/Et59nmNyCQ+URDk90Wff4kdjJnxOAHv3D5rN4mnfBP9yhV6UONdlMrX4I0r7IJw
 DjloMyBH5oOFA3ByBtYhlFGIQH35Fq+JdNerkWDeVFxirRr5KUFiwlcHycQ1RKX0wZ7finiF9JrcD
 pRXTU+6tjHypZg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,  Stefano Babic
 <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  dl-uboot-imx
 <uboot-imx@nxp.com>,  "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 5/5] imx93: convert to OF_UPSTREAM
In-Reply-To: <DU0PR04MB9417A38FD214BC4A20AB82C3880A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 (Peng Fan's message of "Sun, 14 Apr 2024 12:47:41 +0000")
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <20240412-imx93-of-v2-v6-5-c2ad48e46eca@nxp.com>
 <87il0k2qia.fsf@gnu.org>
 <DU0PR04MB9417A38FD214BC4A20AB82C3880A2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Date: Sun, 14 Apr 2024 16:33:05 +0200
Message-ID: <87cyqs815q.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 14 Apr 2024 17:38:50 +0200
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

> Which dts upstream tag are u using?

You will find it in my previous email.

The command I use is:
./dts/update-dts-subtree.sh pull 2639a0e2fdbdb7f2dd351d06afe54c895adf9d9d

> Do you have time to debug the issue? I not have the board, so not sure what
> happens here.

Not at the moment sorry.

Mathieu
