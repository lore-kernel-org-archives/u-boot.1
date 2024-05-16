Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3276C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928AD88326;
	Thu, 16 May 2024 11:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PZDauxmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C27B8826D; Thu, 16 May 2024 11:15:53 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 906E5882A2
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-351d4909711so443830f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715850945; x=1716455745;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M5J6H4LxKzYu95I8SNk46X0MxpyiT+uTwR0gKQj3Vbk=;
 b=PZDauxmdj/ymW3Af3Sgx9AGJoe7XKGlRoJ1brx+3D4Slf7MwH03UgazS1Dg3ckG11W
 +wP2urpGMnStDmpNPnsWz01Ch+wP+lVRf09luZTyoL+W57SP0vHd6MWObVq7sUSB2pPh
 dZL9FCHdlrJUomt7T9zxBhb4gmDxDP4Wi2Lhfj4OrX127FIYvD1wTkVc0V3lcSxlYwn1
 ti+wOVI8l2QIPIzt3p9KPDlvvxO6EoANgksQ7uNYruoa89nixlSva2FRKBpEhSpBpRBr
 7Om7YBg1CGq2P2edsl8BMMByZbaQxZdLd0YYjjbFuXnfvtS+AmKNWYSbsmzvNUn8W245
 c07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850945; x=1716455745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5J6H4LxKzYu95I8SNk46X0MxpyiT+uTwR0gKQj3Vbk=;
 b=rFf3+/hca9thJ73a/YVmMordAOvA/MgLTq/foey0VGXyPOt7cKz3nssv4BdzYJuj3f
 r6atdLv1GlWnPMfCS1rfiB0z73L0cnR1dmk09VFnVXaeJBErbcUBoOsS7gG2ricyuveE
 Jp6qMCTHH2nzvVHzzzunCLJ1UhJHnQqOw6ga3vfzZ7TkOzOqSNoIhFkO6smGj0U8aaHi
 ILLDbUx2QOEKsWtfUBJnS+XAUyQcWnn06MbuKuCmbw1vx+csLh7KmlZGOuiSw24Vuo1e
 v3sk0WLgOmdSUA75vSWI3JjUno0W84OfjdqsBwdRMZvjSKmU48QvY7LKjBjUR2s7SB6A
 FlTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Q2bnh73h3cI1UBwETeKuF+bUe4ZW5vgPr2TJhgD5yX9ytTfEtnilzd/1tzrUoPDubUEPt/HOTiqWI5CzqbM2zF8Fgg==
X-Gm-Message-State: AOJu0YxElnsoQMitzJPjYOGo62WhQD8Apl5LtgVzLxBC1xCg2+EDW1XQ
 GD2YyF4TO7DkLxGmaQ6lfZJNs5428uJQBIgS1sGp1JFv8Fb/EUBnajokWKJS2rw=
X-Google-Smtp-Source: AGHT+IFaoJYMN8wiJ6UA7m1x7tY8g6CExB4S707yqLJ9nOs3D8a4eS3pfS2J1AWPKfkjwgp/piybGQ==
X-Received: by 2002:adf:e68e:0:b0:346:f830:db09 with SMTP id
 ffacd0b85a97d-35049bc0308mr15813191f8f.31.1715850945107; 
 Thu, 16 May 2024 02:15:45 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-351d95d47e7sm1072603f8f.117.2024.05.16.02.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:15:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 16 May 2024 11:15:42 +0200
Subject: [v2][PATCH 2/2] MAINTAINERS: add USB gadget regex to u-boot-dfu tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-gadget-maintainer-v2-2-23cc916df434@baylibre.com>
References: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
In-Reply-To: <20240516-gadget-maintainer-v2-0-23cc916df434@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

We try to split work with Marek on USB as following:
- Mattijs handles USB gadget
- Marek handles the rest of USB

Add additional gadget patterns to the maintainers file so that I
get cc'ed more often on USB gadget patches.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05217db79f7e..6d021763a62a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1017,8 +1017,11 @@ F:	common/update.c
 F:	doc/api/dfu.rst
 F:	doc/usage/dfu.rst
 F:	drivers/dfu/
+F:	drivers/usb/*/*gadget*
 F:	drivers/usb/gadget/
 F:	include/dfu.h
+F:	include/linux/usb/ch9.h
+F:	include/linux/usb/gadget.h
 
 DRIVER MODEL
 M:	Simon Glass <sjg@chromium.org>

-- 
2.44.0

