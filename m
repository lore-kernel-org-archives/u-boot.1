Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578A3CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 15:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B887B83071;
	Mon, 29 Sep 2025 17:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Cta/E4ZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839088329F; Mon, 29 Sep 2025 17:13:12 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498AC82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 17:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CBB764E40DEC;
 Mon, 29 Sep 2025 15:13:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8B163606AE;
 Mon, 29 Sep 2025 15:13:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84D0E102F16F4; 
 Mon, 29 Sep 2025 17:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759158788; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=yQM39gYkfqQoLLd29DS3pKKPI8kwV9AUKgXPfsry93c=;
 b=Cta/E4ZDs+clBloAhZhhejzUHmjNM+PS9oOUH9P9V3OmNt8a8jhJADgAXNoa85wEICN27j
 9o8MrwEXTaHmzHQViHvPYcJL3+Mcj00rwQPF1gTcEuxaHgU8jclDsNjMApcnljJHHa58sE
 q7lJmheC0eayoF24ZMrevEzCLhLzAmnXpIbc6HooI9Ast/xHdsxqBqGUJjAuki65jQ3hA7
 wWoxgVFWHDii6gbPDZsJLAbRRCenPsZ9piwEgQBzrdn2wPzt6x1RKOTTnKQhI1qfJ6pghr
 B+nb5B5M1jOIdxSUjAvxCXt0xDpU0uOoLRtIVFWusb5GJYZNEY/sq0M7tZnzxg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Sagar Patel <sagarmp@cs.unc.edu>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Hendrik Donner <hd@os-cillation.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] checkpatch: use python3 to find codespell dictionary
Date: Mon, 29 Sep 2025 17:12:51 +0200
Message-ID: <20250929151252.1005683-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Sagar Patel <sagarmp@cs.unc.edu>

Import Linux patch to locate codespell dictionary:
https://lore.kernel.org/lkml/20220309180048.147672-1-sagarmp@cs.unc.edu/

codespell requires Python 3.6 or above, but on some systems, the python
executable is a Python 2.7 interpreter.  In this case, searching for the
dictionary fails, subsequently making codespell fail:

  No codespell typos will be found - file '/usr/share/codespell/dictionary.txt': No such file or directory

So, use python3 to remove ambiguity.

In addition, when searching for dictionary.txt, do not check if the
codespell executable exists since,

 - checkpatch.pl only uses dictionary.txt, not the codespell
   executable.

 - codespell can be installed via a Python package manager, in which
   case the codespell executable may not be present in a typical $PATH,
   but a dictionary does exist.

Signed-off-by: Sagar Patel <sagarmp@cs.unc.edu>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 763287e02b1..b0ee126bd89 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -337,7 +337,7 @@ if ($user_codespellfile) {
 } elsif (!(-f $codespellfile)) {
 	# If /usr/share/codespell/dictionary.txt is not present, try to find it
 	# under codespell's install directory: <codespell_root>/data/dictionary.txt
-	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
+	if (($codespell || $help) && which("python3") ne "") {
 		my $python_codespell_dict = << "EOF";
 
 import os.path as op
@@ -347,7 +347,7 @@ codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
 print(codespell_file, end='')
 EOF
 
-		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
+		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
 		$codespellfile = $codespell_dict if (-f $codespell_dict);
 	}
 }
-- 
2.43.0

