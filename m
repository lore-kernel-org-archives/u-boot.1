Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94942C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301758783F;
	Thu, 21 Dec 2023 01:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a6ECUFLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B3387852; Thu, 21 Dec 2023 01:00:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2A78783F
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E5E13F45F
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 00:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703116820;
 bh=rXRTrfdVek5cW43L+IK4kqDIa9r4yFNGiHVxzGQttd4=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=a6ECUFLQF11pAmouJSGiozfbmkrpDylrcnpNVSzKhjw7z9VHh024JQGsNp41nfs8D
 gC2ccX7RoDt86aJyY4z/01e7GYgMDhiETUoTsgpPtTweL1fgvhLZrGxziWNXhC64lr
 wPjlq86u4n5CC6g0fstpdiWP3wCFJ1oW5xjeIaROed9gJz3r88GdNHkxPnyQxX0O5c
 mD41FHC3UvzhpYlDt1R8FVMtD6nWh5jGBYzAwy/6w2ux7hgzTUDOw/F4clnqoNMT91
 iDK5vSmKAHAKgaplBUiACWHZZ/AXKBExfMu9dgJHjFbgChPDTNXn7E8X0mETSTLLLe
 wqqXuFXPCPoZQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-336688e89dbso606010f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703116819; x=1703721619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXRTrfdVek5cW43L+IK4kqDIa9r4yFNGiHVxzGQttd4=;
 b=UbZfsH5RpAt7KFOp8yRZ4a1NazGTUfknAMti9piezMAn2d4lzy7sYNHHV0FpOL0zIN
 BZPDLExLU5A3Bnd6tLqm3Gr8b4Kh36rvoeKR9HtN6nl3PRXwEQbCkzo8B+e1nYqd4dVZ
 glMXg5ZCekzf5KAREdnUgo8vpOH/1iHeSQKuSqPHaDGZMz/IsfizGTN23rMjYTuvDsTB
 P6QpIHPDjIIjsvLU4ntOKpgDeqKec/jceZD2hiSIZPtX9s1qWDnHobCagBkfPgejybO7
 tRiFHZrysF9Ew4ed9vuVN+Csmj6oxt+FhbJrc87HmT9WIZq0kzAYA16ypI7y4gSh5mEB
 iMPA==
X-Gm-Message-State: AOJu0Yz8N1pW604M8+d3bthfom502gt/q8v9zl3H+5AJ/uab827k21Ee
 DKX8NCDu9GC83+NhRpjTw2MScT+jlZ/dqsMpL55Dw3Ex/z4rfbP8AqpUHUTUDFGdr4ZXr33huq8
 HNnS7YKBUqbBSP2NZr/md8D9UrDYh+OA=
X-Received: by 2002:a05:600c:4f03:b0:40c:3dd7:98e0 with SMTP id
 l3-20020a05600c4f0300b0040c3dd798e0mr189927wmq.33.1703116818908; 
 Wed, 20 Dec 2023 16:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhneL3elCaCVFKPkXM8uXMzZRivJPqr52j9goqTO95H8yXA9o/GcoaVyz8aMGDv1Wi8lUEKg==
X-Received: by 2002:a05:600c:4f03:b0:40c:3dd7:98e0 with SMTP id
 l3-20020a05600c4f0300b0040c3dd798e0mr189919wmq.33.1703116818477; 
 Wed, 20 Dec 2023 16:00:18 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a05600c3b1400b0040b4c59f133sm1162514wms.1.2023.12.20.16.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:00:17 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: fdt: check fdt address
Date: Thu, 21 Dec 2023 01:00:11 +0100
Message-Id: <20231221000011.297145-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Trying to read a device-tree from an illegal address leads to a crash.

Check that the parameter passed to 'fdt addr' is within the RAM area and
non-zero.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/fdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cmd/fdt.c b/cmd/fdt.c
index 331564c13b..dc954ea7d5 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -193,6 +193,11 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		addr = hextoul(argv[0], NULL);
+		if (!addr || addr < gd->ram_base || addr >= gd->ram_top) {
+			printf("Invalid address\n");
+			return CMD_RET_FAILURE;
+		}
+
 		blob = map_sysmem(addr, 0);
 		if ((quiet && fdt_check_header(blob)) ||
 		    (!quiet && !fdt_valid(&blob)))
-- 
2.40.1

