Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBAECDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED84786C2D;
	Mon, 16 Oct 2023 11:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448097;
	bh=ToFs8dLEa9qCTj7bpsDFVVhtg6sgY4pCRfzhZpZ1WV4=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FAbCkQm+aSky9fNAK225MA0yeoDGmvyNVz4POzaZXKH3cng4+2Slw4AP4DBdt24Dx
	 +5Ucge4g4e4TFk3Z6FAEXltQ++qAdmfEUFll4nQ2X9Qo5ifB3RojUAxI/JngzdKObH
	 RjCXDz7LGmfSu/zsj1azT7HeCiDv6IDM0UhTMTfnj2ESDpPvwGVm6Id7icQDzVAHgV
	 v1gVWQ42nCOX5qtMp0mt+LZPRVNfVrvN3e5e46t3HJ5frpQ4YDjeAdg+z0QdUW1swF
	 Wsl3iDUCwkaQLcZPX0HIDkZJ4rMyjvhO3ufnOrO67pk0p5B5T1MuDLs1DMWnvl4Uce
	 RXTbaw5jR5MNQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E626E86823; Mon, 16 Oct 2023 11:21:30 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8C686B71
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSP2XlPz1sCJ3;
 Mon, 16 Oct 2023 11:21:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSP1GFbz1qqlS;
 Mon, 16 Oct 2023 11:21:25 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 5V8dsbiChYhA; Mon, 16 Oct 2023 11:21:24 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:24 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1825579
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH v2 3/3] arm: dts: imx8mn: protect the firmware/optee node with
 ifdef
In-reply-to: <20230824190144.980883-3-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092130.E626E86823@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:28 +0200 (CEST)
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

> There is no need to include the firmware/optee node if the optee
> driver is not enabled.
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
