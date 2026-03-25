Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F80109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D923E83FC6;
	Wed, 25 Mar 2026 17:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VWMpVaPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12AA28408D; Wed, 25 Mar 2026 17:55:51 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E537A83DA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4673790ab85so3006858b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457747; x=1775062547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRtZGQ9Tiyv0MwLF/Z4HR33frbI32o5MX3Vlk6IoykY=;
 b=VWMpVaPP+7nNe/zvrCnNTmW4YjWlinyZ1l16mN3BbTC1f3IFLp79VnPpbYvT0Ct6ZT
 o0KeVAoBDkyHISboP4h23v7scxz5gas/b269YIq+aiypUp/XyjJfBiKti66vp70f5LrA
 WQU/QqPJ04LZeTgI9VpgznClZldAJGhjlH9ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457747; x=1775062547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRtZGQ9Tiyv0MwLF/Z4HR33frbI32o5MX3Vlk6IoykY=;
 b=Se+YfiH58ugLVI0IeSJiSdQITd0RHq3s76hnwVYeiLU9GJ6GdceBEOc0/Yiqbt6jY/
 /nKt84swgrvhGgQmfVyuDt3Kng4QFT6ELZODXm5vkprsk9JRBnMu+Z/2e6RLTvo7q78Q
 RZJt5Any4OLuCB5nsZtsCygiS3by3c9iF0nav9UGmSQHZAdHjgsY51Qml0tgf1zhhwha
 /CVOWbHflgVOZLWPVl9XxJNY3OaunWEHJnQ9A/Mo8VdPp9rBiceNDUemu8C7UUU0DsQ9
 h6ojbpKlb8VNPbkoQ09KAnyr7ubQkJztsYXgTCb4I/aoB0Q22DGiVLe0gT2uqGxJU3cB
 sKdQ==
X-Gm-Message-State: AOJu0YxZgzdd5KLXILhqIejxyd9b9FEBKp/koLSCbmrGU71CHBwn5/FC
 36b7fZxt4VzNO6cTnSa31Bgfe7sLhtG1hhxpYVvdl5d3DAFf5Yn1rllEnHBjldyQ7rr3uPpeC13
 ijf8SNQ==
X-Gm-Gg: ATEYQzyoCyY0VCoQ96Am2kXplTWIsIoFhFUUXMHJFPsv8jJUAAvyDdcx/IfL9dlmAUj
 92xBTPDReX32RZhCnX6BnYyZNf3lV0v0fpQSAvQWYLzdssEY+Izd+SFPV0hWkCzp1utNyRz7zIz
 OiJmJduFsl8Qdwpc4AOMGOI436tom5gEyTWqlOx7E4zKf+p3V7zkuleSoM0UbDsoTb0IPUpUDoS
 rDBoJxiKIgDZJhuz+0sR6sXcx1/VFlWVAcL3gMYHaj8dKAylUYJ3Goje5Zb3/1j9NMYVE8VVVzc
 A5nwzZ+DkUoLQx05uDBSoPpsVarjj1/bD0qlesuKbzUQmL6qHyaZ9wa0ol6RSIUPIlMF6tXLlmd
 5doU5CEBoKjGuHT4lio+TF3Uox5pDMoDuZ0HxBOuzhll7W5Hk8PeD4l3iD7AbknsUUlqOVRitSS
 dm/JjGRAwSv10n4yV58w==
X-Received: by 2002:a05:6808:1b89:b0:467:f150:afbc with SMTP id
 5614622812f47-46a5c59d6ddmr1934512b6e.6.1774457747065; 
 Wed, 25 Mar 2026 09:55:47 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/13] boot: Move the architecture check into check_allowed()
Date: Wed, 25 Mar 2026 10:54:17 -0600
Message-ID: <20260325165431.1027591-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We may as well have all the checks together, so move the call to
fit_image_check_target_arch() into check_allowed().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ba8a56a8ff4..0a880863063 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2194,6 +2194,15 @@ static int check_allowed(const void *fit, int noffset,
 	bool type_ok, os_ok;
 	uint8_t os;
 
+	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
+	if (!tools_build() && IS_ENABLED(CONFIG_SANDBOX)) {
+		if (!fit_image_check_target_arch(fit, noffset)) {
+			puts("Unsupported Architecture\n");
+			bootstage_error(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
+			return -ENOEXEC;
+		}
+	}
+
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL);
 	type_ok = fit_image_check_type(fit, noffset, image_type) ||
 		  fit_image_check_type(fit, noffset, IH_TYPE_FIRMWARE) ||
@@ -2379,15 +2388,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (noffset < 0)
 		return noffset;
 
-	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
-	if (!tools_build() && IS_ENABLED(CONFIG_SANDBOX)) {
-		if (!fit_image_check_target_arch(fit, noffset)) {
-			puts("Unsupported Architecture\n");
-			bootstage_error(bootstage_id + BOOTSTAGE_SUB_CHECK_ARCH);
-			return -ENOEXEC;
-		}
-	}
-
 	ret = check_allowed(fit, noffset, image_type, arch, bootstage_id);
 	if (ret)
 		return ret;
-- 
2.43.0

