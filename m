Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26738CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F37928884F;
	Sat, 21 Sep 2024 04:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aLbqbGlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7463488753; Sat, 21 Sep 2024 04:39:37 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1104D87E30
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c7b57e2b17so16746246d6.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726886374; x=1727491174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ineV/GfhJJwm/TptQCJyoYgQtQrgSSpTKof0nIXxnv8=;
 b=aLbqbGlT7nWFIZMSpJYx4ysZm5u+ovTvWsuNT9EA/VKiYCXKl9VqkZNeRiNzluECDZ
 k7ZtRSbTYTM9g2KvzOJGP5IZdc+P0oYMci0niU7ZM1gkHEw9aO5/xjJ9AJtrYAy0dXeg
 79jo+3lpE4vbqSzdd415tnbBSiZD2lgEeQosk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726886374; x=1727491174;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ineV/GfhJJwm/TptQCJyoYgQtQrgSSpTKof0nIXxnv8=;
 b=uoLHl6D/LDwjbA4hs34gjmlZ+CKM1tXeFyjyLtlsrOEmPMn8SVfU49v7mqE4gypb+j
 4xyzOFeSvp695yGHLDcCltKoKyq7fCudBfFR7xfiiyskISErjVu89LBKIB4BrhrtFw0k
 e6JmAQj/LDuEZPd1CzqgRdFpCfWA5MHKpNviaXxSLqxRPdzT3YNYYWxTcLQaHFdxossf
 gT+3fgTtuZijFLfJs1f4lCphN2y7lFqWJZfIWujEpG2pgPHHTdionUXhE94u+KUH8ITf
 dzqYaw8iA0CnqPCkmVQ1GiHZonEoqNG3QgVndLPU/BdjAcIGfzaQFMtgXJuf2Ncgnxg5
 HySQ==
X-Gm-Message-State: AOJu0Yy3OwbsIN0ucd8xfk1LVtbjxueijWivNSjJxREYnqGfsW11o/Eq
 N4ZiNcQ0sUqNvIN9Wv3iBM89d7JQBYUw+el26KvHW4lGl+T96QGLZF8AjRQnJ7k=
X-Google-Smtp-Source: AGHT+IF4SYmfn3hAWzMV0Pdzi5tbxOR+E+75OEN7max0i2TNEOJtA4ngk5ZuNCY2YuRtTE9w5+nbnw==
X-Received: by 2002:a05:620a:f10:b0:7a1:c40c:b1f1 with SMTP id
 af79cd13be357-7acb82255c2mr791665185a.58.1726886373820; 
 Fri, 20 Sep 2024 19:39:33 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb082a3cfsm251414885a.70.2024.09.20.19.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 19:39:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240916152025.75789-1-sughosh.ganu@linaro.org>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/2] lmb: rework logic to validate load address for
 network commands
Message-Id: <172688637179.2451825.4736403690225486599.b4-ty@konsulko.com>
Date: Fri, 20 Sep 2024 20:39:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 16 Sep 2024 20:50:23 +0530, Sughosh Ganu wrote:

> Rework the logic to verify the load address so that address re-use is
> not an issue.
> 
> 
> Note: To be applied on next, on top of
> https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


