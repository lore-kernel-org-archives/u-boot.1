Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89577C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6CA80AE6;
	Mon, 10 Feb 2025 21:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P/pIYf6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F92F80842; Mon, 10 Feb 2025 21:38:47 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE5F803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5b22d35268so4284009276.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219923; x=1739824723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quEHpOAWAzl0E12lVz5NM4gGbFxNc3zt29KGJMgD3vI=;
 b=P/pIYf6wpAdEjzN10fWzq3kQl5XNQF18TCVOXaHHF5kXgumPuXMWjdnQsXSSItTVo3
 x7t+o4nYvEviu2f3GT8gWEMDCek5MR5ri5fSmd64BlSrq6gkFVcdj2GgS7I0eWM8CSkK
 QGTIiTeCtnPj8OPWEqJg8iwhbm7J6tlDY1kLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219923; x=1739824723;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quEHpOAWAzl0E12lVz5NM4gGbFxNc3zt29KGJMgD3vI=;
 b=f73gIWEpTSgSnOppkQf9m3ji2wVryni2Iex63QsDHjENgw2r5s519k9puqPCfC2spx
 tdfm8Cj5GGS9bhgDacUTepcHUImxYxqx5poHpJsrPCjffLeh4d92YHB63/mF4dNTV/Zu
 V/TH6DO7hpO2zA6/i5hlvwvLZHPhqlyoyuML8WAxxNThXQIcGJ3LI1Omhxriz8F9vkdi
 wn99QwNiCEYOK4YuY0Y1YnWwfkvqfx00IdYFmy5ouerX7oXmRNutWt8dpZIotyLyt0Ew
 B2mqwDnFOYtDfyHjP/aYF5x9Y/eiMeCyi2fMCEDsK47e+4U5IEJqDtMEC3pkf/CnPg5J
 JPxg==
X-Gm-Message-State: AOJu0YwJoA0cOReUWIIE8ob9DwkUtGfj6fq8ZTkwy9uVgIX1zIFR2Laq
 kyMdgEcO1BUwM02Y4PmSPKBB6AN1S8GPSKZyJKrAsPXwWQL74qSUXWTXPbf2aGGsGa5uwSJYA90
 o
X-Gm-Gg: ASbGncsfw4Yp0Xe2u6WIvPa6n2NvtVJKl2s1jd7f335d7+W+giQUJZYivxYBLSWCxI7
 y0G0/qQ5f5uNHIw1kuzTaKdV+knu/b2odpHXEI40/+zbjj2aN59yDDyUrvVqUT8f7pfdMu3zL04
 egR9n64nfXGKPQJGIHzHkJi62KGFu00BioIQhdUpU9rqSkhPIwp4wIo0LJBrK+Mdv2/0ycHw2lD
 9fctFL/w1RD18WfPTatV29kweE2Cyd/IvOvOGqmv/f9ZN85Q8RJpdNHY10Ji+9rdJ68ATEq0SIg
 XFlffvcH8e3byQ==
X-Google-Smtp-Source: AGHT+IH7GXBG7sXVX41OE3iqj3ONJlFLFQ7c6OrOPBb8cqs76BXXNEwcioE+RP2qH1CZ5J0vSt92YQ==
X-Received: by 2002:a05:690c:3607:b0:6f9:50ed:e6eb with SMTP id
 00721157ae682-6f9b29e4d7fmr127939567b3.27.1739219923529; 
 Mon, 10 Feb 2025 12:38:43 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250206004128.153430-1-weijie.gao@mediatek.com>
References: <20250206004128.153430-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH, RESEND] mediatek: mt7986: rename pinctrl to pio in
 mt7986-u-boot.dtsi
Message-Id: <173921992248.2921783.4963712403564363231.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:42 -0600
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

On Thu, 06 Feb 2025 08:41:28 +0800, Weijie Gao wrote:

> The change from pinctrl to pio was missing in mt7986-u-boot.dtsi and will
> cause build failure. Now fix it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


