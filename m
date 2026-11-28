Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC5606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rIwHnPTB;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=WyLTUv5R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 517E860623;
	Sat, 28 Nov 2026 13:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XdsRObCXPyTq; Sat, 28 Nov 2026 13:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80C1460635
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871780;
	b=dlAsnD8CsqPO321HMv/kA59730RYVo2DPubbMzhRGWbDyHEXb1xD0nuFc2TpqwANn4X6
	 e7i4tSOkjlRVSYqZRHj56lNxMMIL1XTvBCOTh8oGk9eELzxmgVF0iMNN5z4tQ/D/TQaKx
	 OCLUvXxAkUZkLCtjiPCR65wbxTWy+gjJkdqda3cJB5KmVhAAn5uTbM44JVWLpNEBd5CQG
	 OPk+75mwnSeAqnMaXUo97fI9THRYjfSb6tSiQSpO7iG/4S2416/7XaU2CKcqvBSqRw2pO
	 vwBKLqois2NDsGXw3ygkXrYbx2jcpR/s7ACL2gmvQH8K25CsS6sgm/xOaFJZf3G48Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8sa2CK3WBk6qMIpVyTpwX12Q4dx6tyDMBPz0K+1CFwY=;
	b=s+SYy44Cx4kGB7Ul79i08WI3hHq8Fj0el+S1bSy1xLPKmxFqhmUlvhSl7bpxMePOgPSC
	 O6oyRZpNwNCQ5jb9jlQWz7yDbQSV18sJSHVuvxoXERPn+aKZSpan27qPT+9QNaNDxI9EE
	 +GZ4sFLjzkiAfTngooxD0WOEksyeI+fkQxIwa5uCKVBL7MsrhTkFtICHh6H6uQJu7q4jO
	 GK97Z8/eGzG97b3Zdx+gc8OokDOpbFeRH9Kew9VwjtT2HobanAXHmTHtS43nsgfYCGoc/
	 QUaawp7OXWT8jOY+1z5RUmP6pkx7igYt1XFXaM8+SWxeTo+QzCUW7+g4fs4HJa/DZgA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871780;
	bh=8sa2CK3WBk6qMIpVyTpwX12Q4dx6tyDMBPz0K+1CFwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIwHnPTBeYC5Mg6bUaau4C+XiWoyuMo0qmqyu7t8m/i4yv0exelKPmI0+mGFa1sM1
	 moCYDIM3cwCcuN28KXhIlJntM8vBFQYEHyD3wrbTuysgerHlzK2Lrb7Fyr6Pj9KXUJ
	 SIJzu8HYzzEzhwMSCUglXGQnmRxMqtOGMJS8Re0T/vRSSCKTK90deL9ORe+hK5ZgIs
	 PfTLtdMDG8z98gYWfZfGgq1I3IlaqLUOSCpjAuUFUemX1IXDgmX65Lw6nRBd3pBVB8
	 9n4lSkVHl99IXmqf8F8eaae9p/LiD44ZGe0ET9mPCCdmInaajzh3OdBD3Qnkq4+Vib
	 7oNesyuYiPxfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80C1460635;
	Sat, 28 Nov 2026 13:16:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6A74472
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B84CF40A20
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5RWO17P0d8L for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:48:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 585B44091D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=WyLTUv5R
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 585B44091D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:44 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A9DA43F193
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795852123;
 bh=8sa2CK3WBk6qMIpVyTpwX12Q4dx6tyDMBPz0K+1CFwY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=WyLTUv5RpZH2HZzcmqPsOXzMbojWZ1oj4DhHTaGjemXIXF/yVTal3smYCDiPsU8Ba
 6SNTCV32NPiN92L1QC7BoxUX3S/s4vmSLfL5AA9K4kArcghG/liWzPHjTxmP3gYv4a
 R/ZigAeZsNFmBocYlSm/2Jl8HR53e1cX6+z5ADQ/FhIwkhFKbIinqyE6gT3oor+MVQ
 xoYL+RdUJ8Y9UQalXxN914ehMRrNuzLGVlP7UJO/ACo5MT8qBPBQJbsuHZY7PbGoI6
 fBU9DUiA9xMSsK6mS4J6qn82bMJBuVVX+SWDnX/j71n5CgusBePO0iH3gCSAnBNNef
 uFK65jpGgTA6GT3ItLH3PVZZkPsSn9XQbxly0bCvwxO27wEUOzazptA+sEVxAPVLy8
 rQxDTjJpPQqnD9gVbEhsZE1S+s5pA8j1Bx3U7W8PQb5+t50gfIkvfrqx78tIXncd+B
 bT/MBHkbq2Wflb+zaUQeLetdXujNcsyT4Yoj7QUs5WwehUt1fEcadEECrni6o4CR/M
 VAjeT56n0W0/APHU8J6cNK8/wIHUztZsPl63UUIjL4kvJf0bK/VpaYZXnp+pKElF3C
 7f6cez06C3ahFj9JJGaF9yp09GxsQGUSK5QEviU4lErncHYm7JwXWD2iN+P4onezhI
 AsFy6g604/jkbwS4UMYKBjZ8=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cde9044a96aso5255389a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852122; x=1796456922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8sa2CK3WBk6qMIpVyTpwX12Q4dx6tyDMBPz0K+1CFwY=;
 b=twWWUDVj2FHxvp3OnlJdu9fKyTEHKRzqsRLJpT++C/np65EkUx95kkDu3vETRTogWy
 W09OUe6tiEwmnGZXfWS+6hqj8rM4LXFPAhSpEBaUcXkYaBCsG1rFy4alTJQy+lzIsnsi
 LTyj4+ALXxpRKdjloUUor515+rR+v6Y+XRevuEao17GTqJuUMECuB29bL6A4BwJxd3ya
 uPS/BkSpaYleZFEbOMANrGmPfM3X0brV1UaTu+Wpsj0K9yUibW/FL10hsLxdV6CgaRBi
 AZ1m3du6cE2WV2gN9qKFj2e9EgWaavdM+cWR9Ti6vJS71eUXqks6yxyxkqNk7k9vrUG+
 Y9Sw==
X-Gm-Message-State: APuU4Z/0tRzNrbWiV7SS+miySr0eFGf/j+24o0V7gmvA2v8b9OaAO1Om
 fQePT4I31darTDLEnfZUpW6a0KF67o1wL24TpUjtRgV9cb0uJfAYPRZ38Y3WkcPVQodmOwCpnT+
 E0QsJL/Z7sga7SidakTfhlZKJBVF+EG8atYqLjVgEZroeISva/BjBP1iWeFPRj5jVt8L8v4mB1g
 7ayc1tie5jdzn5NBNZpQ==
X-Gm-Gg: AZFdTZczVBcmiIPAhziyzM2o7FZcR+jX3HsBwljMNt7+DTVCxqJHEkvpZXHG9qwJSjp
 EOFbRvXcIriJoBUenwv6S7U+Jhmj8TQBH+FfC/5fZkvzfhRNAmgXjDPSHq+zVnqwfqIB6uff1O0
 O/SUvcCET30eogAqu0NxVMSnzWir1yYMOF26AVa6TFrxBrxB0nbjr0RzX88jl19JsoPJlnsYlCl
 N4O8hJCnGkDP6aaAq+H8oKCU0rUI6jPusAxnIuWashyVUyU79SDJqmii8CSiof7e9a28tcz0e1c
 qqTRWjvP8jYYy2BpkwcQtN70rkETGPotQqChuFwf1mM4XfvtY6EKbGhAEAg2/KdWHp+I6vEpFnK
 umrrJ57qBRczW9oLc0QHi0Ca4aCZ6x2wzRCh570H+7LiKMAOADKQmtHFOOwxYtvnCkDy2Zdbf6y
 BJbqOrLJxx67ndz2bWIz6Bwnuk
X-Received: by 2002:a05:6a20:a110:b0:3e2:7c10:d46b with SMTP id
 adf61e73a8af0-4014c250152mr30116507637.13.1795852122235; 
 Fri, 27 Nov 2026 23:48:42 -0800 (PST)
X-Received: by 2002:a05:6a20:a110:b0:3e2:7c10:d46b with SMTP id
 adf61e73a8af0-4014c250152mr30116499637.13.1795852121876; 
 Fri, 27 Nov 2026 23:48:41 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm14086238b3a.28.2026.11.27.23.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 23:48:41 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 2/4] test: pstore: check the names of the saved dump records
Date: Sat, 28 Nov 2026 07:47:38 +0000
Message-ID: <20261128074801.11306-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128074801.11306-1-aristo.chen@canonical.com>
References: <20261128074801.11306-1-aristo.chen@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 13:16:13 +0000
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

Add a test that saves the records of dump zones 0 and 2, with an empty
record in zone 1, as Linux leaves one when the file of a record is
deleted, and checks that the files are named after their zones.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_pstore.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 8473b7ff625..3fb262253ef 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -355,3 +355,27 @@ def test_pstore_zone_order(ubman):
     finally:
         # Restore the default record sizes
         ubman.restart_uboot()
+
+@pytest.mark.buildconfigspec('cmd_pstore')
+def test_pstore_save_zone_numbers(ubman):
+    """Test that pstore save names the dump records after their zone."""
+
+    ubman.run_command('')
+    ubman.run_command_list([
+        'mw.b 0x%x 0 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH),
+        'pstore set 0x%x 0x%x' % (PSTORE_ADDR, PSTORE_LENGTH)])
+    write_record(ubman, PSTORE_ADDR, PSTORE_SIG, b'====1.0-D\nzone 0\n')
+    # Linux leaves an empty record in the zone of a file that it deletes
+    write_record(ubman, PSTORE_ADDR + 0x1000, PSTORE_SIG, b'')
+    write_record(ubman, PSTORE_ADDR + 0x2000, PSTORE_SIG,
+                 b'====2.0-D\nzone 2\n')
+
+    response = ubman.run_command('pstore display dump 2')
+    assert('zone 2' in response)
+
+    with tempfile.TemporaryDirectory() as outdir:
+        ubman.run_command('pstore save hostfs - %s' % (outdir))
+        assert(sorted(os.listdir(outdir)) ==
+               ['dmesg-ramoops-0', 'dmesg-ramoops-2'])
+        with open('%s/dmesg-ramoops-2' % (outdir), 'rb') as f:
+            assert(f.read() == b'zone 2\n')
-- 
2.43.0

