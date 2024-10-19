Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D27D3E1A8
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 02:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8B988EDA;
	Sat, 19 Oct 2024 04:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M80c+jHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8AE888E81; Sat, 19 Oct 2024 04:21:37 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D671788E81
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b1505ef7e3so142805585a.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729304494; x=1729909294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXQOmiL+7bywpeboPFWzJnfgkkOreRFKIHTLW+jk/Bs=;
 b=M80c+jHYfaennamaWV7FCY2Hbhc5eUK4pT0KYNMupVb6Ki6oYeU/HoaKxZa/tZ/fqn
 ohyyd8OuH4+n8PBamvU8rmGAZPplmuV+b6/s1ZodZtO/yY9zSwzZU1FHOLX3RohS46Kg
 UPwhp1g5RjEurwNRuo78TolQ+Y1K6HU1bETqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729304494; x=1729909294;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXQOmiL+7bywpeboPFWzJnfgkkOreRFKIHTLW+jk/Bs=;
 b=J9htLQrne2411l+Tv0i4kCNJQt3/Lgi9lnlZczjKqiBrFc+XDNsTJd7fFiYBHATUBd
 DlTO6IJvTV0Xxyye4JlZqsudclNkh1+UWkYQ409AoONhGOWHhCMhaQLP62jpyg2WUbvU
 nQp5AN83u3PHb5QRJ9SwYlt9UyWmdU0NV8RZyAreUJyPiyNBEG9XwoPnR2vivmhyXpAJ
 6a06b8/lmR5aTe2H3hk4OKcvBr3NaEduOispkzOUI0roWlHqkzdu1TmsAJt/XANbKBE3
 b/Xf0NjXWL7jNPYpY7qd+nTndfsgG/i4fDj84XdUM4vL+sJh8sRlAfb17G9hSbWw67OR
 Hsog==
X-Gm-Message-State: AOJu0Yzf9JTaNP7tSYUWhU2hE7vwDmRGWDAA9/f4UTGrtbFRhWAS/GZs
 voH9Nsg+0Ovf6iu/CkwHZuTRPM3/SmSci8bkiGvJrW6XeJWHF4x4THfKJEiXviZRS4GcPIDX26/
 wtp8=
X-Google-Smtp-Source: AGHT+IGyYmhZyVYX4Z0wFS2/sdyQvUv7nSHImGaYIfQC9LhM97DHxfOhOtIMws3OuDhEHt5ny+oXzw==
X-Received: by 2002:a05:6214:3a08:b0:6cb:f1cb:a161 with SMTP id
 6a1803df08f44-6cde1617b19mr51347286d6.43.1729304494546; 
 Fri, 18 Oct 2024 19:21:34 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde138fde7sm12521016d6.143.2024.10.18.19.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 19:21:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
References: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd: upl: correct printf code
Message-Id: <172930449283.2505436.12596718719161293392.b4-ty@konsulko.com>
Date: Fri, 18 Oct 2024 20:21:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 18 Oct 2024 04:46:57 +0200, Heinrich Schuchardt wrote:

> Building on 32-bit results in a build failure:
> 
>     cmd/upl.c:75:51: warning: format ‘%lx’ expects argument of type
>     ‘long unsigned int’, but argument 3 has type ‘size_t’
>     {aka ‘unsigned int’} [-Wformat=]
>     75 | printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(&buf));
>        |                                         ~~^           ~~~~~~~~~~~~~~~
>        |                                           |           |
>        |                                           |           size_t {aka unsigned int}
>        |                                           long unsigned int
>        |                                         %x
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


