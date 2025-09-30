Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A25CCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933A383045;
	Tue, 30 Sep 2025 11:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mdy72Xcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54ED483071; Tue, 30 Sep 2025 11:49:55 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEBD828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA3EB6013C;
 Tue, 30 Sep 2025 09:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D1DC4CEF0;
 Tue, 30 Sep 2025 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759225791;
 bh=WYU80+sSBv2/sJWNlqrSsVn5le5/IsWCazN5NYQRNJE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Mdy72XcbRxiWiPTRwe63D8biKbrIW4lm874belEPXYZRKybqNnVNlFDwhkQxJ4QLy
 flx5eIH/sozi+2lC8Mq3ruH6SPuATu2u/AfVW5rcb3QvpMPfyheKLKiT/wXz9LefgY
 ZgOAeKmccgOkFES54AB2p3v2x+Rp1XJHoJ9Tm0nBTd5C+msz3aH3ICuocvGS0YZVjD
 g5LCXkOXSvjk/v/RGPJ81WgtpY5eu8XVGu18lqeQTTdMZeFtnWhwc7FlK4K42SKYiQ
 7b6f81GhCzoc37lXxA94F3Ko/powBn+Y5r00cGq88IEtyi09FkWc0Uf5PJLbIRz18j
 o/YLBsMbtzTxg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Chance Yang <chance.yang@kneron.us>
Cc: u-boot@lists.denx.de, morgan.chang@kneron.us
In-Reply-To: <20250826-master-v2-1-30b787a2f9fd@kneron.us>
References: <20250826-master-v2-1-30b787a2f9fd@kneron.us>
Subject: Re: [PATCH v2] fastboot: Fix has-slot command always returning yes
 for fb_nand
Message-Id: <175922578937.1439753.4670104525196375862.b4-ty@kernel.org>
Date: Tue, 30 Sep 2025 11:49:49 +0200
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

On Tue, 26 Aug 2025 11:36:17 +0800, Chance Yang wrote:
> The issue was a mismatch in return value conventions between functions:
> - getvar_get_part_info() expects >= 0 for success
> - fb_nand_lookup() returns 0 on success, 1 on failure (from
> mtdparts_init and find_dev_and_part)
> 
> When partition didn't exist, fb_nand_lookup returned 1, but
> fastboot_nand_get_part_info passed it directly to getvar_get_part_info,
> which treated 1 >= 0 as success, causing has-slot to always return yes.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] fastboot: Fix has-slot command always returning yes for fb_nand
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3ce8a0e9115eaa0cdfc142459814b2283cf01785

--
Mattijs
