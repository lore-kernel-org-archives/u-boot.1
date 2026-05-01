Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06CBCCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5C880F0E;
	Fri,  1 May 2026 14:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eMt9z3/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E4B839D5; Fri,  1 May 2026 08:09:43 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA90803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 08:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f69.google.com (unknown [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94EEC3FCFC
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777615192;
 bh=vQrE8AynQ+lTEKI73hKiO2rDE0WillVbWGhlnIL6GTc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eMt9z3/bGM1WuUrgrHYI7ediGrOtLrTbDtKL1sPOzoIxmKPxnIIkELblY0Fm7he5D
 Cf7JQPSewePGQ8wedRVydy/3PfjoPkdciGiYUZrQAwe/30PgumA4KPwLZJnMnKg34a
 0FYiva5e293bYIII4YQXZXkZB2hAUixVOYhPI8knremVf5oBVh54kIhzx39brWsa07
 bykMHFFkKKjHVwbVt/qVQbI5kMpKqp2BZBZ4axBvhljW3n1k6kCmhL+exeJtwrFnI9
 8xXPPoLOFJdenoqkjYaADPPFoKteaq7/KMfGW96Esut7AGBM8KpsFNFRj7QLxeWnT4
 RDIMStL6OCrfR5G8cSyCugRW9/20ap87O87AgszUG1eTk/YpZhRR2Y8AuRRVp9Nebg
 SZh+AB15d9E8VcscwAWBiKEfK5SbOr//a5MtTGWCkI+EKMuahxi4bUBl1OI7Ykx8F6
 nr70XrOgmsKljip9m+X8hVWtbsoeVwr6lG9s0QBf8AZujFWvSQv7s0gz9o1EFePAxy
 P2v+wKVIRfY/ZcUFaumB/F7wRCkeMQIu0c9d/hgtNJJ8SbpVDvWpNKpocorDkgQw6h
 UUT+OAkhhCF76/HpAw/209gdIizj3N/8NHGNcmJDQdgU5uYFo08MW+mmqHjKYgh7Fn
 dwNCNGZVYAyprkeNPnZfkilY=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-364f007d1f3so215357a91.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 22:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777614709; x=1778219509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQrE8AynQ+lTEKI73hKiO2rDE0WillVbWGhlnIL6GTc=;
 b=SlUwAvUTqmMRw9KqzXYLuQiF1Lb3/pwipEGQ2AtrNfq+iLwdaVEbeGIRfzcfAgIQrE
 nAcgA16TYdrp8yRug2aDdHs0vPvCHlEZQIOZ23JP11o96nenvJwpB2nsX8pCnS07ulR1
 CmNQ0K2r/kjdWVtOZX53zY/XnUDuduFS555rxyv0ej9ATei6g87Mv+vVcDh2JCUXIUSl
 GgkLZl2Err6Vj5eZkcWrTknSNS6l2jd1y1kN1WhPPiC7G7zaGhcL4ZT2Hj0mCg9v5dfr
 HVbUfGiFXc98t00xcPaHbSiiX/NCIAmXxHOQD4uvPyMLtByEs6mPwbzB0qbaKLWURgsF
 TTzw==
X-Gm-Message-State: AOJu0YyFxwopVf2aKW+wducxQsUi9b4QgPQEL34yvXWwOfzl8JAkV6lY
 KqLh7sjQwEYBCgtgtFdve75+os5PRnE68HHVdmzJ0uKl6Y5WJv/pHfxoeoSVFiDCV6EoYqr91mB
 fV7IPlwOuC4A6FECJysoYppDqIftAlidojvcY80SXL5ZQZ2RNnw5kPqT/0ehTEBPqf9lp1/bkMd
 9GHBg=
X-Gm-Gg: AeBDietpLXp3YNmmFPdt73nnvmDOtqBw0W3yBlderAhQIhdZt+kl8uCSqXAPvSKKlJ3
 KmqBFEquyyju51/h3BjuclwsA2zfXKqRvNa7wonskIfJt6TmvwnZSkNitMkG3bUQr+7e6x5Bh5x
 sJmAvlWNkARb8iEFFs6neUkHUzp7c6FEqjhbJ6HXv/QUdYsN1mH9cUO7Ne5MuW8y+JcjM3xkjzN
 hYpO3b4Aqni0NjomHMtI9WVNsAhN1vTQq3SxbQXEnb+qsN88gBTjxEZacpt8Vl9hQTURl9PlzXB
 vyu5nDeHZlu/jj4rd62qnPjyj/kyy6ipuyNNq4nzg20936uQtZpEQlcr/zzbkmpdJ5ND/TmuIpv
 3U/wouzz2mJ8U1mDBzlgWrPN7Iax3nSCr/pq0C+e9TshQiqjpB2qkFjVAIU6EdGYpGYztvwLR04
 Pv1XLou4Be8VQk4F+JRKAem5DSkQ==
X-Received: by 2002:a17:90b:4e8b:b0:35c:195e:112f with SMTP id
 98e67ed59e1d1-364c49ff8f4mr5466381a91.18.1777614708687; 
 Thu, 30 Apr 2026 22:51:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8b:b0:35c:195e:112f with SMTP id
 98e67ed59e1d1-364c49ff8f4mr5466359a91.18.1777614708323; 
 Thu, 30 Apr 2026 22:51:48 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf2aa41sm6174538a91.4.2026.04.30.22.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 22:51:47 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/1] test: fit: Use shared make_fname from fit_util
Date: Fri,  1 May 2026 05:51:04 +0000
Message-ID: <20260501055112.3966757-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420074827.3917463-1-aristo.chen@canonical.com>
References: <20260420074827.3917463-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 May 2026 14:38:15 +0200
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

test_fit.py declares a local make_fname closure that is byte-identical
to fit_util.make_fname. Drop the local copy and call the shared helper
at all seven call sites so there is one definition to maintain.

No behavioural change. Both implementations return
os.path.join(ubman.config.build_dir, basename).

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index bcaaa6a5fc4..4f56a1421e1 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -140,18 +140,6 @@ class TestFitImage:
       - run code coverage to make sure we are testing all the code
     """
 
-    def make_fname(self, ubman, leaf):
-        """Make a temporary filename
-
-        Args:
-            ubman (ConsoleBase): U-Boot fixture
-            leaf (str): Leaf name of file to create (within temporary directory)
-
-        Return:
-            str: Temporary filename
-        """
-        return os.path.join(ubman.config.build_dir, leaf)
-
     def filesize(self, fname):
         """Get the size of a file
 
@@ -181,7 +169,7 @@ class TestFitImage:
         Returns:
             str: Filename of ramdisk created
         """
-        fname = self.make_fname(ubman, filename)
+        fname = fit_util.make_fname(ubman, filename)
         data = ''
         for i in range(100):
             data += f'{text} {i} was seldom used in the middle ages\n'
@@ -278,33 +266,33 @@ class TestFitImage:
             'fit_addr' : 0x1000,
 
             'kernel' : kernel,
-            'kernel_out' : self.make_fname(ubman, 'kernel-out.bin'),
+            'kernel_out' : fit_util.make_fname(ubman, 'kernel-out.bin'),
             'kernel_addr' : 0x40000,
             'kernel_size' : self.filesize(kernel),
             'kernel_config' : 'kernel = "kernel-1";',
 
             'fdt_data' : fdt_data,
-            'fdt' : self.make_fname(ubman, 'u-boot.dtb'),
-            'fdt_out' : self.make_fname(ubman, 'fdt-out.dtb'),
+            'fdt' : fit_util.make_fname(ubman, 'u-boot.dtb'),
+            'fdt_out' : fit_util.make_fname(ubman, 'fdt-out.dtb'),
             'fdt_addr' : 0x80000,
             'fdt_size' : self.filesize(fdt_data),
             'fdt_load' : '',
 
             'ramdisk' : ramdisk,
-            'ramdisk_out' : self.make_fname(ubman, 'ramdisk-out.bin'),
+            'ramdisk_out' : fit_util.make_fname(ubman, 'ramdisk-out.bin'),
             'ramdisk_addr' : 0xc0000,
             'ramdisk_size' : self.filesize(ramdisk),
             'ramdisk_load' : '',
             'ramdisk_config' : '',
 
             'loadables1' : loadables1,
-            'loadables1_out' : self.make_fname(ubman, 'loadables1-out.bin'),
+            'loadables1_out' : fit_util.make_fname(ubman, 'loadables1-out.bin'),
             'loadables1_addr' : 0x100000,
             'loadables1_size' : self.filesize(loadables1),
             'loadables1_load' : '',
 
             'loadables2' : loadables2,
-            'loadables2_out' : self.make_fname(ubman, 'loadables2-out.bin'),
+            'loadables2_out' : fit_util.make_fname(ubman, 'loadables2-out.bin'),
             'loadables2_addr' : 0x140000,
             'loadables2_size' : self.filesize(loadables2),
             'loadables2_load' : '',
-- 
2.43.0

