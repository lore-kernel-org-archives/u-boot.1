Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6460E1073C93
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0908404A;
	Wed,  8 Apr 2026 14:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=saramena.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBE7840AB; Tue,  7 Apr 2026 23:32:44 +0200 (CEST)
Received: from saramena.us (saramena.us [71.19.144.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E6B8404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 23:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=saramena.us
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=murtaza@saramena.us
Received: from localhost.localdomain (c-98-248-123-35.hsd1.ca.comcast.net
 [98.248.123.35])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
 (No client certificate requested)
 by saramena.us (Postfix) with ESMTPSA id DA54615AB37;
 Tue,  7 Apr 2026 21:32:39 +0000 (UTC)
From: Murtaza Munaim <murtaza@saramena.us>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jerome.forissier@arm.com, andrew.goodbody@linaro.org,
 Murtaza Munaim <murtaza@saramena.us>
Subject: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
Date: Tue,  7 Apr 2026 14:32:31 -0700
Message-ID: <20260407213231.19133-1-murtaza@saramena.us>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

nfs_readlink_reply() copies the symlink target from an NFS READLINK
response into the global nfs_path_buff[2048] using a length (rlen)
obtained from the RPC reply. The existing bounds check validates that
rlen fits within the RPC packet, but does not check that the result
fits in the destination buffer.

When processing relative symlinks, the target is appended to the
existing path. By chaining two symlink resolutions, a malicious NFS
server can cause the combined path to exceed 2048 bytes, overflowing
nfs_path_buff and corrupting adjacent global variables (nfs_path,
nfs_filename, nfs_download_state, file handles). This can be
exploited to achieve remote code execution during NFS boot.

Add bounds checks against sizeof(nfs_path_buff) before both the
relative (append) and absolute (replace) memcpy operations.

Signed-off-by: Murtaza Munaim <murtaza@saramena.us>
---
 net/nfs-common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 4fbde67a760..30f549f9e1b 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -671,14 +671,24 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 
 	if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) != '/') {
 		int pathlen;
+		int new_len;
 
 		strcat(nfs_path, "/");
 		pathlen = strlen(nfs_path);
+		new_len = pathlen + rlen;
+		if (new_len >= sizeof(nfs_path_buff)) {
+			printf("NFS: symlink too long (%d bytes)\n", new_len);
+			return -NFS_RPC_ERR;
+		}
 		memcpy(nfs_path + pathlen,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
 		       rlen);
-		nfs_path[pathlen + rlen] = 0;
+		nfs_path[new_len] = 0;
 	} else {
+		if (rlen >= sizeof(nfs_path_buff)) {
+			printf("NFS: symlink too long (%d bytes)\n", rlen);
+			return -NFS_RPC_ERR;
+		}
 		memcpy(nfs_path,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
 		       rlen);
-- 
2.50.1 (Apple Git-155)

