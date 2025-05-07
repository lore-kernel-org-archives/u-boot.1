Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE79C369DC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 06:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4AEF8212F;
	Wed,  7 May 2025 08:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="RMsYmnJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589C08212F; Wed,  7 May 2025 08:08:05 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF608216C
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 08:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746598078; x=1746857278;
 bh=B9ACeeCBCWkFqEa0Lc4g/AphJg+TQTuDXV8ePfdOOlU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=RMsYmnJ8mwvumfAWpuuowLeArBy0FfD3YBBb8A0oospzacEmNNRFVDvyKWk0Z5l4W
 bnjxxXhzRiMC3Hy08pDPWnChfcNu+MEAx64hln56cuAqarAASaoW2VqNucOMRtfn/8
 zNUkJFxLCTypRZ9ps8SZ+vN20/j5s9N9GJjKDQmgReOQQ3KqZBymX8L9n5gWA3G006
 jWfZg4IqdpZzN3RirAX28rF7qSE3x5bFLeor2a1nHWKUXvSZu2ZpzQrFyuRUDchzKX
 AH4/EwZexyE88IqOVczK+o1hFH28OSm+V3RS1WdngBGDQBu8lHyblSqTiJcg+orwD9
 M1YaGcaSGVsig==
Date: Wed, 07 May 2025 06:07:54 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] arm: cpu: armv7m: add required .type name,
 %function directive
Message-ID: <20250507060739.326096-2-johannes@krotti42.com>
In-Reply-To: <20250507060739.326096-1-johannes@krotti42.com>
References: <20250507060739.326096-1-johannes@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 29bc29b6ed66c67a655ccd2776dc3cfff607b02f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Since GNU binutils version 2.44, assembly functions must include
the assembler directive .type name, %function. If not a call to
these functions fails with the error message 'Unknown destination
type (ARM/Thumb)' and the error message 'dangerous relocation:
unsupported relocation' at linking.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/armv7m/start.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/cpu/armv7m/start.S b/arch/arm/cpu/armv7m/start.S
index 0c07f2140c7..c20f01a0aed 100644
--- a/arch/arm/cpu/armv7m/start.S
+++ b/arch/arm/cpu/armv7m/start.S
@@ -12,5 +12,6 @@ reset:
 =09W(b)=09_main
=20
 .globl=09c_runtime_cpu_setup
+.type c_runtime_cpu_setup, %function
 c_runtime_cpu_setup:
 =09mov=09pc, lr
--=20
2.39.5


