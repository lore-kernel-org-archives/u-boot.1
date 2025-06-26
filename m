Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BB0C7115B
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 07:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0CC82E05;
	Thu, 26 Jun 2025 09:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="exkFqewo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D6382E05; Thu, 26 Jun 2025 09:38:23 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C21382D21
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 09:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q7c1XN2092136;
 Thu, 26 Jun 2025 02:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750923481;
 bh=OcwpGMpTQwO7XPfomyMJborN4n+dMmlcif8at2MKMhk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=exkFqewoMykLbjOGt+vPPnJ4rYHeG4JmjsYxtH9yyXFkIUnotC5Y7K1k1Zk5rNqge
 wiC4Glr4OeHSbeiHjT4KpuXJD1zCIWmzSRJeXdcK65LS4GS2xiJcQXvHTtMSsK/dGz
 hFKYDW+CPrIQ5mFFI2T8v/OWehNCjTmTpU0rXYTg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q7c1l92034303
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 02:38:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 02:38:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 02:38:00 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q7bwiu874510;
 Thu, 26 Jun 2025 02:37:59 -0500
Message-ID: <9e9dfcb1-8f03-4c6a-88ea-3a894581986f@ti.com>
Date: Thu, 26 Jun 2025 13:07:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: ti: Add defconfigs for AM69-SK
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Apurva Nandan
 <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20250625-doc-ti-am69-v1-1-67527a9c8dfa@kernel.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250625-doc-ti-am69-v1-1-67527a9c8dfa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Mattijs

On 25/06/25 20:28, Mattijs Korpershoek wrote:
> The J784S4 and AM69 Platforms page only details the defconfigs for
> J784S4.
> 
> Mention the ones needed for AM69-SK as well, to guide users on how to
> build for that board.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  doc/board/ti/j784s4_evm.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index 349fb394d747ac1f98b5a4af092bede60c5ed06a..22442874110d29d862ee79b1666e50269645a2f2 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -90,6 +90,15 @@ Set the variables corresponding to this platform:
>     export OPTEE_PLATFORM=k3-j784s4
>     export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
>  
> +.. note::
> +
> +   For AM69-SK, use the following U_BOOT_CFG instead:
> +
> +   .. prompt:: bash
> +
> +      export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
> +      export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
> +
>  .. j784s4_evm_rst_include_start_build_steps
>  
>  1. Trusted Firmware-A
> 
> ---
> base-commit: 59e6462d7c08eeba744afa0f17846c398b8ef9e1
> change-id: 20250625-doc-ti-am69-d20d1529f376
> 
> Best regards,

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
