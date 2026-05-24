Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9588BCD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 23:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D93844CF;
	Mon, 25 May 2026 01:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="stthaIj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF74848C0; Sun, 24 May 2026 17:14:52 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D988489D
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 17:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B4203F286
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779635690;
 bh=uxIjJE7JjINyrrLIMub3NG1PX5BrWC9/8gRO5FIlj2w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=stthaIj8pAsEKRLxzpFL4xBihPpep6Si+avrkf8dDSw3bg4HJLvwVcdbyJM4Lk6AR
 c9pJVB76ebm3dwwLXm2+E2RUhgZ2AbUPqL+SBqD6QiPKFW2WpyVg89qVga3h1ye5mS
 +s2l8zlbWXkXZBeTV1k3EpGlL21clg0NwjZZbHAp8FDJFSR6JP7e9K46b2LIXDD7Mi
 QWG8wqzBK0jeEPeCt7w+jXE+1f9m/RduXV+Eu2QXKZrzHeBQGvlqyPYe80/2HFC4wo
 tEcP4ymM2SMaKWJzl4bb5XfIdEFHJkTB5IExV7sBg6SAUCEWrWm8p/WnlsjcAoK/xh
 0zKuyMcZfRiDA84Ll81kgbsnMFtX/3V5mFhLs+GqIBOt4ylN9t+BL8zJ/lnMeWkLW6
 O7yW8JFyB6d/Fu3nUhoB58GiBUzZw9NKlxcY3XjiF4oEIhLc64m1aIA6fMdnfqq2KN
 6TsWClyTeZc/vbri6oxZOhA0rktwK2GZrOJyAsPp574qcVhEo5CwhenWJSXsMAZsCt
 Na0xOCFtY8DWUiBy2qw7IpSF1eIYUO+yyhaJ/2uWxmKkyhGo1oc++vfzCBG8srDZt1
 UNY5fGMHM5XtF3OU2mPsxJfL0RiSiQ9Q/JSiSKZAvkytHGhpzXYyNo3iAmL3BKi5al
 abVFstg5Vhp/KokvDoPwVLGA=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-365faf6006dso8683748a91.1
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 08:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779635688; x=1780240488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxIjJE7JjINyrrLIMub3NG1PX5BrWC9/8gRO5FIlj2w=;
 b=QGECEtSKAW5/1S0PfP429IXrY/BtsqlNO8dPMCTu7F0v6hmUT8VuBGVY4sRvhqqDPO
 IJGDY4saVimrUbZTVCqmfvRn+Aw58UYTYZ1+nsAraMcEpeVMgrSlJYb+aEx7tuMLfR3U
 65ZUfPFNtrsN3JZxlGk51ZoY+asTCVTpZmVUB3bGve4+HDlbYeRVNXgfL1IFFwN7V4JZ
 obGNnxMIIbyhirTB5iK8MMYL2aA5pHhYMWlvy7xT0rvsP8E3Foozo21r4XtRDlguuQEa
 LuO27+s/s3iHhrlFpzqe1TGdOHErMEMcpQxM9mo739csOEIN3AEuBc8FQ7FaYIpH5YIH
 yolg==
X-Gm-Message-State: AOJu0Yy9t1PfpLHKo59Y/wCJXNw/wHmquUGYzISjXxdtlesBs2Y19YGE
 TAqk+dRPGiPojmdexAgsJO9GXfj79vhnO+rsxqVsmADV53v4jzcbphYg4zbaj5xHRNo0vw44bm3
 3dWySne5p/09W9nCuQqEuFwAdTxqD1+uvNPjPxwx38OHjSX2NedcVVrQeWP09qGRKQAH7drCDrg
 S+/wg=
X-Gm-Gg: Acq92OFwWd8UKZK1XTqhikWsfQwuSG2Rzh3cwfAB8FFYY4Z5JVCK+aWbLuTW6BCNx2q
 po3EJWmF8stuAtME4tKAuLN0TE/DN3szFY+4rDw7fk2QLUjwCmRoCP1zIiSbz2s1LOUS54xaIdy
 rCg70m8yd4hQ0IZmKlG59SqLjKlP1XxqCs/o5E28gtSW8HZoXUAEItXkt+nO0Ig0UWRWFCzbHk5
 EOEwp3SrVVw2zBXzfqms42SiW7FJkLRg2pwjwLCZ2pWKbjb7lu/4gZNDvXwTMoTvfVWpblfyzLA
 5U1u52slywAj4L7K1GfDwbYRJ431gDD67sKA549rT+YqgQJw1W/tqBxJprb7jrHqp+sSUd++xt3
 oknWYzpiMDPpByC3AyT2e0TpRF+6gCXrF4tFxZBEP/H6Xu9aY4630xawg4zcmQGMIuEE741ajpm
 TmWwc6Ab4=
X-Received: by 2002:a17:90b:544f:b0:36a:b560:5c5a with SMTP id
 98e67ed59e1d1-36ab5605f73mr3264191a91.5.1779635688573; 
 Sun, 24 May 2026 08:14:48 -0700 (PDT)
X-Received: by 2002:a17:90b:544f:b0:36a:b560:5c5a with SMTP id
 98e67ed59e1d1-36ab5605f73mr3264178a91.5.1779635688210; 
 Sun, 24 May 2026 08:14:48 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a71ecf799sm7097940a91.8.2026.05.24.08.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 08:14:47 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v1] bootm: bound-check OS index in bootm_os_get_boot_func()
Date: Sun, 24 May 2026 15:13:16 +0000
Message-ID: <20260524151431.72296-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 01:11:45 +0200
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

The boot_os[] table in bootm_os.c is a sparse array whose compile-time
size is set by its largest designated initializer (IH_OS_ELF), giving
it IH_OS_ELF + 1 entries. The accessor bootm_os_get_boot_func() returns
boot_os[os] without any bound check, even though the caller in
bootm_run_states() passes images->os.os straight through. That field is
populated by image_get_os() from the raw 8-bit ih_os byte of a legacy
uImage, and by fit_image_get_os() for a FIT, neither of which clamps
the value against the table size.

An attacker-supplied image whose OS field falls outside the populated
range therefore drives an out-of-bounds read of boot_os[]. The caller
only rejects a NULL return, so a non-NULL adjacent global is accepted
as a valid handler and invoked through the indirect call in
boot_selected_os(), turning an unsigned image with a malformed header
into a jump through an attacker-influenced function pointer. FIT
signature verification covers the os property and mitigates this path
for signed images, but legacy bootm and unsigned FIT do not.

Reject out-of-range indices in bootm_os_get_boot_func() so the existing
NULL handling in bootm_run_states() reports an unsupported OS and
declines to boot the image.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ae20b555f5c..69aa577a2fc 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -599,5 +599,7 @@ int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn)
 
 boot_os_fn *bootm_os_get_boot_func(int os)
 {
+	if (os < 0 || os >= ARRAY_SIZE(boot_os))
+		return NULL;
 	return boot_os[os];
 }
-- 
2.43.0

