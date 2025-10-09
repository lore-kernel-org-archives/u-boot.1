Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B51CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C385084529;
	Thu,  9 Oct 2025 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YVb2SzaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8991584522; Thu,  9 Oct 2025 16:18:56 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7623984307
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7b4f7a856acso359621a34.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019533; x=1760624333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DX4QAlVmi9kK9WDsu+tt20eVGEE0zb7+5eH4D6ejYmU=;
 b=YVb2SzaCQQp70kXODDyAiBwTNb7Dd3XP6/W2EJ2c8CxyU9mZ1RzsVN0PMCsMGeI/bo
 M/jNhSFmKRpMuH6hwgtB0OtCB2TO1wQARYS/LJicbNy+BDgN0MQU6w7LMoryThmC54uC
 gIAQaTti3qRcZGqwsFYyhbuJyBMUI7HyZDVhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019533; x=1760624333;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DX4QAlVmi9kK9WDsu+tt20eVGEE0zb7+5eH4D6ejYmU=;
 b=gF0LeuD0N1+sr+yVze4OcrCyH9q8IXLyrKaUaisLLVXZrFgSE7G2mf7vA00WcC5Nza
 Z4oo95MGDZaeOcvbzTbokps77C+TIL8O5KgNIlOd7gBcYqAtsVRch4mduZjNgb+S8g3P
 iv27Da6fHU9GLFxf1nzb92hDxon3NVYt76KcOoFx4DygvKhUhf6enKdr+MuxDFQOd/cl
 tvxlKXSguF3LFbDdmMTv1Uj3rs3J++5CDtcwzLA7rRPTZVspivj2oB9iHLoUo+sosuCq
 uZd8eBEJZro27L2xtDVfQ+sG8rcYN0nUM8muDnpXFvIxzBXgbbEOavGdwbp98gWSwItQ
 I+Qg==
X-Gm-Message-State: AOJu0YxdTI/jWDSQcdfD1Dm4Czx+Prfhn0i8qtrQ6S2D8A7CVdIwIAcA
 NXYgkXU2/x2YbTBv0ZP4/5BqxUsIYENgje7cLrmeE0Hcw/8cEYfRtET8VQW0fu6gMH1/oeEPJ8D
 zL2Jg68Y=
X-Gm-Gg: ASbGnctJDJL6U3HeY14xSiYeQQUUVA1Ern42WH6W8M5naf8nhxV8QrHP2g//W83R53N
 fbeJgaKg3euoUdaFGXtwbwDtLiU3ZGpD4kpFYZeOnpW6+XwjcqXu0TLjw0YUNCJweYZKl4txBFG
 FFiQKjzlXu6vh4nEkE4zhRZPMXsesEmkU8mWA7rhmD9/pZrTc7YetBy8gXmmVmic14iSBiiwxPT
 j3IDQu+32aw1v9Qwck2zFaOCTDC/G/2dtWf/OvnWio/5xUxo7726oWpArNhOLtunCRzlbkWTfrE
 tMEuYPnmqfzhYMv136vHueSsqcroqqW/Y8MrxPU4ZxkKbDkOBIYl6OsXM1kmREU1U4uxudu+Yfv
 fHsf2aabqzoFAQ+3gwYaYPMTe33aIT5W96ZMvSg4KUu6PjxGfMppplTSRAvWjvZUt05cru5c48o
 UA0EB6qLZYTOc883Xklt8=
X-Google-Smtp-Source: AGHT+IEFssQ5TMHGONIQE6WoR2k5no1ShXP8H6NrDidduoFpMLYtJj+oGtsZbp9MaOpUDBDtrsSPMg==
X-Received: by 2002:a05:6830:3490:b0:7b4:da74:2310 with SMTP id
 46e09a7af769-7c0df7f399cmr4271521a34.25.1760019533242; 
 Thu, 09 Oct 2025 07:18:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205124.3561896-1-trini@konsulko.com>
References: <20250925205124.3561896-1-trini@konsulko.com>
Subject: Re: [PATCH] spl: Correct dependency for SPL_SYS_REPORT_STACK_F_USAGE
Message-Id: <176001953198.3159859.8383263820391203866.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 25 Sep 2025 14:51:24 -0600, Tom Rini wrote:

> In Kconfig syntax, "!=" is a string and not numerical comparison. This
> means that to check for a non-zero SPL_SIZE_LIMIT_PROVIDE_STACK value we
> need to test that it is "> 0" rather than "!=" 0. This is because "0x0 >
> 0" is false while "0x0 != 0" is true.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spl: Correct dependency for SPL_SYS_REPORT_STACK_F_USAGE
      commit: 93dbdf389848310afd769a45f7a043e4a19c1b2d
-- 
Tom


