Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED35DCAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 16:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0249A83322;
	Sun, 14 Sep 2025 18:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AO2dtyl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163FB82AE1; Sun, 14 Sep 2025 17:27:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBD980B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 17:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=osama.abdelkader@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b9a856dc2so21162045e9.0
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757863677; x=1758468477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b19F8pGAc90KZx0eJNn1dqTb/dtDyk1f6VxnA63U09U=;
 b=AO2dtyl4qTozPtiCNBkbcg18VsIak7zUdk9loHChtTOWcCsIgK/VJd5YmUQ6gZZxWZ
 rwwZCU+90m9k+iQ0iMRFJLBTi65cR+6mElpOZ6byEN/cXPKrznfzt8tiww2qgE32zSiq
 efpZ0aKHhT/3aStOsmCCQN5C16vCXArV5QCGfAWNyYvOG3bcb+4SJJlCRYU2tk+L4N/d
 Vm9H+I/YgOk7zsmQGhJ38+DAp0AH9p74trErchKGpqHKevxhNwRvBs6LDoly06P2GFgO
 q1RJbW4dZ+QdjBW11evEVuVk4EqP7+QzG8pb1d5GvnvN72/kU8yEZ95ggmL+P+SjNnu4
 oRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757863677; x=1758468477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b19F8pGAc90KZx0eJNn1dqTb/dtDyk1f6VxnA63U09U=;
 b=TyRzmN1C93+S7KkZyvqOVkZ8hDFZG9pqjs+6vTqRZx0vYk0srmPqwtyH/tKaJZ8R49
 Vjqhmb9kg10HVgdJIT3FxjHhtoWX9ngJ0f+WYtKVZOaZzNigq3Ao09Me9dAXnfx5WNxh
 3Smu1QiK6KSORC8mKSeL+o2md3M0KnBzQaVVvX/97E4fXkGgpX3avlviTRKrZ856esXu
 78UuQqSXgKlmYODafw1ZLe+BUG+FRlCv3jnHI5jXsijua2PdyYxlkciiJCBTO+nbBAcL
 fRarux2AvEHOvUBXPnPSc+GdQ88IjcUyj0ztX+5C8D/VGdb77MWRKcv+AG0H8Brjqo+E
 UyDg==
X-Gm-Message-State: AOJu0YzthJh7M11fAHt1OUlttCC6oh9Xq4Fw2cwCcyqvF5aqm+DwtcJF
 9ZoQiN48t4NiRaYtG3ktpnWEt2qU9/67zMqNZUe2dYkmdbFqJTOHVV9aID+BeA==
X-Gm-Gg: ASbGncvnRvpUq98P1NJtyXC4Qzi1vnwExPzjfib4cPMSaV/Uk7a3N2pxSZVSjs1cVoV
 aL/dSAkF6UDJ0tl6wsy4uP/bIPyv8VGcBeBKwxavAY6dielY/dMUxUgNZ/zvSHzH62CqSRuD229
 jq7KNMttryGZzp1pTpwItzfJe7+6wg0UItdtRaGSR4rVAHVCVdxLqG6lvRImPAQh3ysiQRREZx2
 Iq37XIM2CLs5+O/15wrBHvOCgWaBJUcY7enWYUOcs6RwxNK0a3VC2dJbrsxKUe7gniDhUWUuGTf
 XNNWSxVJ5C5CIbU03El/Q2coDW/F9qQSIMKjo9USrFLxdUJwSG3g3TrdpzEdd0Ojo2PqBKeiJLi
 aVLBHrmKna+WnM0cYqAx7EURxiILA2gX2tC7/RDKE7/H9qKNbFgpeMGoH/79D4Z8kRKS5CvMQp3
 oFfpo=
X-Google-Smtp-Source: AGHT+IGAPGdPWaNzX3+sntdve864iEsEavDipfDZp+dS4DfMPhJ/KysQZp2Q8Wmnrru0WJwNpOQcmg==
X-Received: by 2002:adf:8bd9:0:b0:3ea:2ed6:9e35 with SMTP id
 ffacd0b85a97d-3ea2ed6a0f2mr1118641f8f.60.1757863676618; 
 Sun, 14 Sep 2025 08:27:56 -0700 (PDT)
Received: from osama.. ([156.223.20.4]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e9a066366fsm3374396f8f.44.2025.09.14.08.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 08:27:56 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] imls: remove return parentheses
Date: Sun, 14 Sep 2025 17:27:51 +0200
Message-ID: <20250914152751.784312-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 18:04:42 +0200
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

return is not a function, parentheses are not required

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 cmd/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/bootm.c b/cmd/bootm.c
index bee683d0580..2c5aea26d98 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -572,7 +572,7 @@ static int do_imls(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (ret_nand)
 		return ret_nand;
 
-	return (0);
+	return 0;
 }
 
 U_BOOT_CMD(
-- 
2.43.0

