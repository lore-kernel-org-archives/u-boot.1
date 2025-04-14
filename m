Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38A1C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 12:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0172E8209C;
	Mon, 14 Apr 2025 14:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qquy5arU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB8A82103; Mon, 14 Apr 2025 14:24:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC1482075
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 14:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 462885C061B;
 Mon, 14 Apr 2025 12:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A989DC4CEE2;
 Mon, 14 Apr 2025 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744633475;
 bh=07wKONGeuvHFTWQGhbG5pg8wLof/epw3i2SEfVMEpuw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qquy5arUkq+f7Ph8DaW2kipmEa5ga3KwpEaR4NO73+fFOfAKs5oqE994Ki4sST9qi
 PUpZx5jxHq9EqMpi1lWRxO4u/LFQCFWqTNG0Fg6DtpZxk+t8u5C3brxp4CBR1fn0XE
 yGaAD/fZGMdmH5yGyvCyL52GMDZ6853IzMz/NHOm53OsVYZ3f/2H3+mC27Gahohg1x
 UlutumRROYr0CbxISuFAG1JZaYq6FwR3fX3aVOR0uI2VPWk9cKR5GeXYm8Te4gErha
 hi9DN41olSm0c5oc20SJGg0zAFE6IRRoVRsTJz2qU1Ky3MeMb3smTLhGiJQ4EZPGUq
 hgHaRE5CBxvKA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>, Jassi Brar
 <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/5] board: st: common: fix dfu alt buffer clearing
In-Reply-To: <20250407170529.893307-3-vincent.stehle@arm.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-3-vincent.stehle@arm.com>
Date: Mon, 14 Apr 2025 14:24:32 +0200
Message-ID: <87plhfc4n3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Vincent,

Thank you for the patch.

On lun., avril 07, 2025 at 19:05, Vincent Stehl=C3=A9 <vincent.stehle@arm.c=
om> wrote:

> The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
> macro to declare a `buf' variable pointer into an array allocated on the
> stack. It then calls the memset() function to clear the useable portion
> of the array using the idiomatic expression `sizeof(buf)'.
>
> While this would indeed work fine for an array, in the present case we
> end up clearing only the size of a pointer.
> Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.
>
> Fixes: ec2933e543df ("board: stm32mp1: move set_dfu_alt_info in st common=
 directory")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  board/st/common/stm32mp_dfu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
> index 1db8e45480e..8c1f80b678a 100644
> --- a/board/st/common/stm32mp_dfu.c
> +++ b/board/st/common/stm32mp_dfu.c
> @@ -105,7 +105,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>  	if (env_get("dfu_alt_info"))
>  		return;
>=20=20
> -	memset(buf, 0, sizeof(buf));
> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>=20=20
>  	snprintf(buf, DFU_ALT_BUF_LEN,
>  		 "ram 0=3D%s", CONFIG_DFU_ALT_RAM0);
> --=20
> 2.47.2
