Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D626C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 16:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4EDE8063E;
	Sat, 18 Jan 2025 17:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HVF9A2l2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDA5807B4; Sat, 18 Jan 2025 17:43:31 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1876D8063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 17:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b8618be68bso218433485a.3
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737218608; x=1737823408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+hJLC7ze+5m43AiJhXvikOiO+YG9wEDZucvI7S13W8k=;
 b=HVF9A2l2Mff9d9DKfVh48bDQnC3dHdLoBkVv5Bq7jKes2Jk3sf6q72UiFTx2wkJamI
 TeZgFLrIvcucJVB3dX6TUAQB0s0iPmASNf1aIfLbmVZPJoohZa/ICIF7ZSjHKc4xedd1
 CAM78kMP9l4QN0b/F0vTJtpKo4m43AnklKEkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218608; x=1737823408;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hJLC7ze+5m43AiJhXvikOiO+YG9wEDZucvI7S13W8k=;
 b=TabnrjdPDWO0HqQn2/DwkAezFCRpFx7rs0/v2vTbM+FTRW3lVWP3mlaGAHbcpl3KSL
 ym/HEb70hznx80Vxt/ha4+81kzoErEpbioep1eoK1DiWXtWXJ90b81JvLGPjYwi4VdDh
 VLXofruvmAWms5cDZ1Vt4EqaO7yuP0pwPJJS3AWn9oA0gJo61WzuQV29SuPH4PwUD2f2
 mbtIH+D9XcpfqyQg0Wbhj4foIZ6oOetMH+jPSk9rsdwD56YVugb7ldpAsvMCNP+Bpksq
 LfNA9a283r0LxkuT3bZT+hgEUrRNO7P5Ap2sg0heERbe7cKKZFdwx/zvZzjb3RczaBF6
 lPqw==
X-Gm-Message-State: AOJu0YzgDRIjbv+tna0KMM5N0siNf03pGZcy+bQCU9eAFhWPnCGFVEhS
 hfSIWg5EHZwiyltL4QAxyqMjlFSF69P9xvEWBziyqfCmLjj3cZxg1v/WB53dMYE=
X-Gm-Gg: ASbGncsnQqMhcFaSXy6hNeVcbknMcVud9kkcDHMujbhzR0lAbYkpHAF4qFxNsmug79U
 3XeSATSvh2FsjQ+W5MeMyyvWTSTRmzcu3C70y8C5n8zZ4SL+N7iI8DOiUAQXsUpMye3S/vdXJX4
 mvj9Z3dY4sccrg7gQu8QObh1xRawiIvRRBX/Lv7Nes7rp8YTppyYjBMcZC3cEgWiQnVp7uhMOkL
 n6HLE6y4E0BczIXmvlqeM5t2e5lj+zGn8l3WQyD+4z8CsS5uwOyRJbaX15vfsC0jw==
X-Google-Smtp-Source: AGHT+IGoW596Qql85Zglt27B24ls4MUa/js9gLJHqIb0BlwIBH5AvOO3/wxiIeaf6gVIYTj+ydCX3g==
X-Received: by 2002:a05:620a:3956:b0:7b6:6e3f:49dc with SMTP id
 af79cd13be357-7be6323e5c0mr1208894085a.31.1737218608068; 
 Sat, 18 Jan 2025 08:43:28 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614f5b3bsm241061585a.115.2025.01.18.08.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:43:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20241221164552.1836066-1-trini@konsulko.com>
References: <20241208190741.4192601-10-trini@konsulko.com>
 <20241221164552.1836066-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Add DEFAULT_FAST_ARM64_TAG as well
Message-Id: <173721860613.2563206.7209548457766522821.b4-ty@konsulko.com>
Date: Sat, 18 Jan 2025 10:43:26 -0600
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

On Sat, 21 Dec 2024 10:45:52 -0600, Tom Rini wrote:

> Upon further consideration, we should have both DEFAULT_FAST_ARM64_TAG
> and DEFAULT_ARM64_TAG values available. This will allow us to later run
> a matrix of some jobs, such as sandbox, on any arm64 host and still keep
> the world build to only fast arm64 hosts.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


