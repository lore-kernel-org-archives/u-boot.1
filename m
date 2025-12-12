Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2BD59D6F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 17:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8748334F;
	Fri, 12 Dec 2025 18:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TAcbgFXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E518083837; Fri, 12 Dec 2025 18:44:33 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EA2800B1
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 18:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c701097a75so816812a34.3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765561457; x=1766166257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEaoWewhkOF/RimyZUnxH/THWvHPcSzGgCrBO269G6o=;
 b=TAcbgFXJS4jZ6gkQ/ggctl2mkDWsxWmJeu/VE2OpR7vVdidZm5dO8NuoimaZc8/FVt
 yMdfiame7szhMo7G3Na8Gs+9oTCHHyj30paSnk9+tydH3Hnznu/AJ271/ZgNs2g0t7Xa
 cmnA1vebn+eXK77wwXZ6IU3OF/Nap+FGjFggE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765561457; x=1766166257;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wEaoWewhkOF/RimyZUnxH/THWvHPcSzGgCrBO269G6o=;
 b=so/B9NqVMmEfaMP9YWJfc0xbGf8HEJ8COcDHwCQ743sKoRcQzEnV9xz16scxBoebOh
 Gnn//QndPdc/1F92GDP1/iK7W6q/gFuJvVL3Xwd0ZBlnH+Qy/ko8R3cEwhLwnbtHACee
 h6/UynnN5LOEwEkYETsd8C3SLvUgIinBqDB2SFTn81RQQE7fgXlAD7FA1qneYPaj28Ol
 SqCScHrXAiBT6jNw4I72LiXBnzX3pwk30SgBF/HMBnQuq0gdgX83NTYWx+zVsVHAa+ZF
 tDk9WG2D/YTpVkDwHWJ5copyEGLz7VrFmWRhFNyqKI217jBca878HGYI6Ne9JZU1UDAx
 h0Zw==
X-Gm-Message-State: AOJu0YwAi1glsBswECGnCWpm9HdqIs7SaGLLDr0jzjM6FbrHmAAq21zt
 RDPG/3iHPBq2K5NtZ+ywdXtsSUL/8YRYxLpU6JJCceslH8CVPEPDymYdngAyGhJckos=
X-Gm-Gg: AY/fxX5GYSN+pZFF6mfDe9pW6gKFEGvjeL96WGXmf77vvszjtkwUIcda5q8u6Q0usCw
 b/ujr3H/OmKHuneQcUnJpE8V6GFqWcizkD8JBojbe20izsG5Nv6Bf095aKj7uT8bqj5ZgOw2lS/
 3At5zBG6JYLiwRiDTj/YYc2osO48S/IeFc4wK3CpMjzKOmiHbdwb1P1IbSmbASP9rXC5mNURQbc
 wJAOjdXOl/iXjNDA3DchFu7EKSyLOICjD3WA4NWzkpZTDJCZ3AJEtIqbrwQACNKi4Hm7j7uF3Xd
 +REWw2hLKSdBnOmagR/fi6GAlD6nvbTo0u856hB+RVrMXCX08VMg1m2aAZWTBX2h51JqeW25aWf
 GuEYfGjJHgp5AL8hZJsVSj3IyDy8SKumKGado7GSTApCD0uigwjZ3bWkhAfHgtfN2EniLAjiqtQ
 /T73Ecuodf/7cBOoYm1wOHwTctyp06Ba0iULsSzzvgjDcHKCt6EhXSWohOs8M=
X-Google-Smtp-Source: AGHT+IGoyywho0LxJxbxWIBbLLiRbRktx856pN1MmNIzmRYQm6qYmsvxM8t5/IoXlvjKQ74SYcGAXQ==
X-Received: by 2002:a05:6830:4acb:b0:7ca:e8bf:8c4d with SMTP id
 46e09a7af769-7cae8bf8eddmr1682537a34.14.1765561456728; 
 Fri, 12 Dec 2025 09:44:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb345977sm3775688a34.29.2025.12.12.09.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 09:44:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <b0ba6f42-d157-449e-9857-84d9bb39bf80@gmx.de>
References: <b0ba6f42-d157-449e-9857-84d9bb39bf80@gmx.de>
Subject: Re: Pull request efi-2026-01-rc5
Message-Id: <176556145593.1046979.6245651941715019094.b4-ty@konsulko.com>
Date: Fri, 12 Dec 2025 11:44:15 -0600
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

On Fri, 12 Dec 2025 13:44:08 +0100, Heinrich Schuchardt wrote:

> The following changes since commit ff80e95fed188ec3d4001129445e414c9c811beb:
> 
>    tools: use setuptools 78.1.1 (2025-12-10 09:28:43 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc5
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


