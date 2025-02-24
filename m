Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DC5C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965B08104B;
	Tue, 25 Feb 2025 00:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RqG2Wscp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F5180FD6; Tue, 25 Feb 2025 00:07:19 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DFB80FD4
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-855a8c1ffe9so147563839f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438435; x=1741043235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=RqG2WscpACJ9aZJLkcn3aiM+Fsy27gP0E4Ve3fBAeqkJyrOUiy4L8CASAgzaSJ7Ktl
 sOMJTd7ZL1lyTuDKzr6QqIKb/VKPXerGgwZEcFBK0T5sxIgNysyK/IcYcUNB87LmD1rc
 r+DIbSS9F+t1fCAFB809Uw3TNgpdb4cnytIAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438435; x=1741043235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jhxSIFalaVLSVgG6wVZXyEthG0WD5Vpn2+AsnABXDE=;
 b=aXu/Lji+tRnr1Tudof4680o4PxgUs2fHSx3qVdocEuDo1mZh7NxlHmOw3v/B4v/e5M
 Q/aBhwncXnk+38dBnPeT8DcSZoVoeRDGKRkYrpE+pGFXvQrCHSQDchXJyWZT6tVU0RUe
 jWXPKtKxUdd8FWaqiyUlBSS/BaI9+rInrZwCkuPxmUBdju8kKMW3tVj8oKvvZ7K7BE9a
 cfYbBHUsp9B+P5gP5kipEQygC/0gFmurnpnxS118HvSTA1VcD2XYIoHN07S3qouLAUlO
 zT0pgNIQlKxtYMrZIeRO5UrrePwlTtBb2/ptrya1n4vYLei8xdKFdp+ChJUI15vLSgFW
 rWPA==
X-Gm-Message-State: AOJu0YzP7HAVGombaf/x5DYZhSuLLKmMzKUMb8oLL1fxLzlW1ltVNNSf
 QXCggQy6oXVv3+SNG8QznM6VvRikvDOuuavNWiElZFf3H7s5vd1ihnV52rz4/EFHrChV5x+H+mM
 =
X-Gm-Gg: ASbGncu7zP8h1SsBm1idv9t+rn/tFOvo0axT5zbq9eSPjFuElAjrJ+KWHlQSSn7tD+r
 ooEX0ejKV7v/vYKEoxzoAJwl5Aa6x70rTzphSiT0j2JHEQJ8xLQ3ctQBYMWyJSEiBCPmKHDxeRo
 n1mG5u6L95NVSgIuXlLZUtBa+gTudmmfhKncDKWieTuTd09wVwZueXZGqpjUe8Rt7j+Sei7Szwt
 rCWTNs2xAPqCNpA4PibIBKo4CuH4IBUcjgEou6tTIv/3zNVvb6886xB4Ww3qzcoUDPj6B/wK78A
 1nr3xqvd6hxYeVk4kI6iF6rEAxhNZCEZz0Clud0BVLsl0M40n3z0LFP/F9uQzWQ=
X-Google-Smtp-Source: AGHT+IH6tRjyPHFZFVNFp2m8+yrr+izOj+DFHMgUjrZGRCP3wHnaeTLbTRDKxhNVSPWOyibSt3Lo6A==
X-Received: by 2002:a05:6602:6d19:b0:855:bc9d:82d2 with SMTP id
 ca18e2360f4ac-856203b2089mr150186539f.9.1740438435296; 
 Mon, 24 Feb 2025 15:07:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/44] x86: Add 64-bit entries to the GDT
Date: Mon, 24 Feb 2025 16:05:58 -0700
Message-ID: <20250224230640.2665206-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

