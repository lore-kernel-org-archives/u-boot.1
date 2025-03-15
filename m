Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD76C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61369819FC;
	Sat, 15 Mar 2025 15:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XlW3KKFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06618129F; Sat, 15 Mar 2025 15:27:37 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EE481C67
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso3700455e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048854; x=1742653654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=XlW3KKFYKDtJvAaJODChuuRi4iL6PZA1OvqkFF5oenSl8Vgg9QOyIURkA69vl2DUix
 NhMfVsOfgA1h4q63SNWWt3LnFuTi5VOqe/H0uz6Q7TpeyUgrIitA7Nu1GJVdHo7z9ctS
 WrBaM8sfQ0yiIkJT6uSqjGW3uWSgm95EOWmq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048854; x=1742653654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=bafna+nvU5b1c+Lrn1rgOWhmf9e/WvQmSFk6Z/H7VDHXawpXfcdN+vRgpWVNunet0R
 WzXEZZvzbRgLa58pCQSx42SEJad6Nw+88hCkEihoR4Mvgovtm+r+bFU+xGXWsTcYbsRE
 1vngI0ZmB7DhCd/YC08Uihr5Hcv5cvBK1nDcFa+25C3PEieH/bdMxBDsgVL0oVzOuQoc
 sDhIZCd7VKexbm/WX7TUBbkapkQfBi7fLBRuYVcM6pl0lraRlkZ2P5N96DneZ7GQp8aO
 2KNvDDN5bG7rnS7YJwYngomPSTiyi48d+ElGKG7/DzyCc4rdS9Q3zCcS7bTo/iJXO5Ii
 87PA==
X-Gm-Message-State: AOJu0Ywmzd8OuJREONJ0YHrUx8Xq3os3dbebZY/TUMtr5yuyeCWcbvID
 VoHFb9/9OgbeUZ81W2uoy747XgAbI7muQNVygYSVnegVEoSjyeArJjispfRYnC+F6KKEKked8Kn
 UxQ==
X-Gm-Gg: ASbGncvi8Ubdw+rxi+fMmZqI58sb9sCtUh8j6vlNiUg1/L+p5UmzMYKUQ0lbTdqEYGe
 lDhd3iHwnr71Ci+h04T0qk3r3A2Jbqy2KZr2DO9bA4bKatpoJ7YpJvE38jMmX64wZWPjpxqhv1F
 LdSxjK3930C0bcBY3OelMpgtmZgKUUtSW4Xajva+xOXJe5srIlxll2KlsrBEnbicUJHH97hfb/G
 MN7/hcD7tmquAutHKsUEwCJbJzIn3DwmgfZ06BNFJTN4UeSAYbHR4pg7LhpFr4GCX4Kfrof17xl
 fenf0Kn3KJ3+ryTQC6aCrxqs4A4EA1+ezfrDhfJ1UA==
X-Google-Smtp-Source: AGHT+IFvQ2deUo2FYoHvunhbcyB+NwuTUIRY70o5f/RQKOxkFAyMz36ZMe27r4+mkYgIpWZXbUaMDA==
X-Received: by 2002:a05:600c:210d:b0:43b:c305:3954 with SMTP id
 5b1f17b1804b1-43d18081271mr111586815e9.8.1742048854270; 
 Sat, 15 Mar 2025 07:27:34 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 12/46] x86: Use defines for the cache flags
Date: Sat, 15 Mar 2025 14:25:32 +0000
Message-ID: <20250315142643.2600605-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Use some named flags when setting up the cache, so it is easier to see
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/cpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 3bbad3b2eca..845e00ca439 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -592,6 +592,13 @@ int cpu_has_64bit(void)
 #define PAGETABLE_BASE		0x80000
 #define PAGETABLE_SIZE		(6 * 4096)
 
+#define _PRES BIT(0)	/* present */
+#define _RW   BIT(1)	/* write allowed */
+#define _US   BIT(2)	/* user-access allowed */
+#define _A    BIT(5)	/* has been accessed */
+#define _D    BIT(6)	/* has been written to */
+#define _PS   BIT(7)	/* indicates 2MB page size here */
+
 /**
  * build_pagetable() - build a flat 4GiB page table structure for 64-bti mode
  *
@@ -604,15 +611,17 @@ static void build_pagetable(uint32_t *pgtable)
 	memset(pgtable, '\0', PAGETABLE_SIZE);
 
 	/* Level 4 needs a single entry */
-	pgtable[0] = (ulong)&pgtable[1024] + 7;
+	pgtable[0] = (ulong)&pgtable[1024] + _PRES + _RW + _US + _A;
 
 	/* Level 3 has one 64-bit entry for each GiB of memory */
 	for (i = 0; i < 4; i++)
-		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i + 7;
+		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i +
+			_PRES + _RW + _US + _A;
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = 0x183 + (i << 21UL);
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+					 (i << 21UL);
 }
 
 int cpu_jump_to_64bit(ulong setup_base, ulong target)
-- 
2.43.0

