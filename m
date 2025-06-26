Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93EFC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 17:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B863F82E66;
	Thu, 26 Jun 2025 19:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VbnXa48x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F80E82E27; Thu, 26 Jun 2025 19:56:57 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2C382E27
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 19:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-735ae68cc78so791337a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750960609; x=1751565409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7b51wtV1L01mkIzuP1ZGZwq5+WpgKYe1u6C8gMK4no=;
 b=VbnXa48xcvsM7yJ5sT8A+AH1k+59hHWIxzEkT59Mry63tn/Y+huKler7my8RlKoFI9
 gjJKcOMFUh1/x0dsU8MnV75VeDoFWmFbbYgkfj9lnY14t8d5TaikKj/Wi0cQ1IMpmRz/
 RNRV502k4gS6XAZGqDfBrRe6YsGqPHvGp1sO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750960609; x=1751565409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7b51wtV1L01mkIzuP1ZGZwq5+WpgKYe1u6C8gMK4no=;
 b=s7VTs86e6IZ5ySdIoaLAwYZNW6ZQ6/nHBfoJwqvVDYGwI4iXMspBZZP+k18JnT0Kxl
 79qOqngMNoDMAaHs1+m6+BrxaY9jS5LwOpEAWhU3iEUlvlcNzkv23WX3Au1588G0mVyw
 fFS7JODjps1Ng4EcaaQJX6vakSDsOUi90wuQdR7ocCWUMIefBVbqtHYP6LbMQa4fylNd
 osY1Xh55bxR7ST6nPWbfSSmuCU0QNCwdodNZ34NkPMO/JLDm/AAfoLYbjEknCSRMEvMe
 8FXAPQJu76G3mqIoHL+usIoshi0Q4NfUo1uLqUYioSqJfwX8shvoUfSzPuxv3pIS6tNZ
 pFLQ==
X-Gm-Message-State: AOJu0Yx4vTTA3c/Sm7DBuhW++02cgXrW2l04CUZs455JGhPftZ1GI/40
 OhrONK6OVDRholOTNeelAYyd5cVHnQCPkRgdshJ/XSVcx+K5Qc0morlzXb1/2VDtQ/Aeq/WupYa
 +mTOwY4w=
X-Gm-Gg: ASbGncsQUE9oo/Z1RWyv+B0w5bUgaJsFYNtvdN/2XiJAhoFEo6rsAwMKOIftaP371Ss
 58TY9i3e9ra5kKyKnpyNH6CpK0/wt0Nl9yqF4s3gCEx/jvfLmy7F5728e+YhR884GGPcTm3ELtV
 sbhNcH4j1daXfNzP9FpTYvTyiMpeGljoXinFGc9CiadAqW0Hrq8qPa5DazwO+D4iBufuanexjst
 3ZIdWRW1nlGHPd5PWuTqE2yEq3Lmx+8EnIL0IA431kbIQN07ZwBPCPFojn/ZFqWFw6KeT6Khg4C
 /x+7rrWMReon8sKHgpee+hAfq0mXJz43nN61CN7H/IaAlPlKrjWqiJcW7rkxvyj8jZklQVMYu6k
 o9tAeD7J29WcTyEwK09I8YA==
X-Google-Smtp-Source: AGHT+IH8L8H2kSwuEdS99pn/AYGd40NZ8jkVgny/VYXDdRps05hsy+7m/q6f2DikG5rPSpV7zdTWgg==
X-Received: by 2002:a05:6830:4c8d:b0:739:f863:c4d7 with SMTP id
 46e09a7af769-73afc5aaddbmr25031a34.12.1750960608853; 
 Thu, 26 Jun 2025 10:56:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb008936sm63877a34.24.2025.06.26.10.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 10:56:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250610122748.2756616-1-ravi@prevas.dk>
References: <20250610122748.2756616-1-ravi@prevas.dk>
Subject: Re: [PATCH v2] mkimage: do a rough estimate for the size needed
 for hashes/signatures
Message-Id: <175096060804.1879961.7261791481032827876.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 11:56:48 -0600
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

On Tue, 10 Jun 2025 14:27:48 +0200, Rasmus Villemoes wrote:

> Background:
> 
> I have several customers that will be using a certain remote signing
> service for signing their images, in order that the private keys are
> never exposed outside that company's secure servers. This is done via
> a pkcs#11 interface that talks to the remote signing server, and all
> of that works quite well.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mkimage: do a rough estimate for the size needed for hashes/signatures
      commit: 7d4eacb0e68a7eb471a8dc43a5585b46ec67a333
-- 
Tom


