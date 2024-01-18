Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34FBC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F206C87B72;
	Thu, 18 Jan 2024 18:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rTfveeGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E3F87AEC; Thu, 18 Jan 2024 18:54:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7204878D3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC38E3F270
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705600493;
 bh=4sEU2yza6dz0mDk6MECdxlaw7rAtkgXM5t+XSX7678s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=rTfveeGEIJO2YQrvVHhd+W+b1XhKVg4mN6WfRJwF5+pkE3pRSBqqPF9Y1PZ995szC
 SvU+O4mjsQoZbc0JZEfV/HcctZ+aKNS4Kq8igq9IyX6uG9rb7xAxNXbAJ0wXiduoAb
 JxWzWbgqd/2dnQbirvVQJAPjkOYAutjOnFCW6dbIHZqnzeYE8emDDgi+Oy4AMUeRaH
 blwMS8AtULjblAnEUxmycD62I/XPGSDr/y3MmJhWbWcWkRTMC/p5ab8PdxZWPP+aba
 0W6Oyx8cQce4fWeucW4ct3DJ0AFBqRVvdUjL2y78Ac6RiziA9MWAhqfBCATR4LX3sJ
 ynxHWrg0KqGhg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e89a9a76fso12290025e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705600493; x=1706205293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4sEU2yza6dz0mDk6MECdxlaw7rAtkgXM5t+XSX7678s=;
 b=RGR8Y/VWMZ26ddXS39wx7VzMadmTqjfNhs8HXozvYrlkGt4Xem3X0FKmDFOGTT0OCZ
 Z9DncpBdwhAJt2cYzjMqfloA1wLetgnbhL0u3ivzacG5IaLjIq+tG05QbDli86JxFZUG
 /kJ+9hyve0p9SwcC0Q5GnVfMuhFhOmbDYCkeZXHwujieRS1huG1rKAwEpKRNMCc5Xz5T
 UMvK02zonmu/WTZ2h77/Gl9pmXyA+m0FwWRaNHQHwuXccT9YIqa5xmhfo7CZIWTjAomD
 9TIu3pAj4eHMkltoNV65e8TBxBH3fby63RK205gWKc80YnmdmFRKX+watyvVAJHh4vZ8
 cO5w==
X-Gm-Message-State: AOJu0YzB9xBqeBUpqcoK7BQziV33aOf4v/bl33m9sZMO+xjOZv2dyN/p
 vXbeTIC2WTy36lh8FjJVojGvYUExWNhSssRnngNJjesOGEIwO36UAFHAPtQxHbVLg0rYg1YokDR
 0ZGq2L90zRfwH3EaIJNGtyor/U0OfVfsC+u5AcGRyGDvNkdYAN8uFzsESVdisfB5yEV2qYskmQL
 I=
X-Received: by 2002:a7b:c41a:0:b0:40e:6dfb:7b47 with SMTP id
 k26-20020a7bc41a000000b0040e6dfb7b47mr848568wmi.11.1705600493482; 
 Thu, 18 Jan 2024 09:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl+altYmpCpsmGn07y9tlmb+lOGPj0/wFY/eEeiwT3oThpID/g00PkT81X6WC+KjB/UE3GSQ==
X-Received: by 2002:a7b:c41a:0:b0:40e:6dfb:7b47 with SMTP id
 k26-20020a7bc41a000000b0040e6dfb7b47mr848559wmi.11.1705600493110; 
 Thu, 18 Jan 2024 09:54:53 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm7772165wmb.38.2024.01.18.09.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 09:54:52 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: add comment in utf8_to_utf32_stream()
Date: Thu, 18 Jan 2024 18:54:50 +0100
Message-ID: <20240118175450.49556-1-heinrich.schuchardt@canonical.com>
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

The logic of utf8_to_utf32_stream() is not easy to understand.
Add a comment.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/charset.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/charset.c b/lib/charset.c
index 89057ef7ce..2b43175b1d 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -570,6 +570,10 @@ int utf8_to_utf32_stream(u8 c, char *buffer)
 		}
 		if (pos == end)
 			return 0;
+		/*
+		 * Appending the byte lead to an invalid UTF-8 byte sequence.
+		 * Consider it as the start of a new code sequence.
+		 */
 		*buffer = 0;
 	}
 }
-- 
2.43.0

