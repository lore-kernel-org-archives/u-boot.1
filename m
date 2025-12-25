Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544BBE7AD6C
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 19:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265C68420D;
	Thu, 25 Dec 2025 20:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rKFxPyQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F70984230; Thu, 25 Dec 2025 20:48:17 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87250841DD
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 20:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65cfddebfd0so4106917eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766692093; x=1767296893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBNuMvhcPFwbjTaCmH3lDPsBV+Pdl5QQ5FbdMVugesE=;
 b=rKFxPyQKa2tPpa8qNKKjSM5oNuVqcN6fptf/XWlgeuY67ip6tt8uHmCSALiYSS+Ml4
 qcuafg8i5rvAZEseX0oWhGlhmmM8GYEw/+W1dO+NKJ3jk8yS6TA17WLJQitJ8WfteA33
 xasUnKbWquT9jtzWKyFcdTWhf6hc+mfO4FGcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766692093; x=1767296893;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pBNuMvhcPFwbjTaCmH3lDPsBV+Pdl5QQ5FbdMVugesE=;
 b=qUq5cwCdNcGCslptuKm2QZVD11zdivN6Nqg34pr0ZFelz5LAPdHrv4rwdrmuD8PGWP
 Shb/gnlelc1U+5vD+p7zx7HDLk10PjaqFerCYaFg/aj7emilT+0dDQTe/z64zRql+G/3
 54YVEGVFbP9D6Wouov8zXUEqguqoSrP0nFYJ5yC+572oLSGYdoUWAcVkG8AmkZUQAewH
 QhNODzThzPDOxTsVgvmcXLUIAGLgOnmDKI1ls9a1bLXAgiteE22izklXVwUNN70kO0Y6
 2T5PEZFBUN8cNT1CJfkPkt+R1wRrmjbjOD8PcfID1tkq5p98mHiciWsiTE+JcPgDvNl6
 ir0Q==
X-Gm-Message-State: AOJu0YykceX9Gh/fLteXZE2wxAJsBiOfrzC8n0Bbikzo1r0XXkRU1Ft4
 jGAkhgmeASEl8kvXU2ZM1d3tBKK2tZArZCbMLfW7C+E3p19VgsP5m3Ip3k34/qfeLfI=
X-Gm-Gg: AY/fxX7uZcEaS1GrYgpL4VKWbBiAHS3luhzSFBE3Ptq8xS9SIPCnhrlurZmuqCu56QW
 7JpPwcynY80+WLDvs4q+AutOh+q+mT9+CoD7X9rSjoZAtrCQBme1g8JEiw6IiWQMZWGgLcEU0Gc
 PMgZcdGSmKZAXSea7Z/c8ZWoUYBL4AtPcB9Umevw2t4/r9y6Er7e3aUfYU81MsnWCXNjg+1Ctk3
 qDQ01lgUkNZdFAC+LZjz10y1Whb/1lCQP+uaHWAkJi5OhihtCJ95XNKvfL7loogucVobV8BJbY6
 UPaLDkWcbwxmEsBkXlhHcRCj7jmav5LW/0Jh+DGF6AQuG+Nv7XwpfZE8/nyw3wB16PZCdB4geyN
 x5Yt3NqVMOmZ2/sxwQVV3YZ19zdE+veINcViNYblc5SrcOlVJDBrVtPgDeOKIBk5KkeBL1OIy9K
 TdIHEoKBYkSH/Zh05mFjpdETfI88b+NfeF4yN1bmODWzDd8y+aLcnNu7kDwd0=
X-Google-Smtp-Source: AGHT+IGOA+FFzK5ULBRW6StC+BpQJIL6MnRq1t3M1GS64Fg/0WlGI+2Q6lOntwbJQLtj3qDTujY4lQ==
X-Received: by 2002:a05:6820:626:b0:659:9a49:8f04 with SMTP id
 006d021491bc7-65d0e99feedmr9155620eaf.21.1766692093298; 
 Thu, 25 Dec 2025 11:48:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f515721sm12794412eaf.8.2025.12.25.11.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 11:48:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251219202121.4180810-1-trini@konsulko.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
Subject: Re: (subset) [PATCH 0/3] Enable / require DEVRES for devm_.alloc
 usage outside xPL
Message-Id: <176669209209.1263958.1138442633587348782.b4-ty@konsulko.com>
Date: Thu, 25 Dec 2025 13:48:12 -0600
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

On Fri, 19 Dec 2025 14:13:40 -0600, Tom Rini wrote:

> Hey all,
> 
> As seen by a number of patches fixing memory leaks, U-Boot has a problem
> with developer expectations around devm_kmalloc and friends. Namely,
> whereas in Linux these memory allocations will be freed automatically in
> most cases, in U-Boot this is only true if DEVRES is enabled. Now,
> intentionally, in xPL phases, we do not (and do not offer as an option)
> enabling DEVRES. However in full U-Boot this is left either to the user,
> or some drivers have select'd DEVRES on their own. This inconsistency is
> a problem. This series goes and deals with two small issues that were
> shown by having all drivers that use devm_.alloc to allocate memory also
> select DEVRES and then we make DEVRES no longer be a prompted option and
> instead select'd as needed. We do not make this unconditional as it
> would result in growing the resulting binary on the many platforms which
> have no users of the devm_.alloc family of functions.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] mips: Reduce size in gardena-smart-gateway-mt7688
      commit: 22ef38f6933adfa0d89b6841f4671f6595f967d5
-- 
Tom


