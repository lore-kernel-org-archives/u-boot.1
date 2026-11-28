Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F7606A321
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RRV2cFOd;
	dkim=pass (2048-bit key, unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256 header.s=protonmail2 header.b=MY8cgh2u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A45CD606ED;
	Sat, 28 Nov 2026 13:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWnUCmviOm63; Sat, 28 Nov 2026 13:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EB8C606C6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871786;
	b=Kw4PC4Td9d1Rd6sBCVFmAE/cJJf5rFNrvMmxSMHVeGEeD6FH9jX1nwF8HzzyqeAFjQ+W
	 pCOvjGWFm0f3a1/wgrIf0rEdP5dIbfn6WOdQpzSfb4xNdIZ9EzzY2YKkaV/R7o2/EUE23
	 xPvAF+gHy7Ew7MgEpyCTHzk/DmSFSpvorjxmShIH7kNbKFKcNKeF5cDYgq0ifBDmK/sE7
	 3NeZMkCVutTGf0cHGffbO9W3HXoTNK6ylGQJWfz7AIajmZ2xhlsBbCcWfpRHzDvNqu8Js
	 CwSKn6pePyxyktn0EEor9m9D1Ha31VWZtRgR+nl9AACKZWd7jMZMgjWCXqGsNs51f8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DwwJR8l8oGcopgf/OhqIK9gDaUbBPk/GzkfcG1GlnJo=;
	b=TO4WrofLAOINDe1DAAPOdL6yTwCfqP+pbyEPZpubmBAoh65wgdIxbh9vfdRsJFmvoVOe
	 RycdyMvW/e+AJ/WDVKFyEQGiO8ClHN1CYK8AS7j/aBBYGb3J+ljq7Mzww09T2cBhX5tlO
	 PjgEFeNnLtD5XJ9AlnUZdpbC2Unyn2oeRm2TOpvRQLSDuxeyNA3SJwXXBETlsHXly0UJ6
	 X1Bg2A+n9RJKleo094RvxHyd++ETl5Uz0muTjG7WWFKsQkDEqsLa+zdWKILCnF2DVy68B
	 IzADgqiKORvdhfqsZMUlgS4FqeGF9Yi6SC7N6lKrNvMvaPmM6M2rlkMYLuDjDW9TOTA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871786;
	bh=DwwJR8l8oGcopgf/OhqIK9gDaUbBPk/GzkfcG1GlnJo=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RRV2cFOdWVluLydbeZD7jaAeAWZmi4wvOlqZeRdgQcwBSdJKMwdt+w6AOlxGqg21f
	 pketDtRwIIXAbxd/vg5BT5DskaUfkuXn7kh7SBkWCkcHOORSVmMoPS5a2KkEtTnbNT
	 2jJuTj4Qalxllgcd4EP+a8Pe9I+rE/jlnCa2d5/R5P1I2B4mhNDN9aIYeZTD4SdRYs
	 v7pP13Lslj6P/2Fm8iaBR1I9cI3tGiBXVEAU/hq8Qh52nkWWIMATAc8Y7nqRh2azjy
	 H+QT28IX0AbavCaUNZF7i2dVxJTbXeuvxbUZ2Q/jMfopTMm3vTNyBX9VE7ZeYXSMP4
	 lWIGLlg3tHiEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EB8C606C6;
	Sat, 28 Nov 2026 13:16:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C26E26D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DE6E400C7
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6bjSFyUFJFK for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 08:09:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D4ED4008C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.20
X-Greylist: delayed 61232 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 28 Nov 2026 08:09:11 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=jaeyeong.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=jaeyeong.cc header.i=@jaeyeong.cc header.a=rsa-sha256
 header.s=protonmail2 header.b=MY8cgh2u
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.20;
 helo=mail-4320.protonmail.ch; envelope-from=lee@jaeyeong.cc;
 receiver=<UNKNOWN> 
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D4ED4008C
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaeyeong.cc;
 s=protonmail2; t=1795853348; x=1796112548;
 bh=DwwJR8l8oGcopgf/OhqIK9gDaUbBPk/GzkfcG1GlnJo=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MY8cgh2ug+7KRBOdGqvJ2BS5/GEr8tmuIp9C1GtceKS5ujh31tJw4J0bEMAeRxMt2
 JCdmy0MNL+GB5XQ1Tb7ncqJI+8qwGyl2aNTg9ioY/NRDtKEx7IHuaNp9RA2NqvCEiX
 iZuPjVc9IDGe5+1E64hXcZNjxe2GFmV8Ooc1Nz+7JeZbuLL2DWvym4gt7dLOlE7Zy/
 Pj8/FG8ECIHExl60TNhxr12oEfLvFJLXbVuma/6u6otskfQtqetiEMpEIjRyfyoa9l
 9xfK6IdyCSa4hQpZJr7C4xfcfjBQX5vxeSoNHoD84ucAc88WKvIA/pg51XhrLzcafD
 uPtmij9NoPsQg==
Date: Sat, 28 Nov 2026 08:08:59 +0000
To: u-boot@lists.u-boot-project.org
From: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Bradley Morgan <bradley.morgan@linux.dev>, Tom Rini <trini@konsulko.com>,
 Christophe Leroy <chleroy@kernel.org>
Subject: [PATCH] powerpc: mpc8xx: remove unused I2C DPRAM definitions
Message-ID: <179585333468.377168.5944554103549100837@jaeyeong.cc>
Feedback-ID: 177356447:user:proton
X-Pm-Message-ID: 56ed60238bb3ced85e96c701c73b891067b0c912
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Nov 2026 13:16:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CPM_I2C_BASE lost its last user when the MPC8xx I2C driver was removed.

BD_IIC_START has had no users since the MBX boards were removed.

Remove both stale DPRAM definitions.

Suggested-by: Christophe Leroy <chleroy@kernel.org>
Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
---
 arch/powerpc/include/asm/cpm_8xx.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm_8xx.h b/arch/powerpc/include/asm/=
cpm_8xx.h
index 98476cdf..6a7fded0 100644
--- a/arch/powerpc/include/asm/cpm_8xx.h
+++ b/arch/powerpc/include/asm/cpm_8xx.h
@@ -52,7 +52,6 @@
  * DPRAM defines and allocation functions
  */
 #define CPM_SERIAL_BASE=09=090x0800
-#define CPM_I2C_BASE=09=090x0820
 #define CPM_SPI_BASE=09=090x0840
 #define CPM_FEC_BASE=09=090x0860
 #define CPM_SERIAL2_BASE=090x08E0
@@ -60,8 +59,6 @@
 #define CPM_POST_BASE=09=090x0980
 #define CPM_WLKBD_BASE=09=090x0a00
=20
-#define BD_IIC_START=09((uint) 0x0400) /* <- please use CPM_I2C_BASE !! */
-
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
--=20
2.43.0


