Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E230ECA1005
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 20:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EEA183A13;
	Mon,  1 Sep 2025 22:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NO+W2Zor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B49A83A13; Mon,  1 Sep 2025 22:20:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC8F83990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 22:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7456d2b49f5so831346a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756758005; x=1757362805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTWMBI2kieWXPpORTBefAm+g1K92cNskeh0A3Iu0BBo=;
 b=NO+W2ZorHQvUza195nOF4pi0AcYOVxRE1tAsgE4u97W6PPzeGZTrw7fo/5LeZlO+aP
 qpRuqo4OqEXOIYJuDghrpcd1wVeTI6pJSW8EOvbkesioVYNbqIUsux7sJxaS8YadlqNu
 keFI4OLQCCODnFJHVDycmvXSQ1Rc09dMiYReI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756758005; x=1757362805;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTWMBI2kieWXPpORTBefAm+g1K92cNskeh0A3Iu0BBo=;
 b=GcF3JmnrkljI2qtWOqwHk3ZrBc+GtS2pQfjThf915SiIPLxFtJosWMjHNcA0KnvpZJ
 I2KwsYKLCo6HU1e69QBnZhM1FhO/Aac6oMw6fPBMsYi6wXdq8bAAGMM4i8Waufjq3MFq
 Dpt30P8NFGYtoFPriStpoA7Hq5wDeaU+aDhCTLkJL+e+KgcUOB+wa4oYvaS1hs7pN1cV
 8JvLBTJb/91dI67KuDrfV8RJBYXtFrcB5+KqulESDup+8fAFNXdPKbz1fRuNLDs9eS56
 jfpfkorx8RG9fJlBbAxbThkuKNJnmhl9589tzPjHRhf/P+By8Nk7Gj3SNTbCaCrj6xna
 m2qQ==
X-Gm-Message-State: AOJu0Yxwmvw+ghbKaoNbWJGGJK/Pz4/OU0AhohdtoR6FtrGVAkq9OtwL
 x+/O4SqENQ/w3anmZUALr2DpAi/GNMJkekcyuLdbx1ldZDNBsz0hXocvawrrrVzGsDVBdjiRiSJ
 fmLxIqVA=
X-Gm-Gg: ASbGncslnUfrggbDoVqOO/chpX68JFKuL9FklIxAOisijqUgJ23C/8pX/j513npvNhg
 wsWlw9TyxUXTzeMjYc+oRh3V03DfhFjPxGVu0plzRM4AGbwazcTpcGXVwUZMVbknXoTRCVcN4fn
 B133FMg0RveoKCXAvqarZWcOc6KXvNF0DlHLwZSW0vBd+9AJSJSTFeP0mL3S3/D2CNlDUzK8cJs
 go4sq8vyzen4eW2QFOQyfOu33kh7mFM8wUQrtXEOXqYJ8MKcCuDHPt4rHg7dMKTkaHHgxfZ3elV
 SwtJjHsQisW0QAX4od6ESUY581Q4XGqk3GRNb9apzH6fjQ6o24IFAlgCdWkOW0mAjSeIRV8nY7c
 ul05XurznrQR71VzfQJ4FvxyS45Sn65yZLBgjEnn3fHktJCbbwAqzRb9B25Tky4QfsQ==
X-Google-Smtp-Source: AGHT+IEM0RVm9tblCL2Tl8u6HBIfDROzMdSUlp5v494dJZHEL/WAwSSLtifDtoG4PScmjIexcn1ZIg==
X-Received: by 2002:a05:6808:244f:b0:437:b83d:de82 with SMTP id
 5614622812f47-437f7dc3b90mr5075710b6e.48.1756758005001; 
 Mon, 01 Sep 2025 13:20:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-437ffea7a4asm1032834b6e.2.2025.09.01.13.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 13:20:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250831011115.463678-1-kever.yang@rock-chips.com>
References: <20250831011115.463678-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20250831
Message-Id: <175675800378.3107606.1634783263143595098.b4-ty@konsulko.com>
Date: Mon, 01 Sep 2025 14:20:03 -0600
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

On Sun, 31 Aug 2025 09:11:15 +0800, Kever Yang wrote:

> Please pull the updates for rockchip platform:
> - New Board support:
>   rk3588 Xunlong Orange Pi 5 Ultra;
>   rk3588s GameForce Ace;
>   rk3576 ArmSoM Sige5;
> 
> - rk3328 soc fixes;
> - usb controller and phy fixes;
> - new rk3328 ddr timing;
> - other board level updates;
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


