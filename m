Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B91C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 20:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DBF81F66;
	Thu, 26 Jun 2025 22:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="GWrKP85B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F4282DA1; Thu, 26 Jun 2025 22:00:37 +0200 (CEST)
Received: from mx.olsak.net (unknown [37.205.8.231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3AAF80C83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 22:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=dujemihanovic.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje@dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=tqN7zrQ+1HaUrwdoEvMBr6CJoqYDhSEVHozHpZ4vxW8=; 
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1750968030; v=1; x=1751400030;
 b=GWrKP85Bpfmq3RIDPiPFNr1uDNjFE5cFGYqQDkf4SbDEBJxqwK601MWKigHFk8ihRvSO5TxR
 5uN1odCB75fpHg68r1+K1zgKmKbyVeoYJOw0LmhOnnZTiBhmDkV/LM7S+2eZmteqjuiR7ww9uAP
 bBOvOHVfQLTAbytJytNUQ8hOOJ0+F7QLI1vb6rnKzM8gvT5ZAiFUhnl5p2iVZEje87WcH0a4yMC
 oC+I5+QjF150x2imHgl0NT8bavyJ6F1mlldkMDfAZKbl5FSooLrXClOeEINBpsixlIfn9K77fWh
 rtGWM2XJlcwbdFKXnnQ1Aw+LDx82kd4feVdMActZ3e+0g==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id cb242120; Thu, 26 Jun 2025 22:00:30 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Thu, 26 Jun 2025 22:00:23 +0200
Subject: =?utf-8?q?=5BPATCH=5D_mailmap=3A_Update_email_for_Duje_Mihanovi?=
 =?utf-8?q?=C4=87?=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-mailmap-v1-1-765760da24ba@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIANamXWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMz3dzEzJzcxALdVENDozTjlESTNKMUJaDqgqLUtMwKsEnRsbW1AER
 DjjdZAAAA
X-Change-ID: 20250626-mailmap-e112f3da4f2d
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=mDPo054FypVKTum5c4eazPc9aD4+lD+tULVDcEJUO9k=;
 b=kA0DAAoWrTGTUkWPrQMByyZiAGhdpt6jK871vHOcrGYXn9jEBI6cs+CgY/dYGSvOm00rybC7I
 oh1BAAWCgAdFiEEbf9B1g3zFLW3a6YwrTGTUkWPrQMFAmhdpt4ACgkQrTGTUkWPrQMT2wEAhwUe
 VntJrAZip8idsS4A+7ypB+wkTpoc6XFmP9v3uIcA/jpav1V3JB2wjzkPu0Xs1Wv3Iqncm3SQI2E
 HpV2vVywM
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Thu, 26 Jun 2025 22:17:13 +0200
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

I'm moving to a new address, so map my old one to it.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 830a263b983653beb89d8632c075f2a22bbd1f6d..629d0ca95a8149dc15073e50cf65bac3d3d1c897 100644
--- a/.mailmap
+++ b/.mailmap
@@ -39,6 +39,7 @@ Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
+<duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@collabora.com>

---
base-commit: fb4a488eb91b089912ffbc9a74d0527f0f2c79ac
change-id: 20250626-mailmap-e112f3da4f2d

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

