Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CB0C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A8A8832D;
	Wed,  5 Jun 2024 05:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1NQDCnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71111882AF; Wed,  5 Jun 2024 05:26:43 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55477882F9
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3749a160512so1755975ab.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717558000; x=1718162800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DwB7knJErWncuZw2hsDOiW5a1oIkrLbpZ326qjD5Us=;
 b=b1NQDCnEqPb/Xy8NIn443GUuDK4xMJbTMo02mJ6WzEWhcgJ9hei28mK52opNdlpfA0
 c7bj5HwxMJoMZSVcM62UwXGo8pB4IZIm1JOvIJxkyGpqzMkhXSUkn9gJ4syIr24VjoMp
 vCi/79/g2YAXFTRlbfy8QGLtxKecaW8uBLKn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558000; x=1718162800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DwB7knJErWncuZw2hsDOiW5a1oIkrLbpZ326qjD5Us=;
 b=ABUqK5yP+pct9/bU4ZEaMtk3LLxBoTwSJxt259Z2GcyXvrOQhBKD7oS1r0COHRZoFJ
 dEpG4L4hjPX0+c1J1gwNT2CbMbG5eb3G3W4iD0sWb055KEWdqIY2SxnGTRGqp6G+1FDK
 5xn6BpwFrvqD4sz8uuLGp6vPHiTZKRPmkDykYdR60wddre6shNaby/8EECsKggqiPqS3
 WyEokTkzwk96FnxM7m0f1aO0qtm5Kq/Rl08EliHvtensMfUtVPpIDMab4Cl632uU3RyX
 jo62fzacAy07FhkojD3xaoKy38++Bt+TELUDglls/PsgAooS/c/ZMTj39uKK/AgHjosu
 PoPw==
X-Gm-Message-State: AOJu0YxtP01iyUfbWbq/6WsGvSyqvM/UWn6ieB2Y3wjL/Dt3Q7mYcwUG
 F6aBriI9mc8LN4VU2ZLD6qd8CP5i1uAJtNSNTgfER4HN7gJaIUyxz8ISM2FFwKi7ciM+7yQd9WX
 BLQ==
X-Google-Smtp-Source: AGHT+IFvx4o1yDPKMR/09kg4PyzRnEE69hGKh5wxE7rwI1P4NbwNeijSX+tv62xy9Wq1A4ykkWjIVQ==
X-Received: by 2002:a05:6e02:178d:b0:374:9c23:a04e with SMTP id
 e9e14a558f8ab-374b12f20a8mr13472175ab.1.1717557999806; 
 Tue, 04 Jun 2024 20:26:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 4/9] power: regulator: Handle autoset in
 regulators_enable_boot_on()
Date: Tue,  4 Jun 2024 21:25:16 -0600
Message-Id: <20240605032521.1142768-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

With a recent change, regulators_enable_boot_on() returns an error if a
regulator is already set. Check for and handle this situation.

Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e..d9e1fb68295 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -518,7 +518,7 @@ int regulators_enable_boot_on(bool verbose)
 	     dev;
 	     uclass_next_device(&dev)) {
 		ret = regulator_autoset(dev);
-		if (ret == -EMEDIUMTYPE) {
+		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
 			ret = 0;
 			continue;
 		}
-- 
2.34.1

