Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5284C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1FB8192A;
	Thu,  6 Mar 2025 17:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C50ctFxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D9D817E6; Thu,  6 Mar 2025 17:05:15 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CCA805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85add719f7aso24873539f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277111; x=1741881911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=C50ctFxGjLcXiyCHerSyGaFfQiGLdph/xPR1KILxtzlk4skvjpznIN4w6vpWVvWhB1
 vjTXzqUHlXzkfyzUGSXWJBBiPn73aVNx6pxUOegAo+HH67IfFOTZs8cMzAa72BSVIQS/
 d2RKx1SV4sY9iCMo2bl8HW6ZaL6LMe0griRG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277111; x=1741881911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=DjK1+9mcwz0orNTKlx/faj1Ili5lrmoFh31+pT1mHkej6NfgFfu7mXQ9PUt8b5+zT4
 gd0kdPMp6N1yuN1D7192MRzLV7d9w5IGEeRgfKDquRwoUYcF2Dt6fpX86RDhU6HVeURZ
 h7qVgi1mv7Fj8HRL4baTl3dIL95/ZPa6Dvi46M8JS7PPJ3VbpOjm86UBe8CyoFBRDp8r
 DuynEhRkC7XEYktM1NSXubtRQuRlrK42e7sDZ2ANxk/jFSOgq7WCp/L+mmA0MJbfQL+1
 n9JpHShxWvVY1Tr4yxzDsCEgfhl8hYz9xYrSsDYEReGcNaO/XeSBfyw9SvzHYkjE/a3a
 yBug==
X-Gm-Message-State: AOJu0Yyq9vgKXIvnpshCtRh4inzHWQNLhPcZdrTiLMo35IlqHI/0G3RV
 y1ewVwiLsAktH1y0eIBcn230BLskjlm9wlbqEMz2XYgiIi1F/h0xa59fjadotb51E+HwlC5C73o
 =
X-Gm-Gg: ASbGncvo3WC6FhOlbYI0JdkMSQsxfFiYmAPOz27kIrYWNwx4NqF79luX9zGthO0THKl
 FpN17Km/SxdUj9rXvkanPUAtxmvBpEhticNktE9o5l/rHPDh7vkozQzQavD2NXtmiE9eEpGiMxk
 xlRjaTGBVNsJrBGwB9QbsO5knGEqnaGxXqx1vepvvI9bpdxA5Ekb3/XhQS8h6zIWzYl4Q11TA/Y
 Ckocz2ROI1SLvBrLoyC99tRWGDqOVL95TXTHQ45lGBLhgnqWl4De1HwdJ1QcmrIlrtdTSy/1Bj+
 3DdL87rihyBkgLZunExUScX+p0NOUoyjmpIG8EZv78EP3TKmSULszWFFw9wZQiysOeJXOXIShiH
 Jh7q4Yg==
X-Google-Smtp-Source: AGHT+IES27Xv8iJqU7plzgogoQF0mWZMH1swXpkrMIFUSTSkpqPkiVTUWzvc4nx3nDUfazCJ46noaw==
X-Received: by 2002:a05:6602:3a86:b0:85a:e78e:2823 with SMTP id
 ca18e2360f4ac-85b1d054a3dmr3847939f.2.1741277109981; 
 Thu, 06 Mar 2025 08:05:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/47] x86: Add 64-bit entries to the GDT
Date: Thu,  6 Mar 2025 09:03:38 -0700
Message-ID: <20250306160428.3041057-12-sjg@chromium.org>
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

At present it is not possible to execution 64-bit code without
installing an entire new Global Descriptor Table. This is inconvenient
since kvm does not seem to like switching into long mode with a new
table.

It isn't actually necessary, since we can just extend the existing
table. Add some new entries to this effect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/cpu.c          | 3 +++
 arch/x86/include/asm/processor.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index a51a24498a7..3bbad3b2eca 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -160,6 +160,9 @@ void arch_setup_gd(gd_t *new_gd)
 
 	gdt_addr[X86_GDT_ENTRY_16BIT_FLAT_CS] = GDT_ENTRY(0x809b, 0, 0xfffff);
 	gdt_addr[X86_GDT_ENTRY_16BIT_FLAT_DS] = GDT_ENTRY(0x8093, 0, 0xfffff);
+	gdt_addr[X86_GDT_ENTRY_64BIT_CS] = GDT_ENTRY(0xaf9b, 0, 0xfffff);
+	gdt_addr[X86_GDT_ENTRY_64BIT_TS1] = GDT_ENTRY(0x8980, 0, 0xfffff);
+	gdt_addr[X86_GDT_ENTRY_64BIT_TS2] = 0;
 
 	load_gdt(gdt_addr, X86_GDT_NUM_ENTRIES);
 	load_ds(X86_GDT_ENTRY_32BIT_DS);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d7b68367861..ad8240be387 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -18,7 +18,10 @@
 #define X86_GDT_ENTRY_16BIT_DS		6
 #define X86_GDT_ENTRY_16BIT_FLAT_CS	7
 #define X86_GDT_ENTRY_16BIT_FLAT_DS	8
-#define X86_GDT_NUM_ENTRIES		9
+#define X86_GDT_ENTRY_64BIT_CS		9
+#define X86_GDT_ENTRY_64BIT_TS1		10
+#define X86_GDT_ENTRY_64BIT_TS2		11
+#define X86_GDT_NUM_ENTRIES		12
 
 #define X86_GDT_SIZE		(X86_GDT_NUM_ENTRIES * X86_GDT_ENTRY_SIZE)
 
-- 
2.43.0

