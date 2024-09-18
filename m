Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA79CDD55C
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1425388641;
	Wed, 18 Sep 2024 23:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gxCcm6tm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AF688CCA; Wed, 18 Sep 2024 23:54:17 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB11880A5
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0A5CB3F1C6; 
 Wed, 18 Sep 2024 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726696455;
 bh=t56utOHDLZPbXYiTupZcOtf6ErdV/G0nGMUsGnZURfk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gxCcm6tmWnW8u/OA3gH0Ozwy4mnr/rAxIlIlDn1g5Xer3fyDftQbV7CUlhLdNnCvy
 7haB6AuKltjtLHvmBpsptlOOEytP0cWvTaljFOz/z2i6GRResOffNDQdArtuuqOJ3x
 k/om9M75GjEviXoUEx1bk0TGiZooFCg+KuJmVklAcW4jLe5FgIdpeSUMY/o2fL0/Qp
 y8HFuDTxStgDh1pv3tKdguA7HWXQ1e8n7BpviVopanbzuQb0ESAg2xq4RA8vDoWIP6
 YSliwHT59wguUB6U0m3fVQ3yuRB1n6+SQk/tAwgySVsKmL3rixJzfgryHYAvKP/tgy
 id9W8Zd02/6ag==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: fix OS function descriptions
Date: Wed, 18 Sep 2024 23:54:08 +0200
Message-ID: <20240918215408.21385-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* Add missing function names.
* Align names used in descriptions with function names.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/os.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/os.h b/include/os.h
index 4371270a1ee..ae3ca6d42a2 100644
--- a/include/os.h
+++ b/include/os.h
@@ -24,7 +24,7 @@ struct sandbox_state;
 int os_printf(const char *format, ...);
 
 /**
- * Access to the OS read() system call
+ * os_read() - access the OS read() system call
  *
  * @fd:		File descriptor as returned by os_open()
  * @buf:	Buffer to place data
@@ -34,7 +34,7 @@ int os_printf(const char *format, ...);
 ssize_t os_read(int fd, void *buf, size_t count);
 
 /**
- * Access to the OS write() system call
+ * os_write() - access the OS write() system call
  *
  * @fd:		File descriptor as returned by os_open()
  * @buf:	Buffer containing data to write
@@ -44,7 +44,7 @@ ssize_t os_read(int fd, void *buf, size_t count);
 ssize_t os_write(int fd, const void *buf, size_t count);
 
 /**
- * Access to the OS lseek() system call
+ * os_lseek() - access the OS lseek() system call
  *
  * @fd:		File descriptor as returned by os_open()
  * @offset:	File offset (based on whence)
@@ -67,7 +67,7 @@ off_t os_lseek(int fd, off_t offset, int whence);
 off_t os_filesize(int fd);
 
 /**
- * Access to the OS open() system call
+ * os_open() - access the OS open() system call
  *
  * @pathname:	Pathname of file to open
  * @flags:	Flags, like OS_O_RDONLY, OS_O_RDWR
@@ -162,7 +162,7 @@ void os_raise_sigalrm(void);
 void os_tty_raw(int fd, bool allow_sigs);
 
 /**
- * os_fs_restore() - restore the tty to its original mode
+ * os_fd_restore() - restore the tty to its original mode
  *
  * Call this to restore the original terminal mode, after it has been changed
  * by os_tty_raw(). This is an internal function.
@@ -207,14 +207,14 @@ void *os_realloc(void *ptr, size_t length);
 void os_usleep(unsigned long usec);
 
 /**
- * Gets a monotonic increasing number of nano seconds from the OS
+ * os_get_nsec() - get monotonically increasing number of nano seconds from OS
  *
- * Return:	a monotonic increasing time scaled in nano seconds
+ * Return:	a monotoniccally increasing time scaled in nano seconds
  */
 uint64_t os_get_nsec(void);
 
 /**
- * Parse arguments and update sandbox state.
+ * os_parse_args() - parse arguments and update sandbox state.
  *
  * @state:	sandbox state to update
  * @argc:	argument count
-- 
2.45.2

