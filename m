Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E94D58D5C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 15:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B8188B64;
	Mon, 25 Nov 2024 16:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AfFoev9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D166F88BFB; Mon, 25 Nov 2024 16:09:02 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72B088B4B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 16:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D774A402F0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732547339;
 bh=9p93dCQ+sOVlSW9JHze5GqOLsqzNNRsgHtN+jPTxw24=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AfFoev9MPZ6l+uUcEbMqw5qy2L+XDheGr6Y4peWek+fFSJ72TzERg1p2KhrjRExij
 vr/B65brNdlT4vtClRz4oHj3kTqoYa7+gDAaJhuB09hPTFpaNcIjOmrQdkyLgubJ3y
 AfQq/keagOvi6+E6PragLtNNHZHD/vv4CvookiJP9cWl8G5S0+MrFHOAb+FsYFxUtC
 r7PDLsIUGC+x8bJfBTAT9HGcDKnq+TyIRAQ6IaYi5DV3/Mw/Ny96aEEtkveRqRXDub
 v+jYl5XPg5Q2MEK8SIsN8rumV/GUMZ0TSBSy/YAZYE2EGB2lidNIR7zgI/t6nC/eFV
 kM5aqnE8QOhFw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a467e970so498835e9.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 07:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732547339; x=1733152139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9p93dCQ+sOVlSW9JHze5GqOLsqzNNRsgHtN+jPTxw24=;
 b=cha8P/ODh+ydg+CfiSkHU4mXPzs2zcSXQR+5k4FyagNsvC+GVvbi9TqpJ6pPyjvDky
 qdunIH49UFMupcLGV3tczFISgElUJgL7iU0ng4o/ZhKtT4QO41QQZoLcfzc0F/oR0aYd
 zmmcQNeJk3PCTqP5QnK8EYh4tADPZSoZJ7rpiwT5QxZT6tyfN/xewkXcCXgZLo/LrhIh
 rMwaNvQ2bVlclSZ2gxf8eDtj6QWNKIBEPzCCqsciILakOKQ4EtkHzYt8YohEvq25yq+o
 1TQrW/xyRnXtT++MFKQcLI5/fnCAnw8L/2fOcyFN7fraqKC0kxxj5YCNlZoMdTMVyDlo
 5H9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNYeb65jH8cBeLtf9Ve5EcE88C3s7yLXmG73kUCQA3aA54JY7iAp7/bBxGWgmM4wc+dlak9nU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9wsBzspxiKQCP/65au7yI4Tbd6T+qr0XCYCT6meCkXHlicW/U
 IZLQHqRxKzXUwzC1OkIPY/X/rK379Q1/Uyx5JwoVSgoOT6z1WKWEEJ/1u8UctAxiPEm00WPrHJ3
 QZPfM99L4g2ZgEkp/4y7E6lAckIa0wXDBnZgtTV5THWaAZOe+4bRA+2nBlqLKCpwa+X4=
X-Gm-Gg: ASbGnctZ8aAVekejpFXssBMJLJCTfWInfPsSvDhmNWa2+21qX9tpEq6Bts+/yyJj4Dz
 7nE83bRA01Udhq/zkvUaosFueI9oX3ITBE2gdN2zHdUvNehhPli+YgPyZpYQviEzD65DgBlovVp
 3IuyVD7mL1/qnMQozPqQZLSVuUsE3JxKWvm4k5oFPiZkauysgzY2UhyWUI0/F5M3Fq1z4Hrrf/S
 8WB5KrkXyS4VPbvzQunZ3fVzIaaD80ZmmgCIoj1ThMU4g6vMG7K3UI0bAD7Y0OrQml/L8Gc8X6j
 iT29+uv3txCAllfWElAnU4XtlGgLpv8liYAJ9YkBztxWbBr70eso
X-Received: by 2002:a05:600c:3d8d:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-433ce4e9e39mr104346025e9.32.1732547337392; 
 Mon, 25 Nov 2024 07:08:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgjw5ebVDFgAHmq9MqzZsG3c+9hGBhL+6cXPSl0h6YkeV/8JlJkg5B0wAPd0JgEUvuh/g+Eg==
X-Received: by 2002:a05:600c:3d8d:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-433ce4e9e39mr104337075e9.32.1732547321868; 
 Mon, 25 Nov 2024 07:08:41 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc44f7sm10891924f8f.82.2024.11.25.07.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:08:41 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: remove duplicate definition of ip_to_string()
Date: Mon, 25 Nov 2024 16:08:34 +0100
Message-ID: <20241125150834.90448-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

ip_to_string() was added to net-common.h but not removed from net-legacy.h
in commit 9063dba2d326 ("net: net_utils: Move ip_to_string to
lib/net_utils.c").

Fixes: 9063dba2d326 ("net: net_utils: Move ip_to_string to lib/net_utils.c")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/net-legacy.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net-legacy.h b/include/net-legacy.h
index ca1efd17af7..5a431fc6b16 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -502,9 +502,6 @@ static inline void net_copy_u32(void *to, void *from)
 	memcpy((void *)to, (void *)from, sizeof(u32));
 }
 
-/* Convert an IP address to a string */
-void ip_to_string(struct in_addr x, char *s);
-
 /**
  * string_to_ip() - Convert a string to ip address
  *
-- 
2.45.2

