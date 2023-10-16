Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D74FCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090D086D65;
	Mon, 16 Oct 2023 23:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697491365;
	bh=HN6pcxmHjZsUHsrEvkOOmo5oK0yKAROOdxd+LB6w//Y=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=uyKmWsThTnY/qTerMhJmUGkFhnBScNnX8xXTd6nEdOdPGPXiD0F3P8UnN58cS40Q7
	 fzNd6erzeEp+RRP/KVvR70hcpZ2FuTRmKl7sqDVG/1t8TG8u+OThhfcE9f5LiOV2yZ
	 Y1GjweVB4M8ENJJof4cBelcVnnf2+gsyhV2h72aseivnecrHQYucKG2ZAlXqAyHWJu
	 /ncTfro0e1Mk/u3XWLSUc+ans1+28+ZRxbt/3PDYS7ZfMjoocUsIRgkHdwl3E8c5Ql
	 EH5O7kpC9I/zFZ2DZcMrhPUIjh4IkHsdUvJmtwlxYL81Tgkq0JpfGPxvNBGN5iehTX
	 /iQOMvaV2emMQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4744886D4A; Mon, 16 Oct 2023 23:22:14 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A908071F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8VS26rPRz1r1sC;
 Mon, 16 Oct 2023 23:22:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8VS26dhMz1qqlS;
 Mon, 16 Oct 2023 23:22:10 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id LELmC_gjJBWc; Mon, 16 Oct 2023 23:22:10 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 23:22:10 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1842980
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v2] pico-pi-imx7d: Unselect CONFIG_CONSOLE_MUX
In-reply-to: <20231004005831.2193997-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016212214.4744886D4A@phobos.denx.de>
Date: Mon, 16 Oct 2023 23:22:11 +0200 (CEST)
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

> From: Fabio Estevam <festevam@denx.de>
> Unselect CONFIG_CONSOLE_MUX to fix the following
> error for the input, output and error interfaces:
> U-Boot 2023.10 (Oct 03 2023 - 21:23:18 -0300)
> ...
> In:    No input devices available!
> Out:   No output devices available!
> Err:   No error devices available!
> Net:   eth0: ethernet@30be0000
> Hit any key to stop autoboot:  0 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
