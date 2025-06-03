Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BC1C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 04:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 927B382045;
	Tue,  3 Jun 2025 06:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIsvbyCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED01480BAE; Tue,  3 Jun 2025 06:50:52 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB82082045
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 06:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-735b9d558f9so1171704a34.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748926249; x=1749531049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgazYEwJSPKBvGHA0lxVinHebhRnoYlSEdlqnODI3gI=;
 b=fIsvbyCMPQh/5sZQF43KEmfP+pAhywdSoFwWJv+SYTT6f7KC/6sZBXbH6QySYo7cfq
 uHxR35nmntIA9jHICfIJ50mjHKQ6GavlqHULTYSFBpVu7ZlbeU9i+PT9B1bBTvX41FMw
 FsnZ6z7SKnp+ILU/08neo4h/bcXDE49g1kS0j7JC0Pg0sm7F1nZzfrBfieWWrA3/qQGD
 i29oayJDE/CBf2XZsaoLDWlt6qolnakuBqqlgy/bL8OU+fD0uPkOclV8xF/V3PL4gKNo
 /skmdLcgAZWeMOqiXvtOZ1E+7nXgDpuNZNlvhEyxTFltQkSwytBs9aoOVkx/uT6LiHz9
 N8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748926249; x=1749531049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgazYEwJSPKBvGHA0lxVinHebhRnoYlSEdlqnODI3gI=;
 b=vOeWXUXTzLcPHZLa301VfqW3WaJi/XgrwyBptjWGqT47kVm/rz06Juw+HS1IyUzzBP
 PGuohdlNhwK/P9b2yn+YNQsb9udq4vPzNAUdWwQW8OVc9pDAGnt27kmPP3qj0hMblkJc
 L7FEPs3NTY1REoiGfrN9rqES7/KNHjhlT9zPyIDIR8q31fjEq2RPNBols5SQfvm6M5ie
 7afBxhefN9kGzt63HLeqG1Cwn3xwuCOYmjzJNZmpApA6Tpv+8LjqLPmVHAR8Iiqg+yxL
 ZtyAmhT168fFpFVpqY3Gru+Tr20ZEWrsRb0OVIHwHiQqrWU6ielVf83qGyB2yDZPm7IP
 ffnw==
X-Gm-Message-State: AOJu0YynE78VaAlGs+U/6z92QWYzNFvEhHYZPZVCdAcpVMsVviqm0W9g
 fb2qXaWaMXD4rKJ5HldJhVGGoEQYy6PMvPZDhve5AkH6DHbuW5UudtgCgfhZqQ==
X-Gm-Gg: ASbGncue7zNFQNPVEM+xEqXZjb5K6sLSpzhINTqwZBu52PBcGzE++dmjf+e/cB4Vqxi
 aIfLRYaMUmVwBTtJ8+wCOCgIMv+eMn7ZLyfYRDlvX1lTTJyuq7CXxf4T8XQeo2qjHnQc3kxcpGf
 ixeqtZZ2UDhMqEoxhkwaoXSdqQ/fa6zLMNMSeyfcVoxi5Prg8e1TfBGPeYOdFVz13f7s4K/cWIs
 DIZQRWf8vRmifYm3BVfYpYf/QQD34tNkBEXhT643KMNJC/sKGfaWN+90GNiA+Sz2Qd37mIxbwHg
 rrHxVfMLV/LG4IiegnERJbSW2O3bYQoqYpZUQPtxQj2smcEHyZP1ZIOmZ0JUpwbAcyiYHqVLYvJ
 G2gaPv1iQNuHusDQXZHm8AyNDBfrD3yBNj3O3Ykc=
X-Google-Smtp-Source: AGHT+IE+x/8TiyMDfRxf5uT4OhryVaJ9GJtAHRbek3xWmWA/hig4UQeN8fnYhuNNzYBoYxsk/+Nv9Q==
X-Received: by 2002:a05:6830:6f4c:b0:72b:84a7:47e0 with SMTP id
 46e09a7af769-7366b051cb8mr9912499a34.1.1748926249341; 
 Mon, 02 Jun 2025 21:50:49 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af878f0bsm1767897a34.39.2025.06.02.21.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 21:50:48 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 1/1] fs: ext4fs: Fix: Data abort in ext4fs_log_gdt()
Date: Mon,  2 Jun 2025 21:50:22 -0700
Message-Id: <20250603045023.29630-2-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250603045023.29630-1-mibodhi@gmail.com>
References: <20250603045023.29630-1-mibodhi@gmail.com>
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

Return ENOMEM in ext4fs_log_gdt when number of blocks per gdt is more than
number of allocated journal entries.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 fs/ext4/ext4_journal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index 02c4ac2cb93..868a2c1804a 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -131,6 +131,13 @@ int ext4fs_log_gdt(char *gd_table)
 	struct ext_filesystem *fs = get_fs();
 	short i;
 	long int var = fs->gdtable_blkno;
+
+	/* Make sure there is enough journal entries */
+	if (fs->no_blk_pergdt > MAX_JOURNAL_ENTRIES) {
+		log_err("*** Not enough journal entries allocated\n");
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < fs->no_blk_pergdt; i++) {
 		journal_ptr[gindex]->buf = zalloc(fs->blksz);
 		if (!journal_ptr[gindex]->buf)
-- 
2.39.5

