Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F2C369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 07:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E31180EE5;
	Wed, 23 Apr 2025 09:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HsL8gKT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3009380F03; Wed, 23 Apr 2025 09:51:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB12980BA8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 09:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 752975C5DBF;
 Wed, 23 Apr 2025 07:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17BCC4CEE2;
 Wed, 23 Apr 2025 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745394709;
 bh=HyhaYMhxYz2b2W0jmXQnPREjt3HkERPnta3/s1brKhY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HsL8gKT9Q/0GRZ4qHZpBal6wDhzpZEGjkb5tOzewH4H0oiEks8KRhKkcVxQmdLVkC
 aQY/Xru1phM+oObg0KKpojmRpdeFNkZgji/Mah7+uRlJ6AsLs4ziWO9PQCSghjVLRI
 TAv2K0Er0hRBozr6lJ+xh0Tp8oVuPlXUwcZA7hNbL/hBM8tSIUHkvJ0PJ9apbAHAVo
 NjUPd7wrIoyVacbUDDDYJS+eUzsJX4+OL1PczH3g+EPxRA7LOAn/H17zpwU9Z+hwtK
 BIkmdUe6z4lRLR/3003cximVS1OxpsrmGu+Yk0QAI0cHbsWFRSkXAE3zUnqSk4uG2j
 zFX9I9VduzDxg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
In-Reply-To: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
Subject: Re: [PATCH 0/3] usb: gadget: Fix issues when using f_acm with ci_udc
Message-Id: <174539470698.9099.15714363217130217402.b4-ty@kernel.org>
Date: Wed, 23 Apr 2025 09:51:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9
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

On Mon, 07 Apr 2025 16:59:34 +0200, Stephan Gerhold wrote:
> The ACM console does not work properly with ci_udc, it crashes immediately
> when setting it up, because usb_ep_disable() is called on an USB endpoint
> that was never enabled before. There are also some other issues in f_acm
> where state is not correctly claimed or cleaned up.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] usb: gadget: f_acm: Claim requested USB endpoints
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/eeef1223025c68bd546a1f9411bdcdf518f8cb97
[2/3] usb: gadget: f_acm: Allow restarting ACM console after stopping it
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/22b5aad20ae0f17bd9617fb9c10ddb38d2b91920
[3/3] usb: gadget: introduce 'enabled' flag in struct usb_ep
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/59310d1ecb9f56a1bac405a5edfa9774f2d90220

--
Mattijs
