Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FDC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350488804F;
	Wed, 20 Mar 2024 14:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MPuhv4Sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CCC8806A; Wed, 20 Mar 2024 14:24:10 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DEA8573F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 759C23F0F8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1710941042;
 bh=wAgqihpp8dxufRGlc752GIcsG067JePgeRNSwLugKn4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MPuhv4SgyqAx5kz0oVQFJoEH1WEYSEl67fFrSHSTrbiLwQ+BYxMQPAVB0Pzwyu/UY
 lmetH/6LNlgzwwKhCn6zI1PvrAaoBamYqbbZScn4Fxo3x9t4SUIDE1FCCwONW8fOc9
 ge52yAbwk5kuiDEOC1lfiu72FRQia7d5BD8WyJjKcFCH/bQoA0Pwx2ge398RiY4rSG
 70iXx2EwMITdwHlrUIi6W6bDPX0JJx0n0ZDv/vDMl3lXKYgnIVpF7L16TBD+AJxJLN
 e/eAdmcOW4rFSo/pLx8YJmqp5APlbUv/ZQ5pAN+sV/8ROd3306GCn0HFBJNHzRevVN
 6OVkdmk7juLcA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33eca7270ccso406260f8f.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941041; x=1711545841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAgqihpp8dxufRGlc752GIcsG067JePgeRNSwLugKn4=;
 b=Po/gJi7oXaGUxptqHwBtDwqTZ4g8Cbqa4GgWqTUrw+MNh4I5DVgwokiPREvoA8Zzk3
 G6ILYk7DDLqR9Yy8sk3ayvffVQV06+OpFia1AY48pWaa73i6EYMWyW95Uhh3+dNw7AjY
 rbCjFbpenmbCnQo1wtqCnXLk+SexUfv/Qrdis1cJI2dUNX+249m0CrbvTF5uccsFwRhV
 G8q9gkuit+9mkqyElLUJ+J5+jx1PWz6+83l0X9r2hzx7q2FKyvefcZ+mS4bOmvYI/no+
 MU2E3kP1Sj0LGWHIL+gXa3fhOQEGTEOqQWZ7PwgDUGAVAxfz7FeQtGo3KzzfUPVurrFu
 t2rw==
X-Gm-Message-State: AOJu0YwFXUZuaSW44S9DN2Lz6G5LFW8OwiQ1DqCNQZ2fz6gI1j1fHEfF
 wXPvHi21I/ojmezW1WYkPJS6cflmLehlTcsRvZSnf3XOw7tjfWZPxGgI6BspBDHH8C7vNBmWsFR
 X1Ukq2X9DKoLMvXOym4WZOnnS29vOePzi8KS0Hbst8nKo740SAiKEZAKpFpM9ZnavzGJLHg76n/
 aV+w==
X-Received: by 2002:a5d:4481:0:b0:33e:7991:6105 with SMTP id
 j1-20020a5d4481000000b0033e79916105mr2000725wrq.16.1710941041618; 
 Wed, 20 Mar 2024 06:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5wEsFSU2heuge+04Ixfg4bN+g6zROK651kBZE6j4CqDZLT+VqlcdwkGUwsMu22Yx1lKa+cQ==
X-Received: by 2002:a5d:4481:0:b0:33e:7991:6105 with SMTP id
 j1-20020a5d4481000000b0033e79916105mr2000708wrq.16.1710941041280; 
 Wed, 20 Mar 2024 06:24:01 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d59c2000000b0033e7503ce7esm8872754wry.46.2024.03.20.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 06:24:00 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: ext4: make "File System is consistent\n" a debug
 message
Date: Wed, 20 Mar 2024 14:23:52 +0100
Message-ID: <20240320132352.46102-1-heinrich.schuchardt@canonical.com>
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

When accessing an ext2 system the message "File System is consistent\n" is
shown after each write. This is superfluous noise. Only write a debug
message.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4_journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index 1a340b4764c..e80f797c8dc 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -430,7 +430,7 @@ int ext4fs_check_journal_state(int recovery_flag)
 			printf("Recovery required\n");
 	} else {
 		if (recovery_flag == RECOVER)
-			printf("File System is consistent\n");
+			log_debug("File System is consistent\n");
 		goto end;
 	}
 
-- 
2.43.0

