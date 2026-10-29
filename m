Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C0606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RdVb83MQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QohDs/kB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D664E40A91;
	Thu, 29 Oct 2026 23:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jxCH0f2VFQx; Thu, 29 Oct 2026 23:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1C1B40A8D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793317055;
	b=mXHBYqfAWj8ozrBSVtBoYwNJKIeK2JvHxJaNhi1/VbiZuhIPe8OJeQlhpYiuRbNCrn9l
	 9ktUtTQlZ7QQlX74FTxhx58+M4PnGHRJuSs4KPXwROdsScR2HePxDkci1Ts+tBa95IcIz
	 CrJAPEwr2wz1wpCzFxHwyt9/473on/CMSGE2TBK+ntse1koYtu+M1sdJ9Nl1G4DcR/n2y
	 4NAfkrZ3jfQG8dWCS/GBpVF0VBvjdpyBFUjz28XMv4PuYtbm0eEG9wx08X/tKgTsjhauR
	 kV+sJ6OAU3UC3o83SApdv3ANcryDDOWtAc8okaZHvD1zokSznvvoH3BKIiN7kwWG31g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793317055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h4EHtT42E9fxCmMCfHhCo9qlVpIdENZks2MJ/ypPxCI=;
	b=M6KJ81Zj8ilBhsDWjCF8M7m2W6OocDRPoH7ZDZZyoeHY5+V32y19lfTDdiUX90bCW9Fe
	 1sG7YiFMkEjd+vs30NOU3OMQDrSmfuUhPRb/2ukBmDJJcuzA0KCDoZGaawMrQNQIHnqlK
	 Hd85hmM5XKRSQC3u51xEk10QGTYpIzQzsLRzZV2FtDOjCxqcou2yFo6i4jFbPSXQfFGGM
	 yEjjEVYS24BsV/AL1rFx1i5eJ6GushlJPumzdX2NqS1xczpf0i5mXVsaubmm0p10mgEsc
	 +q29BlRoFlooAibN1nK1jRli7CGCE7CXLg0NGdfnOLc8mgwPNxVRA2ILHf/ku5eN6tA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793317055;
	bh=h4EHtT42E9fxCmMCfHhCo9qlVpIdENZks2MJ/ypPxCI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RdVb83MQDO+J0MhX4bQsFqwuz1uXz3flKx+q9oLczLWk9IKj7NrLdQvXsg94Sbnah
	 mc1rBVaIfAnam1Qz6u9aMEnSjQ1IYMU9d2czskMPq8cTdeogh7LxA7R40QGFh2T2Sc
	 K1Gobc4wTwWmPAJWowsj1W6p2bPyQhYBXsjr9uSnhGQYaEwQowZVwiZAEahPQBeGEw
	 +kajeTgf/QyMGp3reh7ascWLFSkJjwJxaGC1kbVu5hGe6VrFwxWZlsUU6BP0uxCrxl
	 jFtHFkLVft0ULzjC/xInZvTj6q7YYee3Gsrr5rZluSGHRrlZJULmNb4eLx5AQF9W9U
	 L4FmeldmVX6AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1C1B40A8D;
	Thu, 29 Oct 2026 23:37:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F932D38
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3454D40276
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8ZETZlBIbsI for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 23:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CC4FF40176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793317052;
 b=h/yKrE4gSBlzE7nins8F+8udJZiflkClUZxgsXrwDFcYWvF0mAdPh5qOx+K8AetcT7f2
 Xf2YzEgDWnhl1k5HVznTBs324O3TzutntuMNmwDbI/yY9f+gxooMOvxjKKGOWzL/7KaM1
 ip4TrW+pNo8sjtzYSNs+aEYeTDU/dahrqDl65rL3c/jeoNwjAG0sr+QRTHDhqqGV73fQE
 l7Rs9cU9nt1k2VMLjHf/TDFi01I0NwKtf+x3OUNO89lHEMBSeUmt4H66osVagYD5tU0G8
 jQFZQ5BXDGTMN+3BY+Aoz+jF4QXUotGJDzVEM2pcb4gHB5axSoEIvfrWz7MIRxoei0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793317052;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=h4EHtT42E9fxCmMCfHhCo9qlVpIdENZks2MJ/ypPxCI=;
 b=XaWB2LXwKSVFwkJD4eLQZ2jGyKHxg+LmSVXWs1JKmPvxX++MEnowJ5OcYnv2WyiW4aBN
 qVxlWi+XwQPStFOfMkl/PIgU2/mla761Vw3rcWyaSwLpZj9N46oNbaZ8PDTJ/ctbEXY44
 NLuft+HLyAJ+5pBmNpFnT4jjKumyGBmurv6ox16F1AXDmoQpcndhOuQyXHSKvaY4EfOqc
 6/Pb1vjqhbRwRVklqX4SfLMAdk6YnOoLHZAWRdXwl3FYWJTrErROBOnlJmntMNZSIY6m7
 PlgCdZbZS71LIBb6zKbA5U5EUoE/mfwCo8QV9G/wXpJC8d8vnffA9dh9+p7y1dv5pqQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="QohDs/kB"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=QohDs/kB
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC4FF40176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:37:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF2D169E;
 Thu, 29 Oct 2026 16:37:25 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C75423F59E; Thu, 29 Oct 2026 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793317049; bh=3Ym+7OXgoB1jhbh23cS78JR00sMp5M3zAMvukTjisfU=;
 h=From:To:Cc:Subject:Date:From;
 b=QohDs/kBl6veGHfUy0WSmt+P1DWvC7zdZBR4N8xrUAW1TelRS1wJeHltzHNdC0Brj
 tH78X23NshyofXQUqkzwhZ12KGscrk7mbao48ox4jNeDU/Vh4rWlpHlP/ciSbJcvod
 mUl3tSCSB1YeRpWTbL5oQT3a7GInLFTzwsCAO38g=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: linux-sunxi@lists.linux.dev, Paul Kocialkowski <paulk@sys-base.io>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH] sunxi: a133: adjust TF-A load address
Date: Fri, 30 Oct 2026 00:37:20 +0100
Message-ID: <20261029233720.8411-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When development of the Allwinner A133 TF-A port started, BL31 was put
in SRAM, like on the similar H6 SoC. Consequently we used the same SRAM
address as the H6 in the Kconfig stanza of the A133 U-Boot port.

Later we realised that the SRAM space will become too tight, in fact it
was already spilling over into SRAM C, which we cannot use any more at
runtime, once the display engine is used. So the mainline TF-A port
eventually put BL31 in DRAM, which of course requires a different load
address.

Adjust the BL31 load address to use the same DRAM location as the (almost
SRAM-less) H616, by just adjusting the match pattern, to not let the A133
fall through to the SUN50I_GEN_H6 symbol.
This allows U-Boot to use the now merged mainline TF-A port for the A133.

This is unfortunately a breaking change, but there is not much we can do
about it, and since U-Boot packages TF-A in our booting scheme, we have
that under control.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b0c5d3cd903..b7ee14c6678 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -267,7 +267,7 @@ config SUNXI_RVBAR_ALTERNATIVE
 config SUNXI_BL31_BASE
 	hex
 	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
-	default 0x40000000 if MACH_SUN50I_H616
+	default 0x40000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 0x00104000 if SUN50I_GEN_H6
 	default 0x00054000 if MACH_SUN55I_A523
 	default 0x0
-- 
2.46.4

