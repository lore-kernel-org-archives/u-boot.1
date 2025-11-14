Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B9ECE7AA3
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 10:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4398183EA0;
	Fri, 14 Nov 2025 11:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CAKOu3U+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A5B83EC8; Fri, 14 Nov 2025 11:20:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98E383E83
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ADB673FE33
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763115628;
 bh=6U1fQKW6u1qRhsL+duzZGpYpN9MNCpDL9P7DriMlds4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CAKOu3U+3nE7uGOLjQgPvQ73DkzbTWQOkCnzHjMWzQSVGNY8AUu/ysTgriaoTuxHQ
 Mp+ER4+xbj+LcuypboNU+shawoLv6OVm9j1m+scWoRtqPfRFAiLmAE95DbBImpaXDe
 vrRkM+k5iYoP/JMC/mxk87OmxBysNkyuz9aSmsV3XrRMQydnLRQ8Y3ShycRqPDnORZ
 FtMjQ77awAaQ41A3YwmqL+Tn6tUDACwsjr0LWZs3McyNQNaH9M06j70rGE9TuAzIGL
 OFjNd3P2FVuSfUJGz835hpC6yuvMCrk9cUb/TPvSbLisKFy+Tjdj29dG5Xd5tbk68U
 MTKwOqVJlAi9VoFxTIvYDOZ5bBTMhLtp3304NUgVwgBUvGeHgdx7GIf+8/X375zOpO
 UZS0ww9iIe7AwMsg05RTCnCoHiLlAR439UrzVYKzrMcNg8ugqnCYVEPBFplQ0M0RbW
 XE+MfrrK6bGzfyQHkKY/Gk/guDLXN02cRF6AG35DYur7iZ/PS/y+CPbuk37sf7n9Ym
 DhpQJ8qT5h6W2HgZNmPYGRk1CXO6w16cZX/TdPdKhbSdw0VMnvtZThFd3nVm+n2M9U
 MWMw96Rig+KgeYkY5pHdbdYhJsKA8AiIimUr6dK0PLit/hhW0ZOaChHayqhSAFEYen
 4qoTqVQtikQ+1tDSn+yUY34o=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477632ef599so14655335e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 02:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763115625; x=1763720425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6U1fQKW6u1qRhsL+duzZGpYpN9MNCpDL9P7DriMlds4=;
 b=vkcoscL5VdV6UKeCxz/9cjAnZenx3KXFd5rpWF3+xzR4WXx1uHJEMW3sLm2x+wTbEl
 3lDSMvgiuZWOkXkTyjZGKH059Fz/4ztiAqDThKyjFNx4UHSSHeBQ6DYqwfUkygERo9FX
 ZB3F0QqF13bdc2fGhku249hq66YA97LsiERcm4IojGUCW6N3Za+aGwy/3JELO7sCMGxo
 CKhUCsnbGhU6uniYv1MShajYk8uN0tjfvy9rTBydSaeXSvBrPfBEmVJDGiDh7QPbrJXT
 h6wiCl4WWXHUXha1qPpRIn+3IvtTgalVNOvN2AhGqmZzYNQ1NAOZyjyNOOz0OJFkSKZy
 4mUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHSpNn07hMrfnVwtH/Uny1CRWfO2fETkQnMctABQW//M9yUGXLvkwNazQ1C4LqigX3Fg4Vs0=@lists.denx.de
X-Gm-Message-State: AOJu0YzyLXykjCIKnPOLcdKzGzCyFc5bctNjHLUuU18UbNm1eEWiSYis
 D/+ZVU+So+xO1LpTomJ3kpyQfm/iSSfaIrs7JmL/72tFxwhO4t24ZZFQHL+BzbrcOW2ZdM0NnST
 /3ky1hKuzHWSOH0ieXsq6IGHom5jOv1YF/a/O/k0S9LVqq4GIfPu7K+Vi5w0SlbuSgAZQ59Q=
X-Gm-Gg: ASbGnctY8e0JTjz2QfwByR7d9e6DneqPNVc9+4IMSMUzSbE2Qm6AfIn1u7TpiIGmm1K
 bRENe1KAlqJZ4Z+J/TdzSQxGQS0YDTzJUFwWGDJd4DdybFshbTneMfQzPIbCPjklhfRqkBaxTdW
 SS3wiL/HMAbFDAV8JFEKaaZ0A1rKvISCsgIY01xTWLknHi8XtJ4hRH73HbPL1SvwphM6oQ6irOT
 vWOzh9khZKKjVUoYCu5dksMLtSNmbXcvn7atCtKt+iWDWORhAyhHhHRwbH/WghFeBtMwz3WcZYB
 UFQhbav/HcKEBs/wXbnU5YS6SEjlx/B/W7UFE3zNC+sMQ6CDAsn7VT9WpiT54I76zRj5o7+D/mQ
 bX+qSQ8TML8yPEO28S/iV28WCo4u/L94adhjUn8w/1Pig5e1shTuN+nhiUHbiM0541A==
X-Received: by 2002:a05:600c:4f49:b0:477:7a5c:6a8e with SMTP id
 5b1f17b1804b1-4778fd90262mr27192385e9.9.1763115624920; 
 Fri, 14 Nov 2025 02:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdFsIB52WeTvmrnnwL0HO1MwTtima1O9nyOIKwTnb1TDB81+hm5vfZPYTahsRTf+gIW0DpRg==
X-Received: by 2002:a05:600c:4f49:b0:477:7a5c:6a8e with SMTP id
 5b1f17b1804b1-4778fd90262mr27192245e9.9.1763115624573; 
 Fri, 14 Nov 2025 02:20:24 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bcf9685sm41989035e9.3.2025.11.14.02.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 02:20:24 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alice Guo <alice.guo@nxp.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb: USB_EHCI_PCI depends on PCI && USB_EHCI_HCD
Date: Fri, 14 Nov 2025 11:19:52 +0100
Message-ID: <20251114101952.79261-1-heinrich.schuchardt@canonical.com>
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

CONFIG_USB_EHCI_PCI cannot work without CONFIG_PCI.
The detection of an EHCI PCI device fails without CONFIG_USB_EHCI_HCD.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/usb/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 427b62e934b..7282a34ff00 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -271,6 +271,7 @@ config USB_EHCI_MSM
 
 config USB_EHCI_PCI
 	bool "Support for PCI-based EHCI USB controller"
+	depends on PCI && USB_EHCI_HCD
 	default y if X86
 	help
 	  Enables support for the PCI-based EHCI controller.
-- 
2.51.0

