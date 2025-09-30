Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA2ECCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364CB83045;
	Tue, 30 Sep 2025 11:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JbKqSASu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C4D833E9; Tue, 30 Sep 2025 11:51:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A96828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D01B043961;
 Tue, 30 Sep 2025 09:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624ACC4CEF0;
 Tue, 30 Sep 2025 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759225907;
 bh=AUqGe++zCrI5aU4E4pU/U3fba/sARnxTDgNf0ANasF0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=JbKqSASu/iyM2+Wv7iRTIqPvUP8ouuxzFobLVjK/K8+PXxInXPe/7vxRFS4cbYxxB
 gLEiy6jsVwPms4nKZi5O6Rr0zWpVv5O9fzLqlPZM5nvXQJ0nU4duHovSbXvXAuuIsW
 QYhgFrzooPpBW/ajIClIufINNABvUFWprG6Z+hcifGgYx4RppVDcXEvH9kYG/PM8/3
 RWVCqAK5CmHOVl1icrExFcKE6ME/+8SIE4eptAg1+iA9Kcd0wDC5ihpr64JKWqAvf7
 xKxa3LWQ/AHHc8wixxQgWlWz8FIJesjU4GSAOeq2i6NUHYP+NEsZ/zaBXhXj/sEllc
 aXoQbeIw06STg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
In-Reply-To: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
References: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
Subject: Re: [PATCH] usb: gadget: atmel: Add missing null check
Message-Id: <175922590555.1440114.13633426417316062299.b4-ty@kernel.org>
Date: Tue, 30 Sep 2025 11:51:45 +0200
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

Hi,

On Mon, 29 Sep 2025 17:25:23 +0100, Andrew Goodbody wrote:
> Add in the missing null check for udc->driver that is present at other
> points in the function before it is dereferenced.
> 
> This issue was found by Smatch.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: gadget: atmel: Add missing null check
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/f58667587243ce652aaa7d0dd6557a2fb2da5020

--
Mattijs
