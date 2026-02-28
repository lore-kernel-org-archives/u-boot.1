Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3877FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63DD83F5B;
	Sat, 28 Feb 2026 21:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mu4UeeOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C1483FAA; Sat, 28 Feb 2026 21:20:58 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8583883F54
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so2024604a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310053; x=1772914853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxL1ABvy8fQTz2fHODU9vgE2ri/q9819Yy7aO/XgT9I=;
 b=mu4UeeOV1MTEMtgAgKTu3J86A5mrJRpMQJcEub3pT4PWoFJTQ1WWgP5MWy0qOAL7WV
 XOexhyB6ZhMo+3TbpQAfj6wg0rbZ5sXzk7qJmDgzlKfF4igeSpB+PXJUtVykk0UMx/VE
 WyvKPN/8DPHAz/4gkUZBFokqpsiiUBwPbn3cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310053; x=1772914853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxL1ABvy8fQTz2fHODU9vgE2ri/q9819Yy7aO/XgT9I=;
 b=D3jphvQNFnTg1kvpsoUArTbUbndkvzbJGxtWIsOle/a1FoImreTnAe63eT2Yizu6Z0
 eoYS6jddB2I71NjOsuoAt1HEYVxI7+j5pm4iFR08MGw6NuUfkMHz0/vmu2+Ocoguv1yz
 NG2aQYS3H3R05ZyBVBUfD0S37Tjmc6O7UnIsH1sFGrQsfOaWhBVZXqWPGnuVA6F4vcP4
 R6fFJCZ4D6tiklp4lQwNANdrZFU2nYDtngWw5FGqor55zSyoZb2h1WViFOvyK8UCcijS
 9w1K353l3BdO01hpx323LPGbYmtBm3dpE6DEkzRHugtki5M1MOnEiBUzsJ7GiB40eLxx
 93VA==
X-Gm-Message-State: AOJu0Yxn5ZwgajEVjF80x6gYOsFD019+D5UeC2vSnyMMWeqi9HdT1oNf
 b+pu631LjIrB3tgiqeo0v7OGz2gzG538VuzwFDAKr8JJJtjoGyeb9mcQnkpb44OGBuL5JNg+KyZ
 SDpg=
X-Gm-Gg: ATEYQzzVVaz+f7NRP2v5H/gYDUktCAaIxbHS/7a75c8HVEfWyr4o9eHag7lREbZmNWD
 0+9k9WRzg6THX9B3vxICmDyA645A6x1tz+L5gb6pRR5wrwIoQCwY+iWZEJrhSPpzaO1VdBR+DnL
 apXmOplRzozDlqWRIzT/3Ptu2VZ5isNTRV000w0J2w0s69ClKxpCsc9haWox7p3u15pvIog6jD8
 z4WIxXN+hEw5UyjRmL2fzGcnreUKqxYciBw5jFGKGef0aSz9NPpVPUQ7PdTAMvrB+ZUZ+hJpAPM
 RJgXm/buRQSFc/dkyQIIF8Z36Z7if7osLjfamHPcR8d+N/iYRycEo8fXpYW2LCax1VZEqenRwnH
 oTubFPUO2UCoM+oqDbszgaG/PO9YqZ4l2ITBGFbxfI/bdHRfRn+ni+bd8Ehxb+KyWSYRL2GxS4Z
 uNgU4b0+tpQ6b/f3CdCA==
X-Received: by 2002:a05:6830:6999:b0:7c7:6063:8e0f with SMTP id
 46e09a7af769-7d591b39a1fmr4658048a34.15.1772310053302; 
 Sat, 28 Feb 2026 12:20:53 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 16/17] xtensa: Call bootm_final()
Date: Sat, 28 Feb 2026 13:20:04 -0700
Message-ID: <20260228202011.1834493-17-sjg@chromium.org>
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

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on Xtensa.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for Xtensa conversion

 arch/xtensa/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index 2958f207397..627fa918769 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -178,6 +178,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	printf("Transferring Control to Linux @0x%08lx ...\n\n",
 	       (ulong)images->ep);
 
+	bootm_final((flag & BOOTM_STATE_OS_FAKE_GO) ? BOOTM_FINAL_FAKE : 0);
+
 	flush_dcache_range((unsigned long)params_start, (unsigned long)params);
 
 	if (flag & BOOTM_STATE_OS_FAKE_GO)
-- 
2.43.0

