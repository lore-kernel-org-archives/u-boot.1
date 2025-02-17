Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26B2C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285AA80F16;
	Mon, 17 Feb 2025 20:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VHlJ43y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3B180F57; Mon, 17 Feb 2025 20:23:28 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C1E80BAD
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220c665ef4cso68780125ad.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739820204; x=1740425004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9Q3r3VhLlxXOi7I96iQMwgibEUN7RWnwshoblJft0I=;
 b=VHlJ43y6+Q5v9w4bKEuikmSNrPWZPS/T8RQwCMl9/EhSlxM8cNVYlJTsUih1DKkAsd
 tPugt8SrLNNlbcbTVG2KUzYKwJLrdKYeB4qjMIAAg1PlbsSg0oxZC/0etm96PnhK2I3Y
 tC72AqVxfe7pJWnOlBzAVFa9+RENGli9f2Pto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820204; x=1740425004;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9Q3r3VhLlxXOi7I96iQMwgibEUN7RWnwshoblJft0I=;
 b=qMfS0rJpqtVfbB6zt4sy2+/SYtY3LcJX4ckSR5W991KRuIIeR94WRujYGZF6cU9ZKr
 c9fTxHcDp4fvl4zwCOVT0S8uqjFWijpBwzsgeJ+lk9Ob6otcBFyNdT0POGcH5XYi/+a/
 MJ2pitKgPoRRbfMbyfAB7+W4o5RNXkUZHGKz8pp2SqtFd7f/u8r6f3fiZ+Zubsx3DuYO
 awENUmWdJJa9wcZDzNACcNgZZwpdmSts3CIC53g62u5vyZhPqY5OjBQ95gI6qI8VkirY
 GMhYPLOw3+O2crI9QI7Z2NvizH/+ixyPFGUyb5Bzfurw/InJLt111E2ahRSYCa88n7QC
 nlPg==
X-Gm-Message-State: AOJu0YxwOF5eV0c7CjI/Ws4CTrkENOF2O/6/Sj3NgBAHW6WPPSYAAw8Z
 yXixkYyxQAVWMp+X/IadJ24eOzwmx4B1tFW54fLO+000JiqQiksIZUdU5qEyALcVieB88RYpskr
 M
X-Gm-Gg: ASbGncuJSwhs4FOg3LkH1zFxtnrwDahVxNGhIrXAJ3DqWdToeFr82iTtrdxNBxfUFLS
 28tZPXXnwXaPFW/SljF5jZSnAbltm0lZ10Gi6S+A5/hDgwAX0jAJTurA0l7gP9NS4/M8LAtYTWH
 3KjPhiukvRgbJFWFDoHM0peyC5OhI+ujOREB6oR8q03ncb8hI1mbhatoUZo9ppRhGtUIN8aFngv
 4CwlLzZKN82qq8lxy8EFIG/XikapUdxpCpW+yppKlVmt2upKklLiQB70A2Gyki6MtTkfiJLD9oi
 sBD5T3uOdOD0
X-Google-Smtp-Source: AGHT+IFMSFrk4AQgdrIivkOcg3VZvFBCwI+wpqg+65j59IajfLNtlbB7JDtxrfNv31+vU3IZ5xtz/g==
X-Received: by 2002:a05:6a00:124f:b0:730:95f1:53ca with SMTP id
 d2e1a72fcca58-732617a290emr15516492b3a.10.1739820203302; 
 Mon, 17 Feb 2025 11:23:23 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326973705fsm4504518b3a.7.2025.02.17.11.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:23:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250209212714.2317040-1-sjg@chromium.org>
References: <20250209212714.2317040-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 1/2] u_boot_pylib: Move gitutil into the library
Message-Id: <173982020205.352489.3501675853235178553.b4-ty@konsulko.com>
Date: Mon, 17 Feb 2025 13:23:22 -0600
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

On Sun, 09 Feb 2025 14:26:00 -0700, Simon Glass wrote:

> Move this file into U-Boot's Python library, so that it is no-longer
> part of patman.
> 
> This makes a start on:
> 
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/35
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


