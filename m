Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7660C7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB91082EB8;
	Sun, 29 Jun 2025 00:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pUpOR7GK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0041182E8C; Sun, 29 Jun 2025 00:44:03 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E7280B9B
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73a9c5ccfcdso599996a34.0
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751150635; x=1751755435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VZGNYaYZeWZvQqZs9lHBfgbjwuXhra2qmEAo64+zuFw=;
 b=pUpOR7GKleyta+wxH8Ephji8SBVmtjznkYKxVJm8lE/xRHvYTMFLsqbTgCnOsmhj0p
 CpaoaDPGK8dHIpnRPM2sp3H9dwqEX0qHI8x5P18Cz+yDfdIsgv34KJ+SkuMUxWi8Ff/I
 gaEaW/N4z6a0IIX3fNNS2iAc3oNHtF3rcesOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150635; x=1751755435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZGNYaYZeWZvQqZs9lHBfgbjwuXhra2qmEAo64+zuFw=;
 b=RJ5CYA4vqKmFEgHM5pYY3ozpkj/0j2J2Gudo3U+/+UeKvA42+hMSP+xZmLlniVvYsl
 WmUrVGntksGFT8rTmuX33FtjANq5XJjYMmmY3qhTOZ0eCB6GAqyE9I7b1o6Na4Fz7bI0
 8VqLO01711iQvifJ6ZFz9xlor8ulxp92uSZcnOdxW+4JPbwUHi4UdflXZsjZ+Y/2Hb/N
 XvHIRSTXDq1u4xsQBE7G8aZwoHAqG6AJ5fMJkN5mflqq8oTlP3NAVB+0YohlvCsEJAY3
 +ZWKk52GK/ETF+JmfgOvXKbx/hX0ZBG/vUUeQPwqc36Log2txDxkVi7iBwHgm31NuiM9
 Pzng==
X-Gm-Message-State: AOJu0YzUaXkIFiF5q3NUncnp1zIXLbhB90wjR7l74wovWBpfkBopm+JA
 Js5sBu+mrRKWR1v9ssBcaYIuidOoAdb8ws3rz6+Z9uioJd9j+0rWCD+hCNEb+tf7AxxEQiTPtcM
 CAvJN184=
X-Gm-Gg: ASbGnct5T4o4PMSY9ylFYhwIMRKledVM37yWSl2y+0TUWUjqFeM2aOngV3qKof/Ip8d
 oZjeQMWtIjmsqLHs8ORt/e/Yz6jhXqm3V+apNdTOYHrtJPe53JhYJtcj8UupeympVY6phblu9lP
 ItkCNczgCEvA88XPYiBFxak9hvFRV82zHjFlrSLt4k1h++9fA8Z25IGUfr6xSGYnWzhtu+svF0D
 /3VUkInSHL9RSMT5JRhJvAl/qZFCs51tl6p0wQVRiSp9GYJukgF0AHp6xP+heNkOfr6qxKzdNyI
 vAU0KOx7ZWdjFQXQPmhvTVgbXp7ADgkRZd4hfbGKuSVoWGs/igEpEZ59FGI0y2II9JLHEdtyVUU
 bhxZEoz1vbOV441iLdzESGW5cEw==
X-Google-Smtp-Source: AGHT+IFF3vWfId3oJlDzM1nCTo0qOOGT7rjfIqzo9Em5xUFf6bRQYxz/bL/i1IoYvWfYgcCPJlUrLQ==
X-Received: by 2002:a05:6808:1918:b0:406:2bb4:99db with SMTP id
 5614622812f47-40b33ef89d7mr5876875b6e.35.1751150635213; 
 Sat, 28 Jun 2025 15:43:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e4besm1013148b6e.50.2025.06.28.15.43.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:43:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/5] include/ndisc.h: Audit include list
Date: Sat, 28 Jun 2025 16:43:48 -0600
Message-ID: <20250628224352.85694-1-trini@konsulko.com>
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

This file should not include itself, drop that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/ndisc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/ndisc.h b/include/ndisc.h
index d0fe3acca4aa..7d9e58aa1c21 100644
--- a/include/ndisc.h
+++ b/include/ndisc.h
@@ -10,8 +10,6 @@
 #ifndef __NDISC_H__
 #define __NDISC_H__
 
-#include <ndisc.h>
-
 /* struct nd_msg - ICMPv6 Neighbour Discovery message format */
 struct nd_msg {
 	struct icmp6hdr	icmph;
-- 
2.43.0

