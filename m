Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA55CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C81086BF7;
	Mon, 16 Oct 2023 23:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697491332;
	bh=uhc12R5Qq911/ZOwdWCkV5VfJls3NyujDtO8VuWjl8k=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=j8VFMRQNNu+FgeMXHmGPQMqaZMJvYdmMWbmlQ5Mi7gx9LyyTf+w68rsGWScVuCFQv
	 Kyv4CbXK1UkDV6uLAxb3Ch1ocUfCFS572UO1KM3C1U+KhdV3N+2kf+z7WU//V0zDiV
	 NRAImiQQ95YQn81gk1chMfywYGMo7Pe0EE+dxXYffkHzkSqODTdOVgl2fDLiLULUmk
	 /6IEEHCoWFujn/BIKDp7zfb6pWfAVMniw7DipatPVRsjSFWlh51xynz6HXki4CoRfI
	 9ctNMVEGPqKBlamvb2E+LO5G5SyyhQAmllz3tPpnuR+BkVYFsGTi50d79UqUkZwgVd
	 a6W46LjZSTIjg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA31C8071F; Mon, 16 Oct 2023 23:22:08 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5ABA86B81
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8VRv393pz1sCHM;
 Mon, 16 Oct 2023 23:22:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8VRv2syzz1qqlS;
 Mon, 16 Oct 2023 23:22:03 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id ljUgYWYCftKx; Mon, 16 Oct 2023 23:22:02 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 23:22:02 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1849065
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v4] imx8mp-evk: Add USB0 OTG support
In-reply-to: <20231016002437.641898-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016212209.AA31C8071F@phobos.denx.de>
Date: Mon, 16 Oct 2023 23:22:03 +0200 (CEST)
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
> Add USB0 OTG support.
> Currently, the USB0 OTG nodes are not enabled in the Linux kernel
> devicetree.
> For this reason, enable the USB0 OTG nodes inside imx8mp-evk-u-boot.dtsi
> for now.
> Also select several useful options such as USB gadget and fastboot.
> Tested by running "ums 0 mmc 2".
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
