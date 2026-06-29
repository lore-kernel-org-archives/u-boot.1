Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54C3C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 07:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C27D841F2;
	Mon, 29 Jun 2026 09:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="eUBjKaqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA78F846A4; Mon, 29 Jun 2026 09:48:20 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED9584105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 09:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A695811831C; Mon, 29 Jun 2026 09:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782719298;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8hCh9OAnn37fr8zTH2OP6kyofhxMK/pwXL7lK9f5NcM=;
 b=eUBjKaqhRpWNBaUYtjIloFKpb+K1gs2OKqkPyJceqy/3fhJtHYdcr4ByuZmxCxV+T+Hc67
 VjXorWN8rpC68o38V0/28W+G4QskPk8aPXjx0r2/YYZsJNCkYgqIkzDnOlRqi6j4RiCfT6
 u7t7QgUkuxzNomvVqG1ZZSRo98zzuE+76HaVSTcbwEiJvRIcu1832jtqtVg14gZdKsgbpu
 MMs/9VbARUTsaX/wF4jIREEy0/onHBfLUgD7snaoOAIVgfoOZ24SN+U8afvmK1Qv+hMV7E
 niHAalfsr9Fcu9ZWjYi6T243x15VdM4b7lB/GJdxU3dXuWYL6R9zLxLjQq5voA==
Message-ID: <f37c6d7e-46a6-4c45-b953-fba58173972a@nabladev.com>
Date: Mon, 29 Jun 2026 09:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "mmc: sdhci-cadence: trigger tuning for SD HS
 mode on SD6HC (v6) PHY"
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, trini@konsulko.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Tze Yee Ng <tze.yee.ng@altera.com>
References: <20260629061619.4268-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260629061619.4268-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/29/26 8:16 AM, Tanmay Kathpalia wrote:
> This reverts commit b42c67188c14 ("mmc: sdhci-cadence: trigger tuning
> for SD HS mode on SD6HC (v6) PHY").
> 
> The reverted patch introduced several issues:
> 
> 1. Non-standard tuning trigger: The SD Physical Layer Specification
>     only mandates execute_tuning for SDR50 and SDR104 UHS-I modes.
>     Triggering tuning for SD High Speed mode is outside the spec and
>     is handled via a non-standard set_ios_post callback rather than
>     through the established SDHCI framework tuning path.
> 
> 2. Non-standard device tree property: The patch introduced a new
>     "cdns,sd-hs-tuning" DT property to opt into SD HS tuning. This
>     is not aligned with existing DT bindings and bypasses the standard
>     MMC capability negotiation mechanism.
> 
> 3. Incorrect tunable mode allowlist: The sdhci_cdns6_mode_is_tuned()
>     function includes SD_HS, UHS_SDR50, and MMC_HS_400_ES as tunable
>     modes. According to the Cadence SD6HC IP User Guide (section 7.5.2,
>     Figure 18), tuning is only required for UHS-I SDR104 (SD) and
>     HS200 (eMMC). SD High Speed, UHS-I SDR50, and DDR50 only require
>     a PHY settings update from the pre-calculation script, not the
>     tuning procedure. HS400 transitions through HS200 and reuses its
>     tuned DLL value with a partial settings update. HS400ES only
>     requires a plain settings update from the calculation script with
>     no dependency on HS200 tuning.
> 
> 4. Tuned state management outside the framework: The patch manually
>     tracks tuned DLL state (tuned_mode, tuned_dll_slave_ctrl) and
>     restores it across PHY reconfigurations. This duplicates
>     responsibility that belongs in the core MMC tuning framework and
>     adds unnecessary complexity to the driver.
> 
> Reverting to realign the driver with the IP documentation and the SD
> Physical Layer Specification.
Thank you for the update.
