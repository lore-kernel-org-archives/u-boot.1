Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA8FD0BB7B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 09:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7631089313;
	Thu, 24 Oct 2024 11:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Qffj0B4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772E189328; Thu, 24 Oct 2024 11:15:37 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AB78806A
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 11:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.CtrlMice (43-114-103-145.static.glaslokaal.nl
 [145.103.114.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B2BB83F385; 
 Thu, 24 Oct 2024 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729761331;
 bh=Jh851w643v1CJrEXcquBJ2n5d4pSGi5UAWJxECJ17E8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Qffj0B4JsJouIDOVGgugFZ4mtB5zCVTHKGtATRk8nR8S2SQz94+FWBYCRqgMuYrIl
 0hp3QNJh0dPiw0g9prrdHPMYeSPU0QunpjF8xhKUZhjJjdeO4uhnUsQs9jCq+C7AQ7
 eYcxP9zbXkeEQOL9B7YT7aJfpb4PlRb8+HuPRN3eeFgYW/d3EAQwYqQbGeLvHXvKKi
 iTonos1T6UItyrOdFjVLK3Q2VXihPsVmC6hyFIBIDumdtMPAuR+LxuPEOtDnMyQwMy
 NiGGGIPwcyFaWreLb69ITjbfdHvzCo1kh4o0qk3DzRak6JMQbZSZIDX8jbFlyCL296
 CiUiorf5yoMMg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] doc: include file-system API into HTML docs
Date: Thu, 24 Oct 2024 11:15:27 +0200
Message-ID: <20241024091529.31136-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* Describe the fields of struct fs_dir_stream.
* Update fs_readdir() and fs_opendir() description.
* Fix Sphinx errors.
* Add include/fs.h to the API documentation.

Heinrich Schuchardt (2):
  fs: improve API documentation
  doc: include file-system API into HTML docs

 doc/api/fs.rst    |  7 +++++
 doc/api/index.rst |  1 +
 include/fs.h      | 66 +++++++++++++++++++++++++++++------------------
 3 files changed, 49 insertions(+), 25 deletions(-)
 create mode 100644 doc/api/fs.rst

-- 
2.45.2

