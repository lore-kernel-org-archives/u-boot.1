Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A910A1E81
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F5A83EAC;
	Thu, 26 Mar 2026 12:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g2nmLbaI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F0383CD3; Thu, 26 Mar 2026 12:51:36 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBEA83A1B
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso18236965e9.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774525894; x=1775130694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NRNe0tsv7xdwn6TailZS7sFZ+Z82CCtkQxhMibYX3s=;
 b=g2nmLbaIxUuYV57n452FklEr0yKpKkHGzPUbZu2Ssm/TIdGPGJVMUdZO15vouaI3zh
 BcjGbTCt2OSNNIKnoHvoyaM8UR9mLnMXZ8qSRoRohFaFOXOhprFIoq7Ysi3iDbNYwnK0
 RRRHpQT29zgaCBv7ISXcypPbPlmMFHGDO2BnxYz7WdkF6auiEbEnp/nkEV/T51U+LgUI
 iQuMkUepCh6C47oRAPGusmBqUtaQf42QOQ9paaHnOA3/2BP6AADZQEOOpJR01mSBWGWA
 3gQr7dTVwtU3CyWh0Szyj2M5ZgjQi83BnsS26EEtYm87agkCtCHQnaLhHMhV5b3CiuRf
 qtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525894; x=1775130694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NRNe0tsv7xdwn6TailZS7sFZ+Z82CCtkQxhMibYX3s=;
 b=cOeHhLT20srY1mjbBW8XZ2Fj6purQ5DmaxbpRGJBuR6BJyrSgr5qIrZfPtDEvTr5el
 ZF0cJgUqa8+qvgJS7lzb26fzvxIOsSxPf85CF+eVrgXLIw721RNLsxz0+UyHfLXCO4g9
 ODmwYu55zDDpCwab1G0EddaP7OLFXhKAKB2ZVwE1qo8tJ9mQ4Mv72IwpTrVDyg47YOH/
 NtomyzLZ3Zu7XHWWo6bKevV3N+72JHJHUaL1ZjLqzOO40qLNhUmub1zA7us34lJLcaC6
 d7Jz5TM9IJ8YteM+dAyMGELtUSE4CEkM95P96BVVOOHItRUc1HGWFNKF+0VFbGXhv4jD
 PwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQKeUaBd8YVHKMMnzA08Ip8dTix+llI0/jQbajkuySTvfMdQwpL6fs7gFOgfILpLGh0iDz0TE=@lists.denx.de
X-Gm-Message-State: AOJu0YxHF3XBg/CAOlK8FDS4NTY1iAW1aV044ANPKyUVqIyh5XEWn2nQ
 WMz/q3kmRo1I7YcRv2eraa0ZVtn8DW70yka0v7xtG3oaW4omUkKwGHAGOSs8htG5rWU=
X-Gm-Gg: ATEYQzyWay/hHnZoP92pJLvkOuehXI01qxaGkxNh4BNkJIe2HX5ZPvVURRU3F1cfD5c
 DvgDO9qMgLZjoOPvM5uRJavOFk2SGBR9VktZ8t1nv8XkDhRHD7yPolvprCApRNXjxc6b8OO2NiY
 625Al2IxKoAyodDEscH7oh4U9HsB/b1bcqy5H1fsE3O3Wu56wf1Sz+K3PvrZb+og3yFfGTubvp9
 raHnn86ty+kvkZn6H55XCx6gwyQtlL7Lx8/2j0kRkLGpGb5G8hiUDQdZAcvLy15NAuZulC6owXi
 PPaPC7jW0pW162bzCiFA+S9TpUtD8RdOOnnMXC5ICrBKDZX1DxsAzPhRza8ecqlLxDKo+9Cicmo
 JveODUJiGMkbjG0Z8EIwawtk8oeo1UHn9rszgXXVjyCOKOVFPRvvg1O0HQKQzQAIoBk6M0RHfKy
 O+4Br2be5BRkD1xuRm+qaQ22Rhr3uSwKRzaKbub54JD/ady2BLRY10e4m4C70HSJsuumzZLSHTZ
 T3vw761f5JNGu9VxSdlJiRO4jbqNQZoJgokUDS3JTaDIR4jzR65UXscHWBnJ6D4lpppvcE8eBcM
 c+p5nqQdWxXiOmrVrOEEymZXTHGrKtRB3EOAAqVcR9LJIIsdz1BZqov21chrN0n0V0lHTIveZ/+
 hZbBqqIZdSut8nXWqcd0P28vBJjG3QMtm7YssVQvnzEW2E9jWHfwP2iznnH2uky2l6VnJAwbDt1
 NIjVdkPo9dM523IGcpwYFAF9ybblsD1s96bSqglRlT9lqiXO69Dqa89mXyctYO
X-Received: by 2002:a05:600c:8b85:b0:487:12c:e7ea with SMTP id
 5b1f17b1804b1-48722ba914dmr19132935e9.5.1774525893401; 
 Thu, 26 Mar 2026 04:51:33 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3d09dsm25968005e9.0.2026.03.26.04.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:51:32 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v1 3/3] common: Allow relocations on the top of the last bank
Date: Thu, 26 Mar 2026 13:51:09 +0200
Message-ID: <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
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

Right now we only relocate u-boot to the top of the first
memory bank unless the board specific code overwrites it.
This is problematic when loading big binaries as it
fragments the contiguous memory space for no apparent reason.

It's worth noting that there are cases where we must not relocate
above the 4GB boundary (e.g 64bit hardware with 32bit only capable
DMA).

Add a Kconfig option and allow the common code to relocate U-Boot
to the top of the last discovered bank.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since RFC: 
- new patch
 Kconfig          | 7 +++++++
 common/board_f.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60f..b9144878ce0b 100644
--- a/Kconfig
+++ b/Kconfig
@@ -474,6 +474,13 @@ config SKIP_RELOCATE
 	  Skips relocation of U-Boot allowing for systems that have extremely
 	  limited RAM to run U-Boot.
 
+config RELOCATE_LAST_BANK
+	bool "Relocate U-Boot to the top of the last memory bank"
+	help
+	  When U-Boot relocates, it chooses the end of the first memory bank.
+	  Enable this if you have multiple banks and want U-Boot to relocate
+	  to the top of the last available bank.
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index df2b0dc899bf..7c3fbeab17ec 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -321,6 +321,8 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		 */
 		return 0;
 #endif
+	if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK))
+		fdtdec_setup_mem_ram_top();
 	return gd->ram_top;
 }
 
-- 
2.51.0

