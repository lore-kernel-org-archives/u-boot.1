Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045CB10F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0309784106;
	Wed,  8 Apr 2026 18:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TRW4bVHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3C584106; Wed,  8 Apr 2026 16:04:38 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618BE8407E
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D02A3F648
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1775657076;
 bh=JundCE4mMIYy9PnhaHJQKnMSwD1qy+qfUkMn8hUqmuI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TRW4bVHh449i522p76o1M6mTRgEtbaTVo1E+2ozyDnCoiMApsDUTSkr36VVx5sspv
 VpLTfQtCa1OlsyqsvsLxa6iignbrn362kTK2SajHoiDlSIE+4tEhaZAfQKVYwDl938
 YWDLueiHK5H0E0l2nEvueTjytucF8HwDO0FqFGd8HCc8H9qcOzgGZET/Lpe65Wa49K
 MbIq/0Uy0OnntDWcblCb6vncrkptBvLlVNjrUDhFPy+r5hZvbELARODFn4P6T1JNEj
 /VIsRx4Pt5PP6In0NyHMmYZF6ow5v8MWzqljG0VkiGcZMwkZZMFx+lDRK1trXBQOLt
 O2maQlp0sfkmSUAJBg2WtGZNYnwcrC/ePa5bv3H63vLckdT0q9+5OhwERtNc45BVfs
 B1eaAHkPOrxsVtNh61hJcOYOGVf7QEV/BVzgWP17e02/LOxVBpKdt5IrYrbsigxG1l
 KSN8P+1SZAQnrIyLJL/MWLEgEWoxx79dbaqnhOVhg8P23ugqSuamNgQuI7OxKWblHm
 6MtmnHCHJkNFf+FHKQFA9xnIIvA5jGwA+HUcHP9LceJTrN8xxh2ahnX/QbwNEdrK6t
 zjYubDOl3Mi8hKXc3O0OqWukJfzfHFnNDF3D1RHF+8GWiv04BTcjcL4iYdaj+BSSGZ
 H3D/lgOExCHneTGmzYIkP+ak=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b24305cb3cso72957735ad.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775657074; x=1776261874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JundCE4mMIYy9PnhaHJQKnMSwD1qy+qfUkMn8hUqmuI=;
 b=Sb9fKWK6mz35M8dkRJQMyw6Wzr2OGopY7wRXJBT+AyO3INeSTSHrcH/h85GPROsnsE
 aecjZ82XTnzgLgmla0tjnViTd4dhJcli/DM0hhZXuB7nGTkCP2jLXEr3kBJbtp4Ld8Vo
 aAJgB+03i97zHZhlEMKCcJsNTSLJ2wYyxP7T/NhsIHSYQrqUgnUzAKhGE7+nCvAyb+26
 kYqC31ZRxkOBo7shhcTASl1dZ2GNf9u/qROY7MvgaiYrCjlwBgBP9KdWgYKS0dE0EkxP
 EctJTIvBw/rnjJdUB1UpqKbjtfJJEBF0SA+GLAZ10gaAJ5m3KXD2SXdz3Q+gCwjNZ9KL
 yfgQ==
X-Gm-Message-State: AOJu0Yxcy6ezfHZUDko8JBUbm4OK25Xm6gumRUh0UQS+Kt42GcRQH/7P
 s53YYSYaelbJk1eWeZ41+Cvm5d30F27NuBfHMGWap2UWilPk2nBKEaqhOwp+29tQqdAZcSbIXYr
 3gJnDEUWbP2h4YNRIsfTrb98WDsFm4yz8gKT/rlm7D9wf9pTY37MYUtqcgp/Kh8iDMxCAUFDJdJ
 bl0Agl2A==
X-Gm-Gg: AeBDievhV9gR0RTMqwLb3FeGfBjUmX9ULdmEM2+M4ZSAs/YM8ZnXA3PSv31en43TD4O
 aK1ULmvnIaNesLCAkDUsu05jnMXxSrlH40lQQ72nmijK5w30gTgjBXPIP2Jtyg4j+EvCJHP+N8W
 YyKaFtBRHuGTDtKSJuPM8agcPsa3OzdAjtFS1SetK0TEDZqT6p1kifEokfWpTll5D8cLd6yNNTD
 kyBOcn4qwD4U+Og4OTlA/nqI+0DuVP98+ZYmoQTH7m07/huyjXYprsqKB7YPDHuBkWNmyYjs+0M
 TmJhyl8xmoiA/G/Sfcnto57njDA+0AcqPGrReeDwKdIqCdYd5fni2XgcU9OCZcp/NFr/gMXDC7O
 AQNzwYGByBJVOjX6nVJM5Qg7lCkyJ39WcMT09lALO1jc9GkAhg81q8V1oYEcIzOLRW6nNyxen
X-Received: by 2002:a17:903:240a:b0:2b0:4b3a:9b4d with SMTP id
 d9443c01a7336-2b2816e965dmr203819365ad.20.1775657073417; 
 Wed, 08 Apr 2026 07:04:33 -0700 (PDT)
X-Received: by 2002:a17:903:240a:b0:2b0:4b3a:9b4d with SMTP id
 d9443c01a7336-2b2816e965dmr203817535ad.20.1775657070958; 
 Wed, 08 Apr 2026 07:04:30 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a3af9sm194312545ad.63.2026.04.08.07.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:04:29 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] test: env: add test for himport_r SIZE_MAX overflow
 guard
Date: Wed,  8 Apr 2026 14:03:36 +0000
Message-ID: <20260408140339.798015-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408140339.798015-1-aristo.chen@canonical.com>
References: <20260408140339.798015-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 18:59:06 +0200
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

Add a unit test that verifies himport_r rejects SIZE_MAX as the size
argument, ensuring the integer overflow guard added to lib/hashtable.c
is exercised and not accidentally regressed.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/env/hashtable.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/test/env/hashtable.c b/test/env/hashtable.c
index 16e49358888..ce9689f46d7 100644
--- a/test/env/hashtable.c
+++ b/test/env/hashtable.c
@@ -122,3 +122,20 @@ static int env_test_htab_deletes(struct unit_test_state *uts)
 	return 0;
 }
 ENV_TEST(env_test_htab_deletes, 0);
+
+/* Verify himport_r rejects SIZE_MAX to prevent integer overflow in malloc */
+static int env_test_htab_import_overflow(struct unit_test_state *uts)
+{
+	struct hsearch_data htab;
+
+	memset(&htab, 0, sizeof(htab));
+	ut_asserteq(1, hcreate_r(SIZE, &htab));
+
+	/* SIZE_MAX would cause malloc(size + 1) to wrap to malloc(0) */
+	ut_asserteq(0, himport_r(&htab, "", SIZE_MAX, '\0', 0, 0, 0, NULL));
+
+	hdestroy_r(&htab);
+	return 0;
+}
+
+ENV_TEST(env_test_htab_import_overflow, 0);
-- 
2.43.0

