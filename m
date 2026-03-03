Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02D4EC1442
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9C183F7D;
	Tue,  3 Mar 2026 14:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mYedeKZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E08B838BB; Tue,  3 Mar 2026 14:29:29 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7336D83F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso47898485e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772544567; x=1773149367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5x90M0eAqRbvCZdtCHasQfwFG0fTr9Wd/65UsE9oLXs=;
 b=mYedeKZAzWSf39dArP0LQ03Vw0ooM/9kXTMpK0T9XPvjYc3AWGrgQjsREb883l21S7
 TwOIsqbuAVSgN7Z0torbwEzxpMML76ArzH2rSHW79JksHOWVfTTnsC0fIuZu5HFI9cH4
 OqxBBbNLXZAhqhlI/RuVrgYx/CkY4bFZRlJdoOnuw33QCIzTXwnQAWt1alTXCc3uUzm3
 YAvvrINn7v5M7oRDiVkMhGFcHKswm0KOfUE0/bHFSNEeVIXxStakv379eebdnksU1dTb
 HOrFjO0t6D7g/WOvd+oWTYBYYSeOn8a1Xo6xmHSe1/22+E8L9jLamASmDHa1bK6GPB6n
 Vx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772544567; x=1773149367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5x90M0eAqRbvCZdtCHasQfwFG0fTr9Wd/65UsE9oLXs=;
 b=l43nNmu/gQdMCdNdYksTDzaRF4CBnZ4EhoM5ImBJChdvaTCnQZ0TzNzxs9yqhCn9Yh
 P0z4qS8hj1u+cg1SJdR5kNQEDH71ks9VZZxXmPbqj2EUBvaMlDq6mcp350uHbDdspATB
 GOZzUljwydA6vQvmWd+snLht8qKa5qJ+3vyYgogVaiFG/wJ7Go2lPqcf5CgFTtausptU
 HLb7Qj8omT0LYnw6SJKDfX/WV4NMFE5yyS1ff/c1l7upQwWIUKfGsVBQUk20uMI26l7P
 cad1r2GyiVLItUQR2HuYf0L3VTo7L/cVD3Z5KTSvl9IYEVFXbtW80P13RL3XmlreZoHN
 SiQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh+ixOYZGMh6xWP/ebffI2Y/Rj0eFv/Vq+xkpj669JBAyQgfvN8DpIrbYGAozBCqqZgmKnYcA=@lists.denx.de
X-Gm-Message-State: AOJu0YxHmDkIfK82lcA7D5DIABxvVzCWsMjUMGAXRhmhJeFDU6qYhHqj
 CqJdtuUxBBg6c2Bxj0EVYS37qZwmgXTnxEJ8SLd7ZR2IBn4NnxP3JeI/
X-Gm-Gg: ATEYQzwlsZbwFbN6jHDritpVucIZVtch5YCU55U0PjbvVB0eNRPNNOef9LQIpiIlErT
 +5b5lzFTQNMucdy9XzcSdbzCvQXkJbEnpThdof4W6qNyq+qdAPavxea+BFxYyKhKXTOWq4ZAsqd
 9uvu6jB00EnqHtcR+T/OEAQhEEdrRSMG8r4gp6azboRhujqy+RoWqqU3SueIFYfi3slRnjQn14J
 6g5qGSdD6gU0wSBiAKM4oyMYyzj6zPeBWXKRfAXf/K0zmA2qm1qxhxHCqZXm2Y+Fhvr4Si+T6UG
 SAW2W0RCOfN7AeF6kJbkPFbFaxwmrOIowx/GgZslpTVy/YOrhYvRy6P2jZVUi3mj6t2qRMczqrN
 gecnAEqzkfk7QOQt8pbhlhbPnUEpOprtpxaTn3nxmuF4BdvFDMb6z4RBXt8+9IMiqPTzPQl2Utv
 88GeiHaIHiIPLnJCL8n6oP0S3EX4tAQqLuUjMtD89Dgwc1AtliNk5TylY=
X-Received: by 2002:a05:600c:1c15:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-483c9c0b6ddmr312735845e9.31.1772544566675; 
 Tue, 03 Mar 2026 05:29:26 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm772625095e9.0.2026.03.03.05.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:29:26 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/5] misc: fs_loader: fix ubifs not unmounted on dev_get_priv
 error
Date: Tue,  3 Mar 2026 14:29:08 +0100
Message-ID: <20260303132916.5502-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303132916.5502-1-ansuelsmth@gmail.com>
References: <20260303132916.5502-1-ansuelsmth@gmail.com>
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

When dev_get_priv errors out, the ubifs is not unbounted (if used)

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 2928cf75f89e..7e432a7ebd62 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -178,8 +178,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.51.0

