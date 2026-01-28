Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5219D46BF8
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 20:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB2383C6E;
	Wed, 28 Jan 2026 21:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yjk1n6Rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3A483E0E; Wed, 28 Jan 2026 21:18:57 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED4583C6E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 21:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45f126d47b8so195475b6e.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769631534; x=1770236334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gA8JAmzhO1LoHfBT/YqZzf85FMNitdt/+Fwl2LGsPxY=;
 b=Yjk1n6Rl4Tkz9kamJ0/7sXgHsxnxFJAmhRBdEP2KEnii2XUMpaaNIcHUFbWEm3Ea/W
 uJ1F67IC/fCmuYYg2zpjG/ye5zzZZXLkhTQVv7Tylc68sRgQRfuywTLA/3XhUTu8mJTp
 c3DnNvxvRDuMrB1DVakysb8EcV/tk9RSj3vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769631534; x=1770236334;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gA8JAmzhO1LoHfBT/YqZzf85FMNitdt/+Fwl2LGsPxY=;
 b=jtGY6rWg9RvZXBqmhz13FK7C+OYTHuG1QFjHM75B/tePoL9eBwHZ9fVAkFLD91AwmW
 9cAgCq7UaXvXn8kDFi7lruFQHVPH7Wspfxh8MJjr/7hCCPzpC0xAbcEagkjek6sg7Gg2
 6uvuvoy1dgUEUxoy4Nh+vLFFhvUsoOC+PSdbi7rIgf1KAgZXl6TYOb1YI4RnrvgeXap5
 h+YtyaejueoBZ0MmLQYr244EGktPFGpmalj46Si8RiRp+z2UdVc5+06eCscpg9Duoks6
 d0jbrU8a53xEHB+gowJqN322HJapuVqRNI9jyq3rpCRrnLjwH/nDEBJPaIE7YEUi3HPw
 LD1A==
X-Gm-Message-State: AOJu0YxceCzPESWkAqHAGZs4XWRGhkhOT1aZSCOwccB6ce5479t31Yxz
 hFhVz5lBLwaYQXPVtY0MKOiVAMovebxtWfHBzHerGNEHwOgnx6n4atrD7Pd4SCiMqBE=
X-Gm-Gg: AZuq6aI3LrnLNeksMjoCUI+JrKS1vV9saFX26YOESGzL3R5Uh4J4/NHrAdNpcTmwHEU
 hkFJOX+YSLsAQCNPuipNfLMr0PIxZgvO3Gv2CBNVGZieDMvdLMOm9yfs/l1+C7Rfgoazpvwijfz
 zU1XQK+Nysv8+JNdyGy4ArEJVNdgwdh6iYLVLpscwx9wRZuO8tNTwXc3TgNWmQ4NZ7NhG4ZL0Tw
 O8+XIMvARF1B0LwyNovdRGRyPZyAHDXqlmaW7vSQudAMy1Im1h++Ii/gfA+GrYbcAxTv16c2fFj
 RGe2ukfa2O7gEHkmr8plXxGMxk7IpiGiB0HW+m1OJRcvX8Im992GLL10FcbFWQGDZxnURBeH4w5
 INu6DbxptEwyUdgoezHRLNSbRC5ZqQ7x0ti6ufsK9NdpXbelm3QAogrh8494i2fav/8EeGX8YWB
 +qE5LeRSOLhqdpWcpiKV+TteIE//TpZ5+gC26Ux+Lh6ACzh9aoe+t3BfsvUpckY4wL6tfYHvJ8S
 13My2kWUql8zoVGVMeDgP6AavPv39fqGanOew==
X-Received: by 2002:a05:6808:3022:b0:45f:1ce9:3ade with SMTP id
 5614622812f47-45f1ce940e5mr544307b6e.19.1769631534508; 
 Wed, 28 Jan 2026 12:18:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb82f5sm1799991b6e.22.2026.01.28.12.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 12:18:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260121151930.566075-1-trini@konsulko.com>
References: <20260121151930.566075-1-trini@konsulko.com>
Subject: Re: [PATCH] .b4-config: Add some patchwork related settings
Message-Id: <176963153305.1736087.7951734896856315148.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 14:18:53 -0600
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

On Wed, 21 Jan 2026 09:19:30 -0600, Tom Rini wrote:

> To make it easier for custodians to use b4 with patchwork, add some
> defaults to the in-tree .b4-config. The API key will still have to be
> configured.
> 
> 

Applied to u-boot/master, thanks!

[1/1] .b4-config: Add some patchwork related settings
      commit: 8e263e3a76e353f0e7e559a4c82fcab2e488d8d5
-- 
Tom


