Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0450C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E91380F6B;
	Sun, 16 Feb 2025 21:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fuYg9tM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2353D80F64; Sun, 16 Feb 2025 21:45:12 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627F180F6B
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8557b84dc10so38944239f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738704; x=1740343504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=fuYg9tM1C7oiCEeBaSkhK1UWIdGlfjUdrFskUQzSU9OAvy12I0PM5O2F8sF9pDnjki
 wHFSX+JOuhPEvM3Tm5FPUsagvDAEB0Enxk3XBwenB7rH3R+bX7rruxTCafrcMg0WfuQQ
 BEUAH3Pcw94vkOt6WQIM2lrdsSmm08f5/cGjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738704; x=1740343504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=DGico88vmS1fIHcRF5QPL77VG7QZEIrNMydmL1U6AK8KQz+eEpfkDlqy70zFtAcEBz
 fnJMBDqRw/FE2vDUoGWM+2kgUQ3q6fG4FyfJdT0KLx++kQAt7Wfs4ejVapLVS1G3QQff
 zvXR1hp3Jrp36qZkgN4xW0ejLQcSbzQzORlORsg0LFP2q5nI4Yt2/kBBL28WU7kNur1P
 Zn3B6rYkfDvZUwocLTvHePYcX4S5gBad/SjWpdgBrD9e4Gp60nx1V3pAS+d20ByWz/vg
 sw52UpgkU7Veus7gprFGzffWgKEs8L6jC0tKfVKlMVpvDcAATc89eDRqB48x8ZVtG6XS
 N1Bw==
X-Gm-Message-State: AOJu0YxQmmy3uXWKjMCZnQzQwzcanWt2eaOSIuw4F9PkRIWDiKViierq
 BcPJNRsHowYlFO9qf0baI9gZEiPZCQbEmFQPlrIhlOq2+6bbhzL5guzWi3ffLpmisdZYMJM87fA
 =
X-Gm-Gg: ASbGnct8F8rqieI/9xaHqkXbysHQTfubZ5u1tFLTyXXvF15TW0WGqJX9o1HaCniCEUm
 IzWmDDThY6/5vkCUNvyIPHeKaVUJG+xr3GvmvsTn+9TLtC9l86iZv3/GhhJUiLgogJTxQarDd1a
 w6BILoog76TtSi2T9LjYHYyrSgL5pYJsEpd8cw7Wr8Np1SH+c1lX5RFbzKgent5aw6xSGQt2IXv
 POaFLOJS/QJa5RO6Ns6YC65qdf99G/Dqcef8mr2BuLNFE0STSklW0fYOYWbUmFVQSx4ahxCGyI3
 xX9kkaUvzjrrfYQ9E2LJ2h2AdBWpz2Uga0PGlQ/r8VYX9fzF4fAa
X-Google-Smtp-Source: AGHT+IEhykvp5NkVG0DP0P3MuIUi6FlB1xpXY7vh+ISYXklR+do6Wez+DFLItzY4i15NWF2v+pOMZA==
X-Received: by 2002:a92:ca05:0:b0:3cf:f844:68eb with SMTP id
 e9e14a558f8ab-3d2807b1b42mr53148155ab.4.1739738704181; 
 Sun, 16 Feb 2025 12:45:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/28] x86: Drop use of CONFIG_REALMODE_DEBUG
Date: Sun, 16 Feb 2025 13:43:52 -0700
Message-ID: <20250216204421.3560012-8-sjg@chromium.org>
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

This option is not actually defined in Kconfig anymore. Use a normal
debug print instead, which has a similar effect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c            | 18 ++++++++----------
 arch/x86/lib/bios_interrupts.c |  6 ++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index acae635cf19..5dfe5a647eb 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -301,16 +301,14 @@ asmlinkage int interrupt_handler(u32 intnumber, u32 gsfs, u32 dses,
 	cs = cs_ip >> 16;
 	flags = stackflags;
 
-#ifdef CONFIG_REALMODE_DEBUG
-	debug("oprom: INT# 0x%x\n", intnumber);
-	debug("oprom: eax: %08x ebx: %08x ecx: %08x edx: %08x\n",
-	      eax, ebx, ecx, edx);
-	debug("oprom: ebp: %08x esp: %08x edi: %08x esi: %08x\n",
-	      ebp, esp, edi, esi);
-	debug("oprom:  ip: %04x      cs: %04x   flags: %08x\n",
-	      ip, cs, flags);
-	debug("oprom: stackflags = %04x\n", stackflags);
-#endif
+	log_debug("oprom: INT# 0x%x\n", intnumber);
+	log_debug("oprom: eax: %08x ebx: %08x ecx: %08x edx: %08x\n",
+		  eax, ebx, ecx, edx);
+	log_debug("oprom: ebp: %08x esp: %08x edi: %08x esi: %08x\n",
+		  ebp, esp, edi, esi);
+	log_debug("oprom:  ip: %04x      cs: %04x   flags: %08x\n",
+		  ip, cs, flags);
+	log_debug("oprom: stackflags = %04x\n", stackflags);
 
 	/*
 	 * Fetch arguments from the stack and put them to a place
diff --git a/arch/x86/lib/bios_interrupts.c b/arch/x86/lib/bios_interrupts.c
index 3ae6c193ec7..e0c2284a901 100644
--- a/arch/x86/lib/bios_interrupts.c
+++ b/arch/x86/lib/bios_interrupts.c
@@ -200,10 +200,8 @@ int int1a_handler(void)
 			dm_pci_write_config32(dev, reg, dword);
 			break;
 		}
-#ifdef CONFIG_REALMODE_DEBUG
-		debug("0x%x: bus %d devfn 0x%x reg 0x%x val 0x%x\n", func,
-		      bus, devfn, reg, M.x86.R_ECX);
-#endif
+		log_debug("0x%x: bus %d devfn 0x%x reg 0x%x val 0x%x\n", func,
+			  bus, devfn, reg, M.x86.R_ECX);
 		M.x86.R_EAX &= 0xffff00ff; /* Clear AH */
 		M.x86.R_EAX |= PCIBIOS_SUCCESSFUL;
 		retval = 1;
-- 
2.43.0

