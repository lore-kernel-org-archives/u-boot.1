Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD4DCCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 09:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB4F83B4F;
	Thu,  6 Nov 2025 10:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T2Ibdwno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72ECB83B55; Thu,  6 Nov 2025 10:20:29 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FB583B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 10:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 157A460218;
 Thu,  6 Nov 2025 09:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D00C4CEF7;
 Thu,  6 Nov 2025 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762420825;
 bh=Ui9lJDsFUS7QBbbXa79l6fD7k3jkk/xxVNw+WEuDbfE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=T2Ibdwno3w1IaMejwXf0bTlCWfTtwzEpGvIPyW2WPe1qiKcESnmxhq5pHGEfowUc9
 XT4oWhwpdSkJ3G70ZT90NWtPhWOx/vEhVWzk0OFyuYI+1u6pPIHYHhIqbR1R8MtARq
 00r7mBIVPz37gFWJhPSG1yhAF4hl3ZCsFPHlvYoKyXHZp/7LtDUKiT1IC+QiB3iY5j
 J0Pfkb5qlKO8A0ZtQFGfWO/AbtJwbXAT14uKddh5qM97Enz58EanDQ/wnDZQocxRdv
 3b0rMZ+sY22vWlFkdH9bn5Y41C97O+ST4J1Alc2iLekk9tnR3a87w4XEOwe7mGY9zw
 JwZR/kTiW7/bg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 george chan <gchan9527@gmail.com>
In-Reply-To: <20251024-botargsappend-v1-1-0b78f05f9132@baylibre.com>
References: <20251024-botargsappend-v1-1-0b78f05f9132@baylibre.com>
Subject: Re: [PATCH] bootstd: android: add the bootargs env to the commandline
Message-Id: <176242082357.10716.11132988775995410791.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 10:20:23 +0100
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

On Fri, 24 Oct 2025 16:23:22 +0200, Guillaume La Roque (TI.com) wrote:
> When previously using script based bootflows, the U-Boot
> environment variable bootargs was used to customize the kernel
> commandline at boot time.
> In order to get the same behaviour, concatenate the bootflow
> commandline with the contents the bootargs environment variable.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] bootstd: android: add the bootargs env to the commandline
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/10da28729949f3e2160f98d82df45833d4c175cf

--
Mattijs
