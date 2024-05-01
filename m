Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80379C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6EA88BEB;
	Wed,  1 May 2024 04:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PefsK75V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174CC88BD7; Wed,  1 May 2024 04:45:01 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3878A88BD2
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso13799386d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531497; x=1715136297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v3DmG/TLXfqSSG4LwHHm4mixtKFy3QlZ0i26hne44I=;
 b=PefsK75VT8qT+zOKte+ymlqEEKk7S/L3L9aVEH+QLRyePrM/BS8Q/M2BJ5iIiKQ1Qg
 iXc9w0+dZ29CeKYoOokLtDN5QsbTfuYyy1HxmFqLGs4K25Zxv11Ve9ZGsSIiyYsFbRsn
 lxa+UrDvcUITaeINZzoCl1h8zLsq2xBWa/HtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531497; x=1715136297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/v3DmG/TLXfqSSG4LwHHm4mixtKFy3QlZ0i26hne44I=;
 b=KU2NYNpF6koP2DeHkoIs6yu/2FxcTfL/BtCkhxFWMHC+7SYMwXc6K1hQkd28ykC/zV
 2Dxp8MBv1+FvXbt/6p74pNtB0E8h28eh/uTQA8+1DzUC5FiqNbszicx4EihBAFVbY+tX
 kOaB9tJfmCYuIW2dvh2xF9eLe51BdNWEPZVykfUqNMbHAXKUmSh0cjom16j0LxhTfWLu
 0CpXC9fy4tD+g+TMnQK1jGP4A5fKX6+Uo0reuYlzehw31/2x0e04ZdC4TB8QN7LOkU7m
 C6Z0nb5BfsyQsPDKtbe+qpgYyR5gGGLdWHzyEg4AD92SpQXFk8lyThxk5Ut/1DN5QFlp
 scbw==
X-Gm-Message-State: AOJu0YxWjFH8Ke5m9+haLxvif7v39yzZSvhhbTHCcgKEjbvSk+JA111t
 QnwuXvSgWqyTwyoo26Jn9lBdaz6p87jaXmQxOUSvO4jY/83/vsIKiugHkBTZGn/eM2MI3BMyTrj
 CRVZRPQ==
X-Google-Smtp-Source: AGHT+IGaST9WrEOyqTLApH0njE8pvYRozvx90NEa84jyG5ESG6FJ/6TfId56dmHcWXPsI5J2WIpHGQ==
X-Received: by 2002:a05:6214:2a49:b0:6a0:af07:1141 with SMTP id
 jf9-20020a0562142a4900b006a0af071141mr1165140qvb.65.1714531496842; 
 Tue, 30 Apr 2024 19:44:56 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 084/149] board: lg: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:11 -0600
Message-Id: <20240501024316.1767971-84-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Paul Kocialkowski <contact@paulk.fr>
---
 board/lg/sniper/sniper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/lg/sniper/sniper.c b/board/lg/sniper/sniper.c
index 86032d7fcdf7..88d5d0881433 100644
--- a/board/lg/sniper/sniper.c
+++ b/board/lg/sniper/sniper.c
@@ -6,7 +6,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <fastboot.h>
-- 
2.34.1

