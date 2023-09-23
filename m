Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E48CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE77886B37;
	Sat, 23 Sep 2023 20:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695495128;
	bh=vkG0uqt3x7LXMD8gwYgBs3DDE/NRhjTHp5blSJiqRSk=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=kTXdoKd3Wz+FlIAusHjPEU5vo7KTmbtrJxbSSLJjESd/K27eADwqIKAJW1OUH1dOS
	 NeUtnrPT3Qv6ON5tAK+UoDsg3YHPOuN4flgL9uwhf89k/sY4xZs4cISMeZcLH8SKiS
	 tiglg1yyVGFbvU77/gJxADQ+csiXCmeGLedqtGCyKujZESraSdOYsY9zUav5OdhTiU
	 uGqa+J1RrG1rg/YsEquOB7zButsg++d6ACKI5Vji+FWuSa64s4QXpagULvUtJCtIED
	 Nv3xrETXqtyIBL313UyOhm0CbVvrlJbLzuUOZC/8jD207ELcSdgdvoHGgr5D2c4aVW
	 GiTK09CWkJW3Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE32E86199; Sat, 23 Sep 2023 20:52:02 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23511869B6
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RtJCN6LlTz1sBqx;
 Sat, 23 Sep 2023 20:52:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RtJCN6CWnz1qqlS;
 Sat, 23 Sep 2023 20:52:00 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id sRyjErIi5BoF; Sat, 23 Sep 2023 20:52:00 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Sat, 23 Sep 2023 20:52:00 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1837174
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH] smegw01: Use CONFIG_SYS_LOAD_ADDR for loading fitImage
In-reply-to: <20230920104908.4117686-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230923185202.DE32E86199@phobos.denx.de>
Date: Sat, 23 Sep 2023 20:52:01 +0200 (CEST)
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

> From: Eduard Strehlau <eduard@lionizers.com>
> Set CONFIG_SYS_LOAD_ADDR=0x88000000 and use this address for
> loading fitImage.
> Also pass the standard CONFIG_BOOTFILE option to indicate
> the fitImage file.
> Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
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
