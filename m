Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3306C46CD3
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 22:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8E6876D7;
	Thu, 21 Dec 2023 23:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="Rw5wAtlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2F38767C; Thu, 21 Dec 2023 23:45:11 +0100 (CET)
Received: from enceinte.jabatus.fr (enceinte.jabatus.fr [109.234.163.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1EA8779D
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 23:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
 score=-25.979, required 5, autolearn=disabled, MED_SPX 1.00,
 RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00, SPF_PASS -1.50, VM03 0.01,
 WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: 36827E0200.A221C
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=py9Q0hSht/wwg1G4WsEyKBioN1PRHV17dsA/KJwH32c=; b=Rw5wAtlNtdnXurgJfBEnrtimro
 VkWM/rg6NZqwtVVOYXCrS8w5M5vBXfcNc7YExYMyWZWM/ODQM4pSat00x49GMzf7JLWknQo3jiVn+
 gPFfNmunGmZHJSrdjMQh5+64Hdw0mqDGeENFjarR6v+n9sD4zwAv9+1qJiwE6FbAtmLEJNqlzGLGK
 aNVzKO+dZXfGbld8iMF7azIQDXWm1BltYevNAZAHD5+oK/Y/yrd+3jDA8S2Lsrgpuy9aWomMqmpub
 0rK6tGkvmnw97XyMrOYF17SAUhui/ofSFwWHQ5ydT7V75KcxJ7OPshGQuOdK1qbwTZTDaE97kzkFr
 LWtv7YgA==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Stefan Agner <stefan@agner.ch>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/1] fw_env: auto-detect NAND characteristics
Date: Thu, 21 Dec 2023 23:44:37 +0100
Message-Id: <20231221224438.21247-1-anthony@loiseau.fr>
X-Mailer: git-send-email 2.11.0
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - sucre.o2switch.net
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - loiseau.fr
X-Get-Message-Sender-Via: sucre.o2switch.net: authenticated_id:
 anthony@loiseau.fr
X-Authenticated-Sender: sucre.o2switch.net: anthony@loiseau.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

From: Anthony Loiseau <anthony.loiseau@allcircuits.com>

Hello,

Here is a patch proposal which modifies fw_env so NAND chip erase size as well
as environment sector counts are guessed at runtime if they are both statically
configured as zero.
This actually extends a previous similar behavior which was NOR-specific,
useful when a same RootFS is executed with several flash chips,
see e282c422e0b.

Be aware that I did not test this exact patch for real. I extracted it from
my older u-boot-flsc 2016 tree on which it works well, and built it using
a sandbox configuration, without running it. I only checked my gcc was happy
with those lines (no warnings added). My feeling is that this patch is small
enough to feel confident it will work on master as it worked on my old tree.


Opened to any reviews or requests,
best rergards,
Anthony Loiseau


v1:
  initial buggy submission (broken thread)
  stephan toradex email no more valid
v2:
  fix cover letter
  use another email for Stefan
  cc Rasmus (author of the changed lines)

Cc: Joe Hershberger <joe.hershberger@ni.com>
cc: Stefan Agner <stefan@agner.ch>
cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>


Anthony Loiseau (1):
  fw_env: autodetect NAND erase size and env sectors

 tools/env/README   |  3 +++
 tools/env/fw_env.c | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.11.0

