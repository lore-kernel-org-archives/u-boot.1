Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580A8CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B940684979;
	Wed, 10 Jun 2026 00:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NC+iFAVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBB9849AF; Wed, 10 Jun 2026 00:28:22 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4820284987
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-486118ecd5dso3839465b6e.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044099; x=1781648899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LptBFiWVBmgF07+9BKTOd6X1ux7Og1qIkqxSgPqtS4=;
 b=NC+iFAVtDiWKo8fYQ1sbvqZBqnIVlEc6TLEXwkMKM4qumGGK6yxXS6DZScmOtuI4gC
 lmrqME26xEIxO/Zj4ad9+zqh+GlvVHrCF7Vw10gaDQXve6OOb00TeVr+y10zHnn4DN2A
 jXNmFlVWN1jPVX8sIeOMExa/ncXSJJzZvokdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044099; x=1781648899;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LptBFiWVBmgF07+9BKTOd6X1ux7Og1qIkqxSgPqtS4=;
 b=AD7ecBnuLdu9XL7CLEIi79073kGs6i4xZKcith+6nGA0FNDlQ11Z90HEZuSsmQyUyQ
 5bUpHLga8MNbBz0Wjt4P0uM5g26fLM8XtfGcOpVRbKC2VMZjYdj2qiulqHIAvkRr3CGo
 h41eYMZFZOYPJvYj2pVx7nhW3vD6z0q+hVA2hVGMS8i4H69PLYXXfXBDrzwxih6ojJiJ
 7jXvZAjOEBkMb6kpfVSz2AqEh0eqNf5MNcIr82p/T4MpYb2seT5KUeLWJnl0E574RW2N
 +4ke/ue3EnqxRxQrb4edw0uabcQIAOpxjO3YF4JAfPtJ3qVjjfcHkYqSlPb38Qykxnq9
 y+KQ==
X-Gm-Message-State: AOJu0YwUQIhInMg0t1FBNTJjBFpqXIIm3Gx3IgT+PLg7CTjPaP+FqX0L
 1aoOIbOH5fbLMMflunHe4HeJiLNeZzeYL3gvDOcRsLjH0DHmyssWeRk9nCa27t+MrSQ=
X-Gm-Gg: Acq92OFQpdTHqwWcIq5GFYZHoIYTl/3HeOHz4iqD5i1Azyt1yxl7IaBY4cOsFVdRUYj
 jnI2ttyGtyCiJDQmeFrhvn9fG12F4zU8OGS6PxcZKXd/uz5huBD3E/fDHJ+NNEerKpw7rjbmTyw
 iknb1gQBJLuO5pPxsX8uHVdJO2+VfdvBmkQ5Bq1ap8t2bvkwWJGmG6TdGbUh6z+Txaux8ZNFGQc
 lgi2BNy2Z2cVm4+lvw5+Oh4Y2cHK5EtovP4xT/V9X8dnj8FiSwtolmAe7Vvo0vZpwrfKEzotvAb
 lxo9z7E0/ZDCC4wp8OCORJcjM49vV1i/U7ar4sK45w68nwfXFnafxbyn0iZhP+0pBtgsweKnyq7
 MxxvUJS4Lrqmon46ZboAKFmxGq6PxoZuDyAaWoziNkW79hbw4Tm8xWB3/5l9jk8L6/+69e1LlYG
 MM/blzDskbUbFQAZMixa898I/vXbn5RaE3VMff7P97YFq8Pk+YLdMrIQYebRi1ODiyb9SNRnaKQ
 QGVfp2elPF0iVoM3+WI3Ec984d3I/u/PFxFYeP6qBb0pm7ZJlMCQTvyeyh8
X-Received: by 2002:a05:6808:1387:b0:479:ff59:dcec with SMTP id
 5614622812f47-4868decc0dcmr15406256b6e.32.1781044099012; 
 Tue, 09 Jun 2026 15:28:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: stefan_b@posteo.net, ryan_chen@aspeedtech.com, 
 chiawei_wang@aspeedtech.com, BMC-SW@aspeedtech.com, joel@jms.id.au, 
 peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260525040602.2368579-1-peng.fan@nxp.com>
References: <20260525040602.2368579-1-peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] gpio: nx: Use dev_remap_addr()
Message-Id: <178104409796.79918.1069429032198494235.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:17 -0600
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

On Mon, 25 May 2026 12:06:01 +0800, peng.fan@nxp.com wrote:

> Use dev_remap_addr() to simplify code.
> 
> dev_remap_addr() does same thing as dev_read_addr() + map_physmem(). And
> it supports both live device tree and flat DT backends, avoiding direct
> dependency on devfdt_* helpers.
> 
> Also add error handling logic.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] gpio: nx: Use dev_remap_addr()
      commit: bc988983d25b19cedd76cba1903e321c52198801
[2/2] gpio: aspeed: Use dev_read_addr_ptr()
      commit: a4e8d80c9d189a245980dd62c26e0e9103599062
-- 
Tom


