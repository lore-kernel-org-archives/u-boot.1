Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F06FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3485843D1;
	Sat, 25 Apr 2026 19:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FyoxTFDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D214843FB; Sat, 25 Apr 2026 19:37:31 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E73A784399
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-42fc6923f38so2291108fac.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777138648; x=1777743448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+T0TZWKiMDz0XG1WlzSHo+puJpuR6Xo2Gh6KL/D5EZg=;
 b=FyoxTFDa6VUnThzQ92lwz2Hkxo5VS4B3TJuqKaxeL8TIdZQcL4Q1BhgDIREUcOMMqX
 vtrVC8EdzVEGH4g9C99ZKztU7SK69NYiixsvfgHpa7jFhgYMUdLy6VtHlrdBsvOuZfNk
 N0UqCFedK2Fwl9XcGP+odlC12eSUseFW5d4g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138648; x=1777743448;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+T0TZWKiMDz0XG1WlzSHo+puJpuR6Xo2Gh6KL/D5EZg=;
 b=oAwWQqvkI1ipCll/wCWZyVbRX2wdJIhR5tmo0HPFizMJCkmm7N8KlEriN5eGEI3498
 s/RZmvHFoDH39ndWkQMY/6apOZjfB0pSAMWhL1hg+/gUtnQ4Vjkirlwi3X3FESUfPnmq
 Lsz9LoMRsIx4xNgM/zgx+utfL81dhdu/iQlL9RxyWTHw24WUFnsdJVYSNJdtA8johRwc
 5yfHVKACmPo3W36raD18uzwf4ZeTNvpMtTJqAQWiX2Krj5OmEue0xT1D9XCYtnIXTwTU
 hxynl4/rneTp7K1wIXulKzaZgszNozbUpoGTCDpGL60TQY0l4/L2or/FpQF6Pn7Lvdr5
 Y9Og==
X-Gm-Message-State: AOJu0YysifHehCzBNtYSekN9T2I6ALhPORyLeQC/KhO8LfjPxnRw4hW6
 5h63jCGa5or9uNeecgh9/FEOBgBlQFXbqXSTkK6CHQo0gpKNnVJHwkTsLOobZ1ksyDp0WAS221m
 iXnx8y+rmcg==
X-Gm-Gg: AeBDieuqiSTRUEcDD9gNqMZbqKE2YAuYe4CoJPxE87tyXAXE9CWmx7iv83dFF7hEjHq
 xL6ggNMd74UKI/KXd30e2LOcQcN/PKolTPZ827H/zTzNxJY2FDQbLEVT34cHe35gWkSyYvxvyfL
 gCi/Z2DY3mXid0ACU6miwEK4lXzSvCAynapa6XYm6805bsSAqHLDBhNpZx9JAFRqMsjTwj1Gohk
 0BRIAhFPTxE6VyccKQ7Nbj54DmV6hs7rGxR5++vu8uwVI87dz+2FFlQJfBHfxYveFXVNBtVYb7S
 6xR7uZLl4mPgiwu9j+YGa6tA87Z4P7mQ1GJTSAtwjpGl8Pzzp/MWbEvQHAqY0S8Qgw8u22X2SZr
 vvr9pRuiwaw86RW8uLNPjQBaT7/LpN+Xoq2a8gOsWjx8YEuJMR9zLnTnwqIZuEhKQ4kd/hovO7X
 JGj2tgfYxvpwLHkEDhblQkITDhTxQPiDqbMk8DBlwrtQabCL3Fy+5MKFHnfVrnvy444Uf9vnKPl
 lpTNgBuJxoAq2vLYtBUEqtJOBcW+vT40McNZjmrcRYFONMigO5oFYPgAFazu+5/ebdOoOg=
X-Received: by 2002:a9d:7392:0:b0:7dc:c70:3fde with SMTP id
 46e09a7af769-7dc955a6dcemr13329425a34.11.1777056654011; 
 Fri, 24 Apr 2026 11:50:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260418063213.110024-1-heinrich.schuchardt@canonical.com>
References: <20260418063213.110024-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] tools/asn1_compiler: avoid -Wdiscarded-qualifiers
Message-Id: <177705665334.2527258.15382973914763700752.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 18 Apr 2026 08:32:13 +0200, Heinrich Schuchardt wrote:

> Building with GCC 15.2 results in warnings:
> 
>     tools/asn1_compiler.c: In function ‘tokenise’:
>     tools/asn1_compiler.c:442:37: warning:
>     assignment discards ‘const’ qualifier from pointer target type
>     [-Wdiscarded-qualifiers]
>       442 |             dir = bsearch(&tokens[tix], directives,
>           |                 ^
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools/asn1_compiler: avoid -Wdiscarded-qualifiers
      commit: b67267c6211528747faf0552b82e2170aede5045
-- 
Tom


