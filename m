Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E73AC83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 07:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D88E86940;
	Tue,  5 Sep 2023 09:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693899547;
	bh=Q7Ug98pKRdZr2OkfgjUrQWUdTB69YB/YtOoqsKEZPzo=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=z9oIhn/l35gzvF9idtGpdHwBJC6a+IwNyAAggRDxHe+7nh/nnRNKQ/BuN8ybwv1Fo
	 1VTUeelGFvEsQMjuYJSovreoSK58Sj3uM0RVZk/Yn1d4nPqOj9uOq4r01h4cAreGYh
	 2MODuIrf8jha7QTMAdAeACx2I4OUevJI/sQoHymWMc3sknSa3L2xdu6DAs4oDUEyX1
	 QKivCV7sNKTirtDf4qwJ0WyP75ZmhZqLNT9kQPMyAApIhADFV8cWjSlJe+dCwIiLgJ
	 JkAHyp/kkF9K1dWqqGqAlSvBHXboKYIfTnodlVNRyL95Kppwo0mZu5XJcDtqnQaZXD
	 eGUdwHduU6lxQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00F286940; Tue,  5 Sep 2023 09:39:06 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A418691E
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 09:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4Rfy7D0FRwz1sBpv;
 Tue,  5 Sep 2023 09:39:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4Rfy7D050nz1qqlS;
 Tue,  5 Sep 2023 09:39:04 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id CUf0IV04hJNf; Tue,  5 Sep 2023 09:39:03 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Tue,  5 Sep 2023 09:39:03 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1824876
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH v2 4/5] thermal: imx_tmu: Fix the temperature unit
In-reply-to: <20230823175911.319414-4-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230905073906.B00F286940@phobos.denx.de>
Date: Tue,  5 Sep 2023 09:39:04 +0200 (CEST)
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
> The temperature unit is millidegree Celsius, so divide by 1000 to correctly
> print the temperature values in Celsius.
> While at it, also change a typo: "has beyond" to "is beyond".
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
