Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B611CCD19A
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 11:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7511183710;
	Fri, 17 Oct 2025 13:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jaB9Se2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B91883734; Fri, 17 Oct 2025 13:20:34 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 120F983655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 13:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so18439455e9.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760700031; x=1761304831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dq6hyLP1UpKc3VdaLqma413Ii/tULGQn4Fyvtr2XYT0=;
 b=jaB9Se2vlu9H20DLPoGtX8+dvIaY3tZMSbXLIL5AWlfVj0//v49ZMO17H9CIGs+YtD
 eCI1jETW/VIrqmo12Z5zq3cXbN7lyYRgnlT46mTYIkxiEEwsHOGOsD2h714dc+za4xto
 QtWAfJZtkBtMH/Mozf0DFsydAOLAIN1yerprwO5sxkIcsLS9CeoU4lt4EjK+nubk6lFX
 9biaJgcHIBhtB9E/ZDO1c7VgltvcT7ckAhxWSwLvDsx81Cq4deXTFrmhuQ9pjc8ahr7A
 nKi8WV8FY0C4FuAK1Q/wQ4Mht6h5h7LLM++1hQ7isI26vM0rIlSEwvF+NVDm5SBWwnrl
 OyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760700031; x=1761304831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dq6hyLP1UpKc3VdaLqma413Ii/tULGQn4Fyvtr2XYT0=;
 b=LSZuosLGgu/9F9SHdFrPHYgToAdNJySRtW1zqD46bZ2fC7Atynu1LbDfhTdg0S1YHO
 /v7g8kFALDkfx1nadn8v9YDZ1U6QgWsQp0UrVBnyE7jbo8zqfy6B2OMxx+spB+XmKY0y
 wPdDQs3+RuQgg3QsjcqGsP0cMLirqeLxFGtwSu1sgYWBRUSPP+L3juFYKtvDhi5upuL4
 GygbEgHOmcf499cteTcnr/JYginkpQCqQSpeAYWllI/SonwlC7kWgN4Aikt1ODFzWETF
 QMTYL0xaol9zWaw+HgKRsoNjx5yVWxvby/O6PS6SqGP0TG8nk3v5fUkSoRG/7VSBSIkm
 UDng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV46mAXaTLCWp3DyvUI5RvgbWbQMzBL0n00eHJqxgfGCheRrpabRmtbvluuMMlw+q+MKYK5mhc=@lists.denx.de
X-Gm-Message-State: AOJu0YwwEKNc3dEmpxmOTSnjkO6KCY045cL5uySgl+CaNitM3m56AYz/
 kEa3yRIg8Ua6b46YiWmL1WMmzoAzNmH76b8mQwkDYWlXNOPAzJL9UtQx
X-Gm-Gg: ASbGncv5+5aDOSN+0BpffrLYJsebah5qGl9U0LXNhALhc3gwvPQKn9GPolV/72LCBTZ
 4VLPffn2JbY0g+DwWaYjOv/pJ1SZLWuQFBtlBw4GpiSHFzka04TOfdoaf4vp744l9sBC2LZw8+O
 WNgC7hVyMtL9n9acSnWKeVqTfkjuJwzblny3WqbSkl3keNEXNgm+KYft51fIjcbj2jTnyHBoMN7
 f365kJvhUiPjhwczVzh2pqUCVirLTfmSIdHX6hty6zUB85Kt2CIO8yoBc2eZMO8XjUZoqBnwWvd
 S7fO5PfHJs+nPn/0QD+H+j9b9CoABLYOMO7oaMUMgQsnOLwDgFP7RxoP3DSRyCMqdiNWON+4ZzP
 9Y0iar5bIsq9bHwJJm1duk8ZmFVNnEsHlBqMPNkKga4xuES6zqx162IvoQLqYEVf/yh0Y3hHvwR
 IiHmu1menWJBnonOcTXpUYoYrMzV/5Q/gvJ1ypIH5NNdro+ciqPi6Jdbjh3N0RjMYkACBXPCWRw
 naeUNCFFO383uwuOf85CW1vNA5RoadAaaxE7iovehgNhNfbEvQie5IXCMjYwm0i2NGynjaoq4XE
 4YuaCjBkfUlEFvwtVAIYPsgm
X-Google-Smtp-Source: AGHT+IEa+ihEUNzglmrsz09Lq0CS9PbMsV+Ld+wXirYheJc4Aamu0Fu7cyqSl0YkGvfORxrldZtFiw==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id
 5b1f17b1804b1-471178a80f7mr21293755e9.17.1760700031173; 
 Fri, 17 Oct 2025 04:20:31 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-471144239bdsm104908045e9.3.2025.10.17.04.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:20:30 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] doc: ti: j722s_evm: drop outdated boot note
Date: Fri, 17 Oct 2025 12:20:24 +0100
Message-ID: <20251017112028.1891132-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
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

The j722s_evm support is now largely complete and is certainly
not limited to UART boot so drop the confusing note from the docs.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 doc/board/ti/j722s_evm.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 9c53fa50858..4b5cf027594 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -201,11 +201,6 @@ The following table shows some common boot modes used on J722S-EVM
 platform. More details can be found in the Technical Reference Manual:
 https://www.ti.com/lit/zip/sprujb3 under the `Boot Mode Pins` section.
 
-.. note::
-
-   This device is very new. Currently only UART boot is available while
-   we continue to add support for the other bootmodes.
-
 .. list-table:: Boot Modes
    :widths: 16 16 16
    :header-rows: 1
-- 
2.51.0

