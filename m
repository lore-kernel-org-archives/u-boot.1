Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847FDC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A0BE4089D;
	Tue, 28 Jul 2026 06:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvIHJSdCMMbZ; Tue, 28 Jul 2026 06:55:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C2B040894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221714;
	bh=yf1KwmASoyLuswlYmOfgxT9lWUqxXlltnUAyeCQFWOM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eZoCUELLq1UmoEWdO5B7iLtceECmSmAWHglDbgcqfTYUGZOJE6FYBGJ3kR/JXe9Vk
	 EvM7p1gkD+L4lG/X7LAKqWLWpJ4bNsEePM7JaYj4VwIxmdY2z3VyZ51eKhSffE0mki
	 69mAiqS1KupDDTDqOOb49TFtocCbPi/ceGTEggoZOxiMSLjZ6QUEYWWvK2G/P7Ex6P
	 wty9dLOtGret7ymTKObGIeAW5iM/FgN6unHtFOWgshms4uMbhAGGPQyKQAxHCnYa7z
	 JFVJ6SY38OfoepxWFGeF4Kz8W9FboyhzpwuPvcVCpZ7S3aLPGTzTsp1O+nSnjXQ6eO
	 LgRY/8F3cEY2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C2B040894;
	Tue, 28 Jul 2026 06:55:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAAB023F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD0CA81236
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpuSBodXt0F8 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:55:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0306880C93
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0306880C93
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0306880C93
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:11 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69c3044e4b2so561140a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221710; x=1785826510;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yf1KwmASoyLuswlYmOfgxT9lWUqxXlltnUAyeCQFWOM=;
 b=JpA9py2gTduUztD9M8H+dUI35d3VyCEX8AjoxV+dNUQkSLhyV9+sab+LxGhKGd5QFZ
 McvsrWOow2UiSXWvgI4OqNJMOIWM8wccoeqHzVZt89rY3l4gCx4dI8wSkzBY2acaJ0+j
 iB7VdplD01ZoiRyn6AL12y8mhC0agi5NiJQAXqvWnj0fn11KNqHohE5yaXfGk2R57eaD
 IRRS7OUXzV1+UoFF/mOJgKwuJXejAUX+etoCX3UtZmGBNg18sQY7VSSAQGwdkcdxzLS6
 XbNzD1CtAgf0uheLhhsgnoDAEh6QLMgqV2CpvOSjJDpS30Pd3COqaj9RN9aDxW9Khui6
 ON9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUEz+QFeHvZbrV+j8KqppAj0DlzOndDVYEbDD5g3AD3kbxABZwUNtrwdJSvzOgP7yORvkZQnU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwgQgG/WUncCQxQMAptNyskflTSMde4B0bHiadnRChM79FqD+hq
 wvQWTUIlku/sWto7l58lguWZGmRf+/C8C1BmWiiIMw6IA8cV6IPhXxnk1Sur4g==
X-Gm-Gg: AR+sD12mlwL8qpTozopdlzdzd+Jy67vUd/fq+ZjcjxIAyXvSiZuGlte8CYNNePrBTn8
 qRZaQycOdO8aPTBG3l2j7GgKS4d3IchfccnzlW7MOsEvW+gGGeQl1tzIwYr7b2z2wtJjQ+LUGIY
 qGulMhNykbMXPpkyGn6UvQhiX7W6R/z/cfypx4eu3dFUmvNRW8vnb888JwTRPBGEbIk4ZH9IosF
 SkTgNCOjC4IOgsfxOU7CDPOu88Me461w9KmaNhzqSxcYQR0ZMb2MnnOwmX/xWm+mPD4Cp09iSUS
 8T5qovSXBNaDU1a8tRRUd/a7HvqZljSIysiySqM2zT5I4xAuKGiLRN9V4A5ziBkLpp98MYM5Gd9
 X8mypOLT4YelNtwNwAcc3gxjvYnoh2Gi0VRRysogVQjvrFX0HKbKPS/KkVxY97MOUClIkR3kwvF
 TbQII6FQEeNu6ME+OQqwhzSxyHCJjXJqZbvW+5THOh2eebbuDURGw=
X-Received: by 2002:a17:907:d38c:b0:c12:c7ca:d704 with SMTP id
 a640c23a62f3a-c1f724e90f2mr26395366b.6.1785221709832; 
 Mon, 27 Jul 2026 23:55:09 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c4835c4bdsm632567666b.16.2026.07.27.23.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:55:09 -0700 (PDT)
Message-ID: <81c6026e-d28a-4c92-8987-135a611d5f45@gmail.com>
Date: Tue, 28 Jul 2026 08:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 05/11] rockchip: doc: remove copyright lines
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221710; x=1785826510;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yf1KwmASoyLuswlYmOfgxT9lWUqxXlltnUAyeCQFWOM=;
 b=UqTxL3ProepOyW4TglDwpTGO4Y3+uzt/S/rfWXq69OzhXUr+Rn29IEH4ZNKXPEEesX
 BSBttdCtaZHQNzOTJzvZ9KlnnyTtt2lwXKOGnlspi56oNjg2fJ6DwsP7hbPdW0dgL5sO
 6VJvAB0NztKHzaJpraI7N1wfUFr/j0QipYZNO+sQuZkzZWJZGdZZxajeIRU68ox1IAMY
 gMk8f1INqWhmswKEQeWYd/LjFVovcs97zd/L2Y9VNfBph5mRJbawed4jdkneNxjtw1ES
 tMghI44tsGlpRIlgWyvW4XLxgWK0WQ1hSp6/fPo06W2uezmqDBxSCETB0ACehNtuQh9B
 9ukg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UqTxL3Pr
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Don't add copyright lines to a constantly changing document
with many authors unless you are making a significant
intellectual contribution. Most changes are derived work
or repeating steps.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 3a190d6905f6..c3fd74c9cc5e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -1,5 +1,4 @@
 .. SPDX-License-Identifier: GPL-2.0+
-.. Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>

 ROCKCHIP
 ========
@@ -552,7 +551,3 @@ config-flash.ini:
         FlashBoot=u-boot-spl.bin
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
-
-
-.. Jagan Teki <jagan@amarulasolutions.com>
-.. Wednesday 28 October 2020 06:47:26 PM IST
--
2.39.5

