Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE06C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAEA087456;
	Sat,  4 Nov 2023 21:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kCi/3Z6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9649287440; Sat,  4 Nov 2023 21:38:20 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEB68701C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778925998cbso197076685a.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130289; x=1699735089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3n1lmP+rJVgM0ljOGVDGizm06HWWCA6XEN/2Y62ds8=;
 b=kCi/3Z6tplXBttlIRR6OTkS8j2kPmDPGwyOt/fKAJYNd24BpxVT1FXxmKVizN/rGUR
 m9E+IiQsD2Id8iiRzJQQ+KmZaJwA7B0acw8CHThBBt3GT8Mj/tLh+9zG6mDE+OIEN46J
 HIqh1oqJcibnwHme1lWThmYdMhcjv9yBBsi7Ud4jEBxOe65eLZIsyibZHowmStuO9WEL
 OXsO3C2dDL30bKIWsrGCLXj6kkL2e1Z89bc0H2/qdmmTYlkW81Ffk9w8HxbL99Drn9YG
 2VbCWac8yFRx2yj8eTfWDoBQN+lCJGFYbr1GLvA/ViPDoQIE3SlwQyUrrVXXUE/zLq8h
 PklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130289; x=1699735089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3n1lmP+rJVgM0ljOGVDGizm06HWWCA6XEN/2Y62ds8=;
 b=ClH30xcRBFlluN4gpXim88zxLBsDa4E5fRJ+ITxZXVqmjvityFCTT7zOOzfjKvjpui
 Qwg9B6gJqKL03U8w2bVxMT3mccwm30wwrh3YOEOe9fOT9VTGH/UMhsX2WDglRsJYovw5
 b2ipHV8VT2uB1BB5mJOF9FwCfp10ZBK5ZwtyjnMG+5eZqTrZhn9Mu8OtC6+0Qtg+DYGu
 ONfAozMMuDXVN172S+KLH9OD5ym90I+TlOT3JB8emD9XfdSDknGvjVWa5T532lPZJGiZ
 ILlBfpUNRdpYMNtxEHOEbQX1IrjRaP6ML2t/qHQgFM4SNdJ9j5Ck8AMo2lrHGSnKyfkZ
 PkoA==
X-Gm-Message-State: AOJu0YyVMsmcTWZIttofVyKlZHUzVZoN+b3LQJAhYm/lu30iaLqN3+iT
 7dAbbEBfzGBtPXHt1OVGr/r00ywwda2y7g==
X-Google-Smtp-Source: AGHT+IHmWQJfopThhaWZhpqwG4u2aQbvXisHFHMlyutBLu2k5XS6zUnYhPporMFmqmx9XuIeW20FyA==
X-Received: by 2002:a05:620a:44d4:b0:77a:5249:935d with SMTP id
 y20-20020a05620a44d400b0077a5249935dmr11789424qkp.62.1699130288891; 
 Sat, 04 Nov 2023 13:38:08 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 h10-20020a05620a400a00b0076efaec147csm1833246qko.45.2023.11.04.13.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:08 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 11/15] nand: Add function to unregister NAND devices
Date: Sat,  4 Nov 2023 16:37:49 -0400
Message-Id: <20231104203753.1579217-12-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

This performs the opposite of nand_register, allowing drivers to unregister
nand devices. This is probably unnecessary for most regular drivers, but we
expect sandbox drivers to get repeatedly bound/unbound, so this will help
avoid dangling pointers.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/mtd/nand/raw/nand.c | 17 +++++++++++++++++
 include/nand.h              |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index 3abd82068fb..80017b3dddd 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -74,6 +74,23 @@ int nand_register(int devnum, struct mtd_info *mtd)
 	return 0;
 }
 
+void nand_unregister(struct mtd_info *mtd)
+{
+	int devnum = nand_mtd_to_devnum(mtd);
+
+	if (devnum < 0)
+		return;
+
+	if (nand_curr_device == devnum)
+		nand_curr_device = -1;
+
+	total_nand_size -= mtd->size / 1024;
+
+	del_mtd_device(nand_info[devnum]);
+
+	nand_info[devnum] = NULL;
+}
+
 #if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 static void nand_init_chip(int i)
 {
diff --git a/include/nand.h b/include/nand.h
index c1d7533aaac..fc584f5ef7a 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -22,6 +22,7 @@ int nand_mtd_to_devnum(struct mtd_info *mtd);
 #if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 void board_nand_init(void);
 int nand_register(int devnum, struct mtd_info *mtd);
+void nand_unregister(struct mtd_info *mtd);
 #else
 struct nand_chip;
 
-- 
2.37.1

