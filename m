Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30892D711A1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8E880433;
	Thu, 18 Dec 2025 20:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TmrSoTvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C543A8334F; Thu, 18 Dec 2025 20:52:01 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74CB8003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-656d9230cf2so516590eaf.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766087517; x=1766692317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Aov3HGBDeOwaxqgWdaVTfItC3tt/Da5NQFW/abnS7o=;
 b=TmrSoTvZzoplNcLV+hsoe0+sFgfxssmez7EtSxb+hg6fd2ZCB4QtZItbGjagNE27rW
 yFj/5WjsZ264gLa6nL3Ckhp7AIq1quenLOG8Bdw0GBW8MlqgZS1ufIQ/Hcy2xgX8lKzL
 F6cv9qzMubOBqZ+nrUtdA4g/2D5AnK0u2Tf+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087517; x=1766692317;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Aov3HGBDeOwaxqgWdaVTfItC3tt/Da5NQFW/abnS7o=;
 b=QwDWpTKbXoDAsJMf5T+tK0DNEJp9aqC3qiirQQz3ekS4TqRGy/9/4nl0Ar6dAV2bzZ
 8oMReB67J1e2p0t0XJl+jMwM19tIXg0fvTDCbcoHIyMu2wjuzqxhIEAIZnHUhbA5imGB
 XAx1/5ewryU02bKDAyoaSRvTKJwnwTIHULsIpV/3+dd9TGJiFjaeWwvp8btbdmD20qtf
 GM9vuWXfp28i9XTFwZIWRZuWSCg0iF2hhTyZY5OJlK79Kjb4ocuuYjN3+LCzV7yd13ku
 rQlXRF2nYbI+gfAie1vYKc5DtTBKxqgtCmop6dRAOs2tfSzOZFNnDNtuiOqWcOZ9SeBG
 f0mQ==
X-Gm-Message-State: AOJu0YzYBcfOJc+JEN8MMe55FQEWQFyUYmhSSeqkEZkWuqDKWOGu7wG8
 cyPrc3Ws/XELaehIkfrDJwkJXGd03HGI26EDyyDN7patZxSR5G1664o7/rlStSiCGsvGI4bQOv4
 +klwKSDc=
X-Gm-Gg: AY/fxX4oCwdbD7uKmLKl/O9KbFr4WSKyAImd/uLzOpqJ7DEyn9eZhs3bUhz9JtRumrT
 KS/3z1P7TssbfMZ3YQydt7l6BfytgbaElRm8h5MuMZCerSns2R7tsCUmGw2rqJDGnmyMSAN02I/
 +PePR/FoYg6pKkMNIcp6/ES9NKzuoDz+OR/fiox4SminYom4OkIXLiM/J7CRkOdbnwFZZ2iXBV5
 nbI1wvqplOvVN36DUkK/6Vjfp5xvq20adLTnBkX5pBtjNKhLIWgoKkWET7O0sjDD27uhWwxJXIl
 NIXyaed9i4grwDkH1dsGmL7zJ9xEW5QUBBRxkJFYg+uk3C4xOWFta19RbGrFXc5kvx6dE66hGLF
 DgF4g9cgDpBjeFkcvtzzXARejQO7+o54m/xZTj7SHyt1CQEUEhHG6EeVgN+w4f1RrAKzNsaVXdc
 c4q0VuZgMcDQ82o23GxU4dy2RAaslGNSt/Ba/mEmpcgV3W2UaK
X-Google-Smtp-Source: AGHT+IFPzqGc8EamLZotRPFrk/r2hklxq1XOWC6EoDsGGkzgvdeGsJAfN4oOIS6PIlUNgCGoAU0wRw==
X-Received: by 2002:a05:6820:1ca0:b0:659:9a49:8fb0 with SMTP id
 006d021491bc7-65d0eb2ffbcmr286769eaf.41.1766087517445; 
 Thu, 18 Dec 2025 11:51:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f710763sm181837eaf.16.2025.12.18.11.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:51:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
In-Reply-To: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
References: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cmd: nvedit: Validate argument count before use
Message-Id: <176608751677.3734627.8204043051416660907.b4-ty@konsulko.com>
Date: Thu, 18 Dec 2025 13:51:56 -0600
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

On Wed, 17 Dec 2025 20:57:38 +0100, Marek Vasut wrote:

> Avoid NULL pointer dereference in case 'env select' is invoked
> without parameters, check the arg count and make sure it is at
> least 2, otherwise print usage.
> 
> The crash is easy to trigger e.g. in sandbox:
> $ ./u-boot -Tc "env select"
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: nvedit: Validate argument count before use
      commit: 2333d446b7b133ddfb9dea2d53996d560796ecd9
-- 
Tom


