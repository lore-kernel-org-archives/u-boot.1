Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899D3C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65B2888C4;
	Wed, 22 May 2024 19:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="z+aZxmXn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7GLKuim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BD588889; Wed, 22 May 2024 19:08:14 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958DC88889
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id C70081C0017E;
 Wed, 22 May 2024 13:08:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 22 May 2024 13:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397690;
 x=1716484090; bh=BgBmoo4ZW19jUMSq82MZUSevSPvpq+L95ODfWky9iI0=; b=
 z+aZxmXnTBwEUXn842G4zUI4KqC6NjrXnZYeAMG4kK9qBqqpLOuh/wWceZtbBxhu
 tH/JxwnG6uy9E+xYPxkoABvPxNXyIaDwENbf8ITXi0H+/LCIT9CYoAmOb+viYwDq
 YHadLpZG7AOot4XGeBOamCF06OhLTjlbdq4RERB8jaz9tFIsoycrOE2HS/mQXIg/
 MLVJLCpk4gXTBQiJ5zoJp2eW36e6AN4YDgQD+Ry+POjq/7AB382VwK+2Tde5uv7v
 hVl9/mVbFIBlDpsw7bGs5wWTe/G6ZyRpDBF/eg4GgdrJPd8/GF31hgv+n3yfUyor
 pa8bAx8tM8NThZyTh/LLaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397690; x=
 1716484090; bh=BgBmoo4ZW19jUMSq82MZUSevSPvpq+L95ODfWky9iI0=; b=J
 7GLKuimVsEhVOg4IoC91vGCYsMLKiIjCRy1XtmgFg2v3Z75/b0dqjmiSJMUb5xeu
 xHn/Qp9Hz+GKSItjqWK/243RqnbHJZYOXH1bVMwb/2YT3qe4ShWc7Z9D7GzqLcPe
 CzzmNCWLmtVyJwzyaFe5cg/vLTRhVBLHIvE7Oyteo1QYT2fbbI5oR8WnoS2vua4p
 a1YHCpEJa0icM4QTCnOGO80ahyoTQrbo5M3Fr4zOk0Int85GAg2bixd+IK+/c/sy
 cZ6U1X59hih+E+DimYGDEoz1FfJwTUmqXFmSmgr2XyByhLLhDa2YhvFsU/g/RKs2
 hc4Pn3WzyybpW8RQkgsvg==
X-ME-Sender: <xms:eiZOZnUJ-sysrSe9s3wEB-Ecv4PgI8NuE3Rb5Z9yz-usBzUoYWqzeQ>
 <xme:eiZOZvlAx2DN5bS1yc4nwO-HwimfmMwnK889hPPjzswhGtJ7ri9NsLkFzQtOLXlOJ
 lyCAdhM8KOjc2CwwgE>
X-ME-Received: <xmr:eiZOZja4IgQpj3zzssAMh2G-IYQHmj8SAQcNYBSokS_kqgNsz0O_jTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:eiZOZiVf9N5aWJTYixbDYoTOi3t5jipivsCvRZPmniLl7vApwZrXpg>
 <xmx:eiZOZhmF54NhgN4CXvil_VdN2h-trw5fl5ZiIK8tLAaVgGQtpyEX1w>
 <xmx:eiZOZve9Gg0TGhzz2KDBbzo18nb1PyU41tv1UjoHeV_jNxHAn79O1Q>
 <xmx:eiZOZrFdYF9WDkBIqiYb_M4nvvd36d98T56pyZpJPhwNAD_IsT55qQ>
 <xmx:eiZOZva1ANRlzaQLf9PTq906UWiMXQ3ItgdltszvUQ1bfLZCe6VrzRp5>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:09 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:01 +0100
Subject: [PATCH v2 05/10] xtensa: Bring in semihosting headers and config
 options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-5-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7883;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=FzNG8EIa/nZaYMqf7GuI53aG1tx+4YP/Y3v1KObQ53U=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tbyyxhKdHiaby0ZP1pW8Utk5rfXyvcajX/6Ufuq4e
 dI+bW5fRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEykn4vhf+ECAd7uV9Wc+dlS
 s0wiXx53+nRM+cqy+/znwt3mBgkf2M3IcJPxYe3W5gmvxa5v+f18wp8blq0ln6967V1TbvM1oW/
 uZD4A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

They are all directly imported from Linux kernel.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/Kconfig                              |  27 ++++++
 arch/xtensa/include/asm/platform/simcall-gdbio.h |  34 +++++++
 arch/xtensa/include/asm/platform/simcall-iss.h   |  73 +++++++++++++++
 arch/xtensa/include/asm/platform/simcall.h       | 110 +++++++++++++++++++++++
 4 files changed, 244 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8f668cc67ed0..4afd56bca095 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -41,6 +41,33 @@ config SPL_SYS_DCACHE_OFF
 	help
 	  Do not enable data cache in SPL.
 
+config XTENSA_SEMIHOSTING
+	bool "Support semihosting"
+	help
+	  Enable Xtensa semihosting debugging support.
+
+choice
+	prompt "Semihosting interface"
+	default XTENSA_SIMCALL_ISS
+	depends on XTENSA_SEMIHOSTING
+	help
+	  Choose semihosting interface that will be used for serial port,
+	  block device and networking.
+
+config XTENSA_SIMCALL_ISS
+	bool "simcall"
+	help
+	  Use simcall instruction. simcall is only available on simulators,
+	  it does nothing on hardware.
+
+config XTENSA_SIMCALL_GDBIO
+	bool "GDBIO"
+	help
+	  Use break instruction. It is available on real hardware when GDB
+	  is attached to it via JTAG.
+
+endchoice
+
 source "board/cadence/xtfpga/Kconfig"
 
 endmenu
diff --git a/arch/xtensa/include/asm/platform/simcall-gdbio.h b/arch/xtensa/include/asm/platform/simcall-gdbio.h
new file mode 100644
index 000000000000..e642860e25a8
--- /dev/null
+++ b/arch/xtensa/include/asm/platform/simcall-gdbio.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Cadence Design Systems Inc. */
+
+#ifndef _XTENSA_PLATFORM_ISS_SIMCALL_GDBIO_H
+#define _XTENSA_PLATFORM_ISS_SIMCALL_GDBIO_H
+
+/*
+ *  System call like services offered by the GDBIO host.
+ */
+
+#define SYS_open	-2
+#define SYS_close	-3
+#define SYS_read	-4
+#define SYS_write	-5
+#define SYS_lseek	-6
+
+static int errno;
+
+static inline int __simc(int a, int b, int c, int d)
+{
+	register int a1 asm("a2") = a;
+	register int b1 asm("a6") = b;
+	register int c1 asm("a3") = c;
+	register int d1 asm("a4") = d;
+	__asm__ __volatile__ (
+			"break 1, 14\n"
+			: "+r"(a1), "+r"(c1)
+			: "r"(b1), "r"(d1)
+			: "memory");
+	errno = c1;
+	return a1;
+}
+
+#endif /* _XTENSA_PLATFORM_ISS_SIMCALL_GDBIO_H */
diff --git a/arch/xtensa/include/asm/platform/simcall-iss.h b/arch/xtensa/include/asm/platform/simcall-iss.h
new file mode 100644
index 000000000000..5a1e7a1f182e
--- /dev/null
+++ b/arch/xtensa/include/asm/platform/simcall-iss.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Cadence Design Systems Inc. */
+
+#ifndef _XTENSA_PLATFORM_ISS_SIMCALL_ISS_H
+#define _XTENSA_PLATFORM_ISS_SIMCALL_ISS_H
+
+/*
+ *  System call like services offered by the simulator host.
+ */
+
+#define SYS_nop		0	/* unused */
+#define SYS_exit	1	/*x*/
+#define SYS_fork	2
+#define SYS_read	3	/*x*/
+#define SYS_write	4	/*x*/
+#define SYS_open	5	/*x*/
+#define SYS_close	6	/*x*/
+#define SYS_rename	7	/*x 38 - waitpid */
+#define SYS_creat	8	/*x*/
+#define SYS_link	9	/*x (not implemented on WIN32) */
+#define SYS_unlink	10	/*x*/
+#define SYS_execv	11	/* n/a - execve */
+#define SYS_execve	12	/* 11 - chdir */
+#define SYS_pipe	13	/* 42 - time */
+#define SYS_stat	14	/* 106 - mknod */
+#define SYS_chmod	15
+#define SYS_chown	16	/* 202 - lchown */
+#define SYS_utime	17	/* 30 - break */
+#define SYS_wait	18	/* n/a - oldstat */
+#define SYS_lseek	19	/*x*/
+#define SYS_getpid	20
+#define SYS_isatty	21	/* n/a - mount */
+#define SYS_fstat	22	/* 108 - oldumount */
+#define SYS_time	23	/* 13 - setuid */
+#define SYS_gettimeofday 24	/*x 78 - getuid (not implemented on WIN32) */
+#define SYS_times	25	/*X 43 - stime (Xtensa-specific implementation) */
+#define SYS_socket      26
+#define SYS_sendto      27
+#define SYS_recvfrom    28
+#define SYS_select_one  29      /* not compatible select, one file descriptor at the time */
+#define SYS_bind        30
+#define SYS_ioctl	31
+
+#define SYS_iss_argc	1000	/* returns value of argc */
+#define SYS_iss_argv_size 1001	/* bytes needed for argv & arg strings */
+#define SYS_iss_set_argv 1002	/* saves argv & arg strings at given addr */
+
+/*
+ * SYS_select_one specifiers
+ */
+
+#define  XTISS_SELECT_ONE_READ    1
+#define  XTISS_SELECT_ONE_WRITE   2
+#define  XTISS_SELECT_ONE_EXCEPT  3
+
+static int errno;
+
+static inline int __simc(int a, int b, int c, int d)
+{
+	register int a1 asm("a2") = a;
+	register int b1 asm("a3") = b;
+	register int c1 asm("a4") = c;
+	register int d1 asm("a5") = d;
+	__asm__ __volatile__ (
+			"simcall\n"
+			: "+r"(a1), "+r"(b1)
+			: "r"(c1), "r"(d1)
+			: "memory");
+	errno = b1;
+	return a1;
+}
+
+#endif /* _XTENSA_PLATFORM_ISS_SIMCALL_ISS_H */
diff --git a/arch/xtensa/include/asm/platform/simcall.h b/arch/xtensa/include/asm/platform/simcall.h
new file mode 100644
index 000000000000..a1cb269e68f0
--- /dev/null
+++ b/arch/xtensa/include/asm/platform/simcall.h
@@ -0,0 +1,110 @@
+/*
+ * include/asm-xtensa/platform-iss/simcall.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2001 Tensilica Inc.
+ * Copyright (C) 2017 - 2021 Cadence Design Systems Inc.
+ */
+
+#ifndef _XTENSA_PLATFORM_ISS_SIMCALL_H
+#define _XTENSA_PLATFORM_ISS_SIMCALL_H
+
+#include <linux/bug.h>
+
+#ifdef CONFIG_XTENSA_SIMCALL_ISS
+#include <asm/platform/simcall-iss.h>
+#endif
+#ifdef CONFIG_XTENSA_SIMCALL_GDBIO
+#include <asm/platform/simcall-gdbio.h>
+#endif
+
+static inline int simc_exit(int exit_code)
+{
+#ifdef SYS_exit
+	return __simc(SYS_exit, exit_code, 0, 0);
+#else
+	WARN_ONCE(1, "%s: not implemented\n", __func__);
+	return -1;
+#endif
+}
+
+static inline int simc_open(const char *file, int flags, int mode)
+{
+	return __simc(SYS_open, (int) file, flags, mode);
+}
+
+static inline int simc_close(int fd)
+{
+	return __simc(SYS_close, fd, 0, 0);
+}
+
+static inline int simc_ioctl(int fd, int request, void *arg)
+{
+#ifdef SYS_ioctl
+	return __simc(SYS_ioctl, fd, request, (int) arg);
+#else
+	WARN_ONCE(1, "%s: not implemented\n", __func__);
+	return -1;
+#endif
+}
+
+static inline int simc_read(int fd, void *buf, size_t count)
+{
+	return __simc(SYS_read, fd, (int) buf, count);
+}
+
+static inline int simc_write(int fd, const void *buf, size_t count)
+{
+	return __simc(SYS_write, fd, (int) buf, count);
+}
+
+static inline int simc_poll(int fd)
+{
+#ifdef SYS_select_one
+	long timeval[2] = { 0, 0 };
+
+	return __simc(SYS_select_one, fd, XTISS_SELECT_ONE_READ, (int)&timeval);
+#else
+	WARN_ONCE(1, "%s: not implemented\n", __func__);
+	return -1;
+#endif
+}
+
+static inline int simc_lseek(int fd, uint32_t off, int whence)
+{
+	return __simc(SYS_lseek, fd, off, whence);
+}
+
+static inline int simc_argc(void)
+{
+#ifdef SYS_iss_argc
+	return __simc(SYS_iss_argc, 0, 0, 0);
+#else
+	WARN_ONCE(1, "%s: not implemented\n", __func__);
+	return 0;
+#endif
+}
+
+static inline int simc_argv_size(void)
+{
+#ifdef SYS_iss_argv_size
+	return __simc(SYS_iss_argv_size, 0, 0, 0);
+#else
+	WARN_ONCE(1, "%s: not implemented\n", __func__);
+	return 0;
+#endif
+}
+
+static inline void simc_argv(void *buf)
+{
+#ifdef SYS_iss_set_argv
+	__simc(SYS_iss_set_argv, (int)buf, 0, 0);
+#else
+	WARN_ONCE(1, "%s: not implemented\n", __func__);
+#endif
+}
+
+#endif /* _XTENSA_PLATFORM_ISS_SIMCALL_H */

-- 
2.43.0

