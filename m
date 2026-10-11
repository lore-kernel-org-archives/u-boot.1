Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93242CA9ED0
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6C1A80C38;
	Sun, 11 Oct 2026 17:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iJzt-ptkrla8; Sun, 11 Oct 2026 17:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8B6C808AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739387;
	b=RoXATQ7lpZEUzos/1RzPTh0aKtiT9R6SiHy9JIpyqOn+3f0qFWxmoTbmA2Q/y8VTFK/r
	 1BGbXC6pF8M+mWHgr6JWy4RpqbyMLD8uebHHPJ0UyojaJuSxztwczlyAPbA+6jcoagDVG
	 CqfQnI5v6eU3wYIxoSri0ufI2HFUpqSTe53AhUZLL7EhVymkHWu7ZP2T3B1g2RIIyt+EY
	 BQOgf2iho0a5skxvi2gKrYAps0A4ZqSyeiKt/mm3DzT2SkKZcbO+C8p9Axo0cMjWPW41U
	 OA+xrxdF5FAxURpQROsGR+CunnkXXjPez0YpixoO0Epid6OlcTXzoIE7tHQPsPIP+Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VmQyurKU8RYn2VjmCd34E411nbk9nfhrIbxHbki1qCI=;
	b=HcNCu8yCGuxj8/rvb0JprsmlykMFRro6etYDdOe4/WfjIGiCNkk2YCPhaUW73FI9c0mR
	 n2sVv2X/28P88+QznpQm6BdL2mN3Fv4O8fp1SWmFyFNodfi7zEgEEh0uirRd6y25Lnnm5
	 muPvQhQ3WgscW4AjZ+dXjBnh0C4tQ3yJRTlOE/rLhmLAjBHF+02mfIPwG1UqfupMIlCb+
	 bj64KzbfWVWkpuXXElkEwDcKv5sPt4MAFLhOOD9P8MbXAsElmroTtQFX9o7k3U4U+VEoA
	 pmLDThzFPl0tpoy0mSXIz1sYUw1CQ1ajn5ZG44afSycSC1L6SPHm7XtbUiOlpoe/uSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739387;
	bh=VmQyurKU8RYn2VjmCd34E411nbk9nfhrIbxHbki1qCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vdr0HN8XAcuchPdMfvRJWXhZj/GXKPtiVKDFXB2+Wi9ZjkUFxM0wymnN25Ao5eL9p
	 QDxos3wOc4sWgb0kSNXghc2/eB0V5iklusNVQFE8/RiCpLplSgcUst2Bgm06QYW+RM
	 ibhtP5cCZvHDrwL1gzs8M8PLBbsBQ/kseFJQlZl8t4fm4eeQbELYJ5JtjV6SWY8HK9
	 zLiE5tw44EVCnvze8a68ukvS9JTgO5EaCrvYIzhCoVO8th+IrrwBuNHt/pyWBq23LU
	 xeSA9uL5rHs2AfXAO7fUtaicmQnBIZRk6UelVm+otuz2087AmkOogc2xV9WpUQGyZE
	 N8CD0VqDzrckQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8B6C808AF;
	Sun, 11 Oct 2026 17:23:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 55740194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BC0B605E4
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SrmmTpuj52eR for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B091605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791732183;
 b=fADgKK9/6LsnubgB6Z9InxflJ0MSc7MuO0i41qUZL4M75RrDBLniCjV5a37gmtEKsD4I
 Xp8mBJYsYVSEFK91HetoF9lysgBQNxXTNkpQOu/ae4bxErDLJTUayRO/4vRCN05BSjFqu
 DLZjYuwmp1AmNJyTaOf9ZSl5O5H75qu+B6HqYgV2ekWGZKnl3ujIANtUFjjId4eBi03Ev
 vUj3cziQ55CcE4lJyIZIFPQOtNmXoyxPYGp9rfy4ljxBPdS+yT/iprvj0Sf3itC/BUhvH
 vpPlh/DCNFhaQYo28uyQcgP0jp8cPtT1AXipNlzsuoqpjQLFz1eiNs37hzIVEWwFz7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732183;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=VmQyurKU8RYn2VjmCd34E411nbk9nfhrIbxHbki1qCI=;
 b=YaRdPtKy7deSny4id7rgBcU4FiT26D3+D8MZTTgpdk1WApSrOpXhkhlpgEjwmjRoZbbw
 LgjkkiiMkfMu39/LI3F0N/iWOYE96ABIyF2POVa/CsT2icZZMFuQLdRfTVcV7PYJZqfYX
 vn7vXSwl7n0bVJzi9GHbDsimG6Tl0RYK9Oy0mM+qU5DVDhyN/oGBaGj5hL4JJHEXOoeO4
 UPjMDUsCOwhg+KEyRvhH3i5fuXr61IoA7HqyslaYnA5fyeIyZ0CxXpwMDNv+7e8mA5vek
 jem5Jqu0lGbs76luZrUo7PzzRxpQzz9byzsNgJ0WT3H6VlOSXf538PhIp4e86tZ1ouw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="a4N+th/N"; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=a4N+th/N
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B091605CF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:00 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE1053F16E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791732178;
 bh=VmQyurKU8RYn2VjmCd34E411nbk9nfhrIbxHbki1qCI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=a4N+th/NAuyV9uqxE33s9oWw+L1R1dWNBBPN6MwBsIj49xUyjkiSLjFmzOm84TuAU
 kjlZdDonypxFxAd9oQgV7o/zaD7+YE0KlKc3JtWeDButaG+yUGJ3BeKhzsLoxbAY7l
 oryUJbbz7+2QZ90lZXp9kXsBOTDu/TyiiPaEMESw3rk17zjCHp7A7emH/OuYXG310R
 J5XXK8zhnEm80/FOwgj+oNQbrunrx3HWXau8Dcten/rPyPGsqBNoGef6cC0ZQqrO/X
 Eymd8rLnwsf9VhkWhaQ+7sSIeQrK97blkfDChuh0LxcaEvpin7sXm2v/Gn1LfKUk1W
 9gQjpPCb4znAL7gGZpCA0nsWvTcmNvmm133Kg3QI31lbA4tLe9XoFObQmSduebJfBo
 agvHxLJbrNcBZ8enT13k13h4E8LXsyTOHsLMx0BC493Z5mHSk7VZfBYQUBhgt4ihGJ
 AOo6PunRjMpr/Vq3DjMGGSRbMolCZLg6YEjO+zLbfFrASR+qmYvW+frQ4Xjxdg4TwR
 mR4OdLq6z37fb1U6uc9kV0Uf0ArJDBkzIN2Iz6AORCH+28joLWE7rIAjWXFa1XTV+7
 YrYshZegbP2K7zEWoM+UUh88KpYDRO1NQBR9axncDc5nReRqVoO32+mu92hPAf70Oj
 StInmcRWJQUYOPxJLr38r8/Y=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e80ef3e0a3so18972225ad.3
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732177; x=1792336977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VmQyurKU8RYn2VjmCd34E411nbk9nfhrIbxHbki1qCI=;
 b=Qpo5VyiPDVXdHqu5yMq95HjH05OnkiIYZMqiJ/v98XWPYsTQuGmGE0tLhllZ9ZBzl1
 NvuA7IbtZH1q7Hfbdc8BS+KNG0izzWgUxMgyiBwIAXL/B9IDHQh/FgMwFrHE+xbbM1jb
 oiKHcu5MA89tZO00Un0OSoVBFvB+5JnWrS+wdEIZ/ZP/hNs4Vtk10zVlXu/4gFAfHsec
 TrhlfCR3YBXTNy4W7LVeNJQvAynVGfU1HnNl5GsS/KmcjVS+0RURGP2G3NvzMRbduAJS
 tNbxkoxo7RNUVNx8qoO/M8MR8aJJlJ/Saka07LGcN7MlUd6pmRh1hMowGqDqydCP388Y
 vXuQ==
X-Gm-Message-State: AFq9FYL2s1UhNQCdBljYo+UAd04aTx3RkgQuNU2IV9KougzIk5TT61g/
 4d7CYxPT+qFT93YrL5oQMNOOKmlICcQsafknB5UcX8K+x2naOmL7WlDrcVWtYOiWueXSx+vZ0BW
 Tt8snBaizkzT9raYvF8BUiOOYVWB78DoYd2SCTeA3pji/Q3BxBCjNkWhEw/0mwuwZJ62U9X4uoF
 esn85SpDER+R7G3SThnQ==
X-Gm-Gg: AYBFou3PsM6672gzrpAiycelnhiyl+DqilEl8G/YHKV1HKk4cZzk74OrEEZchsnVWIO
 XsvoDpbTgOvneAhmev+mJhRb2wgd4dUSnPpJQotNl7yjlFE3B5nuOoW7OzPgmfIGUpDR/EO35+t
 BLz4QEMdDJokKx667tV2oyfD2N672+8AZMpfVXNoxvtb29s9r9kheVefqeDDQRuMHE3WEO9DtxJ
 VTvEwTUdem0Nsu4KdSMqKuuViSZ/qAjFhS4igRt+KjuYYVC5C8QJNpDE3FbDCsw0G/tf+VB3kYt
 itluBHXSYe55R+RXqqlQBvWP943W2xdZZms29TGcH7Jsg1IV8mk4EKfs6ioVXcVIY4Qg3HMgGwS
 VBcjtBpe0jj1GcdImSipeDwkyF/m1LE5xFP8VTG4JkjwEUNbBcHW+h/exmoTf/psRo6nSpA==
X-Received: by 2002:a17:903:230c:b0:2df:4876:50d9 with SMTP id
 d9443c01a7336-2e8429a58b9mr66322455ad.18.1791732177338; 
 Sun, 11 Oct 2026 08:22:57 -0700 (PDT)
X-Received: by 2002:a17:903:230c:b0:2df:4876:50d9 with SMTP id
 d9443c01a7336-2e8429a58b9mr66322325ad.18.1791732176923; 
 Sun, 11 Oct 2026 08:22:56 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b5fd2sm33300445ad.50.2026.10.11.08.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:22:56 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/5] test: py: keep the external payload when editing a FIT
 with fdtput
Date: Sun, 11 Oct 2026 15:21:13 +0000
Message-ID: <20261011152235.8842-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011152235.8842-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

test_fit_import_data_missing_offset() builds an external-data FIT and
removes one image's data-offset with fdtput. fdtput rewrites only the
device tree, so the external payload behind it is dropped and the file
shrinks to the bare FIT. The test still passed, but only because
fit_import_data() reads the remaining image's data from beyond the end
of the truncated file, which on Linux lands in the zero-filled rest of
the mapped page rather than crashing. A bounds check on those reads,
added next, rejects that image first and the test would stop
exercising the case it was written for.

Add a helper that saves the payload before running fdtput and appends
it again afterwards at the 4-byte alignment fit_import_data() expects,
and use it in the test so that the edited FIT stays complete.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_import_data.py | 30 +++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fit_import_data.py b/test/py/tests/test_fit_import_data.py
index efbbad14262..95f7114243e 100644
--- a/test/py/tests/test_fit_import_data.py
+++ b/test/py/tests/test_fit_import_data.py
@@ -14,6 +14,7 @@ stages instead.
 """
 
 import os
+import struct
 import subprocess
 
 import pytest
@@ -59,6 +60,32 @@ BASE_ITS = '''
 '''
 
 
+def fdtput_keep_data(itb, *args, opts=()):
+    """Run fdtput on a FIT while keeping its external data
+
+    fdtput rewrites only the device tree and drops any external data that
+    follows it, so save that payload first and append it again afterwards
+    at the 4-byte alignment fit_import_data() expects.
+
+    Args:
+        itb (str): Filename of the FIT to edit
+        args (list of str): Node, property and values to pass to fdtput
+        opts (list of str): Options to pass before the filename
+    """
+    with open(itb, 'rb') as inf:
+        blob = inf.read()
+    totalsize = struct.unpack('>I', blob[4:8])[0]
+    payload = blob[(totalsize + 3) & ~3:]
+
+    subprocess.run(['fdtput'] + list(opts) + [itb] + list(args), check=True)
+
+    with open(itb, 'rb') as inf:
+        fdt = inf.read()
+    totalsize = struct.unpack('>I', fdt[4:8])[0]
+    with open(itb, 'wb') as outf:
+        outf.write(fdt.ljust((totalsize + 3) & ~3, b'\0') + payload)
+
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtput')
@@ -77,8 +104,7 @@ def test_fit_import_data_missing_offset(ubman):
     assert result.returncode == 0, result.stderr
 
     # Remove the offset so that only data-size is left on kernel-2
-    subprocess.run(['fdtput', '-d', itb, '/images/kernel-2', 'data-offset'],
-                   check=True)
+    fdtput_keep_data(itb, '/images/kernel-2', 'data-offset', opts=['-d'])
 
     # Re-processing must skip the malformed image in the import, so that
     # the hashing stage reports it; previously the stale pointer made the
-- 
2.43.0

