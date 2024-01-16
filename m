Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E5AC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 14:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20445876E5;
	Tue, 16 Jan 2024 15:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V34X/SJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FE0876E5; Tue, 16 Jan 2024 15:00:39 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2EB86FB0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 15:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD1D63F120
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705413636;
 bh=Q53GQob56Xnm2jFD31DMBDgPlNHSIKfvHeDwV4bto2U=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=V34X/SJttDmNT3XAk0ykXo0pjWwEYYBQ/bQpGD8JE5oxARYDa9A8MFLqWEPFYTz0S
 WZ5iXCBpAitCES2HFKjl7uxjNdH8M9fW8MY3Xp9Rrrz4hvo+uEFpaQ1HW6uiBuU/GZ
 a96QX0VTK+Cz6JHHm6bFSH5EMIFzbhv+G4iJ2npW5zoM3ZnqP8lyEwmf0PM+a8VrzV
 AKtEBsK4lJ3wNRdGnXxMu2ugTzZQWMIYwJxIHnmoRp5mh+xdq0yyQuTuxRQluG2rdF
 cCVd7LJt55LJD7m5syFiJRTy9PcOtUvlZjdZEOUF/fzKZr2HCp9uuahdRoP3dBK6dT
 JYWjRYJIk3EPg==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2e1630853eso68635166b.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 06:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705413636; x=1706018436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q53GQob56Xnm2jFD31DMBDgPlNHSIKfvHeDwV4bto2U=;
 b=rlC4OxFggjcjgybkLX8i6MTlbTopcdmoRcQugxopQi9xfGMaqblk50DhCdTE6CIOWt
 TtqUQtqSi4NFaUb51XQulhOjt+LkP0ffHOtNJFJvnm8Fb4pAEu8u34SL3NUTB33c8sYx
 YJ1NeC3i+3CWsjcnx1i68R4euJv1R5OBm1DwDKls2QlegHq2PX3WFeru9FWn8Mi/66sC
 SxnrkmgFMpw9rYPT2O3hka2gm2ivv78jLQDyifbmsWWrKmojwUigTMSNTb+Xza2ieheu
 Ow5RbR5PbdGCFh4EHFAN4wXhen9zvTtrDhnceFV2V5kjOhY+u2LmD6V+2X4I4wbzCDsk
 +/jg==
X-Gm-Message-State: AOJu0Ywhl3j7FaH2m9ODoH7qmEVmUpwc8HSq6LJ95o7d3zk4s4S1Eg3Y
 ncSVQfJGXIMHjVY0UjU4ET3FtxEqVxpEmqRBVjCRf+sqsCxcwrhYnX+9NVW40lV2kOmapulnXp8
 vjZBsq8J1TKsw7Y4bwZ1QZhteRBpUinIoBvhRg7NJ4iwWcw==
X-Received: by 2002:a17:907:a0d1:b0:a2c:f8e3:1fce with SMTP id
 hw17-20020a170907a0d100b00a2cf8e31fcemr3613277ejc.153.1705413636518; 
 Tue, 16 Jan 2024 06:00:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo0Sco4D4PssDn3AvNoSbp3AyPwx4nhZSRwENYG8IfkhNT/PLQ8fdJFLoYESQfYuyfM1G0sg==
X-Received: by 2002:a17:907:a0d1:b0:a2c:f8e3:1fce with SMTP id
 hw17-20020a170907a0d100b00a2cf8e31fcemr3613263ejc.153.1705413636226; 
 Tue, 16 Jan 2024 06:00:36 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 tk10-20020a170907c28a00b00a2d60194466sm3727645ejc.52.2024.01.16.06.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 06:00:35 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] part: correct documentation of part_get_bootable()
Date: Tue, 16 Jan 2024 15:00:20 +0100
Message-ID: <20240116140020.58464-1-heinrich.schuchardt@canonical.com>
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

We have to use 'Return:' to render the description of the return value in
the HTML documentation.

Fixes: f55aa4454ac3 ("part: Add a fallback for part_get_bootable()")
Fixes: dcffa4428d03 ("part: Add a function to find the first bootable partition")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/part.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/part.h b/include/part.h
index db34bc6bb7d..32ee4048856 100644
--- a/include/part.h
+++ b/include/part.h
@@ -685,8 +685,8 @@ int part_get_type_by_name(const char *name);
 /**
  * part_get_bootable() - Find the first bootable partition
  *
- * @desc: Block-device descriptor
- * @return first bootable partition, or 0 if there is none
+ * @desc:	Block-device descriptor
+ * Return:	first bootable partition, or 0 if there is none
  */
 int part_get_bootable(struct blk_desc *desc);
 
-- 
2.43.0

