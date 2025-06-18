Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9C7C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 17:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB00182BCD;
	Wed, 18 Jun 2025 19:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zoho.com header.i=alex3kov@zoho.com header.b="BNDQrQdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5A682C2F; Wed, 18 Jun 2025 19:11:38 +0200 (CEST)
Received: from sender4-pp-o91.zoho.com (sender4-pp-o91.zoho.com
 [136.143.188.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81B580C83
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 19:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex3kov@zoho.com
ARC-Seal: i=1; a=rsa-sha256; t=1750266693; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cvwrrQcdmhU4f6FAqgWUovPO4U+G7aLYVqQqMgaMT08xhS7Q6+Op/DOZbuesqFo32welOodEh36FUTfV6RisKg7pfLCFGWuYEiB+qJTVvkd+IGBdbVsSQnj+F1BuQAjY2THCkKwX4MGVS1owT+7eAOCY/bLtUP+7s97+N4FxyMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1750266693;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=dMspnWPNSohIwyx6aRmONvNrAl19Y1U44cBHMjKNJ/o=; 
 b=HDqybLQSavKJeN+6BmF+vosoK+tAmtl9ZFsq0OF+tdSSp00mj5TgVysUqSY8x9nEiqg3VCtnRp7vIOwi7bgWf9gQ28tkNCKdnc/f7lT15i0KH4ub5xxmWBf85xDvurNXbGlnCeE27hC7xkXM0m5r0f9u66csh9ewv0dVYxEuq78=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=zoho.com;
 spf=pass  smtp.mailfrom=alex3kov@zoho.com;
 dmarc=pass header.from=<alex3kov@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750266693; 
 s=zm2022; d=zoho.com; i=alex3kov@zoho.com;
 h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Feedback-ID:Message-Id:Reply-To:Cc;
 bh=dMspnWPNSohIwyx6aRmONvNrAl19Y1U44cBHMjKNJ/o=;
 b=BNDQrQdxeU+LjhsFEI7vpSAnf4hHaFSi5FBWCRoWkotZG0lKqM8z97/EjEvu7OdP
 hAd795FdoXjMR137kxQQ8L7unlml/LYMIeoPuZNE0ntc+Rxjnp2aKJC9O28EqZa0e8U
 HOJmRjoXY3a/GbFKrU6o4vkwnTTePvXd8zRwJ1Ig=
Received: by mx.zohomail.com with SMTPS id 1750266685930814.4307801362268;
 Wed, 18 Jun 2025 10:11:25 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:11:18 +0300
From: Aleksei <alex3kov@zoho.com>
To: u-boot@lists.denx.de
Subject: Build fail on rockpro64-rk3399_defconfig + SATA_MV=y
Message-ID: <tc42tqvd3kqqbfqkau5niycwkhi5ddaqponrasaitk3tkusops@yevset7ocspg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Feedback-ID: rr0801122832074458fbb81b4ff35c09780000e491b898e5bf0629fbd5bbbd8a781543ccc261c59b6d96471eec:zu080112250c3f17b89b530ce0a39480520000b57f7bc712898beb2dae530cce90393c1982382ab1db80:rf08011226433917f0d3b8ca0c4bb836120000f1e8c14f8232977bbf9148c81fbe3d36cc98fc702d66712b:ZohoMail
X-ZohoMailClient: External
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

Hello,
Building v2025.07-rc4 or git (17012e3068d):

make mrproper && make rockpro64-rk3399_defconfig
make menuconfig
# enable SATA_MV=y in menu
make -j $(nproc) BL31=/tmp/bl31.elf

drivers/ata/sata_mv.c:55:10: fatal error: asm/arch/soc.h: No such file or directory
    55 | #include <asm/arch/soc.h>
       |          ^~~~~~~~~~~~~~~~
compilation terminated.
