Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF4BC83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF34682F14;
	Tue, 15 Jul 2025 11:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oTMpD9dJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0BB82F8F; Tue, 15 Jul 2025 11:28:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A84582BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 352FC61140;
 Tue, 15 Jul 2025 09:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C96C4CEE3;
 Tue, 15 Jul 2025 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752571684;
 bh=qYBKSDM3BQ82ykjxFG7QGbllODO1IiqbIMtnMLoX9C0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=oTMpD9dJrJaSi4HAKL1X0Ma81Fn0tBZS5qGNXFcoCygv1v63+8icrMeCpgDqhGOG9
 TtJc8FXssFzyYfT/fv+93bnBlg5RTQSOD+QBucrH+nJC9ucdbI3N7h4sQi6vzTvgPi
 uRYcGDfuq+9JiBU/kIfp/gAKO5tGEjUg8W0R8AeDr3B6zp6+VpvRSWsYR8Y9Q1iiA0
 gCunRTw5SSj5a9NQg8E9wLiXjnCST2KbM6e7irC7xjyK8Rg5xzgfSG/ZApcAuM9r2X
 8s+drchPBZNmME7eamMQc0DekxYUoJLRlHvmCtTHOTmlD2cinCo18/ys5+G/4k8prb
 nUxCm0qwIe1vQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
In-Reply-To: <20250709042342.13544-1-semen.protsenko@linaro.org>
References: <20250709042342.13544-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] dfu: Fix dfu_config_interfaces() for single interface
 DFU syntax
Message-Id: <175257168212.26135.2562345918072954175.b4-ty@kernel.org>
Date: Tue, 15 Jul 2025 11:28:02 +0200
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

On Tue, 08 Jul 2025 23:23:42 -0500, Sam Protsenko wrote:
> As stated in DFU documentation [1], the device interface part might be
> missing in dfu_alt_info:
> 
>     dfu_alt_info
>         The DFU setting for the USB download gadget with a semicolon
>         separated string of information on each alternate:
>             dfu_alt_info="<alt1>;<alt2>;....;<altN>"
>         When several devices are used, the format is:
>             - <interface> <dev>'='alternate list (';' separated)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: Fix dfu_config_interfaces() for single interface DFU syntax
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/772526fb9f55a1fea439ea3a6923136cd121cc88

--
Mattijs
