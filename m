Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE0C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3FE878AD;
	Thu, 21 Dec 2023 17:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="hl3pG0iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7443787860; Thu, 21 Dec 2023 17:00:16 +0100 (CET)
Received: from glass.jabatus.fr (glass.jabatus.fr [109.234.163.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE988788E
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamScore: s
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=1.511, required 5, autolearn=disabled, BAYES_05 2.00,
 MED_SPX 1.00, RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00,
 SPF_PASS -1.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: 733F6E0467.A1E58
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aQ1ic1qrG0UtIzU6DWACEmMiPwSrdvsGAxu/hUsrJqI=; b=hl3pG0iy0Yg2WAn7C4gFWUMRNH
 RTf5RAE3xUD9b530zZW7r3Ta95cCD/JL6adG4z6uX/t2iF4/BPVkMnvI8HjATWLi+P0yRgA7x+GxX
 bMuF+Xa4iokNfP7721WIiJqrd7a2cQrqqJbfm6NllJKiaV9oErJHBZm5OsTqBOcXrMuIlWxyMJxgr
 OjwNpw0gJiOcr5nruCaG0ZiuMoh9+ZKZrAnGbfvrHwXJ07z1uKU0fLgC1u6rQ8qCM7IZI6r9M3CZU
 lf0KsyC2U8TnTAu7HNzW2YMr3madFpCEKZ/QIrqrgSJZ5lyoMd7e5iGXzSjaaa7r6kNGvbvMTd7ek
 F01LTNzQ==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Subject: fw_env: auto-detect NAND characteristics 
Date: Thu, 21 Dec 2023 16:59:28 +0100
Message-Id: <20231221155929.1762-1-anthony@loiseau.fr>
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
X-Mailman-Approved-At: Thu, 21 Dec 2023 17:18:03 +0100
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

Please find attached a patch proposal which modifies fw_env so NAND chip
erase size as well as environment sector counts are guessed at runtime
if they are both statically configured as zero.
This actually extend a previous similar behavior which was NOR-specific,
useful when a same RootFS is executed with several flash chips.

Be aware that I did not test this exact patch for real. I extracted it from
my older u-boot-flsc 2016 tree on which it works well, and built it using
a sandbox configuration, without running it. I only checked my gcc was happy
with those lines (no warning added). My feeling is that this patch is small
enough to be confident it will work on master as it worked on my old tree.


Opened to any review or request,
best rergards,
Anthony Loiseau

