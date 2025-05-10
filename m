Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C7C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1A082A25;
	Sat, 10 May 2025 13:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I1F6HYcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4EE829CD; Sat, 10 May 2025 13:05:56 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CBE8070C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so527781466b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875154; x=1747479954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGw7ckad1lodLX1xNVmlapSHfnxwb5XYiQpVm9aQ+ow=;
 b=I1F6HYcfk4Oc3Opl3ywDSkKo6GDU6TnSxUrCsoWaLRG9nL1sTx14ERKWd4w3eQB+gr
 jGP5BYP8MfnA3FDsnmkv4rs9wg140y87y9Qat2SJtGeRI4GYx2aNa9HE0abgdtTr0BnZ
 tHg3PzXYhkgRGFqYTus4RFFuJIkkq4BRomx6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875154; x=1747479954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGw7ckad1lodLX1xNVmlapSHfnxwb5XYiQpVm9aQ+ow=;
 b=oAblVfjGL8F56GFHh3jpmylCEKFnAObCOYlFuMjzIMNxCrnP6RxSmEBNSrhXLc7iIu
 UfA65b6RZyHHHpeOfX5NVVCmS7Pr14ozklqd8Fo9FSgu/r29cGWrk1HKsqJ68u3qVrQg
 YiogFiUePbxGoRtEERg+uIaOIu2kgH4R1wvAfEQWPRCglQDD/nB2SXanRc+uoc1I2+wu
 MyITYRNsJaZS0yRWCUF0MxLt9QsenA2kU8S6/PfsOmoD9GCNx5iMI/g4/tddqQARz43D
 Pv7ZXZUo0ileA9BZ7YlodR97ggmWpjUUPaYGg9IJR0cmfJJx1TIsHJmdVTQhhPsiuxqT
 u2HA==
X-Gm-Message-State: AOJu0Ywk7GWSPkmB4p9ewVJN3IOvKz2cctKMwDzYszkQ01WBemeXl3uJ
 eusF+OgZmslqaF+u8qq69/FzmPYedXZkBSiW1zxrbRd91SdHs0gP0n6o6ZBFvux+GFi9rbPpjGc
 P9NFIZlFvEQ==
X-Gm-Gg: ASbGncsKdpIJBqMxA+FIEwG26cY2JnCNXtHUvF8wOnYCw9JeXLvp/xbjyGpvLlZKM4p
 kq4Rz6CggQHRC50ZJAW3mug/AV1wvBnlD/xN1nhhgVdVCdmqYOrgN6AHHDDkrsRX1aMz4xEv10N
 qmDLMIYb660b0fuEO4AqXWP9gk8ngvOf1gYUZVoCYhc3m2c0sW3WPtLC1hi4qCOrV/EM6mPORSl
 4ntnW33ogs/DkCVnyS3U6iXjxaKnnSznjXImBgav2GUgGPIDZwFxNLLs13OOg03r38ukHhZ02F5
 f9Bm5uS4JUO8YAdhB35kZdAF8uX6w6ZTdV+9UrtmLvBHEf8=
X-Google-Smtp-Source: AGHT+IGXwPlWzkITzeWup9KjM3EqQ7ekKCpV3aiugIYF6EJ1r9/h+i0mK8fyIcXGEXkDecsNBZla8Q==
X-Received: by 2002:a17:907:7f9e:b0:ad2:411b:589e with SMTP id
 a640c23a62f3a-ad2411b5dbbmr65255466b.43.1746875153916; 
 Sat, 10 May 2025 04:05:53 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/25] u_boot_pylib: Add more functions to gitutil
Date: Sat, 10 May 2025 13:04:56 +0200
Message-ID: <20250510110535.1453745-4-sjg@chromium.org>
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

Add functions for checking a branch, showing a commit, etc. to support
the new functionality.

Git version 2.34.1 ignores --stat if --quiet is given, so adjust the
args so that this performs as expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/gitutil.py | 96 +++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 7d001d03bed..34b4dbb4839 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -784,6 +784,102 @@ def check_dirty(git_dir=None, work_tree=None):
     return command.output(*cmd).splitlines()
 
 
+def check_branch(name, git_dir=None):
+    """Check if a branch exists
+
+    Args:
+        name (str): Name of the branch to check
+        git_dir (str): Path to git repository (None to use default)
+    """
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['branch', '--list', name]
+
+    # This produces '  <name>' or '* <name>'
+    out = command.output(*cmd).rstrip()
+    return out[2:] == name
+
+
+def rename_branch(old_name, name, git_dir=None):
+    """Check if a branch exists
+
+    Args:
+        old_name (str): Name of the branch to rename
+        name (str): New name for the branch
+        git_dir (str): Path to git repository (None to use default)
+
+    Return:
+        str: Output from command
+    """
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['branch', '--move', old_name, name]
+
+    # This produces '  <name>' or '* <name>'
+    return command.output(*cmd).rstrip()
+
+
+def get_commit_message(commit, git_dir=None):
+    """Gets the commit message for a commit
+
+    Args:
+        commit (str): commit to check
+        git_dir (str): Path to git repository (None to use default)
+
+    Return:
+        list of str: Lines from the commit message
+    """
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['show', '--quiet', commit]
+
+    out = command.output(*cmd)
+    # the header is followed by a blank line
+    lines = out.splitlines()
+    empty = lines.index('')
+    msg = lines[empty + 1:]
+    unindented = [line[4:] for line in msg]
+
+    return unindented
+
+
+def show_commit(commit, msg=True, diffstat=False, patch=False, colour=True,
+                git_dir=None):
+    """Runs 'git show' and returns the output
+
+    Args:
+        commit (str): commit to check
+        msg (bool): Show the commit message
+        diffstat (bool): True to include the diffstat
+        patch (bool): True to include the patch
+        colour (bool): True to force use of colour
+        git_dir (str): Path to git repository (None to use default)
+
+    Return:
+        list of str: Lines from the commit message
+    """
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['show']
+    if colour:
+        cmd.append('--color')
+    if not msg:
+        cmd.append('--oneline')
+    if diffstat:
+        cmd.append('--stat')
+    else:
+        cmd.append('--quiet')
+    if patch:
+        cmd.append('--patch')
+    cmd.append(commit)
+
+    return command.output(*cmd)
+
+
 if __name__ == "__main__":
     import doctest
 
-- 
2.43.0

