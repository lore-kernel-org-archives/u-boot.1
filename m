Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4915CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF2586B79;
	Mon, 16 Oct 2023 11:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448084;
	bh=4n9yLnGFs95ZgXsbi57+6ohRoTYO1LSLyI21tqIPZXQ=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=gwvcHP2aIQyyW0RJSK1KTbF6GPK8x4CtmJWo7A1PFW9dgKikBW6N6oYVX/cDRBivf
	 w2BH2zJ+Y/6uGXDfiaQAt27hWHbmbSNog1JW05Y8hIeeuf75PxXrsehYZDmeWBQKz7
	 c2f6VqX0h7wUUpC/l0vaxXuFzanjQcaTIyUDSx8lDnI2XWmq3PI4/uxbH/p+9iqeaM
	 BTKP2dChstNVqRtRUyqo9hYy4aLHVZu7No9HYo/D0QTeDRGtDqLGWnC8Nd8y7yQXFr
	 xWYDPnqqSuXd5/T5h8sToWZJhC6bdAKTpBRdzkUyPrbWDVxqYSURq170ZwGL4MXigB
	 J028Dmfafr7UA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE9286B71; Mon, 16 Oct 2023 11:21:22 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756AE86C26
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSJ1KDVz1r2sg;
 Mon, 16 Oct 2023 11:21:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSJ12bDz1qqlS;
 Mon, 16 Oct 2023 11:21:20 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id mgoO_wqQmTjf; Mon, 16 Oct 2023 11:21:19 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:19 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Hiago De Franco <hiagofranco@gmail.com>
X-Patchwork-Id: 1829616
X-Patchwork-Delegate: sbabic@denx.de
To: Hiago De Franco <hiagofranco@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH] verdin-imx8mp: drop unused tdx easy installer ifdef
In-reply-to: <20230904132437.36435-1-hiagofranco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092122.7CE9286B71@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:20 +0200 (CEST)
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

> From: Hiago De Franco <hiago.franco@toradex.com>
> Drop unused code related to CONFIG_TDX_EASY_INSTALLER, that existed only on
> toradex downstream branch.
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
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
