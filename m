Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61369F357DA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 10:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB59D8366F;
	Wed, 25 Feb 2026 11:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Sqn1Mqnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81AA83AA9; Wed, 25 Feb 2026 11:28:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBB782A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 652EE3F73D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772015317;
 bh=ctdZIbLFUiQTv/bZUV0lHCnA1Ua2C2wOs2mx9zTJY18=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Sqn1Mqnpi1PF1edNb2bsQd6hTXpJieCiP556h/tWs6qWnDmCMbqxtJCld9ddBHjmp
 VM4cVdZ2xdb7RQDeJwdMDlVqWUJUxQvp//YT7NmS/NNQpvE2A9t1XiA27o/I/By1at
 Cs35gRYBsBJKIMfcB23TfCysYpygxFGiJS9xgG+leQiSBgtb7TmVNkJrJQ92gnfRZZ
 8GSh3A4SnlMZtcyexBEZL0YTWg6LOFzWOiiQio6WZ2JAVigGye1L57Ns/jaq+UMZ10
 UujY6Mev3dMFmhpsxn2+ywFUC5kKm8RZkS9nHhS/ftNeSJx+lwp9va3exWQ0V6h4Rg
 e9gp5OEQogT0o2GhcrbyMcOvDl0q2/v0wj9qoWsH0JGlJ4bIjr52whqIxTxiwW8kE8
 s3G4eV1CDOQFIA8AUYlaAyPBmV9a7CwcwNPX/s5cVV6wqfMCB61hO8vWOTH8EmLOgH
 YrC0OcteveAPLzJ+9AUVWCpBwIqP1BDVYwJZAfThxJZ2DdOFj7DnWVlJwG+pdFrdnO
 kdlXDymKsRs3wteu9+WNf4lfINuDlIaCv/TZqV1DzjD8DxA9R7+9Q5Hrc3b1pVrlef
 J24yJW+CKlycMW9kJoVX/C5PYNx367dGYt42AbX05RGQ2Rhy3UdqkWNYoa5UJ0TDP/
 pBSDAWcNqO/dhCUvxEoJ3bKs=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4376e25bb4dso4503309f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 02:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772015317; x=1772620117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctdZIbLFUiQTv/bZUV0lHCnA1Ua2C2wOs2mx9zTJY18=;
 b=pBZ8tZ8VOw/4q3Gtj/YRUGHstrILCUGLnSuwAOyoOfaQ//jA+csNoKRJ2RFIZd2VBk
 fszeQtsqP2GySAbA1KmQwnHUAcMEpToiDbOongwL5O87D4XTusXHkTt7OJke/MyjE0CB
 rzg0ZHLpVquG0yXRPJP0nKvJPjlPkvpcyIqoB5Y1yscnQbySBprhdbuuiSW2uT17BjXb
 UrTjvsUA4HkjsyuMtapc7SmXhKoV0bXyejYUrcZgJmOiQNrLYIJsNpQp1yWZsMXOhIip
 cZzhe0Wt2boUcXhVmDnDsUVaNUiQTzJI/CLDvsmJrlpmXKg2bLgKmtuXn4JOvy2tv0ke
 SOCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiNJqb3dNF+jBnwzKWHcZs00/q6fCsj0TAwzanKoePzSCMeG4osrk2oNRTvWek2amVzd43HrU=@lists.denx.de
X-Gm-Message-State: AOJu0YyAKnM6RLIdNpGIHCTcad+ZIGf98WaJ3xUQklhnqt5oy8YEb8h6
 KTyjUepc4XxJflMGdGfWShGtvLdoIp81gNBaF/glrG4o7uM4uw5G2p14J9ow43Rdy3MeKfNShWX
 SBVkOtB4iyoI87LLDlWYXK/mUDNRhrFWDUZBNPGcSHrN+9KeQg9/1dSqXqqcM93ylqQR2Lx8=
X-Gm-Gg: ATEYQzyARzWHJsn+bjZzwGhechzLdMNs3O8VXt/mH5bsnU1jp6v0jm6qeKq/sLR8EyB
 T1tW/feAIB9qw94jJQ9NZC5dwFhO+SdzykmQTD41TZ8DUZcSn2C945M/3P/gETYPwMJ721Xqi8C
 KSkdeZsnuPYuODA71VCCQM3YRf6TjGcpEHU4oC+rzfFbF7h8yrK6rVnmD5RK47R2yj7auHrU2ch
 tBqyTrn8Qke0BH1nkKSvWhcZPpz13RyA+K8ZOivks4XCeZVQZpU/RGQ+bMBgA6kIoxgJP0ZzYgA
 3D5owLJixao8ozkhA5MBdM151Fp88mdCKlSVgR3xow6k5YgMNpO+64uz7i8P28wLJIctQV8IHv0
 i4EbyVFD0CTwVq2rln0JbC4cfxAdVN1EcLZkwRE6UKoSkSTTCzBuDuK/tlYHyNN7UiloYlH3uU+
 68duUkke1Z887lspYBypFEH64ZVGX6lTOg604wkQbqp1rz
X-Received: by 2002:a5d:5888:0:b0:436:1946:c186 with SMTP id
 ffacd0b85a97d-4396f16e368mr29618133f8f.10.1772015316930; 
 Wed, 25 Feb 2026 02:28:36 -0800 (PST)
X-Received: by 2002:a5d:5888:0:b0:436:1946:c186 with SMTP id
 ffacd0b85a97d-4396f16e368mr29618105f8f.10.1772015316464; 
 Wed, 25 Feb 2026 02:28:36 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43987f3ed03sm12582515f8f.16.2026.02.25.02.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 02:28:35 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't exist
Date: Wed, 25 Feb 2026 11:28:31 +0100
Message-ID: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
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

Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_CLINT.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/cpu/mpfs/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
index bcf1ede818b..8054313d182 100644
--- a/arch/riscv/cpu/mpfs/Kconfig
+++ b/arch/riscv/cpu/mpfs/Kconfig
@@ -6,8 +6,6 @@ config MICROCHIP_MPFS
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply SIFIVE_CLINT if RISCV_MMODE
-	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
-- 
2.51.0

