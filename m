Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F735C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61DA88670;
	Sat, 20 Apr 2024 02:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="DvV2R+d1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0858813F; Sat, 20 Apr 2024 02:04:05 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F6088693
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5T0wjPghC0sRbkAsuag1RhqTJCyLnvCIwEVua2GVeY=;
 b=DvV2R+d1uacy3TmheUleVEW1ByJvxyXsJGNDWfDbK79ITXgFn584D8GnSFLCFGyokW6D7M
 /qMFOOPaeyfcHr5E0bB99C7vGF58McC2axvUi4A9emg967GOQJLkvP+itaYQHSbFxbWzEn
 yS19naKOcM3Umf5wdMdArCfFr439oeTmD8QvatsWrjMfiIU7y1m3qq1lDbmvuQ9iwdAq88
 oxukv6cV+oX5U/Rq2e4GKwFJgx31UYjZaaLC9EEaO9rIJPzNzJ4/jpB88+UCJP7D3zr0t/
 IlRDeNu/qw3mJ4tDeDn2XXpE6t0E8ZAruSLv4F2R33cmWFG84/N4LAv885TfPw==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:36 +1000
Subject: [PATCH RFC 3/9] sunxi: sun50i-h6: Specify DE2 and LCD0 base addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-3-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571372; l=748;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=IySDGZDJQ9iUzaxPdy5nvMjMDL09d9dIHpL39uDY5p0=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAcdKgMHgHCRd2cjZ/Mg6gH+z
 oMP59/yK3pg22mBkiwUyrpY6Ho1hVeVZ8BZ7wD2ZsY5Yzht3cYtvqdi3nxyxaBQUAAOoy
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

These are used for operating the LCD on the H6/H616.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index 8a3f465545..2c9fe18289 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -31,6 +31,9 @@
 #define SUNXI_DRAM_PHY0_BASE		0x04800000
 #endif
 
+#define SUNXI_DE2_BASE			0x01000000
+#define SUNXI_LCD0_BASE			0x06515000
+
 #define SUNXI_TWI0_BASE			0x05002000
 #define SUNXI_TWI1_BASE			0x05002400
 #define SUNXI_TWI2_BASE			0x05002800

-- 
2.44.0

