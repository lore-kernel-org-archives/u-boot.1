Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A21C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F84183102;
	Thu, 29 May 2025 19:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kMziBc43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6E683108; Thu, 29 May 2025 19:55:20 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9A383102
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4e4564178bcso1441338137.1
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541317; x=1749146117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiVP0wrihqDYBclFXDSsB7l5KUtBqKpQniT11EgB2HM=;
 b=kMziBc43aWEQXYG4fxGJdKSO7c7A0N8govHwldYqfiwQtBIvhk+7A6WcwRJizO0Pc6
 odUsuz+Z9eWMDNSKGtSabOvHipEsFqptC47qihMMN3b7Fw0SZk34ITwhBDafx6/ESOqR
 Lq2xvxAOmp/2ul7968PMYtfAfEMF1QEpshFHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541317; x=1749146117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiVP0wrihqDYBclFXDSsB7l5KUtBqKpQniT11EgB2HM=;
 b=rm3wf4G0OqwdsBxjt7GgiEd9dFQjwHUdDqMnNiBBZRmOiGL5o19t7Ckx6k2e8+4ton
 s+iwIBf2qb+wgi/O8V7mOS+fxEqcH5HgKyEkUurLKEy7JtFSexidP7sbyHJdn5g84K40
 ta6FVAH0CabYEoTfkyfEzJbt8iO3uJ+eMHh5W8Qq/nIJq4RBRK2X9PKFYohF81FC2t1w
 vhbDqcv7BgGtoJfjfouvadDQ740fggk7yINJFtrDOS68bFar4BBb3OR2jTrGKXlF4gao
 Y3f+0ftOFJ48hY/N6zAHeKj63P10J8dndsbN5oRF0x0ybPA06Q+t3avXKitaUeZ/+PC0
 ENbw==
X-Gm-Message-State: AOJu0YybOSP4eZFn5cBlb10nHkMseekMhCb0q3/xP6rzv5UtCEc3d5wL
 1pOGwD46XBfeoiYRqmypqPtPOJ4ROi8LR7EuQQiGQ3Y7it5xMdyakj5ZcoqqAH245l+BQEXPVnv
 U7xwhZF8=
X-Gm-Gg: ASbGncucPJahdOWJg8A3Y8bvPg4mQDFh803CroK4FoUCW90+qh8yjakCXmhWxXD0BzR
 2+UrXJi4GbTLH2kl2MBHe5CT8wuAFGLi3vVsE3esFNovh7E0mvAsmsGGfxf0ePg0l0FsOC3+3X4
 mWsyxuj0CSrCVlgsSMqoKDKXchUbXrA9cXCN2ZQVRmAPaBZYJvY1QLlpdOndsqhdoKUcJoBOHbF
 eep8gjMdJ6if3oh9LkZlaheGw7SNoMYz+bb25m9J3VuaerKLOWALYRNB4dNDmv8pjIf+3yQxKc+
 Dx4V0kjfHnQhdRHIvBIQeZW8DAqx2kMPH/LzzwyP52AxBBM9cM/HxsrC+AUxb0z77J8si6yDYhi
 wAWi5AcFDdlw=
X-Google-Smtp-Source: AGHT+IEZdsjcMbsLU30Q5fiQTqruVnghtKmjN5VFOthkXhA6fnEYP/hFoy2f/UWt2NXtUZxqU9JObQ==
X-Received: by 2002:a05:6870:8a2b:b0:2d4:e8ce:7bcc with SMTP id
 586e51a60fabf-2e8fc90aff1mr2435238fac.8.1748541305750; 
 Thu, 29 May 2025 10:55:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c42c16sm77455eaf.7.2025.05.29.10.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:55:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: sjg@chromium.org, bb@ti.com, ilias.apalodimas@linaro.org, n-francis@ti.com
In-Reply-To: <20250515111554.2916254-1-w.egorov@phytec.de>
References: <20250515111554.2916254-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/2] Print Reset Reason for K3 based devices
Message-Id: <174854130448.3917659.3006587963052818010.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 11:55:04 -0600
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

On Thu, 15 May 2025 13:15:52 +0200, Wadim Egorov wrote:

> Although AM62x, AM62Ax, AM64x, and AM62Px share the same register for
> reset reason, not all TRMs document this consistently. To avoid relying
> on undocumented behavior, introduce SoC-specific implementations for
> now. If TI confirms all SoCs share the same register, this can be moved to
> common.c for reuse.
> 
> It will be mostly copy&paste for the mentioned devices.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: mach-k3: Detect and print reset reason
      commit: a282950debce20035cc12672c856ff2d70326ad4
[2/2] arm: mach-k3: am62x: Implement get_reset_reason()
      commit: be93c0892d0f0bf83ac669678e01ae27f798738e
-- 
Tom


