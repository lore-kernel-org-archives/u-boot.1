Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42F1CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 09:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7BF8495E;
	Fri, 26 Jun 2026 11:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDVMruC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA44E8498C; Fri, 26 Jun 2026 11:18:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC138460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE8CB43C31;
 Fri, 26 Jun 2026 09:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170311F000E9;
 Fri, 26 Jun 2026 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782465528;
 bh=pfmHlMv0W4opYz+pDFQTqIOLdbagyC0JuA8AKxbFb/g=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=KDVMruC7BZBf2gbcZwQ0vvEybnd2LiQznERW6MdpNnuuikD1/eUAGj7WCuU/nDeZs
 kx8XOS26akmPS2114pXQT4ucz9/3l+flkYugKWVE1HF+gjDKUKrSzKxPIidfBm+RGL
 XZbaM8zVbMftd7yk9O8pGVDDfyfSweBOCRDRyU0fytNNP47/cZAI9zLrAECs2meJZC
 jfXxV8ipVpQRlBBfJsF4cqvytbMvmME4JJMqOZEqfoml1tRM8xT+BGxrIBR6p28uP0
 YtIleZEGTlAauRSaKgr/Z5128vWk4ze266hBlYCh/RVBhkyAB5C9E1qWE7RvWPJGn1
 TH3PLVTbKQyZA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260617-ums-disconnect-v2-1-6e52d9de1d36@kernel.org>
References: <20260617-ums-disconnect-v2-1-6e52d9de1d36@kernel.org>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Disable eps during
 disconnect
Message-Id: <178246552618.1113926.16850893689475421909.b4-ty@b4>
Date: Fri, 26 Jun 2026 11:18:46 +0200
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

On Wed, 17 Jun 2026 13:14:48 +0200, Mattijs Korpershoek wrote:
> When trying two ums commands in a row, the second one no longer
> enumerates properly from the host.
> 
> This happens since commit
> 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> causing usb_ep_enable() to return early when ep->enabled is already set.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: gadget: f_mass_storage: Disable eps during disconnect
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1c758ce38caa783c85129753c1ecc9d14a203d8e

--
Mattijs
