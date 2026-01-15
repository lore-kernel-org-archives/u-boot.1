Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C63D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09278399B;
	Thu, 15 Jan 2026 23:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tTvSloFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0878398C; Thu, 15 Jan 2026 23:28:43 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CD480077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cfd20af161so501212a34.3
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516120; x=1769120920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmGUNa+PefQ8nCFUGcVf6FsD8RRmzZROA5ZEzzovOkA=;
 b=tTvSloFnWeyMUMG0FzZuLdafDwkERb6TWG1EUjbrqyHW08cQON+uk7Ope6n+w6BGQ4
 cazJTRtEazJRZx7/lPYLjpuPYp24Vb7sNBEJj9h/juR/qvhKEWwap8mJwALj7c0BawTU
 AR3Vj7xQe0+3+tgR6bDGCIeInDUrhSjIPLaOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516120; x=1769120920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VmGUNa+PefQ8nCFUGcVf6FsD8RRmzZROA5ZEzzovOkA=;
 b=BddvLIDwuBxtJpb/9D+8A3XpnADLqXz/A+FQZZvmUWxja9eJrD6e6shK+Ns1vkc9fK
 k5H91YY6pSDe8PnK+KUmUza6jXLTrCwymON5luYfs0X8sD7OE6k8Sxq0f6wyhHBVrvDr
 A6FSGnw9ECnw+btcNX84ft7bBoPhSJwyMcMWOjS4GEmd30v+bLno8FZ9UIstvw2yjny9
 dmkLZbnGfFDbDXM7Eeh/CAy+cu+IVsdzSTMzo9a9db+7Rhd1cA2Slj6AQNHBquCxch+4
 lVx3keCS5vkwj+NPC+3Nln4NXDhnSvxl53PJFOgThu7Nb46DMK/43RlCWUKWbDucRABO
 t/Rw==
X-Gm-Message-State: AOJu0YymlT2k4rnN30bACJ4LoHJzeSg6biKWV/AbxnhkN9qRsh4KVW72
 owSL6IDWuk/706fH9sPQ5h5L3IMoj9viNaUdFjjH6Yh2v371J4qERVPZ+YuwcQTrIvs0o7C8Atg
 xEzrDtS4=
X-Gm-Gg: AY/fxX7zWDoKZYRqoqpAesMAKt2U9AKdzqFhhMuEv2X4iutinjfk+NDewbWDuaTAnSg
 CWAno3TlA7huMWhBFQtxqKBaMZNhpXSEUyokRveuiW2shpyxpFcvsKI8KMHqxrhK+pUCI3RoHtv
 8vHZ1PWR8jepUCWlblaMRl50n9RqHR0GH0QIgMIq13391jtK+hPrgtz8xOxJlwkNV5+dmsAqRkB
 TXNgLFszX0udLkMxcgD/QbifO6SZ39x5PZlSU4C9Rd0pdKXkCOeirIeF487LXZhI9U8Lr0Xccri
 QNvzS2kXnR2p+aCMoL0aFhyq76aMb+XFKVtuLiskNP27ZcE5ZL9qgs9b8C6/o7q4U0BjnSvdiD3
 6I42bVjEkIxL3PFHPkLpJkU+gUp3wBXw1lu0iM+oArHcXoUnKn+dR3Tk9Ku1Ut7PpHyHmrvQYTr
 V9vTfXorAU8fK/Nyqi6GpQItSIhr6xSBkA0NAOk38wCtoTQrgw0utBuDXoTWb2T34tAPndg54Vt
 veHrqSkH8JpOiP0HmhVpl3mEiFCM7Zod2zgHZ6jrQ==
X-Received: by 2002:a05:6830:6614:b0:7c7:6063:8e0f with SMTP id
 46e09a7af769-7cfe0110c8fmr241305a34.15.1768516119721; 
 Thu, 15 Jan 2026 14:28:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/10] mips: Update linker scripts to ensure appended device
 tree is aligned
Date: Thu, 15 Jan 2026 16:19:35 -0600
Message-ID: <20260115222828.3931345-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Aligns the final section before _end (for U-Boot) or _image_binary_end
  (for xPL phases) by 8-bytes by adding '. = ALIGN(8);' to the final
  section before the symbol. For SPL we need this in two places to cover
  all build configurations.
- Remove now-spurious  '. = ALIGN(x);' statements that were intended to
  provide the above alignments.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com> (maintainer:MIPS)
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 arch/mips/cpu/u-boot-spl.lds | 6 +++++-
 arch/mips/cpu/u-boot.lds     | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cpu/u-boot-spl.lds b/arch/mips/cpu/u-boot-spl.lds
index 310a5c5053b1..ea2deed34f15 100644
--- a/arch/mips/cpu/u-boot-spl.lds
+++ b/arch/mips/cpu/u-boot-spl.lds
@@ -27,16 +27,17 @@ SECTIONS
 	.data : {
 		*(SORT_BY_ALIGNMENT(.data*))
 		*(SORT_BY_ALIGNMENT(.sdata*))
+		. = ALIGN(8);
 	} > .spl_mem
 
 #if defined(CONFIG_SPL_DM) || defined(CONFIG_SPL_LOADER_SUPPORT)
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} > .spl_mem
 #endif
 
-	. = ALIGN(4);
 	__image_copy_end = .;
 	__image_copy_len = __image_copy_end - __text_start;
 
@@ -123,3 +124,6 @@ SECTIONS
 		*(.eh_frame)
 	}
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/mips/cpu/u-boot.lds b/arch/mips/cpu/u-boot.lds
index 133ea05df3da..d59a48b7ef85 100644
--- a/arch/mips/cpu/u-boot.lds
+++ b/arch/mips/cpu/u-boot.lds
@@ -54,9 +54,9 @@ SECTIONS
 		LONG(0xFFFFFFFF);
 		FILL(0);
 		. += CONFIG_MIPS_RELOCATION_TABLE_SIZE - 4;
+		. = ALIGN(8);
 	}
 
-	. = ALIGN(8);
 	_end = .;
 
 	.bss __rel_start (OVERLAY) : {
@@ -140,3 +140,5 @@ SECTIONS
 		*(.eh_frame)
 	}
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

