Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB28EC83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 07:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDC3868BC;
	Tue,  5 Sep 2023 09:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693899544;
	bh=PZDL/kzW8/XKpLnA5sodognVNV5wiB0RYEIEO00W+Pw=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=jWS4CKezaOndfBdhFpOh5QTAJ84rjTMjArEJcFzbA4zHQfoWDXNDDbY12uJBaNIgq
	 ZwqXLxPP8MD2dIYmrkD88oh8SIV8Tpa8JWR3B+JMJkE9nIsYWMJZAo9CtuNHVjrB08
	 BotiRcUD43h6IE0NWFJkT0dd3jcMGftcZ3Vajs2NmYvhD8a9xJNU1lngza/vLjJBxG
	 S9Vn1LUFW3qhQ73gFCVXDQkXBctJ7hYp0LacYh5zoXiJwDvvhc/Bt2FcL5u3Uh1CN3
	 72B6VpyJjiXL9lGzaWDagm8umZI3YqWagaENGTFcnAOeTBOGy7WJpvLtrLSonxpLaI
	 F6p8rku/n30HA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101BD86915; Tue,  5 Sep 2023 09:39:03 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E93986569
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 09:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Rfy781n7Dz1sB7V;
 Tue,  5 Sep 2023 09:39:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4Rfy781Tpvz1qqlS;
 Tue,  5 Sep 2023 09:39:00 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id I-QlnZQruieG; Tue,  5 Sep 2023 09:38:59 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Tue,  5 Sep 2023 09:38:59 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1824874
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v2 2/5] thermal: imx_tmu: Fix the polling default
In-reply-to: <20230823175911.319414-2-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230905073903.101BD86915@phobos.denx.de>
Date: Tue,  5 Sep 2023 09:39:00 +0200 (CEST)
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
> When the 'polling-delay' property is not passed via devicetree,
> pdata->polling_delay keeps at 0. This causes the imx_tmu driver to get
> stuck inside the busy while() loop when the CPU temperature is above
> the alert point.
> Fix this problem by passing a one second polling interval, which provides
> a proper delay to let the system to cool down and exit the while() loop
> when the temperature is below the alert point.
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
