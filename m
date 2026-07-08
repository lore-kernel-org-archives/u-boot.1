Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F080BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C99084A1F;
	Wed,  8 Jul 2026 19:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="iJV1zkfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D5284A3E; Wed,  8 Jul 2026 19:21:33 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6804A843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwPyf75PHzDF9;
 Wed,  8 Jul 2026 19:21:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783531290;
 bh=aKv6FSxFCDetWnjbHAHcZpwzG9jKdb/r6AD6xT87ANA=;
 h=From:Subject:Date:To:Cc:From;
 b=iJV1zkfwlojdR7KOQnU9KbwxvMJ5weGu6tFiLBEQgtHcy5kb0Pgs6+wlhH6dqt62A
 jfQUfxRLDk0nTUWAe1Evdf7pfqaSqsfKnvAX5x7N4/tJseyBoR8NQBzmZvfqEvBSHa
 QAB+2QJT8tdFsW/OXBbeBsOF7uCqff8BUcAKepO49dEv4UpPlCqGP2M8wGJFJ3SrF5
 6vkW0c7ixPgqVZU6GK3ymjuFaz7ctCJcDOp0LAjXxbYHMh/fVE2rvByY67Dr2RkR3V
 3xeiaEHhDbWfp6P9htV153SUPU4+Fw8DcUp4W3onuHtb/LCV90Me0GE5IE3Rh5K1v3
 Uh2+SgEJqxMIQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gwPyf0ZZCzZn2; Wed,  8 Jul 2026 19:21:29 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] doc: CONTRIBUTE: hint at different kinds of contribution
Date: Wed, 08 Jul 2026 19:21:12 +0200
Message-Id: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVpSRBXEQsdg7FoZVoiEXdXL
 N/i/wsCCVOANrtA6ODA3iWYPANcBjeT4jEZCl1UutaN8nEhUehdFLaqNENjrTZY1Qip2YQmPr9
 f1/8Ou10J4zuB+34AUr/F4HEAAAA=
X-Change-ID: 20260708-other-contrib-31a8bb01c67c
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

We could benefit from having more reviewers, as well as more tests and
documentation, so let's make that explicit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      doc: CONTRIBUTE: use internal link instead of hardcoded external URL
      doc: CONTRIBUTE: tell people reviewing *is* contributing
      doc: CONTRIBUTE: explicitly list tests and documentation as welcome contributions

 doc/CONTRIBUTE.rst | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)
---
base-commit: ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d
change-id: 20260708-other-contrib-31a8bb01c67c

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

