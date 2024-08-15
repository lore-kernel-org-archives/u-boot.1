Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13010C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1D688BFC;
	Thu, 15 Aug 2024 22:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AGWVUGi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F59088C26; Thu, 15 Aug 2024 22:33:23 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A03888BFC
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d80752933bso930041eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753992; x=1724358792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VubkCBHpHferQ5wRq4pn4M/aO5faBwR//KIkcaIK2Tc=;
 b=AGWVUGi1SsHlI4sMO2QEKakzvuaFTjnqPEJWi0SlNTHtPyG2QaBxJD+mVVbvcy+Ma3
 nQSb1NPBIfAK+HkypMYgz7h2C+zXp5lP26QcYSCsNnxcivYWQUqYZzeS7uTCu3uSlL2h
 cYZWjG2AAieVhkeBsYnj4fnMS/nb0jFKRlFCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753992; x=1724358792;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VubkCBHpHferQ5wRq4pn4M/aO5faBwR//KIkcaIK2Tc=;
 b=XUNRlsZJKAAfCDEBGLz8H4Hy6XR1R0Ff6GD75NT+X+slmYAhDATJ7ksG9BnVUjZz3O
 GdEw+g/yzl9xNnrUCXgEpQFwyzBAc2FRUve8KywfBtSOCGahQB3XLJQN+VwbZjgnbChq
 zzjbo3uqDfvLuSu0FthPKDy3pWK4yybiQC8JpylXwWe9Ma8R+Sb9D+W5tMkJK0WMDja1
 oYx2zO74f7ZvGanVTz/UYzhzQkv81BBQutpXqXuPghZXSpuvGhEvbe6nHcH+OpO/AA90
 aJWKfO8xuRhwhRcKOv+PQ1qM9FwWyfUWCzuECAjzDZz9moevu6Tz2g1IA8Y9r/JBhr8d
 KVTQ==
X-Gm-Message-State: AOJu0Yz/QbaJ5MVIN1GHSOy6lT12KklSrBvRqhSgkYo7jK7+6sCF7cbF
 haZcRD/uwci91kR5DysqsFwUnvxgbE1IXvtsbu88XiJx0MWpL7uEQs9703n4nrY=
X-Google-Smtp-Source: AGHT+IGKAVfAgjSDADnWHHeGBMWaM0tY0z00qmZ36aYRXsH2unl18deqP/mQjpD3qx4Zyq9MsP1y9g==
X-Received: by 2002:a05:6820:1519:b0:5da:9204:6727 with SMTP id
 006d021491bc7-5da980256a5mr1002921eaf.6.1723753991782; 
 Thu, 15 Aug 2024 13:33:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, JianfengA.Zhu@sony.com
Cc: u-boot@lists.denx.de, Jacky.Cao@sony.com
In-Reply-To: <OSQPR04MB7740E04121473281459069CB90B82@OSQPR04MB7740.apcprd04.prod.outlook.com>
References: <OSQPR04MB7740E04121473281459069CB90B82@OSQPR04MB7740.apcprd04.prod.outlook.com>
Subject: Re: [PATCH v1] lib: elf: Fix bootelf -p crash issue
Message-Id: <172375399078.3490037.14925748017248529327.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:10 -0600
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

On Wed, 07 Aug 2024 02:20:07 +0000, JianfengA.Zhu@sony.com wrote:

> Do not load and flush segments whose program header type is not
> PT_LOAD to avoid crash happen.
> 
> bootelf will load all program headers and then flush cache.
> Since PT_GNU_STACK start address is 0x0, crash happens when
> it flushes PT_GNU_STACK area for target that memory cannot be
> accessed from address 0x0.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


