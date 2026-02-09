Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41F9E81BB2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 12:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51EF839A5;
	Mon,  9 Feb 2026 13:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZCyqit8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D0083BDD; Mon,  9 Feb 2026 13:56:05 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CD58341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 13:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4833115090dso16861635e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770641762; x=1771246562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TxXuQ6Vq1JF9rFl6j8YRqLzKkO/+GBWsZj9qlwNMay0=;
 b=ZCyqit8wrjq3x1NXa9pUL+yih9PGTGyCvcrC0T1SFBGU1Xl+NzJeV+taDYJfu1YhxL
 veMhsfHwmXXiAJE+6MVHqGhW5bDj+hyHa5qFqKWKO3/rjRICwnpztO/p3wEBGQ63cFdf
 0esdGqqt0PSD9JJ2AAgVUPO1VmYgfEEAoGnbfOqT9k0cQ0oFKYhQWE8e/jr3NEBYZgbt
 nSapq9yOA7okgoPHEAEadKcxbVPDrc/bgZ4YlKs01plZZ1F456E5VwYOWBm0C+oGJsij
 0W7DH7kuHsNQYATjsQJTJXLBihvUjjl/IP59EiRTprv0out9FCGdtpMXljbAf/EvbSDL
 dquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770641762; x=1771246562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxXuQ6Vq1JF9rFl6j8YRqLzKkO/+GBWsZj9qlwNMay0=;
 b=mqC/pHAPJPL5GCA0Yztp7QjKUGJxNXsc+VvgWfxVswFywDKQThEZXw6pv0rsa8IEuW
 iezIDKDUwFzQjCGZaKVe+s9FLbw2XQDGUCuFAG9WvR+MmyXFjK6SKvY9IUHXALZp1RUe
 6iQ3d9LTyU55ylsRZ0MhbyK1FopZ7pes7ethWKQRxjkc7dzsLOplMFyDV+OQIti7Ww74
 Qfq+fY5ZB0kCG9WZsd4brF2pN2xKlyl7KLa7csf4GsI31TBXyQmyHFrZmsz2j3yMTZP2
 eM+anfxYtQLbz1HKMK3QrMWdQpCQIXDmAEdl42pgwBGHtntbF7Wu1LJxwdNCHT1Q/QU1
 05CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv76Xc19WS10sHiNPzf0twpAq/RokcbCOl8lSNiUbsON9oSlKYtP0x9kj5Wcxk2DD4utQ1n5k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5JhXyOtCn2f+Z17cn/4AiRYwaKgDIOnqMvQG22xZhwnK+hati
 z9ewzSRnJagmUwNWK8jofkrHh1uOrZRqthtsHz/rreMzmY9POe3HkCyv
X-Gm-Gg: AZuq6aLu3s9G6p7bvCXjmzINR7T0O+2CcrK5q6IXtBU3UHps2UvQNvLixNRzLzaECpf
 xbot8XUKsAkx0bdzngDOFB3phQIUtUFc0O1lJG6nbdaIBjL5fr27zfMIO0aNPND1SWmSuO63Dhv
 +Cxr0pt28LO5UBw/eJ7v+uNtZV2a2gOOm3UQeOrp2jXxLSwJa/3LqVRUDQtXaN2gTVRmeoIc66M
 ffuaBgvibUmaaXC8UlkNEY0jYWX0KgRsTjLD6wcaSBpBQ5G2+UX+ZopFPQEEKl1V9wYGhlSqzT0
 Q0LrDEN5q8g9Cze3lXxAyx622TYB160JYQNkk7n250fl+brRcijslD51iyv2We6loMVtZ5CnAMZ
 FQRIxkVp1cdoWskYlTDdzVs6CKVCUwUTbDoj9K+U1t99jk8AXp4rK9kt7DTduesSsXMuAI833RY
 lrQuk/od/pOlJ6nksTw7axXp0Mq3u/28GEs4l8ejXYOQzHL1sVCPLXiZy0fPi64U9QR+M0hn5cy
 P4PkqJqGE/5kc/XywGyNMhXkdaUDu5IGFQVD1Eme2yz2rzYaVKig+NFpU/C6qpcfC0RtWIgLCcr
 tVGRFxIN8XHfa5ndnNiqga1NRMNRgnQaqifGzQwmwZdia3nFXc+m7WNrMrLUelF1JPg4LKD5nEp
 N5RbYteuKjA==
X-Received: by 2002:a05:600c:4f0e:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483201dce33mr183498395e9.8.1770641762027; 
 Mon, 09 Feb 2026 04:56:02 -0800 (PST)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48317d299bfsm305905825e9.2.2026.02.09.04.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 04:56:01 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] rpi: pass the Video Core logs DT parameter through
Date: Mon,  9 Feb 2026 12:55:47 +0000
Message-ID: <20260209125554.14700-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Pass the VC logs DT parameter through to the kernel
device tree. This is used by the vclog tool and is
a useful debugging tool.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index f9b643555dd..7256d66a9a6 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -608,6 +608,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 	/* warnings from the firmware (if any) */
 	copy_property(fdt, fw_fdt, "/chosen", "user-warnings");
 
+	/* firmware logs - used by the vclog utility */
+	copy_property(fdt, fw_fdt, "/chosen", "log");
+
 	/* address of the PHY device as provided by the firmware  */
 	copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
 
-- 
2.53.0

