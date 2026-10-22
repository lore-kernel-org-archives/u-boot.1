Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77502606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tsWkfPrY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Su043TI9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43B5060877;
	Thu, 22 Oct 2026 07:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2OvbXt8v8W6; Thu, 22 Oct 2026 07:09:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2621608D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652967;
	b=mTQ0PJZsh+VGAvbuOIfXFIlzwtd5UhB1OhAma/FQ7euK3txAusszipH88tIi/KSKRsJG
	 uBCDOlZw7Z1yMfd8TIvZhsrIMCjr5PiqcRvAZSW+MYqRPSxkwmC+gwZAAuLksi20Pdh3D
	 hTHrcfAoSWpzOvh/h23bmHRwpY8Acpd2pb/oz805AX3a9ncM/AAdrb3w9xcFngeL5t15w
	 dsRFBZJm6fxtya5OJex/krc67Plfmbhzd6dMT032ksHYI1UtAqnse8XQ0l8U3c6v/Vcjn
	 RVYhaS7VvZtRjDUUaWsMS5pYZryqZqq0lLaGbbzTDPkIrm2fecYUXSoTnPyf6B9gDQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lbPw9e0pzqva7lJUQdzLuNWTu+ObsSwxvuNNNW3vNP4=;
	b=CYIoFNxCAVXPEMo0qEy9B/qb/z7yz62zA1AwTO5mfdijj7f+NR7tYtSVFAazHoIzaVIh
	 W2KraiuHp2maRPnINv2KJoII+sCzC04UxsNb51d9g9r/wpeNWZjZKk9s50L1waB0iGiNI
	 6tmuanGb/oaLR4qGM5O2oBFHboDLiaVD5bsaVYh3ZnedotPlm0lO8qe/i0ZCrHrh5YyMN
	 3/h5Wty7Oj7Zpo+HB6kscVizDdPsDEh1dd1jQXChK3hblB4dyLxRZsmVMLHeJW1IrKQqY
	 /ki69BvwIqhYWZ99zMykT8WQJUIJx3J1dJXrFLLhujBNfJtUjlZEKEYyx28cWaJrsXw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652967;
	bh=lbPw9e0pzqva7lJUQdzLuNWTu+ObsSwxvuNNNW3vNP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsWkfPrYPX7hABilMGbN7/n97iSHZnR57iX04gRLRFZxSZCTzBqCucYmUUVSJ1VIu
	 Bl1Xf4FU/mGYqED0RgGvFyB2Veq1oFOPARrLFbqNbFYAkzkzhNLB8k02NHVFurwLqP
	 Fuh4iuER5xyWgpsHT4L/Z0BzDbPoLBEQxGd8yM48r+8JdNHHdrpyOLsLB82xsb/yb7
	 cSOARLcXpIaO5dB1FxdMnn13XDc2oWn1cqRIjTfk+Pz7I5UUkZs/3WDv5Uufmjou2A
	 zYZafOikJh6RLkopj/Y9xLmclmrZPMT70DdjDHVqSqWqnpUKVvvYLEixsA1rbfejUW
	 SfnM7iK3EnT3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2621608D4;
	Thu, 22 Oct 2026 07:09:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D97CD3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB826407FC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBaPDVVhTUTV for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 046E2406E6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652953;
 b=M8SlpYGSEokVTzsoUKUUpynGH0/gvWxwAtcMlie578jxFi1M+OELL1ME++SjTBPPWAC2
 BQXOwOsCNhE7wnz5aBg163RTbIF8B1rGu0ecnuAt2nOU38EldhnXvhWK8bB2SIgTwOCqB
 Xi/8sirxti78isaIxKo+ivvHrCveF5j3jAR7sgl7f2xCtSP4WlVde6QWOwdD5+P24lh6i
 bNSHIEOW0uvKRCMDzpVaiGBEtI75BiUKNf4nhFtUbSywUzveL1vZhcuy6oLzFU7aEyUR9
 3pQPrMvL5yPzcLmMciSCvDyPnReenrMkW4BBwjh8VG2oqy9B26gKd8gFSM0tErP8mjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lbPw9e0pzqva7lJUQdzLuNWTu+ObsSwxvuNNNW3vNP4=;
 b=Spq0YMYw71pnyyDAl7KCZefa0bi7rEAVg+V6smEdGxQrdW5vnavrcPyxxADsCF1Aveal
 vRRKf6qZGkqbOAZ6wy7uyov+5oRB+TJnHXbef/cIZpTy6kAeZ7mZU5tkX7aRlOTln8oCU
 5n7s6uJK/xAt6dvpNQKydEebEchdOXIORm+ge16Zp+YOjBMHqYnAzdMSVcJld3Uwr2JA+
 Z2FyaM+3nsYljHXpJem8xtjnRweT3Pj0yfopKpESpTb4z81R6H55LaIPq2egjQabafSBx
 Ymp8ZjFuQCikBLTUKhCWKERMlREQReGPcQdK/hKg3CdlZ/GZNE2Ybv8nFYMGQOeujBA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Su043TI9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Su043TI9
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 046E2406E6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:12 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so992651f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652951; x=1793257751;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbPw9e0pzqva7lJUQdzLuNWTu+ObsSwxvuNNNW3vNP4=;
 b=Su043TI9+b4+PKdgwBA4/SWoEo6Ala3ltkGbK0MNwVWp+sdSVXVvDsU2Ekr53c0MDD
 e2qV8r+a0HLDvPTczRCq9nu3twWMa4BhY5tq9+Kk76x+4t8ZLjKxEoEyYcojk3TI3Zw9
 tnjpHPnvXrp7rAl1sSDgKssui85GYSfeNyxK4ac0qSf8Vl3VmxCILJJDTD2XEgCSsSFv
 Q8OuSRaExSaBKCoCMAsMhcR7OhSolGlDCn3RI//fl3IPIFCCS1me5StYf1hmG10gIk5K
 5kbercvKp6YBH6jvSxm7RPHx8CXnsOiHfaZp6hAkpb+GFHPn/FS4r4res6gMfN8ZGfET
 ztHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652951; x=1793257751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lbPw9e0pzqva7lJUQdzLuNWTu+ObsSwxvuNNNW3vNP4=;
 b=H82/IflPwgrDVP8Q4IYN+NuKAtmtpqYe+KzQIFvLgO1nU5E9CJM5B1k7khyL6TOCm/
 JPvxrf+1+Vm6bghPJDnvBYDOhYUVybfvjP/jNi+AgTJRXMMx1HFg2kUR4tHuNyVHy7ge
 i/NVYIJDJpC/Vl3HhWcaLYgan+bob9muHGNtqi+No/4TsqIUZFARR64ecCbq87QzlOaT
 O9prmWc64icwj+1LirBXxEEvNUJLJFtDtIH/fC/ijq/RHcO9YNSXTTxBiOKKM1Omsobk
 7OnsOsKKNKYfDXBpW9bdx528I6w5BUetvKkIyrbSY5yezS19O68Y8ER0Kd7CaNVi0Q0s
 l2YA==
X-Forwarded-Encrypted: i=1;
 AKwUvByY676hgZi+2olrCaq+Lc1WRgToRIJQfqJeYEXOVusc1CDpLw58cQi8nvJqyCQnl1vhys2Bxvw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7sVSJAYaWiGpSmiwdqAj18/0rL0qxnYIo8u2oaxIZeI0/0KHt
 lQbEQlESHTmET+VWO2MdgU2NsTQwuOuIPLf847YO41RhZKK8MgvptgOX
X-Gm-Gg: AYBFou0x930tpD4v3pT2zlH9LTTU4/Rc9Vgg7sw3RU6vcXHU5nxmJanI6vdxZJnJL7+
 mOI41BOBGkRR9tOfVWHeexwE+/X83apA7jaMSE6tEimTcyDE7HyQyukBCl6sMhlOgpSni8rtRq7
 ojtM2TMFyEubYDwHTtlrBjKZaQjxJYXXapM8cwAyVul/UoJD6elDnxuHqLA/hzKnTA93eL6rt0m
 wfsBl/dPvKJQ4aT5hx0l8XK2lAbhLn1Ott7mgiv6GblUash+k79N2SoKssLZkHRoSQEyecg/Z6A
 WnxRNFSPPlTt6zwtaCaiHEq/ANGxy/o/TzouuLN2TjLnfEFrsSgA5a1Muakc9/TqDLvsqo/QXtC
 Va0WTIoajscpRc3yASA3nhLsOsZgTKEUfy8i1eTRzulScAbrGV6tChqMMXfMB7FumI+G3MdoNb1
 ZrWuuH3wHxyaHhNbUoJF+qcaHE3dZC8DsSOfB+EeNurOMtVZ3XUW+AIXGFCBMkSn4b/+chXzZ2d
 fZh2xPF14YOYKR+7Jg4G3x5kgbU50iPIyyNEJQAHOjHp1qvqTaiI/DJy0ihgQ==
X-Received: by 2002:adf:edcd:0:b0:488:5852:6ee3 with SMTP id
 ffacd0b85a97d-48e264f18f8mr7403500f8f.34.1792652950778; 
 Thu, 22 Oct 2026 00:09:10 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:10 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 09/10] usb: ehci-vf: sort the includes
Date: Thu, 22 Oct 2026 09:08:59 +0200
Message-ID: <20261022070900.616265-10-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Put the includes in the order the coding style asks for: the top-level
headers, then the ones in subdirectories, each in alphabetical order.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v8:
    - new patch, from Marek's review of the vbus patch in v7

 drivers/usb/host/ehci-vf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index d2263a1224f..81f76ddb1ba 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -7,20 +7,20 @@
  */
 
 #include <dm.h>
+#include <errno.h>
 #include <log.h>
 #include <usb.h>
-#include <errno.h>
-#include <linux/compiler.h>
-#include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx-regs.h>
 #include <asm/arch/crm_regs.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/regs-usbphy.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
-#include <usb/ehci-ci.h>
 #include <linux/usb/otg.h>
+#include <usb/ehci-ci.h>
 
 #include "ehci.h"
 
-- 
2.55.0

