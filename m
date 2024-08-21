Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F055C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1315B88E35;
	Wed, 21 Aug 2024 18:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dxYjonDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C3788E0F; Wed, 21 Aug 2024 18:19:48 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D0488E1C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70cb1b959a6so2683308a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257185; x=1724861985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jr4V6ILtn7eg2t4690GoGHcZUvgGrgo9Y0h80vEcLbk=;
 b=dxYjonDcv2dPVH+nUjSUbBGfuIE5Kw+RxGgu3ML3hbdIz3uRRPcZ2JIEN1TLAXXYHa
 zRuBy0uw6ofEYXnF8lTb4SQtNiEFq8j3T0TVubnchI3TUhV7eIk9FLtVAGsCuV22AkBB
 mJv2Vmck/stanV6UGlgnv3Brg7qPg2l0Z4En4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257185; x=1724861985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jr4V6ILtn7eg2t4690GoGHcZUvgGrgo9Y0h80vEcLbk=;
 b=qmzlajRcComrhlCkCvf62uaHt/+UcYaCfwjVV7QLx4kZXz1mIRF1tScG+pkixhtdJ8
 jTGIXISFgwkdbsEVKvky1Z7+Npr0N4CFc/056NWxch4qEbQIwy2Xjt9eoBbMYcADVVfd
 UdQ7Dwx44EW1bBO7Lg1u9YbL0qrkJzXDvOejVNjjP6M1kn9EiAp9ID1OkF4grLRlOY1k
 EDEHpEwAZEGELC4RHJrbNVNfmItBAvrlANqaW6XtHE2EIxbZEJIRt0A5kdkrtZp4HkvU
 WTVJGWrVCYZWwEGEZcsyUEEIArQpTC6OkwbgDCWF0U/lwN6ZaHYwF0Tek+9pHpCFdvpi
 Xx6w==
X-Gm-Message-State: AOJu0YyuA2zG0HlqALax6dhoDi4A4HnpJmCNtulQuT60WmYcxBCRkY6w
 iPJFuiNmFs8he3XbviuZOHslg/GJvV/YWiOW5Rl8BEKyyqei4J5a+5ljhivht6JkY/wwaHCCKRY
 =
X-Google-Smtp-Source: AGHT+IFrmRGAbpCxSokqb15QFoXEVOcd9TMEyDtkY1MB9zLP7o2q/fa0HUSBPZ0d9P+RQNTCHxVOeA==
X-Received: by 2002:a05:6830:4129:b0:709:483e:7033 with SMTP id
 46e09a7af769-70df85f01b5mr3348309a34.3.1724257185453; 
 Wed, 21 Aug 2024 09:19:45 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/35] global_data: Drop fb_base
Date: Wed, 21 Aug 2024 10:19:03 -0600
Message-Id: <20240821161927.695717-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This value mirrors information recorded by driver model video drivers,
so can be removed to save space. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 79d2aa4c6f5..a06b508bebb 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -64,12 +64,6 @@ struct global_data {
 	 * @mem_clk: memory clock rate in Hz
 	 */
 	unsigned long mem_clk;
-#if CONFIG_IS_ENABLED(VIDEO)
-	/**
-	 * @fb_base: base address of frame buffer memory
-	 */
-	unsigned long fb_base;
-#endif
 #if defined(CONFIG_POST)
 	/**
 	 * @post_log_word: active POST tests
-- 
2.34.1

