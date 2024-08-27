Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BC5C5473F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8120A88ABA;
	Wed, 28 Aug 2024 01:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cIKXEzy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B7388A74; Wed, 28 Aug 2024 01:22:58 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777F688A9D
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5da686531d3so4862986eaf.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800975; x=1725405775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+mJwVwSD6lhbG7lyixzWEoxo/DgfL7Llq1kCeWko9Y=;
 b=cIKXEzy/1FG5iLwRG8LMK511bRKTp5EGPB3rZZZi+vvbfSi4PM69CTySjbXWw6zn23
 2rOyoL9rZzO1iJyDzjFVv2QW4TfUEvKvyBNPm9McwmQc+rw/u1ufZUkm4AjcwCCOK7gP
 Uo+wQ4sR99xMW5j3/+lOJkOiETfsxnwzgXT4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800975; x=1725405775;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+mJwVwSD6lhbG7lyixzWEoxo/DgfL7Llq1kCeWko9Y=;
 b=fGfV1E/8R8iyowJXKHE/3BrN1vRuxOMbbang9RN6ErOzuU0NpCG5UXRmVT1v43bIlb
 6/bst4VtcA3cUNoslGdVfjFQxn95OyHsyyMWeMN+3Z4C7/4opQ194rUpHqHccU/0sTW0
 Ef0u8oVd0G+cCT6rvHSAuQe4zpcHmvXDDCAS2CGJi4Y++Gg+edau//gN+mi2mRpRzOCn
 G6wtuguRk6TmS/GxG/gNtAaFPluMB6zZwJXhNQthdy3QyzZseP6zz228R0iMHcDmATnd
 hFCO7GMYQVJqnVs40tvDMUIXXJHBlMi2QjnvIoGl59z1QxAyv7uk6+SFO/TJgFceM+92
 Y2qA==
X-Gm-Message-State: AOJu0Yz5X41uMVI9OMcDgquR7xerlF/m1zMen/+zWoeiR3r6K1Mu//ov
 qq3VaxAc3OXJsfVIdSyQgsf9KgM4Jh0jVmW0wcJzTaJituodaRMvMn2I2j1sevo=
X-Google-Smtp-Source: AGHT+IHLGqSzSvQ0CIzLDLBeXwBlx8wUxTZnxPHaXsLVYTdCVme1mwP7FaQIKgYd1r3PlTbToesmkg==
X-Received: by 2002:a05:6358:2624:b0:1aa:b8ba:8e with SMTP id
 e5c5f4694b2df-1b5c3b30b5cmr1873194955d.22.1724800975165; 
 Tue, 27 Aug 2024 16:22:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240804150556.3519995-1-jonas@kwiboo.se>
References: <20240804150556.3519995-1-jonas@kwiboo.se>
Subject: Re: [PATCH 0/3] dm: core: Avoid multiple calls to fdt_parent_offset()
Message-Id: <172480097409.2972894.4613418527936197597.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 04 Aug 2024 15:05:48 +0000, Jonas Karlman wrote:

> Use of fdt_parent_offset() is very expensive as detailed by the function
> documentation:
> 
>   NOTE: This function is expensive, as it must scan the device tree
>   structure from the start to nodeoffset, *twice*.
> 
> This series remove multiple calls to fdt_parent_offset() or
> ofnode_get_parent() when instead a single call can be made and the
> returned value can be reused.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


