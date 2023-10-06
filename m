Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CD8E9412E
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 21:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FB286EA9;
	Fri,  6 Oct 2023 23:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QP1+WOUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7C686CCE; Fri,  6 Oct 2023 20:33:35 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0131D86BDF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 20:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monakov.y@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50308217223so3017292e87.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696617213; x=1697222013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4cm6glvfKr8qH5JtTSB6xIhlENd96WvUYy2y8DsZ4Ck=;
 b=QP1+WOUEb/xNmnBJ5QJq/l34PpcQu/ilEBKcEAYb9JceSiEeBBd9PN+hDGHQ+DjlNR
 Vynnma+M5KqYqke5099QTNG0UEI8ZBzpcxidwHm8ksJS1E+x1yYV4EYxjTVcfnpM4ktv
 QvU6dxyEHyeSXR6wS/ibM9OpKFk428g5kGIFP4odYLKzyckfz9tYYC71pJaZD1JrGy1a
 R5Zd0/78opCgefGJe3zKxfeAg64Ne0b9cgGVTR1d5vjDL/aHEQNxlDWFzq1N8iFqOpdt
 6LCzUdha/IpNy4vjvgm5/eF7cO4bu1gs0NWvS26kEW2nxo6/4+9m6yET+PaL4xfZa9lo
 0P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696617213; x=1697222013;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4cm6glvfKr8qH5JtTSB6xIhlENd96WvUYy2y8DsZ4Ck=;
 b=rg0qJf1ZXYxJ1JUp2H+fhPQuHe7ZzEMCNvWJCX8GeGdmPQxFyBOo/8NxEEP8mRDWNK
 s8ls6WMHwRfv59KLSoyxig0vOdaXWpjacwz5f/E3niMAInUV2ABSgdoy6DURi8+dS6cA
 nhWWffk+sZ5XX1oFE8+/wAU3plwtVphw4BZshFyMUmfiGYuURMY5rHuv27oqB1ey2a7E
 B5KtHLJwYPIwatIUMQE8SDdEUEG00ffiOyP3wW6IgIenkEnAgDj0m7X8L+46YSXaCz9l
 kJSmGRYHAa+P0sr6Co82+pR2npmpOz4Gvm6VqSnwm4kmv/+2qvURFB0+0+aK2tlbVwvl
 cLjA==
X-Gm-Message-State: AOJu0YyB7TiEVOrOAed4VRWA6CiSUdfW75W2/bIIx9PO3a2s84Z/Zl4F
 xYdSzs2BDbaHC4jYhHdMwCpCKac4Slcv8w==
X-Google-Smtp-Source: AGHT+IHVHKxDY2FZVN661tEyIHuar2aVklPvzoLYRy8qcGqL4GHeP79oBnroEWHJ6xaARasFzpYP9A==
X-Received: by 2002:a05:6512:3144:b0:502:d5b0:436e with SMTP id
 s4-20020a056512314400b00502d5b0436emr7201019lfi.62.1696617212400; 
 Fri, 06 Oct 2023 11:33:32 -0700 (PDT)
Received: from monakov-desktop ([92.62.56.106])
 by smtp.gmail.com with ESMTPSA id
 y5-20020ac24465000000b005041e5050e1sm395555lfl.147.2023.10.06.11.33.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 11:33:32 -0700 (PDT)
Date: Fri, 6 Oct 2023 21:33:29 +0300
From: Yurii Monakov <monakov.y@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cli: Consume invalid escape sequences early
Message-ID: <20231006213329.03aad5f5@monakov-desktop>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 06 Oct 2023 23:32:20 +0200
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

This commit fixes some issues with extra 'Esc' keys entered by user:

1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
=>
nknown command 'ry 'help'
=>
2. Sequence <Esc><p><r><i><Enter> gives:
=> ri
Unknown command 'ri' - try 'help'
=>
3. Extra 'Esc' key presses break backspace functionality.

Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
---
 common/cli_getch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/cli_getch.c b/common/cli_getch.c
index 61d4cb261b..0ee7908777 100644
--- a/common/cli_getch.c
+++ b/common/cli_getch.c
@@ -46,6 +46,8 @@ static int cli_ch_esc(struct cli_ch_state *cch, int ichar,
 	case 1:
 		if (ichar == '[' || ichar == 'O')
 			act = ESC_SAVE;
+		else
+			act = ESC_CONVERTED;
 		break;
 	case 2:
 		switch (ichar) {
-- 
2.34.1

