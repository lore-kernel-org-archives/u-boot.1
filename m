Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52FCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 17:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDDD83C29;
	Thu,  6 Nov 2025 17:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RDXA5R7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBF383BEB; Thu,  6 Nov 2025 17:59:51 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1020383C02
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c6d2ec149eso767323a34.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448388; x=1763053188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pfjkVDsP8Zbta9eLEcmty+ds6w9w+gbqDYnntTT/1/k=;
 b=RDXA5R7BrprMMhx9SAThjfw9USGBodRRuM2JI4bZhtaymVRPlHG3MnfJwTTpn6mAsU
 tV2w2PvCbmksyggjjVXK6dGmBTIQMG9epxAV+Ync8IADdGN80e9wn2r7K2BKiR3LTLEW
 zJe7Mj8IvvGd4yZ19rnsGBnTuvNcw7moZh1TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448388; x=1763053188;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pfjkVDsP8Zbta9eLEcmty+ds6w9w+gbqDYnntTT/1/k=;
 b=m0mKlLXTIqDNnSD7FAQwUfjBerCoKJfo0kOnfYaHuvyzBlN0zvlsAyaLqAA60V6MC4
 daQUh20zBHZDO5vccQ7nilSvuf18ES3Nvn/7WSCObWv6tKGMJkp3o0KMLMSUdwvad46F
 WUrWrfsg543hN0s3g4YERtzPExcs1Cu8dEsXB++c9FcllWWBb0+XgzreKnwnRJtmQyQ/
 eltdzyXR9Javl7/9R4CLVq6FSaWVX1wkpw//zVstKJZf2pOvdCsZwaclt+MbtFiDYHQC
 JciuzBMGYsOseqTxUtnx5LmAlGTIk9/V0pvF7vUFlqYzMAmZaexd/IeaY5tjFSMnkGlK
 rrWQ==
X-Gm-Message-State: AOJu0Yz1HGjMqjmkRfdoavMDVMGMV2SYOl6J4cXbSCJkBXYAB0MHESxI
 sO8ayglBYgt75rw229a8yTqWJ1yjUEEy51mYLvATCc6JPmr/ZIq1sUuK+Eel7rADGig=
X-Gm-Gg: ASbGncuRZpE9KecaC85T1gC6f9siR5Kgm473+FbIrl1Lc7A9qjGKBbXog3nzsa50Ttk
 j+xr6g2CoSR5c3G4R4xgB9bdFgZdcIvHqWRdKmndZa6YZ1uhmQc1g0aiwZqus0jBhshWB0BOC6r
 I53BLEq6l1NVGMxXcM9TuHeZF6SfQ/EilA6DAGAqrV99wfejLGX7IS9eXfbIO0fknDpxa1GKgLU
 Mpz0hr2BaSb9iUVcHbfr8y18Rxy5Mmf3PJvEZ8evDstPnTgY65tcJdiLzyjRBJUJPG5AW+b/GP+
 +les49M5dRgsR6PdZxN/h+meegW2Ei4+rxgCCXCyBk9rEHQoih3SoHOTgas7XM7QT6xl903OZt/
 7CVjrQg8MMGKbu4z2hLGRjJ+THzDBMQXA5jZZ0hXC7bkxPJES0YeB6zGKBCzx6wRyGf8fLULAxH
 M6ZWLbCbuGeMUi+bvNYSEn+cO3SdfGlfobi7ftTw==
X-Google-Smtp-Source: AGHT+IHwPhkzNZuIRDdRLFm+OueqgY4/QE9unEm6t13+1XlyjrAog0lgG8vDiPo/2LxIRR62gYExug==
X-Received: by 2002:a05:6830:b84:b0:7c6:9fcf:85d8 with SMTP id
 46e09a7af769-7c6efffc831mr162466a34.15.1762448387891; 
 Thu, 06 Nov 2025 08:59:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251103221214.3398735-1-trini@konsulko.com>
References: <20251103221214.3398735-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure: Ensure we do a shallow git clone
Message-Id: <176244838726.3056677.12871033603834129975.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:47 -0600
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

On Mon, 03 Nov 2025 16:12:14 -0600, Tom Rini wrote:

> In Azure, older pipelines such as ours do not default to a shallow fetch
> but rather do a complete clone. This introduces a marginal time increase
> in each task, but also more importantly takes up significant disk space.
> We are now getting warnings in some cases about using more than 95% of
> our available disk space so take this as a first easy step to resolve
> that problem.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Azure: Ensure we do a shallow git clone
      commit: 59f6025e5a6e46c9cf8b94cd6958bae78cd15d13
-- 
Tom


