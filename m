Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE71CEE350
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFFA83A57;
	Tue, 18 Nov 2025 21:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cmlWIhEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598DE83A57; Tue, 18 Nov 2025 21:17:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B05383A1E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 94EF941019; 
 Tue, 18 Nov 2025 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763497070;
 bh=IoR6B34mWI+BXTzwsrQxehtd+1Xq7cvK06sJq9qlVyc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cmlWIhEHUbEYdHl5jadfbseWF6CrdkhArDggrneNFqyovbpC6LkNAO9vdajXDqE2p
 OjDUZ5xQ+qa/kwS0wmbHXQVHSvBtbSza9JoBV21aEO6Bc6mG2cvZdvOw4JcwXfityu
 yOB291hzYBIOYZegBzfBFJKD3cg3jC5AinwWMqnFlPn5C288kR+dhXLq63E9S+Cleb
 hn5V0fxds7/pYuOQYd6WhSUA5hE3NWZwCS3z9oy1I9+owQmgLHA83x2QhGIYBZVo3G
 4yVYSEdThcT73VzTUupFUI4rNZOHdOR+eT1/D9ibbZGl/mzjGAMkyhuyk0C5GHQoV5
 5lyYSbVIrNRcpulZDvmSdllnWYMwQfCiMozsPAq7Jp0dkzxPMdT1aoRaobyacgpoLc
 bqmQzPk+BVtiTPhCrVwh+vlgAfMJmC6l1gWcrBXCnCloKNfeqj+7MiuD+/3VeZGwJH
 2OJUGvJRgscliho3MYKC2e9j2nWBIsFZfLQN+ZAxiur2kBG7/lolVoRL/y7axpBfTU
 ymXxYQ6/Z1FSTrTceIOxCqHmFxieGv4/F99PkJT9xgin18iknKayzt8QkPF1pO0A0H
 nhmDtLhNNJmqMKxat8sVKiQuG+UZU3uV+gMm5DILT2FCCT3m3OjgrU8mdQ1BtmlcpS
 4NB9JsOlum6vqCXmMzD1TTyg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/4] doc: describe return values of C tests
Date: Tue, 18 Nov 2025 21:17:33 +0100
Message-ID: <20251118201733.67297-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
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

* Enumerate return values of C tests
* Reference assertion macros

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/tests_writing.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index b6972489d4c..1a020caa411 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -228,6 +228,14 @@ Note that the MEM_TEST() macros is defined at the top of the file.
 
 Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
 
+* A successful test returns 0.
+* A skipped test returns -EAGAIN.
+* Any other value signals a failure.
+
+Include ``test/ut.h`` defines a number of macros to check values and to return
+from the test function if the assertion fails. See :doc:`../api/test`
+for details.
+
 [1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
 
 
-- 
2.51.0

