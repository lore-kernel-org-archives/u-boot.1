Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6126DC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E2C8771E;
	Fri, 22 Dec 2023 16:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="HIg+1BLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA9EB877B2; Fri, 22 Dec 2023 16:44:39 +0100 (CET)
Received: from envoi.jabatus.fr (envoi.jabatus.fr [109.234.163.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91824874D5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
 score=-23.969, required 5, autolearn=disabled, BAYES_05 2.00,
 MED_SPX 1.00, RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00,
 SPF_PASS -1.50, SUKB_11 0.01, VM03 0.01, WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: 11B05E0207.A6249
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EcMjcdqP0z4q5v1WgBSmHUDfZbvx2bCI8osAIkyE1tk=; b=HIg+1BLS7f1ruxAMzQxdRoNsTo
 fYQOg0UzAQ5OjsLwLY4798FsFzeajLPA/qcT0Mg9rgxmNAC0uFFgQOW0+t8v8UvmCkzV+akp+U2xx
 YebIzhXeSSWdsPIw6LcFCN2UaV00QqhBhOfRjFf5NnkXvmpcXBOrU05qYTGLANMkZV4FCKIJBuQwm
 bwOzv0bKrUANfyVOvd7gm5dVWBf66sSnzriIvooxvesONIy51gxqGhC1/dBSOjqfXaXHaI+BmKwL1
 8BGHqI6Chn+8NSaC28y7GTw4AFfyE6NwaG7aFAEhunr8gjatd/BrfBefgH4OYD9QzOP/p/Gqo4TWM
 LmFDggQg==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 0/1] MAINTAINERS: fix folders within glob pattern
Date: Fri, 22 Dec 2023 16:44:07 +0100
Message-Id: <20231222154408.21519-1-anthony@loiseau.fr>
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

This patch fixes few folders I think mishandled within MAINTAINERS file.

For example, files within drivers/clk/tegra/ were not affilated to ARM TEGRA
because rule "F: drivers/*/tegra*" does not match them. See MAINTAINERS file
embedded documentation on top.

The same for tools/env/* files which where not affiliated to Environment
section despite the "F: tools/env*" rule.

It worth be noted that despite I successfully tested this update for
Arm Tegra and Environment sections, Arm TI related updates does nothing.
My feeling is that those updates are good and wanted but another issue remains.
It looks like all sections maintained by Tom Rini are entirely ignored, I don't
know why and did not dig into it deeply.

Example of test:
./scripts/get_maintainer.pl -f drivers/clk/tegra/Makefile
now lists Arm Tegra maintainers were it did not.

Cc: Tom Rini <trini@konsulko.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>

Anthony Loiseau (1):
  MAINTAINERS: fix folders within glob pattern

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.11.0

