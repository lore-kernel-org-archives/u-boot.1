Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB8C369A8
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3586983C51;
	Thu, 10 Apr 2025 14:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="Unh14GsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780FD83989; Thu, 10 Apr 2025 09:00:43 +0200 (CEST)
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me
 [162.240.238.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99458394F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parvathi@couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
 ; s=default;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YOCPe8Vk7AaOBQyPdlCLIdutbJBxhtyR+wXunVfy4Pk=; b=Unh14GsLV5+8bJjnGR2yEH+9bn
 CuZPIQHXs7hqQgRdlYhmfbY69tuV78p0FDXH10zn66JIske2L6M4nB5utx+w9jRTsE0/AG+8ImbrK
 qro0YOJVcLRGC49Mj96cp1weSvhIv0bKrmJkprZvCJf0fBlJRswlDvO/9uo6sMbVJ+me06sxjOcqn
 ZI0ixr0f9/iUi/Y+eLgrvW/skasEZu4/0VyXxe7fzb2e1llerXrWeGPjJg7Q6U9femkBV6576Zrqg
 uTG53qG2793HVrGpa3K+auBfmcOsVwDvjmBODkoQBYzcKu5YrxYBlvydhDkcxWra35qhe6NsDviK5
 5Nx8gfjA==;
Received: from [122.175.9.182] (port=56142 helo=bulbasaur.couthit.local)
 by server.wki.vra.mybluehostin.me with esmtpa (Exim 4.98.1)
 (envelope-from <parvathi@couthit.com>) id 1u2ltu-0000000035o-0F6L;
 Thu, 10 Apr 2025 12:30:37 +0530
From: Parvathi Pudi <parvathi@couthit.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	sjg@chromium.org
Cc: pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, danishanwar@ti.com,
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, afd@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com,
 parvathi@couthit.com, basharath@couthit.com
Subject: [PATCH v1 0/1] Support for PRUETH mode on AM335x ICE
Date: Thu, 10 Apr 2025 12:29:54 +0530
Message-Id: <20250410065955.9770-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id:
 parvathi@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Thu, 10 Apr 2025 14:58:33 +0200
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

Hi,

This patch adds support for PRU-ICSS mode in the u-boot environment to
correctly load the device tree blob file based on the HW pin (jumper)
configuration in AM335x ICE Evaluation module. In this device, the pins
and the ports are shared between PRU-ICSS and CPSW thus need runtime
detection between the two modes which are rmii in case of CPSW and mii
in case of PRU-ICSS.

Depending on the jumper configuration on AM335x ICE we have to load the
appropriate device tree blob file. In case of CPSW (rmii) mode, we need to
load am335x-icev2.dtb file and in case of PRU-ICSS (mii) mode we need to
load am335x-icev2-prueth.dtb file.

Thanks and Regards,
Parvathi.

Parvathi Pudi (1):
  include: configs: Adds support for AM335x ICE PRUSS mode

 include/configs/am335x_evm.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.17.1

