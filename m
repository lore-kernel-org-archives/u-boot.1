Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BAFD6DDCB
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7FF89355;
	Fri, 15 Nov 2024 05:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j9iud9/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F01289353; Fri, 15 Nov 2024 05:27:38 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483A089326
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-50d32d82bd8so131863e0c.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644855; x=1732249655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0csZqWCb3rB6MlHL5zYpUI1yWINbnSXMJxL4ul4Gj0=;
 b=j9iud9/T5xR85Cnx1BSn/K6FIS9vnMO7B0xnzC/Bvf1wQVVJGvqXt97xEsTKioTQCm
 zmC5oClcrwsgYOiEQI/6+N0AYHPrUhENm3mi2vbcqCpDRAlOtWcT634gul/f2WxVMwQ9
 9jadtZMN1/bwiuJZPlEL3+CcA2dPNuOsUob0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644855; x=1732249655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0csZqWCb3rB6MlHL5zYpUI1yWINbnSXMJxL4ul4Gj0=;
 b=KxEacE0uKcOWR3HcZ4bMIqi5J7FbZm6mIesWBsZkA2bd+z26ZPT4x3ycLqTv7insaF
 wE4TcFRy5Dgt6jeWt9KJM2pewlnmX07ai9qbq0TSF+fzbKGH9J5kNbIce//IR7pQQ6B3
 zatQ8TkTmYaHdBha8EirwNOkrHAdKMOYELGZ+I4MGG1VRzvOm4cKf2SxFQd3liA0dheu
 TUJYUJKDEkSgsfvg8zztahgfZiub0IJkniPCTGilvuXR/RRTPXSsg/5kUWkuE2Zt+nL3
 PenFGOCo3XSbgI8DFOUq4CNd8+wfIllLH6J90MBfL73M5SxccH1b/PaSKM4jtoZIAD5Q
 QtTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUbAk9Kh4Ktlrg1Y/XVmfwS6RU6jYy9WlbfPIzINEryVgyA39UasZm6G1iMsC+Te7TTZ8hWdc=@lists.denx.de
X-Gm-Message-State: AOJu0YzUUth4HqOW8NTpgrXO8tWTEQXedk1LXY+9Czrefap5cAXPnLcd
 9NnOCY8rLTXbHQSGWzDcp8MlgYBeSEYTOqBGHiDLx38Xe/u0fLtxK4GstxygGIo=
X-Google-Smtp-Source: AGHT+IHlZw1E29pQOIQzHlGel3oieh4PpcNYbfnuWe/5P/4VT9TkzILR0O9wwDaebCZynn8khOgUuA==
X-Received: by 2002:a05:6102:32ce:b0:4ad:5c22:8412 with SMTP id
 ada2fe7eead31-4ad62c3fe59mr1690705137.17.1731644855139; 
 Thu, 14 Nov 2024 20:27:35 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjd@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
References: <20241111-mk_arch-ccache-v1-1-e27f5f605bc4@cherry.de>
Subject: Re: [PATCH] Makefile: fix empty MK_ARCH when using ccache
Message-Id: <173164485273.1205089.3627584232848095781.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:32 -0600
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

On Mon, 11 Nov 2024 14:20:49 +0100, Quentin Schulz wrote:

> One can use ccache by prefixing the typical CROSS_COMPILE value with
> "ccache " (e.g. "ccache aarch64-gnu-linux-" for Aarch64). This however
> makes the MK_ARCH empty because sed won't find a match anymore since it
> expects the CROSS_COMPILE value to start with the actual toolchain (with
> an unlimited number of white spaces before).
> 
> This is failing builds since commit 7506c1566998 ("sandbox: Report host
> default-filename in native mode").
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


