Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC2CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B959F846A4;
	Mon, 15 Jun 2026 09:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QVMIcZPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460D584704; Mon, 15 Jun 2026 09:15:50 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA8283FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF11E43D3F;
 Mon, 15 Jun 2026 07:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048771F000E9;
 Mon, 15 Jun 2026 07:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781507746;
 bh=y8uJXUMXkzeWSf8PKJq2tEmhnGjBItmxDQM0x4gFqik=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=QVMIcZPWqlbcalwBYk21YIvfeRPgI/F9htljY7ZhSmpDkf/yYLN8d5SLf1h3BZgit
 ju3S09St/8xwPNI6mSoAtYsVHz645UsUKSs2px2hk5E1xQxFuE64p30VEZotVWsvfH
 ua2VeOAqzZdzNbJhBkka+s438Z5AvFyshwhZsD/o5FMiwlrWAzaSR3Fl1yCfd1nx/W
 yOy3Qnn6eqq7jQiccYEs+dc4WZondHxRsp+AML/M9sqy4KObssl2COj3fXtXbcy5A4
 NAhuCapgzw4IWAhax3sR/atuBL8R/jFPybdxK0KOBoYBe6WlIhv3KCvQWJcpurISP0
 mJxlrpKRCcn9w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de, 
 Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
References: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
Subject: Re: [PATCH v2] usb: gadget: atmel: use calloc() to allocate
 endpoint list
Message-Id: <178150774408.19584.12915809927897444644.b4-ty@b4>
Date: Mon, 15 Jun 2026 09:15:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

On Sat, 06 Jun 2026 10:27:09 +0200, Zixun LI wrote:
> malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated,
> which could make this flag falsely true.
> 
> In next usb_ep_enable() call since this flag is true, ep->ops->enable()
> will be skipped. Then usb_ep_queue() will fail on uninitialized endpoint.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: atmel: use calloc() to allocate endpoint list
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/033eb908d0a8ed938bc652f34a2d702a29a8726f

--
Mattijs
