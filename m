Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD187C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDA488766;
	Tue, 11 Jun 2024 22:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RqwNadX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650FF88717; Tue, 11 Jun 2024 22:02:30 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5681D8859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3737dc4a669so7070065ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136147; x=1718740947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAxnoetFX8TDGTVaRPuPszKw/VWrSDhtxAkOmQtnSM4=;
 b=RqwNadX6HgCSnmRwLl3gDM+S0+zHi2a5IogxyIEovX9ZA004kaJZog1fylywnNDbV6
 xVxrhZEErgu6Tri2B4SZQOqoJ/e49wsxWMm0rdWdnIOobilZMjweKLtIdRkWx325DNnq
 ObZgk+l/vabAMHqmYZ/uwFj+Qjaip/r1Uemvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136147; x=1718740947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAxnoetFX8TDGTVaRPuPszKw/VWrSDhtxAkOmQtnSM4=;
 b=kEzftSougWiM1kzCZyvy+8oeSxXVI9T9thqtHzVDSXJy4tuNs3NQrOCljkdzoNF9BT
 +16R3HMdPXUtGoyR406PTOTrFwGjj0O1/QcYkPxq+PQIkXxjgtj62WpyYYAQa/985kxu
 tUmo6TbBnrvK3Z2jhpV/8BhvYwjvGY/TY83Q/Us0Xu40aDKCnpqEl9WUJJESnUCHEJLk
 X6g4e0Vd3JtyabJJYYcnnFbhcBncyPPPar+mUM0ulXGSXJTf3hjbVPlNnwoVLWfFF0XJ
 M0PtgdwcNb/fpUzVPPeFPjhajYCnenW/Ks69jQqlr+3jXLomTW9v+SeYkCMlfUNxE9T8
 UCLA==
X-Gm-Message-State: AOJu0YxpQaT5t7m1leiLNbXceTS4XWk5ekcO4uxPKeopzjXddz/NJzeV
 AcenLAbWwLQlFqHspJ493t9EfzO/3O8AjWmlj0bTGHY6JiTpZE2IkvIdIJQpc6DTkTdYYTzcK32
 WtQ==
X-Google-Smtp-Source: AGHT+IG3vENbleWl0cZtzrUfnB3NknvgdJYAbwcj9PS+DW1ujaMWbb+g3MpksZxZVu/xomhxp87RxA==
X-Received: by 2002:a05:6e02:1fea:b0:375:c56b:a0fe with SMTP id
 e9e14a558f8ab-375c56ba749mr12337595ab.19.1718136146918; 
 Tue, 11 Jun 2024 13:02:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH 16/42] sunxi: Mark scp as optional
Date: Tue, 11 Jun 2024 14:01:30 -0600
Message-Id: <20240611200156.2245525-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

This binary does not prevent the system from booting. Mark it optional
so that U-Boot can be built without it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/sunxi-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index 0909a67883e..e1a9a7f5d4c 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -90,6 +90,7 @@
 					scp {
 						filename = "scp.bin";
 						missing-msg = "scp-sunxi";
+						optional;
 					};
 				};
 #endif
-- 
2.34.1

