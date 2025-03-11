Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C59C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06362807D7;
	Tue, 11 Mar 2025 13:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NRfrYqsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F025816AF; Tue, 11 Mar 2025 13:31:38 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A59D80F92
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so5173644f8f.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741696296; x=1742301096; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lg1GCr+aaE0AevH9o1zlxGBN+hCKIdxCsPW+0VbAXUo=;
 b=NRfrYqsFTnvR+2q9aJsfG1MlRKLKXWBg5Lp30Mb2vb2j5bIRClV89VcPBNWtFFMgat
 IlkhOmJomdDEaiyhBtKR98n/HqO9Tzr90CdDuBWUT6T6gCM2pOLpq1fLGnNZ1VwyB3Ve
 n4RnJbXHgf35rIpOjUPp9PEwSlHA91EMKE/4ncyHEswlLevdV7YoWH/RxuPDBoi/KI6o
 MRbrvDmAUD6g0FBOn+sWkXO/oejDCHM4NYRl1E0u88AaawXGtUWFmlh44pIEpMYjeriz
 ROKwOt0yB1q1f/5Ta+AKz+GgCX5OPJV0hK5bcd25effYI0LWdmrxD3NLyTEqlN1yMz8s
 WnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741696296; x=1742301096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lg1GCr+aaE0AevH9o1zlxGBN+hCKIdxCsPW+0VbAXUo=;
 b=JDzn/RwflTrUI/ujJlnhxUSBqYB6y+gMU0uHRWl+RiJUiWASr07AmtffbVxYqn3qH3
 qMvtN9lIEpA77HI5vtjw0LfDHWQqjlzzFbJoZK4z6BmUF9tT9LaATg/XpR7ev7jROu2t
 xX1ck8NKaL+9YjyX9eg5Hnt57+ZyaEF3IgqQXg/1scQL5niyCH+NzU9PCd0gSRfKWdYo
 aBUKI22kQdgCr3Y95pRFVnSV1X+g/8tjRVpUW13pu2l0ok6x+7WGYMPvAT/iJxp2AgaO
 KeI36Rf9I0UFgEbe2xgVplG8l7U5c6xuWALI1+MYRn6yerqS7ibgBmwjmN+u1E5QI6Cw
 KoPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfrdQWJdJ3xVfSAFfdfw5sjbO0DrXSUii6LScRzX/PSIuVHf6wvOJEcirkIFf0PavV9c2KIHQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwyYS1G1dI35fuf9ZBSiR8HDVwyPXS6UJfoLQqtl9F+H1LoRGtN
 6k/MthhT9suVkRX13m+CjyS7HsWGpkgfq1I6adQAl5//De/8Z+82C7M68MOxX4o=
X-Gm-Gg: ASbGncvnsMY0TfVdKnd4/6nobc+nhvmE/YlRdOxPnVPkxfjI9qmDi0364kKcHiX4lPd
 coGOtZMHrp+KR7ANugzik8+DqnsNQaT3ORAyVlC24gMpSXaDp75mIOKBUvyRLydGV/zkL9m0czD
 YQ2raCYhzTbTwf7HGNJR1UKEua6JoMXJAfHczvTRBbDbZiIK+Xdul3uV3M2qAd4McxlZWYsmDVQ
 6t/riItP4ozEJ/eLirqwrQCyq+NmdjYYzYiOmE+IyA2Ct9vLbYUSuxW2gv6bNHRS5WLRzGszwv+
 qNcFsbNb0XTUINZUWU7YxnUvbUbGr70ZWRJ+kdyNyRywi2oYUfTVWL9Y6PHTFCo0uGx/nV0D
X-Google-Smtp-Source: AGHT+IEqFKe5Aogh78ZAXiwmurx3eY1v1EtBMWecoaf483f4RCb9MgpgVPzTqLowKHZnkPhfFiBMwQ==
X-Received: by 2002:a05:6000:1887:b0:391:2c67:7999 with SMTP id
 ffacd0b85a97d-39132db1bf2mr17663868f8f.48.1741696295584; 
 Tue, 11 Mar 2025 05:31:35 -0700 (PDT)
Received: from toyger.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm17788586f8f.76.2025.03.11.05.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:31:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 11 Mar 2025 12:31:18 +0000
Subject: [PATCH v2 3/4] bootretry: check for bootretry variable changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qcom-phones-v2-3-83dcd88a6a87@linaro.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=7aGOctiNDBsGQCXk6t7RWfyufw13wgNM/Mg3qxK2xnA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn0C0hJUb4xNMSTgOmW5g0N3/HtS+8Xd5WkelfC
 zDZGA/Y+KOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9AtIQAKCRAFgzErGV9k
 thXWEACDFMFINHHwDy5/5jHiVFhkQBwlnOiQdb9lvoDuro17esGdn4QSvXzLfhkxo1YFYDQ5PxP
 6gVG5anQzmbQNDvaqDjJhYNDfIDN4PhEkyzhrOorIZUnQlEfZDHAZcY889GOkxQcZJAM0Uvjj5p
 l7PmV6yVmDBeA4Ig7nwTYUZpKH0yzcIXyWfLHBhRVScPetE3lRq3UoyXC0Ipq0zPCKQaSlHfw59
 CEin1if30amn6NOscTPo6s72MuadY0Rf7L4SHWrrM+MUlwMfCyeuEF668gqV/jU88aPmgo6jR1D
 XEBFILENAmW24ujWg+e404B8iZXEtuziwSEIb9MQdyhrE0GXAZu0+s+j9gnuxaXl42ErPsfDUKu
 A/mbyi7CrSXmfzvzq2JcG3ICFRuFJc7mHY0aUfmvB/CjAJ7bbIlb4W/tn+bYX/vz1GEWkRkweHr
 NFecbI8VzmQupCnOXOY1uuaMqAUgTrYWrM+JBzOkjt33Y2H4Onn+jeUedA+fa0FchNzJtcBIhfw
 X/nIyq70CMiALNtEyaD+cSZ9mA0wpLchJcgtD5Ew9YWw8n4aGlFE1Swlj5AASRq++BA5TufZ5dW
 ZM0uBloopNV6IIe4a4v29NDxAha5vDh+dsyEnB6hhFa93DUREfl1FAgSPTMZBDzQ/LCQR8wm1du
 aOmkDILyfj0MCPw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

To enable more complex sequencing of the bootmenu, autoboot, and
bootretry, handle changes to the bootretry variable between tries. This
makes it possible to turn bootretry off (e.g. to drop to a shell) and
then back on again.

This makes it possible to have a persistent bootmenu (the only way to
navigate U-Boot on devices like smartphones which lack a physical
keyboard) by having bootcmd be defined to launch the bootmenu. This
allows for menu options like enabling USB mass storage gadget to return
back to the boot menu once the gadget is shut down.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 boot/bootretry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootretry.c b/boot/bootretry.c
index 587b2de7d6b08db07e1dea512a834cb5590c2d12..a60767eaa2ee51970e4695e487ce5651575079ba 100644
--- a/boot/bootretry.c
+++ b/boot/bootretry.c
@@ -36,8 +36,10 @@ void bootretry_init_cmd_timeout(void)
  * reset command line timeout to retry_time seconds
  */
 void bootretry_reset_cmd_timeout(void)
 {
+	/* Parse changes to bootretry */
+	bootretry_init_cmd_timeout();
 	endtime = endtick(retry_time);
 }
 
 int bootretry_tstc_timeout(void)

-- 
2.48.1

