Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F51C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7550C82F67;
	Wed, 16 Apr 2025 16:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m4YIFSp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8F682F5D; Wed, 16 Apr 2025 16:11:02 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5445181B4B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so26034fac.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812659; x=1745417459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V60cUsUS3fj9itED1mDyPOPUvNb4JOf2+wFNQw+jrcA=;
 b=m4YIFSp5B4ktW3k+yGddjWwxE9ww8CEaYP6wcGTTARJeSRug8ahTKU5kfE+qF+4JgT
 +GlNxL1OmAwcIxocYrDWgnCcRYtG1Z6fywUnNUVOWmM1V35GMac5vC5h77WiaozwaKez
 9vgwVYAb91sxevqIiC02NyaY8WCObijGellmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812659; x=1745417459;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V60cUsUS3fj9itED1mDyPOPUvNb4JOf2+wFNQw+jrcA=;
 b=gGVdvzMQ4JGdrQT60Woidzl9atMwMfbKZNrF+Ks2AigICu2DbinW6NXKo2Uj2JW1Pj
 qUD/13a14BfrDJxdpjU7Ili9vxdH/qBYr4rSzrVFZZVmekCZekSFYSfviXGcFvKgd7OB
 I4qCYW/55q9hLy5XAgUOTiQ9gz2TmdRkaXeIvCZiS01t9LDvapb+q7/SumLV5lJnuaNJ
 Ie/zDDIfRKGPTDodeqX2hJRFSryWAQ3YSbCPstCpPE0Zvkw0il+1EKG1ZDt5anb4kz+t
 zZAtTx7v4bsXBJLFmxPHBkHR0ALdrnzOLttVsgxAxpv1x4uNnQ24M/4UGRB9JdCATmjF
 COjA==
X-Gm-Message-State: AOJu0YwaWWOwu3vyAVDNez9fZR/CRYp2HqTdVf3syPyS5ZhXIfBKWy/l
 2Me39tsErqGxjDvCUhqa4rwBkJuztrsdM8IkNTOylFbJX6DS5HavFfazlC481nmxCv184U3Hbfu
 I
X-Gm-Gg: ASbGncvdUtGds6HQQ3sgAFTk3ATa2X/B7tNq3MSh3/3UB7f+KZWm6T41oVCjGuHGphI
 sdirMlJq1uwusKxIDxPlod+s8O3zji4NHMyVtjczKqg2Tq0sStnGv28AwrLPPrBTlrS2xMbEMXj
 dWxSHO2zhCijs3Uj+6RgJLVyE/hLnw2RTgjcLD3IY1FJjBKgLNTY6f/BdnjfLLaemSaXEvUaS5g
 oSaiSiLfGV1ZrvRlVoINvcgxKahBiRKB8ihZYYaaDqonrVbpV+DuA1ChfOv0Qs+5ZcEXuqgw8/1
 kVJ0i2Xd+YM4Hc7y4AMw8EsIhwfUrwHQwz4RWO5yNPLBCQLyqkdr44I55qPDnlmjzdYvvoDyWBD
 x
X-Google-Smtp-Source: AGHT+IGi5+RyIQiTCDZPaIQmoS31eNXrKBvQfb8gJJN5eFp7SNSGcYwYojU3DWHIRegsbLcV5NGimA==
X-Received: by 2002:a05:6870:b023:b0:2c2:5ac3:4344 with SMTP id
 586e51a60fabf-2d4d2b19b02mr1137175fac.15.1744812659123; 
 Wed, 16 Apr 2025 07:10:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250411170406.3250498-1-trini@konsulko.com>
References: <20250411170406.3250498-1-trini@konsulko.com>
Subject: Re: [PATCH] buildman: Update to grabbing gcc-14.2.0 toolchains by
 default
Message-Id: <174481265849.2150978.13318823259363905428.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:58 -0600
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

On Fri, 11 Apr 2025 11:04:06 -0600, Tom Rini wrote:

> With the switch to using GCC 14.2.0 in commit 001bac5f16ad ("Dockerfile:
> Update to gcc-14.2.0 and clang-18") in CI, we should make buildman match
> this.
> 
> 

Applied to u-boot/master, thanks!

[1/1] buildman: Update to grabbing gcc-14.2.0 toolchains by default
      commit: 05a2b6984159e83d91420af283dd204bdbe07d65
-- 
Tom


