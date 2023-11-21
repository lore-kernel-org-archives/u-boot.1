Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43488C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2912875B2;
	Tue, 21 Nov 2023 03:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D7uejOV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D068759F; Tue, 21 Nov 2023 03:09:47 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4F387584
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1f5b92bba54so1607105fac.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700532579; x=1701137379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jD17SbTP8SOv5pdeKmShDQP4s0JCH5JnAoRbk4oQFvY=;
 b=D7uejOV3awljXuplULMmvo46nO3M/PRw9iUFqC1j+pK731rAjwLlEdPBmpIgPzdCo/
 iYT47SWuv9Pl5ZDBayFkmlV8W6A0QJpkRULctolJIRYFCBjgsSsNzVHr5yYHQkc8Ji+A
 pOX2CL9FV4mdSp5NWm9Fwtzj9AUsZVQm4BMYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700532579; x=1701137379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jD17SbTP8SOv5pdeKmShDQP4s0JCH5JnAoRbk4oQFvY=;
 b=lIvVz1F3HPgM6IsdEuGs40aBgTOB+V0kqSiPZ+VTlTJb6TcKsPH68XASl5gPfVe6mH
 4htnMSTbb2GVYzKZtEBtZ8iEBg8EPZlhF8hYmbGjXEWuFp4EsFKFcU7mzVALzDc4CSPu
 GJQUe/wDeR7AcWrV3tWZ877kHkkWP+7BBBvR9FIDNDTbESQ2+SWMwvDvD0I/UBklvOYu
 uU6giEX9/MVEryioaADkAl1ZrD7aZ8yxPSnVUy7/Q1Uy0OWlOfG+Z5kIN7hsJMmLjKa+
 rYZe/XzWh02vjadvgMbRkfmG5kNQa82Kqn+KjzuNyqYwNDU617G2cre8XzlLg76qKRaq
 twCQ==
X-Gm-Message-State: AOJu0Ywsf4eebW4Croa29+GCK6LO3L3x592NI+gnOn3xcL0xPMALa6zw
 J88WN9KKpLzwzjxiVDpbmXqwODspYrwhIQYNmTQO6w==
X-Google-Smtp-Source: AGHT+IF/z566dLGcx9AIhAnpmHmF3g4lH5zO8wnehcfdezQalF2t10xDA471zzQB0uEuHc2LzMX7tw==
X-Received: by 2002:a05:6870:d90b:b0:1e9:88a0:a67f with SMTP id
 gq11-20020a056870d90b00b001e988a0a67fmr652426oab.23.1700532579606; 
 Mon, 20 Nov 2023 18:09:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 du20-20020a0568716e1400b001e12f685592sm1542693oac.13.2023.11.20.18.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 18:09:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2 4/5] sandbox: Increase cyclic CPU-time limit
Date: Mon, 20 Nov 2023 19:09:28 -0700
Message-ID: <20231121020932.733405-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121020932.733405-1-sjg@chromium.org>
References: <20231121020932.733405-1-sjg@chromium.org>
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

Now that sandbox is using cyclic for video, it trips the 1us time
limit. Updating the sandbox display often takes 20ms or more.

Increase the limit to 100ms to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 5906a4af7c33..f3f6f495adfb 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -636,6 +636,7 @@ config SPL_CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
+	default 100000 if SANDBOX  # sandbox video is quite slow
 	default 1000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
-- 
2.43.0.rc1.413.gea7ed67945-goog

