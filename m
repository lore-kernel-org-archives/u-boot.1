Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CE3D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9A588915F;
	Fri, 18 Oct 2024 01:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q8HrTzPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F6C89121; Fri, 18 Oct 2024 01:12:11 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE8589068
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe700dcc3so9335736d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206728; x=1729811528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ep+3yh9KSkA5VaxlQpJV244Z3ESBMvgAvhEEviraaNQ=;
 b=Q8HrTzPVE1TuYMnj7pCoexIThkNMBKWdv8SjltngS4dhiCeIX41rvXAviME0EQimqJ
 5WxxsbkZ+RCSX39h9aokPQ+M6S+aAnyr+ks2uuPBwMmVs8nFF8UjqU0F8jQPJ2nbeduL
 pNsoCPVXHuhE/zx5SzihLUTArY5NBtMCLXuIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206728; x=1729811528;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ep+3yh9KSkA5VaxlQpJV244Z3ESBMvgAvhEEviraaNQ=;
 b=ppCIeUrlMg/TlOvSZNJmYMcPNgl3/dPPH0yPv0G30JRaMfW1aJ/yFQd0y4iqkE2HZH
 t+MJC4GZck0cHg4SUSVShpFpE66Z+W7pHETFWg6U7bnPFQHH3tgCbLf9AoXgwyz1hcax
 ML9QygVUBALlZoO6UPT3LOheDRjqwHeuUGAUMKHDdp4uIGrZ4W1kSRd8o3fgeVV4Jbh7
 qFZt6IWEVhBAOM0qBhdZKiZqyW66W00eY5kM9Xg3N2Ap2oIB1a4s8rSRMrZjzCTmEH9I
 y1qC/sTHJNq73L/jzXec4Marxu5x7RUzzoWJNivZgb4ZWzVBuSj48NihhlXYmhyZRtYs
 odaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB2lu7LZ43hZly4ATxmAVLMt+/5HcHEZosOr/0gZlrfT+nuHhwKvgKfKrkvyxvs5CJzEsoly4=@lists.denx.de
X-Gm-Message-State: AOJu0YyL+1ISRmBr3AgwnN27Tk/DBoV+P/2F1DeLtPp4CPmMnFymZI58
 laFt/CbCg7ve5p5I9kuHBuBgqJvdjRwuL641Y6to06lw7Bpe4lmElqhthF01epViUDIfAdIaEmI
 igOqAoz25cyRtCpcuqUSQAXVlIuskRZa5jQebEWLkIZHEGuU=
X-Google-Smtp-Source: AGHT+IFlnmtFfY3Oxe+4Bx3Tp2+40fFOpCfYkTiP+nNzN0o/FiPp+qiKGJXeGCZrQq1I2cT2cEVDxc3R1xBvCcfTdKs=
X-Received: by 2002:a05:6214:3f86:b0:6cc:b4:5dcb with SMTP id
 6a1803df08f44-6cde1639b87mr11527736d6.47.1729206728351; Thu, 17 Oct 2024
 16:12:08 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:08 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828201355.1111764-3-sjg@chromium.org>
References: <20240828201355.1111764-3-sjg@chromium.org>
 <20240828201355.1111764-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:08 -0700
X-Google-Sender-Auth: 0gTy9uVukZ2YVbKg-srp48rQOdU
Message-ID: <CAFLszTjeFDvf3teruKw1X5y4NBpRmkv3AMb-a_rELGeg8p+KpQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86: coreboot: Enable receiving timestamps from
 coreboot
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Bring this information into bootstage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/coreboot_defconfig | 2 ++
 1 file changed, 2 insertions(+)

Applied to u-boot-dm, thanks!
