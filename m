Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F139EE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6542805E9;
	Wed,  8 Jan 2025 15:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O6Qt1zMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8765980609; Wed,  8 Jan 2025 15:38:58 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485FD805E9
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so13073224f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736347135; x=1736951935;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GGk8ypRn2HdqKx5bZecE9fyICT54N9mxXtLckpEfxks=;
 b=O6Qt1zMHKPTJiHau/2gjkVslijLG3vQnTSHivxq8yM5L7VguoPXLb24OWLXIvWOwSg
 IFgtfWIsyN7PS67EugA9FQkU/GA3TLN9EbKhsNdOKilbbk3PYlThQyOrkPH4NUl8//qL
 aAiFSCeuk2/H6zw8aovqRVVH1xeXbmjZ4B88F2dNmRtTRx5Fp7s/XeCHLtRxscRQjSso
 6H2uwJC8MdIEzes9vgoIAykdTzQNohvhHAEXqXktCOXWgtZU2xX06TOkcIPM7zTUcGgW
 mTHQa+PAuY5SmaGtfFcP961WIE22UcCOJ4qqj/W8pKrjkiTtM2GMG6TZyH95tUlgXex7
 rLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736347135; x=1736951935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGk8ypRn2HdqKx5bZecE9fyICT54N9mxXtLckpEfxks=;
 b=ssBJfn3Hg1uVr1r4ryGUj2v0o1flSh88uBID1+yvqlOnRNhlYCGR9Eklrp0r6z8HHY
 JF6/lVDrJRQJVhIaRDS7FKWOdgfWj1PQTx8b5fvMhTgs5hRqXGo4a/GLue9RtGATzCip
 E4D9cXu6OXhYlV3PGBNZkS4uZXZjXkEoigp+1uoRNoCUhAwho/+6G7rDS6M/5rFlqssk
 RTiVkxF3TZ9UncFGOkfrjA5blor9EuQY62Cw6qNhQWx2WExhKSIxNWmeYJcxhLWhrMLt
 78rmg3EwO8rd32N0qSI2kRm7YDfnnrwQ2fNS1QtG+dp1z18W0dNZwdaRYcpwT0v1FKA4
 uRzw==
X-Gm-Message-State: AOJu0Yyzs73KS0JsYGClnOVGezTqqBdUiLIvoAyP/9ILVVpp46Z3z/Mk
 Px28kjcbq2azZebXj0VokV4xtkiOPeFGAmXrrKBy1v2RgQLS/7hwtVUxVstnJsQ=
X-Gm-Gg: ASbGncuMEOp9SDi/bEnc99MZNIatCzSifnictdr4OZjuccZU/6+rmgMrJ0MbDl8hdLY
 gcv4LbY1Cp0hVL57ZtG6QGNoKomIQcUjK0G0a26Rd3jaqP9kJCPEhJgFbJqx7weyUkfgAp9Tp8B
 9DS6EjfRVRFUy8Q8olBl3ufL9/1ktTXcJ/AbhFU7+ixgr/qoWEsI3S/WaNb/8Sk/2qqlbMfflIL
 8iYptFAUPcVgv2NMXrJGfTkzoK2LlIBFnULyn2H1iHWN4wXHEJMLRv2blOUU0UOCqciGMRM
X-Google-Smtp-Source: AGHT+IH7wcYE1JHaFvrD9gEZ0ltXZTnq3TC0gQo2fyiJmWIBxZsnZ3F2UcV43437Yh7HiY3b7Uzpug==
X-Received: by 2002:a5d:598d:0:b0:38a:624b:e7fe with SMTP id
 ffacd0b85a97d-38a872d121bmr2624625f8f.7.1736347134742; 
 Wed, 08 Jan 2025 06:38:54 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e3e779sm22796565e9.43.2025.01.08.06.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:38:54 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 08 Jan 2025 15:38:42 +0100
Subject: [PATCH v2 2/2] bootstd: android: Allow boot with AVB failures when
 unlocked
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-avb-disable-verif-v2-2-ba7d3b0d5b6a@baylibre.com>
References: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
In-Reply-To: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

When the bootloader is UNLOCKED, it should be possible to boot Android
even if AVB reports verification errors [1].

This allows developers to flash modified partitions on
userdebug/engineering builds.

Developers can do so on unlocked devices with:
$ fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img

In such case, bootmeth_android refuses to boot.

Allow the boot to continue when the device is UNLOCKED and AVB reports
verification errors.

[1] https://source.android.com/docs/security/features/verifiedboot/boot-flow#unlocked-devices
Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/bootmeth_android.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 2cd167f80280801618a317a65e93a10e70a0d9ee..dc9aad1633bb7a6d577013bfa0f939343f2e066b 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -407,17 +407,26 @@ static int run_avb_verification(struct bootflow *bflow)
 				 AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
 				 &out_data);
 
-	if (result != AVB_SLOT_VERIFY_RESULT_OK) {
-		printf("Verification failed, reason: %s\n",
-		       str_avb_slot_error(result));
-		avb_slot_verify_data_free(out_data);
-		return log_msg_ret("avb verify", -EIO);
-	}
-
-	if (unlocked)
-		boot_state = AVB_ORANGE;
-	else
+	if (!unlocked) {
+		/* When device is locked, we only accept AVB_SLOT_VERIFY_RESULT_OK */
+		if (result != AVB_SLOT_VERIFY_RESULT_OK) {
+			printf("Verification failed, reason: %s\n",
+			       str_avb_slot_error(result));
+			avb_slot_verify_data_free(out_data);
+			return log_msg_ret("avb verify", -EIO);
+		}
 		boot_state = AVB_GREEN;
+	} else {
+		/* When device is unlocked, we also accept verification errors */
+		if (result != AVB_SLOT_VERIFY_RESULT_OK &&
+		    result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION) {
+			printf("Unlocked verification failed, reason: %s\n",
+			       str_avb_slot_error(result));
+			avb_slot_verify_data_free(out_data);
+			return log_msg_ret("avb verify unlocked", -EIO);
+		}
+		boot_state = AVB_ORANGE;
+	}
 
 	extra_args = avb_set_state(avb_ops, boot_state);
 	if (extra_args) {
@@ -427,9 +436,11 @@ static int run_avb_verification(struct bootflow *bflow)
 			goto free_out_data;
 	}
 
-	ret = avb_append_commandline(bflow, out_data->cmdline);
-	if (ret < 0)
-		goto free_out_data;
+	if (result == AVB_SLOT_VERIFY_RESULT_OK) {
+		ret = avb_append_commandline(bflow, out_data->cmdline);
+		if (ret < 0)
+			goto free_out_data;
+	}
 
 	return 0;
 

-- 
2.47.1

