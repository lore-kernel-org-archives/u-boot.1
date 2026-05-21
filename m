Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E25DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB7A2846CF;
	Thu, 21 May 2026 07:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fCMLHFb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB0284659; Thu, 21 May 2026 04:35:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA22846CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 04:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1BDB83F785
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 02:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779330925;
 bh=kUEae4v7YSv8GzlNdaZTr9cwN//HM5uLITbar6KNgx8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fCMLHFb2s8UbKvveVjZXjsRKXw78QT5VZLPsnkloW8d/Vm6VKptRw/L0spjAzNBER
 adUUYxYrp/R1+BqqTFKqAsBE5RRccETse0OJWeaM1cLQUdlx+gWxtZjhYxY4jkxO+9
 /Tp/rPbfyGAaeaU0UsLw7sejCNWn44K5WkfqMKwFUchtlnwbbbgNgKn9AuWC5GWul/
 8L9BVq/Z9cEZcjQ+yV5GxENOYS1d3GQUdNumJzMr5uzVFhwxP2iBnGkha4/m3TrdSW
 fAEeAxrKnBOBqFNfuFw7e4VxidUt8J9GPyQ/8+UwSo7n/0O8Daynb9OqA2/uxiPPPF
 bYMDXHcUtbcNsOvePwL+4vkS/iwUfCieBSMA9OQmVAPERoUxqhw0PZbBFsR8cKrkDy
 XjMAFWQQGA8ngCQ0tlBpbK4moAE4cVgKdSv7u92pPnYL/HB2ANC1ot1YxKvBX/i7Li
 AmoKlEXRWq+metMNmXIhezixJK0OVPLx9sJP9cbYJbM2fPkJTZXSHgiq2tWDRUaR2Z
 PBVVwCooAyK3iyW/7OiCdB4wXgb3TnmpOnZvrRafcVxzcixkskAngk6OLMRMihhjMC
 krw9d9dsWvH6hzkVfs4S2zQ5or6Nh8+ohu9OK2ZrKKmrtI9QbfstxE6S1wSH3oDZfn
 Qcl7RuVRIFx3Xs/3HI5pr3GE=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-368f2d76b04so5143777a91.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 19:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779330924; x=1779935724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kUEae4v7YSv8GzlNdaZTr9cwN//HM5uLITbar6KNgx8=;
 b=SHBY7Nbsc5Qu1VUmVeD8/HngVZAHA/PlbbNnqmcdjF1z0lnBlYv+4SvCVwqhCSSk5Y
 6ASktW6xtyjKnWtnbvSgRd01DcXcESbtHj8XinCIcb55ERoT3P4cufxhWgUPmSj7q2u4
 8ZY2KP0JJuV0l0QP2bqHP00E4VHg1ZFlfIT/8ngJ1bV1NURMCsKRMUp7R9D1GTGtl3UU
 0+9nWGatrjbMxEr96PAp2KzoUPqU/U8ydWsE0AYbjeZR5OGan0coz7tkvzJc26OfrNyV
 wP0I1cBFnwAVwk+dBr+DLQP9ycavD8E8w4Z+KMA3FsCI25JwHW1iO8AXuCjQnJ9RGICt
 LWqg==
X-Gm-Message-State: AOJu0YzodWUNGUlRP6WNDhNDBMK3Y536mwLprXhfO1cHwzMHEEYJmbY1
 B4+3L5AdKOKkXWIpSzLVReDID3ZP9Uz1cVkKSVZ9cs5lT4y+SnBfYYyh1VX2erCsXnvTmlivOfz
 OSvy7cBtTGXF0t/lUOaR6OF60HN1wRGGWD5jybtLDx8vNbXgIDaPyhvhgQyAQF0NoMwJ/hbhXf8
 pL2iJzxw==
X-Gm-Gg: Acq92OE1NRRMdhtTWX2AvnhijvuggbWOyAGajs7QuSHaZZ+fymPMfQ9WTQJAKjYn0Pt
 pia0x9lnr7Pmq/pfERtqdn0HJD75k693PXXTduas/o1+77Kjw0mrFkQ+h5kBw6au0CwQgpkXKZ2
 adCoLstL+38eA2C4N3LXJmb75WwOlSBoIVDCT6pW93p2W5iU5AgiUW5nFk/JjfMS3KzV6SV1XeO
 Iu2sJ0BVovxpdkMBOPTKYPcqajlPmScwKnKMczgkdgJUzIB9BEFvYlct3L7WNMoig8WW0UcSg7v
 pxG7MIrGt0LMc+sAaem2Ib4IQux+AOq0qp3wcphNw1ektwusVQjetKw1yfH4IJ4OLgzbrY3ZTes
 bcMnSVUOijso/d/qWvm6uu4sjA0IzEh4TdC0Az5nspHkD4zpxksZkQArE/09uRRErEP3yZFP3Nt
 HCROGzVJU2YUM2BBk=
X-Received: by 2002:a17:90b:5245:b0:369:a359:b181 with SMTP id
 98e67ed59e1d1-36a4562f4famr871510a91.23.1779330923729; 
 Wed, 20 May 2026 19:35:23 -0700 (PDT)
X-Received: by 2002:a17:90b:5245:b0:369:a359:b181 with SMTP id
 98e67ed59e1d1-36a4562f4famr871505a91.23.1779330923399; 
 Wed, 20 May 2026 19:35:23 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb3aedfsm958899a91.4.2026.05.20.19.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 19:35:22 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] test/py: cover get_basename crash on paths with dotted
 directories
Date: Thu, 21 May 2026 02:35:00 +0000
Message-ID: <20260521023503.29315-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521023503.29315-1-aristo.chen@canonical.com>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:44 +0200
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
 test/py/tests/test_fit_mkimage_validate.py | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index 170b2a8cbbb..0a1cc5963a6 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -103,3 +103,58 @@ def test_fit_invalid_default_config(ubman):
 
     assert result.returncode != 0, "mkimage should fail due to missing default config"
     assert re.search(r"Default configuration '.*' not found under /configurations", result.stderr)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
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
+    mkimage = os.path.join(build_dir, 'tools/mkimage')
+    cmd = [mkimage, '-f', 'auto',
+           '-A', 'arm', '-O', 'linux', '-T', 'kernel', '-C', 'none',
+           '-a', '0x80000000', '-e', '0x80000000', '-n', 'test',
+           '-d', kernel,
+           '-b', dtb_relpath,
+           itb_fname]
+    # Run with cwd=build_dir so the relative path resolves the same way
+    # the bug originally reproduced.
+    result = subprocess.run(cmd, capture_output=True, text=True,
+                            cwd=build_dir)
+
+    assert result.returncode == 0, (
+        f"mkimage crashed or failed on -b {dtb_relpath!r}: "
+        f"rc={result.returncode}\nstdout:\n{result.stdout}\n"
+        f"stderr:\n{result.stderr}"
+    )
+    # The fdt sub-image description is set from get_basename(); confirm it
+    # matches the expected stripped basename.
+    assert re.search(rf"Image 1 \(fdt-1\)\s+Description:\s+{re.escape(expected_desc)}\b",
+                     result.stdout), (
+        f"Expected fdt-1 description {expected_desc!r} in mkimage output, "
+        f"got:\n{result.stdout}"
+    )
-- 
2.43.0

