Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BB1CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3484286A43;
	Sat, 23 Sep 2023 20:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695495121;
	bh=i4fe/yn0wO+fF45u0m3n4xvqKPoJLunOmnZq1lXRuiE=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=B1W7AIIsuJjWEeyS0F2DNE/wwHL6DhqkxrJqBmp9oRppXfNnt7kUkL7iQxtxXu2QQ
	 EA27gRczTXns1ddYAzvPadhaACvAj08+UOU+4Bvxyss/CtuPECPPXaNCE+KBq+Oi4C
	 DI4HhUc9ntL6tQONG5AtvsC7FVqtCXcVvv6cX/bItpAlN8qLI1CM+m2ohmD5SsS+vQ
	 AWPBkWMurVwznQTkIPij4FpedrAuCzugZio6ZJl+m/JRHuPnoB4ArfoJyWa3Pua1Pw
	 IzumBXNEzYlAi1yAdAUNiC94INfc78pfQpURQpvuQbLo8JrlzBDxPdMbIWc+Y4mD1v
	 wwkL/ITc66j0w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6AE869EB; Sat, 23 Sep 2023 20:51:59 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6025986B29
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4RtJCK1222z1sBqf;
 Sat, 23 Sep 2023 20:51:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4RtJCK0m5qz1qqlS;
 Sat, 23 Sep 2023 20:51:57 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id MitlohL2cDxi; Sat, 23 Sep 2023 20:51:56 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Sat, 23 Sep 2023 20:51:56 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Fabio Estevam <festevam@gmail.com>
X-Patchwork-Id: 1830685
X-Patchwork-Delegate: sbabic@denx.de
To: Fabio Estevam <festevam@gmail.com>,u-boot@lists.denx.de
Subject: [PATCH 2/3] imx: hab: Improve the hab_auth_img_or_fail usage text
In-reply-to: <20230907014727.371324-2-festevam@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20230923185159.5C6AE869EB@phobos.denx.de>
Date: Sat, 23 Sep 2023 20:51:57 +0200 (CEST)
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
> Split the hab_auth_img_or_fail usage text in two sentences to make it
> clearer.
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
