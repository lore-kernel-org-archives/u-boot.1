Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56225C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496F184A48;
	Fri,  3 Jul 2026 22:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m5jjk2Hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE06084AB5; Fri,  3 Jul 2026 22:51:03 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD8B84ADB
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-43cce34c881so726509fac.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783111856; x=1783716656; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5uHOq3BspGQrEd330Xhwg6d86BDUleQw86mv3uPOts=;
 b=m5jjk2HmzcwtoX+GOMdwXJDEWguY1gg/VRAa7Rxrqx3PE/BQjX3sYlmBKkDJCU+4dB
 1ah0SfRCXSBbSyhdOwZ/XMXA1Iva1rHz0jmB0c8X+g6rFKIJfSilnK/s/eYuTgSNCQ6F
 mKLkoKlEaSWc4Xywt2mC+x66uDhp4YnlVSf2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111856; x=1783716656;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g5uHOq3BspGQrEd330Xhwg6d86BDUleQw86mv3uPOts=;
 b=dS0oeEjJ/TdWX21CDE8XA8FUclQQSTAps7KFm3MJOIkgboqvY4Y4P1P2dRm0W4H7N+
 hBnLVK0isWMjxF5HO91WfMmooOdw0QnxZ7LIfOxEe4odWewtzoyv0WXGFvdg8acR612x
 LS6vK9QFtpX+ZEQUqzoAOaRh+UAeTBE9YXwq22eD3WX9sNiMDkmBeFG2AydkUcHpN3L/
 ckt78E3iEzq+mqQa4JvehbioNXQzNnCmtMrbUu4o+S1z7zjxCIZ2flXwTxYeAwJbb97n
 stjx+ltXNZ0JbuH9PYBd2IZIL6b2zSpk1BD3H7BKg2e1gehgQLdKHodwsYqg4Ur1VAOz
 NhRA==
X-Gm-Message-State: AOJu0Yw8ATrYRWTA8YrMJDRDP6rG71q/b+tTPNXaFuyxVudAq9Y1Uclq
 dq1o8FChsxje+BW8DpMD1NGNNwFJwJaX2Y7L/QhbPSpcyISP6GSrTr+4LlFpAICljWnbkDAWc6f
 iaKfhtq8=
X-Gm-Gg: AfdE7cl4KOtzAenh83w0mnlwhN4Ts9kFxyD4f2hY0+9o9gKYSVcbl4SDgvroJlioozc
 uUkzEuUelfOvSfq3zB5rR/8qc5+dLmunrg4llKnUaie593r6CzqGk/1f/v0ZsO9f3BVQriLcp4y
 xW+lyqCAPSRT+c7ldP3YcBi05iC6zCtex1grcGkKrAbh4pG4qSeF64gNdZin/3N1B2Yt+LPhJ7G
 8KJ7efvKpJIRWyk9woHYttXeHkjewSFoaYVzvUDsadIW9KlhRRnYoFCt4QY/+elxWcaArHYMhis
 7Kj4bTqt/pgQd7Mny30JYb7fgJcwAR3KPSsxaTJhC78qs2SDb2LND+u//ligYJqkoi13760Jr+k
 4eukP8+Cem4/k3xViNFHc1w5DCug+cNJOp6a0xeiNYNah07Qe3XiK2gygUGTr2WeLI6tYxhY2TZ
 gIToIk4MuRujIDF3b9GkZIrc56RELmz2HvxQ5fMG0eIK5Aehwfh3Uxk1tEy7iXbB4eATzde9/9T
 jKRq7xFE03/7UTY4b+DF/YKAognsGx7xKT4
X-Received: by 2002:a05:6870:c6a2:b0:447:d5f7:3d91 with SMTP id
 586e51a60fabf-44d17f50d2dmr527867fac.3.1783111856332; 
 Fri, 03 Jul 2026 13:50:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3088491fac.17.2026.07.03.13.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:50:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
References: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add entry for ARM
Message-Id: <178311185527.3143424.3518998709687008703.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:50:55 -0600
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

On Tue, 30 Jun 2026 17:42:42 +0300, Ilias Apalodimas wrote:

> Since I've added various features in the arm architecture
> support and review most of the patches nowadays, add myself
> as a co-maintainer
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Add entry for ARM
      commit: 780084d7c07f511da4a39b43277c573156ed42e0
-- 
Tom


