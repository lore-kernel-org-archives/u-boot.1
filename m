Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8440CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 22:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD4A8818B;
	Thu, 28 Mar 2024 23:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bM/kD5hL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D6087D43; Thu, 28 Mar 2024 23:29:55 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36AE88203
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 23:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-22222357d76so916218fac.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711664992; x=1712269792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PCZV+dlltxUhxTKZqkPE6ZqobohUd9JSGdhq94MjY+c=;
 b=bM/kD5hLefDTsePFxBpXRJzHx14j9rc7RURUYNcPKUL98/DrHo8sfLQ4XU0KtKnqXT
 t67TOsqZAfZ+sV1GAg+IVPcGiCFS32GNzZWCee7ouvERywttlGzboaytGel0xtE/SCy+
 A7C50T0ExaQ5mLB2RnlGTozD+rHfB2Taf9Zw8VeouOxsi1AkhPeqmljgIFE466lTwcpP
 H34PXvPiFKybfbAoG8it5kNcB/d83iics1jYI7JINd2aCYJHCBPEl0P2FrnxWCA/qu64
 v0h/bdUew3x82ew/gNrMN250tV/gluT7m2jtBpBov/dxLkX4PUjxxU/Q7877vKpg6ydp
 nYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711664992; x=1712269792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCZV+dlltxUhxTKZqkPE6ZqobohUd9JSGdhq94MjY+c=;
 b=a5rFMGfJlkTzGegmwJStcpc0i0S7C9JurEOpFQsrC7w4QgkuvNxE88FeVQ/QI+JFm1
 9lvUqzGkPLV/CTRCgGEToRjDW782TjP3rUbs538+UTulP/OvA1XHP0ScDCaw+KwzYLrJ
 vCXhmQwo3j26AV/6kZu6Ty5Hn6/B4uHjLO/SZH9oyt3Wl+ZUpCy7OWq7fP4DJbQmifod
 kxAojBAH2HWsFWIEGgjVLnGJ7OaDcLs5pum+agVacQQcTH0xGa5ZPFGzKf/wo3sOu8pW
 fCwS3fhNxx7lgtLlyEzI+A5x1dYlbn5qU3NIp+i44B5VT4uTkYiKcTPiFzwNDg+CMLMr
 0MYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBZnyt00Fi17+GD/LWdJaGNTpkv7kdkP8HFVyGx7O0ikeDl38ZvokuAVEezQGAk6hLgc8b0MeC2Ups/qiwG9scn94MjQ==
X-Gm-Message-State: AOJu0YyLoRnMcJiYIAjsn2yBu3abAW9GkqXqAh+hLS5dfajg67k9FMC7
 nWp5ZhoyJxqeKhfugN+NDUOLMEKsFtQR7HcT++QB8nIyOVFVi/ZRf6CpGrx2j/Q=
X-Google-Smtp-Source: AGHT+IENcwebxbZP8sjNjeOeEXIi9zG+povHcLW6CkRfhUxsJ2xp/HoImECo1tJFhNck51AmYq4Urw==
X-Received: by 2002:a05:6871:741a:b0:229:cec1:cbb8 with SMTP id
 nw26-20020a056871741a00b00229cec1cbb8mr630383oac.3.1711664992459; 
 Thu, 28 Mar 2024 15:29:52 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 hz14-20020a05687153ce00b00222623eea36sm602541oac.40.2024.03.28.15.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 15:29:52 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, Steve Rae <steve.rae@raedomain.com>,
 Petr Kulhavy <brain@jikos.cz>,
 Richard Retanubun <RichardRetanubun@RugggedCom.com>, u-boot@lists.denx.de
Subject: [PATCH 1/2] part: Check all partitions in part_get_info_by_name()
Date: Thu, 28 Mar 2024 17:29:50 -0500
Message-Id: <20240328222951.11431-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

In part_get_info_by_name() the inability to get some partition info
shouldn't be a reason for dropping out of the loop. That might happen
e.g. if the partition is hidden or unused. An example of such case are
Samsung devices, where they use the "unused" GUID type
(00000000-0000-0000-0000-000000000000) to indicate that the partition
should be hidden from the OS. Such partitions might not be seen in
"part list" output, which creates "gaps" in numbering in between of the
visible partitions:

    Part    Start LBA       End LBA         Name
      1     0x00000400      0x0000a3ff      "efs"
      5     0x00026420      0x00026c1f      "dtbo"
     12     0x0003f390      0x0074738f      "super"

In that case, the loop in part_get_info_by_name() would break after
partition #1, so any attempt to obtain "dtbo" or "super" partition will
fail. Fix that by continuing to iterate over the remaining partitions to
make sure none of the visible ones is missed. That makes "part" command
(e.g. "part start", "part size") able to work with such tables.

Fixes: 87b8530fe244 ("disk: part: implement generic function part_get_info_by_name()")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 disk/part.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 36b88205eca7..08c9331e059c 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -717,8 +717,11 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	for (i = 1; i < part_drv->max_entries; i++) {
 		ret = part_drv->get_info(desc, i, info);
 		if (ret != 0) {
-			/* no more entries in table */
-			break;
+			/*
+			 * Partition with this index can't be obtained, but
+			 * further partitions might be, so keep checking.
+			 */
+			continue;
 		}
 		if (strcmp(name, (const char *)info->name) == 0) {
 			/* matched */
-- 
2.39.2

