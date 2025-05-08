Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44716C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAEF82AB1;
	Thu,  8 May 2025 09:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YPZcq4GL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1162482AA8; Thu,  8 May 2025 09:29:53 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0960082AA4
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-39c31e4c3e5so492215f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689390; x=1747294190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLvIuMAEripSDaD8qXHMt/ebMSsUz+M1tZRUSDXGmi8=;
 b=YPZcq4GL/maz0NnvsnyHYUR8rzanK1MBUor0nrMD90UW/XEv2h0a/H5RdsinSBt70D
 +/AsNqZln0kobvbMwf1vEN5vaRLqLJKrvtp24qLjwFgK9W5mQb60gFoxXeKqFc47B4M7
 qay0FvyWyMnNkbqspfvCuRzZ/0WPfFHOJek+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689390; x=1747294190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLvIuMAEripSDaD8qXHMt/ebMSsUz+M1tZRUSDXGmi8=;
 b=euoP7Vf7AmatSiP8MWsQLsrT7nl12JAPfkqlSnxxKYVgaSHiwxZKWwvBBs7okE/Pjk
 9YPzbWRLQT99dGymBQim9qSpJrERJnK1RHZdVNTyZTyXkt6Z980bMU4dx+C6e++trwxY
 HA6R1N69d782d3Gh/tAK7E6iWgmvv2CWMl09GIt2Moon+yJ+lAsISncvhdRAos3RbXxe
 2cE5J99HeD/QF3UC8K8q+sUWitM1eAGzaSor1wbZElH99gnZ+VSeG9spnS62rzMYqNRE
 9RbXYDlbIcRJB1imoe8ACCL+79pVpCs+zFcRT0LNv6IH+xyJRyatE4L5FZyrpXC3tiwW
 pWXQ==
X-Gm-Message-State: AOJu0YzorZDvAbO4RszaMjbc6qNd+38mA3ZzCELv4Nt+B1xu53o5thJ2
 D6qTyqvEshqAzUh7qOGV3qkryifQTJk8DKEzWfweqpRPec0PR0hmM5RqCf3eJ32TVSof5URxuAF
 K9rEdVHRkZm9U
X-Gm-Gg: ASbGnctT+kAg4HRnD4XYuugIGWQ/sVHkjdzit2a/pl5Bx1oNNlwbDb8XHT1vKtTQ6rP
 L6DIaivyzndDsLxl+7NxKe+bHvEUwVqRD7eExQ7fCjMp+XBb/pGbju9AzzunsRKo8R+Cwu+mXWf
 CmK6EIrhD3C63uXvsYtxFw2hcZ0fqy+6LI3qolsuq+9nZryDWJJvS8L5B5TnebC8kIB+3ZkOPOg
 y2opzy704xo2xqK5QLEksnuSGtvXQKDh1zJy2QcJnpoAIJxyO6ozPME6F2EMD2OIjK+ucnDlsoc
 Hhn4y6fHqhbwnAVnAIxu8fGAxX7mLNkxA3WCNg==
X-Google-Smtp-Source: AGHT+IHx68pfDDacAubINFWRxGyKSIqMISWmQTHeuV000KhYmR+SkYVyN6yoF6LtsLdZIbQHYHbe/g==
X-Received: by 2002:a05:6000:220d:b0:3a0:b8b9:6b2e with SMTP id
 ffacd0b85a97d-3a0b8b970d7mr2382260f8f.34.1746689389972; 
 Thu, 08 May 2025 00:29:49 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/20] patman: Support collecting all lines in the commit
 message
Date: Thu,  8 May 2025 09:28:44 +0200
Message-ID: <20250508072907.207175-21-sjg@chromium.org>
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

In some cases we want to collect all lines in the commit message so that
the commit can be recreated with the same message as before, or perhaps
with light filtering.

Add support for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchstream.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 5691ee4b3c1..45040877f8c 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -109,6 +109,8 @@ class PatchStream:
         self.recent_unquoted = queue.Queue()
         self.was_quoted = None
         self.insert_base_commit = insert_base_commit
+        self.lines = []                  # All lines in a commit message
+        self.msg = None                  # Full commit message including subject
 
     @staticmethod
     def process_text(text, is_comment=False):
@@ -190,11 +192,22 @@ class PatchStream:
         """
         self.commit.add_rtag(rtag_type, who)
 
-    def _close_commit(self):
-        """Save the current commit into our commit list, and reset our state"""
+    def _close_commit(self, skip_last_line):
+        """Save the current commit into our commit list, and reset our state
+
+        Args:
+            skip_last_line (bool): True to omit the final line of self.lines
+                when building the commit message. This is normally the blank
+                line between two commits, except at the end of the log, where
+                there is no blank line
+        """
         if self.commit and self.is_log:
+            # Skip the blank line before the subject
+            lines = self.lines[:-1] if skip_last_line else self.lines
+            self.commit.msg = '\n'.join(lines[1:]) + '\n'
             self.series.AddCommit(self.commit)
             self.commit = None
+            self.lines = []
         # If 'END' is missing in a 'Cover-letter' section, and that section
         # happens to show up at the very end of the commit message, this is
         # the chance for us to fix it up.
@@ -345,6 +358,8 @@ class PatchStream:
                 self.state += 1
         elif commit_match:
             self.state = STATE_MSG_HEADER
+        if self.state != STATE_MSG_HEADER:
+            self.lines.append(line)
 
         # If a tag is detected, or a new commit starts
         if series_tag_match or commit_tag_match or change_id_match or \
@@ -499,7 +514,7 @@ class PatchStream:
 
         # Detect the start of a new commit
         elif commit_match:
-            self._close_commit()
+            self._close_commit(True)
             self.commit = commit.Commit(commit_match.group(1))
 
         # Detect tags in the commit message
@@ -579,7 +594,7 @@ class PatchStream:
         """Close out processing of this patch stream"""
         self._finalise_snippet()
         self._finalise_change()
-        self._close_commit()
+        self._close_commit(False)
         if self.lines_after_test:
             self._add_warn('Found %d lines after TEST=' % self.lines_after_test)
 
-- 
2.43.0

