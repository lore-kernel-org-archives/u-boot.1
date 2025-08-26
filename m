Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A65CA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 19:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18062830F6;
	Tue, 26 Aug 2025 21:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iv8Fz1qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE968311B; Tue, 26 Aug 2025 21:38:24 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE9E830B3
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 21:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e96eb999262so364998276.2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756237101; x=1756841901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ybBY25yeLnVBJ5BZbSmiBbvuosbjlHDWWx+opbI6irQ=;
 b=Iv8Fz1qbIfGBowqDw51MSwqK+PuoMErtihgcVelUcOEP7NfxVEkST2CWUIPVzHnAro
 F7SlxGGY/FJy1NrfutGd8e5ZvvJbaSM9jrYab6jvWC6zQJQMzExe3T6THtDfu75V10eN
 UPUqT4fgNsSV6E8L04socLLMYo3OWjx5vzqkgXOi6iCluZk9mTnyHa8U3XAx3t83DoSl
 17hCm1UBpOZ2p0FqX+s6NiCzRcP+67nM/vUZOF3XbMCP9mMzccrOBMOajYJK9C9Oe0YE
 s7wnSmYQF0Tqru3KTpikjuEvuhCOrAbYXAWW4RsR//EoOlomo2dsYqvXDbrz83ZQ7MCQ
 gYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756237101; x=1756841901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybBY25yeLnVBJ5BZbSmiBbvuosbjlHDWWx+opbI6irQ=;
 b=ZwSkgu245bvhVKYQ0bkeYv7Xj9WrGUkOh0e8I3EoZYIlCidOTTrmDVNA368hRTZjHr
 WHY8VwzuCnHnjhgTABMLquSEDM1FvEEQq25QpzYzB/h9M264DPgyl9jRSpC1rj9/6hFl
 J/7ZV+osIvxAYRE3JvmHRMKP9WaNTH7LwXC4c+hbX6tAJdN42NbgVBIJIVG6/fKVpvZW
 OcnBpJBO4qzch/7C2ER/ZXmg7PrMeKbLMcSlVw6RhtPaxhBVcNTGfIVAFWj3KtiKRa+j
 ihcyLcB23wFewYc6prUqju/mX+2OysRAdEDGXw2DUhnQKGC1jRHFGsfDf8M6erp2RGtp
 i6eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVApK3qY+5CMQajH3cZQtTxSas9TJU+HvDCE/4i1LNxAHWOmhujAf2BDgkTzFmonOM5F54xc0k=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc5Rdq4wuI/DWo4JDKQmO76iIOYgys18xN5HmCKYxEXuvfzSUp
 6HhPNC341zDjvKprqGqEX4I2WvvILZX8dHkE2FXKO4XDPqSx9MHPlBEygQSQOA==
X-Gm-Gg: ASbGncv3PN4wqD5nsE74NfC7y/XTEtc34+EUEp0emWa8gEX9IFdp5Awgo2AjWL8m224
 p7cvUED3zXdnNgb9CJh/ITsoyb2w/hWZWztNk71AEnT2twPTlfjSD6ukkloq2SdGcmBa6Cmoemr
 Z1SF00iZYCJpkGjC9LfP+RmbYRr9SoP80ffBdRsKlmsCuJrtbc1MGILM53cRmp/1T76BfOc6EJn
 AwEamWNIkpWMC4C9sPvQTtF8tLTTYgd0fvf+aPoaq+8xPSY32Y9eHVxS14jl7WWp4+0nO21lyuL
 mBTLNLh9xaKioKLClxH/R60I/t8OofCBtKW/M5QVNcNtgUUeOjQxZUSMdnMF39Ue2svXt+jca02
 Zk9aCsxM04u4eA9F9O/XLtkNGuzZKwVyxAfMuGYjRxM6OzaoaePrrAhE2b59Z9xamHN408ca+z5
 LkwFTnbhUBAA==
X-Google-Smtp-Source: AGHT+IH6QNiSEDQM3EXJfNYzzhqNP5aMuu+BRttvzVrjZuGdPx2i9DwATbcObc/bBxZ0xgBl16MB7Q==
X-Received: by 2002:a05:690c:5511:20b0:71f:eb2b:83d5 with SMTP id
 00721157ae682-71feb2b878amr146784727b3.20.1756237101145; 
 Tue, 26 Aug 2025 12:38:21 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71ff18be5d9sm26146337b3.65.2025.08.26.12.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 12:38:20 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] fs: ext4fs: Add initialization failure recovery path in
 ext4fs_write
Date: Tue, 26 Aug 2025 12:37:17 -0700
Message-Id: <20250826193717.20543-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Don't invoke ext4fs_deinit() in ext4fs_write() if the failure occurs
during initialization. It would result in a crash since ext4fs_init()
has already done that.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
 fs/ext4/ext4_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index dd8ed40f888..5b290f0d80d 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -877,7 +877,8 @@ int ext4fs_write(const char *fname, const char *buffer,
 
 	if (ext4fs_init() != 0) {
 		printf("error in File System init\n");
-		goto fail;
+		/* Skip ext4fs_deinit since ext4fs_init() already done that */
+		goto fail_init;
 	}
 
 	missing_feat = le32_to_cpu(fs->sb->feature_incompat) & ~EXT4_FEATURE_INCOMPAT_SUPP;
@@ -1050,6 +1051,7 @@ int ext4fs_write(const char *fname, const char *buffer,
 	return 0;
 fail:
 	ext4fs_deinit();
+fail_init:
 	free(inode_buffer);
 	free(g_parent_inode);
 	free(temp_ptr);
-- 
2.39.5

