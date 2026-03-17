Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BECAFB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB45C84297;
	Tue, 17 Mar 2026 02:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pQVl5iD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E579842C9; Tue, 17 Mar 2026 02:24:48 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105C684297
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1872504cbso303827a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710685; x=1774315485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VBSvUQ9GlEEiwRMYp1t3FL9xS0rpt1CvfO3iBz0rEks=;
 b=pQVl5iD/vmVmijDafHhR4RYhjqZDlIzomUZYKNOP4wm4HKFXtKsk+OZ8Cqt79XLWze
 anSUrdci6gfFGHWKeBe0cOU/c0N76Gda/lDj/T8OXTfTfWLwEggyA+dA3DcJ7tExhCVp
 s66KBvsp4runQ7UKz3xs3aXgx7jLBgELsl5Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710685; x=1774315485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBSvUQ9GlEEiwRMYp1t3FL9xS0rpt1CvfO3iBz0rEks=;
 b=iLiCmkcE9INzMAW9XpbkoxDtN6GCcbjLY9NadDsUDm9Bjmf0ca0ZIv7bXJ32zROees
 EUrTK+wHZW9E7qtXjTLOK9pNe78Sayf/AWMp6ggI4KqcVMFxxuVHcxuqSGOMP9RWSb+G
 fUd74Yb6qx8cbye+ZXgpJbAZ92dpaSpZSZTI911v4Nz7ne5GNkO5YTYkyd223JMpnRLN
 s8PF5hhv51xtePDDwm6APXabJO1ZpkwWqoRS4mM9XSPq7bD2an8w1EPYk8W7s4qs+d40
 AsaxylEzHCp6cOBkUDqmj88qTLG3s7FR2b0HVimvrG183n4M7Kl+SeTscwtv3SZfK6AG
 ipiA==
X-Gm-Message-State: AOJu0YxESuxbidEnSEpACZ6f026TnKHigK4+8TptwjfBoMZUZbTE2i67
 2/3XX9bzqGYDgmHNvYH3x3XrnehsH31TLl6ZokaW1xZF6/LkiwKP5GTh3PBCFEelptPsixMj8u1
 PWtWy2bk=
X-Gm-Gg: ATEYQzxcs66tSiZCI/NWgs6JebGPdTffbutEv1tNf6onbxxQsn/PYNwid3jX8of7J3Y
 mEO3YiqyYwGCnkTW/P8wu3MtlH/fBML2gv7JyobmMz4JeLp7mdz7b5LH4WdrThHblRDHda8UKLo
 +qeYeAt5aX0XHbTmxpjYjayfA0KjqvrceONQtI/ZQxH/wfjICXjxzTTD+uREDX8ZPpUJCV70RpO
 i/IyzwnCl6RE52KKeKWnTRJahAOsxAnMUVF7eYKYyuVtLT1FNZb3bL35tYoxRcnEp+aaESPAur7
 YmAnE4UKTarBbyYQACVGQwNPyX03FpLceb2ZRm0/7OK/51nDnKkUyCqRS0Ego6YpsP0PlyeCBEg
 QSPauUHeF1icWoaYRPx3AnURZGEBc9jNw99KVHJk13xC68qzDn7mu9fTFN/7683T5s4Hif4FPr3
 WTpb3HmUaPmRIyhJdGCv0Y6WmDR9zkIBF5fkfDIpPa9BHUFj/JNUYjw20GeIbWmLIRuWQ/qGBC2
 X1PiKyNu0LzuuCtwFgPqZZdwMA+T4eBlINpwTJ3ye09Vl+6JUo=
X-Received: by 2002:a05:6830:43ab:b0:7d7:bf70:f9 with SMTP id
 46e09a7af769-7d7bf700932mr213325a34.1.1773710684707; 
 Mon, 16 Mar 2026 18:24:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aa5dcc7sm13956159a34.0.2026.03.16.18.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Date: Mon, 16 Mar 2026 19:24:43 -0600
Message-ID: <20260317012443.4162600-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends on
DM_REGULATOR this symbol must also depend on it as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 66911199c8ba..3f0ec50510c0 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -239,7 +239,7 @@ config RESET_AT91
 
 config RESET_RZG2L_USBPHY_CTRL
 	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
-	depends on DM_RESET
+	depends on DM_RESET && DM_REGULATOR
 	select REGULATOR_RZG2L_USBPHY
 	help
 	  Enable support for controlling USB 2.0 PHY resets on the Renesas
-- 
2.43.0

