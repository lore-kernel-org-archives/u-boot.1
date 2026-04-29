Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B35FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF428487C;
	Wed, 29 Apr 2026 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="D2fFp8oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E093D84870; Wed, 29 Apr 2026 14:20:28 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D393B84843
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20260429122026361167e08b00020727 for <u-boot@lists.denx.de>;
 Wed, 29 Apr 2026 14:20:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=l905t0UfPiEsnu3IBZnQAL88Iyf7yDpeGLlcwssw+i4=;
 b=D2fFp8ojDzB5bVdlJftjvyBO3DmeE3yE8ijwLldcXm0cPnES3XW0wys9K4qgluXA31fZjM
 6cwIYZejk2CIvGwmR90DGDXDpxcK0dOeNCFJhdozGhiLWTz2dECHPRJwrgyWjySMSQYQbUWW
 zav/rIGpf5FhyJ5imSEk4qyAd5a1QFwMyewO2LOHdKgtIkdTP9ZKoIbn/ZxRHEsZPOhhBrX2
 ToxIe5o1VmBB60cD/y906WfErUkG/wjoSqjvNtlfKenyDg02xV9vFBYyF9C05+xh/XoRB16E
 eakwQH7/yuCA6ecW2PZhfSs91+hhZhlbZMpQTVjdk6xL+gfIXZiUKn1Q==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] patman: fix use in worktree
Date: Wed, 29 Apr 2026 14:18:51 +0200
Message-ID: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

When using a worktree '.git' actually is a file and pygit2
init_repository() does not like that. The intention is not to create
a new git repo anyway so use normal constructor instead of
init_repository().

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 tools/patman/cser_helper.py | 4 ++--
 tools/patman/cseries.py     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
index 2841fcd9c20..81ad212daee 100644
--- a/tools/patman/cser_helper.py
+++ b/tools/patman/cser_helper.py
@@ -309,7 +309,7 @@ class CseriesHelper:
         self._copy_db_fields_to(series, ser)
         msg = None
         if end:
-            repo = pygit2.init_repository(self.gitdir)
+            repo = pygit2.Repository(self.gitdir)
             target = repo.revparse_single(end)
             first_line = target.message.splitlines()[0]
             msg = f'Ending before {oid(target.id)} {first_line}'
@@ -725,7 +725,7 @@ class CseriesHelper:
             raise ValueError(
                 f"Modified files exist: use 'git status' to check: "
                 f'{dirty[:5]}')
-        repo = pygit2.init_repository(self.gitdir)
+        repo = pygit2.Repository(self.gitdir)
 
         commit = None
         upstream_name = None
diff --git a/tools/patman/cseries.py b/tools/patman/cseries.py
index bcbc4963cea..0844b5f0257 100644
--- a/tools/patman/cseries.py
+++ b/tools/patman/cseries.py
@@ -119,7 +119,7 @@ class Cseries(cser_helper.CseriesHelper):
 
         new_max = max_vers - 1
 
-        repo = pygit2.init_repository(self.gitdir)
+        repo = pygit2.Repository(self.gitdir)
         if not dry_run:
             name = self._get_branch_name(ser.name, new_max)
             branch = repo.lookup_branch(name)
@@ -859,7 +859,7 @@ class Cseries(cser_helper.CseriesHelper):
             tag_info[svi.version] = [svi.idnum, name, f'{name}-{now_str}']
 
         # Create the tags
-        repo = pygit2.init_repository(self.gitdir)
+        repo = pygit2.Repository(self.gitdir)
         for _, (idnum, name, tag_name) in tag_info.items():
             commit = repo.revparse_single(name)
             repo.create_tag(tag_name, commit.hex,
@@ -896,7 +896,7 @@ class Cseries(cser_helper.CseriesHelper):
         svlist = self.db.ser_ver_get_for_series(ser.idnum)
 
         # Collect the tags
-        repo = pygit2.init_repository(self.gitdir)
+        repo = pygit2.Repository(self.gitdir)
         tag_info = {}
         for svi in svlist:
             name = self._get_branch_name(ser.name, svi.version)
-- 
2.43.0

base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
branch: patman
