Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB725C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63EB82AA3;
	Sat, 10 May 2025 13:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SvmPbGRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 631BB82AB2; Sat, 10 May 2025 13:06:23 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E92282B11
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac34257295dso485519366b.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875180; x=1747479980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xwlx/FKeCg0onm5HC+Nx1e7Rrt/HFY3L2+XeMqs0HiY=;
 b=SvmPbGRKWW4s3DUnjPbLRwLgITRkbMViHuGTto1gWSnkeI6V3/uSakqiU10XVsadtJ
 fD2bSWv5lA+TClJajqs5gNFjRzVDTh3ciVGrnmMbSlLgER2qAbTBgTGKHF94+Js9x935
 vMRDOcHfEM3oQA0AgQnpHJaF95T6wJgcPKF3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875180; x=1747479980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xwlx/FKeCg0onm5HC+Nx1e7Rrt/HFY3L2+XeMqs0HiY=;
 b=ItoVgChiTUEFuKzPY1R4Y7Yfjuevhd0PylZlDA3iMCv3IPQbww3uVktBqUy0XW7apG
 IwIJDfsZnYXmpvrYmg0ABO7irICqW9WFKnaMAy454lR7RnCrYDJ+a9yCCchcTjDQMQzm
 GRPg8Y3QoxUFaxs0N+OuuP/wlgt5XZeZM2fEWA/TCw1Xxl21TboMIzb2C37X+Mgft5aq
 sw7rj/mNAZMIW9MWdY/kxucl603FJl8YM8mvScHsrB7Ye5yVg97TBKE8gzXqqeK4NimP
 5ftAu/XG/zXcP3rdyKEILa5HYNH//rwmw+sbKdy8xLv2ATRhwfBkz4xrL6hTsSmL35VX
 Mgvw==
X-Gm-Message-State: AOJu0Yzy6cMJbYLxkHICMWBtdxfMqeEnkTS0lmGA59k45txWemVB5rb5
 m2aCj8Z1Et9VcmhrlpM5PXQd0xogobz8FToNHKk8yZht5UBJ6CmGmg7fEMisEbzYxp36WflXguz
 KZD73L/aYHQ==
X-Gm-Gg: ASbGncuuNQzhLemfxZnIlB8457BGpHb+pe08E31tR9LzyH5GKShVp4dGC0evyZVdZmc
 ijCjna4jxDaNeRvAfHENV/Ha33XUahn6fWZ9uIk9ciLVwgQXjnPek/m9tg6NOebnmiXvBy8Q7ss
 Yytiou1mMaz39EcqZIsLsHM0FOLp9Zq7PBbCN9ZUjL4WtX2g2tVvkjDHTjCKWNjIbKXN0xKZcdb
 oMnCJqJ0P0wQT40UJJwdIcmJ7LEUGfkZIPF8DFB0Ye0DisrY9Ppfqk6YwTietQGe8PER35nMIeL
 PWNN5pIPXvR3rhshp1Hc/pjwTot+9Y+PQf+wZLke59vZPzQ=
X-Google-Smtp-Source: AGHT+IEcs+2hREz2y2XTOYXJNk1WMNDyqGf4p66byWW1s0dclrDieAp081ZqaM/eChWknQgqtL1dpQ==
X-Received: by 2002:a17:906:794c:b0:ac7:b8d0:86c0 with SMTP id
 a640c23a62f3a-ad218e88df2mr654127266b.9.1746875179980; 
 Sat, 10 May 2025 04:06:19 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/25] patman: Improve Series support for patchwork links
Date: Sat, 10 May 2025 13:05:11 +0200
Message-ID: <20250510110535.1453745-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Update Series with a way to better manage the Series-links lines in
patches. Use this in the 'status' subcommand instead of the existing
primitive method of expecting a link without a version prefix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py | 25 ++++++++++++-------
 tools/patman/series.py  | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index 7bf0e7ff61a..ec94b23421c 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -20,8 +20,11 @@ except ImportError:
 from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
+from u_boot_pylib import tout
+from patman import cseries
+from patman import cser_helper
 from patman import patchstream
-from patman import patchwork
+from patman.patchwork import Patchwork
 from patman import send
 from patman import settings
 
@@ -70,9 +73,11 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     Raises:
         ValueError: if the branch has no Series-link value
     """
+    if not branch:
+        branch = gitutil.get_branch()
     if count == -1:
         # Work out how many patches to send if we can
-        count = (gitutil.count_commits_to_branch(branch) - start)
+        count = gitutil.count_commits_to_branch(branch) - start
 
     series = patchstream.get_metadata(branch, start, count - end)
     warnings = 0
@@ -89,21 +94,23 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     if not links:
         raise ValueError("Branch has no Series-links value")
 
-    # Find the link without a version number (we don't support versions yet)
-    found = [link for link in links.split() if not ':' in link]
-    if not found:
-        raise ValueError('Series-links has no current version (without :)')
+    _, version = cser_helper.split_name_version(branch)
+    link = series.get_link_for_version(version, links)
+    if not link:
+        raise ValueError('Series-links has no link for v{version}')
+    tout.debug(f"Link '{link}")
 
     # Allow the series to override the URL
     if 'patchwork_url' in series:
         url = series.patchwork_url
-    pwork = patchwork.Patchwork(url, single_thread=single_thread)
+    pwork = Patchwork(url, single_thread=single_thread)
 
     # Import this here to avoid failing on other commands if the dependencies
     # are not present
     from patman import status
-    status.check_and_show_status(series, found[0], branch, dest_branch, force,
-                                 show_comments, pwork)
+    pwork = Patchwork(url)
+    status.check_and_show_status(series, link, branch, dest_branch, force,
+                                 show_comments, False, pwork)
 
 
 def do_patman(args):
diff --git a/tools/patman/series.py b/tools/patman/series.py
index 3d48836e90a..ad61bbfa399 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -430,3 +430,58 @@ class Series(dict):
         if self.get('postfix'):
            postfix = ' %s' % self['postfix']
         return '%s%sPATCH%s%s' % (git_prefix, prefix, postfix, version)
+
+    def get_links(self, links_str=None, cur_version=None):
+        """Look up the patchwork links for each version
+
+        Args:
+            links_str (str): Links string to parse, or None to use self.links
+            cur_version (int): Default version to assume for un-versioned links,
+                or None to use self.version
+
+        Return:
+            dict:
+                key (int): Version number
+                value (str): Link string
+        """
+        if links_str is None:
+            links_str = self.links if 'links' in self else ''
+        if cur_version is None:
+            cur_version = int(self.version) if 'version' in self else 1
+        assert isinstance(cur_version, int)
+        links = {}
+        for item in links_str.split():
+            if ':' in item:
+                version, link = item.split(':')
+                links[int(version)] = link
+            else:
+                links[cur_version] = item
+        return links
+
+    def build_links(self, links):
+        """Build a string containing the links
+
+        Args:
+            links (dict):
+                key (int): Version number
+                value (str): Link string
+
+        Return:
+            str: Link string, e.g. '2:4433 1:2872'
+        """
+        out = ''
+        for vers in sorted(links.keys(), reverse=True):
+            out += f' {vers}:{links[vers]}'
+        return out[1:]
+
+    def get_link_for_version(self, find_vers, links_str=None):
+        """Look up the patchwork link for a particular version
+
+        Args:
+            find_vers (int): Version to find
+            links_str (str): Links string to parse, or None to use self.links
+
+        Return:
+            str: Series-links entry for that version, or None if not found
+        """
+        return self.get_links(links_str).get(find_vers)
-- 
2.43.0

