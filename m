Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAFFD42B84
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9DA89472;
	Tue, 12 Nov 2024 14:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vysj+ONP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0B189472; Tue, 12 Nov 2024 14:59:53 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461DE8942F
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83ab694ebe5so221432139f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419989; x=1732024789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F02VXYi7Slsrq6nVv8c4R2YZ1Q5SwEbsT5v+hYeoXO4=;
 b=Vysj+ONPvXvhK6waJRQVe+aCXQf2+sZa7ZHt0B8Og7zd/wexuVEr2c0pzxOCDUKstd
 IOJ0G1NpeoQmStq0SsdaYAwuU3ybeuiViGpWaKZb/JIX3aUORgSMpZpNpH2GQP0ejAxw
 G+iTePCwIc7snnbb5VAKZqwmMkiTmy6fz8P38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419989; x=1732024789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F02VXYi7Slsrq6nVv8c4R2YZ1Q5SwEbsT5v+hYeoXO4=;
 b=Cv0eRoZ657VDqcASn7BjCczDVucHhXcnSlXSn0tOkqSZxBut3mvv6Gap6W4iUdHbLU
 du5mmcRdWyJ6siH0dJIZAx2PUKyrsoaZS9ztPNuccZnwDkirNQuzxmc1Q7jv2ULVpOMV
 7pDY08BCHaO/MDJeuCwlg5mzv0qpMpTe0WI2Wm7TiCKqtbnmaikGv3UiW2b7PfIRC+aB
 oI1MGFyrwocEz14+gDXv6SQkF0udvHUlYIIRxWDjNmAb9CRXC1fwU1pZa4yhLgwbEI/5
 1ftCzl5CQVH0wsCP55eyvSbZL4Lv2dJIQzbo4Jh1UUy+1JsaaXVmFCzJOsUrEg7DUq86
 k7aQ==
X-Gm-Message-State: AOJu0YzxHOmDPo/yUIfwXcC49cF/NPymAn4qHvCr+18Xl6Eo+l4Bc2Rv
 ZqatFB11d/T67bois2eHCLJf37476T6Pd/kskhL4AEPwHRqPdadbgO3zv9DtWkUtZgw5aJg29CQ
 =
X-Google-Smtp-Source: AGHT+IHl+TKppKBfZvhVwMQqzaFTF2uaqicaKBxWnwo0ZRiWWT7yLZqfjJYJHZHSVm4H2bl34ZPaKA==
X-Received: by 2002:a05:6602:14c1:b0:835:45f9:c2ee with SMTP id
 ca18e2360f4ac-83e032a8e61mr1959354139f.4.1731419989244; 
 Tue, 12 Nov 2024 05:59:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/18] x86: Add 64-bit entries to the GDT
Date: Tue, 12 Nov 2024 06:59:03 -0700
Message-Id: <20241112135911.630586-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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
2.34.1

