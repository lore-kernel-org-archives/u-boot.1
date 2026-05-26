Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6D3CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 08:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F38847B0;
	Tue, 26 May 2026 10:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T0VQFacD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967788484F; Tue, 26 May 2026 09:03:56 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A0C84702
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B74473F56B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779779033;
 bh=qM+8/qgHKOYDZ9FN2NItO9HPufYkvFTDwMEzdVzrX+8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=T0VQFacDgAiLWSqRKQ0rdbPXnX1tyXLklpozOVBMx/ZxDRmMvq0w65o1w0zTDjayP
 IAo0oQUPu1KW+BNDxNLEvw0fg061IL147TWWvcYzgKfvhhGKV5jjbXtcn72KqY/sa4
 Pjc9FnZ91w56+d7QVuvyp3KUrUBu+aoEjOSdZL77tc7DDwI1Lqt8Fcou0+tp61Hj2i
 bQ6j5HUkv03zEJcpQ8wciR5XvANbq+0J8AROTrOiU0xz7zrhx25uAyKemAjZY4ZPMi
 5GXVedld5Poih5Pcb4aNb8gtSv3ZR1JqYlwQ1TkFOJtQdg6ZUYld2g3/D4MoUiKaL8
 QrKZ6/qxlBd7JQYdqn1Xe8OjWcj6dy5rJ4pfuhPj2jUwnQ0Eo+SsG2j+lNynYMLauj
 vaUyurInVy5zvYXm3Y5fsTt3g3J2WE3MAgJIP5sLbwg5/wq1XfVtAjOw5tLyah+bRg
 A+oi/j9IjBT+T+FpShNYVH4iI8FJteMUPksMlXg93BwR73RAI1NaQaWNsXADCu/yo9
 Qxim91Pfs8X8Z+QNONOw3knaho612j9f3Yn1rk1jp51dBJVp1LfWtQafGV0N1f1Yvb
 tOFp7a94KVPRKcFn/Od6elKPpSvbpTS1jOKWI5cBYkkrj4IG9t3BSEqnUqf2wJClzO
 905ljQgQ688/dKNy5FhUTrPE=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba6fe41283so110517075ad.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779032; x=1780383832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qM+8/qgHKOYDZ9FN2NItO9HPufYkvFTDwMEzdVzrX+8=;
 b=lD3Fbfb5MKSX4JPNY37DCaQIJfb5ROY1lIWIxRePTx0P4FEJ3KgfttTfNr534BaL1R
 rhUNveGYumORY76hfA8e4EdjtfaA6bR4SQUpQNeJkU6kW/vxGE202MxTCUk/1Gr0ssLs
 3iMuqGHWtOrtg2b8NxmTnJeWn92XH53YebdOQtz9wpMqwKvkkpEzq7hWYPKXNKMu0hJK
 e7/z6lbZoDU4xzSvsHfZ6tPuyL288zUtebEPaW4pMMFV8rYxLl7AfxJ8YhxcRPZwQA5F
 FKXBmHJ+G59nfH8mcfaN0ziO4IbbV7aIAJM23DUHJSewky/LEfW/t4oSRtUI+7uC66gw
 LoiQ==
X-Gm-Message-State: AOJu0Yw/GyQuHeC900PxeTOgWIVNOLYVqEYLaWr2wew//IQtqMzRk3NF
 pH75bceitrqHhTbKAK1DOwG5h+VzwCpdVm/5fBSwSnXT0SZ1+eZYOhkFlKkpwhsv5mWitjpSicQ
 v8OuTIElvrKU412vtueabTCawLKNL6tovPRZQHHt//ssrHKjL0f6JudS/vo0qqtq8pqcqjHrYmu
 iB79Re1nc9
X-Gm-Gg: Acq92OGcR76UqvVGOQmVdyno9C2RilqVvg5JqaKtVvDN8MTIqutzbIE4zpXZ8fyRR9t
 daH2hRCzVvitLrM5PHMduuK6kj5iQLU+zRTGdQhUGv3ecX91lCN7wwyLBSd58kNh+7Rpi7MxzHc
 yPJLW9ZsxjZBVd0hIbsRWigrKBaF2mwcH0nfXl2MnUKln80xIz2MWskqsa/qPC6OGuk56VGnufn
 th7fq2xvCl2Rqu8CuUS5AKikp3dRl7f+D8ple34tONmikv+Qlb/cvx+QBWYqR4KqwHcN8fs4eZD
 4agr14FaUO90c8XtP+44q8KV0lfEmYUmNbeHDwp+2kweEud874T2yG3qIjUkKMmUXAScyqGGNxi
 X7KkNz0meBNvXZmmaXl+TxASstzcP+MLSs23ICfFaFRVq4z5pGB4UQr/4BpsYNbp9yxSQZncryk
 +6Lhwr9oFER16n2OT6j9XTLEpazw==
X-Received: by 2002:a17:903:24c:b0:2bc:9f51:2922 with SMTP id
 d9443c01a7336-2beb06c45e1mr178934525ad.41.1779779032309; 
 Tue, 26 May 2026 00:03:52 -0700 (PDT)
X-Received: by 2002:a17:903:24c:b0:2bc:9f51:2922 with SMTP id
 d9443c01a7336-2beb06c45e1mr178934175ad.41.1779779031919; 
 Tue, 26 May 2026 00:03:51 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm117133795ad.21.2026.05.26.00.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 00:03:51 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] test/py: cover get_basename crash on paths with dotted
 directories
Date: Tue, 26 May 2026 07:03:33 +0000
Message-ID: <20260526070336.23199-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526070336.23199-1-aristo.chen@canonical.com>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <20260526070336.23199-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 10:34:48 +0200
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

Add a parametrized regression test for the fix in the previous commit.
The test invokes mkimage in auto-FIT mode (-f auto) with a -b argument
whose directory component contains a '.' and whose leaf either lacks an
extension or is a plain identifier. Before the fix these inputs caused
get_basename() to compute a negative length and segfault inside memcpy.
The test asserts that mkimage exits successfully and that the fdt
sub-image description matches the expected stripped basename, covering
"./mydt", "./sub.d/leaf", and "./a.b/c". A control input of "./mydt.dtb"
is also exercised to confirm normal extension stripping still works.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_mkimage_validate.py | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index 170b2a8cbbb..5922f071dd8 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -7,6 +7,7 @@ import os
 import subprocess
 import pytest
 import fit_util
+import utils
 import re
 
 @pytest.mark.boardspec('sandbox')
@@ -103,3 +104,59 @@ def test_fit_invalid_default_config(ubman):
 
     assert result.returncode != 0, "mkimage should fail due to missing default config"
     assert re.search(r"Default configuration '.*' not found under /configurations", result.stderr)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.parametrize('dtb_relpath,expected_desc', [
+    # Crash triggers: last '.' precedes last '/', or leaf has no extension.
+    ('./mydt',       'mydt'),
+    ('./sub.d/leaf', 'leaf'),
+    ('./a.b/c',      'c'),
+    # Control case: extension lives in the leaf, no dotted directory.
+    ('./mydt.dtb',   'mydt'),
+])
+def test_fit_auto_basename_dotted_directory(ubman, dtb_relpath, expected_desc):
+    """Regression test: mkimage -f auto must not crash when a -b path has a
+    '.' in its directory portion.
+
+    Before the fix, get_basename() in tools/fit_image.c searched the whole
+    path for both the last '/' and the last '.'. When the '.' fell before
+    the '/', the computed length went negative and was passed unchanged to
+    memcpy(), which segfaulted. This test exercises three crashing paths
+    plus one control input.
+    """
+    build_dir = ubman.config.build_dir
+    kernel = fit_util.make_kernel(ubman, 'kernel.bin', 'kernel')
+    itb_fname = fit_util.make_fname(ubman, 'auto_basename.itb')
+
+    # Materialize the dtb at the requested relative path inside build_dir.
+    dtb_abs = os.path.join(build_dir, dtb_relpath)
+    os.makedirs(os.path.dirname(dtb_abs), exist_ok=True)
+    with open(dtb_abs, 'wb') as f:
+        f.write(b'dummy')
+
+    cmd = ['./tools/mkimage', '-f', 'auto',
+           '-A', 'arm', '-O', 'linux', '-T', 'kernel', '-C', 'none',
+           '-a', '0x80000000', '-e', '0x80000000', '-n', 'test',
+           '-d', kernel,
+           '-b', dtb_relpath,
+           itb_fname]
+    # Run with cwd=build_dir so both ./tools/mkimage and the relative -b
+    # path resolve the same way the bug originally reproduced.
+    result = subprocess.run(cmd, capture_output=True, text=True,
+                            cwd=build_dir)
+
+    assert result.returncode == 0, (
+        f"mkimage crashed or failed on -b {dtb_relpath!r}: "
+        f"rc={result.returncode}\nstdout:\n{result.stdout}\n"
+        f"stderr:\n{result.stderr}"
+    )
+    # The fdt sub-image description is set from get_basename(). Read it back
+    # from the produced FIT (a device tree) rather than parsing mkimage's
+    # console output.
+    desc = utils.run_and_log(
+        ubman, ['fdtget', itb_fname, '/images/fdt-1', 'description']).strip()
+    assert desc == expected_desc, (
+        f"Expected /images/fdt-1 description {expected_desc!r}, got {desc!r}"
+    )
-- 
2.43.0

