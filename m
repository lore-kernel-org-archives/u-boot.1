Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB3CD29FB2
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 19:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23E7840CB;
	Thu,  4 Dec 2025 20:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eJzm+km6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57D084083; Thu,  4 Dec 2025 20:32:05 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677628414E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-657490df6f3so572753eaf.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764876714; x=1765481514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D2cDUV/unCXDEL1EOf4n/x9SMylcfXKFDXglbb1/Mc=;
 b=eJzm+km6vm2fVC3zYkg0nW6HNTsxZ7uIRKBz5ypkNH0u9shTpTPTZM3Ob3WM234lnK
 GM8ueGUP1HwNxE/2GQ4Pok2M2DDABC5O0CU1jQT28seFHmK0me2/CmmNp6ET6rolPWMJ
 UBkk6lhRbtUXnponT9RbiaOUJJh6IoLU+ALcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764876714; x=1765481514;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8D2cDUV/unCXDEL1EOf4n/x9SMylcfXKFDXglbb1/Mc=;
 b=qM16V04OW20KJ0MoCDZW+Y4GcAi/2AY6KapEvyR8aERFGoaGyXSostujioCJxyiYx9
 XrqUjRy4vELQcPsZcqi6yB9+bwIYlVGI29/CXNUtHvR6qvitnBb6knLpcPeCBoY22RGa
 GK0VNuRoYalXfT9q9bRKVwYVBiPkUdcwFolmefww5vJJm1uCtxjrO8T+egrILshehPkN
 go/TLyaJRtLFu8xjK4RpJm5dPXs+wlwiFbwAzeSsRBeKuXyHJdP9lZWfs6xOrOsdpYGT
 1VXGOTX7fU5I31qo4SLmKuLirDi+iH9eSnXxwg2Tg5Qr3+gfCQC455DXeRUkQuLi6eyH
 +UcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaQ/3NbjZt/JoKViXAOKO/fRkQwJvznD4Gyhhnq+qoZOSYc+X5LupMrfLZ9MRgkBtbimWLR0A=@lists.denx.de
X-Gm-Message-State: AOJu0YxnmD29jBi1nw7kriOGZZD3CMzXYTHuSExNQdCR+mwG7h+merzd
 VXGE/1p2oeqzTY6alRcehuOflR9DqGOhRcII27oyn4OtCyBw9MJHXkNFU2XvKPmvnXo=
X-Gm-Gg: ASbGnctk7UHzKp8/6nOEn+b7gpDWEVYDdKla34pT+r5r3BwsLUxPW9Rl25Uxlo5sruY
 kJ9yymf8tVKJH1oGtvMon8wuL5K935vsyQb5GNdv539LB6jYxuIWvcXQhrpNdjYCAgH/SJ6H2GK
 mPjOkUBr3WblSodTqS/i8QC89I5wHFkkKqwwZ0akTUSRCkh/qMIFaXQGx3dghwcI4dUitfRH87u
 7fyzkXhhsn5AQB/Y+v2SNCzdoLCuoJfDKMZSJNQUQXJk3EhO5S0+AM+LTJPD0xU8cHw3iSmUUk6
 nIxJKvaLoXmv/SUD9RE8hhkII6JO191LaJUHHZMvc568+XDX22VN7uPlv4K8UfdoCapkBmlD4eV
 Hcs+O75JIfcitkchG8Iw3bC2iMPwcjgscURLyBxNxtqQ+/vGYcgYdDM88QHHwemNJCXJmBdJxVP
 RpzehKEJHC0ntnrKLAjn3KTAtwSrIKTv6sETAed+o/LI19/Lxejis5Qww/Mkk=
X-Google-Smtp-Source: AGHT+IFMlvebN+vUuaQlzRNtAbUpFfAt2pL6wMysFlIlSxIM3aiTZzKQjFS7mnwg8VTTKVQvyzDL6w==
X-Received: by 2002:a05:6808:21a8:b0:450:b8da:b80e with SMTP id
 5614622812f47-4536e3a01dcmr4232382b6e.2.1764876714030; 
 Thu, 04 Dec 2025 11:31:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef0c840sm1147095eaf.9.2025.12.04.11.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:31:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: bigunclemax@gmail.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Marek Vasut <marex@denx.de>, 
 Maxim Kochetkov <m.kochetkov@yadro.com>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de
In-Reply-To: <20250829082628.623597-2-bigunclemax@gmail.com>
References: <20250829082628.623597-2-bigunclemax@gmail.com>
Subject: Re: [PATCH v1] clk: Only enable the parent clock if the clock was
 enabled before reparenting
Message-Id: <176487671289.2050783.12164735802509750286.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 13:31:52 -0600
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

On Fri, 29 Aug 2025 11:25:00 +0300, bigunclemax@gmail.com wrote:

> The current implementation of clk_set_parent() unconditionally enables
> the new parent clock, even if the target clock was not previously enabled.
> 
> To avoid this implicit behavior, this patch adds a check for whether
> the target clock has been enabled before parent enabling..
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: Only enable the parent clock if the clock was enabled before reparenting
      commit: b493db39ea7fb1205d3a2df269352cb79874c1c7
-- 
Tom


