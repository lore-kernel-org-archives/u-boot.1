Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638F6EE57C2
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 23:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8884683FDC;
	Wed, 31 Dec 2025 00:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kOEjHm1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628CF83F36; Wed, 31 Dec 2025 00:19:42 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F0283F36
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 00:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e12fd71984so7287672fac.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767136778; x=1767741578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5m2muqZjMqvviAOFjKOY9vqy7OWOrcSXhwj/jrVxkQ=;
 b=kOEjHm1nyHUMgZeiobENTV38a6C7+GJ/dCPqB84hD8iu8FAP3Z0dRo9YVC3K7p0jMO
 yCvYNYI1/ibml5aSTX0/Nk4Ote9ll3ZHRvAuDV1vfYuLZA6NFWhQiiVXPLN2XVDxEgPG
 qvJBr/oovoFEiB6qem4ExVmrb0clD71MoMV7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767136778; x=1767741578;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5m2muqZjMqvviAOFjKOY9vqy7OWOrcSXhwj/jrVxkQ=;
 b=SLKG3ZuKF201KwzuF3iDguAi18k0CcIf3nB8K+FbrP2na4QAJhzMOY46idjzY+fyXC
 kEy0C6YJobrvPJZjf9VsMyHk2xNqXsAHDUWG9oNrbshVl5aZtrhgdFnfATY5XOzYkiMl
 jfH/d4xYKC8a4SOZImwlY+KCsTrrsnlgKI11lxnQIsqbeBKFa2rq6IFuwnpX2GkdT7NI
 9uZv+Iuv7PVZwENJ67ji55DanCcZbfVq06xS2fvKEMWe0RZMeNkFVmvthj1XcU581BFA
 f6bCsQdMjfbnTWV/oETpznnFxOBCyIWOXUyXffj+kFifId7nxIGef4yAIGahGHG0MN4R
 JxmQ==
X-Gm-Message-State: AOJu0YzmoDRVIz/OokY3tySrqGCWz9FEB+EA3Twg/Y+AKBusDuf2sNSY
 bpgCAIwEMUpEmYPyog8+5xJE6+tb4Z7MBIjd6tyw1UEVV4bBnQl7afi3P3deTbCuleGuxpacVDe
 Pqdm77qA=
X-Gm-Gg: AY/fxX5RbLCty2gQvcrYLe1kSeVXddadptk6JLLe1DNJ+dNA2FbqkCHZ/eMLXQCAa8o
 ezZJ/JaW52hvrdK7aSx2hD/RgOICucWjaOyQKGMwsUfjP+jJp2D3m962u20xL397KIEdzgwmrpd
 LxsXLq0kjfKXYsvK13qhUUsXtf/z2udw3D1fuBxpfjHRXCW891lW+70guQg2/ZIEu8MSxlTp+b5
 PQ/EoQHA1pXAFyvsqvlZKevcvoKD1ZV3Wxxc4AODgWzJYfOQ/2xjWNpacMwyMlF7JEypyao1to4
 GXcRaNRrL3zeu56f8hGtafzD56z3xiwyQxbHX+pPuOaGkM8pheonI7B+5kw8WqQcwQZeuPbqLGB
 yrXS+H5Cyuex34b/p6YnAFxey/0AgOliRTIlNxaLRHYIJqVX0OVKJj6nx6qXZleuu13/tbQNoCK
 QUYpdy3gqWJ/EdtcrQyQ57JvHkQClauk2aBPeiiqzffMmXVAHEUzXLYFD3eyuKHk7ZhtFPI7640
 Pqc8m/eD2ANZvTVEyLwJ0NGIhA8GbDTt6kjMoeIHOlNh5+O
X-Google-Smtp-Source: AGHT+IGU10KA+yzozJ4g/HP5jsh2ThOXpMzQqExupZVgWANzs3goNoGdCnIup5SL0LMluun+QW2t6A==
X-Received: by 2002:a05:6871:8304:b0:3ec:4dce:ab6f with SMTP id
 586e51a60fabf-3fda56672cemr17597261fac.28.1767136778098; 
 Tue, 30 Dec 2025 15:19:38 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa8d4521sm21172083fac.4.2025.12.30.15.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 15:19:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>, Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
References: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
Subject: Re: [PATCH 0/2] video: display: refactor display_read_timing to
 avoid code duplication
Message-Id: <176713677726.315706.7136871348174695913.b4-ty@konsulko.com>
Date: Tue, 30 Dec 2025 17:19:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 30 Jun 2025 12:08:14 +0200, Julien Stephan wrote:

> Commit 2dcf143398ad ("dm: video: Repurpose the 'displayport' uclass to 'display'")
> left the display_read_edid() function unused by mistake.
> 
> This series addresses that oversight and introduces a new useful cmd.
> 
> Patch 1:
>  - Refactors display_read_timing() to use the existing
>    display_read_edid() function, eliminating redundant code.
>  - Marks display_read_edid() as static since it is not used outside of
>    the file.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] video: display: refactor display_read_timing to avoid code duplication
      commit: 5b2ee2c4a200961fa92ab1f2f2502ee41905257e
[2/2] cmd: add new command to read edid
      commit: 5e9b0b56ad8c2a4289b2b506ad3d0f3acd0d20ba
-- 
Tom


