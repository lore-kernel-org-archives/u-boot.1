Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F24FCD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 09:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16B58718A;
	Tue, 26 Mar 2024 10:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83CD788019; Tue, 26 Mar 2024 10:34:41 +0100 (CET)
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net
 [178.33.251.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FAD87F64
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 10:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.17.88])
 by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4V3l4t56Cqz1d3n
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 09:34:38 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-tbvpx (unknown [10.110.168.217])
 by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 05A1920009;
 Tue, 26 Mar 2024 09:34:37 +0000 (UTC)
Received: from armadeus.com ([37.59.142.103])
 by ghost-submission-6684bf9d7b-tbvpx with ESMTPSA
 id X1+lOK2WAmbxeAAAE8nR6A
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 26 Mar 2024 09:34:37 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00582661fa7-6dfb-4e63-8092-3d26630fbfe1,
 053BE689857645FDD68B3632F2CDF9C290DDC83D)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.140.169.135
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Guillaume GARDET <guillaume.gardet@free.fr>, u-boot@lists.denx.de,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] net: nfs: fix file handle length in NFSv3
Date: Tue, 26 Mar 2024 10:34:31 +0100
Message-ID: <20240326093431.23962-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10857615754266471403
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefurogsrghsthhivghnucfuiiihmhgrnhhskhhiuceoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqeenucggtffrrghtthgvrhhnpefgleevhfejvddujeeuheehtdfghfetieevtdfhueeivdehuedvgefggfejgedtffenucffohhmrghinheprhhftgdqvgguihhtohhrrdhorhhgpdhrvghplhihrdgurghtrgenucfkphepuddvjedrtddrtddruddpledvrddugedtrdduieelrddufeehpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
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

The NFS protocol uses file handles to refer to file or directory.
In NFSv2 file handles have a fixed size of 32 bytes.
In NFSv3 file handles have a variable length up to 64 bytes. This is
also true for the MOUNT protocol. [1]
When the NFSv3 server replies with a file handle length > 32 bytes, U-Boot
only copies 32 bytes of that file handle and the next LOOKUP Call fails:

BIOS> nfs ${loadaddr} 192.168.1.51:/nfsroot/opos93dev-br/boot/Image
Using ethernet@428a0000 device
File transfer via NFS from server 192.168.1.51; our IP address is 192.168.1.133
Filename '/nfsroot/opos93dev-br/boot/Image'.
Load address: 0x80400000
Loading: *** ERROR: File lookup fail

done
BIOS>

Looking at this transfer in Wireshark, we can see that the server
replies with the following file handle:

    length: 36
    [hash (CRC-32): 0x230ac67b]
    FileHandle: 0100070101005e000000000091763911f87c449fa73c298552db19ba0c9f60002980cfd2

and U-Boot sends the following file handle in the next LOOKUP Call:

    length: 32
    [hash (CRC-32): 0x6314131b]
    FileHandle: 000000240100070101005e000000000091763911f87c449fa73c298552db19ba

Fix this by using a variable length file handle for dirfh.

[1] https://www.rfc-editor.org/rfc/rfc1813.html#page-106

Fixes: b0baca982048 ("net: NFS: Add NFSv3 support")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 net/nfs.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/nfs.c b/net/nfs.c
index 7a8887ef2368..c18282448ccd 100644
--- a/net/nfs.c
+++ b/net/nfs.c
@@ -57,7 +57,8 @@ static int nfs_offset = -1;
 static int nfs_len;
 static const ulong nfs_timeout = CONFIG_NFS_TIMEOUT;
 
-static char dirfh[NFS_FHSIZE];	/* NFSv2 / NFSv3 file handle of directory */
+static char dirfh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle of directory */
+static unsigned int dirfh3_length; /* (variable) length of dirfh when NFSv3 */
 static char filefh[NFS3_FHSIZE]; /* NFSv2 / NFSv3 file handle */
 static unsigned int filefh3_length;	/* (variable) length of filefh when NFSv3 */
 
@@ -377,9 +378,9 @@ static void nfs_lookup_req(char *fname)
 
 		rpc_req(PROG_NFS, NFS_LOOKUP, data, len);
 	} else {  /* NFS_V3 */
-		*p++ = htonl(NFS_FHSIZE);	/* Dir handle length */
-		memcpy(p, dirfh, NFS_FHSIZE);
-		p += (NFS_FHSIZE / 4);
+		*p++ = htonl(dirfh3_length);	/* Dir handle length */
+		memcpy(p, dirfh, dirfh3_length);
+		p += (dirfh3_length / 4);
 		*p++ = htonl(fnamelen);
 		if (fnamelen & 3)
 			*(p + fnamelen / 4) = 0;
@@ -565,7 +566,14 @@ static int nfs_mount_reply(uchar *pkt, unsigned len)
 
 	fs_mounted = 1;
 	/*  NFSv2 and NFSv3 use same structure */
-	memcpy(dirfh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
+	if (choosen_nfs_version != NFS_V3) {
+		memcpy(dirfh, rpc_pkt.u.reply.data + 1, NFS_FHSIZE);
+	} else {
+		dirfh3_length = ntohl(rpc_pkt.u.reply.data[1]);
+		if (dirfh3_length > NFS3_FHSIZE)
+			dirfh3_length  = NFS3_FHSIZE;
+		memcpy(dirfh, rpc_pkt.u.reply.data + 2, dirfh3_length);
+	}
 
 	return 0;
 }
-- 
2.43.2

