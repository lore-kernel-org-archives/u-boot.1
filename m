Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FF2C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B96486FB6;
	Mon, 13 Nov 2023 04:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oe9JnAxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE4087044; Mon, 13 Nov 2023 04:00:13 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB4186B0A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35aa43c92daso5804555ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844407; x=1700449207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=comWTCV1XaRZU1sd0HPXl/reLdTUpm3Fb3i9aFP3E54=;
 b=oe9JnAxIVT8yPZqAQ+Ck3MRHt0FOxPduF4+T5mkjs7vuwCILGkhLJFevMYt67fsOOB
 3iXQxlkk0Lj4EWLNZiqR8ye+vkmGmuPbcD3zzpcdTkcm63/2aTUH2Cy9ChQJvxkiRDim
 kjVzO/Ml248VI4+Lpv9PGDcHEjQHuS0/euO50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844407; x=1700449207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=comWTCV1XaRZU1sd0HPXl/reLdTUpm3Fb3i9aFP3E54=;
 b=MAMmEMgvuctmGtGKMOptATkHjLdDlj0sGA3lyuAO7C+nCeG4jdMtjSXQJEYfKaNhx1
 s/2w+TXeacZ4qKULMc/7NLZ8DxADJzChZ0yv99IVEJrDgwc7gQhTY6K6aOYyZybOae00
 /h1bc2uT9XOhkpNpgwx3DCs/7QZgkJRQYJ0eAsmgOIyL7HdggBspcZFNG2tGFn20glpe
 5l0SzIdkVxXC+UEN3qknt/p5XWEGmMWwSVjKPVMxjzcHB/4Va3/7/sDNMVNKEmhi4G+y
 9STQMOMoCSyFvL2k58Y7cWaQjRCNfF3fwv5gg5ixD66Dn4nvAIkilwnH/d+sNB2uSwJi
 E3nA==
X-Gm-Message-State: AOJu0YxVPds/T1PM/iys2ON3hI2sOhZ2O0dAW0Pzien2aAzljjbupgR/
 KIHFIurgKcf2+ilYZgmlmsd+zDgRnXysVg9HCNR2Lg==
X-Google-Smtp-Source: AGHT+IF9mAs5Si6VV7CrmuLBE4lQYBf39MxgiIKwOKnX+RF2nswg3ClueJ11nepdZHLvPSXCuSi94A==
X-Received: by 2002:a05:6e02:20ca:b0:359:33dd:f470 with SMTP id
 10-20020a056e0220ca00b0035933ddf470mr4573229ilq.3.1699844407381; 
 Sun, 12 Nov 2023 19:00:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot-amlogic@groups.io
Subject: [PATCH 2/9] meson: Use checkboard() instead of show_board_info()
Date: Sun, 12 Nov 2023 19:58:22 -0700
Message-ID: <20231113030001.240020-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

Boards can use a sysinfo driver if a particular model name is needed.
Update this board to use checkboard() directly, rather than having a
weak function laid on top of a weak function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-meson/board-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 2421acd817e4..95a29da07229 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -168,7 +168,7 @@ static unsigned int get_socinfo(void)
 	return socinfo;
 }
 
-int show_board_info(void)
+int checkboard(void)
 {
 	unsigned int socinfo;
 
-- 
2.42.0.869.gea05f2083d-goog

