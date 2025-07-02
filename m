Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05C6C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5362382103;
	Wed,  2 Jul 2025 12:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZB+4/GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0F182CFA; Wed,  2 Jul 2025 12:10:53 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1A580E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D54B24613E;
 Wed,  2 Jul 2025 10:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4680DC4CEED;
 Wed,  2 Jul 2025 10:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751451049;
 bh=HV4pjlvD8+eGFIzWBRppSx9YRNgC0vsSUfJ8brmZIeI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MZB+4/GFmBg9x9kgxD18DC1LX30M2icsPfcD+cL0pse0UTSxwrxbC6MC13KLJVlok
 eFYQWBV5fGj9pCGJn+x96YDO8P+kvGHnxT5ZopJv0cL8QwPoQKB82Ks8PeJeBTpQh2
 ATkN5qTPx4nWDHUmRrV/rUwTjiBq9bOlGsq72v5ANl0DkEgFjAvbk9sEQ5medHXW+Z
 eiCayxLBQG5bjvHI/7P590/iVGDyBvO/2Z3jRzIssnL7opVuMadsaGsHYX3PaoIPUD
 4PPDAT83+raHoJ2f9AtMXKREjIZBSl9GRSbavJM0KWX35HwiEiNN2CkIKhAtRYbb4a
 DAqA7Zl0xSr+A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
References: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
Subject: Re: [PATCH v4 0/2] Prevent use of unitialised variable vhdr
Message-Id: <175145104713.55152.14849151834430606841.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 12:10:47 +0200
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

On Thu, 26 Jun 2025 17:38:53 +0100, Andrew Goodbody wrote:
> Ensure that vhdr is initialised so that its value is never
> accessed when not initialised.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] cmd: abootimg: Prevent use of unintialised variable
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b9717c6868f2f98b02fbe87a885cfa48a5b9946
[2/2] boot: android: Prevent use of unintialised variable
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b489f517366595cd3f003d4175e721bd927a18b

--
Mattijs
