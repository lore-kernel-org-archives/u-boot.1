Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B71CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B6588F9B;
	Fri, 27 Sep 2024 00:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M8ZBdB/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FD488FE0; Fri, 27 Sep 2024 00:43:05 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCB287B77
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-458366791aaso8332801cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390582; x=1727995382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZiLjMtLPhGqbinSBSP/b2U4VwNho2J+ttezSEqKlDUw=;
 b=M8ZBdB/xm0g8pdXnIelg8RsMU8xqB1D0RXQpALhjW/c2GZSOCEyFa/bJsezWY3xMzH
 q9wNjRD7NCkv2OFaZ9AT6B6u7QYbeHSExdda8vIOKQk/ZgykYM8rB6bKaqqv79xzhDIh
 1hEBmux0nEvTzlEJmbhJHmEPzFBJ/LPVosO9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390582; x=1727995382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZiLjMtLPhGqbinSBSP/b2U4VwNho2J+ttezSEqKlDUw=;
 b=gRsBc344C91rO9/i7rrgB8BfFiddFTSCxBYZn0HTlzU09JpsJVja5uVxa1QW544U2u
 qdZhFbGPbCKwdqScDHuRe8r5B0b8QqGXJ5C/I7wDe6Gx6Kbjk9Bn60MQpIA4Lp99egi6
 EIGpGdAaewBndq7av6MiHhttGdZI5gva3cIZIUsnIPx2j5K8lcrzrSiSiE3Au23kKgQr
 ptPcRjN2mg6BqT/WmCnPkAufz8riNLSPAmmY3QrQ8+fjIhPxAHN0PevDl2JNhggUwfxW
 Umc9NC99U4uUZUTNEVILbjNpQ7HdvYL4r7pz4/MmgdJsjbe7PJpF/b3ddvRLJiaab/iW
 Oe2g==
X-Gm-Message-State: AOJu0YxNshGBLZCX1w3QGiFWq3kdq380M89XHgcXGA8PMCZuQBf6IowF
 FpcQejKjID9MSkh1hzgwktyzjhMoy+TqxorxMz/5XT8zofig5VTkORLcsrPLoP2h0nqw4awZh0p
 FyqhEszw=
X-Google-Smtp-Source: AGHT+IFiHS0N6uc6RFxsWV5HE7PAGRgzAfE1qjyeXrgPPnOQ8T0NhX7m4QzE5utBY0w1rpby46yiFg==
X-Received: by 2002:ac8:7f8c:0:b0:458:5bb4:7751 with SMTP id
 d75a77b69052e-45c9f1e7c03mr15837361cf.13.1727390582521; 
 Thu, 26 Sep 2024 15:43:02 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:43:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 21/42] spl: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:46 +0200
Message-ID: <20240926223814.1276764-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/spl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/spl.h b/include/spl.h
index dd9aeeaf9cc..415d198da56 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -90,7 +90,7 @@ enum u_boot_phase {
  *
  * To include code only in SPL, you might do:
  *
- *    #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+ *    #if defined(CONFIG_SPL_BUILD)
  *    ...
  *    #endif
  *
@@ -120,7 +120,7 @@ static inline enum u_boot_phase spl_phase(void)
 	return PHASE_TPL;
 #elif defined(CONFIG_VPL_BUILD)
 	return PHASE_VPL;
-#elif defined(CONFIG_XPL_BUILD)
+#elif defined(CONFIG_SPL_BUILD)
 	return PHASE_SPL;
 #else
 	DECLARE_GLOBAL_DATA_PTR;
@@ -154,7 +154,7 @@ static inline enum u_boot_phase spl_prev_phase(void)
 	return PHASE_NONE;
 #elif defined(CONFIG_VPL_BUILD)
 	return PHASE_TPL;	/* VPL requires TPL */
-#elif defined(CONFIG_XPL_BUILD)
+#elif defined(CONFIG_SPL_BUILD)
 	return IS_ENABLED(CONFIG_VPL) ? PHASE_VPL :
 		IS_ENABLED(CONFIG_TPL) ? PHASE_TPL :
 		PHASE_NONE;
-- 
2.43.0

