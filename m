Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF6C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 10:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB39809D4;
	Wed, 23 Apr 2025 12:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xrirti5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A29580BA8; Wed, 23 Apr 2025 12:04:05 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A947809A5
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 12:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53NA3sTF2263940
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 05:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745402634;
 bh=RO+ZR16tvkXbAcKwOsLw/rNCpluRZiG6c7x175+7Wq8=;
 h=Date:CC:Subject:From:To;
 b=Xrirti5qfciyYvC40BzA2/jbDR/qzACXqXO4/PYUw2diyElrlg5oYxQMngszY08G7
 TnKEx6bPBpBMK0M53IaD09qHCwL4AKC0UMtdAxXKor3uqRH/pXSVkyZhVtQQsLR3UT
 qUfwg2vHsuZ2a+8uW0d1okwxL6fv+uqlKPLauwxY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53NA3rbs059575
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Apr 2025 05:03:53 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 05:03:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 05:03:53 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53NA3qZ5066008;
 Wed, 23 Apr 2025 05:03:53 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Apr 2025 15:33:37 +0530
Message-ID: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
CC: <vigneshr@ti.com>, <rick@andestech.com>, <mporter@konsulko.com>
Subject: [RFC] Expected behavior of the go command
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi all,

I was trying to understand how the go command is expected to work when
used to load custom OSes. My use case requires getting a proprietary OS
to boot using the go command on a TI K3 platform. The OS expects caches
to be flushed and the mmu to be disabled before we jump to it.

The go command (do_go func in cmd/boot.c) calls the do_go_exec function
underneath which does not seem to have a consistent implementation
across various architectures.

In RISC-V the implementation (arch/riscv/lib/boot.c:10) calls
cleanup_before_linux before jumping to the loaded binary. This behaviour
would enable the direct use of the go command for booting a custom OS
(like in my use case). Though no such generic implementation exists for
ARM64.

I was wondering why we have the call to cleanup_before_linux for RISCV
and not ARM64?

Also, is booting a custom OS using the go command a supported use-case?
If yes, it might be better to rename the function to be more generic
like cleanup_before_os from *_linux and call it for each invocation of
the go command.

Regards,
Anshul
