Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9EC369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBEF382AFB;
	Sun,  4 May 2025 15:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eDfdKpZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3599982AFB; Sun,  4 May 2025 15:24:40 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1668219D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so593231566b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365077; x=1746969877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ug/EPxSXnprwGiCwrivA8HXyYNMyx3ICcChYFxrHSL8=;
 b=eDfdKpZwswd2C0hYg70oNd4tUm0hOL+X8hmpAJYwDZ6SGlc5tHsg2ulKTnwXCrKkZW
 2KpU/Hd5VtvEA0Vhl1vBonX7PI6f+5s94hKjBRO/w+ucVItwyKKEhIVl1QD44C6aE097
 2khL61thNNtZXQ84N37iGfSMHzluBfHxebOGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365077; x=1746969877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ug/EPxSXnprwGiCwrivA8HXyYNMyx3ICcChYFxrHSL8=;
 b=hWbQ0yeWkeSS2IvRRRlXKt7cqaTwl8G2j+Cr7fUz+9jzaCWX8DJ86P5ke1VRxIJwlA
 uErkLqRn4ChxkISeLSIKWNuCYT4GVe+gbZvIIxbM2MwBr7wo5Ylc8d/65to7MynG4fAB
 SwjOh7vWMzKWLnvWedhE8gXIdlNu/iDQWj8E0sOBX/FMl5YT/McY+zDckZld/q9/H/p9
 cZ2nV99ENFsqvs0VKm6kLV8mvCzPk2q86ww1+LcmuePnThMrx9ogD1rC7sFjnsfyAj2x
 enI3WTWeyePIjpPEASlwdQRBnjCDugcO7PAXOnxU33vVst3Its2OwDeVtZ0DnKFLs9c8
 2b2A==
X-Gm-Message-State: AOJu0YzDrRpa9LOlS5JfpWE91WOWvKd4r/dNAMjXdprq4Ppa517n8Ywc
 xlpiYyWcemTZKT0u3mVR1cYFADy/p5GebJYcL//OfYU2oMctKm/Lcj3HOgvEWyffu1HatK16Ide
 crG6fDMA=
X-Gm-Gg: ASbGncsgHkdwbKKE4sXUL9gVzo7v1Op1QMUyRJr0zB3Mv5IW3+nje9XBtaurR7Nn7Dp
 uJ+UN1qVx1NjtSNUoT+qIhDR1b6o3DvaW0wZ2syuX3B/3QgfzesMqD1kEhPTEW7DZuV/fC4Sz7Q
 oEWe1nvaVrmyCGtWXzN0prKbTy0TKbtCj6+zxvZKcdgl8VVIJg2sNsOaDM0f36ntK/a87AiSyB/
 MjqkjjIKBknlEjQty09AgYq8NoiS15rgyf2Anmi+xBXsFem0P8wU6iYkJHI/m5FlA/523hy6qG5
 /G0pDotDZX7m57nJwCS5g0BDUusDaT4SjBYI
X-Google-Smtp-Source: AGHT+IEHa09Bt+yqv4K5XIEZ3TwzJ6vCRWIQw3Vthyo6ttZCkKUSSfWUR8vya0KY+0KhtRBhMIqxOQ==
X-Received: by 2002:a17:907:97c7:b0:aca:d52d:b59b with SMTP id
 a640c23a62f3a-ad19084ec5fmr520967266b.47.1746365076707; 
 Sun, 04 May 2025 06:24:36 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/30] patman: Rename check_patchwork_status()
Date: Sun,  4 May 2025 15:23:35 +0200
Message-ID: <20250504132356.2317305-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

This function actually shows the status and does some other things.

Rename it to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/control.py   |  4 ++--
 tools/patman/func_test.py | 14 +++++++-------
 tools/patman/status.py    |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index c33ca821aa6..06a9dfd2bca 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -99,8 +99,8 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
     # Import this here to avoid failing on other commands if the dependencies
     # are not present
     from patman import status
-    status.check_patchwork_status(series, found[0], branch, dest_branch, force,
-                                  show_comments, url)
+    status.check_and_show_status(series, found[0], branch, dest_branch, force,
+                                 show_comments, url)
 
 
 def do_patman(args):
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 50fb53787d8..31ba708ab87 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -1045,8 +1045,8 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         series = Series()
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
-        status.check_patchwork_status(series, '1234', None, None, False, False,
-                                      None, self._fake_patchwork2)
+        status.check_and_show_status(series, '1234', None, None, False, False,
+                                     None, self._fake_patchwork2)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
@@ -1159,9 +1159,9 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         # <unittest.result.TestResult run=8 errors=0 failures=0>
 
         terminal.set_print_test_mode()
-        status.check_patchwork_status(series, '1234', branch, dest_branch,
-                                      False, False, None, self._fake_patchwork3,
-                                      repo)
+        status.check_and_show_status(series, '1234', branch, dest_branch,
+                                     False, False, None, self._fake_patchwork3,
+                                     repo)
         lines = terminal.get_print_test_lines()
         self.assertEqual(12, len(lines))
         self.assertEqual(
@@ -1361,8 +1361,8 @@ Reviewed-by: %s
         series = Series()
         series.commits = [commit1, commit2]
         terminal.set_print_test_mode()
-        status.check_patchwork_status(series, '1234', None, None, False, True,
-                                      None, self._fake_patchwork2)
+        status.check_and_show_status(series, '1234', None, None, False, True,
+                                     None, self._fake_patchwork2)
         lines = iter(terminal.get_print_test_lines())
         col = terminal.Color()
         self.assertEqual(terminal.PrintLine('  1 Subject 1', col.BLUE),
diff --git a/tools/patman/status.py b/tools/patman/status.py
index 8edb4ced449..57786e496be 100644
--- a/tools/patman/status.py
+++ b/tools/patman/status.py
@@ -300,9 +300,9 @@ def create_branch(series, new_rtag_list, branch, dest_branch, overwrite,
             [parent.target])
     return num_added
 
-def check_patchwork_status(series, series_id, branch, dest_branch, force,
-                           show_comments, url, rest_api=call_rest_api,
-                           test_repo=None):
+def check_and_show_status(series, series_id, branch, dest_branch, force,
+                          show_comments, url, rest_api=call_rest_api,
+                          test_repo=None):
     """Check the status of a series on Patchwork
 
     This finds review tags and comments for a series in Patchwork, displaying
-- 
2.43.0

