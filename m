Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C67606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AEn6ur5b;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=gwxSh2bq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F04E8137A;
	Tue, 10 Nov 2026 13:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJNuUBd2e2Rw; Tue, 10 Nov 2026 13:06:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40FA1813B5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315964;
	b=VADHhsIULo7abUZ6nQkyWT+KO/IgoSU+dBKfAjD0EQ2SVfNI5JkSaFEyc3kldvLoH/I8
	 op8GKEa5exil2ZJGloM83fXch4m+gbdNc4eGJ0QavYqB5vvs6l+2UyVzzM1OVK0jJMkFX
	 pHNbhlqI8Bbi2Utq+hLMnRUHdpHZzVOe1UA+mx7Lc3iWe9FBars+HgC6ODR3l7tsk+oJE
	 B300VfaSNqjaZcVh0BzdQFN6T1lkDAl1z+QhgQblBTssu/vg6DHXMe773I3MLQ/Hsxq3y
	 yIPokTpvoESaZlTVtMI1oLyFht3Q5PrhlHxMebmbAd5xxljDuXVBlZLTUZNYFNyqsIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zjRmThdETDkSKF2YLUKHBj/A7tFUwu/28OollAX3iwI=;
	b=FXKeXKSjPN2hcxh01V0BqhFg3HtCEzZlGWdhGKu3xjJKgqfO+FJsOk0W5gAL6AIsRaKe
	 9BLF2z0FiRpRUWurDq0ZiLOqjpg1DHwYKIFeqT2CXat94FwYCQxbC+dbqIA/tlQzdrhYB
	 ihKCM++HnEEgisMYFJ4hiyUVKdroNeX6Tt1V3C0qO7r77MixvQ3gkwnWZwrw0x14+oei8
	 RCcZnr4JKVFHa13Td9cxhYlPUE4QwlglGS/SDJ1atQXoQZdZn6x7yx+h1ANSewM8LQ1aA
	 YU7WdZ4EAJ84y+zHVOqPDMjKqIrBj9oJx+g0cPd/mPhpw+yqKtVUhd9YKXlpblfhLPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=gwxSh2bq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315964;
	bh=zjRmThdETDkSKF2YLUKHBj/A7tFUwu/28OollAX3iwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AEn6ur5biJfuYj7fbJ3vu4RtcN75UTkm3JwIwwP4LRCnhXYhcN3v4A6zL4Jv4t5Sl
	 wh6Ne2VDoKrQpL4beCJPsth0cnvnh7EOTFymZa9X2eOgP3JQL/SyshMg8s8zYeLeSa
	 wVftS9jI5qmFGRQrNV8OYegL8Np3wOWXvOkc4hGZpw+bWlofe7Kjexc1zeJfBfEmTL
	 Ywtk0siQ6BKEAxMB30Ufj1dXGqOAsP28IfO3V4eMkaJse0Qg9SJmqV1gRb6JETYOyK
	 zJiFziDAx/ld0uyLIBVzrPHd8RvqXLBRyTDipJQJPTyzXlmyYYd0X7u/tqG5tExewC
	 RbYCynhdmrm0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40FA1813B5;
	Tue, 10 Nov 2026 13:06:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A17D14B8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 879DE80E11
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTMlDSXIk8G7 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84A8F80DFD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=gwxSh2bq
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84A8F80DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:59 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 67C093FE5B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297477;
 bh=zjRmThdETDkSKF2YLUKHBj/A7tFUwu/28OollAX3iwI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gwxSh2bqOtKpSFWMRGGSrQ6EXbcHITnpRyxRkNhUYie/SwsxCXgHc4SucrcfeTKYV
 rhANn8Vfa/ZrgzX8wWVUzrUzhagmQlDyfPN90ZQBuWsriB9CcOUxknvGBYz1Pkuepi
 CikUNF63EsxVV0E4XjiyoVABwhKHHHeBkw9CgtEao7j5jKRAIkSSH1MoJGpxTVDY7p
 0WOOaYErwc6RlJxnt3SgmeslnnJmP3D/3EqLXHGF7an3gW8j8963fH1j5qxLAvO+mi
 0nCDKEea3MVYc+mb5Tn+HiyOQUJ4flxroDxGcgy99LaoOrzuyJUKZ1O2V9+ehyM7di
 KgnBxUkflMJDhMsWWye9tjeZ/zUj7HX5DvkB2QSB+vqb+v/o7+WunvxqCF9W27kPBZ
 zkNxrko8IYmp90Q0bldIDnF2fXbNZa/051Kkn9qYDWdTR3oilunOL3DP4xmKbVd/lU
 jGrqTHzWBMqs7GORfaVtCHsCC5yUYHwjziuu55f4ez/PMophgTcp/bvksX30jJbOgT
 u0nxMd8sfYoe5al8AvBv7N7yIaeZvqvuxyjG6BvHWY8Uwn+SDXpLmLXeqHSZEQe5qQ
 iy9dQ84IYhBdIYNK+lDuwV6inO75R1ukgocKUabjMO1fg2fJ6aDi2aqdxMCSQ2vOOU
 bsSMwiT11U9nnasfDkZ5F7zc=
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so1823eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297475; x=1794902275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjRmThdETDkSKF2YLUKHBj/A7tFUwu/28OollAX3iwI=;
 b=0srYsnujD037LPDizJtbbGPckzClVXGaOk1cwHooNJFZIqzRDJnneuVZqM6VTdpdoP
 usKkRHdetBcCGvoiHRcWqePA8QT/Wdxq8g9BQpnK+49hYX/6YtAizrnjftJdAvyZuAGP
 Sl+30UzX21BNl32Ek2qeWZwiNHmR8arwq/Xhyhl0LrtcTNpOYC1jfOX8itiUYf+9YiV/
 qSxkwMVk7V7gGaCEcOMB2ZAwiPllmkMXgnjHDbd/8KuCwWhDRssvKaBXqem6kK/s5ijq
 66WyUsGjS2ioj1kE8GVnqEUMnwhw4aD2Ge/w1Q8qH/++r1mqhzaroIWt9ixnofgbX65p
 pXwQ==
X-Gm-Message-State: APuU4Z8ZuF/QOlxlugMOxZObL661QLV2aYHTvMHsSVI+UFzbRHRWN412
 5JFw/4LP9zdt2CMhJuHx1/CHymsUgN1Ll86RcTBtMGr+zcAbAfnlZaFGryNxmeRA2LufyKRsXwN
 VQIi46uYewu+7n2XqmXUha0FjeoHpvAZBydMe1kSRWDbnnN99S1duBSqgr/DacW+2g+thde+hcp
 LKNkZU7dWHC8R6bloNpd67
X-Gm-Gg: AYBFou2VkgVOlE+9ITGtUKcPEOisJoeLDXrhu7C5FE9r4DK2VVGYSBaNUoruuyKXmbG
 r5AmwnUf59eiVrotUjZyJIi4f8QtDmd4pRg0iNWaf4//9IG9tS1cK9xJA6v8pGrrVahjuz682qK
 hFVSR1UUjeRGZdVo2UukxD0gkD0pXP3GWf0hn6Cz1vVCikDNyRPIPKfH/OH28srjc/vzd2vJOnk
 3PTBQuTQo4RzWb5cfTeAeh4mle+0keIS6pqhKt8A8OeMzF6Fg3DrXggYySd/urp/rk799w/gM/8
 kD0syfYAQGxf0K5A22pNcp1cYal4ISdt4ekVRi9aOHYm2+WggHdTDGfQwqwOuKcsbiVwNV/ABbv
 4kH4zhsPWOhYGGs10Jf/ocIXfpThut1wKa2Sk67I1RMT9BLDV/9NdjRL2smr+kL/zzo5NVSeJIK
 OkdxK3QB9ZzBUmQLxx6hxnpB0V
X-Received: by 2002:a05:7300:a498:b0:36f:5746:3364 with SMTP id
 5a478bee46e88-37520bf7048mr3112351eec.28.1794297474905; 
 Mon, 09 Nov 2026 23:57:54 -0800 (PST)
X-Received: by 2002:a05:7300:a498:b0:36f:5746:3364 with SMTP id
 5a478bee46e88-37520bf7048mr3112319eec.28.1794297474401; 
 Mon, 09 Nov 2026 23:57:54 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:57:53 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/6] test: pstore: check that a buffer allocation failure
 is reported
Date: Tue, 10 Nov 2026 07:56:38 +0000
Message-ID: <20261110075707.1409824-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075707.1409824-1-aristo.chen@canonical.com>
References: <20261110075707.1409824-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set a record size larger than the malloc pool, write a dump record and
check that pstore display and pstore save report that they cannot
allocate their buffer and write no file. Without the allocation check,
U-Boot crashes on the first record.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index d2d4273d6d0..35836882552 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -7,6 +7,7 @@ import utils
 import os
 import tempfile
 import shutil
+import struct
 
 PSTORE_ADDR=0x3000000
 PSTORE_LENGTH=0x100000
@@ -49,6 +50,14 @@ def write_header(ubman, addr, sig, start, size):
         'mw.l 0x%x 0x%x' % (addr + 4, start),
         'mw.l 0x%x 0x%x' % (addr + 8, size)])
 
+def write_record(ubman, addr, sig, data):
+    """Write a record holding data at addr"""
+
+    with tempfile.NamedTemporaryFile() as f:
+        f.write(struct.pack('<III', sig, 0, len(data)) + data)
+        f.flush()
+        ubman.run_command('host load hostfs - 0x%x %s' % (addr, f.name))
+
 @pytest.mark.buildconfigspec('cmd_pstore')
 def test_pstore_display_all_records(ubman):
     """Test that pstore displays all records."""
@@ -163,3 +172,28 @@ def test_pstore_cut_dump_header(ubman):
     assert(not os.path.exists('%s/dmesg-ramoops-1' % (outdir)))
 
     shutil.rmtree(outdir)
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_buffer_too_large(ubman):
+    """Test that pstore reports a buffer that it cannot allocate."""
+
+    # A record size larger than the malloc pool
+    malloc_len = int(ubman.config.buildconfig['config_sys_malloc_len'], 0)
+    size = 1 << malloc_len.bit_length()
+
+    ubman.run_command('')
+    try:
+        ubman.run_command('pstore set 0x%x 0x%x 0x%x 0 0 0' %
+                          (PSTORE_ADDR, size, size))
+        write_record(ubman, PSTORE_ADDR, PSTORE_SIG, b'====1.0-D\ndump\n')
+
+        response = ubman.run_command('pstore display')
+        assert('Cannot allocate' in response)
+
+        with tempfile.TemporaryDirectory() as outdir:
+            response = ubman.run_command('pstore save hostfs - %s' % outdir)
+            assert('Cannot allocate' in response)
+            assert(not os.listdir(outdir))
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
-- 
2.43.0

