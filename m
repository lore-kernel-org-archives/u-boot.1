Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72CAC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 21:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F408801C;
	Tue, 27 Feb 2024 22:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N7MGteNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE8E88019; Tue, 27 Feb 2024 22:51:45 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79A288031
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 22:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0D4CE3F3C0; 
 Tue, 27 Feb 2024 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709070701;
 bh=yB+NngQuV2OKZJoFZIDyZ+Qtwoovv8S5JGMHcC6GB9w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=N7MGteNB85YsvzgKRA3tXeYwFid8Wx6TPULWYgI4MYFNhjtnzWwuWxKH5dQriM/E4
 BrO9oFjfg342fsergVbv1X3M3cdZ1T4vKTFQwFUUBp/4JdACsJJcIzQVoO4nvHSTY8
 Hj1Mo2vIqEqC/4dpojhEg4zcGj306J2aLkAygP6Di/eQI5Gm8o8OeAxqzaBqmY8iN3
 e1U1n4SDVXXawGo3speyLobSPeJx8yUPzWVVezHDN2FU7iAkGd27z7LsY2ZWW+PbY7
 gxiydBZnfepMIV76+/Du0ZjKTv9r40CAuzKWnCCScYudT327IzPGvZg3n7juI/NzoE
 ++wUdmOGr2Auw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] pylibfdt: fix invalid escape sequence '\w'
Date: Tue, 27 Feb 2024 22:52:04 +0100
Message-ID: <20240227215204.236447-1-heinrich.schuchardt@canonical.com>
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

\w is not allowed as escape sequence is strings.
Mark the regular expression with r''.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/dtc/pylibfdt/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
index 8baae08770..c6fe5a6a44 100755
--- a/scripts/dtc/pylibfdt/setup.py
+++ b/scripts/dtc/pylibfdt/setup.py
@@ -37,7 +37,7 @@ with open(os.path.join(srcdir, "../README"), "r") as fh:
     long_description = fh.read()
 
 # Decodes a Makefile assignment line into key and value (and plus for +=)
-RE_KEY_VALUE = re.compile('(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
+RE_KEY_VALUE = re.compile(r'(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
 
 def get_top_builddir():
     if '--top-builddir' in sys.argv:
-- 
2.43.0

