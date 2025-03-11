Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C061DC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24C48169D;
	Tue, 11 Mar 2025 18:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JiA2BnsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBC781782; Tue, 11 Mar 2025 18:55:51 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D17480F92
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30bae572157so56984661fa.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715748; x=1742320548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4kTA2UL6eG1QRPgMO4A+jK4hQeGYDEJl5fEajZ1QMA=;
 b=JiA2BnsOjRCOQp0nIXWGuNxN+OH0mHL8wpzkXOGCMBzWiX47vV6xCw6y8IkrhIf8Bs
 XCQDrj9ckWxI/VM/FvoxpyGjVg1uvi9MduhJkxsl7xKj77+PgEHC3cycFUOBPsHaA1KD
 Qh6iLsZGIZGfnQqOYCE9I5hfFjoAXMDlBWA6D2Ftnz5wIF/bCKju2+WCaEqsYSY64cV0
 thzyN038zo9K8J8vRfoIbIeW1nvr/SjLiCJwcBhHCGqyVBCElScaRmCeAFOBZWMX1UtR
 y1e+NKzK1Rlgc47ZfPydtee7cbk0QjqkBltG5tyh1RUsQz+jfDFr6tFJ4j8SqRRCuCXJ
 A7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715748; x=1742320548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4kTA2UL6eG1QRPgMO4A+jK4hQeGYDEJl5fEajZ1QMA=;
 b=h/sypvYwdXE0L7FgQgJU4Buu5m5YOONk2gjhJy7f7wAcXMO0/oiocN5Wh1rJn8fTgp
 rzedmvhd6W13Tmm/KeNKkSctpLmNnVBM5lS6oqPmdhstYG91NtHwSqhVF2EsvN++9JKl
 dZvqPdpjquuYD//rUVg2Kp5ULeGkuH80zVzrB9ybpDPegRqaH+R88jfsHwLKxVpx/fDW
 inbwFObHL+VzviqLzGVI+A2QVuJ9nf1ixsGcl2MZ2Kf1QEWo7aAMXk0qA/HUncUId7C+
 f1Q7hIANP3CP1qwEEfdUo1ixz+gNfsWlLPQwWotloplNDwxRnU6qKjXi33HvW4cQdH8X
 7MjA==
X-Gm-Message-State: AOJu0YxThgFFPFBwFZLXBK4fdMZKDkT8I8ZET8+nA8AZrDmXTRKN7j/J
 3mRP5OO8Zs+ZVS+L0zU6K/ea3ognt4VHGZhvqcSNUeQcR2ekKOcY
X-Gm-Gg: ASbGncuh86uvzBhTb6i49wQablKNtA7LRtkOyojZuCy8J0BBVyU1a7jU6AyOGet5H68
 zdJtKfB/CekItV6amAVsaxB+EH1iJm7m2+AAGlvuk2/RZszoCswOj+FVdPPNw+AfR8KO0T3Wxh/
 Dm6u8u9y4U7ty4jikGTXIIcDIqG9cR+epF0KRR85IZmGls9rMd3Hpog+Eh4w441VmoqkwVG7svg
 3jvZYdrNWlczm3/elKc0Si15EhuDIKqDDemfdKkfelR4X7sY8ZPX0sDTL/ECiJY7wzIwCY3f85x
 hJ8gbfpcKBtd3+zDkCJn7M6O4ZrlmWwZiuiA
X-Google-Smtp-Source: AGHT+IHBOIBn7WKjERhQsORNhE+OYQu5CgspK3fKgo8X7qbKP5+wxUQKw49Ax0HmaLtfpYGZc6gw8w==
X-Received: by 2002:a2e:6e15:0:b0:30b:c980:c589 with SMTP id
 38308e7fff4ca-30c2066a1e4mr16130381fa.14.1741715748371; 
 Tue, 11 Mar 2025 10:55:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/6] configs: grouper: add 3 second delay before power off
Date: Tue, 11 Mar 2025 19:55:19 +0200
Message-ID: <20250311175522.120018-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311175522.120018-1-clamor95@gmail.com>
References: <20250311175522.120018-1-clamor95@gmail.com>
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

Introduce a 3-second delay and an informational message during boot to
enhance user experience.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/grouper_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index 9221ffb46a3..f265db8232f 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -21,7 +21,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.43.0

