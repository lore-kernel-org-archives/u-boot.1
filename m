Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75577E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1D2387242;
	Mon,  2 Oct 2023 03:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GVILjJC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B5887253; Mon,  2 Oct 2023 03:18:00 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8A08723E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3512740906dso46299855ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209375; x=1696814175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMpGCSnSZSuNOcfUgEMpTMWGM0trZQFTZzt1Dvzh63s=;
 b=GVILjJC0Kp8xB/REkzBsRgS7QL407ZxyqrGmp88EukE9n1fHNo75G844NNePw8J+Kn
 Eu3XJ6flnbiPVE2cEm2hFQv88veHLwSxs5VvjRoYpeBpO5EmwyeiWXDwc0n5Rk1lu0u/
 hYC1TVp6PSuIu0AVUWqwfSEZ6JMryROmHvS8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209375; x=1696814175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMpGCSnSZSuNOcfUgEMpTMWGM0trZQFTZzt1Dvzh63s=;
 b=NUyuQSFnNWnQ6mDwar+OMUQhiryzlJHu4MdO/YQUgWcEhTpG7mYLEmwnGuBWmEB3c8
 NSMrZ+ZmHT6Qf6eH+dirIi+HNF8A1qBcCjums3eAdveqnUxisGB/5P53SzEj/SYPCBNd
 hQtWiaqpRpaqpq/K/9XAEF8Qql1LquDc7o89k42NfgvDXRY6EN5B0ttbQtLv91VqRPpP
 PR3CoPkHA2x3CbFLvdY0MfylnblJ7FAdgWKxYBAheHup34G4H3d7QgcyLdW5Y5z081Yb
 ShGp5N7z3/H5Dzt1RSAP+xSHo5ZRI6/CPV1r0HJECt7l+M5ko6SH+foft5T+OvWiUj3q
 q9Ug==
X-Gm-Message-State: AOJu0YzGQRqkJ3dLHELWXQOVGZZFTOzcTu10KMvch/fNN7p2HTyscq6G
 vl7kqa1tTmoXtDOO0tXnO62KSPxvt2LJ+qOXdNk=
X-Google-Smtp-Source: AGHT+IFcmONtRZOBktuiZi6lomJr3a0RKHlxNAvwEFOGIsuqPA6hwtSHy5uVm/yT7rj4mdVxWk6M7A==
X-Received: by 2002:a05:6e02:12e3:b0:351:4bf9:5b02 with SMTP id
 l3-20020a056e0212e300b003514bf95b02mr13448343iln.7.1696209375353; 
 Sun, 01 Oct 2023 18:16:15 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/34] test: print: Skip test on x86
Date: Sun,  1 Oct 2023 19:15:22 -0600
Message-ID: <20231002011553.463514-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These tests cannot work on x86 machines as memory at address zero is
not writable. Add a condition to skip these.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/print_ut.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/print_ut.c b/test/print_ut.c
index b26f6281b013..bb844d2542b7 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -170,6 +170,10 @@ static int print_display_buffer(struct unit_test_state *uts)
 	u8 *buf;
 	int i;
 
+	/* This test requires writable memory at zero */
+	if (IS_ENABLED(CONFIG_X86))
+		return -EAGAIN;
+
 	buf = map_sysmem(0, BUF_SIZE);
 	memset(buf, '\0', BUF_SIZE);
 	for (i = 0; i < 0x11; i++)
@@ -275,6 +279,10 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	u8 *buf;
 	int i;
 
+	/* This test requires writable memory at zero */
+	if (IS_ENABLED(CONFIG_X86))
+		return -EAGAIN;
+
 	buf = map_sysmem(0, BUF_SIZE);
 	memset(buf, '\0', BUF_SIZE);
 	for (i = 0; i < 0x11; i++)
-- 
2.42.0.582.g8ccd20d70d-goog

