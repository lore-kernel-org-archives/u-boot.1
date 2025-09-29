Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38405CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 22:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2C883071;
	Tue, 30 Sep 2025 00:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yqD+qvHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761F8832DA; Tue, 30 Sep 2025 00:19:32 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BBC9807B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 00:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7a79efc43e5so3814220a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759184367; x=1759789167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tKFu70RJx362HanEz7cQKzukyp7KKcJY7wl0nhVb3ac=;
 b=yqD+qvHRVzzBtLYP7+7hpqKpl13x3x3kLpyaLPQ92jWpHT1jzdPl8DW2+9RL2sj6fX
 XAaa2gzymVWfuEXUcXmVUcm9XrkxEHChU3/EVXek0PYStXZ83huSSuDyIqPjkNTV0sqE
 xI1ywvdlnrQ30CwLiRrNzfoifgesUoN8+6wECPKK+F48lUd14RbUQpltFCvZpRqRLqNt
 lTyenMZFqpN8MCgdgKPDvCEA58wMGGgUeGMTgb4nDNoBMxg7wiWu/fKo0PT6Poy5C0NV
 tKzuRyhCReRdJ1JVY8lVU8UyXrJaNcnZBiFEKTaLKtvtF1muQIJ0IO/gSyeT2GBTd5we
 64iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759184367; x=1759789167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKFu70RJx362HanEz7cQKzukyp7KKcJY7wl0nhVb3ac=;
 b=u3TZA83v5C7w0j4NyHiRcmovuFUOc7mHxRithM9mSFKy2lMfyY1T36X6OS0GSeOobI
 QYJkM/Gf1G/bhMCpa2H987qU9AKB6hFRoRXg38iXihjJHlo0Hq1aNn5CgF2hwp+hCgnu
 x97BrqDpDn/Q5jMH2JvdpTaWyaf5Lsol7yEddicxwFpq2fdYJ8dEg+kvEFaF5ZEO3cfI
 T+T60SWfcjsCs9lEibdeWV005CM229ZoDvXsJ6Sdp/DoQz6JuqyAvdRH5r7A3euWOsxs
 Cu1+8ukvmwqipgVGFeK1pTHLVM0R2WAKZNox0qriZ3Ie7li4VjQOXtwD1KkwXkSjw3lg
 bXSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNzJNr3OIKTMohnAo6Qtv6NRJFg6Ch9/EGb5GDfD2gme6k7l6XoWEteapDRIq26otSvp1lCA8=@lists.denx.de
X-Gm-Message-State: AOJu0YzZjrkdofvKfXZaLaK1pYOhxDECGSLhMmnDMrvfLVGjJtdpE0Hz
 juivOHYRZNNCNBmmbl+EqIQQeyShJZkFgJHB24LV8a/JgQErhVqJQwV7cExMBMOwAMk=
X-Gm-Gg: ASbGnctFcWG7MEd+a5sB5heB6C4kEbuXsotDLGG7DqWaZVYFytWhg2uWQbdl7j/Zawo
 CyouVZyJHowJZ63R/cDHZfYrMVOGCXiYj+XDtc4GEGnLw2f0Dx5GzDfaQJ0C9cW7KSxzN/kAkeC
 GWyQ9J6g4KqHsK62kXOOhSsNUiXjblsjeSey5KDKQOMm4VOy1Izpn96maz4zk7lzqvgzl2qrXOT
 Tu4/wvTg/bIpt6gE0F4uMuef19yTawIh7U0I+Rv7Mv8a1YFflpARWC0sy4gjHAWZEbH5JONPRE2
 hL5nRQrAcNksUDZ0Eo5cr2sYPoliyhyg9rrF3ecWJrprxsH5zrvPTVZupdzhrnokgpCQH4PAXwH
 oCgo9Nf45HW+lqZAylVhrhO3Org==
X-Google-Smtp-Source: AGHT+IEp18mM9bIL1EJV+V9dFd2aSCo0TrA317YxBFd1hWocpwRlo7244L6H9LtF3W3IEiX3xgpOdQ==
X-Received: by 2002:a05:6830:2d8d:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7a7ff0cf1c5mr5921296a34.23.1759184367548; 
 Mon, 29 Sep 2025 15:19:27 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193c8dasm2827856a34.4.2025.09.29.15.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 15:19:27 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Richard Weinberger <richard@nod.at>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] Revert "fdt: Make sure there is no stale initrd left"
Date: Mon, 29 Sep 2025 17:19:26 -0500
Message-Id: <20250929221926.29046-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

This reverts commit 9fe2e4b46458f9c4ec6b8115ebf18b4b26fe6127.

Commit 9fe2e4b46458 ("fdt: Make sure there is no stale initrd left")
introduces a regression in case when U-Boot transfers control to an EFI
app which acts as a subsequent bootloading program. Such an app might
try to set "linux,initrd-start" and "linux,initrd-end" fdt properties,
but by that time those properties are already removed by the code added
in the mentioned commit.

Particularly, the issue was observed on the E850-96 board where GBL EFI
app [1] can't run Android successfully anymore. More specifically, the
kernel can't see the ramdisk and panics with next messages:

    /dev/root: Can't open blockdev
    VFS: Cannot open root device "" or unknown-block(0,0): error -6
    Please append a correct "root=" boot option; ...
    Kernel panic - not syncing: VFS: Unable to mount root fs on
    unknown-block(0,0)

fdt_initrd() function (where initrd dts properties are removed) is
called two times:

1. First it's called by EFI boot manager (e.g. as a part of U-Boot
Standard Boot mechanism) when it's installing FDT:

    fdt_initrd
    image_setup_libfdt
    efi_install_fdt
    efi_bootmgr_run
    efi_mgr_boot

It's already enough for EFI app to malfunction. But then it's also
called second time:

2. From the EFI app, via EFI DT fixup protocol:

    fdt_initrd
    image_setup_libfdt
    efi_dt_fixup
    struct efi_dt_fixup_protocol efi_dt_fixup_prot = {
        .fixup = efi_dt_fixup
    };

See [2] for specific GBL code which sets those fdt properties and then
runs DT fixup protocol callback.

This issue was discussed [3], but no action was taken since then. Revert
this patch for now, until a proper solution can be found.

[1] https://source.android.com/docs/core/architecture/bootloader/generic-bootloader/gbl-dev
[2] https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/libgbl/src/android_boot/mod.rs#208
[3] https://lists.denx.de/pipermail/u-boot/2025-July/593879.html

Fixes: 9fe2e4b46458 ("fdt: Make sure there is no stale initrd left")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 boot/fdt_support.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index b7331bb76b3e..92f2f534ee02 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -224,24 +224,15 @@ int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end)
 	int is_u64;
 	uint64_t addr, size;
 
+	/* just return if the size of initrd is zero */
+	if (initrd_start == initrd_end)
+		return 0;
+
 	/* find or create "/chosen" node. */
 	nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
 	if (nodeoffset < 0)
 		return nodeoffset;
 
-	/*
-	 * Although we didn't setup an initrd, there could be a stale
-	 * initrd setting from the previous boot firmware in the live
-	 * device tree. So, make sure there is no setting left if we
-	 * don't want an initrd.
-	 */
-	if (initrd_start == initrd_end) {
-		fdt_delprop(fdt, nodeoffset, "linux,initrd-start");
-		fdt_delprop(fdt, nodeoffset, "linux,initrd-end");
-
-		return 0;
-	}
-
 	total = fdt_num_mem_rsv(fdt);
 
 	/*
-- 
2.39.5

