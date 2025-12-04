Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2566DD2A532
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F7B284158;
	Thu,  4 Dec 2025 21:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hZV7/9jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A000C8413A; Thu,  4 Dec 2025 21:28:52 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8851E8413A
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 21:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6da5e3353so1218005a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 12:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764880129; x=1765484929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6efOq84umOJU7YUbVLvXsJHf6D6rt1bqLd/6WLhRbw=;
 b=hZV7/9jJtM4rU7oAmedQ1gVV9sjYjinPluky8TD0SFQBpKi/pbe+Ff6vx24lZeqvit
 m77j5+fxNif0+xyCn7p01ZHwlsvskUnTB73Ano9QO3gjndFd1ByFFEluacZdzF1VaPI0
 jAEynEeBInjZXrUVDGhfyVPCf7BViy4/bkJgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764880129; x=1765484929;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y6efOq84umOJU7YUbVLvXsJHf6D6rt1bqLd/6WLhRbw=;
 b=DCt3AxVzzan67daFVoqsIlaP6FRy5WT9Qv/fPMTdKmxNQbOtCPDM6azbNj559Sh5VN
 gt7kxE5CTRS0E2wIA1+VZ2+re9sOUa/sLRBgszKOXFz8HGs9Jrgt6Yadutz635DQ+veh
 bgyUjuqqNdc+kjKfPp9roqVFzP4mKukfoDVT9LA1n/uLHaK305McST21WvoxUkh5VG1A
 DLdrJmcfFzgOXAsL08cDtJPVwrQ7gQdkQjrNGXW+aHeQik4XKtRhL+9I6+bjsmiDJPQW
 /1P/UmMCLxANySUXBen/NeHeSrbL4FwnvvkYkIJWPHnS5V1gWYcxSY1Y5GtsCBf2d9er
 NUfQ==
X-Gm-Message-State: AOJu0YxD52/ruei4bXsjR2WXgxpXy62PnJwp+DgSdmIvrQ/H4iJUfyGG
 UqPSvnwuGYEbAtmvXkfaPOkVCvUGDiDZmMgeN9szHBillcPSdqC0NoQ+2WngU7uNOjTahxnVkQq
 +QKCmtXE=
X-Gm-Gg: ASbGnctvznCfEiLMtBClzK30+d/vzgH7W52D3rWAmiLxYdcPbGpi5B9xXSRALWbx+0u
 mMLzX8rf3vynUBdQPXG8UUccYeojUzZaHd1gXEU8zyJHGDrMYAgqBvBY5lCDmKFBG7VGu6GoJNe
 dRRAs10YYttZ9T/0unhdwG9jZwacq21noYz71HCpCjn30f4fWnxbI0xKTu2MiIBeJEFRAur1ltl
 67+0pTfQiwcLgdEuyQolCPHg5vJ11ug2RCMEDRk/VQvCZsmnI1Hi4wE8VuouUpme/BmTMTH5Yig
 N9Ae+wUnyK598wm05IP9XrIeNJRrkSMcdU1MniZfJdJkIbBuxAGWKkG5ol4YD5J01F1IqdnYDry
 /nu2rpERdXa2biX013Zx5N6cFMkO1kJUITcf7KmFC+MSRLyaljXqOMt5A5ST4WILQNHrMJdYbpE
 nB2nKOa6IM86o0WjpgnS4qTMF4TCiQJwIcUF/AC1hoJJ1x+NYS
X-Google-Smtp-Source: AGHT+IH0mnacsq7vt6nabhCEQlP66b7J79dhFsyBK+EeFKevG+yrJkbPJ+/ZyqmAoNcW18N1UBuCeQ==
X-Received: by 2002:a05:6830:2695:b0:7c7:639e:d530 with SMTP id
 46e09a7af769-7c958d17b20mr2168315a34.36.1764880129271; 
 Thu, 04 Dec 2025 12:28:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8f8d0bsm2336131a34.5.2025.12.04.12.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 12:28:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wolfgang Wallner <wolfgang.wallner@at.abb.com>
In-Reply-To: <20251202094355.73929-1-wolfgang.wallner@br-automation.com>
References: <20251202094355.73929-1-wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH v2] board: BuR: Update MAINTAINERS files
Message-Id: <176488012846.2061624.10003467542781247832.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 14:28:48 -0600
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

On Tue, 02 Dec 2025 10:43:41 +0100, Wolfgang Wallner wrote:

> The MAINTAINERS files for B&R boards are not in sync
> with the current file names. Update the files so
> that they are correct again.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: BuR: Update MAINTAINERS files
      commit: 97e202a72160ea038dda46130d911546e66a189c
-- 
Tom


