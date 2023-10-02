Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC39E784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 13:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC2787133;
	Mon,  2 Oct 2023 15:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=bitbiz.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E43887141; Mon,  2 Oct 2023 10:01:12 +0200 (CEST)
Received: from web01.gemnuservers.be (web01.gemnuservers.be [109.68.161.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F32A87134
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 10:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bitbiz.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lars@bitbiz.be
Received: from d5152ca9a.static.telenet.be ([81.82.202.154]
 helo=lars-ubuntu.telenet.be)
 by web01.gemnuservers.be with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <lars@bitbiz.be>) id 1qnDrU-0006tA-2y;
 Mon, 02 Oct 2023 10:01:04 +0200
From: Lars Feyaerts <lars@bitbiz.be>
To: u-boot@lists.denx.de
Cc: Lars Feyaerts <lars@bitbiz.be>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] checkpatch: skip fdtdec_* check for tools
Date: Mon,  2 Oct 2023 10:00:13 +0200
Message-Id: <20231002080014.1861669-1-lars@bitbiz.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: lars@bitbiz.be
X-Mailman-Approved-At: Mon, 02 Oct 2023 15:00:05 +0200
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

Have checkpatch.pl skip warnings for use of fdtdec_* functions in
ooling; livetree isn't used there.

Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
---

 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 62b764f6c38..488d73a0ed7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2606,8 +2606,8 @@ sub u_boot_line {
 		     "Possible new uclass - make sure to add a sandbox driver, plus a test in test/dm/<name>.c\n" . $herecurr);
 	}
 
-	# try to get people to use the livetree API
-	if ($line =~ /^\+.*fdtdec_/) {
+	# try to get people to use the livetree API, except when changing tooling
+	if ($line =~ /^\+.*fdtdec_/ && $realfile !~ /^tools\//) {
 		WARN("LIVETREE",
 		     "Use the livetree API (dev_read_...)\n" . $herecurr);
 	}
-- 
2.34.1

