Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63977C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 22:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16F082E25;
	Tue, 27 May 2025 00:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qHO9tddV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B38682EBE; Tue, 27 May 2025 00:29:37 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E245782DB7
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 00:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c13802133so685313a34.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748298574; x=1748903374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=roajmwZAOeYQbWQ9caJtmk/zwrBIx/l8lNn1Jvrc4PE=;
 b=qHO9tddV8lulxi27Y48JAFCDjbivFpO5/JK3PzC/gSWbKd/6RIGsPgZ9R5LaakE2hf
 t4g38qGm1p0QEEiSNOEFTCYnRNBMTdoxHTgFEdZEJZmn47wifn4w5zM4VsQ5mlCGSS+I
 JNqMG4FZftou85I269/ACsWpBglRGQN8vK5Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748298574; x=1748903374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=roajmwZAOeYQbWQ9caJtmk/zwrBIx/l8lNn1Jvrc4PE=;
 b=Owz12EMGetP5VWVpqarsdhLNVz1k0ioBkBrmzYEvWSjV+oV3wDhmndavXUTzqRj76u
 pQ5kaKzPz47Z5MqjRLJZPDJx2V24LlMZcna5ZYGGFQvh0d1q0lMgwv/nVHwZJ8G7ey6J
 G+5hqCXBBESQhd9oZURvS+AWunoEBQeE0P8M0pTKSSM1ITwvji+AYoNIQau512yPAfLH
 Xwn8qtA7/BTqYKyEyfoe2iOie78do5xKnJXiwRC2+5P5n6k+oKnOOyznxnzY8N9r+hb8
 r6CRU3JwCo7/lgcLJq5mbUZeO/klIFtwyA9TyI6pNKuTDm7xwWllwNzxE0QOidJ7v4nR
 gdmg==
X-Gm-Message-State: AOJu0Ywsp8Kmr29iJYGXZ8eGUWAK5Hnc6JTWvUlC6zbPOHMvbjHYZnF6
 fAHVGdfolysbdsorJrF9tB1xWHwswgkbg4d0AmrrJoEpZi8zO0Nhp9BuMsim3gwRs5uUiJgknpS
 YtI4XUvk=
X-Gm-Gg: ASbGncsiru/OPobD6uA1KihpD2tR/HnRaP0U9mc+QfMtY7sG+czJJNQlwx9LrT4HmY2
 WuoHN8PGmgJIOrcKto3M2X+0jlg+TZ+XxNCzQqg5ImomVCMp2MGyBLWgTLhFS2aXNRaZ0HyoQeW
 YEKZzg8SSbupCSx811x9OYrnK0gXSB2S2JP+axkz/kEzhWWc6gybx6dSM/ZAA/SuFkX72E1MCTk
 jOvdOWBm1e5Cy/Cl2VfkgbQrnnRUBFSFf/Tu6kBf+C1pLYNwtQ9TvEDMKGliLJqp0El+bCVRhri
 Sj0OcfOxlnMWhOg12KjFigJzjgjrITinSWSBRV60EiVLqPi5pLF+2bV1yvRhTbcbyqQsljhnWTW
 2q/IX/0th+agkVRc=
X-Google-Smtp-Source: AGHT+IEBXFQoPXJ0wq/UkwiYZt8BEHjHc1mBmkS1596ZNNvJ/yqNXeOLv9IWgJNM2yQQr9/+tvlQWA==
X-Received: by 2002:a05:6808:680a:b0:403:31b5:7eb1 with SMTP id
 5614622812f47-40646877de6mr6193892b6e.36.1748298573674; 
 Mon, 26 May 2025 15:29:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b87fa82c3sm2156537eaf.8.2025.05.26.15.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 15:29:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] Revert "ext4fs: Fix: Read outside partition error"
Date: Mon, 26 May 2025 16:29:31 -0600
Message-ID: <20250526222931.2775004-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The issue here is that the function read_allocated_block() will report
problems via a negative return value. If we say the return value is
stored in an lbaint_t that can no longer happen (and Coverity discovered
this by reporting a no effect comparison and then dead code). The
problem being fixed by allowing for storing a larger block number will
have to be solved in some other manner.

This reverts commit df2ed552f0b05591090369a7fe7ddc92439dea5c.

Addresses-Coverity-ID: 131183
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tony Dinh <mibodhi@gmail.com>
---
 fs/ext4/ext4fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index f10c622e62c5..1727da2dc6db 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -101,7 +101,7 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t pos,
 	blockcnt = lldiv(((len + pos) + blocksize - 1), blocksize);
 
 	for (i = lldiv(pos, blocksize); i < blockcnt; i++) {
-		lbaint_t blknr;
+		long int blknr;
 		int blockoff = pos - (blocksize * i);
 		int blockend = blocksize;
 		int skipfirst = 0;
-- 
2.43.0

