Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31218F364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C36384105;
	Thu,  9 Apr 2026 20:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngQUpEaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10AE284099; Thu,  9 Apr 2026 18:44:59 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA8983CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebasjosue84@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-56d9c4f7f0bso725533e0c.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775753095; x=1776357895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UszRydjgnil6xCBl66k6CnSI51I6E8fv26ecdhZ21os=;
 b=ngQUpEaJpY/WF5D/AWsTV69qXasMiMQMpnFdovbaeED6D+M5A64OJFJNGJGDrDDTYp
 1Yxy7zc2oqw0oAyad1PfkQKJAZ7u04Ti2prMLvnIKYAugIlNQph79myULd/8kE3FcFQP
 HMt1cy2/H8SdO3TFOd0rO9W8dOT5sxYVqxltserHJaO41YuLEbt8cCEK9UCD/Bvzl5Nu
 xefG5KrRgBO1jj/zrjhQU35UHchVJwq2w/bsryxfX7PKHInCivzpG4FWJV79Rj8Yqjtp
 62oouMrZoR/hybp+QQviIWBA1sT8twlZYuwh/VgdIzlMWn+gdgIavc6MrldFAag9huRO
 CmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775753095; x=1776357895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UszRydjgnil6xCBl66k6CnSI51I6E8fv26ecdhZ21os=;
 b=VQyMCvW/RParTZ6WIL9AcamkG9rdazHoksJWHpSzj6Ga3K1K8bjM3fn4pSLu0ftUz4
 +M3xLkdTKQuxyIFy84JlKjTOoGSnJ+j4KSoHfbXxu4gODtEd/u+vq+pvf2irj9K1mEB7
 rTa4KhC+fxPO4vOYwsCx/b8cayqj5CcOIqkm8672R5f5nM/I8i/4+grXRKSxtkg8HGLR
 EjVl5d+C326EpSHL5SqrXmfV+gC+1kZ2H6sDy+FTyJhgXwpJsjebCsDlUJHiml7n/Pt0
 GAg5L0KYqab3ncV9CRgJ583L0sF8XXgRjX/Yfh+vQQcLu2UcBWKTMS2pgB0B7adplt1j
 kmKQ==
X-Gm-Message-State: AOJu0YxsA2w4XhHImSnUtORM5OMPExgp+WrJtJ3gjHJlrOuvTYupoYq1
 12LXggSFALR19ix50IE/ehPW6EZdUHS63/EeTvD/T3A4d0aE1xtzmt9sqx+bftqQ
X-Gm-Gg: AeBDieuv8OqoruChgNwgL4yX/VDbQRkcsdr/B2vR6zjezTKlWygVGDjJX8FjBzoDKt1
 aFP8xyjGsRVHlqogBVYrwG3r5R+ls7W8E+poQWEvWKu3jmQA5oLjJH8Iqp9AWDbunA6zRw1Bdqo
 WFcVSTazx+85R/0QM6hVPHev5qzs3GPaP5heldgA4pkCIx0DGq/fIoSwY2ScExFMNOiXICT2XYN
 9chKDhaxJKvO7G3dSpoEia4NfGC2mPwNPn0On/hiVRc7Noiqe4ic0pQD5c4Jb20rXiYADpAOlVA
 uLN1sco/BNY2aQDvGvZU/r4T57d/wXrY0nizymt13BRVihD0KX6VF6oQ0t8dHFlftiRHjS/Q0zf
 MtwrWCDPSs7a/eR1ySsyOG9jorshitEtDnZdtsF9hy/Q4Dym+Zx253aOQu7IkB1i3Pq10bmi3W0
 ohj7m1zFYFRuzSxkKtZXitwhkiyg==
X-Received: by 2002:a05:6122:4d0f:b0:56e:f2cb:190b with SMTP id
 71dfb90a1353d-56ef2cb2ab1mr8821130e0c.0.1775753095396; 
 Thu, 09 Apr 2026 09:44:55 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac1:76c0:1048::11:163])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d9bc9b75dsm22740384e0c.12.2026.04.09.09.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:44:54 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jerome.forissier@linaro.org, stable@vger.kernel.org,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
Date: Thu,  9 Apr 2026 10:44:40 -0600
Message-ID: <20260409164440.323405-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:28 +0200
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

From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>

nfs_readlink_reply() validates rlen only against the incoming packet
length (inherited from CVE-2019-14195), but not against the destination
buffer nfs_path_buff[2048]. A malicious NFS server can send a valid
READLINK reply where pathlen + rlen exceeds sizeof(nfs_path_buff),
overflowing the BSS buffer into adjacent memory.

The recent fix in fd6e3d34097f addressed the same overflow class in
net/lwip/nfs.c but left the legacy path in net/nfs-common.c unpatched.

Add bounds checks before both memcpy calls in nfs_readlink_reply():
- relative path branch: reject if pathlen + rlen >= sizeof(nfs_path_buff)
- absolute path branch: reject if rlen >= sizeof(nfs_path_buff)

Fixes: cf3a4f1e86 ("net: nfs: Fix CVE-2019-14195")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 net/nfs-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 4fbde67a..72d8fd82 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -674,11 +674,15 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 
 		strcat(nfs_path, "/");
 		pathlen = strlen(nfs_path);
+		if (pathlen + rlen >= sizeof(nfs_path_buff))
+			return -NFS_RPC_DROP;
 		memcpy(nfs_path + pathlen,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
 		       rlen);
 		nfs_path[pathlen + rlen] = 0;
 	} else {
+		if (rlen >= sizeof(nfs_path_buff))
+			return -NFS_RPC_DROP;
 		memcpy(nfs_path,
 		       (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset],
 		       rlen);
-- 
2.43.0

