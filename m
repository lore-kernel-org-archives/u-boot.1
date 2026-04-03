Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF823E85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92FD38415D;
	Fri,  3 Apr 2026 21:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S218BhvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C09841D5; Fri,  3 Apr 2026 21:47:26 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089E4840B0
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7653db148so1355338a34.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245643; x=1775850443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9opqFGLrrxrdluZQSmQASqhYd7OJWHvukJP66UGpD6I=;
 b=S218BhvWs6bHOlWEdrtR5Tp5MY1C7ACqKE8R5M7+HiL99gV1/Fql/y0fH4dgJ+wKFd
 NnNWGtYpyZoCxVVe1BK3Qm232x1rusuqW4UcXbzvUHxO7S3Xwd7gv5/8kvY6Cev5y1gl
 2dElIUpmPw97Zi2Lpf4K27pR5sKdM6VjYgPX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245643; x=1775850443;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9opqFGLrrxrdluZQSmQASqhYd7OJWHvukJP66UGpD6I=;
 b=YlVE02mL1mwQmX8IlO7ibHpHKBUjN3QMrogOlNGuOcj98fvgrVJpBcSVNN/Hh6rQBu
 YTjVzPdJdCn0Ms2iWs+iIKRgXAJRdlA6ntxXKbyRrjWlG/fvZu70WxvhYjfmP4Wwp6FQ
 F9qucespAtudwKsKfjHInwLYcK12g3GEdJ2mcF6dHrZJYdMFthRTJoP5UAHqjrFrjTWP
 0cHeQvfitdIvJj2RaB0Xahsv1SoWVUf6+tkxpLeKw8sd10dT/NYUMg5YjymxrRUJmMXa
 0MqKi47WnELYEj3e5t2q0jfbYJRv/9xT14eyC/6giPQ6mZug5QGdwnuW7y6UrbTVAlsA
 MfgQ==
X-Gm-Message-State: AOJu0YwsIeAz5UGTLm9Y1+ZNe3bnc5ldCnJQMKqiKpdR+MEsAOiRFD5q
 sIqXijyP/KFH5Y5PX6ZfWWNbyGhiTd9QEwplxFU2JQYJgJ1yLOAUm+LXgLWLx1P9gWG7dIMbsmr
 Px/VOYtk=
X-Gm-Gg: ATEYQzwPkxnyEl8WKJ0t0+YMC33eaqv2bwuIkoUQP0ehG/qA7LqAHKUj7AWnpu4CSmI
 WPYIRtvIiQKvX6BkTosKzT74vKssP2KC3VzaulYZ08pEnPU69DfZRU7vxez+mCYfftvicqd7kdX
 cp1fhbSjg3lvWXSilSDiFnD5SrGLWytRqCx+Q1wU8BnaJh4UgH1Qq8tTfcCpRuNsmeYgU66BYPj
 Bh9GGUQJGfYc4R8RyY1o+F5XR0fvTRnbDylogMBGJYV98ewRmvIz66BuC+q7ZO5UCSv8JzAHMyv
 k4/T5lbb0aig5SNL2AiW66bo3/FROwII3DfPBi2y4TvKvc6O3BKkN5apmp07xstmLlriTDold2Z
 bVJRaT9nDtTU1TsFe8FDEJmiwfMrRm8XCNlRo46rnRTG7N4OY24PH0Rvs75QSNAiLccMRbWdRrB
 JTFXUSNF46Dl8OgW4iOx6G47QIQClhEPvJR4nACXhCXPgv1fF6PYTjeHU4TgUxGOK+QHX9i3aHu
 aIClekcxXdMODqvKkr9S1/B4uVPZAYdACaOgOFDX/J4Mg8=
X-Received: by 2002:a05:6830:6184:b0:7d7:ecea:fd95 with SMTP id
 46e09a7af769-7dbb7327a94mr3008705a34.7.1775245642774; 
 Fri, 03 Apr 2026 12:47:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205345.3789046-1-trini@konsulko.com>
References: <20260320205345.3789046-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Add missing dependency to CMD_PMC
Message-Id: <177524564196.2281750.17378920336833274246.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:21 -0600
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

On Fri, 20 Mar 2026 14:53:45 -0600, Tom Rini wrote:

> We cannot build CMD_PMC without ACPI_PMC, so add that as a dependency.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: Add missing dependency to CMD_PMC
      commit: af54c2185e11f3baf1cba464bfc014eaaa799203
-- 
Tom


