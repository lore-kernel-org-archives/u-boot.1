Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB837D49200
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E25839A8;
	Fri, 12 Dec 2025 12:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mC4bEDzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB9F835B3; Fri, 12 Dec 2025 12:32:41 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3683839A8
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so7642955e9.0
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765539151; x=1766143951; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N5ir08gmLEl0jm7hP9qz9pSmeSLcu9/3Kd4BOB8qECA=;
 b=mC4bEDzdcOWHKiwJKTaKMXow0f6u1b2pMatBy2NqE06dtk+fGsN5mTYQIHKVxQ2hba
 eTYsCE6YGhahRaMUqilF1BS6b904lIfkwq4Y3PDE/dH2BP0vh/C4FSmxWSIf+QV7Otx7
 0sUXiGsv8YHqkNf4mbM8lbB8FiQ1ekZT1vadqkwmIcihPfmO9NmBV4GwpX6oMNks6mac
 rPg1IzYB8xXTsmw7tG/HimiwCCqNImR9Lw8ERDGVhUWnsoI4HU89vIZRvvJtd4h3i/nO
 OuAz+9pfsqIki5IyFXcFaQzpw6A6cHtQhULrKghKQQWt4kuMvcet5rdrvd3ED2/WAJOR
 giqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765539151; x=1766143951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N5ir08gmLEl0jm7hP9qz9pSmeSLcu9/3Kd4BOB8qECA=;
 b=lD0DDIEZNyUoSEe2ZO84q/vYG3WpI7QFDqE3DLjgKk1BTLfrR6NnQu99DXAAwTImF/
 V41eZi04fjNnYWW0OXc29s86ca5wwnwTlzETDw3Hb9ix92/4gjGUUsfxr8CI4rOhRXjq
 5zwp9UOBRwYJAaDUGWH6YDcfaujKFFmUBxuw6SlGZouPFHp2mAorUZv8ezM4Hg6252Yx
 jmDUkP7tR161sZ4scTucjTlEHIZ2Dp/O4QPHXbOIO+T0hHRPlvrjbmGTLJRxVIGo6fs2
 Dxyl1DRiwTDIvMulwOb/C2PMw5NoZaX0tiAGSsRqqve6SV6NI2S0r1DcfHkJTRbFluMV
 2QDQ==
X-Gm-Message-State: AOJu0YxCOTkhPuDgOuPoyw8RVpliHgTQ9kmJ/48qQNaWg2GyNR1hY/PD
 StgGkZuhAjyAYCdl9aANgfxxNFhsjP2BpwjDo/zprpzQ1hzWDcDBXRPzR1tC59ZaO2o=
X-Gm-Gg: AY/fxX7QNP0Fmsu+c9hbcmbhFZZhv4ZAC4JD+trcp09JC7dXNedocY8JigOAEGKtBHy
 vuIM6iQ7cfcYwDOjDngUoG9+rp6FkMSJDiKKbSf6+kFNm7IA7b4qdETA+zDVsONK3gM1vFFT7T0
 4cXUUwV5uis57LbOanFT6VuAEbCi9eiWPT4qtwcbUmq+jCQNv0uxJlPkOqotv7OpFKgXBh5/7pZ
 r+dhvm6bkhZjrKFZfvhtVLxxR6EWety8FfL76rjAQjICn+s8jbv/jT/3rfqS/TZfmNarzDnKaGf
 OaOrq47FYe7Ld8UB6BAUCsXjjxPeOxxUyGLqBOjayr0dF9r2Fbl16HniysVjK5zG4MwoFZqWTSA
 m/3h/Fa32EEgAplLQ7lbPOz/7YJSwdAvXCZ5jGSmTLyJ8IN48Y9Xz8Gpsb6d1yDUCL7qGF6L+Ae
 R/kU+sEUkyQXEBErPKhK5Gb2vBu75tRAmaxJke/p8=
X-Google-Smtp-Source: AGHT+IH7flNm47Z17xjMAqRFAvNa95Kc5yZAbqhyMt+TIWVZB2NhKz4ySiUjN1Lj716F3oEJIk0pmw==
X-Received: by 2002:a05:600d:8447:b0:477:b642:9dc9 with SMTP id
 5b1f17b1804b1-47a900bd698mr12291615e9.28.1765539150822; 
 Fri, 12 Dec 2025 03:32:30 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8f39c6sm26277235e9.14.2025.12.12.03.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:32:30 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 12 Dec 2025 11:32:27 +0000
Subject: [PATCH v2 4/6] net: nfs: Move most NFS code to common files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-lwip_nfs-v2-4-9cb5a60520d8@linaro.org>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Move most of the NFS code into common files so that it can be used by an
lwIP port of NFS.

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/Makefile     |   1 +
 net/nfs-common.c | 861 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/nfs-common.h | 123 ++++++++
 net/nfs.c        | 848 +-----------------------------------------------------
 net/nfs.h        |  59 ----
 5 files changed, 998 insertions(+), 894 deletions(-)

diff --git a/net/Makefile b/net/Makefile
index 468820186cfc8287fb23a81e75f6a3594f46f261..3a32bc8b0e78404c3db2196ed802010988145bc8 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_$(PHASE_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
+obj-$(CONFIG_CMD_NFS)  += nfs-common.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth_common.o
 obj-y += net-common.o
 endif
diff --git a/net/nfs-common.c b/net/nfs-common.c
new file mode 100644
index 0000000000000000000000000000000000000000..a6a70677bd2d8350819dd7bce336d35cc3ae7bf8
--- /dev/null
+++ b/net/nfs-common.c
@@ -0,0 +1,861 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NFS support driver - based on etherboot and U-BOOT's tftp.c
+ *
+ * Masami Komiya <mkomiya@sonare.it> 2004
+ *
+ */
+
+/* NOTE: the NFS code is heavily inspired by the NetBSD netboot code (read:
+ * large portions are copied verbatim) as distributed in OSKit 0.97.  A few
+ * changes were necessary to adapt the code to Etherboot and to fix several
+ * inconsistencies.  Also the RPC message preparation is done "by hand" to
+ * avoid adding netsprintf() which I find hard to understand and use.
+ */
+
+/* NOTE 2: Etherboot does not care about things beyond the kernel image, so
+ * it loads the kernel image off the boot server (ARP_SERVER) and does not
+ * access the client root disk (root-path in dhcpd.conf), which would use
+ * ARP_ROOTSERVER.  The root disk is something the operating system we are
+ * about to load needs to use.	This is different from the OSKit 0.97 logic.
+ */
+
+/* NOTE 3: Symlink handling introduced by Anselm M Hoffmeister, 2003-July-14
+ * If a symlink is encountered, it is followed as far as possible (recursion
+ * possible, maximum 16 steps). There is no clearing of ".."'s inside the
+ * path, so please DON'T DO THAT. thx.
+ */
+
+/* NOTE 4: NFSv3 support added by Guillaume GARDET, 2016-June-20.
+ * NFSv2 is still used by default. But if server does not support NFSv2, then
+ * NFSv3 is used, if available on NFS server.
+ */
+
+/* NOTE 5: NFSv1 support added by Christian Gmeiner, Thomas Rienoessl,
+ * September 27, 2018. As of now, NFSv3 is the default choice. If the server
+ * does not support NFSv3, we fall back to versions 2 or 1.
+ */
+
+#ifdef CONFIG_SYS_DIRECT_FLASH_NFS
+#include <flash.h>
+#endif
+#include <image.h>
+#include <log.h>
+#include <net.h>
+#include <mapmem.h>
+#include "nfs.h"
+#include "nfs-common.h"
+
+static int fs_mounted;
+static char dirfh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle of directory */
+static unsigned int dirfh3_length; /* (variable) length of dirfh when NFSv3 */
+static char filefh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle */
+static unsigned int filefh3_length;	/* (variable) length of filefh when NFSv3 */
+
+enum net_loop_state nfs_download_state;
+char *nfs_filename;
+char *nfs_path;
+char nfs_path_buff[2048];
+struct in_addr nfs_server_ip;
+int nfs_server_mount_port;
+int nfs_server_port;
+int nfs_our_port;
+int nfs_state;
+int nfs_timeout_count;
+unsigned long rpc_id;
+int nfs_offset = -1;
+int nfs_len;
+
+const ulong nfs_timeout = CONFIG_NFS_TIMEOUT;
+
+enum nfs_version choosen_nfs_version = NFS_V3;
+
+static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
+{
+	ulong newsize = offset + len;
+#ifdef CONFIG_SYS_DIRECT_FLASH_NFS
+	int i, rc = 0;
+
+	for (i = 0; i < CONFIG_SYS_MAX_FLASH_BANKS; i++) {
+		/* start address in flash? */
+		if (image_load_addr + offset >= flash_info[i].start[0]) {
+			rc = 1;
+			break;
+		}
+	}
+
+	if (rc) { /* Flash is destination for this packet */
+		rc = flash_write((uchar *)src, (ulong)image_load_addr + offset,
+				 len);
+		if (rc) {
+			flash_perror(rc);
+			return -1;
+		}
+	} else
+#endif /* CONFIG_SYS_DIRECT_FLASH_NFS */
+	{
+		void *ptr = map_sysmem(image_load_addr + offset, len);
+
+		memcpy(ptr, src, len);
+		unmap_sysmem(ptr);
+	}
+
+	if (net_boot_file_size < (offset + len))
+		net_boot_file_size = newsize;
+	return 0;
+}
+
+char *nfs_basename(char *path)
+{
+	char *fname;
+
+	fname = path + strlen(path) - 1;
+	while (fname >= path) {
+		if (*fname == '/') {
+			fname++;
+			break;
+		}
+		fname--;
+	}
+	return fname;
+}
+
+char *nfs_dirname(char *path)
+{
+	char *fname;
+
+	fname = nfs_basename(path);
+	--fname;
+	*fname = '\0';
+	return path;
+}
+
+/**************************************************************************
+ * RPC_ADD_CREDENTIALS - Add RPC authentication/verifier entries
+ **************************************************************************
+ */
+static uint32_t *rpc_add_credentials(uint32_t *p)
+{
+	/* Here's the executive summary on authentication requirements of the
+	 * various NFS server implementations:	Linux accepts both AUTH_NONE
+	 * and AUTH_UNIX authentication (also accepts an empty hostname field
+	 * in the AUTH_UNIX scheme).  *BSD refuses AUTH_NONE, but accepts
+	 * AUTH_UNIX (also accepts an empty hostname field in the AUTH_UNIX
+	 * scheme).  To be safe, use AUTH_UNIX and pass the hostname if we have
+	 * it (if the BOOTP/DHCP reply didn't give one, just use an empty
+	 * hostname).
+	 */
+
+	/* Provide an AUTH_UNIX credential.  */
+	*p++ = htonl(1);		/* AUTH_UNIX */
+	*p++ = htonl(20);		/* auth length */
+	*p++ = 0;			/* stamp */
+	*p++ = 0;			/* hostname string */
+	*p++ = 0;			/* uid */
+	*p++ = 0;			/* gid */
+	*p++ = 0;			/* auxiliary gid list */
+
+	/* Provide an AUTH_NONE verifier.  */
+	*p++ = 0;			/* AUTH_NONE */
+	*p++ = 0;			/* auth length */
+
+	return p;
+}
+
+void rpc_req_common(int rpc_prog, int rpc_proc, uint32_t *data, int datalen,
+		    uchar *txbuff, int *pktlen, int *sport)
+{
+	struct rpc_t rpc_pkt;
+	unsigned long id;
+	u32 *p;
+
+	id = ++rpc_id;
+	rpc_pkt.u.call.id = htonl(id);
+	rpc_pkt.u.call.type = htonl(MSG_CALL);
+	rpc_pkt.u.call.rpcvers = htonl(2);	/* use RPC version 2 */
+	rpc_pkt.u.call.prog = htonl(rpc_prog);
+	switch (rpc_prog) {
+	case PROG_NFS:
+		switch (choosen_nfs_version) {
+		case NFS_V1:
+		case NFS_V2:
+			rpc_pkt.u.call.vers = htonl(2);
+			break;
+
+		case NFS_V3:
+			rpc_pkt.u.call.vers = htonl(3);
+			break;
+
+		case NFS_UNKOWN:
+			/* nothing to do */
+			break;
+		}
+		break;
+	case PROG_MOUNT:
+		switch (choosen_nfs_version) {
+		case NFS_V1:
+			rpc_pkt.u.call.vers = htonl(1);
+			break;
+
+		case NFS_V2:
+			rpc_pkt.u.call.vers = htonl(2);
+			break;
+
+		case NFS_V3:
+			rpc_pkt.u.call.vers = htonl(3);
+			break;
+
+		case NFS_UNKOWN:
+			/* nothing to do */
+			break;
+		}
+		break;
+	case PROG_PORTMAP:
+	default:
+		rpc_pkt.u.call.vers = htonl(2);	/* portmapper is version 2 */
+	}
+	rpc_pkt.u.call.proc = htonl(rpc_proc);
+	p = rpc_pkt.u.call.data;
+
+	if (datalen)
+		memcpy(p, data, datalen * sizeof(uint32_t));
+
+	*pktlen = (char *)p + datalen * sizeof(uint32_t) - (char *)&rpc_pkt;
+
+	memcpy(txbuff, &rpc_pkt.u.data[0], *pktlen);
+
+	if (rpc_prog == PROG_PORTMAP)
+		*sport = SUNRPC_PORT;
+	else if (rpc_prog == PROG_MOUNT)
+		*sport = nfs_server_mount_port;
+	else
+		*sport = nfs_server_port;
+}
+
+/**************************************************************************
+ * RPC_LOOKUP - Lookup RPC Port numbers
+ **************************************************************************
+ */
+static void rpc_lookup_req(int prog, int ver)
+{
+	u32 data[16];
+
+	data[0] = 0; data[1] = 0;	/* auth credential */
+	data[2] = 0; data[3] = 0;	/* auth verifier */
+	data[4] = htonl(prog);
+	data[5] = htonl(ver);
+	data[6] = htonl(17);	/* IP_UDP */
+	data[7] = 0;
+	rpc_req(PROG_PORTMAP, PORTMAP_GETPORT, data, 8);
+}
+
+/**************************************************************************
+ * NFS_MOUNT - Mount an NFS Filesystem
+ **************************************************************************
+ */
+static void nfs_mount_req(char *path)
+{
+	u32 data[1024];
+	u32 *p;
+	int len;
+	int pathlen;
+
+	pathlen = strlen(path);
+
+	p = &data[0];
+	p = rpc_add_credentials(p);
+
+	*p++ = htonl(pathlen);
+	if (pathlen & 3)
+		*(p + pathlen / 4) = 0;
+	memcpy(p, path, pathlen);
+	p += (pathlen + 3) / 4;
+
+	len = (uint32_t *)p - (uint32_t *)&data[0];
+
+	rpc_req(PROG_MOUNT, MOUNT_ADDENTRY, data, len);
+}
+
+/**************************************************************************
+ * NFS_UMOUNTALL - Unmount all our NFS Filesystems on the Server
+ **************************************************************************
+ */
+static void nfs_umountall_req(void)
+{
+	u32 data[1024];
+	u32 *p;
+	int len;
+
+	if ((nfs_server_mount_port == -1) || !fs_mounted)
+		/* Nothing mounted, nothing to umount */
+		return;
+
+	p = &data[0];
+	p = rpc_add_credentials(p);
+
+	len = (uint32_t *)p - (uint32_t *)&data[0];
+
+	rpc_req(PROG_MOUNT, MOUNT_UMOUNTALL, data, len);
+}
+
+/***************************************************************************
+ * NFS_READLINK (AH 2003-07-14)
+ * This procedure is called when read of the first block fails -
+ * this probably happens when it's a directory or a symlink
+ * In case of successful readlink(), the dirname is manipulated,
+ * so that inside the nfs() function a recursion can be done.
+ ***************************************************************************
+ */
+static void nfs_readlink_req(void)
+{
+	u32 data[1024];
+	u32 *p;
+	int len;
+
+	p = &data[0];
+	p = rpc_add_credentials(p);
+
+	if (choosen_nfs_version != NFS_V3) {
+		memcpy(p, filefh, NFS_FHSIZE);
+		p += (NFS_FHSIZE / 4);
+	} else { /* NFS_V3 */
+		*p++ = htonl(filefh3_length);
+		memcpy(p, filefh, filefh3_length);
+		p += (filefh3_length / 4);
+	}
+
+	len = (uint32_t *)p - (uint32_t *)&data[0];
+
+	rpc_req(PROG_NFS, NFS_READLINK, data, len);
+}
+
+/**************************************************************************
+ * NFS_LOOKUP - Lookup Pathname
+ **************************************************************************
+ */
+static void nfs_lookup_req(char *fname)
+{
+	u32 data[1024];
+	u32 *p;
+	int len;
+	int fnamelen;
+
+	fnamelen = strlen(fname);
+
+	p = &data[0];
+	p = rpc_add_credentials(p);
+
+	if (choosen_nfs_version != NFS_V3) {
+		memcpy(p, dirfh, NFS_FHSIZE);
+		p += (NFS_FHSIZE / 4);
+		*p++ = htonl(fnamelen);
+		if (fnamelen & 3)
+			*(p + fnamelen / 4) = 0;
+		memcpy(p, fname, fnamelen);
+		p += (fnamelen + 3) / 4;
+
+		len = (uint32_t *)p - (uint32_t *)&data[0];
+
+		rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
+	} else {  /* NFS_V3 */
+		*p++ = htonl(dirfh3_length);	/* Dir handle length */
+		memcpy(p, dirfh, dirfh3_length);
+		p += (dirfh3_length / 4);
+		*p++ = htonl(fnamelen);
+		if (fnamelen & 3)
+			*(p + fnamelen / 4) = 0;
+		memcpy(p, fname, fnamelen);
+		p += (fnamelen + 3) / 4;
+
+		len = (uint32_t *)p - (uint32_t *)&data[0];
+
+		rpc_req(PROG_NFS, NFS3PROC_LOOKUP, data, len);
+	}
+}
+
+/**************************************************************************
+ * NFS_READ - Read File on NFS Server
+ **************************************************************************
+ */
+static void nfs_read_req(int offset, int readlen)
+{
+	u32 data[1024];
+	u32 *p;
+	int len;
+
+	p = &data[0];
+	p = rpc_add_credentials(p);
+
+	if (choosen_nfs_version != NFS_V3) {
+		memcpy(p, filefh, NFS_FHSIZE);
+		p += (NFS_FHSIZE / 4);
+		*p++ = htonl(offset);
+		*p++ = htonl(readlen);
+		*p++ = 0;
+	} else { /* NFS_V3 */
+		*p++ = htonl(filefh3_length);
+		memcpy(p, filefh, filefh3_length);
+		p += (filefh3_length / 4);
+		*p++ = htonl(0); /* offset is 64-bit long, so fill with 0 */
+		*p++ = htonl(offset);
+		*p++ = htonl(readlen);
+		*p++ = 0;
+	}
+
+	len = (uint32_t *)p - (uint32_t *)&data[0];
+
+	rpc_req(PROG_NFS, NFS_READ, data, len);
+}
+
+/**************************************************************************
+ * RPC request dispatcher
+ **************************************************************************
+ */
+void nfs_send(void)
+{
+	switch (nfs_state) {
+	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
+		if (choosen_nfs_version != NFS_V3)
+			rpc_lookup_req(PROG_MOUNT, 1);
+		else  /* NFS_V3 */
+			rpc_lookup_req(PROG_MOUNT, 3);
+		break;
+	case STATE_PRCLOOKUP_PROG_NFS_REQ:
+		if (choosen_nfs_version != NFS_V3)
+			rpc_lookup_req(PROG_NFS, 2);
+		else  /* NFS_V3 */
+			rpc_lookup_req(PROG_NFS, 3);
+		break;
+	case STATE_MOUNT_REQ:
+		nfs_mount_req(nfs_path);
+		break;
+	case STATE_UMOUNT_REQ:
+		nfs_umountall_req();
+		break;
+	case STATE_LOOKUP_REQ:
+		nfs_lookup_req(nfs_filename);
+		break;
+	case STATE_READ_REQ:
+		nfs_read_req(nfs_offset, nfs_len);
+		break;
+	case STATE_READLINK_REQ:
+		nfs_readlink_req();
+		break;
+	}
+}
+
+/**************************************************************************
+ * Handlers for the reply from server
+ **************************************************************************
+ */
+
+static int rpc_handle_error(struct rpc_t *rpc_pkt)
+{
+	if (rpc_pkt->u.reply.rstatus  ||
+	    rpc_pkt->u.reply.verifier ||
+	    rpc_pkt->u.reply.astatus  ||
+	    rpc_pkt->u.reply.data[0]) {
+		switch (ntohl(rpc_pkt->u.reply.astatus)) {
+		case NFS_RPC_SUCCESS: /* Not an error */
+			break;
+		case NFS_RPC_PROG_MISMATCH: {
+			/* Remote can't support NFS version */
+			const int min = ntohl(rpc_pkt->u.reply.data[0]);
+			const int max = ntohl(rpc_pkt->u.reply.data[1]);
+
+			if (max < NFS_V1 || max > NFS_V3 || min > NFS_V3) {
+				puts("*** ERROR: NFS version not supported");
+				debug(": Requested: V%d, accepted: min V%d - max V%d\n",
+				      choosen_nfs_version,
+				      ntohl(rpc_pkt->u.reply.data[0]),
+				      ntohl(rpc_pkt->u.reply.data[1]));
+				puts("\n");
+				choosen_nfs_version = NFS_UNKOWN;
+				break;
+			}
+
+			debug("*** Warning: NFS version not supported: Requested: V%d, accepted: min V%d - max V%d\n",
+			      choosen_nfs_version,
+			      ntohl(rpc_pkt->u.reply.data[0]),
+			      ntohl(rpc_pkt->u.reply.data[1]));
+			debug("Will retry with NFSv%d\n", min);
+			choosen_nfs_version = min;
+			return -NFS_RPC_PROG_MISMATCH;
+		}
+		case NFS_RPC_PROG_UNAVAIL:
+		case NFS_RPC_PROC_UNAVAIL:
+		case NFS_RPC_GARBAGE_ARGS:
+		case NFS_RPC_SYSTEM_ERR:
+		default: /* Unknown error on 'accept state' flag */
+			debug("*** ERROR: accept state error (%d)\n",
+			      ntohl(rpc_pkt->u.reply.astatus));
+			break;
+		}
+		return -1;
+	}
+
+	return 0;
+}
+
+static int rpc_lookup_reply(int prog, uchar *pkt, unsigned int len)
+{
+	struct rpc_t rpc_pkt;
+
+	memcpy(&rpc_pkt.u.data[0], pkt, len);
+
+	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
+		return -NFS_RPC_ERR;
+	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
+		return -NFS_RPC_DROP;
+
+	if (rpc_pkt.u.reply.rstatus  ||
+	    rpc_pkt.u.reply.verifier ||
+	    rpc_pkt.u.reply.astatus)
+		return -1;
+
+	switch (prog) {
+	case PROG_MOUNT:
+		nfs_server_mount_port = ntohl(rpc_pkt.u.reply.data[0]);
+		break;
+	case PROG_NFS:
+		nfs_server_port = ntohl(rpc_pkt.u.reply.data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static int nfs_mount_reply(uchar *pkt, unsigned int len)
+{
+	struct rpc_t rpc_pkt;
+	int ret;
+
+	memcpy(&rpc_pkt.u.data[0], pkt, len);
+
+	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
+		return -NFS_RPC_ERR;
+	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
+		return -NFS_RPC_DROP;
+
+	ret = rpc_handle_error(&rpc_pkt);
+	if (ret)
+		return ret;
+
+	fs_mounted = 1;
+	/*  NFSv2 and NFSv3 use same structure */
+	if (choosen_nfs_version != NFS_V3) {
+		memcpy(dirfh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
+	} else {
+		dirfh3_length = ntohl(rpc_pkt.u.reply.data[1]);
+		if (dirfh3_length > NFS3_FHSIZE)
+			dirfh3_length  = NFS3_FHSIZE;
+		memcpy(dirfh, rpc_pkt.u.reply.data + 2, dirfh3_length);
+	}
+
+	return 0;
+}
+
+static int nfs_umountall_reply(uchar *pkt, unsigned int len)
+{
+	struct rpc_t rpc_pkt;
+
+	memcpy(&rpc_pkt.u.data[0], pkt, len);
+
+	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
+		return -NFS_RPC_ERR;
+	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
+		return -NFS_RPC_DROP;
+
+	if (rpc_pkt.u.reply.rstatus  ||
+	    rpc_pkt.u.reply.verifier ||
+	    rpc_pkt.u.reply.astatus)
+		return -1;
+
+	fs_mounted = 0;
+	memset(dirfh, 0, sizeof(dirfh));
+
+	return 0;
+}
+
+static int nfs_lookup_reply(uchar *pkt, unsigned int len)
+{
+	struct rpc_t rpc_pkt;
+	int ret;
+
+	memcpy(&rpc_pkt.u.data[0], pkt, len);
+
+	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
+		return -NFS_RPC_ERR;
+	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
+		return -NFS_RPC_DROP;
+
+	ret = rpc_handle_error(&rpc_pkt);
+	if (ret)
+		return ret;
+
+	if (choosen_nfs_version != NFS_V3) {
+		if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + NFS_FHSIZE) > len)
+			return -NFS_RPC_DROP;
+		memcpy(filefh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
+	} else {  /* NFS_V3 */
+		filefh3_length = ntohl(rpc_pkt.u.reply.data[1]);
+		if (filefh3_length > NFS3_FHSIZE)
+			filefh3_length  = NFS3_FHSIZE;
+		memcpy(filefh, rpc_pkt.u.reply.data + 2, filefh3_length);
+	}
+
+	return 0;
+}
+
+static int nfs3_get_attributes_offset(uint32_t *data)
+{
+	if (data[1]) {
+		/* 'attributes_follow' flag is TRUE,
+		 * so we have attributes on 21 dwords
+		 */
+		/* Skip unused values :
+		 *	type;	32 bits value,
+		 *	mode;	32 bits value,
+		 *	nlink;	32 bits value,
+		 *	uid;	32 bits value,
+		 *	gid;	32 bits value,
+		 *	size;	64 bits value,
+		 *	used;	64 bits value,
+		 *	rdev;	64 bits value,
+		 *	fsid;	64 bits value,
+		 *	fileid;	64 bits value,
+		 *	atime;	64 bits value,
+		 *	mtime;	64 bits value,
+		 *	ctime;	64 bits value,
+		 */
+		return 22;
+	}
+
+	/* 'attributes_follow' flag is FALSE,
+	 * so we don't have any attributes
+	 */
+	return 1;
+}
+
+static int nfs_readlink_reply(uchar *pkt, unsigned int len)
+{
+	struct rpc_t rpc_pkt;
+	int rlen;
+	int nfsv3_data_offset = 0;
+
+	memcpy((unsigned char *)&rpc_pkt, pkt, len);
+
+	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
+		return -NFS_RPC_ERR;
+	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
+		return -NFS_RPC_DROP;
+
+	if (rpc_pkt.u.reply.rstatus  ||
+	    rpc_pkt.u.reply.verifier ||
+	    rpc_pkt.u.reply.astatus  ||
+	    rpc_pkt.u.reply.data[0])
+		return -1;
+
+	if (choosen_nfs_version == NFS_V3) {
+		nfsv3_data_offset =
+			nfs3_get_attributes_offset(rpc_pkt.u.reply.data);
+	}
+
+	/* new path length */
+	rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
+
+	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
+		return -NFS_RPC_DROP;
+
+	if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) != '/') {
+		int pathlen;
+
+		strcat(nfs_path, "/");
+		pathlen = strlen(nfs_path);
+		memcpy(nfs_path + pathlen,
+		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
+		       rlen);
+		nfs_path[pathlen + rlen] = 0;
+	} else {
+		memcpy(nfs_path,
+		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
+		       rlen);
+		nfs_path[rlen] = 0;
+	}
+	return 0;
+}
+
+static int nfs_read_reply(uchar *pkt, unsigned int len)
+{
+	struct rpc_t rpc_pkt;
+	int rlen;
+	uchar *data_ptr;
+
+	memcpy(&rpc_pkt.u.data[0], pkt, sizeof(rpc_pkt.u.reply));
+
+	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
+		return -NFS_RPC_ERR;
+	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
+		return -NFS_RPC_DROP;
+
+	if (rpc_pkt.u.reply.rstatus  ||
+	    rpc_pkt.u.reply.verifier ||
+	    rpc_pkt.u.reply.astatus  ||
+	    rpc_pkt.u.reply.data[0]) {
+		if (rpc_pkt.u.reply.rstatus)
+			return -9999;
+		if (rpc_pkt.u.reply.astatus)
+			return -9999;
+		return -ntohl(rpc_pkt.u.reply.data[0]);
+	}
+
+	if (nfs_offset != 0 && !((nfs_offset) %
+			(NFS_READ_SIZE / 2 * 10 * HASHES_PER_LINE)))
+		puts("\n\t ");
+	if (!(nfs_offset % ((NFS_READ_SIZE / 2) * 10)))
+		putc('#');
+
+	if (choosen_nfs_version != NFS_V3) {
+		rlen = ntohl(rpc_pkt.u.reply.data[18]);
+		data_ptr = (uchar *)&rpc_pkt.u.reply.data[19];
+	} else {  /* NFS_V3 */
+		int nfsv3_data_offset =
+			nfs3_get_attributes_offset(rpc_pkt.u.reply.data);
+
+		/* count value */
+		rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
+		/* Skip unused values :
+		 *	EOF:		32 bits value,
+		 *	data_size:	32 bits value,
+		 */
+		data_ptr = (uchar *)
+			&rpc_pkt.u.reply.data[4 + nfsv3_data_offset];
+	}
+
+	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
+		return -9999;
+
+	if (store_block(data_ptr, nfs_offset, rlen))
+		return -9999;
+
+	return rlen;
+}
+
+void nfs_pkt_recv(uchar *pkt, unsigned int len)
+{
+	int rlen;
+	int reply;
+
+	switch (nfs_state) {
+	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
+		if (rpc_lookup_reply(PROG_MOUNT, pkt, len) == -NFS_RPC_DROP)
+			break;
+		nfs_state = STATE_PRCLOOKUP_PROG_NFS_REQ;
+		nfs_send();
+		break;
+
+	case STATE_PRCLOOKUP_PROG_NFS_REQ:
+		if (rpc_lookup_reply(PROG_NFS, pkt, len) == -NFS_RPC_DROP)
+			break;
+		nfs_state = STATE_MOUNT_REQ;
+		nfs_send();
+		break;
+
+	case STATE_MOUNT_REQ:
+		reply = nfs_mount_reply(pkt, len);
+		if (reply == -NFS_RPC_DROP) {
+			break;
+		} else if (reply == -NFS_RPC_ERR) {
+			puts("*** ERROR: Cannot mount\n");
+			/* just to be sure... */
+			nfs_state = STATE_UMOUNT_REQ;
+			nfs_send();
+		} else if (reply == -NFS_RPC_PROG_MISMATCH &&
+			   choosen_nfs_version != NFS_UNKOWN) {
+			nfs_state = STATE_MOUNT_REQ;
+			nfs_send();
+		} else {
+			nfs_state = STATE_LOOKUP_REQ;
+			nfs_send();
+		}
+		break;
+
+	case STATE_UMOUNT_REQ:
+		reply = nfs_umountall_reply(pkt, len);
+		if (reply == -NFS_RPC_DROP) {
+			break;
+		} else if (reply == -NFS_RPC_ERR) {
+			debug("*** ERROR: Cannot umount\n");
+			net_set_state(NETLOOP_FAIL);
+		} else {
+			puts("\ndone\n");
+			net_set_state(nfs_download_state);
+		}
+		break;
+
+	case STATE_LOOKUP_REQ:
+		reply = nfs_lookup_reply(pkt, len);
+		if (reply == -NFS_RPC_DROP) {
+			break;
+		} else if (reply == -NFS_RPC_ERR) {
+			puts("*** ERROR: File lookup fail\n");
+			nfs_state = STATE_UMOUNT_REQ;
+			nfs_send();
+		} else if (reply == -NFS_RPC_PROG_MISMATCH &&
+			   choosen_nfs_version != NFS_UNKOWN) {
+			/* umount */
+			nfs_state = STATE_UMOUNT_REQ;
+			nfs_send();
+			/* And retry with another supported version */
+			nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
+			nfs_send();
+		} else {
+			nfs_state = STATE_READ_REQ;
+			nfs_offset = 0;
+			nfs_len = NFS_READ_SIZE;
+			nfs_send();
+		}
+		break;
+
+	case STATE_READLINK_REQ:
+		reply = nfs_readlink_reply(pkt, len);
+		if (reply == -NFS_RPC_DROP) {
+			break;
+		} else if (reply == -NFS_RPC_ERR) {
+			puts("*** ERROR: Symlink fail\n");
+			nfs_state = STATE_UMOUNT_REQ;
+			nfs_send();
+		} else {
+			debug("Symlink --> %s\n", nfs_path);
+			nfs_filename = nfs_basename(nfs_path);
+			nfs_path     = nfs_dirname(nfs_path);
+
+			nfs_state = STATE_MOUNT_REQ;
+			nfs_send();
+		}
+		break;
+
+	case STATE_READ_REQ:
+		rlen = nfs_read_reply(pkt, len);
+		if (rlen == -NFS_RPC_DROP)
+			break;
+		nfs_refresh_timeout();
+		if (rlen > 0) {
+			nfs_offset += rlen;
+			nfs_send();
+		} else if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL)) {
+			/* symbolic link */
+			nfs_state = STATE_READLINK_REQ;
+			nfs_send();
+		} else {
+			if (!rlen)
+				nfs_download_state = NETLOOP_SUCCESS;
+			if (rlen < 0)
+				debug("NFS READ error (%d)\n", rlen);
+			nfs_state = STATE_UMOUNT_REQ;
+			nfs_send();
+		}
+		break;
+	}
+}
+
diff --git a/net/nfs-common.h b/net/nfs-common.h
new file mode 100644
index 0000000000000000000000000000000000000000..a19b98b7b1f0cb323d5384ee8c22bf058f6446c9
--- /dev/null
+++ b/net/nfs-common.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Masami Komiya <mkomiya@sonare.it> 2004
+ */
+
+#ifndef __NFS_COMMON_H__
+#define __NFS_COMMON_H__
+
+#define SUNRPC_PORT     111
+
+#define PROG_PORTMAP    100000
+#define PROG_NFS        100003
+#define PROG_MOUNT      100005
+
+#define MSG_CALL        0
+#define MSG_REPLY       1
+
+#define HASHES_PER_LINE 65	/* Number of "loading" hashes per line	*/
+#define NFS_RETRY_COUNT 30
+
+#define NFS_RPC_ERR	1
+#define NFS_RPC_DROP	124
+
+#define NFSERR_PERM     1
+#define NFSERR_NOENT    2
+#define NFSERR_ACCES    13
+#define NFSERR_ISDIR    21
+#define NFSERR_INVAL    22
+
+/* Values for Accept State flag on RPC answers (See: rfc1831) */
+enum rpc_accept_stat {
+	NFS_RPC_SUCCESS = 0,	/* RPC executed successfully */
+	NFS_RPC_PROG_UNAVAIL = 1,	/* remote hasn't exported program */
+	NFS_RPC_PROG_MISMATCH = 2,	/* remote can't support version # */
+	NFS_RPC_PROC_UNAVAIL = 3,	/* program can't support procedure */
+	NFS_RPC_GARBAGE_ARGS = 4,	/* procedure can't decode params */
+	NFS_RPC_SYSTEM_ERR = 5	/* errors like memory allocation failure */
+};
+
+enum nfs_version {
+	NFS_UNKOWN = 0,
+	NFS_V1 = 1,
+	NFS_V2 = 2,
+	NFS_V3 = 3,
+};
+
+extern enum net_loop_state nfs_download_state;
+extern char *nfs_filename;
+extern char *nfs_path;
+extern char nfs_path_buff[2048];
+extern struct in_addr nfs_server_ip;
+extern int nfs_server_mount_port;
+extern int nfs_server_port;
+extern int nfs_our_port;
+extern int nfs_timeout_count;
+extern unsigned long rpc_id;
+extern int nfs_offset;
+extern int nfs_len;
+
+extern const ulong nfs_timeout;
+
+extern int nfs_state;
+#define STATE_PRCLOOKUP_PROG_MOUNT_REQ	1
+#define STATE_PRCLOOKUP_PROG_NFS_REQ	2
+#define STATE_MOUNT_REQ			3
+#define STATE_UMOUNT_REQ		4
+#define STATE_LOOKUP_REQ		5
+#define STATE_READ_REQ			6
+#define STATE_READLINK_REQ		7
+
+/*
+ * Block size used for NFS read accesses.  A RPC reply packet (including  all
+ * headers) must fit within a single Ethernet frame to avoid fragmentation.
+ * However, if CONFIG_IP_DEFRAG is set, a bigger value could be used.  In any
+ * case, most NFS servers are optimized for a power of 2.
+ */
+#define NFS_READ_SIZE	1024	/* biggest power of two that fits Ether frame */
+#define NFS_MAX_ATTRS	26
+
+struct rpc_t {
+	union {
+		u8 data[NFS_READ_SIZE + (6 + NFS_MAX_ATTRS) *
+			sizeof(uint32_t)];
+		struct {
+			u32 id;
+			u32 type;
+			u32 rpcvers;
+			u32 prog;
+			u32 vers;
+			u32 proc;
+			u32 data[1];
+		} call;
+		struct {
+			u32 id;
+			u32 type;
+			u32 rstatus;
+			u32 verifier;
+			u32 v2;
+			u32 astatus;
+			u32 data[NFS_READ_SIZE / sizeof(u32) +
+				NFS_MAX_ATTRS];
+		} reply;
+	} u;
+};
+
+char *nfs_basename(char *path);
+char *nfs_dirname(char *path);
+void rpc_req_common(int rpc_prog, int rpc_proc, uint32_t *data, int datalen,
+		    uchar *txbuff, int *pktlen, int *sport);
+void nfs_send(void);
+void nfs_pkt_recv(uchar *pkt, unsigned int len);
+
+extern enum nfs_version choosen_nfs_version;
+
+/*
+ * Implementation specific functions called from common code
+ */
+void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen);
+void nfs_refresh_timeout(void);
+
+/**********************************************************************/
+
+#endif /* __NFS_COMMON_H__ */
diff --git a/net/nfs.c b/net/nfs.c
index 7bae7c78642cb33e5040c44ed9d0378222069923..f5edc9b043ae1f0f8a1404b28506b8ad120fc5a5 100644
--- a/net/nfs.c
+++ b/net/nfs.c
@@ -31,745 +31,31 @@
  * September 27, 2018. As of now, NFSv3 is the default choice. If the server
  * does not support NFSv3, we fall back to versions 2 or 1. */
 
-#include <command.h>
 #include <display_options.h>
-#ifdef CONFIG_SYS_DIRECT_FLASH_NFS
-#include <flash.h>
-#endif
 #include <image.h>
 #include <log.h>
 #include <net.h>
 #include <malloc.h>
-#include <mapmem.h>
 #include "nfs.h"
-#include "bootp.h"
+#include "nfs-common.h"
 #include <time.h>
 
-#define HASHES_PER_LINE 65	/* Number of "loading" hashes per line	*/
-#define NFS_RETRY_COUNT 30
-
-#define NFS_RPC_ERR	1
-#define NFS_RPC_DROP	124
-
-static int fs_mounted;
-static unsigned long rpc_id;
-static int nfs_offset = -1;
-static int nfs_len;
-static const ulong nfs_timeout = CONFIG_NFS_TIMEOUT;
-
-static char dirfh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle of directory */
-static unsigned int dirfh3_length; /* (variable) length of dirfh when NFSv3 */
-static char filefh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle */
-static unsigned int filefh3_length;	/* (variable) length of filefh when NFSv3 */
-
-static enum net_loop_state nfs_download_state;
-static struct in_addr nfs_server_ip;
-static int nfs_server_mount_port;
-static int nfs_server_port;
-static int nfs_our_port;
-static int nfs_timeout_count;
-static int nfs_state;
-#define STATE_PRCLOOKUP_PROG_MOUNT_REQ	1
-#define STATE_PRCLOOKUP_PROG_NFS_REQ	2
-#define STATE_MOUNT_REQ			3
-#define STATE_UMOUNT_REQ		4
-#define STATE_LOOKUP_REQ		5
-#define STATE_READ_REQ			6
-#define STATE_READLINK_REQ		7
-
-static char *nfs_filename;
-static char *nfs_path;
-static char nfs_path_buff[2048];
-
-enum nfs_version {
-	NFS_UNKOWN = 0,
-	NFS_V1 = 1,
-	NFS_V2 = 2,
-	NFS_V3 = 3,
-};
-
-static enum nfs_version choosen_nfs_version = NFS_V3;
-static inline int store_block(uchar *src, unsigned offset, unsigned len)
-{
-	ulong newsize = offset + len;
-#ifdef CONFIG_SYS_DIRECT_FLASH_NFS
-	int i, rc = 0;
-
-	for (i = 0; i < CONFIG_SYS_MAX_FLASH_BANKS; i++) {
-		/* start address in flash? */
-		if (image_load_addr + offset >= flash_info[i].start[0]) {
-			rc = 1;
-			break;
-		}
-	}
-
-	if (rc) { /* Flash is destination for this packet */
-		rc = flash_write((uchar *)src, (ulong)image_load_addr + offset,
-				 len);
-		if (rc) {
-			flash_perror(rc);
-			return -1;
-		}
-	} else
-#endif /* CONFIG_SYS_DIRECT_FLASH_NFS */
-	{
-		void *ptr = map_sysmem(image_load_addr + offset, len);
-
-		memcpy(ptr, src, len);
-		unmap_sysmem(ptr);
-	}
-
-	if (net_boot_file_size < (offset + len))
-		net_boot_file_size = newsize;
-	return 0;
-}
-
-static char *basename(char *path)
-{
-	char *fname;
-
-	fname = path + strlen(path) - 1;
-	while (fname >= path) {
-		if (*fname == '/') {
-			fname++;
-			break;
-		}
-		fname--;
-	}
-	return fname;
-}
-
-static char *dirname(char *path)
-{
-	char *fname;
-
-	fname = basename(path);
-	--fname;
-	*fname = '\0';
-	return path;
-}
-
-/**************************************************************************
-RPC_ADD_CREDENTIALS - Add RPC authentication/verifier entries
-**************************************************************************/
-static uint32_t *rpc_add_credentials(uint32_t *p)
-{
-	/* Here's the executive summary on authentication requirements of the
-	 * various NFS server implementations:	Linux accepts both AUTH_NONE
-	 * and AUTH_UNIX authentication (also accepts an empty hostname field
-	 * in the AUTH_UNIX scheme).  *BSD refuses AUTH_NONE, but accepts
-	 * AUTH_UNIX (also accepts an empty hostname field in the AUTH_UNIX
-	 * scheme).  To be safe, use AUTH_UNIX and pass the hostname if we have
-	 * it (if the BOOTP/DHCP reply didn't give one, just use an empty
-	 * hostname).  */
-
-	/* Provide an AUTH_UNIX credential.  */
-	*p++ = htonl(1);		/* AUTH_UNIX */
-	*p++ = htonl(20);		/* auth length */
-	*p++ = 0;			/* stamp */
-	*p++ = 0;			/* hostname string */
-	*p++ = 0;			/* uid */
-	*p++ = 0;			/* gid */
-	*p++ = 0;			/* auxiliary gid list */
-
-	/* Provide an AUTH_NONE verifier.  */
-	*p++ = 0;			/* AUTH_NONE */
-	*p++ = 0;			/* auth length */
-
-	return p;
-}
-
 /**************************************************************************
 RPC_LOOKUP - Lookup RPC Port numbers
 **************************************************************************/
-static void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
+void rpc_req(int rpc_prog, int rpc_proc, uint32_t *data, int datalen)
 {
-	struct rpc_t rpc_pkt;
-	unsigned long id;
-	uint32_t *p;
 	int pktlen;
 	int sport;
 
-	id = ++rpc_id;
-	rpc_pkt.u.call.id = htonl(id);
-	rpc_pkt.u.call.type = htonl(MSG_CALL);
-	rpc_pkt.u.call.rpcvers = htonl(2);	/* use RPC version 2 */
-	rpc_pkt.u.call.prog = htonl(rpc_prog);
-	switch (rpc_prog) {
-	case PROG_NFS:
-		switch (choosen_nfs_version) {
-		case NFS_V1:
-		case NFS_V2:
-			rpc_pkt.u.call.vers = htonl(2);
-			break;
-
-		case NFS_V3:
-			rpc_pkt.u.call.vers = htonl(3);
-			break;
-
-		case NFS_UNKOWN:
-			/* nothing to do */
-			break;
-		}
-		break;
-	case PROG_MOUNT:
-		switch (choosen_nfs_version) {
-		case NFS_V1:
-			rpc_pkt.u.call.vers = htonl(1);
-			break;
-
-		case NFS_V2:
-			rpc_pkt.u.call.vers = htonl(2);
-			break;
-
-		case NFS_V3:
-			rpc_pkt.u.call.vers = htonl(3);
-			break;
-
-		case NFS_UNKOWN:
-			/* nothing to do */
-			break;
-		}
-		break;
-	case PROG_PORTMAP:
-	default:
-		rpc_pkt.u.call.vers = htonl(2);	/* portmapper is version 2 */
-	}
-	rpc_pkt.u.call.proc = htonl(rpc_proc);
-	p = rpc_pkt.u.call.data;
-
-	if (datalen)
-		memcpy(p, data, datalen * sizeof(uint32_t));
-
-	pktlen = (char *)p + datalen * sizeof(uint32_t) - (char *)&rpc_pkt;
-
-	memcpy((char *)net_tx_packet + net_eth_hdr_size() + IP_UDP_HDR_SIZE,
-	       &rpc_pkt.u.data[0], pktlen);
-
-	if (rpc_prog == PROG_PORTMAP)
-		sport = SUNRPC_PORT;
-	else if (rpc_prog == PROG_MOUNT)
-		sport = nfs_server_mount_port;
-	else
-		sport = nfs_server_port;
+	rpc_req_common(rpc_prog, rpc_proc, data, datalen,
+		       (char *)net_tx_packet + net_eth_hdr_size()
+		       + IP_UDP_HDR_SIZE, &pktlen, &sport);
 
 	net_send_udp_packet(net_server_ethaddr, nfs_server_ip, sport,
 			    nfs_our_port, pktlen);
 }
 
-/**************************************************************************
-RPC_LOOKUP - Lookup RPC Port numbers
-**************************************************************************/
-static void rpc_lookup_req(int prog, int ver)
-{
-	uint32_t data[16];
-
-	data[0] = 0; data[1] = 0;	/* auth credential */
-	data[2] = 0; data[3] = 0;	/* auth verifier */
-	data[4] = htonl(prog);
-	data[5] = htonl(ver);
-	data[6] = htonl(17);	/* IP_UDP */
-	data[7] = 0;
-	rpc_req(PROG_PORTMAP, PORTMAP_GETPORT, data, 8);
-}
-
-/**************************************************************************
-NFS_MOUNT - Mount an NFS Filesystem
-**************************************************************************/
-static void nfs_mount_req(char *path)
-{
-	uint32_t data[1024];
-	uint32_t *p;
-	int len;
-	int pathlen;
-
-	pathlen = strlen(path);
-
-	p = &(data[0]);
-	p = rpc_add_credentials(p);
-
-	*p++ = htonl(pathlen);
-	if (pathlen & 3)
-		*(p + pathlen / 4) = 0;
-	memcpy(p, path, pathlen);
-	p += (pathlen + 3) / 4;
-
-	len = (uint32_t *)p - (uint32_t *)&(data[0]);
-
-	rpc_req(PROG_MOUNT, MOUNT_ADDENTRY, data, len);
-}
-
-/**************************************************************************
-NFS_UMOUNTALL - Unmount all our NFS Filesystems on the Server
-**************************************************************************/
-static void nfs_umountall_req(void)
-{
-	uint32_t data[1024];
-	uint32_t *p;
-	int len;
-
-	if ((nfs_server_mount_port == -1) || (!fs_mounted))
-		/* Nothing mounted, nothing to umount */
-		return;
-
-	p = &(data[0]);
-	p = rpc_add_credentials(p);
-
-	len = (uint32_t *)p - (uint32_t *)&(data[0]);
-
-	rpc_req(PROG_MOUNT, MOUNT_UMOUNTALL, data, len);
-}
-
-/***************************************************************************
- * NFS_READLINK (AH 2003-07-14)
- * This procedure is called when read of the first block fails -
- * this probably happens when it's a directory or a symlink
- * In case of successful readlink(), the dirname is manipulated,
- * so that inside the nfs() function a recursion can be done.
- **************************************************************************/
-static void nfs_readlink_req(void)
-{
-	uint32_t data[1024];
-	uint32_t *p;
-	int len;
-
-	p = &(data[0]);
-	p = rpc_add_credentials(p);
-
-	if (choosen_nfs_version != NFS_V3) {
-		memcpy(p, filefh, NFS_FHSIZE);
-		p += (NFS_FHSIZE / 4);
-	} else { /* NFS_V3 */
-		*p++ = htonl(filefh3_length);
-		memcpy(p, filefh, filefh3_length);
-		p += (filefh3_length / 4);
-	}
-
-	len = (uint32_t *)p - (uint32_t *)&(data[0]);
-
-	rpc_req(PROG_NFS, NFS_READLINK, data, len);
-}
-
-/**************************************************************************
-NFS_LOOKUP - Lookup Pathname
-**************************************************************************/
-static void nfs_lookup_req(char *fname)
-{
-	uint32_t data[1024];
-	uint32_t *p;
-	int len;
-	int fnamelen;
-
-	fnamelen = strlen(fname);
-
-	p = &(data[0]);
-	p = rpc_add_credentials(p);
-
-	if (choosen_nfs_version != NFS_V3) {
-		memcpy(p, dirfh, NFS_FHSIZE);
-		p += (NFS_FHSIZE / 4);
-		*p++ = htonl(fnamelen);
-		if (fnamelen & 3)
-			*(p + fnamelen / 4) = 0;
-		memcpy(p, fname, fnamelen);
-		p += (fnamelen + 3) / 4;
-
-		len = (uint32_t *)p - (uint32_t *)&(data[0]);
-
-		rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
-	} else {  /* NFS_V3 */
-		*p++ = htonl(dirfh3_length);	/* Dir handle length */
-		memcpy(p, dirfh, dirfh3_length);
-		p += (dirfh3_length / 4);
-		*p++ = htonl(fnamelen);
-		if (fnamelen & 3)
-			*(p + fnamelen / 4) = 0;
-		memcpy(p, fname, fnamelen);
-		p += (fnamelen + 3) / 4;
-
-		len = (uint32_t *)p - (uint32_t *)&(data[0]);
-
-		rpc_req(PROG_NFS, NFS3PROC_LOOKUP, data, len);
-	}
-}
-
-/**************************************************************************
-NFS_READ - Read File on NFS Server
-**************************************************************************/
-static void nfs_read_req(int offset, int readlen)
-{
-	uint32_t data[1024];
-	uint32_t *p;
-	int len;
-
-	p = &(data[0]);
-	p = rpc_add_credentials(p);
-
-	if (choosen_nfs_version != NFS_V3) {
-		memcpy(p, filefh, NFS_FHSIZE);
-		p += (NFS_FHSIZE / 4);
-		*p++ = htonl(offset);
-		*p++ = htonl(readlen);
-		*p++ = 0;
-	} else { /* NFS_V3 */
-		*p++ = htonl(filefh3_length);
-		memcpy(p, filefh, filefh3_length);
-		p += (filefh3_length / 4);
-		*p++ = htonl(0); /* offset is 64-bit long, so fill with 0 */
-		*p++ = htonl(offset);
-		*p++ = htonl(readlen);
-		*p++ = 0;
-	}
-
-	len = (uint32_t *)p - (uint32_t *)&(data[0]);
-
-	rpc_req(PROG_NFS, NFS_READ, data, len);
-}
-
-/**************************************************************************
-RPC request dispatcher
-**************************************************************************/
-static void nfs_send(void)
-{
-	debug("%s\n", __func__);
-
-	switch (nfs_state) {
-	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
-		if (choosen_nfs_version != NFS_V3)
-			rpc_lookup_req(PROG_MOUNT, 1);
-		else  /* NFS_V3 */
-			rpc_lookup_req(PROG_MOUNT, 3);
-		break;
-	case STATE_PRCLOOKUP_PROG_NFS_REQ:
-		if (choosen_nfs_version != NFS_V3)
-			rpc_lookup_req(PROG_NFS, 2);
-		else  /* NFS_V3 */
-			rpc_lookup_req(PROG_NFS, 3);
-		break;
-	case STATE_MOUNT_REQ:
-		nfs_mount_req(nfs_path);
-		break;
-	case STATE_UMOUNT_REQ:
-		nfs_umountall_req();
-		break;
-	case STATE_LOOKUP_REQ:
-		nfs_lookup_req(nfs_filename);
-		break;
-	case STATE_READ_REQ:
-		nfs_read_req(nfs_offset, nfs_len);
-		break;
-	case STATE_READLINK_REQ:
-		nfs_readlink_req();
-		break;
-	}
-}
-
-/**************************************************************************
-Handlers for the reply from server
-**************************************************************************/
-
-static int rpc_handle_error(struct rpc_t *rpc_pkt)
-{
-	if (rpc_pkt->u.reply.rstatus  ||
-	    rpc_pkt->u.reply.verifier ||
-	    rpc_pkt->u.reply.astatus  ||
-	    rpc_pkt->u.reply.data[0]) {
-		switch (ntohl(rpc_pkt->u.reply.astatus)) {
-		case NFS_RPC_SUCCESS: /* Not an error */
-			break;
-		case NFS_RPC_PROG_MISMATCH: {
-			/* Remote can't support NFS version */
-			const int min = ntohl(rpc_pkt->u.reply.data[0]);
-			const int max = ntohl(rpc_pkt->u.reply.data[1]);
-
-			if (max < NFS_V1 || max > NFS_V3 || min > NFS_V3) {
-				puts("*** ERROR: NFS version not supported");
-				debug(": Requested: V%d, accepted: min V%d - max V%d\n",
-				      choosen_nfs_version,
-				      ntohl(rpc_pkt->u.reply.data[0]),
-				      ntohl(rpc_pkt->u.reply.data[1]));
-				puts("\n");
-				choosen_nfs_version = NFS_UNKOWN;
-				break;
-			}
-
-			debug("*** Warning: NFS version not supported: Requested: V%d, accepted: min V%d - max V%d\n",
-			      choosen_nfs_version,
-			      ntohl(rpc_pkt->u.reply.data[0]),
-			      ntohl(rpc_pkt->u.reply.data[1]));
-			debug("Will retry with NFSv%d\n", min);
-			choosen_nfs_version = min;
-			return -NFS_RPC_PROG_MISMATCH;
-		}
-		case NFS_RPC_PROG_UNAVAIL:
-		case NFS_RPC_PROC_UNAVAIL:
-		case NFS_RPC_GARBAGE_ARGS:
-		case NFS_RPC_SYSTEM_ERR:
-		default: /* Unknown error on 'accept state' flag */
-			debug("*** ERROR: accept state error (%d)\n",
-			      ntohl(rpc_pkt->u.reply.astatus));
-			break;
-		}
-		return -1;
-	}
-
-	return 0;
-}
-
-static int rpc_lookup_reply(int prog, uchar *pkt, unsigned len)
-{
-	struct rpc_t rpc_pkt;
-
-	memcpy(&rpc_pkt.u.data[0], pkt, len);
-
-	debug("%s\n", __func__);
-
-	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-		return -NFS_RPC_ERR;
-	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
-		return -NFS_RPC_DROP;
-
-	if (rpc_pkt.u.reply.rstatus  ||
-	    rpc_pkt.u.reply.verifier ||
-	    rpc_pkt.u.reply.astatus)
-		return -1;
-
-	switch (prog) {
-	case PROG_MOUNT:
-		nfs_server_mount_port = ntohl(rpc_pkt.u.reply.data[0]);
-		break;
-	case PROG_NFS:
-		nfs_server_port = ntohl(rpc_pkt.u.reply.data[0]);
-		break;
-	}
-
-	return 0;
-}
-
-static int nfs_mount_reply(uchar *pkt, unsigned len)
-{
-	struct rpc_t rpc_pkt;
-	int ret;
-
-	debug("%s\n", __func__);
-
-	memcpy(&rpc_pkt.u.data[0], pkt, len);
-
-	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-		return -NFS_RPC_ERR;
-	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
-		return -NFS_RPC_DROP;
-
-	ret = rpc_handle_error(&rpc_pkt);
-	if (ret)
-		return ret;
-
-	fs_mounted = 1;
-	/*  NFSv2 and NFSv3 use same structure */
-	if (choosen_nfs_version != NFS_V3) {
-		memcpy(dirfh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
-	} else {
-		dirfh3_length = ntohl(rpc_pkt.u.reply.data[1]);
-		if (dirfh3_length > NFS3_FHSIZE)
-			dirfh3_length  = NFS3_FHSIZE;
-		memcpy(dirfh, rpc_pkt.u.reply.data + 2, dirfh3_length);
-	}
-
-	return 0;
-}
-
-static int nfs_umountall_reply(uchar *pkt, unsigned len)
-{
-	struct rpc_t rpc_pkt;
-
-	debug("%s\n", __func__);
-
-	memcpy(&rpc_pkt.u.data[0], pkt, len);
-
-	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-		return -NFS_RPC_ERR;
-	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
-		return -NFS_RPC_DROP;
-
-	if (rpc_pkt.u.reply.rstatus  ||
-	    rpc_pkt.u.reply.verifier ||
-	    rpc_pkt.u.reply.astatus)
-		return -1;
-
-	fs_mounted = 0;
-	memset(dirfh, 0, sizeof(dirfh));
-
-	return 0;
-}
-
-static int nfs_lookup_reply(uchar *pkt, unsigned len)
-{
-	struct rpc_t rpc_pkt;
-	int ret;
-
-	debug("%s\n", __func__);
-
-	memcpy(&rpc_pkt.u.data[0], pkt, len);
-
-	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-		return -NFS_RPC_ERR;
-	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
-		return -NFS_RPC_DROP;
-
-	ret = rpc_handle_error(&rpc_pkt);
-	if (ret)
-		return ret;
-
-	if (choosen_nfs_version != NFS_V3) {
-		if (((uchar *)&(rpc_pkt.u.reply.data[0]) - (uchar *)(&rpc_pkt) + NFS_FHSIZE) > len)
-			return -NFS_RPC_DROP;
-		memcpy(filefh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
-	} else {  /* NFS_V3 */
-		filefh3_length = ntohl(rpc_pkt.u.reply.data[1]);
-		if (filefh3_length > NFS3_FHSIZE)
-			filefh3_length  = NFS3_FHSIZE;
-		memcpy(filefh, rpc_pkt.u.reply.data + 2, filefh3_length);
-	}
-
-	return 0;
-}
-
-static int nfs3_get_attributes_offset(uint32_t *data)
-{
-	if (data[1]) {
-		/* 'attributes_follow' flag is TRUE,
-		 * so we have attributes on 21 dwords */
-		/* Skip unused values :
-			type;	32 bits value,
-			mode;	32 bits value,
-			nlink;	32 bits value,
-			uid;	32 bits value,
-			gid;	32 bits value,
-			size;	64 bits value,
-			used;	64 bits value,
-			rdev;	64 bits value,
-			fsid;	64 bits value,
-			fileid;	64 bits value,
-			atime;	64 bits value,
-			mtime;	64 bits value,
-			ctime;	64 bits value,
-		*/
-		return 22;
-	} else {
-		/* 'attributes_follow' flag is FALSE,
-		 * so we don't have any attributes */
-		return 1;
-	}
-}
-
-static int nfs_readlink_reply(uchar *pkt, unsigned len)
-{
-	struct rpc_t rpc_pkt;
-	int rlen;
-	int nfsv3_data_offset = 0;
-
-	debug("%s\n", __func__);
-
-	memcpy((unsigned char *)&rpc_pkt, pkt, len);
-
-	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-		return -NFS_RPC_ERR;
-	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
-		return -NFS_RPC_DROP;
-
-	if (rpc_pkt.u.reply.rstatus  ||
-	    rpc_pkt.u.reply.verifier ||
-	    rpc_pkt.u.reply.astatus  ||
-	    rpc_pkt.u.reply.data[0])
-		return -1;
-
-	if (choosen_nfs_version == NFS_V3) {
-		nfsv3_data_offset =
-			nfs3_get_attributes_offset(rpc_pkt.u.reply.data);
-	}
-
-	/* new path length */
-	rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
-
-	if (((uchar *)&(rpc_pkt.u.reply.data[0]) - (uchar *)(&rpc_pkt) + rlen) > len)
-		return -NFS_RPC_DROP;
-
-	if (*((char *)&(rpc_pkt.u.reply.data[2 + nfsv3_data_offset])) != '/') {
-		int pathlen;
-
-		strcat(nfs_path, "/");
-		pathlen = strlen(nfs_path);
-		memcpy(nfs_path + pathlen,
-		       (uchar *)&(rpc_pkt.u.reply.data[2 + nfsv3_data_offset]),
-		       rlen);
-		nfs_path[pathlen + rlen] = 0;
-	} else {
-		memcpy(nfs_path,
-		       (uchar *)&(rpc_pkt.u.reply.data[2 + nfsv3_data_offset]),
-		       rlen);
-		nfs_path[rlen] = 0;
-	}
-	return 0;
-}
-
-static int nfs_read_reply(uchar *pkt, unsigned len)
-{
-	struct rpc_t rpc_pkt;
-	int rlen;
-	uchar *data_ptr;
-
-	debug("%s\n", __func__);
-
-	memcpy(&rpc_pkt.u.data[0], pkt, sizeof(rpc_pkt.u.reply));
-
-	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
-		return -NFS_RPC_ERR;
-	else if (ntohl(rpc_pkt.u.reply.id) < rpc_id)
-		return -NFS_RPC_DROP;
-
-	if (rpc_pkt.u.reply.rstatus  ||
-	    rpc_pkt.u.reply.verifier ||
-	    rpc_pkt.u.reply.astatus  ||
-	    rpc_pkt.u.reply.data[0]) {
-		if (rpc_pkt.u.reply.rstatus)
-			return -9999;
-		if (rpc_pkt.u.reply.astatus)
-			return -9999;
-		return -ntohl(rpc_pkt.u.reply.data[0]);
-	}
-
-	if ((nfs_offset != 0) && !((nfs_offset) %
-			(NFS_READ_SIZE / 2 * 10 * HASHES_PER_LINE)))
-		puts("\n\t ");
-	if (!(nfs_offset % ((NFS_READ_SIZE / 2) * 10)))
-		putc('#');
-
-	if (choosen_nfs_version != NFS_V3) {
-		rlen = ntohl(rpc_pkt.u.reply.data[18]);
-		data_ptr = (uchar *)&(rpc_pkt.u.reply.data[19]);
-	} else {  /* NFS_V3 */
-		int nfsv3_data_offset =
-			nfs3_get_attributes_offset(rpc_pkt.u.reply.data);
-
-		/* count value */
-		rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
-		/* Skip unused values :
-			EOF:		32 bits value,
-			data_size:	32 bits value,
-		*/
-		data_ptr = (uchar *)
-			&(rpc_pkt.u.reply.data[4 + nfsv3_data_offset]);
-	}
-
-	if (((uchar *)&(rpc_pkt.u.reply.data[0]) - (uchar *)(&rpc_pkt) + rlen) > len)
-			return -9999;
-
-	if (store_block(data_ptr, nfs_offset, rlen))
-			return -9999;
-
-	return rlen;
-}
-
 /**************************************************************************
 Interfaces of U-BOOT
 **************************************************************************/
@@ -787,12 +73,14 @@ static void nfs_timeout_handler(void)
 	}
 }
 
+void nfs_refresh_timeout(void)
+{
+	net_set_timeout_handler(nfs_timeout, nfs_timeout_handler);
+}
+
 static void nfs_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			unsigned src, unsigned len)
 {
-	int rlen;
-	int reply;
-
 	debug("%s\n", __func__);
 
 	if (len > sizeof(struct rpc_t))
@@ -801,117 +89,7 @@ static void nfs_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	if (dest != nfs_our_port)
 		return;
 
-	switch (nfs_state) {
-	case STATE_PRCLOOKUP_PROG_MOUNT_REQ:
-		if (rpc_lookup_reply(PROG_MOUNT, pkt, len) == -NFS_RPC_DROP)
-			break;
-		nfs_state = STATE_PRCLOOKUP_PROG_NFS_REQ;
-		nfs_send();
-		break;
-
-	case STATE_PRCLOOKUP_PROG_NFS_REQ:
-		if (rpc_lookup_reply(PROG_NFS, pkt, len) == -NFS_RPC_DROP)
-			break;
-		nfs_state = STATE_MOUNT_REQ;
-		nfs_send();
-		break;
-
-	case STATE_MOUNT_REQ:
-		reply = nfs_mount_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
-			puts("*** ERROR: Cannot mount\n");
-			/* just to be sure... */
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-		} else if (reply == -NFS_RPC_PROG_MISMATCH &&
-			   choosen_nfs_version != NFS_UNKOWN) {
-			nfs_state = STATE_MOUNT_REQ;
-			nfs_send();
-		} else {
-			nfs_state = STATE_LOOKUP_REQ;
-			nfs_send();
-		}
-		break;
-
-	case STATE_UMOUNT_REQ:
-		reply = nfs_umountall_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
-			debug("*** ERROR: Cannot umount\n");
-			net_set_state(NETLOOP_FAIL);
-		} else {
-			puts("\ndone\n");
-			net_set_state(nfs_download_state);
-		}
-		break;
-
-	case STATE_LOOKUP_REQ:
-		reply = nfs_lookup_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
-			puts("*** ERROR: File lookup fail\n");
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-		} else if (reply == -NFS_RPC_PROG_MISMATCH &&
-			   choosen_nfs_version != NFS_UNKOWN) {
-			/* umount */
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-			/* And retry with another supported version */
-			nfs_state = STATE_PRCLOOKUP_PROG_MOUNT_REQ;
-			nfs_send();
-		} else {
-			nfs_state = STATE_READ_REQ;
-			nfs_offset = 0;
-			nfs_len = NFS_READ_SIZE;
-			nfs_send();
-		}
-		break;
-
-	case STATE_READLINK_REQ:
-		reply = nfs_readlink_reply(pkt, len);
-		if (reply == -NFS_RPC_DROP) {
-			break;
-		} else if (reply == -NFS_RPC_ERR) {
-			puts("*** ERROR: Symlink fail\n");
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-		} else {
-			debug("Symlink --> %s\n", nfs_path);
-			nfs_filename = basename(nfs_path);
-			nfs_path     = dirname(nfs_path);
-
-			nfs_state = STATE_MOUNT_REQ;
-			nfs_send();
-		}
-		break;
-
-	case STATE_READ_REQ:
-		rlen = nfs_read_reply(pkt, len);
-		if (rlen == -NFS_RPC_DROP)
-			break;
-		net_set_timeout_handler(nfs_timeout, nfs_timeout_handler);
-		if (rlen > 0) {
-			nfs_offset += rlen;
-			nfs_send();
-		} else if ((rlen == -NFSERR_ISDIR) || (rlen == -NFSERR_INVAL)) {
-			/* symbolic link */
-			nfs_state = STATE_READLINK_REQ;
-			nfs_send();
-		} else {
-			if (!rlen)
-				nfs_download_state = NETLOOP_SUCCESS;
-			if (rlen < 0)
-				debug("NFS READ error (%d)\n", rlen);
-			nfs_state = STATE_UMOUNT_REQ;
-			nfs_send();
-		}
-		break;
-	}
+	nfs_pkt_recv(pkt, len);
 }
 
 void nfs_start(void)
@@ -940,8 +118,8 @@ void nfs_start(void)
 		       nfs_path);
 	}
 
-	nfs_filename = basename(nfs_path);
-	nfs_path     = dirname(nfs_path);
+	nfs_filename = nfs_basename(nfs_path);
+	nfs_path     = nfs_dirname(nfs_path);
 
 	printf("Using %s device\n", eth_get_name());
 
diff --git a/net/nfs.h b/net/nfs.h
index 6bf1cb76bd58b0ca123f85d834355e30bf649811..0dd180ce2229ed6640ab8acb913f2876cc5e2772 100644
--- a/net/nfs.h
+++ b/net/nfs.h
@@ -6,15 +6,6 @@
 #ifndef __NFS_H__
 #define __NFS_H__
 
-#define SUNRPC_PORT     111
-
-#define PROG_PORTMAP    100000
-#define PROG_NFS        100003
-#define PROG_MOUNT      100005
-
-#define MSG_CALL        0
-#define MSG_REPLY       1
-
 #define PORTMAP_GETPORT 3
 
 #define MOUNT_ADDENTRY  1
@@ -29,56 +20,6 @@
 #define NFS_FHSIZE      32
 #define NFS3_FHSIZE     64
 
-#define NFSERR_PERM     1
-#define NFSERR_NOENT    2
-#define NFSERR_ACCES    13
-#define NFSERR_ISDIR    21
-#define NFSERR_INVAL    22
-
-/*
- * Block size used for NFS read accesses.  A RPC reply packet (including  all
- * headers) must fit within a single Ethernet frame to avoid fragmentation.
- * However, if CONFIG_IP_DEFRAG is set, a bigger value could be used.  In any
- * case, most NFS servers are optimized for a power of 2.
- */
-#define NFS_READ_SIZE	1024	/* biggest power of two that fits Ether frame */
-#define NFS_MAX_ATTRS	26
-
-/* Values for Accept State flag on RPC answers (See: rfc1831) */
-enum rpc_accept_stat {
-	NFS_RPC_SUCCESS = 0,	/* RPC executed successfully */
-	NFS_RPC_PROG_UNAVAIL = 1,	/* remote hasn't exported program */
-	NFS_RPC_PROG_MISMATCH = 2,	/* remote can't support version # */
-	NFS_RPC_PROC_UNAVAIL = 3,	/* program can't support procedure */
-	NFS_RPC_GARBAGE_ARGS = 4,	/* procedure can't decode params */
-	NFS_RPC_SYSTEM_ERR = 5	/* errors like memory allocation failure */
-};
-
-struct rpc_t {
-	union {
-		uint8_t data[NFS_READ_SIZE + (6 + NFS_MAX_ATTRS) *
-			sizeof(uint32_t)];
-		struct {
-			uint32_t id;
-			uint32_t type;
-			uint32_t rpcvers;
-			uint32_t prog;
-			uint32_t vers;
-			uint32_t proc;
-			uint32_t data[1];
-		} call;
-		struct {
-			uint32_t id;
-			uint32_t type;
-			uint32_t rstatus;
-			uint32_t verifier;
-			uint32_t v2;
-			uint32_t astatus;
-			uint32_t data[NFS_READ_SIZE / sizeof(uint32_t) +
-				NFS_MAX_ATTRS];
-		} reply;
-	} u;
-};
 void nfs_start(void);	/* Begin NFS */
 
 /**********************************************************************/

-- 
2.47.3

