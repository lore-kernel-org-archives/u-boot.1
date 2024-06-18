Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF03C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C4BF8839F;
	Tue, 18 Jun 2024 15:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="SajbnoYy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="FfpU9RWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8A5883C9; Tue, 18 Jun 2024 15:56:34 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA8B87F5C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 5E77D1C000F2;
 Tue, 18 Jun 2024 09:56:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 18 Jun 2024 09:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718989;
 x=1718805389; bh=cFZllFjy05lO12l8G6LKWRPZ6TJ+VsZjjXPfg6cN1G0=; b=
 SajbnoYyKfRFsj17Qii7UoTQ1iiWgDnVTwXpRKc6tjNojZFWH17hUqtgN6ed7kw0
 wOtebUChKUoSdmwix4zk8MVfHbw+t7T4gO5Za7eHdyo6PhzfSqp8fGyY972aEuXt
 XKxFTevEgd6RON/Ud0LugS7Xcfxzx5d3XGNYwk4FFVWF3S+7sR93D9+QmmwG4ko8
 pXv0hKmHf4upcO0sjL9G9xxoucqf0XYwnhom74ELBEXQ9frUE/tfdSZWs7IzxgJ/
 D4wRBFSgZHa0KL5q5wM487FtgBBNNHUn3x9ZK+FC/gASzbTWYUSBb2qMpbnTxfc0
 bx8POACzmhQwTnY+5WS/iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718989; x=
 1718805389; bh=cFZllFjy05lO12l8G6LKWRPZ6TJ+VsZjjXPfg6cN1G0=; b=F
 fpU9RWc9/Pp6xhjllJwQc24aNDtbWKv2Yjn0hMtQehYVuFoJ0B3Bx2V6yx5orwlB
 SwbScgcGgHfIekZwQVZYSQuaqM2sUDV2IpuMwlTBUDKfxNQeJO/bYOvQPQ74fjM1
 8rqktK4zytIqbaAjThyZ5BP/t1N0OipSGFOg8PI5j7gpjucbgjzfMwiktLFyUBIf
 1aAd50yNOvBMHSf0yf9kad7Mujs5YwPVmJODP9/dChCWebyh3yanncyZYKw6xY50
 /7TWPTH1WU3vBWifV3nLiWO/S0LPjsnPn5AFKaGSLW5EqYc9S+U0zFGlRdebyvQh
 b4Lc+9koUZKn1Q6m+nFXg==
X-ME-Sender: <xms:DJJxZmPSI3K7xuiGN7i2Bkkmz6-Q7VPgnOycE4qfu0hztYWulppGlQ>
 <xme:DJJxZk-if91VJF-u9oWLlf-f4_dA1flAbgkJSCTOzPTYmwpEMC1D6oYIRNhSUQFyY
 MQ4iCIe88n-x5LObtM>
X-ME-Received: <xmr:DJJxZtRtXxVIpqUgsxwMd3GL8FH-sNU2ZfnULy8vQE2HYQ-GICTupU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:DJJxZmunoTJ0MR-YZb-ZbdYaev6UvslQ1rmsjzTri1qSda2ZjQ-77g>
 <xmx:DJJxZucuJigj6Ob0Uvyta8lrAyi0xfzqTrt4kOXCU5STRBUNN4o5xQ>
 <xmx:DJJxZq0eQHZ9QaKBWNrqBC4RGYsj-RQG0JD6gYbZaTqw3y9rPyxUaA>
 <xmx:DJJxZi8P9rQcHnCaLIGmIyupb1bgB1ja2pfVwbzNsWFqTV3OuT9vSA>
 <xmx:DJJxZmSWBmMaDkqKzSaqmvl1NyAjeUMYwi0mf_M-FmDqKf3xqUAL6m-k>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:27 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:05 +0100
Subject: [PATCH v3 05/12] xtensa: Bring in semihosting headers and config
 options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-5-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7929;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=O3JXuRJAA2IVzUknEEiM05ladijTOLjWaA+khHIhU9I=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYxCEg83NjLPn2fNX9I++2OSjbTz9DZdl9C9W7/oq
 Zp/tVHuKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIl8z2Bk+NNrJDnDhpfBxqhz
 l/SdKdFfEp8LGefe+qg9689D8Y9LKhj+6f9a7u838baLu7TIuSm7bJ/+mLHdd/vt87OvxdgdWn1
 1BwcA
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
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
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

