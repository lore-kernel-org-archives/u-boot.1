Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF06CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC96D86A5A;
	Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gCL0Za5x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F09KNXQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D5786A2F; Sun, 17 Sep 2023 16:12:03 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806B086A14
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RpVH53MBtz9sdn
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a4zQwqlm/OUiz3Hx4eWWijZTdKIA39tgOb/FxMoTzw=;
 b=gCL0Za5xJsi3KWs2tXwt2cPQ9PefnlHJA7YBsxYPFlUeUf+AvBhPvua7jQK3Wr647lKqvU
 iB9wM5rmNm8puO8al0DXpGV9OZG17DmgePgbq7AW0c8pcOrW4aKin5v51rFzkGbbCyi15P
 JNu7+Rl72qppYiR69jywp37YZ0rp1veCKCOPxEeDPalsXsCm3JjKXlWZCEL2xtRmvHUYYQ
 P4scHjrEomkWBC2V8lqG35TWrSpdLN/eoY9ySyHvQn5+UFFyLV0tGpwEIeqFcnf9okqVGu
 +kHZQLidv1kJxIfkvvMM805evheejceld/32hKAApYMUrz0A/PI9wFCaM7348g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a4zQwqlm/OUiz3Hx4eWWijZTdKIA39tgOb/FxMoTzw=;
 b=F09KNXQixG7Tm25IHZH8IzYd/QFwZP1VM0XdmsD+pR/70D/fL3FLx6kGjjCH5mtZjIl4Wl
 NgQpt8ROMQ1KZyuhc7jd2bPDEQZQs6wqstdn3YoMPrmTan7j7kP0z3Ydxf2I+CjU8dgOq3
 qVXMikymiwFSqJOJZWOJW7MxNiso2OQ6MsD6F8AH5AhSoDSTwRP6KZ1s+K0uamXQjJO2kP
 KLphuhihVr98xRZJ1K/J8jQok/pRYqcqIhwSXJSYK+TwfW+x/XpddPidUGnXyUrJACwBqT
 keBpYENewMVkzCLNSI0r4oRZLNxFte4aZ7b5hj4MPo197T+HxMl2CHnbJeMUVA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/20] clk: renesas: Synchronize R8A779F0 S4 DT headers with
 Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:23 +0200
Message-Id: <20230917141141.379884-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d89b7047dbbde3dc581
X-MBO-RS-META: 1a1zzxtews6ejr6oougi4a884gpbgy18
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

Synchronize R-Car R8A779F0 S4 DT headers with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/dt-bindings/power/r8a779f0-sysc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/power/r8a779f0-sysc.h b/include/dt-bindings/power/r8a779f0-sysc.h
index 0ec8ad727ed..cde1536e9ed 100644
--- a/include/dt-bindings/power/r8a779f0-sysc.h
+++ b/include/dt-bindings/power/r8a779f0-sysc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
-- 
2.40.1

