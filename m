Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6549C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 00:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338F3871B1;
	Tue, 14 Nov 2023 01:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="MlW8+zsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D77A87061; Tue, 14 Nov 2023 01:49:58 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3494A868AE
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40a46ea95f0so30918255e9.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699922987; x=1700527787;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHQMv9bTA56M98Ha0U+T8cu+BIK/Bpy8cWycPWRTnYc=;
 b=MlW8+zspKZkRfldSyMBmO6ttl26/bSIu34Dy/3cfgeu1JD+4kLGlibph502KB8+5+r
 P8By2JOkSkqyfwKaEKb1RHcsWwHtXUVPbWKxN23xtiZhAYi9gtCXguHwOLDTx3iHk1KL
 oswP08M4Y9p2xgB+lLmNFQ00BHq6DjEebvZvYuF9KM7gK3+KOUaLPoYQ5dY/rXh9OOto
 hvYkS/8sitKYAy//RDUr2T1dmUeGa5Wf7By+R0eUdI7oGGhEhPuHTl/O8t3mer16xpX8
 5VzM48HQlAg7g7o5qOG5H2c6t3DJpQuIWKZj9lHhn7UJKfB4KTTbTT5iKVhaq3A99Q3X
 qMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699922987; x=1700527787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHQMv9bTA56M98Ha0U+T8cu+BIK/Bpy8cWycPWRTnYc=;
 b=G6TtyZ31cMKDZ1JbJIMM0CyHLTsO0TnmrFZOH1hn6pKqQeXaEj2fU/Fk+6rK9kQM/F
 tBe9MHgBvzA7ptGUOKq7atc8z6gSGlpLcC7jDFbhioS4Y+/aCMr2spJ2DGXO+Vk1j7An
 PF3O61z8UfhjQB8RE0CWbhDwJxoOWzk0FnkQt7dQMxmz+UvPRJpeoPVrD5u5MPlu0kWK
 dmeRCXNzjbKzMaXqtFU1xcSotsbsFInOdu8g13IGG4AOwTn5yPpDA6HkNgDqt/zQu141
 F06t14CReDTNAOFJeqJca4MUiKZv5Uufnpblf4rJeX+XNhioz74TYRL0ZGjIDyOG0RQ/
 NQaQ==
X-Gm-Message-State: AOJu0YygMSK+kXXO0mnX3w4f70+sxlqxYz4JCdn9k++b18QtWBEApcC3
 WbZPFAFtN3IB5XHUS/bv68IwyUSA0KV50Ai5ZClVqxvQ
X-Google-Smtp-Source: AGHT+IErJKjsSXT3j4uk+MlXi2aG78S2hvRzFZPi6qkjpm95nXjZSISJlc3g+3XodHTAhYmeBwcEbw==
X-Received: by 2002:adf:f241:0:b0:32f:7cba:6815 with SMTP id
 b1-20020adff241000000b0032f7cba6815mr5288432wrp.61.1699922987392; 
 Mon, 13 Nov 2023 16:49:47 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0032d2f09d991sm6402675wrm.33.2023.11.13.16.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 16:49:47 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	trini@konsulko.com,
	Shantur Rathore <i@shantur.com>
Subject: [PATCH v1 2/3] bootflow: bootmeth_efi: Don't set bootdev again
Date: Tue, 14 Nov 2023 00:48:25 +0000
Message-Id: <20231114004826.815833-3-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114004826.815833-1-i@shantur.com>
References: <20231114004826.815833-1-i@shantur.com>
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

efi_set_bootdev is already called as part of tftp while doing dhcp_run()
Doing this again crashes U-boot and we don't need to call again.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ad3f4330da..a65d8ff582 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -359,9 +359,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
 
-	/* do the hideous EFI hack */
-	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-			bflow->size);
 
 	/* read the DT file also */
 	fdt_addr_str = env_get("fdt_addr_r");
-- 
2.40.1

