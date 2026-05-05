Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA84CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7AD849B8;
	Tue,  5 May 2026 19:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cYE2bjJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39368849B1; Tue,  5 May 2026 19:57:37 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8665B849AA
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 19:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6949831a7bcso3077257eaf.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778003853; x=1778608653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr1OmQOauEz9Apk77uE2QY8Mv6oP4+XLZ14aB0Sydxg=;
 b=cYE2bjJMMfcDDHHTYieHaYVv5a3ZYUfgvkSgupX0cI7kW8k3DQkmm4oMDidUzEJ8n3
 +ZLLN4eptXNKU7FfonOqksKdKtJ3RUsf57eyjgu2U15SgimcrsDO2S1YF7tWtVLWqzzX
 gfGdBsDajO8bxPiXA7HrZayHLZq6hHnmpD8dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003853; x=1778608653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xr1OmQOauEz9Apk77uE2QY8Mv6oP4+XLZ14aB0Sydxg=;
 b=hATV+enUKKwe9mbuTL1nVblvLQ6IhqVjQDut/UpmsAWkmvq3nb1bPUQ+DoBMd31HrV
 ieUjtjo0EKyxbBT5SdUhKMheg/KZkHOaSwxYlmPAvnqOTPiCidRgyGyWzeWgDIq+RpCH
 4iSW+pFcld3PPwWZKYMLQFUmCRTDQS7bQytjIGMvRHsfBqsDEn7jSC3OX7ak//mpKAYH
 UexUk7K2UPor/f9GRpw4nN5z4+nb9M5SnuA7uk0NTM+5BTwiq4zvrKecIcw81Z3/jDlk
 2DO+umN/TMj7RKf2y600qtmk7eZR2+bF2N+Nw4anPmwXv75aJhtY7bXPdMqjntiH02Yd
 gZvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8l5JS5w0HK+OYEYJTGm9oWlUNPmOlvUbepCC3LPczR8HtwINNmVY04l/NN0OG3FPvvDRrNGxI=@lists.denx.de
X-Gm-Message-State: AOJu0YxBoVUD22E+cI+1rIKf522i3RpOJL1Nbf0HByH6tpm/7Qrh9/A6
 amBb8EJW2+bgrY7xyCoiYwK8R4eB2jtpAsXGAueDczJepYdR6dvW+QXJfDXlXo4gLfOihTI6+zq
 v/QNMpt/7iWuR
X-Gm-Gg: AeBDiesBDYl9wCqxCyqUNgjZIeORw0/tNJf8yZSDMXwpmbm/3VT6K+Aeott1JlxLd+l
 1wgR42DzKs2Dw3EIMOMANqU//oxlSJ9IOM3FG3VNOaydMOWgVMMueS5VPJ1ojHUKxnmiYeR+iGx
 oTELb1+P/yrhf/45dlHSTEV6UWA/c0ZhDehjU8yVPAU+xDSVXy8+IGQgS6NeKrTxJH+dCnx7Zc1
 KhXLZN+hK4RexiFR+fdBxvZAc0Ts1Y9BBqQfkEgwFzfZu3RLVgop8seh6S3XyQikFK/Sy1I92C+
 rP4W2V+p/LVA0uU6cEDc6z0gI71wbuk3UBiGr0aDq22QZ3Iz9RbHJTnB1juebVXwyV1zlkB70E8
 ILihcC1DV0xljfOC2Am/hhUo9E/lIYvGQMMJj954TzdPU0LFrrD/uqMMuxUw70MDSBWEhjReXNX
 ENJV5KAvv3AumJ7IRev9Mk9yM68aiNQ5McuJn8rQnWWYwQmcQlGWW2JtBQrmk7Rl5DyT2pGZc7G
 crEvrSqP8JkdfpFC+5o3ZXGdgebN4Dy+ti0EJ+IGYHo0JSYQGaw01mjJ8tp
X-Received: by 2002:a05:6820:211:b0:68c:2ff9:522c with SMTP id
 006d021491bc7-696979ad2acmr7948201eaf.2.1778003853255; 
 Tue, 05 May 2026 10:57:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324e2sm13561561fac.13.2026.05.05.10.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:57:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Yan WANG <yan.wang@softathome.com>
Cc: paul.henrys_ext@softathome.com, u-boot@lists.denx.de
In-Reply-To: <20260417083050.499955-1-yan.wang@softathome.com>
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
Subject: Re: [PATCH v7 0/3] binman: Fix preload signing with encrypted FIT
Message-Id: <177800385253.2525131.9832701135870074049.b4-ty@konsulko.com>
Date: Tue, 05 May 2026 11:57:32 -0600
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

On Fri, 17 Apr 2026 10:30:47 +0200, Yan WANG wrote:

> This series improves the reliability and efficiency of binman preload
> header generation and test it against an encrypted FIT image signed with
> a preload header.
> 
> When a preload header references other entries (e.g. an encrypted FIT)
> through the collection etype, the referenced entries may be rebuilt
> multiple times during binman processing. This becomes problematic when
> the referenced entry produces non-deterministic output, such as FIT
> encryption using random IVs or timestamps, since rebuilding the entry
> changes the data.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] binman: Generate preload header and sign data only once
      commit: 5006121b44a2d147e7e426c74537b3566407e853
[2/3] binman: collection: Set build_done on referenced entries
      commit: 9ff82a771c44a8cf38bd52b556f685ddbc6f1a55
[3/3] tools: binman: Test signing an encrypted FIT with a preload header
      commit: b20d69e5f57bee299380bb30112856e51d8f26b0
-- 
Tom


