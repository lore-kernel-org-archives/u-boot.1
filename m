Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3A5C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9F18192A;
	Mon, 21 Apr 2025 18:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fvFvjTNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8281B4B; Mon, 21 Apr 2025 18:26:19 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D2A817C4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20E243FB68
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252777;
 bh=YmjybOU9P7zfu6g7Sx3HZ0EOBAq8zit5q6sQED7QJ+w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fvFvjTNrESBuLYD58uQB1kYGirIXvvs5BkqKnOiKugnRpAkcoL5TdIC8npwbXacdr
 fFQ9thzZ0/OW37WE9o8D2XjT0nqKbX5nepuMsmOpW+g1rtYw2z9akl2Dabkid277Sa
 MrRqzBwDpNmUbN6DSWyEKnmLGYj/ViawGx/Yy7C4FRs47tOBomt7UmWkmicW98Q3UK
 7UKy+wygCAT7CkPxKKHYmeJFkWc5vhM5m4x/yO8z0RgndKvK+WmxPLVL1sKRmKigB0
 +jX2LIM/Ff/IJE1LSCBc2hufn+Ny5oJ9eOKLaH+qBnBqBLwZN3ZEjaJwdGX0hWEOaU
 neqrMJfPpE8Hg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eed325461so24657835e9.3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252776; x=1745857576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmjybOU9P7zfu6g7Sx3HZ0EOBAq8zit5q6sQED7QJ+w=;
 b=oJT3x8rR336fEi/iRkNaVF+DnJpsl7sVjCNn09JxvC2l0qrrZ8v71JcKvTo6y9HVu8
 ylEyqwy9m+fqNMIhtvy4EO2mafKM3WZ8Owjx1kES0uoJSA14QLhMHSWSx4RJ1TkaJ/BL
 Dw4rpO1yDuZrFScY1ePVp6qDWWJxOlTZvkxK13KeP8lozlZw6IyxTt63GMCCqVLuCejE
 nmVPIbpUayWi3CkbtFJlaohhwd4S5TuSFqeT6YLFG2a50evyMtI/jr9ZIzzmKCAmZhPS
 JpQiOzxmKYu0J/8TzO/yNc7wAMSf4b1sovemvKtShU0czmHLW7GsZt1Pirrr4W32tDVC
 Ne6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGL9kTKecwSjzJPrUdTwJcTclMyu/KBWBzc5/806u9wBGX6sVRVQC6RsD2vwXN19Kvg9EQ2ZU=@lists.denx.de
X-Gm-Message-State: AOJu0YzeCXr0mEuuOmzC9RFlg1/u/bwBJFibyb4BwCmeZ0gFlz34wS+g
 eYYvLFGYzotqKxcvcDgMzc12PK5Ed/6Ytm5qN9SiOnMO4Tw9Ewj3k9+Mv3gP2zrPnXxsHYmzi8l
 5okPyjaYTORc3BseeHUhWeXa3VGnafDvTVALuew4FoOgUZYG62QfSl7RQLyja+8A2a/Y=
X-Gm-Gg: ASbGncv8+Sc76l1DpV8tgmos0rrSTwedN6pH52stWhizvNRb8adzirS3k9liizb2MPs
 mx9pTw44Y32mzktIIxSmt0Pl/8hy1NHbSNDza1pXcGbuVfJSVOQy9fOsqbFndi4UNPSIOMjpi0b
 LXEAGplLLCKKFO8T9KZ0NhrZQhp8/hDmp/qxHUqqeVGFyAZQajGETFihnBsxJ5mISumAgt29Tyq
 DDatmTyQxt3nfuDjRBe5iYMnvbEChYwoSjlme+Cp8+zvgbHYhZFmFaHPKqwaudXOjTTIpC84ksL
 CgLwR8eosYZd5R+96KZ3EDwf5tRZwRrUYwGHL+tG+Bqg46J7bGNQnrQEzCukapJqeTRtWSiGXdA
 LUf1oU1xUdtksMQ==
X-Received: by 2002:a05:600c:c0db:b0:43d:10a:1b90 with SMTP id
 5b1f17b1804b1-44072c7f6fbmr79578035e9.16.1745252776737; 
 Mon, 21 Apr 2025 09:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4fMNjHmp0+t0V96bixZ4GjL37kImWF/l1EF8c81iVn0Psfi5DFo9JXvRerfBqwLbB45ibdg==
X-Received: by 2002:a05:600c:c0db:b0:43d:10a:1b90 with SMTP id
 5b1f17b1804b1-44072c7f6fbmr79577885e9.16.1745252776381; 
 Mon, 21 Apr 2025 09:26:16 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
Date: Mon, 21 Apr 2025 18:25:48 +0200
Message-ID: <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

The EFI boot manager bootmeth does not require variable BootOrder to be
preexisting. It creates this variable.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootmeth_efi_mgr.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 42b8863815e..1669cbed5bd 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
 
 static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
-	struct efi_mgr_priv *priv = dev_get_priv(dev);
-	efi_status_t ret;
-	efi_uintn_t size;
-	u16 *bootorder;
-
-	if (priv->fake_dev) {
-		bflow->state = BOOTFLOWST_READY;
-		return 0;
-	}
+	int ret
 
 	ret = efi_init_obj_list();
 	if (ret)
 		return log_msg_ret("init", ret);
 
-	/* Enable this method if the "BootOrder" UEFI exists. */
-	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
-				&size);
-	if (bootorder) {
-		free(bootorder);
-		bflow->state = BOOTFLOWST_READY;
-		return 0;
-	}
+	bflow->state = BOOTFLOWST_READY;
 
-	return -EINVAL;
+	return 0;
 }
 
 static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
-- 
2.48.1

