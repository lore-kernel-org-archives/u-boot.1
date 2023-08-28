Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0E7C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F30D86522;
	Mon, 28 Aug 2023 17:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YrzqI8w2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B425B86522; Mon, 28 Aug 2023 17:22:41 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A76286505
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-062-143-244-162.um16.pools.vodafone-ip.de [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8AA173F1FF; 
 Mon, 28 Aug 2023 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693236158;
 bh=jQ98Yjxajv2GjP4cJfuf8RiRnuoMKTFIADFXNjxh7EA=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=YrzqI8w27jxg227iso2wONaeC7Z6IVEMST6fnkPwXUlj47LM/ejhP62JWyjgut8PP
 5JMmyz4UgwWgpJTDkjpNXYBgqdxAlLwTWlr9Za2yElogJcUUydv0Xz/7ojfYf5dVaL
 qL1Mn7rpfGya2sTAsndkINcY+pPVxz9z7XEP9ppwC536KDw38a1Y9tli4gkeLOO+tz
 CRPRnjcCiLKg/qQFCLrylBpja1wa6VzmQGi3cg+u6Y7GNoOA45asxZQdhREu1LRG3W
 gZ7IUm6JpY3wP458+l3Z5JhqBFzf7sUfqM94hXAmzqbyTstYzk/MmaQlS7BrqiCmw7
 2Xh8X8Q/Olm+Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] doc: event: document all events
Date: Mon, 28 Aug 2023 17:22:24 +0200
Message-Id: <20230828152226.73466-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Document all events and add event.h to the HTML documentation.

Heinrich Schuchardt (2):
  dm: event: document all events
  doc: add events.h to documentation

 doc/api/event.rst |  9 +++++
 doc/api/index.rst |  1 +
 include/event.h   | 84 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 doc/api/event.rst

-- 
2.40.1

