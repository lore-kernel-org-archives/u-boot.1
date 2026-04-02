Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3274D6AAE7
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB4B84132;
	Thu,  2 Apr 2026 17:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKbmhEfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA0784020; Thu,  2 Apr 2026 17:29:05 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A0B8408D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8cfc5941028so180534785a.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143740; x=1775748540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+Xbjk7F5jiYZOpED3P/2VAc89G/ssZFPE2ArW137EY=;
 b=WKbmhEfbc/wt9Frxf9rPLaZJXPxshWCbi2Aou1mtVBhpkODqqpxoaeAYL0YxpedVd4
 3vpzPuClynpQshaWngJeMw7AYbIZs7xnb+kGCXAe/HEjPs342fGaZZQIk0ofAnP6HSnR
 +gnlJHTh8RfJinziNHhqGZjOqSnQ35y1aiyjhx3+YbZeqtDkVwXG/UaXyKPkup4DmOZ2
 8LVovZSBDQMdPyD28s77F6pimJQ9iHU4GYtHtnfRNVD7F2ug3UfGsjSdNDl1YEYzO08I
 zBGzlOYSXd2DWdZPCQgNI9833MGfWPAP++9xSTgzxbFwmipqm/Dn3nSAY7Z0yn3MoFym
 PA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143740; x=1775748540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+Xbjk7F5jiYZOpED3P/2VAc89G/ssZFPE2ArW137EY=;
 b=O2VpnjKpJaHQtcD5QO8QA2co1KLZLPu0U7K/2QS4NhJYyX0X5Am5rLDOsN9Mjo+8F7
 IzVFg9i2XYXiyVK6a5NquuiyEENvFweQMjvS01ZMVPSr5cO1WPjNNefl1sCvLpBU4LEd
 9RpEastM8+IcNh6odldQ9gw8qNusxp7wTx2vrdrfZt99n8EiYUt0eHDqIZzaDBWlx4Qa
 NgJFOytgOOT9TyWO9mo6m1U829D6GpEfSdyayeIMrS/v0g4MveenUrDLGihq1G9HDHDi
 oWDa2g8PL6iA6fESs8Mj5Yl/sRMznpsr5ggsxnCqAqR7rHHWgDKEwl1A6aPbFHJU5zDO
 gK+Q==
X-Gm-Message-State: AOJu0YzWmE3l2MYRGfO8A0DEo2Lv+B7PNnzF8053ctZj4FoHB2fPt7av
 Q9+3dOsLnGJkSX45f9RoyDtpOo5wBXMqm5QwicRCA12gIcLW+UZDICK+PlYOC2tb
X-Gm-Gg: ATEYQzxqUWR9xDAN36S9XMysqLn4C9i7+LZsYKfMJay9MODKYkSHnxWFSPbxXRL5yqY
 1NBKjkt8Tx0HSDDr/xJTF9SlEd5yPX2vQ4VddjynpSqFfsyDOEFhbdkk/cfoUbaXaOAPNjFBmcE
 rZtD4SGvfCfnqp3TrKtqJMTjs/db4smBYNMjAKyT3bhv2GwPta/ekFgF4X0VJt9Z7SYtZ6bOVfL
 XoBQdU9YzhnCekDYx6ydgQZBhE1FImDGKOhc+daCP9OAkFeSQTyOu92LT8LbFBYwK3BfyTeRfNT
 gR9e7zWpCW4CO4NMv8h8Os3EonpcIMCo1ZhHRvF1/e5sL253B0GAX4rNnOER7xYvSt05yztKVAC
 H7uQ/UmhSUVm3m1t470ufJgATmcjhUk6pYLMUJMiFYdVdv1KNhGfTdcbsYIGbSGcXShl+Eh8yYM
 rUbiU+OxD4JvoZrqgpZllWREGUO1p+jVGyrA==
X-Received: by 2002:a05:620a:4454:b0:8cf:e208:eea6 with SMTP id
 af79cd13be357-8d1b5c18020mr1175690985a.65.1775143739887; 
 Thu, 02 Apr 2026 08:28:59 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:28:59 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v2 07/13] dts: sc594: Fix gige-reset line on EZKIT
Date: Thu,  2 Apr 2026 11:28:30 -0400
Message-Id: <640a8f1a9389af1ffeb4dbd946cdf316550099e3.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index afc16df577a..422dab9ff50 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

