Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6554ED3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992F989247;
	Fri, 18 Oct 2024 01:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B/iGoe3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64117891E5; Fri, 18 Oct 2024 01:24:58 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 374CF891EA
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a3a5cd2a3bso6462245ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207495; x=1729812295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=je2QVr+9pAnxvTYzRFUaCNGdjDt7qOjC/2e464a0p5Q=;
 b=B/iGoe3ktLBj2OZ60l9GkoWC63WA/YKyJwLDFZ49IIBMahBbjRHMM4gDEPyuVtOBsQ
 iJIEkRURoqH8T6S4DiiNzZ7rPGXv5pfnQAYp+HqGlPoNcD4y71f3aaCbsPibxOESP/n1
 Zx95k+JG1EgnLf5LDDWdQlGqTbv+p047crtyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207495; x=1729812295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=je2QVr+9pAnxvTYzRFUaCNGdjDt7qOjC/2e464a0p5Q=;
 b=QQ0ZDa4i6uFj+Y4IraQdUx67SINGIWDEEQcM0npJYo424yznZRd68a5gnbrEbs1Eyj
 WCW+oHUJpfSFZoU4mbMbY5tPr0+72R20N52NNhtGJjsH0m4dyY7nlESvPx0GY2yw/8gF
 JObKSJ8p7F96qmeFu6w3/pg5+p7KFcOWKVlBiv0BbedFlJmmrNbmOSfK1BDk8WzS/UPe
 DWLtv8nEWNavCzUryh78nRvPDOAqmiWGRYTgzRNWq0I9RDIhQ2DWAjblO2yDysT5cYwE
 TYpDnsj1pkf56f2kYEJN56T9jnkdUEpxw6bkU+ZQ8lgd14/1bJxRX+7edv76pNtvEKu3
 jLig==
X-Gm-Message-State: AOJu0YxfKgmYDuALL+GJVBklPYIHRMELDccu7Vm+cK5TuZtDgr1PnVD9
 l3thlz3otXsSevA2ZQIX8vb0hEDbZXcc5xNywu5DpMkxVGU+Hg1hyLAvJoAJjT94QC2fzhURc4w
 =
X-Google-Smtp-Source: AGHT+IEl2xLjdhYzFb7VoBGtEzpZlQBPwxDxaX35gPoJXXiqAfzJHB5wuXtpFRnNTwbFkO4tO2/TUQ==
X-Received: by 2002:a92:c56f:0:b0:3a3:b439:5d09 with SMTP id
 e9e14a558f8ab-3a3f4060aabmr4629115ab.11.1729207494882; 
 Thu, 17 Oct 2024 16:24:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 15/34] image: Add a new type for extlinux
Date: Thu, 17 Oct 2024 17:23:54 -0600
Message-Id: <20241017232413.724808-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Add an image type for the extlinux.cfg file, which U-Boot supports
reading.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index abac254e026..cf16fb7fbf7 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
 	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
 	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
+	{	IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index c52fced9b40..606e7d49169 100644
--- a/include/image.h
+++ b/include/image.h
@@ -232,6 +232,7 @@ enum image_type_t {
 	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a Legacy Image */
 	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
 	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
+	IH_TYPE_EXTLINUX_CFG,		/* extlinux configuration-file */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
-- 
2.34.1

