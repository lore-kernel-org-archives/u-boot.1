Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443EEC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EE354074E;
	Fri, 25 Sep 2026 13:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkKHG-WpRv0c; Fri, 25 Sep 2026 13:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B2AE40A61
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343762;
	b=pZXGOjnjKe1BlXAAR+vtqofKxjDGpl7Usd5JFCFufYEtzad9nfb34vGMhoufa8yH1y3b
	 kt3XWdPc3WH2WfIFbzdJsJgH4IDA12MoigfHT0aLeKYoGNUITvRmqi/6r+rQTUu7xe5CC
	 6iQ3abZccrri6/4Kz9CellmqJR3KnVzfzdzAD4IKc5DEoftU98rNKOOn8pVbW3ppOXWiS
	 JUNDUM2kgJMrZCCqRUMKAgV80D27TlXDU0W4CqCbahcRCVTXukMIHiwK/7WfnSTcXMvbJ
	 n9SPMbE2VDXP12fe+QM6pYwxCmDKpXOfIveDt4huTwhfcT08msH7h5yZ7o7KFgUeRTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
	b=GAPIPHqGXhjbm0dzPl264yrRvMpsf1NNo4cE6s0EGaYgMFp9Mh+u7hA4vHWxLyhpxzH2
	 qdI2dUST5HCvk2r4G0plAUlO3DPFc70uWynkTaWhzDzNoVlY4Ob76mRHIIgv+8eNZ0r+v
	 3V8lB4qKvvj21L50G+7HnB4EERN//QSsojbku5DvlX+zb2f7tyAmSHFalSQFBr3QxiMd5
	 94fFrKzX9aD88f80QSSi+5DZ9vfNJG9J+w0ShykHgU2UzlO+UieKhA6t4a13AmKiPSFkY
	 dzkiBYfJQojN8QU0Yyc+YEVb2ZvVGkTOZadu2Ztql0H9d2l3Z/hcEXdMeIrvWYaxdgg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343762;
	bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AAvNJbqOA6Tea6jRCq82lsaiFQB/Un9AliyWPGQt0T29hIgH3lI6KHu7Bi/s0+Fxj
	 SpJAbHEF+u4g1yKahbmPYg2Bpb0YLHxGhvV5qHqfZWmXsLQk3D5qvsvZ73w9lmh6nB
	 frjeOOjVKQzErs9x7gobF8lUYIJaEU/b6vv/5c1SiOpKNVjJ80kW2R1T3oCkbQhh1M
	 LR858SDLUolzs0p/cNeyhgZp5yl6/6G624fhBpL5N3Z3lqlcOah/RjQfLiVKV9qTCq
	 BVq3C8tgKmsK51CUJEc0r+F/Qu/rApyWGu3SqYoM7fpmyo4rxp1N7/B+8jHmmlZE5/
	 Ltytyyl4UNjzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B2AE40A61;
	Fri, 25 Sep 2026 13:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF97832F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4FAE81236
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xr_54mGoGq6y for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B23478113D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343755;
 b=aFWWnjmOrFyaRxc0/8u+f9fC1+vvI3WB0jYhQ3dZj4B6YeDZM3ryVXqUwWygmFLxLakY
 OwScYNf+m+ARv8X/I+3e9OqBi4kig0FgfbxpIo/chjggCo2qW8SV7Oc75iNbreggFhvt3
 LuhmRaGXLbKHyRO8cP7nSaFbNNmgFhpqlHdsmT7N42FpHzEtuoE1lNNTcciZgEA/Mdtih
 dAuwTBgz067XE2Fm19X1aUzba39urCm2/9VRAxRJ7WYykgHo/hWbWWEQs0S7jrEjuIY2+
 T2BFHq4Eg36hEqyf3xhnq6AxRnJDiV36X25ImjQkSM/A0t+H1SDhExflaK0i07rgVAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343755;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
 b=n9/jEu3HD+8StKP6eb53BRySyD1A/0evK/aJU3fZtRVRWvwhynr4IjzwZ6JcsqZED6ZE
 ENbKu6cq69dYBbMZWt05fDzUGp9KWlbEQJIeu7w4bKtsDx4JcPxidOhzrpYwSmDJvU9oF
 MyCbeGk1hM3csHq7Hlj5M3rcJWUIjX5Tl+TsH+mz66pd7AN7K96Zp6yFAop/CH4rc/4jv
 +Ozf4z3bYiapIsDR8ypauTQNNHwjpfjrSXlov3fBl2cbEj19OP51kOxqDIQiWz7m+ojVH
 EXPGoB5D6swSKNZPQgUfxtaVXy56iArqJLvR2fFgfZLKR6yKgDLJHmman1m5JLn2nRg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pZ7SstP7; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pZ7SstP7
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B23478113D
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:33 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso9768085e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343752; x=1790948552;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
 b=pZ7SstP78jP7MHAe2F+O1UL/t9i8O9M4KtEaAutSW6e9NPxROj3rELuV3lt6Qpsy13
 xh3l7cbh4QKx4Ts5IFC0rwBjvA1dem2+vXzPNkI1Xz0IfmlMt5QZeVbUM7kMvfzvcCTp
 K9lUQKSz70dBRNjKyJYzCour5HPOrUxsbHHZKzd+S7ybvXYhE36WjOJmTgYCOCdW5Jex
 sVI3c6wy+tTwAGG7Nzu6LX0ipDLoYHTuLalJJzqWV2OGRd1GbFK569br0LlbDiHlK7Zt
 OP5449l4oBBdSJxMe/E1cic87wh8geaQD+JemcwMhwVsQOTXCvNghTEzZsnRjkr3crQt
 AjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343752; x=1790948552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KNwV/SB7rHu3dnw/U9aQJw5zejT3kNv1outIXYJHIT4=;
 b=iJdIp26rg4VMBmlSJloNvYJPG5dzJD9fl5SJDFMgtr1Sdsqk5Gr0gnCnQhF9wwybuo
 8B1GcZ6nntyLOjUPhd60+waJZXjMCafrBcTzrkrLV9cLspzKl81dWp90sBeZOpCIeDBV
 yF7e3nqvpAExzNEFaO05V2tv6QHALthQPqYjPu/rSu3Xi8IG5kAbWzs3jcqqhiiQ+6tr
 4rbc/MIdhhOjTWbqHcRoF4cUVR2Q7SV4GSOi3+qjS3G/Ix+8+MzHRpCVX5/+o5g/dckX
 iFgPD1kl2NZsFLZGC4fwIgyqpGPJLpmRZqxVMHwuU3SqDVgnq/XuJdU+ijkIPQwhPGp3
 9b7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHREljuJGgcig6QxMNnZkVQfQwN4dO7TiBRwVc59+3WY2VnFhByTkZoBnDYgcE6H6PJL/Ya5Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mZ8BiNhbP+6tniF+LptSYsAnnxiHDHXa5GdzD0rE+bzRaoX2A2
 WlE9jawa3DGENLaYeduWFp8Zsi6KehRZNonn80SD2A3xwfamFLU23ugdTvO+MGrsBZo=
X-Gm-Gg: AYBFou0IiAxAkqr3/679unEPj3+HxZiCO3ZHVyRdHNliZoRmbrPhREiWDJVeqT5Y/qZ
 mZfd0yPgI0XzhM2wyQaNdjo2//e3XldOGzwaiO64RRO0MWdkY13IWUmZOez15WMei8fddN3YgRZ
 mr1aztFHL0/SI7+Gki9UvAvQ/VYWe5y04p/zly0kBUGMUwAIJhq8GIuaOybkzpHFYA1cWTP6RUy
 vBM/z1bQxnMCVT1ZyZNwEbbA6Gf/gyOijQSwpdyjl2XjffBySVsWR0PE1ga16JPgjTUQujZQy1X
 ZA4XV1Vwn9xd2/MlkYykyJEYO4hYQHrdb9biikh8TAwmNZQxZdizfeVn6As4lRFbwhnv/CG4Kmk
 sIV5qJZ8CeAYH/5HYCH/U4/D0A6lI318fjm3YHqUh/0rwhzYR92fXZ9wWWdMUngGoEeQMZZ2Tdy
 q8rN8+v4JLQSPvZ5WsqYnTxZp2r0jkmMnq0shCSMEGiEficfNl5tDtemgP8dlm
X-Received: by 2002:a05:600c:154f:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49fe7bbaf51mr94871415e9.27.1790343751947; 
 Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:26 +0200
Subject: [PATCH 3/4] configs: khadas-vim3: update the Android partition layout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-3-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Update the VIM3 and VIM3L GPT layout for the AOSP Android builds.
Add the missing frp, vendor_boot, init_boot, DLKM vbmeta and metadata
partitions. Grow super to 4 GiB, resize userdata and remove rootfs.

Set the vendor_boot and init_boot staging addresses and advertise
metadata as f2fs for fastboot format.

With the non-A/B defconfigs removed, keep only the A/B layout and
drop the unused ROOT_UUID.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 34 +++++++++++++++-------------------
 include/configs/khadas-vim3l_android.h | 34 +++++++++++++++-------------------
 2 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index 551ab51c881..18632bb95a0 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -10,36 +10,29 @@
 #define __CONFIG_H
 
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=frp,size=512K,uuid=${uuid_gpt_frp};" \
 	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};" \
+	"name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};" \
+	"name=vbmeta_system_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_a};" \
+	"name=vbmeta_system_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_b};" \
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
-	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#else
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#endif
+	"name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};" \
+	"name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};" \
+	"name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};" \
+	"name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};" \
+	"name=super,size=4096M,uuid=${uuid_gpt_super};" \
+	"name=metadata,size=64M,uuid=${uuid_gpt_metadata};" \
+	"name=userdata,size=10240M,uuid=${uuid_gpt_userdata};"
 
 #define CFG_EXTRA_ENV_SETTINGS                                    \
 	"board=vim3\0"                                               \
@@ -61,6 +54,9 @@
 	"kernel_addr_r=0x01080000\0"                                  \
 	"pxefile_addr_r=0x01080000\0"                                 \
 	"ramdisk_addr_r=0x13000000\0"                                 \
+	"vendor_boot_comp_addr_r=0x39000000\0"                        \
+	"init_boot_comp_addr_r=0x41000000\0"                          \
+	"fastboot.partition-type:metadata=f2fs\0"
 
 #include <configs/meson64.h>
 
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index 1869249e7c9..e84820a0d6d 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -10,36 +10,29 @@
 #define __CONFIG_H
 
 #define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
 
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
 #define PARTS_DEFAULT \
 	"uuid_disk=${uuid_gpt_disk};" \
 	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
+	"name=frp,size=512K,uuid=${uuid_gpt_frp};" \
 	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
+	"name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};" \
+	"name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};" \
+	"name=vbmeta_system_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_a};" \
+	"name=vbmeta_system_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_system_dlkm_b};" \
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
-	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#else
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-#endif
+	"name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};" \
+	"name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};" \
+	"name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};" \
+	"name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};" \
+	"name=super,size=4096M,uuid=${uuid_gpt_super};" \
+	"name=metadata,size=64M,uuid=${uuid_gpt_metadata};" \
+	"name=userdata,size=10240M,uuid=${uuid_gpt_userdata};"
 
 #define CFG_EXTRA_ENV_SETTINGS                                    \
 	"board=vim3l\0"                                               \
@@ -61,6 +54,9 @@
 	"kernel_addr_r=0x01080000\0"                                  \
 	"pxefile_addr_r=0x01080000\0"                                 \
 	"ramdisk_addr_r=0x13000000\0"                                 \
+	"vendor_boot_comp_addr_r=0x39000000\0"                        \
+	"init_boot_comp_addr_r=0x41000000\0"                          \
+	"fastboot.partition-type:metadata=f2fs\0"
 
 #include <configs/meson64.h>
 

-- 
2.34.1

