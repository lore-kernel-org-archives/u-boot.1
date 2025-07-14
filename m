Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A23EC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E688304D;
	Mon, 14 Jul 2025 15:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="0CREbyzM";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="H5sIQ+UC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4168283061; Mon, 14 Jul 2025 15:22:38 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FED08300B
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=VofmIZhpVaNveXZiK79iKRy3KJa9+7zJNWW7jWC+PIU=;
 b=0CREbyzMc3mD6HAFO1ujLtH3jdGHFg6qXAAtZ3wxIBywe3hzmaVxHdmgXUpIBU+zvhpdpyOe6jBXY
 SELqmZMhljRDmSKwNE61CpHUp9CDWIWR0pejKCFrfyBOVbAyTJT9tGku5M3pytrBGdvVMtSLGhy6gB
 Jc99i8SzJ0f57xqU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=VofmIZhpVaNveXZiK79iKRy3KJa9+7zJNWW7jWC+PIU=;
 b=H5sIQ+UCz9xrbqjdJCiYxRCclxv7PZAOVtp3jEXMDZkmPDzr7RQ+D9rzoSbfq9y3X2vir6+SJsyex
 9S9L0JeSnhrC4uBOJX8klBNUKHYDyvmXN+rjS3WNVQEf+JC+SGHsSoEcGjMpbdgW4bM6LYhyB8HKQ8
 uvBCNOJqzJ6buMYIF0Xecp75OXUSx/7Mp84yx+kezSdJV/gxrQzl+ZQIQMv4jwBSMqYLzFCfT01Q3a
 kojWUxKVTY5SFe/nBsKrQ3rtI2tlCzmffWOv0M/3z4sa/X2pnAerG9rp4k2QvH0D6/FPzZ2HTE3xxV
 tPsdJ/pudUUO7wO8SFouUGEjhLffj4g==
X-Originating-IP: 20.86.212.242
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 98f0d550-60b5-11f0-ac89-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 98f0d550-60b5-11f0-ac89-878ee10b8a33:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown
 [20.86.212.242]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 98f0d550-60b5-11f0-ac89-878ee10b8a33;
 Mon, 14 Jul 2025 13:22:32 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with SMTP id
 C457380528A; Mon, 14 Jul 2025 13:22:31 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 99E16637F985;
 Mon, 14 Jul 2025 15:22:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 2/6] km: Kconfig: set KM_RESERVED_PRAM to zero for all designs
Date: Mon, 14 Jul 2025 15:22:17 +0200
Message-ID: <20250714132221.2471558-2-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
MIME-Version: 1.0
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

This area was used for special purposes on kirkwood. On the current
designs we don't need this anymore.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 board/keymile/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
index 41458813858..3a66b2915ac 100644
--- a/board/keymile/Kconfig
+++ b/board/keymile/Kconfig
@@ -31,8 +31,7 @@ config KM_PHRAM
=20
 config KM_RESERVED_PRAM
 	hex "Reserved RAM"
-	default 0x0 if MPC83xx
-	default 0x1000 if MPC85xx || ARCH_LS1021A
+	default 0x0
 	depends on !ARCH_SOCFPGA
 	help
 	  Reserved physical RAM area at the end of memory for special purposes.
--=20
2.49.0

