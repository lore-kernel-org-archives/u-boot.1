Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A8C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 09:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB1088DF5;
	Wed, 24 Apr 2024 11:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="BEe0ycsd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A01886F2; Wed, 24 Apr 2024 11:47:11 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A259988B10
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 11:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-572250b7704so1361662a12.2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713952028; x=1714556828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZfGh4kn7Wj6e8cLJBt8y44qUaF4KW2HkU9XTQR3chU=;
 b=BEe0ycsdL14dH7e/XpGk0GgsNCHr3iFAJkbadOI2++I+46sqamXKiMUSavEpF4Lye3
 qZBtVvfdFeiWfVph2aOYnIAJlipQ4MLcPY8AtxRdc+iSTjqIqb+oBdJwpv4Mu27GyYKh
 qAU7pLZZiYey7b4gHsZInJPOxSCMW4WsUhi/VGd4NwCy/y75+JdxtduqsMn3U43xxGqk
 6jGqZ829PglcDAQ5rUQCPl5kUQ3A7SC8Mv5qvvDzkQ1+rj93EsatDUS/Xfw7opfqReSP
 p1HTpy4GIXF9gKkw11ZNUIw8rK7YrIz7ya6PLpU4ihBAWr8o/NdW+Eefs8l0gKTTZgAX
 T/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952028; x=1714556828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZfGh4kn7Wj6e8cLJBt8y44qUaF4KW2HkU9XTQR3chU=;
 b=wapjY9inHn1Vwsbidbtr5122gX3PdGfTqhkyLH4ffsXJMdlYUJ4THxraxOurYhDD2B
 gtRZJkkllpiP3L5nXK5QmN4bndPpw6mIw17UYQTI9PUnrrTGDyyrje+1IxC7qQ0RoyMr
 nWo4lbyHWv8iAlw9Pq9yk/tcIjXyhFaKXQAkJ6/MGxAqKHQ46YpbXUQ4E+cnOPMS3W5h
 83VhEpi2SUxnmqLSWW9N+wrHaua/ACPV9TnofeDHNQ6IHWegCNeXrRdbg6FWEdukENrT
 4fokAE5LSC890iu0IExQ4Hvd+IC9y4+dY5HtIIOu83DOGU0O14QY8fBuH/ZaQCh2iZ7a
 LJGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURsbN7kyV/s8bnikVEVQklnnLTQb+KhOMgW+erflhAKD5CeG8brUYtURc1OwA6utC0SP5FjItcd5791669mWq2iKYW2Q==
X-Gm-Message-State: AOJu0YyhLPj7y6nIf6pToh6ffU/3vpFv7373W+4By2ow3rb+RJoDzExn
 cyK7ABQRHPanhBEozdQr/apefKfFzU2nGnrL6tTKcSDsoBdN6JZDXkuGGAgCnSA2Qz/UZ1damxR
 h
X-Google-Smtp-Source: AGHT+IGt0oA1QZLChfzrDpUgKjprQFGyylFOGDnj7Omm9J3UpuuM5dHIdi1Ap9y4OubL4CajA5kFEA==
X-Received: by 2002:a17:906:684a:b0:a52:57ee:4464 with SMTP id
 a10-20020a170906684a00b00a5257ee4464mr1214530ejs.19.1713952028233; 
 Wed, 24 Apr 2024 02:47:08 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 lo27-20020a170906fa1b00b00a588685d769sm1274598ejb.32.2024.04.24.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:47:07 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, sjg@chromium.org, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 4/4] MAINTAINERS: IPQ40XX: add pinctrl driver
Date: Wed, 24 Apr 2024 11:46:25 +0200
Message-ID: <20240424094701.21198-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424094701.21198-1-robert.marko@sartura.hr>
References: <20240424094701.21198-1-robert.marko@sartura.hr>
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

Pinctrl drivers were moved to a dedicated directory but the entry was never
updated, so add the pinctrl-ipq4019 driver entry.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 207c8b763f..382376b8e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -343,6 +343,7 @@ F:	drivers/phy/phy-qcom-ipq4019-usb.c
 F:	drivers/spi/spi-qup.c
 F:	drivers/net/mdio-ipq4019.c
 F:	drivers/rng/msm_rng.c
+F:	drivers/pinctrl/qcom/pinctrl-ipq4019.c
 
 ARM LAYERSCAPE SFP
 M:	Sean Anderson <sean.anderson@seco.com>
-- 
2.44.0

