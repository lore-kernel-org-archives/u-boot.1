Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D78C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 22:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB9882A1C;
	Sat, 10 May 2025 00:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qfjBfcOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FFB82952; Sat, 10 May 2025 00:49:57 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E8F8211F
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 00:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-403407e998eso1888811b6e.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746830994; x=1747435794; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0EHMsRlIiqQ1XgDS4oE00Y5e27J0Bt/og3WwwF4+2A=;
 b=qfjBfcOuPFyD2AMRLzSnEotok3UBuJHboZlwaeDRDZNJ009KtLwhj5gtRVWxmN0BCn
 bjRqIyaSxHbpqfY6TnkGsZK5UmU6NABMpmRLm8kfSxWn+f7yiI2c0h1NUxIi8JWOQ1C8
 vnWuBLqZY1lBM93Wh5J7Gpx/ce0tAqVWL7C8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746830994; x=1747435794;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0EHMsRlIiqQ1XgDS4oE00Y5e27J0Bt/og3WwwF4+2A=;
 b=vjGhwjrkn/9ZK9EIUre4TPMe4A5bvv+HlLTxqWxKPAl7ScoL+C7B11Fb/wEifyRHsn
 7z4N/tgVA9zCmm+kUoPcO+W3JjYdC3iYL1Vv6aOg3EdtWVsVyjGV55MiBOl9HNAn0K3I
 +BCjs7WPbY7Not3qKAIFytMjxdvLhKdKU+tgsFzbJ4NvVwf0z4H8CWyeHJhMRvepFtd7
 nH6t6sq445S028M4etrT20PKcJnlhH3+7M5/RiFs4Faz4wmUyLUFHKGvmUUp1UiYXEhy
 aGrWavMdYjKZ7e9INt+lLE/QnV9DW/akRKhn659tNqXQ4vQptiTwZV2g/Q6Sb78BMDk9
 30lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMLusyAN5c81y5qOg58P/ZpXmAbW2UDMXvKbFZlvo2CTj26rtCOjnb0WMALgfXRtTuDCjhyiE=@lists.denx.de
X-Gm-Message-State: AOJu0YyMNRrMCJvbjrbpVp1CdQsmhxYmPvM9SMKPFcvBoXn65pA/AU1C
 R3VYzhGEwZMZRNSLZ303+b5lBqs9xX7VPfOxWopbi+ajA20u+zjv9vz7sNoUlbY=
X-Gm-Gg: ASbGncuIsl5yfUgcNaYETI0cXmjA4jhuDLQFLAAfEjj9I9ze+IgW0BWx3KkhkD93FFO
 k1E1GexaVj9qnuQJQ+HpHnTmMh0TA54a3AnGodW6a/F6Vs+7LKJZqOjUwllCtrND7qBX+mBOesb
 68xuPPr7wYYl82fhZFpPYmG/WjVRmSOuakVQaHE2UhdEPnqjxCezOt9DPK+F87od0Ft9ojSzYCa
 TSwC+b3Lb7ncmR6nvl+LQTg7rjGHMRv/cOud/t1ECh8kWEMaVo3tzgRUs4DkrEqxcC624qdR/c5
 fETup4w/IlKw3ndZK4njKBTfBxu22wMqvswmunGPh3wGCvfOjzAOH7OhRPpqf0dqzQIj7WA6ESe
 NfuVV18jGgfY=
X-Google-Smtp-Source: AGHT+IHn35mNHQ+Fg3GDsA6O7MpPjJr4Od1t4EHBqccGXSapaQ8p2f4IQ6eX4lq4k0cWESSYpDGFMg==
X-Received: by 2002:a05:6871:780d:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2dba44e250amr3349878fac.30.1746830994395; 
 Fri, 09 May 2025 15:49:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b82571sm801403fac.49.2025.05.09.15.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:49:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20250505144314.299359-1-heinrich.schuchardt@canonical.com>
References: <20250505144314.299359-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Dockerfile: use lz4 instead of lz4-tools
Message-Id: <174683099317.770062.11505804857228184406.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 16:49:53 -0600
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

On Mon, 05 May 2025 16:43:14 +0200, Heinrich Schuchardt wrote:

> Since Ubuntu Jammy lz4-tools is only a virtual package which pulls in
> lz4 as dependency.
> 
> Update documentation too.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Dockerfile: use lz4 instead of lz4-tools
      commit: 285d265f7dcf7b5a8984d7015b07b2e86de91420
-- 
Tom


