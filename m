Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043EFCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732F886E33;
	Mon, 16 Oct 2023 18:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697474768;
	bh=dAgZWBsVs9+oHQNZbJ8KIlFBsHdkS78BEMZf9ZHonzw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z52eEvwCglUlQJnvYDGiYAI5R47FGKbYyHPROt7cYwdszaaz70IWLiKfaf9ePw38i
	 kKuW5l0ywoUkzut0NXIcfvEL+kZ8WSKNDdMBskJ2Ofx+iATB4z4GKfcS7mzwZrxRDS
	 6RJvyP+7a22JCAyK8iBX5TcLQCCcQ/FBr0+v1lRg2/+Qkf3y+Mh5GYL9//J8KMwKPu
	 ae8wuo5POlBRke0BpcgUkxWQS7l74aGiPLll9joDaOoNKVSHIIXiGBL39PSJHXkWSU
	 FZDmrhV3gwPl86kxywSnyWs8Po/Ds0uwZxegLy2ZZM8gINJyV2o0cunHyxVpe6dagM
	 OR8dkJKHYJqwQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D976486DCA; Mon, 16 Oct 2023 18:45:57 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C479B86940
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8NKD5n8Lz1r1gC;
 Mon, 16 Oct 2023 18:45:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8NKD5fM0z1qqlS;
 Mon, 16 Oct 2023 18:45:52 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 8miSJX6iIee2; Mon, 16 Oct 2023 18:45:52 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 18:45:52 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: =?utf-8?q?S=C3=A9bastien?= Szymanski
X-Patchwork-Id: 1813670
X-Patchwork-Delegate: sbabic@denx.de
To: =?utf-8?q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Subject: [PATCH 3/4] net: phy: realtek: Add support for RTL8211F(D)(I)-VD-CG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-Id: <20231016164559.D976486DCA@phobos.denx.de>
Date: Mon, 16 Oct 2023 18:45:53 +0200 (CEST)
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

> Add support for the RTL8211F(D)(I)-VD-CG PHY present on the i.MX93 EVK
> board.
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
