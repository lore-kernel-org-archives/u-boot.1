Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73995CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4FF86C3F;
	Mon, 16 Oct 2023 11:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448160;
	bh=Wk9y+2bVomW2Twt+fuzO6znjHyjVDnESRNd2ZUmBJ5o=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=gkYOmVp9iy5xIID0AnDLs23SHp4KeRD58aY04b3qRiPlE4Ze5N89I9+0/SQz/Nz1a
	 ydnl/dKQChsvF0sZZKVag7jxYIyIYvKQgMDJ/Z0staDrO4tl79BVMgSN1GKzR0DXGU
	 +XaWgq5OXvmclekUoHR88Tchw9KzvIff8Uf+U1J1iLRi1NdUUPruEFnZmMty3wEppN
	 0dvPnXDbWik0s7pEpaWTzxCUl8OEXtooQot9pjvtyvEwnZwWDNc4+Jq1Ix1Ml3YRCc
	 LsYYGpXSixFk53qJE/8uGZpxWCC5xw8CYPyZHsmYwZ42SzUdp42BNGttMuC3X1pQdi
	 WMOgJ7IBtdngA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5033D86C3E; Mon, 16 Oct 2023 11:21:53 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DB286CDB
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BSl6hBrz1sClY;
 Mon, 16 Oct 2023 11:21:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BSl6YKTz1qqlS;
 Mon, 16 Oct 2023 11:21:43 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id bFdw0jT-zKnz; Mon, 16 Oct 2023 11:21:43 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:43 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Tim Harvey <tharvey@gateworks.com>
X-Patchwork-Id: 1821585
X-Patchwork-Delegate: sbabic@denx.de
To: Tim Harvey <tharvey@gateworks.com>,u-boot@lists.denx.de
Subject: [PATCH 6/6] board: gateworks: venice: updates for
 imx8mp-venice-gw74xx revB PCB
In-reply-to: <20230815220115.2000851-6-tharvey@gateworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092153.5033D86C3E@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:21:51 +0200 (CEST)
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

> Update the imx8mp-venice-gw74xx for revB:
>  - add CAN1
>  - add TIS-TPM on SPI2
>  - add FAN controller
>  - fix PMIC I2C bus (revA PMIC I2C was non-functional so no need for
>    backward compatible option)
>  - M2 socket GPIO's moved
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
