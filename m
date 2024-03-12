Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBFEC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8ADE87E71;
	Tue, 12 Mar 2024 16:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cl3F3iOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A29E87F27; Tue, 12 Mar 2024 13:57:36 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414F187E49
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=colinmca242@gmail.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7c8bb3c2494so65820039f.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710248252; x=1710853052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0npeMhlc1fX8H0cY0RQCnKhuOJJvuGa8r6znLHU1s3E=;
 b=Cl3F3iORxwu/gdxWBm6YiE6zAA6CiaD4wtHoskO8BHs58Ipc/OApoA//tGSvFrvIxF
 NOvqj2yhy2eAdqw2NTBallsu3w7SFlYuB4PoJd18bG8h3u+b+mqHxd8mHLBuXDH+JkRf
 VE5ri+iEdXGwxnCibaWMv8iIQb2ZYhUUfgjyvkqtVSJjh3jOaKvCREKeVXtIO3ln5Aca
 ZIHjjP9GPhDvmqNd9V8fW6jMI5SawujhMdrfWh3LRFqqWbKUDt59iAsywH5LQMwWgKRz
 Nf9q7aB7VTmckNpl2UnTuxa/f0QjdgsjJ0khOaUDAFoniK9wJEbuiMC2dO983u8VS8CN
 oZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710248252; x=1710853052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0npeMhlc1fX8H0cY0RQCnKhuOJJvuGa8r6znLHU1s3E=;
 b=IhezmtmqjQ0pqpLNLD4Zi/z+Tt58k90ZnlpKjw8uflda6VUPGMeVkVgMOXgs4IzbWk
 qi/G2O1kzIuk+PbKpDHvD+SmduiQ6wsNpZp2OeZAQ5EXOs5ExqTw3WcG8XEXqFEGb/oB
 SgMB90SZ81ixPQzecRpVpt/JpyHd9hUK7cH/+u99+QdhzC5nPvaOctvJPJ8tmFTGBLBV
 IewkKAcTahufZOXsgjUfDsczD3tmKb9xYlnD5w16A1XHFKsx2cHfAMNMYhNwF3EHOBiQ
 SmHozUxgD646KchqLAKfKwpj0P8Wxvlgxni6Waq05FIaZD21W69Ci1Vqx/hoRh7sCO3Z
 LCUA==
X-Gm-Message-State: AOJu0YzUaOL4MnZMs+ZhLOnSG0xLgda3upy5KuqGi2ecFLgfYfd3c9PR
 SMHj/08XtknGb3F8DlyWczRlkVQlZacbgOaUwBOBUSgn0tQrhMnNjtaN6Y9ANu4=
X-Google-Smtp-Source: AGHT+IHHfb3dUK03EBwBxLSJwFQ3J9u2vO2z7lG+ZuntqhcwU7S9a+Nx9ZXqxI/PD/xLjIe/6HoIyQ==
X-Received: by 2002:a05:6e02:1a66:b0:365:616a:72da with SMTP id
 w6-20020a056e021a6600b00365616a72damr6825904ilv.7.1710248252296; 
 Tue, 12 Mar 2024 05:57:32 -0700 (PDT)
Received: from rehoboam.localdomain ([136.37.200.217])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a92d485000000b0036577b41481sm2278595ilg.73.2024.03.12.05.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 05:57:31 -0700 (PDT)
From: Colin McAllister <colinmca242@gmail.com>
To: u-boot@lists.denx.de
Cc: Colin McAllister <colin.mcallister@garmin.com>, JPEWhacker@gmail.com,
 sjg@chromium.org, Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Colin McAllister <colinmca242@gmail.com>
Subject: [PATCH v4 1/2] android_ab: Add missing semicolon
Date: Tue, 12 Mar 2024 07:57:28 -0500
Message-Id: <20240312125729.82695-2-colinmca242@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312125729.82695-1-colinmca242@gmail.com>
References: <20240312125729.82695-1-colinmca242@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Mar 2024 16:00:41 +0100
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

From: Colin McAllister <colin.mcallister@garmin.com>

Found a missing semicolon in code protected by a #if that will never
evaluate to true due to a separate issue. Fixing this issue before
addressing the #if.

Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Colin McAllister <colinmca242@gmail.com>
---
v2: No changes
v3: Added "Fixes:" tag
v4: No changes

 boot/android_ab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index c9df6d2b4b..9a3d15ec60 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
 #if ANDROID_AB_BACKUP_OFFSET
 		crc32_le = ab_control_compute_crc(backup_abc);
 		if (backup_abc->crc32_le != crc32_le) {
-			log_err("ANDROID: Invalid backup CRC-32 ")
+			log_err("ANDROID: Invalid backup CRC-32 ");
 			log_err("expected %.8x, found %.8x),",
 				crc32_le, backup_abc->crc32_le);
 #endif
-- 
2.34.1

