Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896C4C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B670181B42;
	Thu,  6 Mar 2025 17:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QUt7SXYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5837805D7; Thu,  6 Mar 2025 17:05:39 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA4880E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d439f01698so2656585ab.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277136; x=1741881936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwCi5fFcCIl+1HqI/RJOgU0oPJvgxI88vMsJeVwX3JQ=;
 b=QUt7SXYO0kaR9REPeUPHjAnzyQ7Tv70DlToADAoJo7KvoZV/IgU39CcokunPCQvKhE
 ULCPkRhbMJ9RvV0k3CBs6tjpC0HK/HOU/1aWujCLfspW6uRJKnZav3vaXE9Va5ROPcIW
 Rolbtxf+bk+oT2eTn2JSN4zNGZYIhBxC0/lqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277136; x=1741881936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwCi5fFcCIl+1HqI/RJOgU0oPJvgxI88vMsJeVwX3JQ=;
 b=r7oKGA0TwSR1IrHiR8GP2EeymQ27m7xYmZrIXYLBQzG10/a2+v2hIc7MfsO93/hY5m
 jjFy/RW1akOmY7t7Gdb7GY+Y44SMxatgTrj6hBHxBAi9UzxZh4fFgOTa0uKKKtaXqQe6
 TRHWBGn6DWpEw6gu/z4mbXd8xPljBBG6469+ZncR6R9cHpE9ha+M16GglhnJgDj0lffV
 ykETw7WeWmsyBpDFkN13qKNCf9HSmb/0R1QYsi8/+bvfOSXfMpCtoU7Qd32U/IE03kkO
 nZJhbq1mTyQ9lNHCAhwbOnuak2gbedC3dbe4AjKlHM32YJAbfxY8dzgXLe+bKTRua9Hl
 O5pg==
X-Gm-Message-State: AOJu0Yy8HR/QjhgVzpGf3AnbKjZp/ADo+pzu3bp+i2P1wfM5U1Ed7/7/
 9l1NIVV0SSELEPiCZZYbbFn7Br5PDYOfc52u2uGALCaSF+fGHYwSfD88Q6MnzFplbeAzob8lhn8
 =
X-Gm-Gg: ASbGncshoKKPW6YAmDqabj+hWw9Y5aws1dgmar02ZckENiAAVMFMSUIgEB7BJWziDJf
 FTrBSwWCBD1WSodpu+FKWPtlb7bpMnkkDBMGnL4n+guzAFd0g8ygSjeWERGvu6Shn+ZDU5lRi4y
 547KU1+wA5ZRStdFFoCoS7TjFaIWUoud1VAuHoEOPhSAWVnJ3K8y6jnhIGGNwTWD7P/k2S+Ab6z
 cL8t9CtwJCqtjjlighX2uEBsJs1CJBquePPxWxLRUey0ZREdpQUlfH0LKkbYHWuXVzN/VRv6b5x
 8lgk5odJcb8yLFUX7Z57IXdL4yADZF9VteSPriVgI9+rp0r4QuWtY+C78zWeuNHd3+5BXP7e628
 doCcRcg==
X-Google-Smtp-Source: AGHT+IFR/TQg1m/l0oDyoigqPvb5Cv8S1oc6tKRPOfr+VHjzMOQAGDvlXe+YvKVSGWIoTIoR5y+Qcg==
X-Received: by 2002:a92:d945:0:b0:3d2:ed3c:67a8 with SMTP id
 e9e14a558f8ab-3d436aa213fmr36270575ab.4.1741277135861; 
 Thu, 06 Mar 2025 08:05:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 23/47] x86: Update mtrr command to support 64-bit values
Date: Thu,  6 Mar 2025 09:03:50 -0700
Message-ID: <20250306160428.3041057-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

The MTRR registers have 64-bit values. Update the command to use 64-bit
values so that memory larger than 4GB can be handled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to update mtrr command to support 64-bit values

 cmd/x86/mtrr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index 93be84f74b8..289865515ef 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -13,7 +13,7 @@
 static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 {
 	const char *typename = argv[0];
-	uint32_t start, size;
+	u64 start, size;
 	u64 base, mask;
 	int type = -1;
 	bool valid;
@@ -26,8 +26,8 @@ static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 		printf("Invalid type name %s\n", typename);
 		return CMD_RET_USAGE;
 	}
-	start = hextoul(argv[1], NULL);
-	size = hextoul(argv[2], NULL);
+	start = hextoull(argv[1], NULL);
+	size = hextoull(argv[2], NULL);
 
 	base = start | type;
 	valid = native_read_msr(MTRR_PHYS_MASK_MSR(reg)) & MTRR_PHYS_MASK_VALID;
-- 
2.43.0

