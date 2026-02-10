Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC75DEA8130
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9069183D7D;
	Tue, 10 Feb 2026 17:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="utnRHzDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF8283D7D; Tue, 10 Feb 2026 17:11:38 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999CF80FA1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so15128225e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770739891; x=1771344691;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yU0IhtiE5SdT3b0e+WiUHkJgsHBG/DzDdu31HrhiRTQ=;
 b=utnRHzDtCODz4B5jOiS/VjB4l6s7DXILdCYvyvuZL72oAT5o94mkx3fiFoQ4vQej/W
 59ZzOz89PPDZjfBfEwlwzaYxgbqfLRt2Plqu5Le7gSQvqdTE65hAs0KaWkygo4lBrb3Y
 wPZy3UBiQa3x1+kJodMaPxFu5V1ZDpaA5MPvhtMxcOEfDKKoN6etH6qtH/6du/ACtPfo
 GoiCf2zvBPJGz1JEApPQEQnlbSrTclq5vtG1tJRxFquLT8xRSJKdl6qq8zjB0MJvopab
 AiT8J6njtV+7W7V2pKvTffs9w49eFdOjvuJvToLzpoRixGryjT6PJ5JebeFu9oVwkzAD
 Yb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739891; x=1771344691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yU0IhtiE5SdT3b0e+WiUHkJgsHBG/DzDdu31HrhiRTQ=;
 b=dDLpfzLKprJJjZyS/8hDIxxQ5DvkW6VyekjJUc1hvb5v+KxluwMS6toR4YIss1UM0S
 Y/XNM2U4uEkqxEMk3U8pvCoPmzuIur72kAW3VZ6GaYrOs9NfELuXtOF95hpSHdq62xEI
 6T13mb93FkprXwIRXtIIZrNfTiCm4HztBYjm00BVqR9QjlwRtMEk8dYHSS+1PJGUQaTb
 pQnOej9xWScqJcZqihaBK0rsHUa75qkj9QsMN7LW01WMOY6INmJkuVoJecYvYlP1b4f+
 tez+lop/he4bmIbI199ayRF9ZPiDcMnPDDdAxB4eE2e13xcB0fSVyg2K/KdJ9bKTHnyS
 FDeA==
X-Gm-Message-State: AOJu0YyRDPBqZneJRgdu/sD+BGjLfEEanng8aTQ/kc//m5desp01Q9Vj
 gFM39/+rETlWa/Uj8FCt2DfEgtr3UPFEWl9LTi32n2iGZWCTmn5Zgwe7xJhmr2G2aY4=
X-Gm-Gg: AZuq6aLTbEaP3+TSP/JwjRwiUaPFS0T5loQQSXdWL+C11ywKaHqviCftDaijZb2PNU2
 S6tQpaDfwQF9718suM4n6PyrluQkYBJx9XEEShZkemdYFSX2wlxcy/Kk52/lHD+wPgF+quVI6eF
 RDtsI4LizV4vjdI+wb/VfhqE6ccDdmg+IkPi+999QkscmlGoeHzSZLLb1rgXt+7z8HRdvjAyJGS
 Oxg0usj+cRFL1L/p6zzOSobGXo0MLX2iLkdx6NFdyskdaeoZkiNpWQC8mqOIOgJinTwgZIBrzUg
 yVs2y9lGqvtcmpfXB5iWloiV7j7KEVcBJhNvrevvDT/1qCwP390fMFqxOSW1UKB8rjfdx9rjf+0
 k5PurD53xCxJ2tTbI92ggaGcqgpgBIqOXWOxdAhUdZzLy/O7twSwUZjY84sF6aWjA3Z3mzo+wuR
 IcYa5lQv7ucmC1QFglelayhuPunW4CSPQAVtgglLZRH3rFHG8sn1eqz/NEjaMBt70CEbT7RzBO9
 fmXnYGh/Mn/jjVGGvtwow==
X-Received: by 2002:a05:600c:8b82:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-4832020f040mr242256545e9.16.1770739891005; 
 Tue, 10 Feb 2026 08:11:31 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm62994595e9.8.2026.02.10.08.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:11:30 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 17:11:19 +0100
Subject: [PATCH 3/3] drivers: ufs: fix typo in struct ufs_dev_cmd
 kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v1-3-bf12e31de4a9@baylibre.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Fix "associated" typo in struct ufs_dev_cmd kernel-doc.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 74125b1ab31..0f6c93fbce7 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -509,7 +509,7 @@ struct ufs_query {
 };
 
 /**
- * struct ufs_dev_cmd - all assosiated fields with device management commands
+ * struct ufs_dev_cmd - all associated fields with device management commands
  * @type: device management command type - Query, NOP OUT
  * @tag_wq: wait queue until free command slot is available
  */

-- 
2.52.0

