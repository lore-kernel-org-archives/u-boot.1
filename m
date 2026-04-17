Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630DEF43687
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 09:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC19283BC8;
	Fri, 17 Apr 2026 11:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q9vFK/an";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAB684228; Fri, 17 Apr 2026 11:17:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3C583B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F0A366012A;
 Fri, 17 Apr 2026 09:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CD5C19425;
 Fri, 17 Apr 2026 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776417419;
 bh=SgT1h8XNJksqrt1rI7c1hNePoT78DYxskIXWh61RciM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=q9vFK/angmg5nHtczkQQYWyn83iH0jsJ6qskd2/wymQuMxrlVRdunlrZGpLUNRztw
 eEpUdYEGcR0QuhU6kfJbANTvHLALfBMgGrhSHxyxCcBYSvKD6UxTiTmRLJLnJnt/P4
 AZd19RVvH8I4m+ZHEPKqGQDMP0efxbk6kN2diJFVslXjrtUVHUs2AfzC3Rd6XDaaNH
 fTsUylxv4L8tFB1txRVWm0/2tZKfktwchMqYO0Q6U+ADjKhX5b8AkOypZLMhUEul33
 alGIxD0DPpXu/U8K7ZQ/pTtMTkOR7qLtOi+UfYK1HHSzsUoNdB2R6dbaKFW8vF11c5
 K6YLlvEWo+QUQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, Ariel D'Alessandro
 <ariel.dalessandro@collabora.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Dmitrii Merkurev <dimorinny@google.com>,
 Michael Walle <mwalle@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heiko Schocher <hs@nabladev.com>, Adrian
 Freihofer <adrian.freihofer@siemens.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] doc: fastboot: Document block device selection syntax
In-Reply-To: <20260410-fb_block-v1-2-68f0c976fe0e@oss.qualcomm.com>
References: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
 <20260410-fb_block-v1-2-68f0c976fe0e@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 11:16:57 +0200
Message-ID: <87bjfigd4m.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Balaji,

Thank you for the patch.

On Fri, Apr 10, 2026 at 10:12, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:

> Add documentation for the device selection syntax in fastboot
> block device operations. Users can now specify target devices
> using "N:partition" format where N is the device number.
>
> Document usage examples for regular partition operations like
> "fastboot flash 0:boot boot.img" and partition table operations
> like "fastboot flash 1:gpt gpt.img". When no device number is
> specified, the default from CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID
> is used.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
