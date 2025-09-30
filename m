Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61264CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8885383045;
	Tue, 30 Sep 2025 11:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cQ67U080";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F1E8341C; Tue, 30 Sep 2025 11:54:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BE6828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 74C6240A1D;
 Tue, 30 Sep 2025 09:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C7EC4CEF0;
 Tue, 30 Sep 2025 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759226050;
 bh=SsTtd18TVIRrzc5vuUk9VmC5dZD8iMAL568xawFuN+A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=cQ67U080lKiXS1KSPelgXPl8cSDT3kO6hhgHLhU4XXV7HQU6HDEMl7RSSWoEhqTu4
 tffmwT8Dz9oRjzIS8wjcNadOGItL4aXEYEZU1aVanY9qswtroXmw3WytySMtOce6lc
 nfmS/iO7VO1k7huvOHIRJx7nZPnLEpOjUbaYt+liWQAJice79O86aXZrpw8D3uQR3t
 /QWexW/GXCv5gYidGb1xSDmSI6WFjCLJktBKi9EvFE8ziGiAvvV7bnk+szyQ+G533a
 XkM5bEd+3n2M6mmr2+oneRxMzKbCFr4OkqRAypNZVYrMeMi0oXoQlreXpT82NcBS7A
 LC4R+Y5QGLMTQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, 
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
References: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
Subject: Re: [PATCH] usb: dwc2: Add missing null check
Message-Id: <175922604836.1440470.5677006425870296284.b4-ty@kernel.org>
Date: Tue, 30 Sep 2025 11:54:08 +0200
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

On Mon, 29 Sep 2025 17:40:43 +0100, Andrew Goodbody wrote:
> Add in the missing null check for dev->driver that is present at other
> points in the function before it is dereferenced.
> 
> This issue was found by Smatch.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: dwc2: Add missing null check
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/5ac61383b2db15b037e87bd353f726eafc49e181

--
Mattijs
