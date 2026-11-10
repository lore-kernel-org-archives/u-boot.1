Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B0606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gd2gDZyo;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=prXUVAaH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E5DF813FD;
	Tue, 10 Nov 2026 13:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-qzqbBK9SHx; Tue, 10 Nov 2026 13:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 207C381418
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315973;
	b=Ju2O5GPxDSaAVxGIBOrFAZ0/XWSDqPvMo71zAqfCkwJjN/raRaNM8UfjTNg+nLQl1Uqc
	 XRUcvXABgN6e++KpSaSdf4dyErsLZYIz8cG3NvFxHt8V2xuFI7mXc1Oz8G23KPIEPW6iN
	 XD/fwaR0kQAyXKB9ulh0GcYy9G9fGt2ych5aNaQYQUEaV4veWUbGmpiIux2v9tjqhwM4S
	 mQxZ+AuGIeKJI7WIFV9/PmFrDU5C+ZIQ4LNDATr0z+19V6UgwoStOA89x9VKMpW5iis+e
	 atMslWR16VjdP8mljmFHyUiPwlTDPWanLjE2Dj9jSf8+HKExyEvQFTsPfoAP4UMQi7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y/MP+AbxXDM6NqRijQ6eMpLtAKsYdpFPoUlQerfa8oo=;
	b=jDvxaZrIhoqWkm8XKyiizUHdZAxIBQnhJxzCxfI+/TgCNK+8lATwgUyE001/lskAccCG
	 PORmstL5ReDwtnGki9JpY6/S9jCSmBP6HmfISh9IVbYmbNYCGlwNDXTzacupalODL3+dL
	 s2yXW4NQHtt60k3hbiSHznQ4NpMngrxL4O8IDn0NIOwHYH2hv7CaAwdUdJLtLTqa5Vd5n
	 dkcG9FypWr652Nzw+Ocx1iHclzlYFSGVSQN3N2C8/FFV9bpDsJEJXvQ5suX/ee7cAVIJ8
	 g3Zo1XZ6JjfsV2xbBQge7KwB3dGLa4ACqJ3JQxpc/o7jRjeVNWLjLPca8BlsjpUGwGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=prXUVAaH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315973;
	bh=Y/MP+AbxXDM6NqRijQ6eMpLtAKsYdpFPoUlQerfa8oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gd2gDZyoTXzCnausEdXl551B+nSDYf7MuJB7XeIJflrejShM4evnNhT9dGgxL90ly
	 jfAv0RpjaMVqelkTI5zPUHyeBmQuQDToaKybmN4tP2P2RXDrHAIEIE+OuQ92TUkRdP
	 8VxTc0b+esTpcGaVqSXo3q5ywYlPR7d8KsK1qVW+//jZVrTzE54qNi7TnbvzYj55RN
	 gwl+jk51xEf0mWNbsvnyHf2eS2hMLKxEPvpMSj0Fvn2tsYImxEsgieFm+i10Ujd25l
	 9OkgtA9qHyakQFesKlDCbS5vsQPmJrIRfsWyyPShLudcF8CZgp/Th6toXnTyOw+Uj9
	 /T9BqKq7FeO0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 207C381418;
	Tue, 10 Nov 2026 13:06:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6751C31F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CF2480E12
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9_YcEe-sowC for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6EE5480DFD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=prXUVAaH
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EE5480DFD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:05 +0000 (UTC)
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C30A3F9D6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794297484;
 bh=Y/MP+AbxXDM6NqRijQ6eMpLtAKsYdpFPoUlQerfa8oo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=prXUVAaHk2P+35OEMXnZucEP2O4Oa0UncefZ9wsXKFS7VqdnwR5dfMG+aiduD6qnQ
 diWPCxA24FKbAh/LHskU6PkKBRnPFuzJBX/ZTat+ydGof6aL834Gw0h94iRuHFtUkr
 PXwMVmn41EfjXL+37ABofHnfQy7pDuItm1e1kMMQiA9HDjiX2vIVBQDzk8RsYBmsqN
 v13CKcNi9dRIwmQNF0MgtAdDURxrRq8eQ9xB5TnR5pdNpyBiffKVAOYfMmmBVuTs0K
 km7lRYyxrNZL0+2S9mS9deJVEfqoB5qr/wqo+JnV+RcmJWUMJj/ZYzAaXvkMNvDPb2
 XIgaNwGwGU45gkedwdgE4xxwQcd5IOa3Af9UoTSUWtCrDjrB8lHSnSOb5uRYurJ8R/
 KO5jNWHyQ4nu3956Zjxy566qslik8U9i1ttIEbbjQWKl0krn3We+bwACElOVXSMmSO
 nBA4n7LMYzZHVW2ZpDMO7wf00i1cN5//aKQKIMprbdWd64DN6cunBAAsc8cF8xyUbK
 1k+eUHaGwgoJhmCY68fZ+S0DCiEVT++TShBv+t2xzJmt6xGbdG6HcG6KwBbZaNG9Fm
 hHFccYRCAyp3LHZIzkbYCJTLVKNIhvwDo1VCwVsK5gnH59T9gcgITuv4yOHLr3GGy1
 J/NOGeAjjAbjkH5YRYqBflks=
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1a2b6fab7a6so1827700c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 23:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794297483; x=1794902283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/MP+AbxXDM6NqRijQ6eMpLtAKsYdpFPoUlQerfa8oo=;
 b=cbGxnRca8KQpmmnemXmhg5oAWdmmqWPqvSm80iKNJOGdOSOUB4v6CUWSC1i9jHUYmC
 +8kPJFR6VzFfAH6WglBgTmHYAt+Fpyd5MWIJNDlLIXOEC9JtDZhBi/e7nYEboJtBugge
 mWAzok3sQGrwk+KQmN34arGuG3ITmVVLguxyrQ0QALErkQZyUamjaaZnmcw052OqyCfA
 EziN0DKX8LDnx3a557X0WNn6Y0/B+TxuctfsesTM3w3DHxErZX4MmXSeXItKLxIyrbdF
 kJ8a4K0bJlFIYC0vIb70YAgRT0aVudz0HivuSYInUNUP2tVrd4FxbLe9YdJuZyv+Otxj
 z92A==
X-Gm-Message-State: APuU4Z97hEWW50NjoMvSZJ9S3qACDaFy0U2hH8ZoVKyW30220P43sxK1
 It6nY3/1gqi2x+WB/ZuCd4TTnEQ1FhqW8jbSCpEdbXPNE3fZN6GLxNe6jZ3bi+JwJW/k3i61YLs
 Q/oGunxeNEXjH9+fjWzL/XV8zf/mxFo/0PD4kpZ5AB4R+zsutczWaWMq9HqwFHh0H/bP9xKlWfe
 AtD9hItc8TZGFqWCiYuS20
X-Gm-Gg: AYBFou1cdBY9m33W9G5h41R+H+Q5ZrS7yIEeLqXNpD4Il2DrwGl4ptCyHRlNr14KD1L
 bBMTgJzou9PCUt3CpmNfKus9RqmBt4cafHOClEfkFGA48iJgy8JkKNJd+88b9NVhd2pS8+36sZx
 ODTodlwMwQiTAAMzNS4ze86xKEVSpGwM/9t7TgZTQkUBpSh1J+vwUag3MVv/nV1szTV4jejRkEZ
 x4M3aLqey1sPkzZazc6B5sApLRXi+lgQ2UlrQH51bOebP+oeOZwgBu8UfNLCQZAGMG99EWbEYex
 Mo7oKKOzKNmBc2zDh5JGRB6+snAqmPeIoPoJgAzbXVkXfSjTKl8jopP/SLuYGN1A/PVraoPEzqb
 Nhd1bn+nEDZviZRyvU2WjQZHbRQvcwxHVSdcgCaPEouRo7lcrltg1Q4qkdn0+33guLNZL9SrIOr
 Iem8LqUtFFOkNujghgUyFhxFqJ
X-Received: by 2002:a05:701b:4642:b0:1ab:e9b8:8a28 with SMTP id
 a92af1059eb24-1b3b5e167e5mr2444402c88.5.1794297482677; 
 Mon, 09 Nov 2026 23:58:02 -0800 (PST)
X-Received: by 2002:a05:701b:4642:b0:1ab:e9b8:8a28 with SMTP id
 a92af1059eb24-1b3b5e167e5mr2444384c88.5.1794297482151; 
 Mon, 09 Nov 2026 23:58:02 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe3261csm4212914eec.4.2026.11.09.23.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 23:58:01 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 6/6] test: pstore: check the ftrace and user zones in both
 orders
Date: Tue, 10 Nov 2026 07:56:42 +0000
Message-ID: <20261110075707.1409824-7-aristo.chen@canonical.com>
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

Use an ftrace zone larger than the user space one, write a user space
record and an ftrace record in the order of Linux 6.2 and later, and
check that pstore display and pstore save find each record in its own
zone. Then do the same in the order of older kernels. Without the order
fix, the user space record of the first case is shown as the ftrace
record and no user space record is found.

Also write a user space record without a signature in the new order,
and an ftrace record whose data looks like a user space record where
the old order puts the user space zone, and check that this data is not
taken for a user space record.

test_pstore_invalid_records wrote its user space and ftrace records in
the old order; swap them, so that the record with an invalid start is
still read as an ftrace record, without checking its signature.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 64 ++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index d7178d8a19c..1105a96220d 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -99,8 +99,8 @@ def test_pstore_invalid_records(ubman):
     """Test that pstore skips records with an invalid header."""
 
     console = PSTORE_ADDR + PSTORE_LENGTH - 3 * 4096
-    ftrace = console + 4096
-    pmsg = ftrace + 4096
+    pmsg = console + 4096
+    ftrace = pmsg + 4096
     outdir = tempfile.mkdtemp()
 
     ubman.run_command('')
@@ -295,3 +295,63 @@ def test_pstore_rounded_sizes(ubman):
     finally:
         # Restore the default record sizes
         ubman.restart_uboot()
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_zone_order(ubman):
+    """Test that pstore finds the ftrace and user zones in both orders."""
+
+    # The ftrace zone is larger than the user space one, so that the two
+    # zones do not just swap places
+    console = PSTORE_ADDR + PSTORE_LENGTH - 0x4000
+    orders = [
+        # Linux 6.2 and later put the user space zone first
+        (console + 0x1000, console + 0x2000, 0x060200),
+        # Older kernels put the ftrace zone first
+        (console + 0x3000, console + 0x1000, 0x060100),
+    ]
+
+    ubman.run_command('')
+    try:
+        ubman.run_command('pstore set 0x%x 0x%x 0x1000 0x1000 0x2000 0x1000' %
+                          (PSTORE_ADDR, PSTORE_LENGTH))
+        for pmsg, ftrace, version in orders:
+            ubman.run_command('mw.b 0x%x 0 0x%x' % (PSTORE_ADDR,
+                                                    PSTORE_LENGTH))
+            write_record(ubman, pmsg, PSTORE_SIG, b'user text\n')
+            # The ftrace signature holds the Linux version
+            write_record(ubman, ftrace, PSTORE_SIG ^ version,
+                         b'ftrace text\n')
+
+            response = ubman.run_command('pstore display user')
+            assert('user text' in response)
+            assert('ftrace text' not in response)
+            response = ubman.run_command('pstore display ftrace')
+            assert('ftrace text' in response)
+            assert('user text' not in response)
+
+            with tempfile.TemporaryDirectory() as outdir:
+                ubman.run_command('pstore save hostfs - %s' % (outdir))
+                with open('%s/pmsg-ramoops-0' % (outdir), 'rb') as f:
+                    assert(f.read() == b'user text\n')
+                with open('%s/ftrace-ramoops-0' % (outdir), 'rb') as f:
+                    assert(f.read() == b'ftrace text\n')
+
+        # A user space record without a signature in the new order, and an
+        # ftrace record with data that looks like a user space record where
+        # the old order puts the user space zone
+        ubman.run_command('mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH))
+        write_record(ubman, console + 0x1000, 0, b'user text\n')
+        data = (b'ftrace text\n' + b'x' * (0x1000 - 12 - 12) +
+                struct.pack('<III', PSTORE_SIG, 0, 6) + b'bogus\n')
+        write_record(ubman, console + 0x2000, PSTORE_SIG ^ 0x060200, data)
+
+        response = ubman.run_command('pstore display user')
+        assert('****' not in response)
+        with tempfile.TemporaryDirectory() as outdir:
+            ubman.run_command('pstore save hostfs - %s' % (outdir))
+            assert(not os.path.exists('%s/pmsg-ramoops-0' % (outdir)))
+            with open('%s/ftrace-ramoops-0' % (outdir), 'rb') as f:
+                assert(f.read() == data)
+    finally:
+        # Restore the default record sizes
+        ubman.restart_uboot()
-- 
2.43.0

