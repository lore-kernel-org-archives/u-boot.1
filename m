Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B768FCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BD5C61005;
	Fri, 16 Oct 2026 13:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E725NOtiygDd; Fri, 16 Oct 2026 13:24:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B553561058
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157039;
	b=aBAdudrvs628h2++zxY9sbpmOf+5eBUhERbOoQkcKxny4ZAcdBV6YVXDkiMDNESHlOt2
	 mKkh6tEjGi2p5Iz4DkREDvwv9j83kJPXjIjJEXfguo9fFLGsQMJfAktyIz6dLQgNOczOF
	 +XBHt7R5ezRWnaYCJ6VbFJRKmLpUy8QoyucCUGOLzqw28f8M2WdzaDI9QR41Rf14FUa/g
	 AwFR/8/vG8iBfR3fgPnhoTN8mfd9HI9uEJRhOUlQGdpWophZRzOy7T6r/7p+j4XbqBpjZ
	 /w+MsXgKZLSnspQjR0uDKKJWUonP3/yPJOREixtWGiMkfQIoZiwxI706fTIavp4N3Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QJ96QJfqQP9ZXlKgft/bTuZ6cWcRcb+EhVfA6kbEu/w=;
	b=UcncHmjbaPHWdDp1BeexQ/mGHsETpnvxYOu3jD/raTFFMgnz9CERWtKK6Z2NpqYTUl8l
	 kql5W+4HIeeT9SZsB1KrEf769cinrETYsLteE+sQZCMNeivHFhbFGi+YVFxtDRETDmGUG
	 wrhCyNOl21G7J5aU+LXhd74moOZlIA5tAlRLhcOh7s0+OHWwijwi80cgx0r0CnI4pl3zW
	 R0YXukrEivlF9pQH1zHtJDpV4bNgoSjjFas9GGBL5hIvS4HSHzL5qzXIb9qJtw2kORoPe
	 VBlULwRcYiqoPiC2y2Zg+vnfZSUXswM9YeeeTW6dVygugYTdpBeYqqu2K45b4aKdb5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=DdqENYZS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157039;
	bh=QJ96QJfqQP9ZXlKgft/bTuZ6cWcRcb+EhVfA6kbEu/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uIqI5PuOpA4ZxrtsV2d0TV51llTVZbEDmHho3mnOAJhZL98DfkhjzAR7ly59xxmyR
	 LcYcOukyYwyBRjfsGY9RxhmjuVz9VcOsEZgNU2+AyeytGRuaGxmhV7nX9DorudJD0H
	 oRRJqYfGEn6hCCVqJ6R2p1UlcwRTssKiS4hkHbhw8sv1kJTq1L7jiUD1CfWH2tcuTF
	 Ux3GdoQV/tTg6HPF/Vnp3nkBHgsoAK8QtzNZFe9DTQFAAlSKczoHouyxeRanBKYqZv
	 LQ0hNvn6v2ai8a+R3OeB5ZxVwkZ/hxtYJOVGJr9uzdK7JsnvVT8Uo1LGsVTIvExg1w
	 56XDQbpoUwicg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B553561058;
	Fri, 16 Oct 2026 13:23:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5288C1AB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43F056079B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zNIJDmluCBNF for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C08DC60A72
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792138675;
 b=cjkH4JMU7IPwOP2dPV/twsdAIs+9ejqmhibk77612n1XNERXbPvd6PpmZVRjLitX3osQ
 6gHEDPtm32DlOCmV3c54rGOBl0vOZFLaJqxsKsBOwJBuhlwjDjj6zSuaGPAXUx137uHs0
 LpmIs7b8KEPgNAMeVSweToaWp2dUkeWHol9dqOU0G7P4vDl5G31lwtiMCCsyUo/PrxlFD
 LoZvdMshVxgiLIYj8okGZgMExLKszDNJkuXdobfsHxi0Nqlo7HstjEJFLPXbTpyGu6FXK
 hGTE65WHMYvBPcAvWibQb1VCJiKeeicwhTsZYOxwN7XiAVL9iBsQPkJ1i9Dx/oE8+vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792138675;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=QJ96QJfqQP9ZXlKgft/bTuZ6cWcRcb+EhVfA6kbEu/w=;
 b=IUSvdWBc5o+duEX0/CikElXq0qjtwhzlO51KaoisH4Hc+prTjhj/veLACg/YMW31tnN6
 qW8I2cL1ZXg4pqwX/+FTSIRR4Bt4OxZrjPelh5wKB6ZMjfURFnkCrJ9hXQaKn3Hl9ctjN
 n9fYKrxAenEGk6loMp+QuyNj5Ye82gheChzKa7+kxFeJuZidfQR0aANwulrHG1yY9/OGd
 hOD+Z0E5cOOrdgtUrbVx9ecZt4+XsSgvE6kGfT8l4JmIf9wkYKHgtjlaVxlwHzQKolKOw
 zsm1OlC9vJS3BEi5meo7szOB+M8CkQQchUZvbDjv6dHyO4Tm3XwS7IOqsJuCOMTBpfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=DdqENYZS; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=DdqENYZS
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C08DC60A72
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:53 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F063840318
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792138671;
 bh=QJ96QJfqQP9ZXlKgft/bTuZ6cWcRcb+EhVfA6kbEu/w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DdqENYZSrXLYdtuBMzbQ3LYP+6NVSUIwdsFA8ya6Ey6L7TbDeQ35RtyNS6n0XQM14
 /ql5ZTgLrU6DlyILaJh7N42XrkLmNCQsa/fLdpeFsEVou7tfl0D74bV/76QNbACFxa
 8mtJFyZr9k5eVf4XRquYgsidrluRI09b8+jZ5AHRmpSHTSiIV51wdSIkQq3POVAx9m
 8ZT2+CtHtiCWlKScNaP88m1QZsCjRfGfNSdxbCYE1HvyYkTWzGuiwQX0Rwcl/aBiX5
 7EkDi4/RpCuLrNGbBIIH3vHD9NP+mDh2AxphuZvgSAiSv5+w6w2ZskSZZSNgCyCNjz
 EO7p/AVRBdzkJyzz5IOJUCWeDw7eRVxOMCMFihfDdpBlNNGnSyuYzf5OMek/91+49T
 T4OUAVLOYEMhR6vMfgVC7ahjxI0snyDlq9uleNFaJNXVMW3JoxC1lxzvzGRHNyV+OI
 gwfW/k4YIaxE98H044oVb85E3O8LuEEVxPGuIy9z5iDlFFbzYhnSUgo2q+xdSwby23
 n0eN4R6uA8oLg8Wij0BKcXDV/XJUjpVDt/2ygHDtZsK8PZUYiAeY2rMcaPK9KUALza
 dW4nDg6MtqFhOBL0dvO+v1aYpLxbIgSIGUHs4boWO5pvl2236lahptAgcSNMIuc9A+
 RzADqicovtO1lwhZ//lTx/Vg=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a8af172664so2593302a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792138670; x=1792743470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QJ96QJfqQP9ZXlKgft/bTuZ6cWcRcb+EhVfA6kbEu/w=;
 b=mTGdtY3iDZ9bHDdSJYNR9Q2SMl2pOE6H3Wx/TqbMS4kcrGlJQGXsZnlydmxeAcNNpq
 yJIF59mXnaUKjnCpbNsxfeZbc5iKua5hHbII0FaxpXueruOzQainWYl47bKQW5C4WgC7
 e/gFEtZh+CGFQknjXhF+iTlVdjtKfJAltE/Q5Qhyf8ZezqNQD+C3ht69nQjqH+1d7krN
 QoeN0JZBTn/qOd1N9/jjynDy8Umsbhxr50lKfrJgxMdaSOdWivGmVR+T8augTRzTJwK7
 smRS84/Pp1hTNfFbqHB1xLOpGlFDIl/zTEEK+Apx1DIa1Uo5kBu7L9TCJapmI+5K3ixH
 xb5A==
X-Gm-Message-State: AFq9FYId25I4H194wLoCO7bipGHTzGAlwUtrs2qRk6PllNcZ20WKbBNh
 XwgDXlPZas8/ejcgwXneMvd4eKyed9y05MFtXFNa6+5hwJwQtXbAnkkHQF3f5Y6IQ+kQqO/ktg4
 Q+c/3oFb0HRvNdU+fkmgwwlWKwfadVo4n8ufimE112T2iDHcrw71heVkagsEVfJ6cWOXgBT8sfy
 fhrAwA3hmykGENWkAaiQ==
X-Gm-Gg: AYBFou18nxLbGJPHahkIQYjaBAXmjc0SOWOAZmRxtFc4ekwKR77xcnkOAkSiy9jsO4k
 d8mC1WMJ8Sm9r0zg4q9SnaC92PQZeUpLjMEaUVuPsF89SkLS7iO+TUP6h9HJpm9UqcjJeHTJFxU
 gR3yxiymU41YKAACrabBYoB5ig9Ehf+Jq7KxoGk/fZexOZJ1stwFpfImFTSnTMhghvitinrMoGW
 8k1U5BUhjXnnHXvKXuP9/2BkGycW00Yf3snjzI1vXJwxwonwrdFRhmlDum43my0eYNG6girQEIW
 vTzmAhNLjSurih2K7ayOlCI7SJRnGMsHATkskCQwFPMHVdAw9Hh+rZtwZ477pkhk14Zr4Vc4x4q
 q00Oh0t0T3mYNiPQ7GhpKEq4Hvrm2Q5Z5csQKa7c0ElNqaZNTMQKgxWfMlLDzJ4TX3A==
X-Received: by 2002:a17:90a:d2c7:b0:3ab:1b19:78f0 with SMTP id
 98e67ed59e1d1-3ab3a8e1d1bmr19092429a91.41.1792138670239; 
 Fri, 16 Oct 2026 01:17:50 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c7:b0:3ab:1b19:78f0 with SMTP id
 98e67ed59e1d1-3ab3a8e1d1bmr19092408a91.41.1792138669743; 
 Fri, 16 Oct 2026 01:17:49 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm9149405a91.9.2026.10.16.01.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:17:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/5] test: py: keep the external payload when editing a FIT
 with fdtput
Date: Fri, 16 Oct 2026 08:16:23 +0000
Message-ID: <20261016081719.814357-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016081719.814357-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261016081719.814357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: no code changes, collected Reviewed-by

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

