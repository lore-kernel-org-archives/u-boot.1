Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B91FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFFB83F82;
	Sat, 28 Feb 2026 21:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IR9JOzJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9448083F54; Sat, 28 Feb 2026 21:20:44 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE8D83F5B
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4d8712b40so1430702a34.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310040; x=1772914840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8II85Fpcy0BmiTQUhstumrZ+fVbNoqSb8gxRp0PFRr0=;
 b=IR9JOzJHAt8/o63o7x7Uwg34pLi7ey+yeI61jGHnPV2DMaEARxBKt3fIT+pjlhyRZY
 Ymenpo2Ziqpj3f73KUi/tt4VR9w7s2wIN57jTdJA2L2E5a3R+IWz1OpjNcOGrEGYoTzf
 WmCQDoydOq707UFmDbiU8CSYNv/ljCrw9JqzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310040; x=1772914840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8II85Fpcy0BmiTQUhstumrZ+fVbNoqSb8gxRp0PFRr0=;
 b=riSHy8VmQMX32TFqA+lqQD/dWKIB2SRQw4dGZiv9bVPuVqaJcA9k+jpSgztny2PisI
 9eL0wF1sv/2Fbv/3pHhwn3Gmrl4IoZgH5wAUY8KtkVF7O23r2OzMUMiIeP7VX0iOZI6f
 u/bL9L4GYky15A/4m4JBSKmDEsc86LIfNV3KZS7MGspGHH9zKNPG4p4FUBWuJThd/8Oo
 +9dp2k97rZgKbieN0R3c2/SHM0tPHlRY+uRa4Dc7EvMZAHP6ZJm7UrrqHQbPqTh5iWuD
 rodDlC0TVQYljbuxnCitwkib8QL0Tie7fUJJd26qfiNNbvdmjwVKzCiT4YorOAD6fcrm
 wLZQ==
X-Gm-Message-State: AOJu0YyAbzyg5Y0LZOqiBrJrpB3BjcVS8bPZ9/7NAfnMjXtglfHtWih2
 X/RtMFFWcvww+RKi6P2pBBia1/GVVW0iBexHBhAa6AAsDrBBviDaaMxGqSDs53K/NiQT9jKtiV+
 21Gg=
X-Gm-Gg: ATEYQzwDFkL0pBWl4RVCft/wbe/0Pl9nx1yJev3/CCacmPgXnuVUXiVLn05L2Y9h450
 +xlmktC0qlAtsswT9sxSrfDoUZXYGXTsFbvsLmXVZV1mto6/bcRQpkYTQRC2BrxQNfCmVkigWnj
 s4iBvlut9BjGDVcB7G/yM1DlIPTNaXr/WQm1n96uzUgJHcxYKBPZEu6IKKuAJ9HHFlcy7lrQL8n
 Qa5VSeoguaHGzE/ZWya6nE3z5JdDFmb+yK1GemQM5xSKs4kws9C2m+vvbyvTTzjCJYmBrdSHKLO
 XQW6/JEgzuJjAk+LFv0pxsyhaYTDBhlMiP9nzAj1mQe0w0Szk1MDThxiRmKvK6tjm2/VtXztMAD
 8WjR2oUIgWBkSJoO3nPdJqm/XxMhI2QjpoapkN6AUX3bY2ijl9trRtK19d7nGM+LX2XzDQF/c8t
 nO81wA6QGdlSj8uLf5Ww==
X-Received: by 2002:a05:6830:380b:b0:7c7:55e3:9117 with SMTP id
 46e09a7af769-7d591bc1e3cmr4790737a34.22.1772310040024; 
 Sat, 28 Feb 2026 12:20:40 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 10/17] microblaze: Call bootm_final()
Date: Sat, 28 Feb 2026 13:19:58 -0700
Message-ID: <20260228202011.1834493-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Replace the open-coded printf and bootstage_mark_name with a call to
bootm_final(). This also adds board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on
MicroBlaze.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for MicroBlaze conversion

 arch/microblaze/lib/bootm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index 2410515f4ac..ef2ef6171ab 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -36,9 +36,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	      cmdline, rd_start, dt);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-	printf("\nStarting kernel ...%s\n\n", fake ?
-	       "(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+	bootm_final(fake ? BOOTM_FINAL_FAKE : 0);
 
 	flush_cache_all();
 
-- 
2.43.0

