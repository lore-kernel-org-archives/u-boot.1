Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F12C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 07:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2191786925;
	Tue,  5 Sep 2023 09:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693899559;
	bh=Mp09YqFcPgYK1b++/oUh0S8JVLsmrgbUOToo1ktyb4g=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ZacilkSfZ0I1uEkMKn931hpAUuFpYfdxRUEVkyF9SVYKHMZoROH/LE7lDKBqxSUxk
	 wU6cxnb+JFjYddMbBtKcSh3i7YbDCuTYKdk4NcqBC/bH4tP4DrY4qvXkHXPnlfurXy
	 I4mOeWBOjywtbI/d25ug9OYacn1DYSPpEc2sAQuaSj7YjVjO7fxqsq3qH+MfWTcCCg
	 8ljShCXme6TBPZWmuIbswTt748D1PyWVhYTUIEcpUlR+D7+4YzWa1ThxoreKuawtnU
	 g11iOiPxjDe6mx67Xj1sIkikY2Q/jQ1mpwLH1iFYuGG/34QdM0QFP6MGIJ0Dy1G/nK
	 dm+m0GqeT/s/g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4485886925; Tue,  5 Sep 2023 09:39:18 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C914586569
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 09:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Rfy7R4Gwgz1sBpn;
 Tue,  5 Sep 2023 09:39:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4Rfy7R48gJz1qqlY;
 Tue,  5 Sep 2023 09:39:15 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id m4lzkpMGDOJ4; Tue,  5 Sep 2023 09:39:14 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Tue,  5 Sep 2023 09:39:14 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1824873
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v2 1/5] imx8mm_evk_defconfig: Select CONFIG_IMX_TMU
In-reply-to: <20230823175911.319414-1-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230905073918.4485886925@phobos.denx.de>
Date: Tue,  5 Sep 2023 09:39:15 +0200 (CEST)
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
> Select the i.MX8MM thermal driver as it is useful for displaying
> the CPU temperature and its grading:
> CPU:   Commercial temperature grade (0C to 95C) at 38C
> It also prevents booting when the temperature is above the alert
> point.
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
