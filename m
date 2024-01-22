Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7B6C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E62F87C05;
	Mon, 22 Jan 2024 14:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uVojMJTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC75987C0B; Mon, 22 Jan 2024 14:04:47 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED6158796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D36ED3FD9F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705928684;
 bh=OC6xGE7nxMgpdQeTrI3oBLj6e/KW7pOkFB6RWwqM7Nw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=uVojMJTIAnzeCoEX/bjl04eSqnJa7Nc7DQ2fzW4Qd3091W5DESao0TZmyMnLAb3S3
 Bi+L5bVjTN6Jlsr3e6ARWzjfeIyVId5e/QdPawF94YMNN8tVrRj1bsOIjKognW8cuX
 YIAjd98gDDCWS/9bM5p1kunAf2Ind0LTwMwy4BCzDFMYMTNFA8/0gwqcjLYXFQ3mtp
 u6FS+V1ftglqGCADFczUYgUJhUs2s8/X8muJgcTzvK6Tx8VEFVk0BIpLkjSefQ7FC5
 EasbcHffDQQ7TXzzOOMAFjocAFzKq1RlD1EUidZiKXBBbqAVPzIhx1jAuOkDffKB8M
 FYlP7tMrEsaNg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e49906305so11070285e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928684; x=1706533484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OC6xGE7nxMgpdQeTrI3oBLj6e/KW7pOkFB6RWwqM7Nw=;
 b=QlbJHpshzXfhwue0s+yz3p5gJr9yfBBWTIenK3/gYm1fbA/m0SXXU1jtSqTviy3pB1
 kvjVClWABDY9xyVLnjzWzEhOZ4IykgxR4oDKFwpLsYTrPVVylf1RLgJZoNirAu565WXF
 A2H4OgsMh8BGPYADpVxF4RuGCZV3UXVSNHFw5X25uTQBofsNkptLUBfnux8DdhWRPGZv
 7wfG/iQKp45z6XtZnJ7Zg3fYX+CgcmMwBYk7oPd8bQ8xgKTzdb4/ldPw9H2j0taeaovb
 4PN9nfHhj29TOzKyFtcgcXlcjPrcS0WWf6Wqcnsx3JmECB7MSwvfGxJpTdPnb1PwuoPS
 3vlg==
X-Gm-Message-State: AOJu0YyKRC8NPiONCy3jRaIDUEcpqUi1h5kiNjzZ6GTH/kGdhKv07M8B
 mKHmPxEa33q2x+n8rMf4aRHWDicB2YhHckNdKDTt4Zi0GUMDRyK/iXn7J/j1x4y1IYtVj/gWhT0
 PK95NGl9GRBxki/uKSewlwzO20Em4/DrcSlD7/5NW+hMVMjJetpRQHurhkbvhvRnSc78=
X-Received: by 2002:a05:600c:5d1:b0:40e:4aed:ad27 with SMTP id
 p17-20020a05600c05d100b0040e4aedad27mr2119773wmd.144.1705928684499; 
 Mon, 22 Jan 2024 05:04:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+OGWBDSQi9/O/avEcb/YehokV2J40GJUkJg33c803KXVH03AtbZEYgYY/6Xl51qgXiZ8Rkg==
X-Received: by 2002:a05:600c:5d1:b0:40e:4aed:ad27 with SMTP id
 p17-20020a05600c05d100b0040e4aedad27mr2119765wmd.144.1705928684127; 
 Mon, 22 Jan 2024 05:04:44 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b0040e47dc2e8fsm38953969wmq.6.2024.01.22.05.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:04:43 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: support SMBIOS3 table in uuid_guid_get_str()
Date: Mon, 22 Jan 2024 14:04:35 +0100
Message-ID: <20240122130435.73871-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

As we support installing SMBIOS3 tables in U-Boot we need to add this GUID
to the translation table used buy uuid_guid_get_str().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/uuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 0be22bc05f7..2d7d99535e7 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -176,6 +176,10 @@ static const struct {
 		"SMBIOS table",
 		SMBIOS_TABLE_GUID,
 	},
+	{
+		"SMBIOS3 table",
+		SMBIOS3_TABLE_GUID,
+	},
 	{
 		"Runtime properties",
 		EFI_RT_PROPERTIES_TABLE_GUID,
-- 
2.43.0

