Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D987CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B93060771;
	Tue, 13 Oct 2026 08:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jY9CcgMEhPOD; Tue, 13 Oct 2026 08:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 756A160776
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878575;
	b=hmMn5x9rVhao48naZRVWo5bA4DyaGUx8OsRzZAfj5RrZXY5cWE8/CdPGIgAi9nDJEbM3
	 EEW850QDqFPzrsLSNeVjq34MSFVxHu3KDE/gnDJNLkT3gMCSnlDSt8YEJNFECtHdokBf4
	 GajcFxaY0tn2dk2k08LyeSeNE8zVGleWCzUG0ma9Alwji8crelElW8UAdB9rEzKo8A/ea
	 11vuvoVXIXENdlOzZse3rPWeIqWlPAO0zxh4HMjCSAiBrPdvJpuKt2b0MPfm9hIDjlOua
	 DUkjOVI+/tMVsIOBam7C+LABLLqyGJQQRdyAx3LzHBj9BHlHBLS9e6cscwWKPUSA2lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
	b=T1ohkUFI8Pz8F7F6IGK/7yjpBwyDSQ4mXiSfR+E3cQqGNvbgNXPrY99l8z7bTJqWPkVb
	 IfN4LHmvt5QVPqiOs0vjlbR+uwwx5V1MVEIrTn7fZ8exehDjYh9maVlSfR0nBySi8TFbg
	 6BvFj2DHBco8qhhwwa0IVbhllkGZIjGH72iG2eUuxRkXGotyVTzjzE0y+Xn+nF1IrqjZE
	 yKQdJxNl7p95HHMwNDtkMnpTrauWakX5K2EpKU6XkACkThfEYPDBo5AUPkViQgSq1eUNo
	 jKqEG2XXIDlrHbava3DEt7pXEwW8f+nW8WtpuVk0ePWIvQ0JJmwf6tQeXaE8kiVGfSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878575;
	bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTuagzVnR7PaFoQE4y6GVQ/Z808+vSBgtAHKcn25LmIMekJlruDfugRS67JWp89Lc
	 O8owaPqSAlB+54csYAvRgBk8UGSXRA8Q/qp6zJkndQo8HdkeBRfa5N5zYWuWHRdm4t
	 PCJZZmzDfgYwyKzZN/0aGLkjsOZYrMPa6yAfu2ymeSPdi7YQD2m2734d3+NTG983b+
	 3zSP7Wk0qlsJcMbao7nn2a6wGatSwtn/9MJb94/e2nAG2X47TO2GylfjhJetOY9HBH
	 A+/jNwIkCloG80T24A6afB6HQjckXoUElhDvrWPCEhQvaOsDGPmrFB3XvFO3KGUfnb
	 AxhhkkBp1eWyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 756A160776;
	Tue, 13 Oct 2026 08:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCF86105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC5B04065B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JRHnTDgcgv5d for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E866C406A7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878573;
 b=rt+Bk9xj59OTVKphYPD+aTVzbM522BIQkvv2JBEvKieZ9pBqa2zXbyCvQl6Fsz1dnIlz
 KFvCB0DRkhefl5ZR3WLszviJEe329ZgY1gjsGkYVf+CWIS8tutE6/WesIG37gBUYD9Bwv
 0zGigVze9JXX8tvfksIWS921m4uYtF4PlZxGN0myrUSTmxImJD8MMEfVH2wKHvfV3WoZq
 PK6Kgq81C1s0w+T6bbbz70s+fEWv6bfv2X18GmhRpVCeMgIP4A8nNFr89cCihyOVmRNsP
 xnl8r7WRzBwlSbZq0+POY4rXRb8qOVg9zHTGfQi7unhd5MVQzaWaA4c82LmR3vE/M/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878573;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
 b=KCVT+x4g3la3MuBNBJYW69CSksY2qrj+kD7TZpPRUH4LjJe03S+KbDvZ6+fIefn9ZuiT
 NZINtYhpBlvSuGemSGAXrVQLPaM36jnJCE6AdZdlhjZ98OiXIs3EjzzR+sjk4lEL+4rkD
 1G13X72Uz7foEicDibIC3ZKoA/K+B+1fytuvSzGRjE8YZGqbackeinR0d5lgdrppO7mNb
 kv5u7cXQTZ59mkEzt4KzimWC1trPQL8ObHkkuD1j/F9NSl3PcIH5eoPrUfGlsQyriXOQO
 7t7m2d/gPJcA95+p9W7lJIah1PfjsGiAdviwCwbeH2PGjvAAOwY7WxeZDouYf+cTfTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dJniJRGV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dJniJRGV
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E866C406A7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:52 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so1896840a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878571; x=1792483371;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
 b=dJniJRGVneGaxCbDriv7TIynmRSC0V9u2JnIOwO9PZmfS7KIERWx5z7tn0fxN510Af
 NzBtNlyxCM6CnIIQ6lpG7kXag4RrLsnG3aizQXP1Py2+x+jwMKcOARuETaWtp7PMtjR+
 Cg65Eif8Ea/FZ4Ttuv6S03D/PKHluaWsv4mhwlZLQ11FzmigA6yMU/AFrdgLDkwGk8Xc
 ynOYsUWI/df3STyPCvvGJlv8WdZY/bbve/zDpB32Psgqj0g09mST2GMOBxBI1nwT4q7X
 ynjDW8tP/AfKTjP53GbhqOH6L34aW3F0adbAkjFD3a07ioKRe6c/LZ2124s3a8gwgwar
 3r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878571; x=1792483371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
 b=JWUE8Zad85WDPN8nFQzCsBYdrNcS6jZkhoOjxW01WSW+xZhPgWNfudsfxoHnf1jiIM
 UaIFrqpNcMrF8V0smxRDOsC5BzxPS6balJE3dpRD+nK1q7QYm/WxBKIQ+/PRwfXnUMW9
 fyef68N0wUlbwgxybPsQ2EwxMoTsSrdl15fuXKW3/pJQxax5sen+//YFZVbDizev3TxF
 L4qGe4Ao1HryR9evpPcL1FPsdFjSCVCuh3GqufQBZdhCTj4ra6R5b+fr6sAXf2ecvWJZ
 R5lX5qVmp6KeH1J+zEmC7kexDemI1HTjxOkuM6oO3qy8FlA13NX89sl+CmgragJajBA3
 GQLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNmkLPMxfeDzG0m7xynn6anoV8lEITN0/wiFj0W1ncmBBB0DeEEPI7d3vUA61GMledSFw2EJs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL+rbNam9uhJ6KMXDuETGWjAFxzguNguQk4RM8AzdDLPS90vwAW
 U9OmkgDaBsXXRWQm5sbLo8S3sxIMCMD2V1Rk/ZPY7jHiSNsuayzZHUHZcJCyGA==
X-Gm-Gg: AYBFou1TedM7JbQ9Phkz5vJfGuVOArrxrvCQABpetz4AzKPV5eySkg5Y9nHtHY25oQZ
 /xoe3d72+sioYknLchAoJQDJTKqNfu13vW4xk9I4x83iorcZ4O4QDeHB2ioeGUiyXHg5fDvJOhi
 GoM+Ir7WsmBs+zz9HQGO1W4Tgwukw+6PNnuTZ3SUdIOHAIDXCHWQ1qUvSqvNyYyoPTBK94qjC+C
 XCnCn7baaTXWmZIetNdGlghF6dbK+B3Pp+ucdtUGejbKeLAImyVnrI72LyGC4MpnImZB4nigHkL
 fCOsJGCBgx/Ngm2jxjxgFmdGsA3lud7hYiDMlto2Fs9+JNUN/JdNP9SphlGTRa8UFkwKOQUdaBy
 b0ccC9NFKWr/vT9rCpiaPU/JrnJE4sU4Yh9rZ7YfS6tdLXwGajCuNgXSSZbam5NStq5AIVPaiwL
 ax9c9tq9MqAcm5gsi3rhQUiszYerOVQCaIt6OlV77JrEajNQcSZGq7F4cgQ65bUb2M3QdBMA9VO
 umdH1McqIjwirHqrRE=
X-Received: by 2002:a17:90b:4d86:b0:3a6:d851:21e5 with SMTP id
 98e67ed59e1d1-3ab3a2fe72dmr9007078a91.4.1791878571567; 
 Tue, 13 Oct 2026 01:02:51 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:50 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v3 5/6] configs: arbel: add network timeout and watchdog stop
 env settings
Date: Tue, 13 Oct 2026 16:01:53 +0800
Message-Id: <20261013080154.1942483-6-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the following default environment variables for the NPCM845 EVB:

 - tftptimeout / tftptimeoutcountmax: relax the TFTP timeout so that
   large images can still be fetched over a slow or congested link
   instead of aborting early.
 - bootpretryperiod: extend the BOOTP/DHCP retry period accordingly.
 - stopwdt: convenience command to stop the watchdog that the boot
   ROM leaves running, so the board does not reset while sitting at
   the U-Boot prompt.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 include/configs/arbel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 63112baf9b2..95f6c365539 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -33,6 +33,10 @@
 		"console=ttyS0,115200n8\0" \
 		"common_bootargs=setenv bootargs earlycon=${earlycon} root=/dev/ram " \
 		"console=${console} ramdisk_size=48000\0" \
+		"tftptimeout=1000\0" \
+		"tftptimeoutcountmax=50\0" \
+		"bootpretryperiod=60000\0" \
+		"stopwdt=wdt dev watchdog@901c; wdt stop\0" \
 		"\0"
 
 #endif
-- 
2.34.1

