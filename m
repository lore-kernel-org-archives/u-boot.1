Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC1FC47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F04C87BBA;
	Thu, 18 Jan 2024 15:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eo+DUqeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C6387BA8; Thu, 18 Jan 2024 15:05:20 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE56587835
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-681397137afso47999166d6.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705586716; x=1706191516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+HH0D03sxRuW121wsFLPImMxhfQrkoj6iYjmNoorTmU=;
 b=eo+DUqeqter91cKtb6gfWO3iqWsGMzyBMzaw6nohiHuj/uvAjgB+YosfuhJCk/usi+
 zqbAwazrPW1fMsbddyY+ZwlNQSkreXaHKglyzPJ8m6eAHYB2oocC0s9tN1jZ3WgCkyIG
 rmx23O7ba5eXZXcIWBEYwbLyVHk+PFSKlJVGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586716; x=1706191516;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HH0D03sxRuW121wsFLPImMxhfQrkoj6iYjmNoorTmU=;
 b=o/p2bCluZnlw16CA5luKX1CY2mBVZgktylv2eO3YJ7RksA0VuSXSKgyTjf3+K4eV0P
 TWgZ88bJoYv5iuW4hQXpMhrbclcPT73LYCCVevpZk17WVy7pllTffmph7DdjSIaOThPI
 I5LB3eSUZjVEUpqt17a4qsKE4N8LNpRTvd6AfEUMYc22P6cWgfQxAoOWZ65MGmW1S/gY
 MbYNH62TQUdTrwp4f8mo4nljCQXSZBwz/E8HZWTd26ktexhQIvRNMLk1PYh0JAD0nn6j
 G57Vz/F8nlG3RUkvXydig+63O7GAGsXDwMt9YAo4WNY14qVB443wLffolM6ylhtpVWhv
 vh+Q==
X-Gm-Message-State: AOJu0YwOWdJOTHChJPrCpmxGr65aGDYo79Im8ReUttU4LLIVh3M4HV+q
 6ELKa11+7m/RKkTI4x8DzByit3mCU35WjwJ/mljaUZOcIfwtF9f4MJLOfIAaBp0xvCYkGZ5Ojut
 3
X-Google-Smtp-Source: AGHT+IFTvdhXDw3NBVgvzBneG+LBfdx5YSS6zkE91yFZ1R4hXvQ5j1SmgdFkDtT9smR8EkjMteZ/qw==
X-Received: by 2002:a05:6214:124a:b0:681:6f4a:f0c6 with SMTP id
 r10-20020a056214124a00b006816f4af0c6mr725133qvv.56.1705586716451; 
 Thu, 18 Jan 2024 06:05:16 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 mm21-20020a0562145e9500b006817fd532absm1246316qvb.82.2024.01.18.06.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:05:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240117221236.2234826-1-trini@konsulko.com>
References: <20240117214357.2197351-1-trini@konsulko.com>
 <20240117221236.2234826-1-trini@konsulko.com>
Subject: Re: [PATCH] test: test_trace.py: Have trace-cmd report always use -l
Message-Id: <170558671533.2400148.11222147775241634007.b4-ty@konsulko.com>
Date: Thu, 18 Jan 2024 09:05:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 17 Jan 2024 17:12:36 -0500, Tom Rini wrote:

> With newer versions of trace-cmd the report subcommand will have
> different output from before if we do or do not pass -l. However, with
> the -l flag passed our put is consistent here. This updates our regular
> expressions and comments for this as well now.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


