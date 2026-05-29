Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F03CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A161846A3;
	Fri, 29 May 2026 20:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="go/Hw4BP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC15846E2; Fri, 29 May 2026 20:46:52 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86FE846FA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 20:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4854b95c307so2685755b6e.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780080409; x=1780685209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ov+29ikPD/QCAcIBVYQX7/KToGiEy8UNJAEBoxSVhcQ=;
 b=go/Hw4BPHD2qy+xilH/XHG7B3JDnMzkVSIuKNjFsql5Z+T9Fh1wKnNGuMZofYm18he
 VLOCCGP+DHTYMifoxzXE04XWwiFbInpMwA5XQOVNECtnuDitcGO+tdFLDRgLiGntREiC
 2lnpFr5lBV5zJRQTEwMo3y+K8lN8pzCRqOUxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780080409; x=1780685209;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ov+29ikPD/QCAcIBVYQX7/KToGiEy8UNJAEBoxSVhcQ=;
 b=jltU1LT2N0YUvEcKkJh7d4WsjyKAnVYAAM++xyCFrockBRWUmxI/4IZIIcE5tvrOI3
 N2GFo+hdBmdT0zheueEIVVX/1b7FyiCIIaYVWvuX9v6FBFkFcAIVTqpPYEvoL/aGNor5
 NMRqvIFn3dAJsnfYQQJAwlxEBf8E0YZB6Bmsgsp2y9vhL+5Tu9ARL3zZ/vEr6q8zxurZ
 dqVHpB9no38j2/akrDTntjhASIkzM6+ok9RPYAIh8qFThr/RJ3Fwk21e7pWKdEjQV+uO
 tJY6Q7d+4k9GpjvszkF46RrENT1C7OjG7zq9EXYiVJqSIWzSS65zFuMe4AiPm8H6I77n
 kLdA==
X-Gm-Message-State: AOJu0Yx4qfKlJYAZ9AWhvFwNDC6W9BlO8bDdhaJBeuu/z5dd/dxoJXaV
 8KFJjErJytcIq9CCxBrXG1h5fvvhAiuNVpqSiz9paz55wBpdL4aF+F/8Cta2d3GCeFOqOxIhKr0
 LCe3L940=
X-Gm-Gg: Acq92OGU/1V6ofd9/UrQlP7QwHJAK//aypSaj7xzlQoSRm/oVhfAr626E+aJBZAPKF3
 6gvs+/pghjhT+/u/cJMZLTXP+P9VjWpvnlFUwZE6YXh8vAjgnm8Um9CvxKLYaujH2aANAJk87uR
 YqfVRxAkZnCZUwERMlAA5SdtfOAQCdw5YNgWugDmVIjIlwSC/y/bOrYy2/oeyhJW+ssRqMFtrYP
 eIMOz6ILR34KOhzlHFwNiCDnVWsBlcVhIM7y3usYGRsL9P/UaJFhljfFcoIsWiBt/u5MPrJalVc
 JgPaeZi6qpsgXJf2EOyfwBjrAsiSXwSeCc7TZ6f5Y+i1+iPed4g+xNCuVkgPfb67u9um4z6nFIc
 rSf6AJ/0n/2QMt9acmycPouUFlDE9+F9A5/cDNRrgS2iAXEiok3jmhqxd55mjc8qG5bfLp6lOS9
 OnMNj9+RxURVN9dL0lGNgy3GwgO763IkK2l8fr9Jfxul80N6r7I1IOSgrxQsmsOUIZlm1oqkU2J
 fRU3RAMKddLiA653mmoSTOvJehzkWHq1qKLXtJsZEaRJFRxPR7B7v4=
X-Received: by 2002:a05:6808:5094:b0:479:eb19:6e6a with SMTP id
 5614622812f47-485fbcc64c6mr435546b6e.34.1780080409461; 
 Fri, 29 May 2026 11:46:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-485ee13b24asm1122987b6e.9.2026.05.29.11.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 11:46:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260529174702.667233-1-trini@konsulko.com>
References: <20260529174702.667233-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Sage: Drop rpi_arm64 lwIP variants
Message-Id: <178008040874.679639.3986624548282713896.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 12:46:48 -0600
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

On Fri, 29 May 2026 11:47:02 -0600, Tom Rini wrote:

> With commit 17ceb774a185 ("rpi_arm64: Enable MBEDTLS/LWIP/WGET and
> WGET_HTTPS"), we can drop the tests for switching from the legacy stack
> to lwIP.
> 
> 

Applied to u-boot/master, thanks!

[1/1] CI: Sage: Drop rpi_arm64 lwIP variants
      commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
-- 
Tom


