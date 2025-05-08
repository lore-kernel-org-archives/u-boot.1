Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E20C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9318283E;
	Thu,  8 May 2025 09:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KKo/9lUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB6D82A5E; Thu,  8 May 2025 09:29:38 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249598283E
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so312114f8f.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689375; x=1747294175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5j+Pif9yjbTLRLFrQNVbCeXeH6fv2uLQ30QyuQFYxU8=;
 b=KKo/9lUcuKr4YVqICqqc8gegrAfLWYsH1nNgHGiDxBGXxeWhpn66rdp2Hl3QqW3UpE
 78iLuEMdAADqSCfEcxIXGMH5BFZYF7n4XExQxEu20f9KKAUJs2d9T7u1KDH9yLVX82Eq
 TG7ztFD2F/nhTAF6d4lDo7kbOH9ijo68XMoaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689375; x=1747294175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5j+Pif9yjbTLRLFrQNVbCeXeH6fv2uLQ30QyuQFYxU8=;
 b=DTQJ9BUXhGSrwnmqKtGA4zSPGdc0AOPxEXjqytgPhdWF2bnXK/VjA+UloMXX8UPKxG
 jc70cPvuH7l8MZgobj7e9tLMUM8c3agbinEHXsatAV/XNkFFSwUa/I8PrwP0yXJu25WR
 yi9HyYC47nVyDhzGZQyhYtPQCjj8rRuC74uRXgYXuhKu+TEKzUir/Gf7+l3yjmfakg05
 CZn2Ql1oDFlA0GLaIboRRtbOH2qLNc8EaV1pHhlX4H5XBoRepH3iQe+p/U2452wa2Z7M
 xG8TxrBHyaYdeETJyVaANI7cJGywr8VHktKksRuisqigNStvAZhOMI+l1Hh3i60mPOBi
 pyMg==
X-Gm-Message-State: AOJu0YyFC+dZx2RnJSmK214/gIdRItMw4fjcR8U1y0dXhm/1K3+Vn1nO
 U19VMTOCtKWqz8FaV6wQKhHEU2n4s/gg5HQPn3c1fMIDbs1hmV8K3ugLgF/SpX5tl6FiP0v2ffE
 dPnloUsm3KQ==
X-Gm-Gg: ASbGncs+S+wHQH0mjle486fx6VUGsAJNJTaicq/FB1NHNiD8jdJJj5SuGz2xt+3JO3P
 Liw7tWznSK9jvNmV2G0btOn2NU9Z2NfTaEkT+FbxfP2FvJQABapE3WWHufgaQP8NRi80gDBYKgI
 WUpuMeUHD8o4ohU9hxnVaKCnEkNxWHC4g82NScPVqWFwq6gX1EjJwXxPH6yDcuNyIW+C2EKdMbD
 Wm97oZ3fMAVG5zlPJ/HbPii+jKUQBQEbRd9Sxhk8zlURXo+7sIzUi6YmVuBmvU8VbgAsIO4oKMo
 WEr+zS8rFgzLWt2c05R/w0byQCX2vrV5Vks+09dHS9juAg2d
X-Google-Smtp-Source: AGHT+IHOTP03yu3xfDKdPuRBr48LUz0tqr70FmPqwErt0wXgptxxjx1oMvBSEfHlpzbEE9xAPla+4g==
X-Received: by 2002:a05:6000:290c:b0:39f:f4a:e852 with SMTP id
 ffacd0b85a97d-3a0b4a4678emr5834502f8f.55.1746689375143; 
 Thu, 08 May 2025 00:29:35 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/20] patman: Clean up creation of the git tree
Date: Thu,  8 May 2025 09:28:35 +0200
Message-ID: <20250508072907.207175-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

The test starts with the HEAD pointing to the wrong place, so that the
created files appear to be deleted. Fix this by resetting the tree
before tests start. Add a check that the tree is clean.

Update pygit2 so that the enums are available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py     |  9 ++++++++-
 tools/patman/requirements.txt |  2 +-
 tools/u_boot_pylib/gitutil.py | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 9c7d5d8c381..61df82312ba 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -503,7 +503,7 @@ better than before''')
         target = repo.revparse_single('HEAD~2')
         # pylint doesn't seem to find this
         # pylint: disable=E1101
-        repo.reset(target.oid, pygit2.GIT_CHECKOUT_FORCE)
+        repo.reset(target.oid, pygit2.enums.ResetMode.HARD)
         self.make_commit_with_file('video: Some video improvements', '''
 Fix up the video so that
 it looks more purple. Purple is
@@ -543,6 +543,13 @@ complicated as possible''')
         repo.config.set_multivar('branch.second.merge', '', 'refs/heads/base')
 
         repo.branches.local.create('base', base_target)
+
+        target = repo.lookup_reference('refs/heads/first')
+        repo.checkout(target, strategy=pygit2.GIT_CHECKOUT_FORCE)
+        target = repo.revparse_single('HEAD')
+        repo.reset(target.oid, pygit2.enums.ResetMode.HARD)
+
+        self.assertFalse(gitutil.check_dirty(self.gitdir, self.tmpdir))
         return repo
 
     def test_branch(self):
diff --git a/tools/patman/requirements.txt b/tools/patman/requirements.txt
index 57a284d23f2..ce9a3854527 100644
--- a/tools/patman/requirements.txt
+++ b/tools/patman/requirements.txt
@@ -1,6 +1,6 @@
 aiohttp==3.9.1
 ConfigParser==7.1.0
 importlib_resources==6.5.2
-pygit2==1.13.3
+pygit2==1.14.1
 Requests==2.32.3
 setuptools==75.8.0
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index cc57e7b7f73..3c52cce232c 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -757,6 +757,24 @@ def get_branch(git_dir=None):
     return out
 
 
+def check_dirty(git_dir=None, work_tree=None):
+    """Check if the tree is dirty
+
+    Args:
+        git_dir (str): Path to git repository (None to use default)
+
+    Return:
+        str: List of dirty filenames and state
+    """
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    if work_tree:
+        cmd += ['--work-tree', work_tree]
+    cmd += ['status', '--porcelain', '--untracked-files=no']
+    return command.output(*cmd).splitlines()
+
+
 if __name__ == "__main__":
     import doctest
 
-- 
2.43.0

