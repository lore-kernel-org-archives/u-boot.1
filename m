Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93103C55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 21:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51010606E0;
	Sun,  2 Aug 2026 21:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wd_48sWeQ_sn; Sun,  2 Aug 2026 21:36:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88942606B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785706618;
	bh=ckuTXtp4jhorvwG5ZruJoTKyF7QibO+k299amwryz7M=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Vk8LXreQ1BwDCD1g9/h/NEBDYEofF/szLzyd7r0Qi3Ja9jI3hLOX+NXIXWBUrIh2n
	 LEHw/dapQA5lKMAPZ5tRQPhyBMjBmdyVdP5tCnrONfikTuG9CZDIhNvQit7XfXtgdI
	 EDgENP/CAhJmkoU80YX8VoX52sglODmUXEqd7m0EdkjnAJ/JR7odOi+mwcq5iUbCOU
	 W6J+b3iHugGS7JBbcs1JueZ3l54mFRtF4cSgTTluYIH9xQcYkB1+k5zK3YCD5QdVvg
	 MmLtIa2yzyM8lspnf3OZlAMO7gM3AD1AlORFfz8FD/NGxJ6I9ZcVY/hvlLErEFBVOZ
	 TDqYkgRHoYC7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88942606B9;
	Sun,  2 Aug 2026 21:36:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A13E8313
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8760D606B9
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gb8yCvLMl6Ig for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 21:36:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A26CF606A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A26CF606A3
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A26CF606A3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:36:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hCtRn24HwzMlJh;
 Sun, 02 Aug 2026 23:36:53 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: dts: renesas: ironhide: Describe inline ECC
 carveouts
Date: Sun,  2 Aug 2026 23:35:50 +0200
Message-ID: <20260802213643.134847-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260802213643.134847-1-marek.vasut+renesas@mailbox.org>
References: <20260802213643.134847-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5c986fc83d841974569
X-MBO-RS-META: 7oox9gxzustcqc7crb9mx9hr1prgsyu6
X-Rspamd-Queue-Id: 4hCtRn24HwzMlJh
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckuTXtp4jhorvwG5ZruJoTKyF7QibO+k299amwryz7M=;
 b=Gam5V6anK6VTNvKJVgGRq4b/5iur6eysVs9XPeiM117/k0gikWD80xsS0YPZJqHIiAgwOr
 OsZ+drXDTtf2DguB8My4fwouW+d5448pyjN6imRLBapqt6VPe/ynaJanaIG+l3CX4Q2CYW
 lVWJWA2PtNgsb8pFCpfDwpf/9mItZidDHaP95lhq5yG99Ri54R7JJaaWC8Qvz7rvpNyLB/
 rUWMDk3KGCpkKKDI/5lWbh+EUZmoXsru3TYZ6GO+KnpDCpQnwzssue2UXSzArYxlrPEEn3
 hkd0MOvpUsgsPZyvL1LXPO9TRzVGO/+87oxhdRzvIW8SBfQn+oXTuM385mpOGg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckuTXtp4jhorvwG5ZruJoTKyF7QibO+k299amwryz7M=;
 b=TOkvIEcztx0Dputyfho0rLJYHEyctHkscKBswTfF13bjAUC0cQe3fH7S4FtWHcIRFn0dYp
 z/WK8qxiK+931obGV7i8jAUZ9mWQUkD7crHlq7Kgvw2lWUzy8m+KKWgcyJZ7HFvg1Cotb1
 5RVDoumAT/v4hjiRv9x2t0TPne3ploF/N/a/b76/1hfKW4ffS3o33IhqyWI2MaFWZ2RTqP
 4lAgxH/Gj4RQMeGFp00AtJspDjwh3gY+chOKqI7JWxOIJxUrFiv7DTKsmStWrwBqhNKTHc
 2ryyl0+qMa9qD9ihFurxYGv/mnHFyPISUla8ndgiPuAQvvZityLZvbGaSjGF0g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=Gam5V6an; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=TOkvIEcz
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TOkvIEcz;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The DBSC5 DRAM controller protects DRAM content using inline ECC.
The inline ECC utilizes areas of DRAM for its operation, which are
in the DRAM address range, but must not be accessed or modified.
Describe the inline ECC carveout areas used by the DBSC5 controller
on this hardware as reserved-memory, which must not be accessed.
Include DRAM areas which are unprotected by ECC as well, those are
parts of the DRAM which directly precede the ECC carveout.

In case of high DRAM utilization, unless the inline ECC carveouts
are properly reserved, Linux may use and corrupt the memory used
by the DBSC5 DRAM controller for inline ECC, which would lead to
the system becoming unstable.

Ported from Linux 7.2-rc5 commit
6fa6ee724d8d ("arm64: dts: renesas: ironhide: Describe inline ECC carveouts")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
index 21b03df849a..2dc8ad7aa6b 100644
--- a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -68,6 +68,47 @@
 			reg = <0x0 0x8c400000 0x0 0x02000000>;
 			no-map;
 		};
+
+		/* DRAM controller inline ECC areas */
+		ecc@10cccc0000 {
+			reg = <0x10 0xcccc0000 0x0 0x33340000>;
+			no-map;
+		};
+
+		ecc@12cccc0000 {
+			reg = <0x12 0xcccc0000 0x0 0x33340000>;
+			no-map;
+		};
+
+		ecc@14cccc0000 {
+			reg = <0x14 0xcccc0000 0x0 0x33340000>;
+			no-map;
+		};
+
+		ecc@16cccc0000 {
+			reg = <0x16 0xcccc0000 0x0 0x33340000>;
+			no-map;
+		};
+
+		ecc@18cccc0000 {
+			reg = <0x18 0xcccc0000 0x0 0x33340000>;
+			no-map;
+		};
+
+		ecc@1a66660000 {
+			reg = <0x1a 0x66660000 0x0 0x999a0000>;
+			no-map;
+		};
+
+		ecc@1c66660000 {
+			reg = <0x1c 0x66660000 0x0 0x999a0000>;
+			no-map;
+		};
+
+		ecc@1e66660000 {
+			reg = <0x1e 0x66660000 0x0 0x999a0000>;
+			no-map;
+		};
 	};
 };
 
-- 
2.53.0

