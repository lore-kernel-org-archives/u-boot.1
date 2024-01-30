Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C8FC47DB3
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF29787D6C;
	Tue, 30 Jan 2024 02:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GB7O33Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059F387BDB; Tue, 30 Jan 2024 02:54:17 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D161687D03
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-602cd92a75bso34407157b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579653; x=1707184453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N73BvZ2aCuEShP8YG4D8tO53cEl4SpW+Gxv4Ak2FJl4=;
 b=GB7O33Q2XoopYLgDMnzuqOiH/gU+wxHTzU1Wh8FlxEcUr0VE7WZdfb8jddXDRlbrhv
 IZEW+FW6ROCJLVD5up4grM1YpCqtLcqFdGRlUbQh+dNXDIkj88RsaRkibPlkcXn614tH
 +DHxCCl5s9vZFkhJO4cwZ7EVGiHfdibcs9d7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579653; x=1707184453;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N73BvZ2aCuEShP8YG4D8tO53cEl4SpW+Gxv4Ak2FJl4=;
 b=RrSd5jQVJqq4CUfFZMoHTUHBwYnRsD1PqNA1uEf1ShZci6sSGEHAXzblaPn5LWfOhS
 rIHEkEBEvSVQ6dKFCjFdO73MHEhtxSoTVyu3t2viRR3XtGmxu9XJrM/Hprnm6beBQGe3
 U7ayQ5dlVI10AMC8ujB9jtFF23t8Ou0c/EQbHMlnT30sdrnEOnTysVh4jlkofjafHxR2
 0oEpIC5ecBOtGVPGv0NJ48gC09Yo/ae/IT4HLYWVqhM93G3nSqTgpmc5BjZiA11JBCjo
 LIRSpSGUuEdworlDbfMqi98ecEYUNCEu7BdXAoFpOaRFX4zKB/lXX7faehejCfWMzjWy
 FBVQ==
X-Gm-Message-State: AOJu0Yx3Qr8l7TAGnBd72W34du80w5Kk9DSi1HCmTB+CUfRR01nU5k42
 mIbgxUewGTNowA+ZD6nQlclN1l425CcPKbWxsgdh1xcEa687KXjG4x5JPawrN8ilfuZXY/yuXFB
 e
X-Google-Smtp-Source: AGHT+IGFY7F8cxXtyAR7p7/xBunHoVUx3v9Sgl2a6xQLgV0XpeN4iF0uOvDRfq8dg5bgeVdQOULJCQ==
X-Received: by 2002:a05:690c:f8d:b0:5fb:550c:9e7c with SMTP id
 df13-20020a05690c0f8d00b005fb550c9e7cmr5919693ywb.9.1706579653361; 
 Mon, 29 Jan 2024 17:54:13 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240117-cmd_font_bitmap_segfault-v1-1-26a9239b3831@jannau.net>
References: <20240117-cmd_font_bitmap_segfault-v1-1-26a9239b3831@jannau.net>
Subject: Re: [PATCH] video: console: Fix buffer overflow in cmd 'font list'
Message-Id: <170657965279.1823400.14518180658966800140.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 17 Jan 2024 23:29:29 +0100, Janne Grunau wrote:

> vidconsole_ops.get_font is documented to return -ENOENT after the last
> video_fontdata entry.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


