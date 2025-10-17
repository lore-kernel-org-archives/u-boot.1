Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22800CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC7C83826;
	Fri, 17 Oct 2025 17:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="MNbMttrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07EA08382E; Fri, 17 Oct 2025 17:21:00 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE5A8051F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DEBCF26374;
 Fri, 17 Oct 2025 17:20:56 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeLoYtAmG9zf; Fri, 17 Oct 2025 17:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714456; bh=3EDw6bp9uKiBWBQQHBpLF5i0TSJ1+iWqS/nCwVEjXgE=;
 h=From:Date:Subject:To:Cc;
 b=MNbMttrgZ3pzVuah2lPyOGMcDJDme8PvjBkAReSuSGjregd5OQ71KGPo7NwhGeypF
 E5GAnlG2xUdDb7c8Wn+WapQU9KvccNJgYvDwQ5aHYUa4rNkRgtPsOO7wwQhO7WjQ7k
 XZRqRI2l4YUrluz0su+9IYY29cVi/56sKN0JZOeFFxm6tAPs5y8mP5octZmGj3Qa7Y
 jH4+owWU2GUwOsddX4NFHJryOT9q6+w/HhgJze5rHn0MexxPHMPIjxUPb6cCpLhqwm
 cW6UPXRo1SU+aMTvdyjdB/MCTe4FCrX2OhgRTQqTQl+He0NTLgoiF7Gi5mfdpREhHF
 Rb2ieZYrSse5g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:49:47 +0530
Subject: [PATCH v2] armv8: implement workaround for broken CNTFRQ_EL0 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org>
X-B4-Tracking: v=1; b=H4sIAJJe8mgC/32NQQ6CMBBFr0Jm7RgK0oAr72FY0DIDjbHFKWk0h
 LtbOYDL95L//gaRxFGEa7GBUHLRBZ+hOhVg58FPhG7MDFVZNapUFxzkmVo0Eh7k0fqV5YVcNyX
 rlg1rgrxchNi9j+q9zzy7uAb5HCdJ/ez/XlKo0OiaO6s7Zmtuo4sSwnoOMkG/7/sXtCYDQbgAA
 AA=
X-Change-ID: 20251014-armv8-broken-cntfrq-f350f68fbf6e
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714452; l=1640;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=3EDw6bp9uKiBWBQQHBpLF5i0TSJ1+iWqS/nCwVEjXgE=;
 b=yI1rHBRj/i6E4AQxHYSatWH31bT6a/TsPe4a7LVitv1Gx9Dc/n6XC5NTCazwjVj9l0prBKeIR
 U4jYNfNGAbiDJc59eU0Yl9E1bOm8Y8oj/kiUAY8tivEN26INUEiwwo4
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:22:22 +0200
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

In devices where the U-Boot is used as a secondary bootloader, we rely
on the device's primary bootloader to implement CNTFRQ_EL0. However,
this reliance may lead to a non-functional timer in broken firmware.

For instance, some versions of Samsung's S-Boot don't implement it. It's
also not possible to set it in the U-Boot, because it's booted in a lower
exception level. CNTFRQ_EL0 is reported to be 0.

Use gd->arch.timer_rate_hz to override the queried value if set. This
setting needs to be done in the board file, preferrably in timer_init().

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- Switched to using gd->arch.timer_rate_hz instead of a new config
  option (Ahmad Fatoum)
- Link to v1: https://lore.kernel.org/r/20251014-armv8-broken-cntfrq-v1-1-b63f9c69ffcb@disroot.org
---
 arch/arm/cpu/armv8/generic_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
index 1de7ec596fc7cbbc3e78a241f163bc0a4fcad6b6..1bc72ed26ca31af8e8e72008ed7885cbde23b076 100644
--- a/arch/arm/cpu/armv8/generic_timer.c
+++ b/arch/arm/cpu/armv8/generic_timer.c
@@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
 unsigned long notrace get_tbclk(void)
 {
 	unsigned long cntfrq;
+
+	if (gd->arch.timer_rate_hz)
+		return gd->arch.timer_rate_hz;
+
 	asm volatile("mrs %0, cntfrq_el0" : "=r" (cntfrq));
 	return cntfrq;
 }

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-armv8-broken-cntfrq-f350f68fbf6e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

