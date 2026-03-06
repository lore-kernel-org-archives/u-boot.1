Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F7F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C26D83FD4;
	Fri,  6 Mar 2026 03:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AdoyKoJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F6C83FF8; Fri,  6 Mar 2026 03:37:22 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9104283FD4
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-89a1d7cc7f0so20896146d6.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764639; x=1773369439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqAdlIapJV6ktiZpes9FSLiyrKtFXGtNxzFmL+nbWdI=;
 b=AdoyKoJveiQLE+qOrXssE+i3yi39E1HqwecvJ205x4WUZaRkljWXGmQSEZXoNMfdBR
 /G7JLq4oTACc22z1LkNjIUWg4k3nVSYEOTm0LOePuwjkKG6cOBi/FGMSqOL94xt6xZoj
 aCN9zVF+87JI0kevD2dWsiuEdMRZ/JnSmCGIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764639; x=1773369439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AqAdlIapJV6ktiZpes9FSLiyrKtFXGtNxzFmL+nbWdI=;
 b=V5L8QxfZIa2liJKIz7RT1uUyY5ggIfWarFv6X3n7IfZGdIzzdSTxBGADlRxgsW1g9H
 pLGAKFbZ7J1SfEadcUM8b95YC2OLdlXRKuhLFtiAKy7esaoTrTXYXxyINuUowGxNhFt2
 EoYQhFwXMZqzjnajxe9kQe/ybvfyeI+fQiSrGjefZrXkdwrGIR1Sx9oNtnpCSV5qjkF9
 BPvWNE8HYsPwFbteMl9X0MJ76BJFcladjWk/kZic34rFQV+T0HFtQ/qEmdflDYpKA9cL
 4KJNxQePOXxyjTlF4I2vLFtkvpJasyPuEI44m6xmtad2vv9++ZWXNzzDDC0UPjUuaf0n
 XIsA==
X-Gm-Message-State: AOJu0YxBjz1zxuuEXjnEYFI8yFVrB+D8m1jB/cHhC1736z+XPAYBzyeE
 vJghs1lpQmc3Ss/+u8LT1LM3kWkTe8mfTWzRrC2bg3nP5bcShogvvdqqlUgNhS6mSyF6rlcTkFe
 T+/g=
X-Gm-Gg: ATEYQzyfqS8LBCG+Ek9b4hqMcGUHORh2PGgJm3cjXGvAvhDuO87jzSzQIxpmL+m9A+7
 XjshJsqNBAnnWIluXdwqe7LuYxxFRjLQBc9RNKqbzjzfIIzcm7uLgCebTKXilS7MszS2diAitdV
 mflpsIRnhV8qhgqWMcnI4ddQUz/L8+0JeEFx9Nmn1yjEpnrWY8vihTm5a0i1j4kFNzTgsH6KGWy
 +0RLU/JpCFQmobBF/MPit66htjmyKchh4CYBBPuVFv4O5eh7WDS78H41OBlkIzCpGSslQC3pJfb
 uQvyK5LUxNe7JQFgx827XJL/EWXHNMSBF6S5MNxmevm1MBuuu2CPTdldo1zlKcAxp8MdcHOGB5m
 NGBQGRAH3l23Uj5kRHPUoFev12AOD+Q2QXU0ejiu3YeTDfzHMyL/+tGB4NQwSRSjL62k0pa7qGS
 S2aJLbbZC/ztK4aYfAWA==
X-Received: by 2002:a05:6214:2461:b0:899:b626:92f2 with SMTP id
 6a1803df08f44-89a30a18ab2mr6116556d6.10.1772764638942; 
 Thu, 05 Mar 2026 18:37:18 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 10/17] microblaze: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:19 -0700
Message-ID: <20260306023638.2678886-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Replace the open-coded printf and bootstage_mark_name with a call to
bootm_final(). This also adds board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on
MicroBlaze.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v4:
- Pass flag directly instead of using BOOTM_FINAL_FAKE

Changes in v3:
- Add new patch for MicroBlaze conversion

 arch/microblaze/lib/bootm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index 2410515f4ac..b54c902602f 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -26,8 +26,6 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	ulong dt = (ulong)images->ft_addr;
 	ulong rd_start = images->initrd_start;
 	ulong cmdline = images->cmdline_start;
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
-
 	thekernel = (void (*)(char *, ulong, ulong))images->ep;
 
 	debug("## Transferring control to Linux (at address 0x%08lx) ",
@@ -36,13 +34,11 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	      cmdline, rd_start, dt);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-	printf("\nStarting kernel ...%s\n\n", fake ?
-	       "(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+	bootm_final(flag);
 
 	flush_cache_all();
 
-	if (!fake) {
+	if (!(flag & BOOTM_STATE_OS_FAKE_GO)) {
 		/*
 		 * Linux Kernel Parameters (passing device tree):
 		 * r5: pointer to command line
-- 
2.43.0

