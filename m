Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C949C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F9282063;
	Mon, 16 Jun 2025 11:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AukXeFLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B22A8210D; Mon, 16 Jun 2025 11:57:55 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6D481760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B277561129;
 Mon, 16 Jun 2025 09:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E98CC4CEEA;
 Mon, 16 Jun 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750067871;
 bh=xvIqjzlNv2CZFsUHO29+8mmLxPenTd6lZwQ3UH/0j3M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=AukXeFLTy9DzU/rGmBlCaHSy6osNVsJESN3bhTHqvF+pnfNEuQC1ykQekv0FzfUZt
 1q5bJCqe2gKzS/LJL+vhefGYzdqZgZdgQkzEQtOG1rYu6RTQKnQSofRoL9TyOmenjs
 kLOuXenY0Z5PAi5nJ58CNPi3VRBszCFPGmjmL136mRiwmRoqoKnMSQGdS3agjBsyFy
 GFjGoUaPePxA4UnL7Mj6FuTAwhuerKdYcNsOs1gRAPnwaTjaNPsVwxHQrRDOrZ0FQt
 U0cQIBkM+25J7qr2R9c/8EFnWgrsShrgY+TRh6cZRRuH2IirlBFAvErLX0Ogy1lMwe
 6zpZJKMQtVbiA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
Message-Id: <175006786891.24663.4435629180041796186.b4-ty@kernel.org>
Date: Mon, 16 Jun 2025 11:57:48 +0200
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

On Mon, 02 Jun 2025 17:45:08 +0200, Zixun LI wrote:
> Contrary to the datasheet, setting both DETACH and PULLD_DIS bits to 1
> does not always drive the DP and DM lines to high-impedance. This
> prevents the host from reliably detecting a USB disconnect and subsequent
> reconnect.
> 
> The symptom is that the first gadget command (e.g., dhcp) succeeds, while
> subsequent commands (e.g., nfs) fail.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] usb: gadget: atmel: reliably generate disconnect by disabling controller instead of toggling PULLD_DIS
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ca036308a513759e3e4cbe9f8191861c3232c611

--
Mattijs
