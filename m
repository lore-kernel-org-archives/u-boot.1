Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C73C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5125682E27;
	Wed, 16 Apr 2025 16:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UP2xatX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C033F81B4B; Wed, 16 Apr 2025 16:10:57 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AEC81B4B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2d0364e9231so1752743fac.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812654; x=1745417454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1YucFPTlSMByuHQbW9ADa55fkcYmXWQmQoOxutf7FY=;
 b=UP2xatX3TV2+3naJWR2UX/OQuQnki2XsOoasArpIG+PrfxTXfh/PdX6zkkjkmB3rE8
 xLFvyHWYWDN/58QY9PsNHvdd/XxIaAlsUayx5RU269/lBd71IXWmdAooOEt2PiCusJgV
 HNXssvUgGVAAKJpHpAiRbYrUXvq9uB5kGFoK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812654; x=1745417454;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1YucFPTlSMByuHQbW9ADa55fkcYmXWQmQoOxutf7FY=;
 b=oaErkmM9PUl3Hzrmxh6IGBuweMcWH9BqgxYTmuPUrjm/ekTOOt8/I9s7mylB6ZsUiV
 aNctC08Yqyqk/CxemXksGYu2CHZNjnCWo2bGV/WmcRR2EOjAonEvzxQ5VPqWj+5DFUCT
 VQiGctUkC+y4+rND09qQXosFGZYnuIv+y1PcuDg0Lom2vublnh2yRlhKRRxAtYynqdY+
 kU7hOGioOtEERrIkV4GtCW9hSTjlFipwEEPXjyAJhe0+IO2/DHpYoKTCzBbNO9oedTiU
 qkhEd/HpPFFivLmng34n+t+7K3MdqWu/32Ws6m7eNwxQ4HohAXk8wMOdP5k/xLJfxGrC
 hPjw==
X-Gm-Message-State: AOJu0YwMMFEXhMUZ15Z9LqOjeuM24z2aX8QZqnvMGXUNU9gx4Lqcnjnl
 t++nloO3boEtxYuM0/Ar888OqJNq3ILZ8d/F2ixlUZvDLl9yxaR3r4yYPJr8SXI=
X-Gm-Gg: ASbGncvqM7fr6Pnd6aIMPhmVG8V5yiabcO/NyuhiSvnGvuNojpIzH8wy9mvSyYheteu
 6nSdWUF/YhCCFSbDWMzWkhMZZoJzN1rXa5IcqU0yDyRKSCmBK+igiGKnmr+nixcvp/nU2lxYqzA
 Jr8rS31TBNKGPKh7ql1WJNBZgeBTAw3YcGc0ZiT7SBfLAGbVBfbLzs+jRdefwT54jIs5ZeY9WWR
 hfaWww6EsEOchHDRjnhk+8ONdGqWVEwBvCpv57QCF9eDt+U4HVaESpPm2XdTdxGhyxuF5WYlq9h
 11w55YJU8/WU3Xf010LW33sRur0Ogg74/0YWLzKahfrxgdHc7ZMpOvgjA+zLcDlEtUQ2cg0DXTh
 b
X-Google-Smtp-Source: AGHT+IFY0tSKByUe1XdCF5vS1m8Y3JI6WMq+0dLDxPeF865QwTesv+XixoV0FqA+srj2n2xwui1HBw==
X-Received: by 2002:a05:6871:aa01:b0:2c2:542b:bce4 with SMTP id
 586e51a60fabf-2d4d29bc7b1mr1131417fac.8.1744812654309; 
 Wed, 16 Apr 2025 07:10:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, 
 Parvathi Pudi <parvathi@couthit.com>
Cc: pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, danishanwar@ti.com, 
 praneeth@ti.com, srk@ti.com, rogerq@ti.com, afd@ti.com, krishna@couthit.com, 
 pmohan@couthit.com, mohan@couthit.com, basharath@couthit.com
In-Reply-To: <20250410065955.9770-2-parvathi@couthit.com>
References: <20250410065955.9770-1-parvathi@couthit.com>
 <20250410065955.9770-2-parvathi@couthit.com>
Subject: Re: [PATCH v1 1/1] include: configs: Adds support for AM335x ICE
 PRUSS mode
Message-Id: <174481265296.2150978.2628781687987666211.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:52 -0600
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

On Thu, 10 Apr 2025 12:29:55 +0530, Parvathi Pudi wrote:

> On the AM3359 ICE we have two modes of operation CPSW mode or PRU-ICSS
> mode.
> 
> For PRU-ICSS mode, connect Pin2 and Pin3 of J18 and J19 and for CPSW mode,
> connect Pin1 and Pin2 of J18 and J19.
> 
> This patch adds support for PRUSS mode boot strapping from uboot.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] include: configs: Adds support for AM335x ICE PRUSS mode
      commit: 07c3480d8b1d9ccaa5b19dab64dd02446197d7d3
-- 
Tom


