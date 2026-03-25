Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90685FEA835
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0135D8352B;
	Wed, 25 Mar 2026 10:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mdaqvF9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCDEC83DA6; Wed, 25 Mar 2026 10:20:07 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A62981E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=qZ46CSs2SNJbL3aTPIvhf36q1HmOiujZHqIMY5tvAIw=; b=mdaqvF9ySfZkqn7cmM/o9LRP18
 vtcuvcHpESVcQr8htmtUStuFvhfd/Wa0uy8ok+JtOHFePq1uZwuzLITe+OTWbBtYZrkdSEfpCVkIA
 EIL610pGaDSqI5RsQNH7F8KW76TxIGlaKo0vJwSUNeFkmtWqEjFnC9RXdOa5wvACLEbPL1+ubYKQN
 4NoOI/wx6LdCtMvWxmS9nfxHcNs5vUqaikV1yJOty7EpK3myuiybVwoXlsZYOR/xpwGXQ0ngBZErR
 uCwOg0Re+wy8W2qKcbz/rRsTBwut4XS/rgwrp3sdUGE4/mEpdlmjYbuCPRs18bUjan8ag9n3Ei0hS
 axq4+XPA==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPD-0004Ac-0Q; Wed, 25 Mar 2026 10:20:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w5KPB-0005cv-31; Wed, 25 Mar 2026 10:20:02 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 0/3] TQ-Systems MAINTAINERS files
Date: Wed, 25 Mar 2026 10:19:51 +0100
Message-ID: <20260325091957.906400-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series updates the global MAINTAINERS entry from TQ and creates a
common TQ Board MAINTAINERS file for board-specific files and the
responsible board maintainer, into which information from future boards
will also be entered.

Markus Niebel (1):
  MAINTAINERS: update entry for TQ-Systems

Max Merchel (2):
  tq: add TQ board MAINTAINERS
  tqma6: remove board MAINTAINERS

 MAINTAINERS                | 12 ++++++++----
 board/tq/MAINTAINERS       |  8 ++++++++
 board/tq/tqma6/MAINTAINERS |  7 -------
 3 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 board/tq/MAINTAINERS
 delete mode 100644 board/tq/tqma6/MAINTAINERS


base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
-- 
2.43.0

