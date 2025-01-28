Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1B1C0218F
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 03:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA138187B;
	Tue, 28 Jan 2025 04:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWHilJoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EA081951; Tue, 28 Jan 2025 04:10:15 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6B781875
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 04:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michaelsunn101@gmail.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e1020253so133122639f.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 19:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738033810; x=1738638610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zamSqw6MoVug5NQ4G++iOUyja4wz6nFach+US7B+rL8=;
 b=BWHilJoWMN3JZCNk76Utrk7Jp/vnYe+b0mgoNZcRZux6rA8uYMJ+20zsYO8YCg+6nE
 3Cp8sUqjVTpjHSJAHznkx3ETjo2gWrHCE1BNwWoGoqGhcOwSnQIu1tfeBFXNdVM4340C
 4kXUv+ZWR76npKmr2+1mrYNcXurRFHn8OQHwHzucUHIUBZx3UNYPHoo/7iSceS81PG+/
 3BtFJT82LqGWD4RXxvatqdh5kbivUcXAt8uKasPAMm2XbOIu0VYphgXBqBfKaJXNdqiF
 jgWQqXYvctDGY04cQ5vtEUkSm89MQBDLmEJwMI82RkiT+qIxp0uJPL6E3Xz3qpLszFnF
 0YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738033810; x=1738638610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zamSqw6MoVug5NQ4G++iOUyja4wz6nFach+US7B+rL8=;
 b=DMelSC+H+oAAFz44zKE/C0YDfAviUcJcjg58E1139ueHZTLc+KZTpgefB66tkxigLL
 sfKw0PSodxKocBnUDz/CNpeCA525aTe2YkdpTwdp09OZIKhtH8CV3EGjJfdh18Bw8WN9
 /C+6+Zw8IMXIwohYdpw9I7AP+SupKYg/CktNfBUN5wny4XRSQ9kVzRowCKRhu8q7lOcz
 4838I18j03sqCqVU4WMIN3CpHSdtZ4ZagrbntGTVrCb0T8C3FNiyKhp3H3dvPpMxigE7
 p3i1koBwj34gSQ95puDgiaDXTT92kmMH1azwdaO+lto6qicfg+Pkm6vmpP33tshqnDzS
 /bpg==
X-Gm-Message-State: AOJu0YzpkqkRSK7hbvu2MNv0BIq7WBSN03GQDgVHOQ4eU8xJerkPXveO
 +7sYws+8xFk9uXij54/98NALG9gYenZo5rz5M6CnlPkZmk8lKfUvVGHJUbA=
X-Gm-Gg: ASbGncs/dp3U1r9HwMa5UDPPto2TJhRyo1iLhYJEmUX6UMydTlstQ/fZwiGcooC+IHl
 iy+/COa4Dyj29sUgxsSGa8fKaqsiyji0SbSzyYemPAjukgkLfEfzrxIrf3nza9dF33uU9ZSL/LC
 LvwjMraHjmh6paYtJXUaOctw1DvGg2JUnQQN4lJ2Ea+tjOm387Vjm2fWMNJrNqG1XqRcPRjGA9b
 nS9Pn2diqZkZRaQNkp2lvIb6sfNZ9gnkgdJcovwThZ/yFYjZgOTytjIfqU0PLP6C/cwlZko5WmG
 wBhOtOxRyU3DVEmTfwQxqneYxMv25PLdgg2xqlsDpg4=
X-Google-Smtp-Source: AGHT+IGL2u1YQrSvLZbspaedmIr743iadLxq7Zd1vxb/MJ2vfiDHb4x5Y+cw6pEo5SzsiUPqIcIvuQ==
X-Received: by 2002:a05:6602:6412:b0:84f:41e2:8087 with SMTP id
 ca18e2360f4ac-851b61d2825mr3254794239f.8.1738033810462; 
 Mon, 27 Jan 2025 19:10:10 -0800 (PST)
Received: from valinor-2.taildfe5c2.ts.net
 ([2604:2b40:2185:31:7b1b:4ebd:7d46:b4bd])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521de0b206sm311699539f.11.2025.01.27.19.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 19:10:09 -0800 (PST)
From: Michael Ferolito <michaelsunn101@gmail.com>
To: u-boot@lists.denx.de
Cc: Michael Ferolito <michaelsunn101@gmail.com>, Marek Vasut <marex@denx.de>,
 Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH v4] usb: gadget: g_dnl: Fix NULLPTR dereference when serial#
 is unset
Date: Mon, 27 Jan 2025 21:09:45 -0600
Message-ID: <20250128030945.1219589-1-michaelsunn101@gmail.com>
X-Mailer: git-send-email 2.48.1
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

The current behaviour of this function will dereference a null pointer
if the serial# environment variable is unset. This was discovered on a
board where U-Boot did not have access to the first 256MB of ram,
resulting in a board crash.
In the event that U-Boot has full access to memory, it will still read
from address 0, which is probably not optimal.
This simple check is enough to fix it

Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/gadget/g_dnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index 631969b340..f2540eb6de 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
 static int on_serialno(const char *name, const char *value, enum env_op op,
 		int flags)
 {
-	g_dnl_set_serialnumber((char *)value);
+	if (value)
+		g_dnl_set_serialnumber((char *)value);
 	return 0;
 }
 U_BOOT_ENV_CALLBACK(serialno, on_serialno);
-- 
2.48.1

