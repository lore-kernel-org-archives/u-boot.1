Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F799C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 13:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967A8883A4;
	Mon, 22 Apr 2024 15:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ixDs+I0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B750A883EA; Mon, 22 Apr 2024 15:50:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00D3883A3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 15:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 56F0A3F188
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713793823;
 bh=O8qNYPS/WJadczqPrdiOXAMfPG+UVYmAveH7ijcE1vA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ixDs+I0/HtRzInL+V1T8TqMfF2HwwOqlHrVdZ+wLfQFYE+NfX4L9J6kSdBi1T+ZhM
 /4NhUEqLkrCqcio+9/tV8x8GhGkY+EtYx1jcaJOV52wvcgD/UbL0on2IlL8F/Rcla/
 eqG6TG58VKvy6lPTnWt1UGkmfV9Ltu1C0NZy6aAw1vQ3wDL/nUCHrTJMitBk1iiQjK
 oAB50YqSSlSy2m14y48xQgqv0zyi4FEjWBSZjSE6JC836PowTPmG/YIN93IlPOMQku
 Acpv7wp48F4SVKQQvMq2PHjP2WlI8aZeFR+uf6T9Z1Ft4s2lbZtPbtN0iyjXgV8wew
 BRW3h2Tiglgrw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-419e3f83aeeso11992665e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 06:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713793822; x=1714398622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8qNYPS/WJadczqPrdiOXAMfPG+UVYmAveH7ijcE1vA=;
 b=pys4QcOlXPXuPNdPzdSwWuOar+HgvOrYSexvVYN9RvXWebC++MJTnEzj691qR0IozB
 xzR/6766I2Q9551oENVes5qset6hxdEiTyQ54TyNf8AHfxFbqEcB/HnMdyzIZkNW2Y/Z
 eswUKiTTyUh33yrKaQDtwxZoRha9uOXQTkpkyfkGCMoWg/cERlDYY4aiy6Ujncx1dM4O
 NU8BPrrneKeRrL5JzkpShZQZnKYNf4iYZDE0JYH1eSTjs3/Ne8UoUcOsv7UPjYLhTzLT
 cmyAnQkKv2DymSsr6ugfWI7F9d51FhdJT4FIr5P8YoLonsv2gI68Zq0AGWCHJ+RlCKHY
 uixw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA1RwujLKxPV9cj2B6divELFb9pNA+0zDtsok1dN+kqJo3fhXG65cHCQvR13nJ3nVrvIyJ+QDlL/1z2/ytNta+j6YDxA==
X-Gm-Message-State: AOJu0YzbzbR2sHA/7vB+3uDdb58H06vCJiglxlHF88GjZmfzorIFZ4vN
 MeK2tuyiWHLPB4k8ZYji+zuFWxiQr/ea1i5hRG3BZj0jjOWj3pz4YKuc68aOmqBvL/MITT0Xt79
 15CSy0SFaPRsnezFgULJzLoRO6boSoF6P7wIApJPFJztvom7veeWNk/QfvSfcNafOiek=
X-Received: by 2002:a05:600c:138c:b0:41a:821b:37f7 with SMTP id
 u12-20020a05600c138c00b0041a821b37f7mr1349478wmf.27.1713793821986; 
 Mon, 22 Apr 2024 06:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMkyFZV/Ckh+qOcFgJ+sgnrGP+H7dMxjTdTlxh/JrxJMryJPmfH3qkXSAkHuPQWl/uuqZFSA==
X-Received: by 2002:a05:600c:138c:b0:41a:821b:37f7 with SMTP id
 u12-20020a05600c138c00b0041a821b37f7mr1349465wmf.27.1713793821584; 
 Mon, 22 Apr 2024 06:50:21 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a05600c348900b0041a7cb8e96esm1985691wmq.30.2024.04.22.06.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 06:50:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: CONFIG_CMD_BLOBLIST must depend on CONFIG_BLOBLIST
Date: Mon, 22 Apr 2024 15:50:10 +0200
Message-ID: <20240422135010.176205-1-heinrich.schuchardt@canonical.com>
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

With CONFIG_CMD_BLOBLIST=y, CONFIG_BLOBLIST=n linker errors occur:

    usr/bin/ld: cmd/bloblist.o: in function `do_bloblist_list':
    cmd/bloblist.c:27:(.text.do_bloblist_list+0x6):
    undefined reference to `bloblist_show_list'

    /usr/bin/ld: cmd/bloblist.o: in function `do_bloblist_info':
    cmd/bloblist.c:19:(.text.do_bloblist_info+0x6):
    undefined reference to `bloblist_show_stats'

Fixes: 4aed22762303 ("bloblist: Add a command")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 42757e0cdf1..2386391daf1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -741,7 +741,8 @@ config CMD_BINOP
 
 config CMD_BLOBLIST
 	bool "bloblist"
-	default y if BLOBLIST
+	depends on BLOBLIST
+	default y
 	help
 	  Show information about the bloblist, a collection of binary blobs
 	  held in memory that persist between SPL and U-Boot. In the case of
-- 
2.43.0

