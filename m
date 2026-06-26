Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350A7CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 09:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0724584704;
	Fri, 26 Jun 2026 11:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iHogFzMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C5E84704; Fri, 26 Jun 2026 11:18:55 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC358498B
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BCFD41979;
 Fri, 26 Jun 2026 09:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D471F000E9;
 Fri, 26 Jun 2026 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782465531;
 bh=tJU58J0OIXSx7nrag1fnKLDtuAlgPSmwfWac43zEXBc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=iHogFzMBlpFncLf9Lo88FDQU38t0AGUjivGBQTs7lx0hvOW7p4WiAk0Eg1GxDcYqE
 AjJsgbqyxdsL/iR6/xI/Z4BX/CZiPQnj0or6nSYUYiEBPtH1J/YwR+IuTb/YgFgkri
 HaeMLrlBhJ7pdikblC2MmJ/hywPpaZjL1mBKVdf9vdY1n1KWJRsmZfuNtsSEKi7vQ1
 pjFLI1bqSyD6cTbNJ6ZnO1ha1YgvwvHULfqIu0Gndk7aa4oLuE81sKNo7oK7Gu1t8h
 4aWUM/Syzv9acl8nlUtTDEasYa3i55/RP25ITO5gj/diw5OzTR7fmi5xf/cKezEsK4
 mIP1dvKz6v5vg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20260619-fastboot-abort-keyed-v2-0-684e53949a42@samcday.com>
References: <20260619-fastboot-abort-keyed-v2-0-684e53949a42@samcday.com>
Subject: Re: [PATCH v2 0/2] Fastboot abort key support
Message-Id: <178246552916.1113926.16433686845673684752.b4-ty@b4>
Date: Fri, 26 Jun 2026 11:18:49 +0200
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

On Fri, 19 Jun 2026 09:54:59 +1000, Sam Day wrote:
> UMS already offers CONFIG_CMD_UMS_ABORT_KEYED, which makes it possible
> to bail out of that mode by pressing any button, rather than only
> responding to ctrl-c. This is particularly useful for phones, where it's
> not possible (yet... hmmmmm...) to send a ctrl-c command with the
> available phone buttons.
> 
> This simple patch series introduces equivalent behaviour for fastboot,
> and enables it in the qcom-phone.config fragment where it's most useful.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] cmd: fastboot: Add keyed abort option
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b6de000aeadc23d7d68f52379dbf30ceec44b8e9
[2/2] board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/865f62483b86b7936c2136d91bbce252b6406330

--
Mattijs
