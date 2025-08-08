Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04381C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35323846EA;
	Fri,  8 Aug 2025 13:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tQ3RmwwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1397F846E6; Fri,  8 Aug 2025 13:32:42 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F56D846D8
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459d40d16bdso13211435e9.0
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754652757; x=1755257557; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X2M1n3GGN5IflwlH3yZdS6LGR/6ajlZkjdJu8J3ZwE8=;
 b=tQ3RmwwKjUw3VJOK0261DKOLDMa78iKtgPEwObbnqiO2OBQ+8ddtir/zcB3dequ8gJ
 PPah9MEugIyvaE5QpvDQtETfXcD5bGy8YtPu63+svW6ldESDh9YExsgItD5C0PiS0ngU
 CQUrOloBfe6PnI7bM5FZJyHv3tk1xRNjutqBAIis8cWWPuVwiu6Z4xrVsHCIqhFfdx+a
 z+9O3IKiCtah54NPSEAGim/7ohe88CxSAbPjDVXJnoApj9Twj2J33UB3iwwwmKMhfJVX
 dwr5+VY6HHFGh4f77sWESZs+7tFCKzy5qvOnU8aFGsAhXYL0xLDC4NBJbAOx9KhPo3vf
 NyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754652757; x=1755257557;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2M1n3GGN5IflwlH3yZdS6LGR/6ajlZkjdJu8J3ZwE8=;
 b=tE38ecnGNcmdBFlr6EFwNY21hLySx/fM8s+7qGYE2tQ/6x+TwtkTtAmK+fLjryJkIW
 ejMpOkwa6pN8xh9c/L+j7RsVFIzWFHo/W2cRxP6AnVwqXKg32qxsZlpkmdtxIk9fYPqm
 n92Re3MvPEkpAkb+Q0LMriIh4F+pqCfMFR0pYz24eoljR3JHoVf9t5PSVR/jHMPU6T6n
 +5+BePXeyNS0HCicGWibjKHzgyrVVK455CF8FA5gDMJitriCV6fVeYB9tufjzEK3JD40
 SdJIqsHDjFOlvyp5RzGS10auptzO5/+yw6qO1wAanWhWCvAq+5Acvv8TZ3EI0iMdsf8Z
 ia4w==
X-Gm-Message-State: AOJu0YwKWEb3UWc6t5I7HLrbqE25yYajaz/1L5I5Y5JrRSsvqsQ8iiWM
 Evz62ILDfgUM9mVPwmO/SYkMNWN3dMmf5+ieu9KNZH6dUpgfMz0lpU3SPRemMqU4KgM=
X-Gm-Gg: ASbGncuDr6gtFRcgpdJHp3OeuxQd17+xvO5eVVX4XTOVLQi9bc94O0EEsstdW/ilQcu
 js6K9lNoABsIJl+KV+7TJLW/524w/QaGtfISWx7C9kQJVR0Tj3s6414yC6iQo/RM0ux8PdqbeiQ
 GHOAyic9RbhOq/4+dLSFjwZniVzIkuEEQM4KOyppJ3mlQiGBEFr8AjE3u3Atz/7yH6hk1rCl+DH
 wJGSUle/9WuUqjkIzc4M6x/x0pc2z2MB6xfX+RkvdJkLUDNQ+diq9uel6vrZO657TL9Xo1s8kX3
 tFvVp+sfx+D1hmIfW5Ojzkqx/vbKMuIfoAGe9Dc86ypMgxQZ9GPk2VYfv9ALTeTDqF2rdORFWDf
 o2LAqwVyCDFWbFuHPvQ0+2e/2UWdn+ZcW/MvJ5SPBqFAgjulAEpk=
X-Google-Smtp-Source: AGHT+IH+H5hmCD8dgPI16y6o6um87HS/CGwBQQ1DuAdpWNWQVP82etFVyiMuDetpyflZ5Tx6fduYSg==
X-Received: by 2002:a05:600c:524a:b0:456:1204:e7e6 with SMTP id
 5b1f17b1804b1-459f4f517dbmr20417425e9.11.1754652756822; 
 Fri, 08 Aug 2025 04:32:36 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45923c34af8sm233770995e9.24.2025.08.08.04.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 04:32:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 12:32:36 +0100
Subject: [PATCH] ram: renesas: dbsc5: Fix off by 1 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-ram_renesas-v1-1-c417163a2a38@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFPglWgC/x2NwQqDMBAFf0X2bCAqltRfKSKrvtQ9GMtuKYL47
 8Yeh2GYgwwqMOqKgxQ/MdlShqosaFo4veFkzky1r1sffHDK66BIMDYXH8+5Ck1sQvSUi5ENblR
 O03I3K9sXeouPIsr+37z687wAfSVVO3YAAAA=
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In dbsc5_read_vref_training the arrays dvw_min_byte0_table and
dvw_min_byte1_table have 128 elements per channel. The variable
vref_stop_index is limited to be a maximum of 128. This means that the
index used to access the arrays must use a test of '< vref_stop_index'
rather than '<= vref_stop_index' in order to prevent out of bounds
accesses to the arrays.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ram/renesas/dbsc5/dram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index ca8a7fb4783..3ed02e11f9e 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -3735,7 +3735,7 @@ static u32 dbsc5_read_vref_training(struct udevice *dev)
 	if (vref_stop_index > 0x80)
 		return 0;
 
-	for (i = 0; i <= vref_stop_index; i++) {
+	for (i = 0; i < vref_stop_index; i++) {
 		r_foreach_vch(dev, ch) {
 			reg = dbsc5_ddr_getval_slice(dev, ch, 0, PHY_PAD_VREF_CTRL_DQ);
 			reg &= 0xF << 10;
@@ -3819,7 +3819,7 @@ static u32 dbsc5_read_vref_training(struct udevice *dev)
 		best_vref_byte0_index = 0;
 		best_dvw_min_byte0 = dvw_min_byte0_table[ch][0];
 
-		for (i = 0; i <= vref_stop_index; i++) {
+		for (i = 0; i < vref_stop_index; i++) {
 			if (best_dvw_min_byte0 >= dvw_min_byte0_table[ch][i])
 				continue;
 
@@ -3858,7 +3858,7 @@ static u32 dbsc5_read_vref_training(struct udevice *dev)
 		vref_outlier = dbsc5_ddr_getval_slice(dev, ch, 0, PHY_RDLVL_VREF_OUTLIER);
 		best_upper_vref = best_vref_byte0;
 		outlier_cnt = vref_outlier;
-		for (i = best_vref_byte0_index; i <= vref_stop_index; i++) {
+		for (i = best_vref_byte0_index; i < vref_stop_index; i++) {
 			if (dvw_min_byte0_table[ch][i] <= 0)
 				break;
 
@@ -3879,7 +3879,7 @@ static u32 dbsc5_read_vref_training(struct udevice *dev)
 		best_vref_byte1 = vref_start;
 		best_vref_byte1_index = 0;
 		best_dvw_min_byte1 = dvw_min_byte1_table[ch][0];
-		for (i = 0; i <= vref_stop_index; i++) {
+		for (i = 0; i < vref_stop_index; i++) {
 			if (best_dvw_min_byte1 >= dvw_min_byte1_table[ch][i])
 				continue;
 
@@ -3918,7 +3918,7 @@ static u32 dbsc5_read_vref_training(struct udevice *dev)
 		vref_outlier = dbsc5_ddr_getval_slice(dev, ch, 1, PHY_RDLVL_VREF_OUTLIER);
 		best_upper_vref = best_vref_byte1;
 		outlier_cnt = vref_outlier;
-		for (i = best_vref_byte1_index; i <= vref_stop_index; i++) {
+		for (i = best_vref_byte1_index; i < vref_stop_index; i++) {
 			if (dvw_min_byte1_table[ch][i] <= 0)
 				break;
 

---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-ram_renesas-f69d183f38f0

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

