Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793E606A31F
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZwcF33KX;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=q3H776st
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3D3F8102D;
	Sat, 28 Nov 2026 13:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YP8Udsi0vydT; Sat, 28 Nov 2026 13:16:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18C1C80FA1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871776;
	b=M8IyZDerla5poop+dT6ZrE6k1tEi3v6fmlGs53FZXyYxNBZGzn8j347M6voRu0kkhx66
	 Es8uxD4+FNGTAXl46V2Q5mhTu9XiNagM0KW4bnIOcdr05wi5otNd6XIUqYRkq1HoUivFr
	 xd3pOcIqPAgQGYO9ZP5J6ou6oLUAt4wNhhB7h8g1LrpZmgektG28M/7E+KP0jpIvMcZSD
	 FgTYHNx4D5TASRAbitylJh0rVTextzOaur7D0ztwKB+MOowpp6V/X/rjn/RSRqBsY0Hl7
	 dyd6IhxDP/CF+FlxtTLmpvV5zgIYKQkZEpSmAO01XJf8jfibyiZEV5HcbOlsIRKCfSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gT2hZP/3KnB1lzX4mXgIbtS2L8uB+/0ZUS8X693oJRg=;
	b=MlD0bY/z8R9HppTW15fOBHIxWm5NDPDcpklE8XHrTZk/U7bVWAnrz/JnhcWsNIAv+19J
	 6fZA9V0ZZQBZctaJnAJTY2x47KxIzH+amr5HbjrLQeJJJPlaZCAzhJmuS4J4dBXJXHCju
	 E7BKbvnAabKVf3XXDgm27M/jQubYE6nguWDp/7E3e5N9iYVw+MJ7f/EtLUQoXlHuFdGEC
	 jtH+pPMzW3A5f7rhki9n/MwAzJyJ3sBIT0/83JQDMNoUlRcC8qop4Lp9unususnTgw9Sz
	 qp7JTcX3t8ToOan0Oz+vjxjwT8EeR0e3E3ElCBDFNsm2lwaDE6bOQz5zLIPf7Lg2w5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871776;
	bh=gT2hZP/3KnB1lzX4mXgIbtS2L8uB+/0ZUS8X693oJRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZwcF33KXdZjR1KFbHdgS//mh/b8mBC3JUlIrsMbS6MVqvDyYptKXSRtH+Vc8Cmgor
	 hqGsDlX1q9F81uvRjNkjiS0aGHCpfAROiQz4gzLfN0oABq6yUvngScKpcLWRL2koF3
	 uhwQQDMu3oyhGlx6aFpoGa4Tj+W0pB+V3bX6fAJuJJHwwbfblcxgLx7/WIJ1QFo9/t
	 InhJ4T0HbKcHJ1gwHt2LprmxfTRKTytNsBEh46/OhHgFRvXC5cmktuY0H8s1CDmz/N
	 5cViZr4YyWKWrTVCzGbaNGR9TDqjomhmolNxbNx3T23SfTLYEUdmrjOIEulaZJ9Tc4
	 7AI3g4UYdgh2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18C1C80FA1;
	Sat, 28 Nov 2026 13:16:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B65849D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1832401A0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoMdZc9N30rO for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 07:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D77540112
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=q3H776st
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D77540112
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:43 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 200433FEB0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795852122;
 bh=gT2hZP/3KnB1lzX4mXgIbtS2L8uB+/0ZUS8X693oJRg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=q3H776stnaKfRg7KVGoT1E+sa627g2hmswpZmsvpOETuVInKF5aBb8/LM7upnsH12
 e8Q+oyxy8/xBb3e+IlNSuYXoidcDIlXeqyhYRdiqys0WzSavG4HD2p/hEf787E+oB8
 24gNeuKjAwdoR8f/M5hEHdZ9cDr+dBB8CUjJN2qdtn02HyCMaz+9z/FUMweAFSdapr
 toKOGMLbKW2EagJbAbTJ+nouPigBV1FkENABCy8oHLz7vv1tz3C8Pyj5fpsK17DJIm
 syx1BKpG3UhMfSp0MUt+Q82op49HVc79TDe88BbDghBgK4Xb1B5P0O0JgMRJWkP7di
 kNk5PZJfM2pcfla3+lXsWD2FMyOFY0OA8O8vKx+36/Vr3kO6vFZjv0assxzW5XHeW8
 MKxt2ftjoaBw69mnRyY3YKV6d91nr3gYT72vxlED79Xac2SjRX0NCn3HGnbcFxF7Z2
 ElSSWD00tPAROzRJHuyh1eNkPeXGrZgvQS7BnDFFn+QhZ8yPsTar162wHLyhUGQMH9
 lo/ws3HEPVkaxdRreb+ZcNcRykDvHaOwsYqmuVwsasL25ECQ+pKqgusOD5B84zNrO5
 L42SB3Vmr5WqrCUxXTmM46IXnwmu8I+k7aWuzTdam8v16mk4Y8ykzXX/qw29YE2cEM
 CZWi7ctQLyh+nOFyn7qfL5l4=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-89e05d31e54so5971974b3a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852120; x=1796456920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gT2hZP/3KnB1lzX4mXgIbtS2L8uB+/0ZUS8X693oJRg=;
 b=Bt+I8UjrLViMDpTDomI/sNvuiWOzy4xQgkJpG2+Nq/En0ihlT6RLUV3aYY4uG8iy7y
 DJ5uKQKoTx2m0btyqdqfbS12vBVIRtzHoLsKTCp3fef4qOPm49UXi7ILxOTqm0+VpJHT
 zScrA7WxNQMM2Q5ZTbv/OZXXIPRrsxq5OwA3JkvsH7NjYqcmfZP6WfTjNDC0yEKhmM+h
 eE4LxTeoll1pRZ4RKftEdXryivsivxIoc91FOk2FUUkKy+cTdGmKctshqKutHkeHessV
 3rTseyQU5boQ5eT58rRC3tQvZEWuqh0loP234akEbhO6lWA4oG/NNvWtPJlk+r2PkTBm
 szSg==
X-Gm-Message-State: APuU4Z/4Ba3iPMYuVYYBmX3UbGwJXuAPUohk13damnr6pmrEjj+l0A21
 yKikEGuWqmG+Zr2bJTfYMFuIr1tvZjHstJk1zcLxeUrGTylqxAzZ03YMKLHKo/ZXlOc2Q7FVTT4
 5JHUjD1FnTHfsLR8gap4EjmqBcy7nCF8lHW7J28txaxI0PdOt7mm1KGsWRraCJnRWbeInUyvqoY
 psErMwFXzjA4q5043BNQ==
X-Gm-Gg: AZFdTZccprPQrRWsBs9Q/nCO4WcgROsk4SgXUFjsUcGo5rdg1PLL3xk3fQQNMs+FzPB
 ZzWeO58IBn+xtIW52E92Pw+5QrYFRjffeeqHB2QwJis2+foUBzXzDpFpF6n7E4pjoIXey5OewWX
 RsthXz7nBhSK/NHvhvTUfDlqtf+CTYn7Qdm+ry6AP+PMGuhnaJ3cRhmVEFWZaMgfzTvXUDzEto8
 QV+4DdNmkd15prn0QdKYrLtC9l1ZGLjClBeU0mwqNiDvZ24+I+mwUOfP19xtD6lkLmyKmRnTWz5
 R4P+JCkGfV7k9Gr4rdmdhxxQoYHcVmlB19uch+cLPfQ3Gc544jFLHdQ7Nr3MgH/jST9O45+mSV6
 3aiz6UtBlNie8iHCY2G+lBDOvfXsP4I83Pj2yJ8L1Wv6Je/KziP9j3TSsyhw4BLwGSN/GAlYQkd
 4wn1Svu7bxh1M/aUjyQxZQgo63
X-Received: by 2002:a05:6a00:b56:b0:881:8b53:f64 with SMTP id
 d2e1a72fcca58-8c87d9fbdd0mr24960773b3a.59.1795852120494; 
 Fri, 27 Nov 2026 23:48:40 -0800 (PST)
X-Received: by 2002:a05:6a00:b56:b0:881:8b53:f64 with SMTP id
 d2e1a72fcca58-8c87d9fbdd0mr24960764b3a.59.1795852120039; 
 Fri, 27 Nov 2026 23:48:40 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm14086238b3a.28.2026.11.27.23.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 23:48:39 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
Subject: [PATCH v1 1/4] cmd: pstore: name the saved dump records after their
 zone
Date: Sat, 28 Nov 2026 07:47:37 +0000
Message-ID: <20261128074801.11306-2-aristo.chen@canonical.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux names the file of a dump record after the zone that holds it:
the record of dump zone 2 is dmesg-ramoops-2 in /sys/fs/pstore, even
when zone 0 or 1 holds no record, for example after its file was
deleted there. pstore display dump <n> also shows the record of zone n.

pstore save numbers the records that it saves instead, so a record
that follows a zone without a record gets another name than in Linux,
and another number than the one that pstore display dump takes. The
help text says that the names are like in /sys/fs/pstore.

Use the zone number in the name of the file.

The zone layout test saves a record from dump zone 1, so it now looks
for dmesg-ramoops-1.

Fixes: 9744d1a54784 ("cmd: Add command to display or save Linux PStore dumps")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/pstore.c                 | 6 ++----
 test/py/tests/test_pstore.py | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/cmd/pstore.c b/cmd/pstore.c
index 51d9ed93c38..7468e8824e2 100644
--- a/cmd/pstore.c
+++ b/cmd/pstore.c
@@ -491,11 +491,10 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 	save_argv[4] = path;
 	save_argv[5] = length;
 
-	/* Save all Dump records */
+	/* Save all Dump records, named after their zone as in Linux */
 	ptr = zones.dump.addr;
 	ptr_end = zones.dump_end;
-	index = 0;
-	while (ptr < ptr_end) {
+	for (index = 0; ptr < ptr_end; index++) {
 		size = pstore_get_buffer(PERSISTENT_RAM_SIG, ptr,
 					 zones.dump.size, buffer);
 		ptr += zones.dump.size;
@@ -514,7 +513,6 @@ static int pstore_save(struct cmd_tbl *cmdtp, int flag,  int argc,
 		snprintf(path, sizeof(path), "%s/dmesg-ramoops-%u%s", argv[3],
 			 index, compressed ? ".enc.z" : "");
 		do_save(cmdtp, flag, 6, save_argv, FS_TYPE_ANY);
-		index++;
 	}
 
 	sprintf(addr, "0x%08lx", (ulong)map_to_sysmem(buffer));
diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 1105a96220d..8473b7ff625 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -235,7 +235,7 @@ def test_pstore_zone_layout(ubman):
 
         with tempfile.TemporaryDirectory() as outdir:
             ubman.run_command('pstore save hostfs - %s' % (outdir))
-            with open('%s/dmesg-ramoops-0' % (outdir), 'rb') as f:
+            with open('%s/dmesg-ramoops-1' % (outdir), 'rb') as f:
                 assert(f.read() == dump)
             with open('%s/console-ramoops-0' % (outdir), 'rb') as f:
                 assert(f.read() == text)
-- 
2.43.0

