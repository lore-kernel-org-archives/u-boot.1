Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA972C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F621807EE;
	Tue,  4 Mar 2025 17:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a5TmeFBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C1B80BAA; Tue,  4 Mar 2025 17:57:33 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36918004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6fd9d9ae47cso4641897b3.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741107450; x=1741712250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Agiyvq1hbSMq1pER9vwekFMySRF4CVI94m3YdhRSjXs=;
 b=a5TmeFBdaoZ+RoNqln5tFxydVrqSLBqudj+tmtjYmhArOwfi6IU2AUfJV5JQvVLT+k
 b0hiMT+dZjTamuN+fwodn88BmKux3vetLf5q0Gk+kuK3wa/JCTB0eteSqD5K/d24uLy4
 bL7vlbeIHFO/siMFRSufcMlbUOXJkEMwEpmxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107450; x=1741712250;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Agiyvq1hbSMq1pER9vwekFMySRF4CVI94m3YdhRSjXs=;
 b=JTAbP/t/S4eypeuO13GKsfFjYjpfvi6D9AoU1TVjddK0GAm6LoK2aSxbpzhWcY28o2
 Go+gRcj3taK8r7CRLq3GTR+Opw4mqi6WpOl6dIJkJU5GX3KXmUpKRdFVfIq9wmtT4Agj
 AH/Nm85QxwX9YCP290yYRSk5Uioc8BIx/gzBZSj7v66btMBcn29RdmoNjWzkEw88O5H/
 99ERefpazAJPq1vADdwGSFGNivYdn41ST//rH4frUNiyO+rK/xwRFa7cLcfI4vna3DHy
 42FjjiZO7MQR4b5wMaVfJSeucuu7J1PVfnjzhWEH8BxdCR04hkdzvk/7LD5ZSb40W3da
 KC4A==
X-Gm-Message-State: AOJu0YzRiAB44wUhLSHtN0tu7W7/S2A0OTdLOHr4zd5NmQuQ3C2P762r
 ceXJ0Re81f7neMKuByG0vDmlri48HN3Yt+0M6FUs06/MSVJoeiNgf2kL/uXpCu8=
X-Gm-Gg: ASbGncsBSj91I+FanecSeMjQc26/noI36Rnz1UX4fY95YCWcYTd4NURkyDEPHE+dopj
 W1D06pYeU5ZCHOkzpiWv4gGLKDM0OmVk70yN11GQlp3MfMuOiU8sk9uFy5CYipy/JJ83Mf1oW8Z
 xKuORIm8+GqKQbWV+JERy9bF5x2likyM0JP96L7ywkuUS4a3HlBadd4a5RrIAuFc9ZR7o1ldAfw
 1QdYJ1VnhY/6HbJfKW/jSoWH3CMR7IvqJJ7qwzXIax9fuq2+68ryra04QfvJg0osOg1PgBlbdLf
 7vFU7sGctOzVsLEBYdIUkjPSA1vzWoJ4N/ogTNFn8g==
X-Google-Smtp-Source: AGHT+IHzr66EAS47TA+pKIs2YV8zdpnHjH24WHSzdoUZXkA3ROAwrlYLQjzeI09Hz+4MCCIx9sB43Q==
X-Received: by 2002:a05:690c:3686:b0:6f9:b0a6:6a15 with SMTP id
 00721157ae682-6fd4a102c24mr250655467b3.38.1741107450501; 
 Tue, 04 Mar 2025 08:57:30 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb9f7casm25268957b3.108.2025.03.04.08.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:57:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250228192830.27585-1-malysagreg@gmail.com>
References: <20250228192830.27585-1-malysagreg@gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update contact information for Greg Malysa
Message-Id: <174110744854.1812793.14995503791107731747.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 10:57:28 -0600
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

On Fri, 28 Feb 2025 14:28:27 -0500, Greg Malysa wrote:

> My previous address is no longer accessible, but I will continue to be
> involved in maintaining the ADI sc5xx platforms. This updates my contact
> information and hopefully avoids bouncing emails from other developers.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


