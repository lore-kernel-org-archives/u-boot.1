Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06817CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E6683E92;
	Tue, 18 Nov 2025 19:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bbAJVJet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A1583F50; Tue, 18 Nov 2025 19:04:11 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D01783EEF
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-656de56ce7aso1200795eaf.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489048; x=1764093848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NWdgnpEfNC/isnGfZp4rOA87f7Y94fJ01ayGjLs1ZFs=;
 b=bbAJVJetXYyYVjpL9qIWuca80zRx4JFlFKdCY14VWxm7XYvg41H2O/y3v3r+LFP/v/
 fzeRzuHyOsM7Kz+rkTCspEGkSnFKdL6MCgrAFCBeioSD92lu58qAvQoZo923ylZeyvHS
 oyE4ec7sisknZ4at5lBmjFPx6nWYXFPZx1LXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489048; x=1764093848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWdgnpEfNC/isnGfZp4rOA87f7Y94fJ01ayGjLs1ZFs=;
 b=U+WAq6SWJSsO5kbF8tAOndPTA3aknYwjv8mdExGEbeNJWEtoA8e7peV8AeuTeDQmvS
 iS+o+DkQXs1GyrajONyDisLXHVIUdgZzTCFYoPEz+iGaDmky1ReKfjYLaaCAVuvKR5wJ
 pgmfhAKtYFUWx+xbf09jhiHpdHK1C1oEMfmcNAlqgIo15G63kTiSoH+BZC6mOUQv/F3m
 JGAxwqRhMFUVQ7LimQFEcvpFwdubrlELCGigt9A8tfJZGrYMOR8wIlRJ4Y24pZmf8i1S
 p5qXm8x9TJVJYB53MGBTXLjrCuxlS8eu79H4xMTTaNzqPDzfu/G2EKy7/LVvdzLGiNO0
 3teA==
X-Gm-Message-State: AOJu0Yyp1MzWoFvguEbJcUwYeNR16wWR74eoWDdWKaFuu1B88CgwF2mR
 VO5rA9XHUO+469a6RdwpzP+r3NcmZRPuol63kSEr5R+r8PVZuNhJvrqOVJ1u2JgnkoUapDtbFVE
 HCXrRfDWfKw==
X-Gm-Gg: ASbGncs1Kob0gReiLkaqk0SPCWn9r/AupKp9c8JJdNviBJYDs/ip5fefCI6nBz2su5X
 7dq/C2t/BsmzlliSi0BTDClbre26UkDwTnYk3zCawlcFfafieojpC9ldvbS7G437pOkEpAq37UC
 JJZXhM/HZOdEnOPb3mFL2ovcNmJ+sKLlqPrHRgbYIXoowC4MMUDvqHTM6KvNLkrDfQulZPulvQZ
 r9ZlAM65OsPzxNKLIHOOR5nkF9ttHC4kViK3VuSDP1+str+OchUpKbpV+pswWQjoxtINzZn6klQ
 XeGDkbx1h0LPWD75q4YifSqK42DuPkTqcrlyWb5CRHlnP/2QVDTTAwlOMZT5tvrfVPAz+G8UHRT
 I/coFx9QH9ntfk7ykGTuVyO8Dk20YSgUfcdstwAdpvf3QYo70opmUgutIntXg0/H//X5k6djhz1
 mpWus2nzlBCOAcXkXv1a4ibG7Vq5WtTZ8GV7YYW/vd3fq7x1Gr8HOo5Y8a5lHPdGM=
X-Google-Smtp-Source: AGHT+IG8G5NJL14G/7pyaJ8FxYgl6HidAdCig2PIMFEEBJyPfhlfHS2PR1Ym0SXEr44KVDA709VEtA==
X-Received: by 2002:a05:6820:c09c:10b0:657:633d:7361 with SMTP id
 006d021491bc7-657633d86e0mr1253622eaf.4.1763489048162; 
 Tue, 18 Nov 2025 10:04:08 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cb873dsm5569130eaf.4.2025.11.18.10.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Patrick Bruenn <p.bruenn@beckhoff.com>
Subject: [PATCH] mx53cx9020: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:06 -0600
Message-ID: <20251118180406.591149-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Patrick Bruenn <p.bruenn@beckhoff.com>
---
 include/configs/mx53cx9020.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index 70aa140036f9..2bd1426c7d9d 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -40,7 +40,6 @@
 	"scriptaddr=0x74000000\0" \
 	"ramdisk_addr_r=0x80000000\0" \
 	"kernel_addr_r=0x72000000\0"  \
-	"fdt_high=0xffffffff\0" \
 	"console=ttymxc1,115200\0" \
 	"stdin=serial\0" \
 	"stdout=serial,vidconsole\0" \
-- 
2.43.0

