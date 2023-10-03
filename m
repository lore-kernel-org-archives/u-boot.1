Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F316E7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BC68745A;
	Tue,  3 Oct 2023 15:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dLOb6Yr3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GAYdkyi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A01D8747D; Tue,  3 Oct 2023 15:40:56 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2CA86E13
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0Jqp3JcWz9src;
 Tue,  3 Oct 2023 15:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAEqPNm7Db6O+piOL1LDctL5/VcosZUsxZ1C6nGnGTE=;
 b=dLOb6Yr38Qd1nW6ZHCqU03N0ptr82LSvmnIWldUIIagOVKkjFJNW8dSaZSaIecnImDdTIz
 Ch2x9705DuT6ydQdrhl93pcBqb6KkcD48485pFtMvDJuW6e2W1ZMSpeDPg3dZmymPi8lB6
 rK+evuVDTbgk3pwuaG/SC4/YfpilSdaT+/K6f2quDfplJ9umsDs/mKvvjh8bw62MDmJxdE
 26hwYGueQx3FicgmqfxnYaSpOChi8q0I3FStysImM+rA5nYOSPAggrz5YBJU1YaSJTuFD/
 lGYGEEWQYzM9w+wV2yxjnEywrCH+Wz8BYtCmEnsngcdSS2yCWXGrPPYsWO3JVQ==
Message-ID: <37263496-f328-e2c8-533b-11ccbe8c3bbe@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAEqPNm7Db6O+piOL1LDctL5/VcosZUsxZ1C6nGnGTE=;
 b=GAYdkyi/9YR/GovhHHyBJtriMr3Ja11tD8r1hUbhbGnknijPR+xySYe8y+HnWbDsCD/kKy
 8AphMlAnw4GYnAGg+hz30hL1awwlK2p1ZsiUCQBYG345MDRWe+GbtG4fyN0qpxpP7D2mk5
 Qx6TYk8kVG+DvmJ9VMucrN2OmQ4gcxfIHkPy3KHFTX5s9Xks3g0gjjrBbMbuIMBpvBYNpp
 a9IIk/pJ8NYujWx/QnOrmlX6zoMmO8ju6FixkETIeRewCAee6LNrqzkUd4g79l3MRRN89N
 4mTRHjzTtwE55GPWDXBBEWdOAzc1oV3/8o4sGLu+yk/PcRtP8oQJNDhN0Uoq2g==
Date: Tue, 3 Oct 2023 14:57:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 08/16] arm: rmobile: Restrict PINCTRL_PFC selection to
 R-Car gen3/gen4
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-9-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-9-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 93e1d7a01ab14065a4f
X-MBO-RS-META: c8uijxc7ksmjs5uq4u5ynutqreondn9x
X-Rspamd-Queue-Id: 4S0Jqp3JcWz9src
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

On 9/20/23 14:42, Paul Barker wrote:
> The RZ/G2L family uses CONFIG_RCAR_64 but does not share a common PFC
> driver with the R-Car gen3 & gen4 boards.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index fc37f6c79e50..91f544c78337 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -9,7 +9,6 @@ config RCAR_64
>   	select PHY
>   	select PINCONF
>   	select PINCTRL
> -	select PINCTRL_PFC
>   	select POSITION_INDEPENDENT
>   	imply CMD_FS_UUID
>   	imply CMD_GPT
> @@ -29,6 +28,7 @@ config RCAR_GEN3
>   	bool "Renesas ARM SoCs R-Car Gen3 (64bit)"
>   	select RCAR_64
>   	select SUPPORT_SPL
> +	select PINCTRL_PFC
>   	imply SPL
>   	imply SPL_BOARD_INIT
>   	imply SPL_GZIP
> @@ -43,6 +43,7 @@ config RCAR_GEN3
>   config RCAR_GEN4
>   	bool "Renesas ARM SoCs R-Car Gen4 (64bit)"
>   	select RCAR_64
> +	select PINCTRL_PFC

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
