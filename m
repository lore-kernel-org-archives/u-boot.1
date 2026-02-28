Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16479FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381CF83FAF;
	Sat, 28 Feb 2026 21:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W4iIWuzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FAD83FAA; Sat, 28 Feb 2026 21:20:59 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A0B83CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c3484268so2244000a34.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310055; x=1772914855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koo15c5sNsEPjcrrTfx8HoBZ/bTKgxNJXpcN/7kCxbk=;
 b=W4iIWuzgy3jLStBGTwuBwxqiTfz1iJGv0ChEDUb4gP5C1Rqs/Y00F2lHosFvr0XpxJ
 AvR0dkE6mnjPLN4Ll1cv+mlEtHIqhGuxf+NhFBiNM6B+0gM9hEo0OaDfBnEAeCIv5Yi5
 4PH1hJeunglHg8+YwR217pyezVTlhgeZjt+BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310055; x=1772914855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koo15c5sNsEPjcrrTfx8HoBZ/bTKgxNJXpcN/7kCxbk=;
 b=Y9Ej1UCxYZiiXRDXMlyc23dGMEfvK1XztMekqyDxXeUnO38+Db4GEXdxbpA/IPi7JX
 hLpKY7XqzITA80B7loVIAj17tryVtm1LyCzZ0hXIyQkr7qIYRFyPBN7dhjinjfMlfMqw
 WIR9Or4D7Of1wmdWRcsrcVeaK+5/ChzfcmZj6WfKdR978NBzIBh3MqhT/p2lqOHX1NpX
 iVnUmbHdXwihBf7nl+5ylJFbQgQm3AXrZczjIc0ZjS6kBr7+8FW55yqevJdOaA0dTNUR
 FSNVGQWJouUsagdqa1eC0bdQ2geQuQgGqTaUgFnBitHCBQjBy8zDX603icdjm5N7sryM
 jtjA==
X-Gm-Message-State: AOJu0YyaNeY14bIyAIfNOPB8G19l/vo3l1S7moKixR/6d9ohGnoVuwRp
 1heD4qQu7QkxGsU2YnLDKo5rA1JFOob0ReVGpwGio7JSYOEC68upPYFg5GNSdrRJSVpF5YyQhCt
 nU80=
X-Gm-Gg: ATEYQzxnbKSkGMWYGBkQoBCFXevTAoPfUWt3/pRM8HqphOj+gvGCKNXr7xFob1Tc5/v
 JqToqfkN0zHzownqVc78gfy9nkYFoASUCauzrcxkrsu4UoP1WghR4XoGb2hNBIGCtF5CESJZmbw
 e88qINrYAwTuV+pF4R2kIJrw5SMowfSAsCxrqKSSZ+N97efJHJ4va+tkFfBHAL3cu8Q15g4NKtu
 vXlOXtmKkn75o+Wa5Dhty9LZ1JjBnsqtogjgyEfWgWXmFAjL738vVpML2Xes6mMRkyUXoYGJNwO
 ABTurLAY8RsxVatNryRAwzpvb6DFWbX52pvNfVO9BthR71nDvfFJd1nzPIuoJPDxLXPJ5zMsjbc
 j+B51I07TbdDk4DU/VW4wkgKWyGFtWQbhYQzbhLzVs/n0FHj/4aKqbtmK8O0DQp8ZQIq8bHYknW
 fMzEmjq1IcDJxpkgG1Jg==
X-Received: by 2002:a05:6830:61cc:b0:7cf:db30:bb62 with SMTP id
 46e09a7af769-7d591bc19famr4549171a34.17.1772310055083; 
 Sat, 28 Feb 2026 12:20:55 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/17] sandbox: Call bootm_final()
Date: Sat, 28 Feb 2026 13:20:05 -0700
Message-ID: <20260228202011.1834493-18-sjg@chromium.org>
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

Add a call to bootm_final() before the simulated kernel jump. This
adds the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on sandbox.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v3:
- Add new patch for sandbox conversion

 arch/sandbox/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 44ba8b52e13..561dad369be 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -73,6 +73,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
 		bootstage_mark(BOOTSTAGE_ID_RUN_OS);
+		bootm_final((flag & BOOTM_STATE_OS_FAKE_GO) ?
+			    BOOTM_FINAL_FAKE : 0);
 		printf("## Transferring control to Linux (at address %08lx)...\n",
 		       images->ep);
 		printf("sandbox: continuing, as we cannot run Linux\n");
-- 
2.43.0

