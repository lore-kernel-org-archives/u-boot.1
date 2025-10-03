Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5569CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2571683906;
	Fri,  3 Oct 2025 22:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AygiCIn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 599CB838F3; Fri,  3 Oct 2025 22:39:27 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23D25838CE
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-91179e3fe34so133885039f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523964; x=1760128764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AabT5RfH65xmqzOFhm3OjYVpE/CWVX4ZcR60R4DY40Q=;
 b=AygiCIn5oQafMqB4GKNajLVp58FkD1YVqMADoUDjHsICYuwlQX+eIVc4czNBSKtC39
 7xe1iDS1L0pv036k+CLiA4+UsPgkRKIrBmIS5NocvMQLeZzZqmupgugKLJNju2ZKwvEL
 Jl4bNYHJT6tpHTN/J5Xo3dWjXwNyt64Wj2F7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523964; x=1760128764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AabT5RfH65xmqzOFhm3OjYVpE/CWVX4ZcR60R4DY40Q=;
 b=dlSOgnm0YNQO7ESCk6a1ZJNVFaZjTvBBed+37BkRe+hRmao1g7FsI+qIkl5Otl4zG9
 RwyPAFtaK+46Ku11nm7cZe8l0bsMrylAReoTZMwC1aWx5GbGpWzpt6JYDp871mF5Houf
 zWHw6WGrCfmUWxl3XSk3seV5ZJL/ojUiJpZU+mLDGCsBXaBV/BEUtjWu88JAm89DT0mg
 OcKgj5nFwHNRi86AtvSJkx/gksW/T0qfByolfjMzCOppGfrSq0L+h8pZv3wWLZasU8SB
 Qh+DkG2NBSu6n51hxCK/DaNaAzg4kluNPBxn6RkX6g+y9gGkrFug0XlV0TqUsoWkXOfa
 TvwQ==
X-Gm-Message-State: AOJu0YzfGjKGg0lvCZLocuC8eEhJQ/w8+BhWvRlUM0qorcVwmBwoBEcQ
 e7QJao1nZt7j3JEnyJzS6nAaCl0DVQo9eIi/8J5/zApbZV00I1xAx2k//CQki/dfL0vaz6aqOPK
 AR3fccs8=
X-Gm-Gg: ASbGnctidIE9q9/CyitCbjnrIBnzeCbWGG2Mxc+q8OGMdQZPSU0fpo51VsC16iIeKt5
 5Og80SicNdzbmEYnnMEsdWw4o3gW889mfUKVhF0qtcatDK9qvbw3cXJxu8CnaetcC/fjkue2Uux
 akQ3EWEVPINvwz9IoQElP7ceZ3guybE7fQjDRl5vt4vK8lChXYY3IM6rSuix72C6/Xp1zgMhCMd
 lUb9bLLlPgV/nyEhjA7OmRUTZA9iNEtZ/PbjJWicOqbvsfQHzDS2h/LsIFvUKkoeahVgmq4RoW6
 UMDiWr9bFrCPH44RElafo5BqJyuHQ4zu+stiWXyg3IRg/GyPWV7gNgU1iR5CqmkrpaTw6YNgxPJ
 uhatIPyRtxjfmA7H37wtf5nEKjgDG9y5lVktGzkVd7JnZ6Idg2xE1i2l45n06zpcMmtW8ZhNVj8
 fiZYZtppHAF3sCp1lSaD2+AjE=
X-Google-Smtp-Source: AGHT+IHZ7MNKbx3mtUzKK2fU+0Kv3ySEIRlutDJmtuNeO5nEFAccjnwq81QxNDU5duBWRNFcIbpigw==
X-Received: by 2002:a05:6602:1602:b0:887:690b:2594 with SMTP id
 ca18e2360f4ac-93b96a35846mr622662739f.5.1759523963837; 
 Fri, 03 Oct 2025 13:39:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93b19d072b8sm198175639f.24.2025.10.03.13.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] usb: gadget: spl: Add missing dependency for SPL_USB_GADGET
Date: Fri,  3 Oct 2025 14:39:22 -0600
Message-ID: <20251003203922.1029989-1-trini@konsulko.com>
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

It makes no sense to ask about nor enable SPL_USB_GADGET without
SPL_FRAMEWORK being enabled. Attempting to do so leads to Kconfig noting
dependency issues. Add the missing dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 882f082c9cdb..056eff4d942e 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -39,6 +39,7 @@ menuconfig USB_GADGET
 
 config SPL_USB_GADGET
 	bool "USB Gadget Support in SPL"
+	depends on SPL_FRAMEWORK
 	help
 	  Enable USB Gadget API which allows to enable USB device functions
 	  in SPL.
-- 
2.43.0

