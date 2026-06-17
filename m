Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9CACD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 19:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F38984874;
	Wed, 17 Jun 2026 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gx6TmmpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D79F8460E; Wed, 17 Jun 2026 21:47:18 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD54F84833
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 21:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-486560db81cso101153b6e.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781725633; x=1782330433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kqb3KayTjOt0wve7SepTRTp6MKBMNrdv4BdrWWP2XAw=;
 b=gx6TmmpZ7+7vUswYWIYpQbVBQaeIf1ZD1lh58YfLG6DDCJsaiQOukJANmyn7KL8i1p
 gUcvgMIV5R5UcpO1YR8vBPoXM/E1ipA/49fBJhPOUBqF1tKH0W2YWh1i6MmcHUL9Nh9c
 z7yP7zR8Xt+BqOXaZ37uLcKMNh4I7dELyZzB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781725633; x=1782330433;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kqb3KayTjOt0wve7SepTRTp6MKBMNrdv4BdrWWP2XAw=;
 b=aBtOZU/15fI1Y/emFzlBLhgnlJzrJu60gRJrHUm1DMMoNlUk7SPMuqghMTwAj3uT5O
 pNTxsB8Qf3nQlJUGtYt21LzLkOR1m2p2QOqRQUVJZEaw0R4MzUpx/8Cfh77e29V+eJmq
 cLhdPo9ULmGQ86Lv5PfgVr9wpMIvhZg4vgOkAUuAqYcrvYwaRSCGpigY+Vnz/BA+rztz
 OFXOK4cX+M4iUXiu+ECi0qmF6AUKR5OyQjilAZ3qQlIfsx3bjYiNl0PFgJGIEOST/+wS
 gM9lU80axK3gbvszvtA2nr9gxlylZfHRo45rdeZYT0Z4NSc86ga2B2y5eanRXPUVFQTx
 pEvg==
X-Gm-Message-State: AOJu0Yyj/ae/JbP3bJWTTySnynLr20vIW+U6wWAjG+ihNED1OrVUD5fA
 YSfcldsJWcMZIKfX6RyC20+AfeNR1JxtBtzKx3inGHn0VfvUxMxXOHHkKGsDfRay2Uc=
X-Gm-Gg: Acq92OG9sOdAKtuAVeb0o8Xw9Wlblmv2/2BO13ZB4paDDI7UXJtjDGc7QDLklmglZTS
 Lcbc66gqDcGnnVDJQyG7jAwfne2gdpkCrDB6f6/Iij7q39RVj7pE6Z0c+Lg+PL8huM+OdSRarwb
 hDLxmG3k/VSLfnfXjTn45BeztnLSqyLa9pGsl0y05IJXDtmpzJUjYPedZrQueqQXZcknUW5I+zS
 oGs8Wv0gtiP3ZVrwTn828hxxajMbUYYFre8zFTKmNQ/u5aT3PTf/cctfTARqQo2kJrlZ8fDpZ+D
 T1DkRL8ZThmSOkAourLHsEfeZrqxQdPZTl9bxlljBFAcbp+PX7OqPzzceleh+WpGiINhzXzVMTC
 n9fL5cfj9I6HLD9M0Jmt8T5edA0OnVVcFpEzDQrHiahKZSGmiBoX1Cj75uAbFD7Ws9DCr7qJIH1
 VvFcBnhcW17O+43iNxy2QTsIcN2lvxv+4rC3UsiHuGf5UJ7oAJbTWUT2qhpQtQIMtr1ag/HoTbG
 4bm/Gm8+j78seneHeAsBTKk0NpWGPal4z9Nchk=
X-Received: by 2002:a05:6808:c2cc:b0:487:55d8:f0eb with SMTP id
 5614622812f47-489429b1525mr4239555b6e.2.1781725633302; 
 Wed, 17 Jun 2026 12:47:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4875dda5f7csm6798219b6e.1.2026.06.17.12.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:47:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260605154255.833334-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260605154255.833334-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v3 0/3] bootm: bound noload kernel decompression to the
 allocated buffer
Message-Id: <178172563263.2028295.860318199384974331.b4-ty@konsulko.com>
Date: Wed, 17 Jun 2026 13:47:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 05 Jun 2026 15:42:48 +0000, Aristo Chen wrote:

> For a compressed kernel_noload image, bootm_load_os() allocates a
> decompression buffer of ALIGN(image_len * 4, SZ_1M) and then passes
> CONFIG_SYS_BOOTM_LEN (typically 128 MiB on arm64) to image_decomp() as
> the output limit. The decompressors honour whatever limit they are
> given, so a kernel that decompresses to more than four times its
> compressed size runs past the end of the allocated buffer and silently
> corrupts adjacent memory.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] bootm: fix overflow of the noload kernel decompression buffer
      commit: 2ff26c1e37858ba0b2fd12c82e114a3cedcb317a
[2/3] bootm: increase kernel_noload decompression headroom from 4x to 8x
      commit: 4956f108539135afb1afdec2b509f62291087d16
[3/3] test/py: test kernel_noload decompression buffer overflow
      commit: a7ea33e3a35860326aeb5792f337bd9082d40ecf
-- 
Tom


