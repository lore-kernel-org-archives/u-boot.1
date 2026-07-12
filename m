Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DACBC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 12:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40E984A30;
	Sun, 12 Jul 2026 14:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FOLFwD2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B888497A; Sun, 12 Jul 2026 10:50:52 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12C5844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 10:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69c20ba892eso3270685a12.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783846250; x=1784451050; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=akTc10TqlO59c5OZS6OzISzZW5wLJ1Y9dSo/vLcrKyc=;
 b=FOLFwD2+Wl1cJVdunpos1ieaxg3WO7ZpFsh0BuhCM4azmXRs0qqlH8QqBtpTJBlWD7
 Hp5+CDT20MjodSgFHDrcww0OpHQElCPfxXe1AlBTaUXEULnBOgPcVjDeXhYEvW2XCcm7
 nsvGbVnAzLElrx+6fVu7mprFkoEUzHL3bTg8MVdpb/ZusnxnK1aebT6XksZIc04CHQSp
 zTU5LjQfn5VxVukgJZQH2GLI4SCKqhEy8ojncZropv8GpagpcK2oHTCvi0iY2BDJb+S0
 IpneQ1Eu1SohZ8wVE5jXiTFX1fF6wAROBdKSVgX8gUc3F9df9Ct2fxQZw3ikmCul30Ha
 7MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783846250; x=1784451050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=akTc10TqlO59c5OZS6OzISzZW5wLJ1Y9dSo/vLcrKyc=;
 b=gyFDGNPER2E8pAsB0r+Xwhap40SJpeVTk0iC+fws6AI+1dTdL3mIntY4njVG7Oicqt
 8zntmmlM9nc1300b9iqRqKIhuPobJE0qvBQG4I8QS3JJ5ici3Emertq+sDD+ui7exXK2
 CI9LCYfWAR0INCZqVq+sQvurTS/ZpJuG8+y2ZAz1gW7T/zcaw9WYU38FAz4a6aGXKa5r
 3BCfW0XLmlUE2YXmGikVwVYlrhnhboO+4JljE/KVQUKPVBM+yHveNo8ig9hYfp2F0nqL
 Vk0m9Vdn33whTs5V1NHHjNR4Zbwsdf24K7ksiapxgJwvgjT0gfHzv6W9653Vm/GrRO/W
 zzZg==
X-Gm-Message-State: AOJu0Yzg1UZ7Dd1hd96AeXMV/lWz5tHoyB0W86w2kytwTPgcAkw7jUV8
 8cVU94z1vH5of0qYTAl4WoqMUNotUBm6w+p33zl1n6gG4qWYgRwhwrshvoYD7Q==
X-Gm-Gg: AfdE7clRA6/p/9zAdKqg+EinMEQAmaaBQMnPerBjA8d9K0ojDDI1jNjrvs/iZKA3LP5
 4zAUwQPXibsMm19F2UYChXXc3NMp4nUvlsOXh8Yw8KHHy/mQjWvVqNPwpgKq5OisSNiCupbOcXi
 p+xCo7wcRaxHM3KcY0cGjBS4Ng9/3rWB1Q6K8XAlXse40Mck2fY/aVpZxPoC03XNNi8Kx1vVb8h
 rkoVEAbKyI/gvE6aahoWgY0UWSijvroyCZq7RmpwPL6jzrc6wLIp3b6WNGN4VDrnuQajvnHweyh
 /10BJGhJ86j5nG8xZyiolXvBbDc1cMl89teaBZLirT9zkSn1GLFhZeBmzHXo0DQOy80FuSW/DVN
 5MWsRBbbVbUCegmI6PGiTLQFWBQMX4SytNTbse6RXSy+pZ1nvL/Or9cIL5k0hVSul895OzhzmpO
 c7jxUATgLmVqbqhZEM52VcpN3XtP1vC2L0YzHe+mF/2px31AkRoPQT4DeG2R+hxOWhbRmcEZzuS
 rwk0ACf
X-Received: by 2002:a17:907:d40f:b0:c15:fc5b:b667 with SMTP id
 a640c23a62f3a-c161e991be4mr222905566b.19.1783846250217; 
 Sun, 12 Jul 2026 01:50:50 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15de6c565fsm525483966b.2.2026.07.12.01.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 01:50:49 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 12 Jul 2026 10:50:20 +0200
Subject: [PATCH 1/2] boot: android: fix AvbOps and verify-data leaks in AVB
 path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-avb-fix-memory-leaks-v1-1-51d6d5a42631@gmail.com>
References: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
In-Reply-To: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 12 Jul 2026 14:44:41 +0200
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

run_avb_verification() allocates an AvbOps via avb_ops_alloc() but never
frees it on any return path. Every Android boot attempt therefore leaks
the AvbOpsData structure and, when CONFIG_OPTEE_TA_AVB is enabled, leaves
the OP-TEE session open (it is only closed inside avb_ops_free()).

In addition, the AvbSlotVerifyData returned by avb_slot_verify() is only
released on the failure branches. The successful "return 0" paths (both
the locked GREEN/OK case and the unlocked ORANGE/ERROR_VERIFICATION case)
return without freeing it, leaking the whole out_data (cmdline and loaded
partition metadata) on every good boot.

Route all exit paths through a single cleanup label that frees both
out_data and avb_ops.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 boot/bootmeth_android.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 1d70e8d5c05..ec255b072af 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -428,7 +428,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
-	AvbSlotVerifyData *out_data;
+	AvbSlotVerifyData *out_data = NULL;
 	enum avb_boot_state boot_state;
 	char *extra_args;
 	char slot_suffix[3] = "";
@@ -443,8 +443,10 @@ static int run_avb_verification(struct bootflow *bflow)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
-	if (ret != AVB_IO_RESULT_OK)
-		return log_msg_ret("avb lock", -EIO);
+	if (ret != AVB_IO_RESULT_OK) {
+		ret = log_msg_ret("avb lock", -EIO);
+		goto out;
+	}
 
 	result = avb_slot_verify(avb_ops,
 				 requested_partitions,
@@ -458,9 +460,8 @@ static int run_avb_verification(struct bootflow *bflow)
 		if (result != AVB_SLOT_VERIFY_RESULT_OK) {
 			printf("Verification failed, reason: %s\n",
 			       str_avb_slot_error(result));
-			if (out_data)
-				avb_slot_verify_data_free(out_data);
-			return log_msg_ret("avb verify", -EIO);
+			ret = log_msg_ret("avb verify", -EIO);
+			goto out;
 		}
 		boot_state = AVB_GREEN;
 	} else {
@@ -469,9 +470,8 @@ static int run_avb_verification(struct bootflow *bflow)
 		    result != AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION) {
 			printf("Unlocked verification failed, reason: %s\n",
 			       str_avb_slot_error(result));
-			if (out_data)
-				avb_slot_verify_data_free(out_data);
-			return log_msg_ret("avb verify unlocked", -EIO);
+			ret = log_msg_ret("avb verify unlocked", -EIO);
+			goto out;
 		}
 		boot_state = AVB_ORANGE;
 	}
@@ -480,23 +480,28 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (extra_args) {
 		/* extra_args will be modified after this. This is fine */
 		ret = avb_append_commandline_arg(bflow, extra_args);
-		if (ret < 0)
-			goto free_out_data;
+		if (ret < 0) {
+			ret = log_msg_ret("avb cmdline", ret);
+			goto out;
+		}
 	}
 
 	if (result == AVB_SLOT_VERIFY_RESULT_OK) {
 		ret = avb_append_commandline(bflow, out_data->cmdline);
-		if (ret < 0)
-			goto free_out_data;
+		if (ret < 0) {
+			ret = log_msg_ret("avb cmdline", ret);
+			goto out;
+		}
 	}
 
-	return 0;
+	ret = 0;
 
- free_out_data:
+ out:
 	if (out_data)
 		avb_slot_verify_data_free(out_data);
+	avb_ops_free(avb_ops);
 
-	return log_msg_ret("avb cmdline", ret);
+	return ret;
 }
 #else
 static int run_avb_verification(struct bootflow *bflow)

-- 
2.53.0

