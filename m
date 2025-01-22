Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587AEC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 21:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01D2801F5;
	Wed, 22 Jan 2025 22:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f+J6hpkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A2380586; Wed, 22 Jan 2025 22:01:00 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADB4803B5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-467b955e288so2201901cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737579657; x=1738184457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHKJb3KjBZn51az9EwMau4JaDxRMk38c/vIctkrDOkY=;
 b=f+J6hpkf8OsEetuKXcAWnrTmOVXRaL+6FPDTHwvyRWjSVnCmY4CvswGQ6cDsNo0D6/
 nKICXsjV7/FRUFLrH0UnoTWfjNsQDvrfYOVjfKvzLEAkaNWGrVyOQlzrERbBawkFPygO
 FEI9VXS00Xxliq9+0G1+bBeqwZkOimJelpNXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737579657; x=1738184457;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHKJb3KjBZn51az9EwMau4JaDxRMk38c/vIctkrDOkY=;
 b=Rv/Urlb9PeZvfSZB852XkYckRf93VezlpBh5cIaW9MHoFTlYuwO5zBcDZJtdhf4ii8
 mgtgnmybHJXLlT6F52pe4hLcp+Y8mSOEu9cSokv+KlHq8Xj3eu/MetJri19z7N/wGwmq
 g3FunwV3YTr4fT577HDWjXD8IxInls6WLD+BGWCVXTL1+x+GMjiKfPsU+Px58jZCy6mu
 gI7ddZY9HqxVQAJmFTjyB17eEwPiUpd27ULLbmdoPNWU46X5VUw+xEOBb4zjT54qqerQ
 UQZM3t5uAbh3r9ArASb2/HFC4ztmdu1ubMlYwnAIptKrvxiE2eyQNBOK/XVMacPdLQOz
 LJpg==
X-Gm-Message-State: AOJu0YwKEbs9GLdDGIfz54Si3PM1es8hPLaBckzZ80qDZHKAhCanAknJ
 a0y0A4QC6qat7SEwjPyed0D2SUFHKRUkNv3/+qXDK6RTpDBaOKCsXMVwZL23dJc=
X-Gm-Gg: ASbGncsB+GUPCBvPAev4CbpskuY0FMZK5XLdTrHLptOLwqo4u2do5ju5rsSjp75APQo
 vuH+suH4BgduptNAmQT0X6fYom9dyXFNPRW7xrmrYoLwYZ/PqOEAHc5YsIJEnCC47CvbdQLGOgu
 Tayi261z/tpHzdffHvrUtv7BHKM5DgdgMuNELQq+YP+CAZ7zbhZ0MXoGqdspHf1OeKAlTYM0frE
 6btV6orhT6FAo60CYjHaa+pH44McmqZoSwyzv3o+qvj0xMV9gT5aO5ZN5dvqouKP53A
X-Google-Smtp-Source: AGHT+IEkrmUXJzzAEUqY1aHObgSiaNETOT5KNHFh/itUgABLPG7H9YdB/lN/3u2S/CbmPfJhNvQSLQ==
X-Received: by 2002:a05:622a:94:b0:467:8017:4e85 with SMTP id
 d75a77b69052e-46e12a61bf8mr370771651cf.19.1737579656637; 
 Wed, 22 Jan 2025 13:00:56 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e10305328sm67560021cf.32.2025.01.22.13.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 13:00:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alexander Dahl <ada@thorsis.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
In-Reply-To: <20250115161621.1551826-1-ada@thorsis.com>
References: <20250115161621.1551826-1-ada@thorsis.com>
Subject: Re: [PATCH v2 0/2] spi: Collected fixes
Message-Id: <173757965555.68186.3605710432245420002.b4-ty@konsulko.com>
Date: Wed, 22 Jan 2025 15:00:55 -0600
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

On Wed, 15 Jan 2025 17:16:19 +0100, Alexander Dahl wrote:

> two patches for header issues I came across when working on (Q)SPI
> drivers for atmel boards.
> 
> Greets
> Alex
> 
> v1:
> - implicit, not a series but a single patch no one reacted to
> - Link: https://lore.kernel.org/u-boot/20241218160947.681253-1-ada@thorsis.com/
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


