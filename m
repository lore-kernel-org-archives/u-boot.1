Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BC2C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F76782A4B;
	Tue, 29 Apr 2025 15:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IYTNoaIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F06828C2; Tue, 29 Apr 2025 15:24:50 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C812482145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c14235af3so3891671a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933086; x=1746537886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE+m0K1KHPKRh7K5dkIl3/6MGbMorDLdFvcDr+jQkkA=;
 b=IYTNoaIlW/y/rQMnsKBp8VN4INBcDy4xN3xQ6IyyXnxY9J7udWm5JwUstfIVAHMnn2
 XpPjU+xU77vF6y6nOuzXU21TF5E8mcJsQbmX7SjuAuvVW68f02CLCLQh+ma6rtxE+zlQ
 2Bye/pPwxAtOIsXwJYXa2FhOtfciHTN2ZEXRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933086; x=1746537886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dE+m0K1KHPKRh7K5dkIl3/6MGbMorDLdFvcDr+jQkkA=;
 b=mm32cW3E2kNOzP+VpxnEUrH0rKnl00OiPgv5zWqm3t3f5PJIGY2hQ9dpRslMqcGUH2
 sXZa89DQdQuhYyW+ZQIi2ScbOCw2fDDfOTF/dLXAcWoAnQ0xyFhpNWCugzl2u7GDNQ8t
 89bLmgfExvI+K/bVaCfJWOw9TUOyJk5F6HirE725jTvte0rjHK73qP7p3cJOUPVyDJwA
 6fFrT45AxUOiz4hxRiDzOI4HcpKWR88DmRI8UXCbB3Nq8JxyK97Z8YPpO8CeOS8D1dRJ
 ooyPqDY4F7Ufi+aKfdZa/6p+l2T9V8ro3QsmdlnR33W3UAvibPdu3CzT22FP2hI/1fFM
 e1mw==
X-Gm-Message-State: AOJu0Yxtec2QqiCTXLN3v2ed4P9a8bnFt/mxEZ6Ap0/xCD8GCX8ZeNlB
 f37Jx8uiohpcINvK0XWMrdPPGNZLO+Srh2Ui2FroTzHGhclX9kyI1aT++xTkeIovmO1wGDWzFBE
 =
X-Gm-Gg: ASbGncsdqzGqLRhwxA2U3S4Go36FIxiaDZcvy8UObp+kT05WJkOzMqEb9c84hyRYuVY
 akrRAC1Ac8EfgnsXUvWD3Yyk7qZWMNgyyrzLUZEikNPjqxERCroraJNmkzF/KKTw4VUTkluyvuC
 oKoPhPR5kMQU2scSHafDqA2vNvZ3+I2DT+TluL/PYsiax6iGagJ7EV9Z68d4LXgxgKYIQn/KiPW
 ZyirBdKEMGrS3cd/Edibiod6BwtDczpsilzCdNhILo/q9GuAkUbpMwM3xb/R3/1HjeDj/wIJBd7
 aLqdd0akGE4blhO0wuRkm1OuHnskIp4gWZMs+DtHdkkLXAwDuLUPw71/7Fy9501ic4AOH0AAoQC
 jLQ==
X-Google-Smtp-Source: AGHT+IFIccXT57Cq+7AgGolvgHXR0bKQFnn7ph6B59I53WCexrUjoCOxYsmwIUBRlIOw59O/k8Ikdg==
X-Received: by 2002:a05:6830:258e:b0:72b:8326:f0c7 with SMTP id
 46e09a7af769-730652485a2mr8542667a34.28.1745933085863; 
 Tue, 29 Apr 2025 06:24:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/30] patman: Adjust how the fake request() function is
 provided
Date: Tue, 29 Apr 2025 07:22:19 -0600
Message-ID: <20250429132239.251756-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Instead of passing the URL and function to each call, put the fake
into the Patchwork object instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py   |  4 ++-
 tools/patman/func_test.py | 41 +++++++++++++--------------
 tools/patman/patchwork.py | 26 ++++++++++++++++++
 tools/patman/status.py    | 58 ++++++++++-----------------------------
 4 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index 06a9dfd2bca..cb8552ed550 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -24,6 +24,7 @@ from u_boot_pylib import terminal
 from u_boot_pylib import tools
 from patman import checkpatch
 from patman import patchstream
+from patman import patchwork
 from patman import send
 
 
@@ -95,12 +96,13 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     # Allow the series to override the URL
     if 'patchwork_url' in series:
         url = series.patchwork_url
+    pwork = patchwork.Patchwork(url)
 
     # Import this here to avoid failing on other commands if the dependencies
     # are not present
     from patman import status
     status.check_and_show_status(series, found[0], branch, dest_branch, force,
-                                 show_comments, url)
+                                 show_comments, pwork)
 
 
 def do_patman(args):
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index ea96c508fa2..9c5e7d7dd51 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -6,6 +6,7 @@
 
 """Functional tests for checking that patman behaves correctly"""
 
+import asyncio
 import contextlib
 import os
 import pathlib
@@ -767,14 +768,13 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
             os.chdir(orig_dir)
 
     @staticmethod
-    def _fake_patchwork(url, subpath):
+    def _fake_patchwork(subpath):
         """Fake Patchwork server for the function below
 
         This handles accessing a series, providing a list consisting of a
         single patch
 
         Args:
-            url (str): URL of patchwork server
             subpath (str): URL subpath to use
         """
         re_series = re.match(r'series/(\d*)/$', subpath)
@@ -787,21 +787,17 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
 
     def test_status_mismatch(self):
         """Test Patchwork patches not matching the series"""
-        series = Series()
-
+        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
         with terminal.capture() as (_, err):
-            patches = status.collect_patches(1234, None, self._fake_patchwork)
+            patches = status.collect_patches(1234, pwork)
             status.check_patch_count(0, len(patches))
         self.assertIn('Warning: Patchwork reports 1 patches, series has 0',
                       err.getvalue())
 
     def test_status_read_patch(self):
         """Test handling a single patch in Patchwork"""
-        series = Series()
-        series.commits = [Commit('abcd')]
-
-        patches = status.collect_patches(1234, None,
-                                         self._fake_patchwork)
+        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork)
+        patches = status.collect_patches(1234, pwork)
         self.assertEqual(1, len(patches))
         patch = patches[0]
         self.assertEqual('1', patch.id)
@@ -944,14 +940,13 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
                           "Cannot find commit for patch 3 ('Subject 2')"],
                          warnings)
 
-    def _fake_patchwork2(self, url, subpath):
+    def _fake_patchwork2(self, subpath):
         """Fake Patchwork server for the function below
 
         This handles accessing series, patches and comments, providing the data
         in self.patches to the caller
 
         Args:
-            url (str): URL of patchwork server
             subpath (str): URL subpath to use
         """
         re_series = re.match(r'series/(\d*)/$', subpath)
@@ -1007,13 +1002,14 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         review_list = [None, None]
 
         # Check that the tags are picked up on the first patch
+        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
         status.find_new_responses(new_rtag_list, review_list, 0, commit1,
-                                  patch1, None, self._fake_patchwork2)
+                                  patch1, pwork)
         self.assertEqual(new_rtag_list[0], {'Reviewed-by': {self.joe}})
 
         # Now the second patch
         status.find_new_responses(new_rtag_list, review_list, 1, commit2,
-                                  patch2, None, self._fake_patchwork2)
+                                  patch2, pwork)
         self.assertEqual(new_rtag_list[1], {
             'Reviewed-by': {self.mary, self.fred},
             'Tested-by': {self.leb}})
@@ -1023,7 +1019,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         new_rtag_list = [None] * count
         commit1.rtags = {'Reviewed-by': {self.joe}}
         status.find_new_responses(new_rtag_list, review_list, 0, commit1,
-                                  patch1, None, self._fake_patchwork2)
+                                  patch1, pwork)
         self.assertEqual(new_rtag_list[0], {})
 
         # For the second commit, add Ed and Fred, so only Mary should be left
@@ -1031,7 +1027,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
             'Tested-by': {self.leb},
             'Reviewed-by': {self.fred}}
         status.find_new_responses(new_rtag_list, review_list, 1, commit2,
-                                  patch2, None, self._fake_patchwork2)
+                                  patch2, pwork)
         self.assertEqual(new_rtag_list[1], {'Reviewed-by': {self.mary}})
 
         # Check that the output patches expectations:
@@ -1046,8 +1042,9 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         series = Series()
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
+        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
         status.check_and_show_status(series, '1234', None, None, False, False,
-                                     None, self._fake_patchwork2)
+                                     pwork)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
@@ -1082,14 +1079,13 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
             '1 new response available in patchwork (use -d to write them to a new branch)',
             None), next(lines))
 
-    def _fake_patchwork3(self, url, subpath):
+    def _fake_patchwork3(self, subpath):
         """Fake Patchwork server for the function below
 
         This handles accessing series, patches and comments, providing the data
         in self.patches to the caller
 
         Args:
-            url (str): URL of patchwork server
             subpath (str): URL subpath to use
         """
         re_series = re.match(r'series/(\d*)/$', subpath)
@@ -1160,9 +1156,9 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         # <unittest.result.TestResult run=8 errors=0 failures=0>
 
         terminal.set_print_test_mode()
+        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork3)
         status.check_and_show_status(series, '1234', branch, dest_branch,
-                                     False, False, None, self._fake_patchwork3,
-                                     repo)
+                                     False, False, pwork, repo)
         lines = terminal.get_print_test_lines()
         self.assertEqual(12, len(lines))
         self.assertEqual(
@@ -1362,8 +1358,9 @@ Reviewed-by: %s
         series = Series()
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
+        pwork = patchwork.Patchwork.for_testing(self._fake_patchwork2)
         status.check_and_show_status(series, '1234', None, None, False, True,
-                                     None, self._fake_patchwork2)
+                                     pwork)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index e0adbdb6481..3ec266f073e 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -139,6 +139,7 @@ class Patchwork:
                'https://patchwork.ozlabs.org'
         """
         self.url = url
+        self.fake_request = None
         self.proj_id = None
         self.link_name = None
         self._show_progress = show_progress
@@ -160,6 +161,8 @@ class Patchwork:
         """
         # print('subpath', subpath)
         self.request_count += 1
+        if self.fake_request:
+            return self.fake_request(subpath)
 
         full_url = f'{self.url}/api/1.2/{subpath}'
         async with self.semaphore:
@@ -178,6 +181,29 @@ class Patchwork:
                     if i == RETRIES:
                         raise
 
+    async def session_request(self, subpath):
+        async with aiohttp.ClientSession() as client:
+            return await self._request(client, subpath)
+
+    def request(self, subpath):
+        return asyncio.run(self.session_request(subpath))
+
+    @staticmethod
+    def for_testing(func):
+        """Get an instance to use for testing
+
+        Args:
+            func (function): Function to call to handle requests. The function
+                is passed a URL and is expected to return a dict with the
+                resulting data
+
+        Returns:
+            Patchwork: testing instance
+        """
+        pwork = Patchwork(None, show_progress=False)
+        pwork.fake_request = func
+        return pwork
+
     async def get_series(self, client, link):
         """Read information about a series
 
diff --git a/tools/patman/status.py b/tools/patman/status.py
index ed4cca6f724..5c75d7b10c6 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -134,26 +134,7 @@ def compare_with_series(series, patches):
 
     return patch_for_commit, commit_for_patch, warnings
 
-def call_rest_api(url, subpath):
-    """Call the patchwork API and return the result as JSON
-
-    Args:
-        url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
-        subpath (str): URL subpath to use
-
-    Returns:
-        dict: Json result
-
-    Raises:
-        ValueError: the URL could not be read
-    """
-    full_url = '%s/api/1.2/%s' % (url, subpath)
-    response = requests.get(full_url)
-    if response.status_code != 200:
-        raise ValueError("Could not read URL '%s'" % full_url)
-    return response.json()
-
-def collect_patches(series_id, url, rest_api=call_rest_api):
+def collect_patches(series_id, pwork):
     """Collect patch information about a series from patchwork
 
     Uses the Patchwork REST API to collect information provided by patchwork
@@ -161,9 +142,7 @@ def collect_patches(series_id, url, rest_api=call_rest_api):
 
     Args:
         series_id (str): Patch series ID number
-        url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
-        rest_api (function): API function to call to access Patchwork, for
-            testing
+        pwork (Patchwork): Patchwork object to use for reading
 
     Returns:
         list of Patch: List of patches sorted by sequence number
@@ -172,7 +151,7 @@ def collect_patches(series_id, url, rest_api=call_rest_api):
         ValueError: if the URL could not be read or the web page does not follow
             the expected structure
     """
-    data = rest_api(url, 'series/%s/' % series_id)
+    data = pwork.request('series/%s/' % series_id)
 
     # Get all the rows, which are patches
     patch_dict = data['patches']
@@ -193,8 +172,7 @@ def collect_patches(series_id, url, rest_api=call_rest_api):
     patches = sorted(patches, key=lambda x: x.seq)
     return patches
 
-def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, url,
-                       rest_api=call_rest_api):
+def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, pwork):
     """Find new rtags collected by patchwork that we don't know about
 
     This is designed to be run in parallel, once for each commit/patch
@@ -211,16 +189,14 @@ def find_new_responses(new_rtag_list, review_list, seq, cmt, patch, url,
         seq (int): Position in new_rtag_list to update
         cmt (Commit): Commit object for this commit
         patch (Patch): Corresponding Patch object for this patch
-        url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
-        rest_api (function): API function to call to access Patchwork, for
-            testing
+        pwork (Patchwork): Patchwork object to use for reading
     """
     if not patch:
         return
 
     # Get the content for the patch email itself as well as all comments
-    data = rest_api(url, 'patches/%s/' % patch.id)
-    comment_data = rest_api(url, 'patches/%s/comments/' % patch.id)
+    data = pwork.request('patches/%s/' % patch.id)
+    comment_data = pwork.request('patches/%s/comments/' % patch.id)
 
     new_rtags, reviews = process_reviews(data['content'], comment_data,
                                          cmt.rtags)
@@ -316,7 +292,7 @@ def create_branch(series, new_rtag_list, branch, dest_branch, overwrite,
             [parent.target])
     return num_added
 
-def check_status(series, series_id, url, rest_api=call_rest_api):
+def check_status(series, series_id, pwork):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
@@ -325,9 +301,7 @@ def check_status(series, series_id, url, rest_api=call_rest_api):
     Args:
         series (Series): Series object for the existing branch
         series_id (str): Patch series ID number
-        url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
-        rest_api (function): API function to call to access Patchwork, for
-            testing
+        pwork (Patchwork): Patchwork object to use for reading
 
     Return:
         tuple:
@@ -342,7 +316,7 @@ def check_status(series, series_id, url, rest_api=call_rest_api):
             list for each patch, each a:
                 list of Review objects for the patch
     """
-    patches = collect_patches(series_id, url, rest_api)
+    patches = collect_patches(series_id, pwork)
     count = len(series.commits)
     new_rtag_list = [None] * count
     review_list = [None] * count
@@ -356,8 +330,7 @@ def check_status(series, series_id, url, rest_api=call_rest_api):
     with concurrent.futures.ThreadPoolExecutor(max_workers=16) as executor:
         futures = executor.map(
             find_new_responses, repeat(new_rtag_list), repeat(review_list),
-            range(count), series.commits, patch_list, repeat(url),
-            repeat(rest_api))
+            range(count), series.commits, patch_list, repeat(pwork))
     for fresponse in futures:
         if fresponse:
             raise fresponse.exception()
@@ -445,8 +418,7 @@ def show_status(series, branch, dest_branch, force, patches, patch_for_commit,
 
 
 def check_and_show_status(series, link, branch, dest_branch, force,
-                          show_comments, url, rest_api=call_rest_api,
-                          test_repo=None):
+                          show_comments, pwork, test_repo=None):
     """Read the series status from patchwork and show it to the user
 
     Args:
@@ -456,12 +428,10 @@ def check_and_show_status(series, link, branch, dest_branch, force,
         dest_branch (str): Name of new branch to create, or None
         force (bool): True to force overwriting dest_branch if it exists
         show_comments (bool): True to show patch comments
-        url (str): URL of patchwork server, e.g. 'https://patchwork.ozlabs.org'
-        rest_api (function): API function to call to access Patchwork, for
-            testing
+        pwork (Patchwork): Patchwork object to use for reading
         test_repo (pygit2.Repository): Repo to use (use None unless testing)
     """
     patches, patch_for_commit, new_rtag_list, review_list = check_status(
-        series, link, url, rest_api)
+        series, link, pwork)
     show_status(series, branch, dest_branch, force, patches, patch_for_commit,
                 show_comments, new_rtag_list, review_list, test_repo)
-- 
2.43.0

