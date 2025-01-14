Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19AFE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 21:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6BC806B7;
	Tue, 14 Jan 2025 22:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pNtquZ9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A798069D; Tue, 14 Jan 2025 22:29:11 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828C88022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 22:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b98a2e3b3eso330898285a.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736890147; x=1737494947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hxodn4dvrGXCrK+Vr0Od7GBEw0iqywODBL93OnVIu3s=;
 b=pNtquZ9N7J+rLcCcrSxi05MxY/SxjiGqITHJkSOAuEG8VPWWaEGOvutBxWymTtAV8r
 GiCz1cuLNF6IrXoLO2VPB9xPx1qKjV7/5pVYVyctuPwS4LPkgnzZHzPLmBIEBLoZYxD3
 tpfg+KeycW3fpr/GOYS2R3ZIA7fs94jWVYnT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736890147; x=1737494947;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hxodn4dvrGXCrK+Vr0Od7GBEw0iqywODBL93OnVIu3s=;
 b=SElM/Pkbe9SSzU+TEgGgNNUmqsUqXRtWtq+wlMeylhGf5yRXTcSy+8Aq0/qYy8w7yC
 URjPjLr0rIYHOyrdq1CCREVGyQ/SqonbLNA5MH/6S4CIb/t28Ekl4XXukti2bqRxZr7q
 FROq5o6tj3MYD7qjJuT2oCp/AjaHivic0W7uHDItzhMzFcDlNmVELypVbDQLSikJ2Zfs
 Hw8B6PQhLOKSPfdlUaoX6wYeye6UIBHUJJxkY0dw7prgm22hoStlGGGCM17kTvasRF7E
 XB04sHFpMdRUt8IzzaScKzHexCGHBcFuus8nWhWnKBg5KL34HGrLmC5vYGIGtqPe/vcp
 +6Rg==
X-Gm-Message-State: AOJu0Yxu7A1nVrBmc2aLlTfcWgKL0SlqFJThnq+V2u7eXorzGRGvyJLe
 euYyqyvWmrBTFki/rI3XhKOkifL5tsr+3X+vfTZcWTpV/I97mvYK5EwVoR23oXQ=
X-Gm-Gg: ASbGncu+EVtqSNCfyL7VBktvqlWq2uYD56qxW9zuC1vYz/wKZOUECzJxBMayCvTECis
 DR4wEkH9U/Yg5wFIpSc8eySlrxPMNwoBS8E4mlr8KnshMYXlOOKh8Ckt7sV3IBrDZwXaKRGNzhw
 KmSlJ7w0bze4vV+h1Xfu0M3kIhFAMIihuKxRhGqRfPMG1TyMdpNuSJ1/hRNHT+05TV7IxAzbgK4
 B/cL0wzgvLVsZVOjtdk7Ogtqy/E9AhUum6Zq2CmctiLc243/Ozr
X-Google-Smtp-Source: AGHT+IFImLW/cY36w7AzELoXGp0EU+SFQ5Q9U+4740KaRC5WFMP9/2ORNIwm/DFKlZyJ1smRT9OpNQ==
X-Received: by 2002:a05:620a:4721:b0:7b6:cd90:c0e1 with SMTP id
 af79cd13be357-7bcd971a16bmr3626224485a.37.1736890147395; 
 Tue, 14 Jan 2025 13:29:07 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce324826esm642891285a.41.2025.01.14.13.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 13:29:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Svyatoslav <clamor95@gmail.com>, Marek Vasut <marex@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <20241120153642.861633-1-sjg@chromium.org>
References: <20241120153642.861633-1-sjg@chromium.org>
Subject: Re: [PATCH v3 0/3] Adjust how autoprobe is implemented
Message-Id: <173689014483.93138.17921853829552422063.b4-ty@konsulko.com>
Date: Tue, 14 Jan 2025 15:29:04 -0600
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

On Wed, 20 Nov 2024 08:36:38 -0700, Simon Glass wrote:

> This little series makes a minor change to how autoprobe is
> implemeneted, as discussed on the list:
> 
>    https://patchwork.ozlabs.org/project/uboot/patch/
>       20240626235717.272219-1-marex@denx.de/
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


