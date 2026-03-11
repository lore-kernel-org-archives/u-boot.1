Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F8B112584E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 15:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8101784013;
	Wed, 11 Mar 2026 16:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Kwo0q43X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCED984035; Wed, 11 Mar 2026 16:43:02 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D69D83FB6
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 16:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F38EA1088D7; Wed, 11 Mar 2026 16:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773243779;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=w/yp7Sp3igFuAhLGOtP6ogF4V1wkQcHaNWtH9t6/aj4=;
 b=Kwo0q43XJ2Y3PU7l+NMRnuAr1HbqVTHxpltohUPXG613IB2blNBPu+ustTDIcm8aYEVUuo
 2kbZuBzec7X/uK8LXRJVuwEh74rj9PGJ3HHD6EwgPIYK7wfk8jm6fPSNwQoT/PmA6KHN7x
 StWiBlggylZzlKb706WEG6lu9LSxsGFUyRTy3sJ62zuhw023NqoAhPuYpjrbRPB1lNpUkq
 UJKN50NgWHGe5Zv2hlUxY/DyFMHm/rrsygNhjM5YsLpz0sow4sTwwbOUMuwT6QdBjGA+pU
 ftMb7fY/Yb6O/ijn/JzzV8HE8BCLS0BVm8QvOyTNskAiYwcifujxtAT1maPzmw==
Message-ID: <d1f9c66c-fedb-4802-94b0-3b043e0b8bbd@nabladev.com>
Date: Wed, 11 Mar 2026 16:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] imx9{4,5}: Add Quickboot support
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, ravi@prevas.dk, fedor.ross@ifm.com,
 sebastien.szymanski@armadeus.com, joao.goncalves@toradex.com,
 ji.luo@nxp.com, semen.protsenko@linaro.org, sjg@chromium.org,
 tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
References: <cover.1773137310.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <cover.1773137310.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 11 Mar 2026 16:43:42 +0100
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

On 3/10/26 12:54 PM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> This patch series adds support for saving DDR training
> data to non-volatile memory on iMX94 and iMX95 platforms.
> The purpose is running DDR Quickboot flow on next reboot.
> 
> The process is as follows:
> - OEI runs Training flow for the DDRPHY
> - OEI saves the data from training to volatile memory
> - U-Boot can then save it to non-volatile memory (e.g. SD)
> - OEI loads the data from NVM at cold reboot and runs Quickboot flow
> 
> By skipping training, a much lower boot time is achieved.
How does this interact with authenticated boot ? I wonder if, in case 
the entire bootloader stack is authenticated, the attacker can tamper 
with the saved QB data (which do not seem to be authenticated) and cause 
bitflips to occur in DRAM, which could then allow them to bypass 
authentication in follow up stages which execute from DRAM ?

Are the QB data protected/authenticated in any way against tampering ?
