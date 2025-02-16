Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CEEC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACA380F18;
	Sun, 16 Feb 2025 21:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hzPn+VvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D50C80F18; Sun, 16 Feb 2025 21:45:36 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3692980FD1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d19f5ce8a0so6564635ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738732; x=1740343532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWsIMg6fiEGJbjDUirRdL/40AhAt2lpLlXiqbL4p1RU=;
 b=hzPn+VvTaHoc2lWdEeKZhk1MJ+Pk2h+694O6U6bJKBw9HLWS80bAFTGt2NtC7qlB8P
 k8D+p1t4NzszneCJqqgP5eF6MxHXh21NwMewA5B0w/LiNsbxSankHkF6DediqHOqoyIy
 QWRpUKtAQhGD951hKfdlOLGpFzfHNewjYeN+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738732; x=1740343532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWsIMg6fiEGJbjDUirRdL/40AhAt2lpLlXiqbL4p1RU=;
 b=GsrWFR2xGf/Jkxx4njHJJyBHvvaE+und9Et3aDkdsEkHTOgTIkezOyv1QPsbCLeXmV
 Arc91ALM8laGW5OkUFpEJfw/aqEUeH9ktc992jLwjqrDfPlD/0DG4b/nLlpCzxXiVFq1
 xnu6rz+yu7yINsb8Sbj78P4GDP9xp1w1OpaldNk9JLuCJV1ZD+jSUmf/Wv2HtRZLT5vE
 PZkyAhEpcfJA6pRQYWXUB/etieuPHb8mZpXjVQuUd3/N69yDVDfY4iKYxGWzHHYQeZE0
 QmQrkBW1XUuao7ddSCwNj05N24BAKtCwvYQFHh2b+WBVoGpmQNNV8H3VFb2dTxzrYGLY
 gKFQ==
X-Gm-Message-State: AOJu0YzA0zEqFse/CHQFsfP40u34eAW3dxkCGNhv4JtblFLfddSRYa8z
 6wEds/o+wMzHuKseFrlJvxMBwbu0dyN++RH99SUmvC9Ql1EARiEjNAJYN90IIrG8mKVdgn5uEKg
 =
X-Gm-Gg: ASbGncvFceSilJrjHsxUrN5dpMzHRmuQF11rlaT4t+v30fmv0NxyoJc8Ev3NvkmNV+x
 0PLdUWuDQamLJ1LO1JLOsDoxUBxcEMwy1/2J0ozQaPq4SNgKIQEKRBN7cVY5B+3DbelRs2nM4BV
 AboYMcNTC/rfUTc8MR5hRvW3UGYNEQuoRPaRwL04Pg1wgGu6i6IQOxXXbR7vELVSD23MgvIB5PB
 nvxb08vFRbHYawANwVqgBMftOZCDe3I7lNOjqY+pdE5bapNMpp0SV+FK4EQIS9lkVg7Z200HbgW
 lPgbomryUHnF3rwZqVxkUqr+bMfzr0TlTZ1WIWrWanaZHYHLkJl+
X-Google-Smtp-Source: AGHT+IHglMFpdES5X/ZyhjtGDb0Wl6TGX3Ze7q4e6qylvAcvj7zulQb+ZEnVT0c7OVO2n8VBF2PQTg==
X-Received: by 2002:a05:6e02:4c1:b0:3d1:5037:c97a with SMTP id
 e9e14a558f8ab-3d18cc66fddmr116275595ab.3.1739738732404; 
 Sun, 16 Feb 2025 12:45:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/28] x86: Rename the _D dirty flag
Date: Sun, 16 Feb 2025 13:44:03 -0700
Message-ID: <20250216204421.3560012-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

This value happens to be used by ctype.h so chose a different name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to rename the _D dirty flag

 arch/x86/cpu/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 845e00ca439..b108f724c51 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -596,7 +596,7 @@ int cpu_has_64bit(void)
 #define _RW   BIT(1)	/* write allowed */
 #define _US   BIT(2)	/* user-access allowed */
 #define _A    BIT(5)	/* has been accessed */
-#define _D    BIT(6)	/* has been written to */
+#define _DT   BIT(6)	/* has been written to */
 #define _PS   BIT(7)	/* indicates 2MB page size here */
 
 /**
@@ -620,7 +620,7 @@ static void build_pagetable(uint32_t *pgtable)
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _DT +
 					 (i << 21UL);
 }
 
-- 
2.43.0

