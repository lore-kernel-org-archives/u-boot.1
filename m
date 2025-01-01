Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F624E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696CC8072F;
	Wed,  1 Jan 2025 23:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tfme7h3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F377C80708; Wed,  1 Jan 2025 23:23:41 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6124380758
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21680814d42so126329105ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770216; x=1736375016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlwBg+ehlwFpHgReYRiNGGLwxih/br4Pd3S6ahuFJK4=;
 b=Tfme7h3aPnbaVMTxfUuv1pG7jfcXRhpP/MSc+s2B49xsTHd/iC3w6eA9APLZlfWhhr
 Px5RpHaRMJwyB3mkOXlXIWMPxbxGnlxEVPZ0QXwzFLPcRX1/eRqJifQcN7373ysvChZf
 kDwUOcXQd/jFuB2tFZwjdvDu3cpEObHo46244=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770216; x=1736375016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlwBg+ehlwFpHgReYRiNGGLwxih/br4Pd3S6ahuFJK4=;
 b=Zu0frCrSM13TB/WoRRXNucIAkY1pP3L6k9J3Me7sOScLqp8LDyW+472fa6XyLARCmE
 NpwMKn577m0wcvwqcFugHfopmLnllHcgqj68VqhWK9osdO2iNo/7ihkPOi8oFauTl9Pl
 fqnINBCIr/lXlP5sWiiSLK7euMoZEMjFfNV1Ny6ajtRdOCmmMLM3VxQmLHcJCAFA4irm
 oDGsbW98cXrgxoFlVnheg+dlWRvGdPnOUMOOCOLy4+6VoQ+/a3LSDGLR4+WbUh9WwJuq
 IAl5aEBrJp5ZAcwK9aOa9fCaqlzGyNzu9VMbacFGwHdYqEnxaSvWf8jO7yjW3nSqtUDu
 JJaw==
X-Gm-Message-State: AOJu0YwVzTOnn/zSfwcP7pUtyBplukU1Y5Ag0JnGwF9h8NbX7zW9rJ5V
 +X1c/ZU9MdLFpYekXK7T93nOWNYQzVdRXqYQHcuKXf+PW5SG9QIanBbOGNn4H13lmbUrO3Io6/4
 =
X-Gm-Gg: ASbGncv/CyOgskdIyKCsu415U3CW5tl89kGxLChaJ2UwJUdIu4a71kZTyBIvCpLDmxv
 tnlIRx2TCGuY8770GgPCG5qTj3k9IhjXCKsIS6FXWS6kKn+hUjonaUAgASrCmW+fgCf1pnHGsoi
 8kXKsIWsPmdJyLR856ud1zlKNsv9K8t/RmYkkcUYFKmFqI8uO2iUe2OJom65QeCDpwwsEDnex1r
 AFVGMM30R3tOXVMxZD30N5ndNVAtYjot4eP+17sPiPciOuIHP2OiC8=
X-Google-Smtp-Source: AGHT+IGI7UaVRaxo8v9SwU5OkoOgcsWNLV/2zzd5O0++jTPYcJZwIdKpQyzhUyBA/xiDHQ35Flz48w==
X-Received: by 2002:a05:6a21:3a4b:b0:1e1:aba4:20ab with SMTP id
 adf61e73a8af0-1e5e044fc45mr61965720637.5.1735770216417; 
 Wed, 01 Jan 2025 14:23:36 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 67/67] upl: Add an 'addr' property for Tianocore
Date: Thu,  2 Jan 2025 11:09:53 +1300
Message-ID: <20250101221003.1944600-68-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Tianocore expects this property to specify the entry address. Add it
until it can be updated to follow the spec in this area, i.e. use an
'entry' property in the relevant upl-image node.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 5db5d02e6e8..a9d25f607fe 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -307,6 +307,12 @@ static int add_upl_images(const struct upl *upl, ofnode options)
 						  img->description);
 		if (ret)
 			return log_msg_ret("sim", ret);
+
+		/* temporary hack for Tinaocore, until March 2025 */
+		ret = write_addr(upl, node, "addr", upl->fit.base);
+		if (ret < 0)
+			return log_msg_ret("uma", ret);
+
 	}
 
 	return 0;
-- 
2.43.0

