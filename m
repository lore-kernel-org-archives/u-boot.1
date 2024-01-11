Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53625C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 17:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16026878BA;
	Thu, 11 Jan 2024 18:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="k9v3PfqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39BB87885; Thu, 11 Jan 2024 17:52:10 +0100 (CET)
Received: from surprise.jabatus.fr (surprise.jabatus.fr [109.234.163.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02A987756
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 17:52:08 +0100 (CET)
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
X-MailPropre-MailScanner-ID: 29E7CE03C1.A5D6D
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QgjvrmOAfi6hp2JHH9lTnbFxPZg1h0wnNVHNsURePG4=; b=k9v3PfqRDz3LHRyCG7Ms89TOfP
 5oAVIqiLoDNCtYxG/XEj2d9YA0Neq/YWzqkeSDJqo1vqpqt0+o2SBMb/w/2jyFz8wpJI4DAGeDcRE
 lOY5d9hrvXbWWW/yK5+waTWOPIJL7p6B1KGEiCGbbSIRFY0vuONz8XifcyW9rTnQSw2ulbD3QDOa4
 Dmn3B1EsayjRmjb3FhW7G/2DubI/4LUqymPCaGJC2J5oAM8E0xROusN2GjmDFu1T4lwMIjxnkQpuP
 ZP7/Ru316m5iSwPbbJzzdjJxicKZy1yoQEn8e+uHMbkZo4SILHIoGhr+oz1Ucy6YCwWSFd0JYrI39
 kyasrBow==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] get_maintainer.pl: slightly modify penguin_chief
Date: Thu, 11 Jan 2024 17:51:27 +0100
Message-Id: <20240111165127.12882-2-anthony@loiseau.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240111165127.12882-1-anthony@loiseau.fr>
References: <20240111165127.12882-1-anthony@loiseau.fr>
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

Penguin chiefs are actually stripped out from get_maintainer results unless
--git-chief-penguins is provided, which appends them to all results instead.

This is a issue for U-Boot since Tom Rini (penguin chief) is also maintainer
of some sub-trees ("ARM", "ARM TI" and "THE REST").

Hopefully, this match is performed case-senditive over name and email,
therefore upper-casing Tom Rini last name workarounds the issue.

Important note: This also fixes "THE REST" catch all section resulting
in Tom Rini listed as (maintainer:THE REST) for all files. Hope there is not
too much developers scripting their patch email header from get_maintainer.pl
output, otherwise Tom Rini may be flooded.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6c58578e98..71cf18c2b3 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -80,7 +80,7 @@ my %commit_author_hash;
 my %commit_signer_hash;
 
 my @penguin_chief = ();
-push(@penguin_chief, "Tom Rini:trini\@konsulko.com");
+push(@penguin_chief, "Tom RINI:trini\@konsulko.com");
 
 my @penguin_chief_names = ();
 foreach my $chief (@penguin_chief) {
-- 
2.11.0

