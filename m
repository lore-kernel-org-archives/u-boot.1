Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EFEC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 17:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E11987751;
	Thu, 11 Jan 2024 18:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="u1IOn2+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C109487885; Thu, 11 Jan 2024 17:52:04 +0100 (CET)
Received: from try.jabatus.fr (try.jabatus.fr [109.234.163.213])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3813C87142
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 17:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-25.979, required 5, autolearn=disabled, MED_SPX 1.00,
 RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00, SPF_PASS -1.50, VM03 0.01,
 WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: C32FBE03B2.A6E8B
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0Ysv/AqBDE6/bWlR2tLGkIi+U8Jy+OkTXlchgylWzzk=; b=u1IOn2+26JRujzFNBcPe9T8BnC
 CxiulxE3XkGI81v7MutUBiGwNdI239EkuWItE7BRy/GMDCiYUsLDbrkQ61gwtPnVtMQsGQHuo2Oih
 I0QkA/YOrej8u0O1gdOkcwenm/ysXPxFAoFle1Hqsrxj/O6b4t/hTduJMlrFSVvUZ50f+jYhid57F
 EdiTl3t/yWeTbE4PZpurF9kolcVmCErH6xfKiBYSAU3M6YvyHaFOzdRoXUIEa7XFXdz4p/J6qtlqS
 5bPEax8F6+9szAV1GcjFlC55sJKFaq8xeJBXWaztpMUmATdmLAraVDXR9qFE29ZBlUVGBFwQXWzEV
 mgyzlSwg==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] get_maintainer.pl: slightly modify penguin_chief
Date: Thu, 11 Jan 2024 17:51:26 +0100
Message-Id: <20240111165127.12882-1-anthony@loiseau.fr>
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
X-Mailman-Approved-At: Thu, 11 Jan 2024 18:55:45 +0100
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

Please find a patch proposal which slightly modifies get_maintainer.pl
penguin_chief list.

This proposal aims to workaround get_maintainer.pl behavior for ARM, ARM_TI
and THE_REST sections (see MAINTAINERS file) for which Tom Rini was not
outputed as a maintainer by get_maintainer.pl.

Root issue is that get_maintainer.pl threats penguin_chiefs this way:
- with --git-chief-penguins, penguin_chiefs are appended to all results
- with --no-git-chief-penguins (the default), penguin chiefs are stripped
  out of all results

That is, since Tom Rini is set as a penguin chief inside get_maintainer.pl,
get_maintainer.pl never outputs him as a maintainer with usual uses.

This issue does not hurt that much for upstream Linux code since Linus Torvalds
is not listed in MAINTAINERS file except for THE_REST, but sections coverage is
good so "THE REST" section almost never triggers.

I saw several options to fix this:
- OPT1: get in touch with Linux upstream to change --no-git-chief-penguins
      behavior so it does nothing instead of stripping chiefs from results
- OPT2: take advantage of case-sensitive (name, email) comparison
        to keep Tom Rini chief as Tom RINI.
- OPT3: clear penguin_chiefs, breaking --git-chief-penguins
- OPT4: implement OPT1 here

From an email discussion on LKML [1] my understanding is that upstream votes
for downstream edits here, hence this patch proposal for OPT2.

Note of interest: this fixes "THE REST" catch all sectioni too, resulting
in Tom Rini listed as (maintainer:THE REST) for all repo files.
If you think developers automatically fills patch emails to/cc from
get_maintainer.pl output, then you may want to break it again by setting its
maintainer as Tom RINI.

[1] https://lore.kernel.org/lkml/13fd63b7e8e0f197842ae1f1264e50c9614d0667.camel@perches.com/T/

Regards,
Anthony

Cc: Tom Rini <trini@konsulko.com>


Anthony Loiseau (1):
  get_maintainer.pl: slightly modify penguin_chief

 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.0

