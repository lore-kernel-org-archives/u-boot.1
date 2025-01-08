Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8315DE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C1780608;
	Wed,  8 Jan 2025 14:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aXn36o+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03391805E2; Wed,  8 Jan 2025 14:43:35 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F858805EA
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so9120099f8f.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 05:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736343811; x=1736948611;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CIJ11LU6vCyTwtiQ6QtxTy2bNxZ7ziaUccIPBIk3nTE=;
 b=aXn36o+1NanEsGCgOwckIFAfSn8lMactQj3pUK6RPXeDtuoY13tiap4gEvEnz/x0DT
 /0Wf6XYgt3UCciLxNyvmJvt22ZfXgs7YE8Cwb08UDDMTy7MW7xxoifnGTYuP/Bort3RF
 f4UX6WmnpcHo+LyQY0i4KtjJZvCouRCPV9CkR11cb8j/plsFOmhnl08+cVBl+HKeg1kO
 7eBBCScEJ3PGcH2Kp1te9V+aTrVgSxFcEcU2QXL0trhDgkUQcHQlN0fPcfk4h9cp54AM
 0Ty+6l9OdfLF+gE4A2cmf6lkial7KrwfYaqLoXzPTSrJIZY5AIgpkRsOUkR+XDwAOi/y
 8M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736343811; x=1736948611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIJ11LU6vCyTwtiQ6QtxTy2bNxZ7ziaUccIPBIk3nTE=;
 b=chxDGdkJ/rzZAjeMLinEB1buD9SIvSN2NoOxSy5Al4Q8nx8jQftiv1t4T+Tg2CP7Jq
 HKrwghzEQW68xObjROmAnbPfgsBwrVW1xihzu0R+d26jfbtbDIWWaDKkv5iCt4JwWvwb
 0jde8DUZPpk20HAXlR1v94lEl449Vg8pArzwZWo7XKOiwZsSDEBl78fluNERTt8GLs5N
 KQqu2jmk+5J7QNtG8KWiFNVzwuI1Pjf3FXBjCHXoJQAEYGX5Uu3E1/lcu53pozFTBPBL
 cM45IXk6OScsvAHKKIYGXyCPU9Upq3ZqjEq/8KUZh0ejSiZcW3a3hulEAHTiiT5M6uYX
 2DTw==
X-Gm-Message-State: AOJu0YwrHSxyG0ANLDckMBcvj+PGymX1JEGC6OhPt4JSiQadUBAGZO8/
 FtXGQaLBgRr2ohdXScVFwndiqC+8HrxRtGtmfO3qeFyJ4WBVGQroZ1tS6wKiUnU=
X-Gm-Gg: ASbGncsw0E5T9KgN1RvGmuEc87r2fTt3vsgFjWO5IWGRWkQYV2F1hF1xkb/drSYkPDL
 OSQ0vRj61G/r/39wUoxLQaWzHC+s56X0hV4oSXb/aqDhrnehxs9DnSYVcqmh2f2oe39h8IeIMlq
 3EOtmjbj77gkdDRTizb/xh8vJOQkRxaIw2/16ql9s7psVUGSL24lTSVut2jDfmB7xC9Dam8lu1B
 u7h8MzpjcXa93E5H/ZQFeGNl87UqE2WGW81UuBmNtREBU1rFbVYlCLjQbw8q/6NyjYUQZdc
X-Google-Smtp-Source: AGHT+IF5Na+SdJxrsB96aw+tN8AB0SjUXnxw2NY6hLUNe7QhtLW9sBzC+PTeNPyPgmIfD5ClrrdAOA==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id
 ffacd0b85a97d-38a8733a1f9mr2620321f8f.45.1736343810790; 
 Wed, 08 Jan 2025 05:43:30 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e22767sm21166045e9.39.2025.01.08.05.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:43:30 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 08 Jan 2025 14:43:15 +0100
Subject: [PATCH 2/2] bootstd: android: Allow boot with AVB failures when
 unlocked
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-avb-disable-verif-v1-2-009c35710ef4@baylibre.com>
References: <20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com>
In-Reply-To: <20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com>
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
 boot/bootmeth_android.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 2cd167f80280801618a317a65e93a10e70a0d9ee..564d21784feb0667bf9bed2a59be0a232601a7dd 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -407,11 +407,16 @@ static int run_avb_verification(struct bootflow *bflow)
 				 AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
 				 &out_data);
 
-	if (result != AVB_SLOT_VERIFY_RESULT_OK) {
+	if (result != AVB_SLOT_VERIFY_RESULT_OK && !unlocked) {
 		printf("Verification failed, reason: %s\n",
 		       str_avb_slot_error(result));
 		avb_slot_verify_data_free(out_data);
 		return log_msg_ret("avb verify", -EIO);
+	} else if (result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION && unlocked) {
+		printf("Unlocked verification failed, reason: %s\n",
+		       str_avb_slot_error(result));
+		avb_slot_verify_data_free(out_data);
+		return log_msg_ret("avb verify unlocked", -EIO);
 	}
 
 	if (unlocked)
@@ -427,9 +432,11 @@ static int run_avb_verification(struct bootflow *bflow)
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

