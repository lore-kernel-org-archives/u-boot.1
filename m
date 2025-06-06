Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3F6C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2AD581F0D;
	Fri,  6 Jun 2025 18:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J1TV7QOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4160E82B26; Fri,  6 Jun 2025 18:47:04 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 219EB81FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 18:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-401e77e5443so1395121b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749228421; x=1749833221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bY4AfgwhH05q2INLoa+p0dd3wL+ISY4s8ik+Qmh3jQ0=;
 b=J1TV7QOpciZdtSY0PTUCCgex7YcU2ucquxIQ7jH6qYTDkZQDsN59vsYSP0UPZvSxps
 VQd6z/T+NHmtUs4i1/qbwEk1VTqzf9Bn1LuGdyY5MQKsBIRpH25jvbQvsNbix5LpUTri
 WC6J3KjvyT5BCojgDhfnw6tHtW8OQR5ZC9cZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228421; x=1749833221;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bY4AfgwhH05q2INLoa+p0dd3wL+ISY4s8ik+Qmh3jQ0=;
 b=ef6/ooIbX7DEHTqwQXgnEK+wlPp97G7Vo+XUrcUbnbB4H0gXaVad5EiVFuZrAQSvZz
 DeJLZ2VzEBLjul0l/uFJLmmEAlu3oawGtyPYq6Caj/QvNsau//Is7OYD4nP9MR8mGpQd
 i5neMsIoQgLVwCREK2xt11wKL+4Zdj1IF+MGCC+KNuUDXLP2h8rqRwzKdgBbHmWc/07H
 PZ0BlpDEZCN0aO1K8LkP8WXstXvTDphoE58g65sFm8o5IGGJPKzvvKwNfAMBXPSUz5M3
 STHGAeZFK6DxamDy9KkgKgLZ2oRzYkR+CfDT5iMqfy9djb8yCiTTXh2RcwhhraNJVVHu
 NN0Q==
X-Gm-Message-State: AOJu0Yy9pDGhK4M6wnnU4v8YE8dZOrG7skzndjgCq8bvNuLxV17Sapri
 Lx7xmzinA+NbrNiM605/UTx2xCacisZGe2ee6j5lvFSc7iHx6i/6qembI5GT/0Pc4dg=
X-Gm-Gg: ASbGncuwvwmUQWGGcWrY3o20V0DfBuLFOZ90HE1sc/FEYnxmsPf2QFRyshg/N+5LZSi
 PtIYmvrlOqhUwWV00MAPc/oIOGtEjfVpoPyo7gCsPSYSYan/T3tD7fqthNYWR9aKL81UJpkvrq2
 TJWuhN19Lx0nYA7cgV0UV+F+/abAkIpf73Jvztl7DPex0H7fCldpcdmohu/xseoOTNdHKx8Rbyy
 POJJtyfbthnjqec8zEiVp/hAL9PIfaqPbyMT6XRFprmiLfi3IaIht0ZzYS31iCXCxfLeS6Ibe2g
 fTMaZKdwKlT6Z8xAsRskfFnIBd/vmvGKF6MD7ovpHzjVTrfh5qDh+yHseOKD7De5JZ2AOrg1dUv
 lWedacK2du+GRY/U81MRKww==
X-Google-Smtp-Source: AGHT+IEqnPnQylG+uz7A0YUuwekQNUJkAKekAjo07Bu7u9YdWVWhKAJ6CmorT/H/aacqLRdorzw+VA==
X-Received: by 2002:a05:6808:22a6:b0:407:a501:19cd with SMTP id
 5614622812f47-40905136fcfmr2931250b6e.29.1749228420861; 
 Fri, 06 Jun 2025 09:47:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069418a9sm377808b6e.11.2025.06.06.09.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:47:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>
In-Reply-To: <20250527210436.1488428-1-raymond.mao@linaro.org>
References: <20250527210436.1488428-1-raymond.mao@linaro.org>
Subject: Re: [PATCH] armv8: fix Clang warning on writing 32-bit variable to
 a 64-bit register
Message-Id: <174922841914.3195369.9627584360250138208.b4-ty@konsulko.com>
Date: Fri, 06 Jun 2025 10:46:59 -0600
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

On Tue, 27 May 2025 14:04:31 -0700, Raymond Mao wrote:

> Clang is stricter than GCC when it comes to inline assembly and expects the
> register to be written with explicitly same type of variable.
> 
> 

Applied to u-boot/next, thanks!

[1/1] armv8: fix Clang warning on writing 32-bit variable to a 64-bit register
      commit: 85683bd1959cb7f3c870c9da12217f5a4ba0e922
-- 
Tom


